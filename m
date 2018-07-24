Return-Path: <cygwin-patches-return-9139-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91755 invoked by alias); 24 Jul 2018 05:03:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91729 invoked by uid 89); 24 Jul 2018 05:03:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_1,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=stay, waited, retry
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Jul 2018 05:03:23 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6O53LBH091384	for <cygwin-patches@cygwin.com>; Mon, 23 Jul 2018 22:03:21 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdmcg6ic; Mon Jul 23 22:03:16 2018
Subject: Re: [PATCH v4 1/2] POSIX Asynchronous I/O support: aio files
To: cygwin-patches@cygwin.com
References: <20180716142128.GZ27673@calimero.vinschen.de> <20180717145146.GA23667@calimero.vinschen.de> <20180720084416.4256-1-mark@maxrnd.com> <20180723125952.GA3312@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <5a893048-199f-ff0c-24a9-5ea92ea543ae@maxrnd.com>
Date: Tue, 24 Jul 2018 05:03:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20180723125952.GA3312@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00034.txt.bz2

Corinna Vinschen wrote:
> Hi Mark,
>
> there's just one problem left:
[...]
>> +
>> +  QueryUnbiasedInterruptTime (&time0);
>
> Nice idea to use QueryUnbiasedInterruptTime.  The problem here is just
> that QueryUnbiasedInterruptTime has been introduced with Windows 7, but
> we still support Windows Vista :}
>
> We could just drop Vista support (is anybody actually using it?) but
> there's an alternative: Include hires.h and use ntod, a global ns
> counter object using Windows performance counters under the hood:
>
>   #include "hires.h"
>
>   time0 = ntod.nsecs ();  /* ns, *not* 100ns */
>   ...
>
> With that single change I think your patch series can go in.

I don't want to be the one to say "drop Vista" because I tend to stay on the 
trailing edge of Windows versions myself.  Your idea of using ntod.nsecs() is a 
nice fix, and dealing with nanoseconds all the way simplifies the code a bit:

static int
aiosuspend (const struct aiocb *const aiolist[],
          int nent, const struct timespec *timeout)
{
   /* Returns lowest list index of completed aios, else 'nent' if all completed.
    * If none completed on entry, wait for interval specified by 'timeout'.
    */
   int       res;
   sigset_t  sigmask;
   siginfo_t si;
   ULONGLONG nsecs = 0;
   ULONGLONG time0, time1;
   struct timespec to = {0};

   if (timeout)
     {
       to = *timeout;
       if (to.tv_sec < 0 || to.tv_nsec < 0 || to.tv_nsec > NSPERSEC)
         {
           set_errno (EINVAL);
           return -1;
         }
       nsecs = (NSPERSEC * to.tv_sec) + to.tv_nsec;
     }

retry:
   sigemptyset (&sigmask);
   int aiocount = 0;
   for (int i = 0; i < nent; ++i)
     if (aiolist[i] && aiolist[i]->aio_liocb)
       {
         if (aiolist[i]->aio_errno == EINPROGRESS ||
             aiolist[i]->aio_errno == ENOBUFS ||
             aiolist[i]->aio_errno == EBUSY)
           {
             ++aiocount;
             if (aiolist[i]->aio_sigevent.sigev_notify == SIGEV_SIGNAL ||
                 aiolist[i]->aio_sigevent.sigev_notify == SIGEV_THREAD)
               sigaddset (&sigmask, aiolist[i]->aio_sigevent.sigev_signo);
           }
         else
           return i;
       }

   if (aiocount == 0)
     return nent;

   if (timeout && nsecs == 0)
     {
       set_errno (EAGAIN);
       return -1;
     }

   time0 = ntod.nsecs ();
   /* Note wait below is abortable even w/ empty sigmask and infinite timeout */
   res = sigtimedwait (&sigmask, &si, timeout ? &to : NULL);
   if (res == -1)
     return -1; /* Return with errno set by failed sigtimedwait() */
   time1 = ntod.nsecs ();

   /* Adjust timeout to account for time just waited */
   time1 -= time0;
   if (time1 > nsecs)
     nsecs = 0; // just in case we didn't get rescheduled very quickly
   else
     nsecs -= time1;
   to.tv_sec = nsecs / NSPERSEC;
   to.tv_nsec = nsecs % NSPERSEC;

   goto retry;
}

The final patch set for the POSIX AIO feature will be appearing shortly.
Thanks & Regards,

..mark
