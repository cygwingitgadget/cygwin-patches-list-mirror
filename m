Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 885863858D1E; Wed, 30 Jul 2025 17:00:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 885863858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753894824;
	bh=L70zVb2YGrWJpGBUtz9Qo+FWY2MscAjuPavbSfHZLaQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=haJobl+DDJ91ULPcC7jmfN6iHrcw04QYAZDfX1SgJpaOKvntGKDbh7Xvl2rpX5iMD
	 EeIMrXy2l5rGbRzZsJXu8oShhgZCuicqK23OYMwx0Yb/bZ46ZcNSNkJG/P4DGq1U3G
	 kYmc4xZD/NR5iFLY8YL3+O2qMvF4Est3zq7pl8WY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D8C0BA80BCC; Wed, 30 Jul 2025 19:00:22 +0200 (CEST)
Date: Wed, 30 Jul 2025 19:00:22 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	"jon.turney@dronecode.org.uk" <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: configure: allow zero-level bootstrapping
 cross-build with --without-cross-bootstrap (and cross-testing without)
Message-ID: <aIpPpti_zl-emdmd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	"jon.turney@dronecode.org.uk" <jon.turney@dronecode.org.uk>
References: <DB9PR83MB0923F85A909F2724ED5328239259A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB9PR83MB0923F85A909F2724ED5328239259A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

On Jul 25 21:40, Radek Barton via Cygwin-patches wrote:
> ChangeLog:
> 
>         * newlib/libc/include/stdlib.h (abort): Remove (void) parameter
>         to fix x64 compilation with GCC 15 cross-compiler.
>         * winsup/configure.ac: Fix --with-cross-bootstrap flag semantics,
>         change target_cpu to build_cpu for MinGW toolchain detection,
>         and conditionally check BFD libraries only when not bootstrapping
>         to avoid "configure: error: link tests are not allowed after
>         AC_NO_EXECUTABLES" error.
>         * winsup/doc/faq-programming.xml: Fix spacing in documentation
>         for --without-cross-bootstrap flag.
>         * winsup/testsuite/Makefile.am: Make mingw/cygload test conditional
>         on CROSS_BOOTSTRAP, use EXEEXT variable for Unix based cross-compilation
>         environments that are not adding the extension automatically, use
>         dynamic busybox path detection instead of hardcoded paths.
>         * winsup/testsuite/cygrun.sh: Add .exe extension to executable
>         references for proper cross-platform compatibility. This still have two
>         caveats, it assumes cygdrop and cygpath to be present in the
>         environment. This is becase cygdrop is not part of the newlib-cygwin
>         repository and using cygpath built from the repository is failing with
>         "Warning!  Stack base is 0x600000.  padding ends at 0x5ff7c8.
>         Delta is 2104.  Stack variables could be overwritten!" even for native
>         x64 environments.

Apart from Jon's points, a small style issue: We shouldn't fall back to
the old CVS ChangeLog format for describing things we did.  I see how
this comes in handy here, but that's very likely just a result of having
merged different issues into a single patch.  If you split this up, the
normal commit summary and text should very likely explain nicely what
you did.


Thanks,
Corinna
