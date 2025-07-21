Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 054F33858D1E; Mon, 21 Jul 2025 14:02:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 054F33858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753106559;
	bh=1LM9YshmUesrLuB3n9IHBD7MqA6DUmD69uKy1Jxo3HQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=IJmeFXfFSQNQNpoP60fhHNJ/IWwEzi7yIFRAaKjDBG7AIsi6iZcXP2zi7/aUJui0E
	 WkMUc99HFb5C1arhVaVwp5VU/LewWZwWpGkt0wsPaCenuUHXagMEaynfNci43mOZAU
	 VlctdbNEPsY1YM594Yaa+lzSXYcueKEfCC+vovHw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 01F2DA80DCD; Mon, 21 Jul 2025 16:02:37 +0200 (CEST)
Date: Mon, 21 Jul 2025 16:02:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/3] Cygwin: spawn: Make system() thread-safe
Message-ID: <aH5IfBPIxgdb01AU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
 <20250721134628.2908-4-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721134628.2908-4-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul 21 22:46, Takashi Yano wrote:
> POSIX states system() shall be thread-safe, however, it is not in
> current cygwin. This is because ch_spawn is a global and is shared
> between threads. With this patch, system() uses ch_spawn_local
> instead which is local variable. popen() has the same problem, so
> it has been fixed in the same way.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258324.html
> Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot")
> Reported-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/spawn.cc    | 3 ++-
>  winsup/cygwin/syscalls.cc | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index fd623f4c5..c057f7ebd 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -950,6 +950,7 @@ spawnve (int mode, const char *path, const char *const *argv,
>    if (!envp)
>      envp = empty_env;
>  
> +  child_info_spawn ch_spawn_local;
>    switch (_P_MODE (mode))
>      {
>      case _P_OVERLAY:
> @@ -963,7 +964,7 @@ spawnve (int mode, const char *path, const char *const *argv,
>      case _P_WAIT:
>      case _P_DETACH:
>      case _P_SYSTEM:
> -      ret = ch_spawn.worker (path, argv, envp, mode);
> +      ret = ch_spawn_local.worker (path, argv, envp, mode);
>        break;
>      default:
>        set_errno (EINVAL);
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index d6a2c2d3b..83a54ca05 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -4535,8 +4535,9 @@ popen (const char *command, const char *in_type)
>        fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
>  
>        /* Start a shell process to run the given command without forking. */
> -      pid_t pid = ch_spawn.worker ("/bin/sh", argv, environ, _P_NOWAIT,
> -				   __std[0], __std[1]);
> +      child_info_spawn ch_spawn_local;
> +      pid_t pid = ch_spawn_local.worker ("/bin/sh", argv, environ, _P_NOWAIT,
> +					 __std[0], __std[1]);
>  
>        /* Reinstate the close-on-exec state */
>        fcntl (stdchild, F_SETFD, stdchild_state);
> -- 
> 2.45.1

GTG.

Am I the only one who thinks it's weird that popen() maintains its own
call to ch_spawn_local.worker, while system() calls spawnve with its
very own _P_SYSTEM spawn mode?  The obvious difference is that
popen has to pass over two file descriptors, but still...

Well, never mind that for now, just a stray thought.


Thanks,
Corinna
