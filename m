Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0F9BC3858D35; Mon, 21 Jul 2025 13:59:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0F9BC3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753106370;
	bh=51nry6bQ9obkFfff0GR+AsUo0ObULyAAjHI55e2tjYI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cT9thHC1pqEg7LDTrnUN7+Ox24Wt3T2Tfn/xYW9sQEb7CwVQKlqVLWKvwzWd/KLye
	 OM8jf+AH0O47Otb+8MKtA1jS+NJbzaHAosUe4uz74Y7EdDgfIsLUq/iTolSZWUXpqC
	 5Tax6BccJC4pCm+Zt+SYqdOeh3C+R2sU5X/5OQms=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 31395A80CE5; Mon, 21 Jul 2025 15:59:23 +0200 (CEST)
Date: Mon, 21 Jul 2025 15:59:23 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/3] Cygwin: spawn: Lock cygheap from
 refresh_cygheap() until child_copy()
Message-ID: <aH5HuxuSf_3FELo6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
 <20250721134628.2908-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721134628.2908-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul 21 22:46, Takashi Yano wrote:
> ...completion in child process because the cygheap should not be
> changed to avoid mismatch between child_info::cygheap_max and
> ::cygheap_max. Otherwise, child_copy() might copy cygheap being
> modified by other process.
> 
> Fixes: 977ad5434cc0 ("* spawn.cc (spawn_guts): Call refresh_cygheap before creating a new process to ensure that cygheap_max is up-to-date.")
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/spawn.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index cb58b6eed..fd623f4c5 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -542,7 +542,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
>        if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
>  	c_flags |= CREATE_NEW_PROCESS_GROUP;
> -      refresh_cygheap ();
>  
>        if (mode == _P_DETACH)
>  	/* all set */;
> @@ -611,6 +610,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  
>        cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
>  
> +      cygheap->lock ();
> +      refresh_cygheap ();
>        wchar_t wcmd[(size_t) cmd];
>        if (!::cygheap->user.issetuid ()
>  	  || (::cygheap->user.saved_uid == ::cygheap->user.real_uid
> @@ -844,6 +845,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	/* Just mark a non-cygwin process as 'synced'.  We will still eventually
>  	   wait for it to exit in maybe_set_exit_code_from_windows(). */
>  	synced = iscygwin () ? sync (pi.dwProcessId, pi.hProcess, INFINITE) : true;
> +      cygheap->unlock ();
>  
>        switch (mode)
>  	{
> -- 
> 2.45.1

GTG

Thanks,
Corinna
