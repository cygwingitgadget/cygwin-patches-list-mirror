Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 118DA3858C42; Mon, 14 Jul 2025 13:24:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 118DA3858C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752499454;
	bh=XWH+n0ZmNDa8nc7sJlvi17b6yrBYMMs4jXr3hZbcJfo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=aId0hlAh00cgRRnTHnezzurqQbJ72AQiPrvUTHOnTufL+1GkQhJxNcOXVjdaNnEUB
	 EoLXtqInSnLfBDgSXgIjqGxxvmV5jFn1dPDfUVoZa62B1P5s/yEgZpOIS1Uoustpcu
	 UMg0PJynrDRCG9lWonaswG/ZOhFRWIgkZJlupIOQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 571BCA80864; Mon, 14 Jul 2025 15:24:12 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:24:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: signal: make context structures registers
 handling portable
Message-ID: <aHUE_EOVwKAW33rC@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB09236018A992CBC8F322F009924BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB09236018A992CBC8F322F009924BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 11 13:18, Radek Barton via Cygwin-patches wrote:
> >From 434df1dc447ecb7a8cfd08af5219ce0697877fd5 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Wed, 4 Jun 2025 14:55:34 +0200
> Subject: [PATCH] Cygwin: signal: make context structures registers handling
>  portable
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch extracts macros from winsup/cygwin/exceptions.cc serving for portable
> register access to context structures into a separate local header
> winsup/cygwin/local_includes/register.h and implements their AArch64
> counterparts.
> 
> Then, it adds AArch64 declaration of __mcontext structure based on
> mingw-w64-headers/include/winnt.h header to
> winsup/cygwin/include/cygwin/singal.h header.
> 
> Then, it includes the registers.h header and uses the macros where applicable,
> namely at:
>  - winsup/cygwin/exceptions.cc
>  - winsup/cygwin/profil.c
>  - winsup/cygwin/tread.cc
> 
> The motivation is to make usage of the context structures portable without
> unnecessary #if defined(__x86_64__) while implementations of signal handling
> code will be developed later, e.g. implementation of makecontext.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/exceptions.cc             | 51 ++++++++--------
>  winsup/cygwin/include/cygwin/signal.h   | 77 ++++++++++++++++++++++++-
>  winsup/cygwin/local_includes/register.h | 25 ++++++++
>  winsup/cygwin/profil.c                  |  7 +--
>  winsup/cygwin/thread.cc                 |  3 +-
>  winsup/utils/profiler.cc                |  7 +--
>  6 files changed, 135 insertions(+), 35 deletions(-)
>  create mode 100644 winsup/cygwin/local_includes/register.h

Pushed.

I like this patch a lot.  Good idea to create job-related register macros!


Thanks,
Corinna
