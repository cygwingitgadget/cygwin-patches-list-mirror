Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D25D2385B53C; Fri, 21 Jul 2023 20:00:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D25D2385B53C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689969602;
	bh=UZP8/Cz5+xJOlJC/5MeMWSFNWbPLYAsNlpeYoJOm9cY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WMtgnQIZzleAY5TcXY9gIklPT3Ohefb1ahr7QC1x0EHIHjucwgSYUzZOXwRWy6xOT
	 Ey6ib8uysLq5JI0fAKaL/bL0LcUYN7/I8K6TKLSLdKU7tfPC2qTfiQfR/cBIxs0QfX
	 8pDgu4+mRFb1Kd4HFTE9SVUOZ/Hmmd8wBxIgsM0U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 64A39A81B2B; Fri, 21 Jul 2023 22:00:00 +0200 (CEST)
Date: Fri, 21 Jul 2023 22:00:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: testsuite: Drop using DejaGnu to run tests
Message-ID: <ZLrjwBa6VS9GKJIO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com
References: <20230721122939.1807-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230721122939.1807-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 21 13:29, Jon Turney wrote:
> A more sophisticated (and modern) test harness would probably be useful,
> but switching to Automake's built-in test harness gets us parallel test
> execution, colourization of failures, simplifies matters, seems adequate
> for the current testuite, and means we don't need to write any icky Tcl.
> 
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>  .github/workflows/cygwin.yml               |  2 +-
>  winsup/configure.ac                        |  2 +-
>  winsup/doc/faq-programming.xml             |  5 +-
>  winsup/testsuite/Makefile.am               | 27 ++++----
>  winsup/testsuite/README                    | 22 +++----
>  winsup/testsuite/config/default.exp        | 13 ----
>  winsup/testsuite/cygrun.sh                 | 17 +++++
>  winsup/testsuite/winsup.api/cygload.exp    | 30 ---------
>  winsup/testsuite/winsup.api/known_bugs.tcl |  4 --
>  winsup/testsuite/winsup.api/winsup.exp     | 74 ----------------------
>  10 files changed, 47 insertions(+), 149 deletions(-)
>  delete mode 100644 winsup/testsuite/config/default.exp
>  create mode 100755 winsup/testsuite/cygrun.sh
>  delete mode 100644 winsup/testsuite/winsup.api/cygload.exp
>  delete mode 100644 winsup/testsuite/winsup.api/known_bugs.tcl
>  delete mode 100644 winsup/testsuite/winsup.api/winsup.exp


Good idea. Please go ahead.


Thanks,
Corinna
