Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4D6ED4BA9035; Mon,  2 Feb 2026 17:17:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4D6ED4BA9035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770052621;
	bh=DxIlwT+AKZZTy44GGEa767IxC27KMAeOK/0w9lvYDTk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VJ/WVzH9Qc+ILhdQTAeII0ZMVYkyWwKY9rb9XkpcZa4/qbaH0sWUUljEhDKWhvMhh
	 kHvijhp36Ydq1NXKCcaEMmYdr/K/j/fS/HjA5+qF7wz+IO7r4MvwwDpVy9VHEyiRU/
	 nXHAu/Dw0WHpsDqikKXy4F2I7+QvNHzF4i9EEW+c=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6B94CA80543; Mon, 02 Feb 2026 18:16:59 +0100 (CET)
Date: Mon, 2 Feb 2026 18:16:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_socket::fchown: fix check for admin user
Message-ID: <aYDcC2nBl0hAVI7D@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260126102559.382483-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126102559.382483-1-corinna-cygwin@cygwin.com>
List-Id: <cygwin-patches.cygwin.com>

On Jan 26 11:25, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> This has never worked as desired.  The check for admin permissions
> is broken.  The call to check_token_membership() expects a PSID
> argument.  What it gets is a pointer to a cygpsid.  There's no
> class-specific type conversion for this to a PSID, so the pointer
> is converted verbatim.
> 
> Pass the cygpsid directly, because cygpsid has a type conversion
> method to PSID defined.
> 
> Pity that GCC doesn't warn here...
> 
> Fixes: 859d215b7e00 ("Cygwin: split out fhandler_socket into inet and local classes")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/fhandler/socket.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/socket.cc b/winsup/cygwin/fhandler/socket.cc
> index c0cef7d3eeb1..0e1fb1bd25f1 100644
> --- a/winsup/cygwin/fhandler/socket.cc
> +++ b/winsup/cygwin/fhandler/socket.cc
> @@ -258,7 +258,7 @@ fhandler_socket::fchmod (mode_t newmode)
>  int
>  fhandler_socket::fchown (uid_t newuid, gid_t newgid)
>  {
> -  bool perms = check_token_membership (&well_known_admins_sid);
> +  bool perms = check_token_membership (well_known_admins_sid);
>  
>    /* Admin rulez */
>    if (!perms)
> -- 
> 2.52.0

Pushed.
