Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6D3E33858C50; Fri, 27 Jun 2025 12:28:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D3E33858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751027339;
	bh=iCPSBp4tlkFElQQUu/EXQVmE4az4saJ0YFVbx2AYRX8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=HIszcTqQlpVhBGQZFQPJzCUunsEqXplVExgLiZPsyIdI7z88YAiNURfzRlOS0/md6
	 1aQIRBhy2LQ78gzcpa8RkG3Qupg9kssB/gMcD3eAfeKly6V0SHrJ7fDFIwuFVg+dDn
	 9yt/oBZPLop8j+Z6bmYJCP3eOo9X31U4eTTAHQ+E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5A697A806FF; Fri, 27 Jun 2025 14:28:57 +0200 (CEST)
Date: Fri, 27 Jun 2025 14:28:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to spawn
Message-ID: <aF6OibgUJ3IUvmLN@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> This program is currently meant to test standard file handles and
> current working directory (since these are settable via posix_spawn),
> but could be extended to add additional checks if other cygwin-to-win32
> process properties need to be tested.
> 
> Change cygrun environment variable to mingwtestdir, and use that instead
> in cygrun.sh, so that other tests can find mingw test executables using
> the environment variable.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> 
> BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> -Wl,--disable-high-entropy-va in LDFLAGS?

Why?


Corinna
