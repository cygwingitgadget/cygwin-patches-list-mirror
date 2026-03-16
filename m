Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 75AA64BB3B83; Mon, 16 Mar 2026 12:29:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 75AA64BB3B83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773664182;
	bh=OamkvTm0jP2cM4lrm4Rl6rPiEXYF+43R8h3gk6ssxeA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=vO23ye1Cg3B9n4PBEmq+r4mYTO5GrhOa2r0UcLG+vRWXUpVAQKUn8fSil5ImDZanL
	 oduNY2L7kqRziF7IpV4aGHCJVyXEJq4QKvK761WM+ZYhSls7BGumGc5KQVyGzDM1Hq
	 9Nh94XdY3J1PqmoezdjgzhHTvUe+9KoVWYYKadEg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 71AD0A8044E; Mon, 16 Mar 2026 13:29:40 +0100 (CET)
Date: Mon, 16 Mar 2026 13:29:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Quash Windows error text to user on fork() error
Message-ID: <abf3tDlkmkyNDu23@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q1/014745.html>
 <20260314064539.1418-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314064539.1418-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Mar 13 23:44, Mark Geisert wrote:
> For a very long time, since 2011 or earlier, fork() has printed an internal
> error message when it fails due to a CreateProcess() error.  This patch
> quashes the error message as far as the user can tell, but it will still be
> present in an strace.
> 
> This change is a judgement call based on the fact we now support
> RLIMIT_NPROC and so a user limiting the number of subprocesses may hit
> more CreateProcess() errors by design.  Don't clutter the scene.
> 
> Fixes: 855108782321 (* dll_init.c (dll_list::load_after_fork): Don't
> clear in_forkee here.)
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> 
> ---
>  winsup/cygwin/fork.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> index 3e5d81fe4..48e8b7557 100644
> --- a/winsup/cygwin/fork.cc
> +++ b/winsup/cygwin/fork.cc
> @@ -400,6 +400,7 @@ frok::parent (volatile char * volatile stack_here)
>  	{
>  	  this_errno = geterrno_from_win_error ();
>  	  error ("CreateProcessW failed for '%W'", myself->progname);
> +	  ch.silentfail (true);
>  	  dlls.release_forkables ();
>  	  memset (&pi, 0, sizeof (pi));
>  	  goto cleanup;
> -- 
> 2.51.0

This and the typo fix pushed.

Thanks,
Corinna
