Return-Path: <cygwin-patches-return-9127-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47567 invoked by alias); 18 Jul 2018 07:33:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47543 invoked by uid 89); 18 Jul 2018 07:33:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=dig, Hx-languages-length:2124
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Jul 2018 07:33:47 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6I7XkFt003669	for <cygwin-patches@cygwin.com>; Wed, 18 Jul 2018 00:33:46 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdzRy1CR; Wed Jul 18 00:33:39 2018
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com> <20180717145146.GA23667@calimero.vinschen.de> <20180717155122.GF27673@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <eb9734df-74e8-8245-5763-a5a262cb594d@maxrnd.com>
Date: Wed, 18 Jul 2018 07:33:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0 SeaMonkey/2.46
MIME-Version: 1.0
In-Reply-To: <20180717155122.GF27673@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00022.txt.bz2

Corinna Vinschen wrote:
> Mark,
>
> I think there's a bug in sigtimedwait.  I just found the problem while
> looking into this aio_suspend stuff:
>
> On Jul 17 16:51, Corinna Vinschen wrote:
>>> +  res = sigtimedwait (&sigmask, &si, to);
>
> You're giving the timeout value verbatim to sigtimedwait().
>
> Let's have a look into sigtimedwait, per your original patch, commit
> 24ff42d79aab:
>
> +  if (timeout)
> +    {
> +      if (timeout->tv_sec < 0
> +           || timeout->tv_nsec < 0 || timeout->tv_nsec > (NSPERSEC * 100LL))
> +       {
> +         set_errno (EINVAL);
> +         return -1;
> +       }
>
> So we're enforcing a positive timeout value.
>
> +      /* convert timespec to 100ns units */
> +      waittime.QuadPart = (LONGLONG) timeout->tv_sec * NSPERSEC
> +                          + ((LONGLONG) timeout->tv_nsec + 99LL) / 100LL;
> +    }
>
> ...which is converted to a likewise positive 100ns interval ...
>
> +  return sigwait_common (set, info, timeout ? &waittime : cw_infinite);
>
> ...given to sigwait_common, which in turn calls
>
>   cygwait (NULL, waittime, [flags])
>
> cygwait uses this waittime value verbatim in a call to
>
>   NtSetTimer (_my_tls.locals.cw_timer, timeout, [...]);
>
> So NtSetTimer is called with a *positive* waittime value, right?
>
> A positive value given to NtSetTimer is evaluated as a timestamp,
> *not* as a time interval.  Look at the lpDueTime description of
> SetWaitableTimerEx.  That's the WIN32 API function exposing the
> NtSetTimer function:
> https://docs.microsoft.com/en-us/windows/desktop/api/synchapi/nf-synchapi-setwaitabletimerex
>
> However, the POSIX description of sigtimedwait indicates that the
> timespec value is evaluated as a time interval, which is a relative
> time:
>
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/sigtimedwait.html
>
> So bottom line is, shouldn't timeout be converted to a negative waittime
> value in sigtimedwait?

Yes, you are correct.  I did not dig deeply enough into cygwait to notice my error.

Is it OK for me to fix this as part of the AIO patch set or should it be 
separate?  Either way is fine with me.
Thanks again,

..mark
