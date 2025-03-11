Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EC70F3858C5F; Tue, 11 Mar 2025 10:44:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EC70F3858C5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741689852;
	bh=5jwrbQ/DWkk8LYnTh3CMulMRTNMRKSOhWQe30FHttJw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=miiD0BgxNkNeJ6jwX87nJXyrnzBXPoCKB/9ynzqbYHs5qqwd3e2UyiPYSDRHBT3VZ
	 Fd4pjpDKptdM1oJwO0aeImcHgsX+6pxBiuM1kg2CkSolWQNfSnRmdzh7cmBqETpqhN
	 /MuiL5WNBlrDVfKb6WGWwi/RFSYoh6mjot/3E9nY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DCB24A8067E; Tue, 11 Mar 2025 11:44:10 +0100 (CET)
Date: Tue, 11 Mar 2025 11:44:10 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Chris Denton <chris@chrisdenton.dev>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0
Message-ID: <Z9AT-rlIU0StWEzQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Chris Denton <chris@chrisdenton.dev>,
	cygwin-patches@cygwin.com
References: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev>
 <Z886PJK2OMtcUwEC@calimero.vinschen.de>
 <19581e3058e.ebf97e1e733524.5029218649132507579@chrisdenton.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19581e3058e.ebf97e1e733524.5029218649132507579@chrisdenton.dev>
List-Id: <cygwin-patches.cygwin.com>

Hi Chris,

On Mar 10 21:08, Chris Denton wrote:
> Currently when starting a process from bash via a native symlink, argv[0] is
> set to the realpath of the executable and not to the link name. This patch fixes
> it so the path of the symlink is seen instead.
> 
> The cause is a path conversion in perhaps_suffix which follows native
> symlinks. Hence the fix this patch uses is to add PC_SYM_NOFOLLOW_REP when
> calling path_conv::check to prevent that.
> 
> Fixes: 1fd5e000ace55 ("import winsup-2000-02-17 snapshot")

This was a bit of a puzzler for me, given we added the PC_SYM_NOFOLLOW_REP
only 2011 with commit be371651146c ("* path.cc (path_conv::check): Don't
follow reparse point symlinks if PC_SYM_NOFOLLOW_REP flag is set.")

I think we should use this patch for the "Fixes:" info.

> Signed-off-by: SquallATF <squallatf@gmail.com>

Hmm, on second thought, we can't do that.

Given you provide your own version of this patch, and given that this is
a trivial patch, I would prefer your personal Signed-off-by.

If you just agree here on the list, I will do the above changes manually.
No reason to send another patch version.

Ok?


Thanks,
Corinna


> ---
>  winsup/cygwin/spawn.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 06b84236d..ef175e708 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -43,7 +43,9 @@ perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt)
>  
>    err = 0;
>    debug_printf ("prog '%s'", prog);
> -  buf.check (prog, PC_SYM_FOLLOW | PC_NULLEMPTY | PC_POSIX, stat_suffixes);
> +  buf.check (prog,
> +	     PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP | PC_NULLEMPTY | PC_POSIX,
> +	     stat_suffixes);
>  
>    if (buf.isdir ())
>      {
> -- 
> 2.48.1.windows.1
> 
> 
> 
> ---- On Mon, 10 Mar 2025 19:15:08 +0000 Corinna Vinschen  wrote ---
> 
>  > Hi Chris, 
>  >  
>  > On Mar 10 15:46, Chris Denton wrote: 
>  > > This upstreams the msys2 patch: 
>  > > https://github.com/msys2/MSYS2-packages/blob/6a02000fd93c6b2001220507e5369a726b6381c4/msys2-runtime/0021-Fix-native-symbolic-link-spawn-passing-wrong-arg0.patch 
>  > > 
>  > > Original msys2 issue: 
>  > > https://github.com/msys2/MSYS2-packages/issues/1327 
>  >  
>  > Sorry, but not like this. The commit message should describe the problem 
>  > and the chosen solution, not just point to some external websites. 
>  >  
>  > It's also missing a Fixes: and a Signed-off-by: line, the latter ideally 
>  > from the original author of the patch. 
>  >  
>  > > --- 
>  > >  winsup/cygwin/spawn.cc | 2 +- 
>  > >  1 file changed, 1 insertion(+), 1 deletion(-) 
>  > > 
>  > > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc 
>  > > index 06b84236d..b81ccefb7 100644 
>  > > --- a/winsup/cygwin/spawn.cc 
>  > > +++ b/winsup/cygwin/spawn.cc 
>  > > @@ -43,7 +43,7 @@ perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt) 
>  > > 
>  > >    err = 0; 
>  > >    debug_printf ("prog '%s'", prog); 
>  > > -  buf.check (prog, PC_SYM_FOLLOW | PC_NULLEMPTY | PC_POSIX, stat_suffixes); 
>  > > +  buf.check (prog, PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP | PC_NULLEMPTY | PC_POSIX, stat_suffixes); 
>  >  
>  > Formatting should try to stick to max. 80 chars per line, please. 
>  >  
>  >  
>  > Thanks, 
>  > Corinna 
>  > 
