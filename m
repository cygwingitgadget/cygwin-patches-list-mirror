Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F0DFD3872709; Tue, 14 Nov 2023 10:53:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F0DFD3872709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699959238;
	bh=DSqT70JUYbJ1cT/mn9Jf/qxxU+a8U5CrWPWvmVy4clo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=W4fOXBcocFD6MTNR3yxr3X6pxzQ2i+AgwfMGVDZNDcu6S9HEveAw0suNTIG4R3EaD
	 Pb8FsbJAVHR6bmIJRT1pQEWtFsmaYpeHPahvRPDh/Zo3eFuFI1in6oTiyUHDb+LaGl
	 yQr6eYSJHP3xL5m8ZaAv4OYGqcYCiVZJQrYf6z0o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 56F7EA80A38; Tue, 14 Nov 2023 11:53:57 +0100 (CET)
Date: Tue, 14 Nov 2023 11:53:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Fix profiler error() definition and usage
Message-ID: <ZVNRxadU2jUfQKiQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20231114085844.6875-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231114085844.6875-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 14 00:58, Mark Geisert wrote:
> Minor updates to profiler and gmondump, which share some code:
> - fix operation of error() so it actually works as intended
> - resize 4K-size auto buffer reservations to BUFSIZ (==1K)
> - remove trailing '\n' from 2nd arg on error() calls everywhere
> - provide consistent annotation of Windows error number displays
> 
> Fixes: 9887fb27f6126 ("Cygwin: New tool: profiler")
> Fixes: 087a3d76d7335 ("Cygwin: New tool: gmondump")
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> 
> ---
>  winsup/cygwin/release/3.4.10 |  3 +++
>  winsup/utils/gmondump.c      |  8 ++++---
>  winsup/utils/profiler.cc     | 46 +++++++++++++++++++-----------------
>  3 files changed, 32 insertions(+), 25 deletions(-)

Pushed.


Thanks,
Corinna
