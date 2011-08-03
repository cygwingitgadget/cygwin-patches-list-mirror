Return-Path: <cygwin-patches-return-7467-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9515 invoked by alias); 3 Aug 2011 06:20:18 -0000
Received: (qmail 9498 invoked by uid 22791); 3 Aug 2011 06:20:16 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Aug 2011 06:20:02 +0000
Received: by iyf13 with SMTP id 13so147307iyf.2        for <cygwin-patches@cygwin.com>; Tue, 02 Aug 2011 23:20:01 -0700 (PDT)
Received: by 10.42.72.134 with SMTP id o6mr4855750icj.40.1312352401700;        Tue, 02 Aug 2011 23:20:01 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id u1sm196483icj.4.2011.08.02.23.19.59        (version=SSLv3 cipher=OTHER);        Tue, 02 Aug 2011 23:20:00 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Wed, 03 Aug 2011 06:20:00 -0000
In-Reply-To: <20110802154240.GB5647@calimero.vinschen.de>
References: <1311126880.7796.9.camel@YAAKOV04>	 <20110721103735.GJ15150@calimero.vinschen.de>	 <1311274281.6192.3.camel@YAAKOV04>	 <20110731082430.GA23564@calimero.vinschen.de>	 <1312258171.3500.6.camel@YAAKOV04>	 <20110802154240.GB5647@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-GPFn6lFOz5Q+K0WHH4qI"
Message-ID: <1312352413.2316.16.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00043.txt.bz2


--=-GPFn6lFOz5Q+K0WHH4qI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1133

On Tue, 2011-08-02 at 17:42 +0200, Corinna Vinschen wrote:
> Does that mean the return value from NtQueryTimer is unreliable?
> In what way is it wrong?  

I'm not sure.  When I run an STC (attached), it works as expected.  In
cancelable_wait(), however, it returns the negative system uptime.  Is
Cygwin doing something to make this occur?

> Does nanosleep wait too long or not long enough?

That doesn't seem to be an issue.

> If NtQueryTimer is unusable, maybe we should just skip the idea to return
> the remaining time from cancelabel_wait and simply use the return
> value from hires_ms::timeGetTime_ns() to return the remaining time
> from {clock_}nanosleep

I'd rather avoid this type of workaround, particularly with
clock_nanosleep having to deal with CLOCK_MONOTONIC as well.

> > and the pthread_spin chunk doesn't look right (previously
> > the timeout would repeat in the while loop, but that won't happen the
> > way the waitable timer is set up).
> 
> It doesn't look wrong to me, but then again, I didn't test it...

You're right, since we pay no attention to the return value of
cancelable_wait() here.


Yaakov


--=-GPFn6lFOz5Q+K0WHH4qI
Content-Disposition: attachment; filename="ntquerytimer-test.c"
Content-Type: text/x-csrc; name="ntquerytimer-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 888

#pragma CCOD:script no
#pragma CCOD:options -lntdll

#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include <ddk/ntapi.h>

int main(void) {
  HANDLE timer;
  LARGE_INTEGER li;
  PTIMER_BASIC_INFORMATION tbi;
  const size_t sizeof_tbi = sizeof (TIMER_BASIC_INFORMATION);
  int i;

  li.QuadPart = -20000000LL;

  NtCreateTimer (&timer, TIMER_ALL_ACCESS, NULL, NotificationTimer);

  for (i = 0; i < 10; i++)
    {
      NtSetTimer (timer, &li, NULL, NULL, FALSE, 0, NULL);
      WaitForSingleObject (timer, 1000);

      tbi = (PTIMER_BASIC_INFORMATION) malloc (sizeof_tbi);
      NtQueryTimer (timer, TimerBasicInformation, tbi, sizeof_tbi, NULL);
      NtCancelTimer (timer, NULL);

      printf ("%ld.%09ld\n", (long) (tbi->TimeRemaining.QuadPart / 10000000LL),
	      (long) ((tbi->TimeRemaining.QuadPart % 10000000LL) * 100LL));
    }

  NtClose (timer);

  return 0;
}

--=-GPFn6lFOz5Q+K0WHH4qI--
