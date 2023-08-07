Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 653D43858D28; Mon,  7 Aug 2023 08:55:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 653D43858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1691398546;
	bh=XgasVt2GhCm9JFrX89hHzkrmm3C+cmVg+Vw2Tg19ta8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Y9eGdExxCnyX9N62tdcur9j4LCutkh7/rtH3LCn3t/3DbNSD6GAk+9CQKs2LaeHM2
	 JHZ6eRlVmaO3gfc8F0FbYWE3R4Ursc9NhpXhyuMKs0KqY0dAd8q/OD5hPL28+yeAsW
	 dwR7wW/AsM1E1oLPIhZ3AKtIz/F9ucz/IsMJ/G4o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A3D7AA80BDA; Mon,  7 Aug 2023 10:55:44 +0200 (CEST)
Date: Mon, 7 Aug 2023 10:55:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Testsuite update
Message-ID: <ZNCxkNhrpJWGRPbB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	cygwin-patches@cygwin.com
References: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Aug  4 13:47, Jon Turney wrote:
> This gets us down to no permanent failures in the testsuite in CI.
> 
> When run locally, msgtest, semtest and shmtest fail because they need a running cygserver using the test DLL,
> and I haven't got a good idea about how to automate that.  devdsp fails due to a hang in child while exiting.
> 
> Jon Turney (4):
>   Cygwin: testsuite: Add '-notimeout' option to cygrun
>   Cygwin: testsuite: Update README
>   Cygwin: testsuite: Fix cygload test
>   Cygwin: CI: XFAIL umask03
> 
>  winsup/testsuite/Makefile.am |  6 ++-
>  winsup/testsuite/README      | 82 +++++++++++++++++++++++++-----------
>  winsup/testsuite/cygrun.c    | 26 ++++++++++--
>  winsup/testsuite/cygrun.sh   |  2 +-
>  4 files changed, 86 insertions(+), 30 deletions(-)
> 
> -- 
> 2.39.0

:+1:


Corinna
