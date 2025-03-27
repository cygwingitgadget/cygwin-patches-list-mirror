Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 260DB3858C48; Thu, 27 Mar 2025 11:49:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 260DB3858C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743076157;
	bh=Wt+X+a8cwM8te5oS5Vn6AD5C/d/KXXYCbp1wzcWeZmE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WqKxuptZtliWyS5U7vF5EukasN7Qtgiw5e9LKiN5Hk8hde3KHnXsUkwxa2Q/8tUx3
	 Pzb8wipPYBmBaX0K6cxL8lcIBOFSd4/J8SSVRx4nhIGmJ3ahcfAOOci+B1smU6BPcI
	 aOyU4ZPNuFh6HOjYY1WsyHepArfJWLh7LBWcmqaI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 06379A806F0; Thu, 27 Mar 2025 12:49:15 +0100 (CET)
Date: Thu, 27 Mar 2025 12:49:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-U7OgZeEh74An4p@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com>
 <3e7c52d1-01ef-4843-23a4-18f69da1ecea@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e7c52d1-01ef-4843-23a4-18f69da1ecea@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 26 16:45, Jeremy Drake via Cygwin-patches wrote:
> v2 splits the vendoring of libudis86 into importing the original files and
> then patching them (and adding them to Makefile.am at that point).  It
> also has both x86_64 and aarch64 implementations exit loops on rets or
> unconditional jumps.
> 
> Jeremy Drake (5):
>   Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
>   Cygwin: vendor libudis86 1.7.2/libudis86
>   Cygwin: patch libudis86 to build as part of Cygwin
>   Cygwin: use udis86 to find fast cwd pointer on x64
>   Cygwin: add find_fast_cwd_pointer_aarch64.
> 
>  winsup/cygwin/Makefile.am              |   14 +-
>  winsup/cygwin/fastcwd_aarch64.cc       |  203 +
>  winsup/cygwin/path.cc                  |  145 +-
>  winsup/cygwin/udis86/decode.c          | 1113 ++++
>  winsup/cygwin/udis86/decode.h          |  195 +
>  winsup/cygwin/udis86/extern.h          |  109 +
>  winsup/cygwin/udis86/itab.c            | 8404 ++++++++++++++++++++++++
>  winsup/cygwin/udis86/itab.h            |  680 ++
>  winsup/cygwin/udis86/types.h           |  260 +
>  winsup/cygwin/udis86/udint.h           |   91 +
>  winsup/cygwin/udis86/udis86.c          |  464 ++
>  winsup/cygwin/x86_64/fastcwd_x86_64.cc |  172 +
>  12 files changed, 11727 insertions(+), 123 deletions(-)
>  create mode 100644 winsup/cygwin/fastcwd_aarch64.cc
>  create mode 100644 winsup/cygwin/udis86/decode.c
>  create mode 100644 winsup/cygwin/udis86/decode.h
>  create mode 100644 winsup/cygwin/udis86/extern.h
>  create mode 100644 winsup/cygwin/udis86/itab.c
>  create mode 100644 winsup/cygwin/udis86/itab.h
>  create mode 100644 winsup/cygwin/udis86/types.h
>  create mode 100644 winsup/cygwin/udis86/udint.h
>  create mode 100644 winsup/cygwin/udis86/udis86.c
>  create mode 100644 winsup/cygwin/x86_64/fastcwd_x86_64.cc

Other than my pretty minor nits, good work!


Thanks,
Corinna
