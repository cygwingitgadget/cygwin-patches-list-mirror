Return-Path: <cygwin-patches-return-7442-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18356 invoked by alias); 21 Jul 2011 02:22:45 -0000
Received: (qmail 18344 invoked by uid 22791); 21 Jul 2011 02:22:44 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 21 Jul 2011 02:22:30 +0000
Received: by yxk38 with SMTP id 38so478586yxk.2        for <cygwin-patches@cygwin.com>; Wed, 20 Jul 2011 19:22:29 -0700 (PDT)
Received: by 10.150.252.20 with SMTP id z20mr41438ybh.193.1311214949326;        Wed, 20 Jul 2011 19:22:29 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id k5sm2242357ybf.8.2011.07.20.19.22.27        (version=SSLv3 cipher=OTHER);        Wed, 20 Jul 2011 19:22:28 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Thu, 21 Jul 2011 02:22:00 -0000
In-Reply-To: <1311199441.6248.9.camel@YAAKOV04>
References: <1311126880.7796.9.camel@YAAKOV04>		 <20110720075654.GA3667@calimero.vinschen.de>		 <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04>		 <20110720141125.GA15232@calimero.vinschen.de>	 <1311199441.6248.9.camel@YAAKOV04>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1311214958.7552.24.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00018.txt.bz2

On Wed, 2011-07-20 at 17:03 -0500, Yaakov (Cygwin/X) wrote:
> On Wed, 2011-07-20 at 16:11 +0200, Corinna Vinschen wrote:
> > The only problem I see is the fact that a call to clock_settime
> > influences calls to clock_nanosleep with absolute timeouts(*).

However, clock_settime() can set only CLOCK_REALTIME, not
CLOCK_MONOTONIC, so...

> > The problem is that we convert absolute timeouts to relative timeouts
> > and then use the timeout facility of the WFMO function to handle the
> > timeout for us.  IMO this is neither very reliable, nor is it elegant.
> > 
> > So, here's the question.  Shouldn't we better use waitable timers
> > to implement this sort of stuff?  Waitable timers are pretty easy to
> > use, they support relative and absolute timeouts with an accuracy of 100
> > ns in the API and a real accuracy which only depends on the underlying
> > HW, and they are especially not subject to the 49.7 days overflow
> > problem.
> 
> I see your point.  The question is how to use waitable timers for
> CLOCK_MONOTONIC.

...therefore we could still handle CLOCK_MONOTONIC timedwait as a
relative timeout.  So pthread_condattr_[gs]etclock should be correct
even without this (although it would still gain accuracy), but that does
leave a problem with clock_nanosleep(TIMER_ABSTIME).

Looking at the other uses of cancelable_wait(), would the following make
sense:

* change the timeout argument to struct timespec *;
* cancelable_wait (object, INFINITE) calls change to (object, NULL);
* cancelable_wait (object, DWORD) calls change to (object, &timespec);
* then in cancelable_wait:

HANDLE hTimer;
HANDLE wait_objects[4];
....
wait_objects[num++] = object;

if (timeout)
  {
    LARGE_INTEGER li;
    li.QuadPart = (timeout->tv_sec * NSPERSEC) + (timeout->tv_nsec /
100); /* rounding? */
    hTimer = CreateWaitableTimer (NULL, FALSE, NULL);
    SetWaitableTimer (hTimer, &li, 0, NULL, NULL, FALSE); /* handle
possible error?  what would cause one? */
    wait_objects[num++] = hTimer;
  }
...
while (1)
  {
    res = WaitForMultipleObjects (num, wait_objects, FALSE, INFINITE);
....

Or am I completely off-base here?


Yaakov

