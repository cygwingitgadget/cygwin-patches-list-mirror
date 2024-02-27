Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B486E3858C78; Tue, 27 Feb 2024 14:59:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B486E3858C78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1709045993;
	bh=Msv35rTniLbMr1T/iXI9Lftm/IiSrYtn/fN6hCftSu4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lmI5zNsXj6n6c0X0XOwF+59hg1dPTD00TIqBB6RFQQ/wvh1lr+hdVtZdwulBzYz1H
	 6hlV9DHrHhhS4tR0bGM/aWblc5xgPKv6f04qaqJQApJapvHhUBVghH3uGuDysVhNmV
	 6rJozUKhPkIKyk/qNaoD+ZXb8xJNxWVwD2zpgGF8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E1999A80A41; Tue, 27 Feb 2024 15:59:51 +0100 (CET)
Date: Tue, 27 Feb 2024 15:59:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: remove ENOSHARE and ECASECLASH from
 _sys_errlist[]
Message-ID: <Zd3457LfikTibhEm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f0c37daf-4086-d5b9-9812-8b15916ad987@t-online.de>
 <ede12d4d-3401-5d68-cfd1-f3aafa6a3394@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ede12d4d-3401-5d68-cfd1-f3aafa6a3394@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,

On Feb 27 13:18, Christian Franke wrote:
> From f495fb0e7c2bd3a42f16f81af18c64ffaba9a860 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Tue, 27 Feb 2024 13:05:36 +0100
> Subject: [PATCH 2/2] Cygwin: remove ENOSHARE and ECASECLASH from
>  _sys_errlist[]
> 
> These errno values are no longer used by Cygwin.  Also add a
> static_assert check for _sys_errlist[] size.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/errno.cc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/errno.cc b/winsup/cygwin/errno.cc
> index 7d58e62ec..d8c057e51 100644
> --- a/winsup/cygwin/errno.cc
> +++ b/winsup/cygwin/errno.cc
> @@ -167,8 +167,8 @@ const char *_sys_errlist[] =
>  /* ESTALE 133 */	  "Stale NFS file handle",
>  /* ENOTSUP 134 */	  "Not supported",
>  /* ENOMEDIUM 135 */	  "No medium found",
> -/* ENOSHARE 136 */	  "No such host or network path",
> -/* ECASECLASH 137 */	  "Filename exists with different case",
> +			  NULL, /* Was ENOSHARE 136, no longer used. */
> +			  NULL, /* Was ECASECLASH 137, no longer used. */

In terms of politenness, wouldn't it be better to define them as
empty strings?  This may be one crash less in already existing
binaries...


Corinna
