Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D9BCC4BB5900; Mon,  2 Feb 2026 17:17:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D9BCC4BB5900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770052644;
	bh=ZRd4BYWjHElCBEhtJLQpi/q+io5UAcU7W/9k4nYMoX8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KNpRdeBT7TvUEyE10MrONNKHyuy/Fcw59iVN3AY8PQI3iTw7/ojIm8TSlSl/gqzvv
	 tzz4kDBsgfPOY3QRaih0MaymXrZGQywdZdao1SO/mKfNsgjfc7Ax67RrkpSDlhR0zh
	 UDdwsKMYDMcPsGcuzyDK+LdLMQtHz7YQDkqu1YSs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 271A1A80543; Mon, 02 Feb 2026 18:17:23 +0100 (CET)
Date: Mon, 2 Feb 2026 18:17:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: spawn: drop CREATE_SEPARATE_WOW_VDM process flag
Message-ID: <aYDcI9Be6Bw3Z75a@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260126102711.382814-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126102711.382814-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Jan 26 11:27, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> This is outdated and should have been removed when we dropped
> 32 bit support.
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/spawn.cc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 7d993d0810eb..04e4a4028b8a 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -401,7 +401,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>        c_flags = GetPriorityClass (GetCurrentProcess ());
>        sigproc_printf ("priority class %d", c_flags);
>  
> -      c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT;
> +      /* Per MSDN, this must be specified even if lpEnvironment is set to NULL,
> +	 otherwise UNICODE characters in the parent environment are not copied
> +	 correctly to the child.  Omitting it may scramble %PATH% on non-English
> +	 systems. */
> +      c_flags |= CREATE_UNICODE_ENVIRONMENT;
>  
>        /* Add CREATE_DEFAULT_ERROR_MODE flag for non-Cygwin processes so they
>  	 get the default error mode instead of inheriting the mode Cygwin
> -- 
> 2.52.0

Pushed.
