Return-Path: <cygwin-patches-return-7445-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15299 invoked by alias); 21 Jul 2011 09:36:33 -0000
Received: (qmail 10891 invoked by uid 22791); 21 Jul 2011 09:36:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Jul 2011 09:35:57 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4122A2CAE8D; Thu, 21 Jul 2011 11:35:54 +0200 (CEST)
Date: Thu, 21 Jul 2011 09:36:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
Message-ID: <20110721093554.GH15150@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110720075654.GA3667@calimero.vinschen.de> <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04> <20110720141125.GA15232@calimero.vinschen.de> <1311199441.6248.9.camel@YAAKOV04> <1311214958.7552.24.camel@YAAKOV04> <20110721092105.GG15150@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20110721092105.GG15150@calimero.vinschen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00021.txt.bz2


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-length: 2387

On Jul 21 11:21, Corinna Vinschen wrote:
> On Jul 20 21:22, Yaakov (Cygwin/X) wrote:
> > Looking at the other uses of cancelable_wait(), would the following make
> > sense:
> > 
> > * change the timeout argument to struct timespec *;
> > * cancelable_wait (object, INFINITE) calls change to (object, NULL);
> > * cancelable_wait (object, DWORD) calls change to (object, &timespec);
> > * then in cancelable_wait:
> > 
> > HANDLE hTimer;
> > HANDLE wait_objects[4];
> > ....
> > wait_objects[num++] = object;
> > 
> > if (timeout)
> >   {
> >     LARGE_INTEGER li;
> >     li.QuadPart = (timeout->tv_sec * NSPERSEC) + (timeout->tv_nsec /
> > 100); /* rounding? */
> >     hTimer = CreateWaitableTimer (NULL, FALSE, NULL);
> >     SetWaitableTimer (hTimer, &li, 0, NULL, NULL, FALSE); /* handle
> > possible error?  what would cause one? */
> >     wait_objects[num++] = hTimer;
> >   }
> > ...
> > while (1)
> >   {
> >     res = WaitForMultipleObjects (num, wait_objects, FALSE, INFINITE);
> > ....
> > 
> > Or am I completely off-base here?
> 
> No, you're not at all off-base.  Personally I'd prefer to use the native
> NT timer functions, but that's not important.  What I'm missing is a way
> to specify relative vs. absolute timeouts in your above sketch.  I guess
> we need a flag argument as well.
> 
> Other than that, I think we should make sure to create the waitable
> timer only once on a per-thread base.  Object creation and deletion is
> usually a time consuming process.  So what we could do is to add a
> HANDLE "cw_timer" to struct _local_storage in cygtls.h, which gets
> inited to NULL in _cygtls::init_thread as well as in
> _cygtls::fixup_after_fork.
> 
> Then cancelable_wait with a non-NULL timespec would check for the handle
> being NULL and create a non-inheritable timer, if so.  All subsequent
> calls only set (and cancel) the timer.
> 
> Does that sound reasonable?

Btw., if you call NtQueryTimer right before NtCancelTimer, then you get
the remaining time for free to return to clock_nanosleep.  It would
be nice if NtQueryTimer would return the remaining time after calling
NtCancelTimer, but my experiments show that some weird value gets
returned.  See my attached testcase.  Build with -lntdll.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="tick.c"
Content-length: 1514

#include <stdio.h>
#include <stdlib.h>
#include <windows.h>
#include <ddk/ntddk.h>

int
main (int argc, char* argv[])
{
  NTSTATUS status;
  HANDLE timer;
  LARGE_INTEGER duetime;
  PTIMER_BASIC_INFORMATION tbi;
  int cnt = 10, i;
  long long lastTimer = 0;

  duetime.QuadPart = -10000000000LL;
  tbi = (PTIMER_BASIC_INFORMATION)
	calloc (cnt + 1, sizeof (TIMER_BASIC_INFORMATION));
  if (!tbi)
    {
      printf ("malloc failed\n:");
      return 1;
    }
  status = NtCreateTimer (&timer, TIMER_ALL_ACCESS, NULL, NotificationTimer);
  if (!NT_SUCCESS (status))
    {
      printf ("NtCreateTimer: %p\n", status);
      return 1;
    }
  status = NtSetTimer (timer, &duetime, NULL, NULL, FALSE, 1000000L, NULL);
  if (!NT_SUCCESS (status))
    {
      printf ("NtSetTimer: %p\n", status);
      return 1;
    }
  for (i = 0; i < cnt; ++i)
    {
      do
	{
	  NtQueryTimer (timer, TimerBasicInformation, tbi + i, sizeof *tbi,
			NULL);
	  //Sleep(1);
	}
      while (tbi[i].TimeRemaining.QuadPart
	     == tbi[i - 1].TimeRemaining.QuadPart);
    }
  NtCancelTimer (timer, NULL);
  status = NtQueryTimer (timer, TimerBasicInformation, tbi + i, sizeof *tbi,
			 NULL);
  if (!NT_SUCCESS (status))
    printf ("NtQueryTimer: %p\n", status);
  NtClose (timer);
  for (i = 1; i < cnt + 1; ++i)
    printf("Timer: %lld (%llx), dTimer: %lld usec\n",
	   tbi[i].TimeRemaining.QuadPart,
	   tbi[i].TimeRemaining.QuadPart,
	   (tbi[i - 1].TimeRemaining.QuadPart
	    - tbi[i].TimeRemaining.QuadPart) / 10);
  return 0;
}

--fUYQa+Pmc3FrFX/N--
