Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 25759385701A
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 09:33:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 25759385701A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MPoPd-1ljGO931IB-00Mq0c for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021
 11:33:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B34D5A831C6; Wed, 21 Jul 2021 11:33:05 +0200 (CEST)
Date: Wed, 21 Jul 2021 11:33:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix nanosleep returning negative rem
Message-ID: <YPfp0WgZUVo0nap7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
 <YPfdSyPTCdSWhRv/@calimero.vinschen.de>
 <0189b5495b2149c5a690de0431b7695c@metastack.com>
 <YPfpSgbZbr+bnOWE@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1dtQ7ztGIgFRdV5j"
Content-Disposition: inline
In-Reply-To: <YPfpSgbZbr+bnOWE@calimero.vinschen.de>
X-Provags-ID: V03:K1:Id0K9RccPO4+pq/xp0ionF28dZeIBic2emq+KlwvKzlESNQ9Fc1
 SsLU4+WxTVTDBna3SK8vrcWbBXWRTg/cAgwxlYS4CXx05/7fhjcJiASds37HZAYc8J2M1wJ
 6oJRNPykKYzbTEl6JPTrd2WLR1O2RTV3a/0AD3XAxAKVf6rS9WIHXU8xdsAC2ohiLTnGe46
 E2O2oMFpLoTMZRc6FOD8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bqjjwf4kzPg=:PvnBDnuuzIr4QExylY2Eqr
 30cOGtW/XaSkYU+8x9M/GqTz1MB0SoNLo+5XqHXibIE9UgDLZt1OR9AmCThO0uyVY4sbfbkJE
 uFsX0hlRA/V9GmOPLwEKhPqK2J5DprdfPGTaHFNHh3NuWrFyjQtW8IyXxDJY3Lc5Z6uvluL9I
 iXi7cE9XQ1uJENuDzjkSFGXUcVs/fwY2tx0n6U+7DC+S8UOBkmNPm9BgxDKZ29FitYl4cJJRF
 gR7O4E9GR44+e5B7WPX/CDNPGn55lrYrBSwtUAGyCbueToNrBaBVEtPZLdoaFJU3b2yXRhUZr
 r/w/JJrXiIDSK8p6QdbGJVwfJMT2Fjlfx0WkrJ4DzVXcU4xlXxAP6gM3wbgO6jBaGGjQIV4kB
 YS9Xdq6wQN/8XMKRe01M9/veyMCBeBhvmhqWmDvvVzE74Q/N0N+EPwHKXBACXytCnpz2XhxhH
 6xY/hqE/J2uNhgDbORvJifPg1WVimxSaeNf1r3/2xP04YVs8iQqZMgExLRFvPcZSv9lfe+ZLy
 TN2CpVHvhXa6VhJpQiprz4VQ5pa+R0O+BKluIfRgM0vsNBH1ccpAj9zptYB+vG/EWPjs5wOy8
 kTs8wrw2AOlXVD5kpeqibiKSBFZ7XoaS+NECZc8NmJ2cJhhgc2uOr4S29kXM2keNCK1kqfiZx
 iORcZpmUhlpay/ApzkgmdhhxcQQAnqZCXvaN+92wQD79e3YXW9zFUe+hXl87hyT74Z9EJ/4AI
 jeqvH1UpgbKhTyI27jRfXyysNn6COaKgz06SZA4Lo31+lEFgHodom1q2HiDmtVqK0YrY/QCSt
 /CFHY9tDn/PJQ6CG7VKhc2bvmap2F0IOOjdht4+I8mHgnIpvzBfmGTbEOOOKmUlgWoSQGnwDs
 dPH0QcJP8VsRC5bgGWGg==
X-Spam-Status: No, score=-100.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 21 Jul 2021 09:33:09 -0000


--1dtQ7ztGIgFRdV5j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Jul 21 11:30, Corinna Vinschen wrote:
> I wrote a quick STC using the NT API calls and I can't reproduce the
> problem with this code either.  The output is either
> 
>   SignalState: 1 TimeRemaining: -5354077459183
> 
> or
> 
>   SignalState: 0 TimeRemaining: 653
> 
> I never get a small negative value in the latter case.  Can you
> reproduce your problem with this testcase or tweak it to reproduce it?

Now I actually attached the code :}


Corinna

--1dtQ7ztGIgFRdV5j
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="timer.c"

#include <stdio.h>
#include <w32api/windows.h>
#include <w32api/winternl.h>
#include <w32api/ntdef.h>

typedef enum _TIMER_INFORMATION_CLASS {
  TimerBasicInformation = 0
} TIMER_INFORMATION_CLASS, *PTIMER_INFORMATION_CLASS;

typedef struct _TIMER_BASIC_INFORMATION {
  LARGE_INTEGER TimeRemaining;
  BOOLEAN SignalState;
} TIMER_BASIC_INFORMATION, *PTIMER_BASIC_INFORMATION;

NTSTATUS NTAPI NtCreateTimer(PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES,
			     TIMER_TYPE);

NTSTATUS NTAPI NtCancelTimer(HANDLE, PBOOLEAN);

NTSTATUS NTAPI NtSetTimer(HANDLE, PLARGE_INTEGER, PVOID, PVOID,
			  BOOLEAN, LONG, PBOOLEAN);

NTSTATUS NTAPI NtQueryTimer (HANDLE, TIMER_INFORMATION_CLASS, PVOID,
			     ULONG, PULONG);

int
main ()
{
  HANDLE event;
  HANDLE timer;
  NTSTATUS status;
  LARGE_INTEGER timeout;
  TIMER_BASIC_INFORMATION tbi;

  event = CreateEvent (NULL, TRUE, FALSE, NULL);
  status = NtCreateTimer (&timer, TIMER_ALL_ACCESS, NULL, NotificationTimer);
  if (!NT_SUCCESS (status))
    {
      fprintf (stderr, "NtCreateTimer: 0x%08lx\n", status);
      return 1;
    }
  timeout.QuadPart = -10000000LL;	/* 1 sec */
  status = NtSetTimer (timer, &timeout, NULL, NULL, FALSE, 0, NULL);
  if (!NT_SUCCESS (status))
    {
      fprintf (stderr, "NtSetTimer: 0x%08lx\n", status);
      return 1;
    }
  WaitForSingleObject (event, 985L);
  NtQueryTimer (timer, TimerBasicInformation, &tbi, sizeof tbi, NULL);
  printf ("SignalState: %d TimeRemaining: %lld\n", tbi.SignalState,
						   tbi.TimeRemaining.QuadPart);
  NtCancelTimer (timer, NULL);
  NtClose (timer);
  return 0;
}

--1dtQ7ztGIgFRdV5j--
