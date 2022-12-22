Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	by sourceware.org (Postfix) with ESMTPS id EAE343858022
	for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022 12:51:01 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mj7yt-1ocqAL0c8D-00fCfW for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022
 13:51:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AA591A80C99; Thu, 22 Dec 2022 13:50:59 +0100 (CET)
Date: Thu, 22 Dec 2022 13:50:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make the console accessible from other
 terminals.
Message-ID: <Y6RSs9d1atkWcPiJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221220124521.499-1-takashi.yano@nifty.ne.jp>
 <Y6ItllXJ8J20cEbp@calimero.vinschen.de>
 <20221221192343.32699d22e6d113ce9195de8f@nifty.ne.jp>
 <Y6MCeRdiRCJAQMbV@calimero.vinschen.de>
 <20221222180603.9a8dedadfee6c59cdf073e36@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222180603.9a8dedadfee6c59cdf073e36@nifty.ne.jp>
X-Provags-ID: V03:K1:wKiI8BWv1SUurcuVXY/7pJWiUa0uTHxu899LsFrK/uY1167C7KE
 fN54TXeLSxHLbJN0JKZCBuR2XR7WuQQerAW5afGL5YJ1a6Uj87kaj72nhMll/SMp8agR2dT
 d2qzp+yLQmSbhxdIvYdEO2uaW6Bdm6e2oLyEbRtmqadvolJ+YMPafA+BxU1mfxRbSj4rzKw
 gGP9lw+souXRgY+0Dno/A==
UI-OutboundReport: notjunk:1;M01:P0:DZvs3gDCNE0=;e5uY1Z91GcmgiDNjKRF3KI/pO02
 yk9FhBsTjtwOsl6oX24n76T5FwEZJMgGIm92lbW+3j5Xiq0GxrMtCK21m+I5NKhtn5XRziC39
 xkskDutfponmdDmaIT+2Cs4QzZUdwhIOIE/pFp9NZdHDo41o4pc2JdMHmOZ9doDTyVRcJUFvw
 TLYaiOO+LRCplzrWGF+h7frkfYQcT8Ufy9ezengFgOdxNYY7KFa+tjP6wqCKNGW93rC83tXLt
 tKtK9HfGj+LiBfMBdbvKZrGXPJkq0gul34TPEsndZLEs0Tl7tBBzVgFrRjvtxVup9pJOPA5RC
 v1rPBi3M6BzsIQCDyR3IBaj7Oz0e5Lqm8tbptdX73v7YOPzjrvUNKpkLq/pB2adcphSRGuJlo
 CxGnOQ83NJVAmGpw86cuyvQP67yClqpCiO5erf2sisnPXOYWaf9kW4UNQszjK4yQSoQewmtwG
 LPd6rM0Fs9DNu6rXib7ygLZS/uAzO9AQkJ+PKjXfNC264J7ZAft/t+dJb7nWp5q9FVcIJBETV
 AMLuuIbDT0+22cMgNeYEG2eyZRNJ3m8B5jS7ptehHKrP4WZlJzJb6H0HjsCgo42bK+nXH8xM2
 K6FxFYDdjTWLbfwah8Mi1tMTdOD62C+cf2dx6yE77Fp26EA4ddBXij9IUf21vy1RnoQfkRFMZ
 rjiS6+7u4QwAkVAP6USPcvKKd7zipHXazzSt9yc2hg==
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Dec 22 18:06, Takashi Yano wrote:
> On Wed, 21 Dec 2022 13:56:25 +0100
> Corinna Vinschen wrote:
> > However, there's something broken with these patches in terms of
> > debugging:
> > 
> > With current origin/master:
> > 
> >   $ ls -l  /dev/cons0
> >   crw-rw-rw- 4 corinna vinschen 3, 0 Dec 21 13:46 /dev/cons0
> >   $ strace -o xxx /bin/ls /dev/cons0
> >   /dev/cons0
> > 
> > After applying "pinfo: Align CTTY behavior to the statement of POSIX."
> > 
> >   $ ls -l /dev/cons0
> >   crw-rw-rw- 4 corinna vinschen 3, 0 Dec 21 13:51 /dev/cons0
> >   $ strace -o xxx /bin/ls /dev/cons0
> >   /usr/bin/ls: cannot access '/dev/cons0': No such device or address
> > 
> > "devices: Make generic console devices invisible from pty." doesn't
> > change this, but after applying "console: Make the console accessible
> > from other terminals.":
> > 
> >   $ ls -l /dev/cons0
> >   crw------- 4 corinna vinschen 3, 0 Dec 21 13:55 /dev/cons0
> >   $ strace -o xxx /bin/ls /dev/cons0
> >    670400 [main] ls 1630 C:\cygwin64\bin\ls.exe: *** fatal error - MapViewOfFileEx '(null)'(0x54), Win32 error 487.  Terminating.
> >    674526 [main] ls 1630 cygwin_exception::open_stackdumpfile: Dumping stack trace to ls.exe.stackdump
> > 
> > FWIW:
> > 
> >   $ strace -o xxx /bin/ls
> >    673796 [main] ls 1633 C:\cygwin64\bin\ls.exe: *** fatal error - MapViewOfFileEx '(null)'(0x54), Win32 error 487.  Terminating.
> >    676814 [main] ls 1633 cygwin_exception::open_stackdumpfile: Dumping stack trace to ls.exe.stackdump
> 
> Thank you for finding this. I think this can be easily fixed.
> Please see v3 patch.
> 
> [PATCH v3] Cygwin: pinfo: Align CTTY behavior to the statement of POSIX.

LGTM.  Please push all three patches.

However, I'm not really sure we should merge "Align CTTY behavior to the
statement of POSIX." to 3.4.  It's a behavioral change, and how sure are
we that it has no side-effects?


Thanks,
Corinna
