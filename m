Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EB26E3858D20; Mon, 10 Mar 2025 19:19:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EB26E3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741634363;
	bh=/2YOUu4aKHoMfFyaGP/ycbg7QaiIojMEhBbwUx9DArE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=tY2k65yRQXs8qhH7J2XSVXnisoUCziXDp+gVmnF2Qtj72Xm3GD1E75R5MjDtYWeks
	 FbfP1hSeg++fMvorsMY1MhrCCLk+IER3GhLSjz6ap/EIqL8Bvm41hr5EcrT5N4alR+
	 yLw2TQAHeLJK6ihVnICQLWLHK9h/uA0wzDIue+ko=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A94D3A8063F; Mon, 10 Mar 2025 20:15:08 +0100 (CET)
Date: Mon, 10 Mar 2025 20:15:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0
Message-ID: <Z886PJK2OMtcUwEC@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev>
List-Id: <cygwin-patches.cygwin.com>

Hi Chris,

On Mar 10 15:46, Chris Denton wrote:
> This upstreams the msys2 patch:
> https://github.com/msys2/MSYS2-packages/blob/6a02000fd93c6b2001220507e5369a726b6381c4/msys2-runtime/0021-Fix-native-symbolic-link-spawn-passing-wrong-arg0.patch
> 
> Original msys2 issue:
> https://github.com/msys2/MSYS2-packages/issues/1327

Sorry, but not like this. The commit message should describe the problem
and the chosen solution, not just point to some external websites.

It's also missing a Fixes: and a Signed-off-by: line, the latter ideally
from the original author of the patch.

> ---
>  winsup/cygwin/spawn.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 06b84236d..b81ccefb7 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -43,7 +43,7 @@ perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt)
>  
>    err = 0;
>    debug_printf ("prog '%s'", prog);
> -  buf.check (prog, PC_SYM_FOLLOW | PC_NULLEMPTY | PC_POSIX, stat_suffixes);
> +  buf.check (prog, PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP | PC_NULLEMPTY | PC_POSIX, stat_suffixes);

Formatting should try to stick to max. 80 chars per line, please.


Thanks,
Corinna
