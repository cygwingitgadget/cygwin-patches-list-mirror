Return-Path: <cygwin-patches-return-9126-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128782 invoked by alias); 18 Jul 2018 05:55:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128759 invoked by uid 89); 18 Jul 2018 05:55:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_1,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=Hey, wasting, protections, Hx-languages-length:3486
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Jul 2018 05:55:41 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6I5tdWa085251	for <cygwin-patches@cygwin.com>; Tue, 17 Jul 2018 22:55:39 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdxVItkv; Tue Jul 17 22:55:29 2018
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com> <20180717145146.GA23667@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <cf3b3182-abc3-9e49-9440-0fe4fa1e137c@maxrnd.com>
Date: Wed, 18 Jul 2018 05:55:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20180717145146.GA23667@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00021.txt.bz2

Corinna Vinschen wrote:
> Hey Mark,
>
> I just belatedly noticed a few problems in aiosuspend:
>
> On Jul 15 01:20, Mark Geisert wrote:
>> +static int
>> +aiosuspend (const struct aiocb *const aiolist[],
>> +         int nent, const struct timespec *timeout)
>> +{
>> +  /* Returns lowest list index of completed aios, else 'nent' if all completed.
>> +   * If none completed on entry, wait for interval specified by 'timeout'.
>> +   */
>> +  DWORD     msecs = 0;
>> +  int       res;
>> +  sigset_t  sigmask;
>> +  siginfo_t si;
>> +  DWORD     time0, time1;
>      ^^^^^^^^^^^^^^^^^^^^^^^
>      see below
>
>> +  struct timespec *to = (struct timespec *) timeout;
>> +
>> +  if (to)
>> +    msecs = (1000 * to->tv_sec) + ((to->tv_nsec + 999999) / 1000000);
>
> You're not checking the content of timeout for validity, tv_sec >= 0 and
> 0 <= tv_nsec <= 999999999.

Oops.  Before this stmt was added I was relying on sigtimedwait() to validate. 
But doing math on the values here does demand validation here.  I will fix.

> I'm not sure why you break the timespec down to msecs anyway.  The
> timespec value is ultimately used for a timer with 100ns resolution.
> Why not stick to 64 bit 100ns values instead?  They are used in a
> lot of places.

OK, will change.  I was using msecs because the code only cares whether it's 
zero or nonzero and I couldn't see wasting 8-byte values on that.  But 
GetTickCount64() motivates for the longer variables... So will be fixed.

> Last but not least, please don't use numbers like 1000 or 999999 or
> 1000000 when converting time values.  We have macros for that defined
> in hires.h:
>
>   /* # of nanosecs per second. */
>   #define NSPERSEC (1000000000LL)
>   /* # of 100ns intervals per second. */
>   #define NS100PERSEC (10000000LL)
>   /* # of microsecs per second. */
>   #define USPERSEC (1000000LL)
>   /* # of millisecs per second. */
>   #define MSPERSEC (1000L)

I used these in my signal.cc updates but somehow forgot this AIO stuff is now 
inside Cygwin DLL so can use the same defines.  Will fix.

>> +  [...]
>> +  time0 = GetTickCount ();
>> +  //XXX Is it possible have an empty signal mask ...
>
> No, because some signals are non-maskable.
>
>> +  //XXX ... and infinite timeout?
>
> Yes, if timeout is a NULL pointer.

My XXX concern was whether an app could get stuck here and not be abortable. 
But I take your comments to mean a non-maskable signal will break out of the 
sigtimedwait(), so e.g. Ctrl-C, or SIGTERM from outside, could interrupt the app.

>> +  res = sigtimedwait (&sigmask, &si, to);
>> +  if (res == -1)
>> +    return -1; /* Return with errno set by failed sigtimedwait() */
>> +  time1 = GetTickCount ();
>
> This is unsafe.  As a 32 bit function GetTickCount wraps around roughly
> every 49 days.  Use ULONGLONG GetTickCount64() instead.

OK, will fix.

>> +  /* Adjust timeout to account for time just waited */
>> +  msecs -= (time1 - time0);
>> +  if (msecs < 0)
>
> This can't happen then.

Right.

>> +  to->tv_sec = msecs / 1000;
>> +  to->tv_nsec = (msecs % 1000) * 1000000;
>
> Uh oh, you're changing caller values, despite timeout being const.
> `to' shouldn't be a pointer, but a local struct timespec instead.

I'll revisit this issue.  This internal aiosuspend() routine is called from both 
aio_suspend() and lio_listio().  Those two functions have conflicting 
protections on args passed to them and I had some trouble coming up with 
something that would compile cleanly.  As I say, I will look at this again.

..mark
