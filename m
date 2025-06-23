Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3606C388935D; Mon, 23 Jun 2025 08:42:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3606C388935D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750668143;
	bh=rstWWBAp/HRMqys62B8y6Mfg+0Sh2OLOh5f1WiP0A/g=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OptN9UtAko6vIfn6aNCeQ6yEgjfcPn9v6hLU2gpQvuv/ytPigzGN3A3llr4x1HoqQ
	 ql7OAd5OHwFHjeUwYcdLXd/37jj/Q9+PiRkIyiGZ8xpBQCfFcIKzhTMOT0i6QvbMo+
	 vNDeDAI4JDZ0hSxTFj3ALIcKSLnm5lSXoVBZV5lQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 123F5A80D72; Mon, 23 Jun 2025 10:42:21 +0200 (CEST)
Date: Mon, 23 Jun 2025 10:42:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: winsup/cygwin/include/asm/socket.h: add
 SO_REUSEPORT
Message-ID: <aFkTbV61qw06knEv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6f703b770ddd29e5c174622ae1570761a8a52a92.1750525279.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f703b770ddd29e5c174622ae1570761a8a52a92.1750525279.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

On Jun 21 11:02, Brian Inglis wrote:
> SO_REUSEPORT is defined in BSDs, Solaris, and Linux (since 3.9).
> It is not available in Windows but S.O. articles suggest

S.O.?

-v, please?

If there's this articel, it might be a good idea to add a link to it
in the commit message.


Thanks,
Corinna


> SO_REUSEADDR|SO_BROADCAST works similarly on Windows, so define as such.
> Required to build nghttp2 1.66.
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>  winsup/cygwin/include/asm/socket.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/include/asm/socket.h b/winsup/cygwin/include/asm/socket.h
> index 276df3a0b5fd..d65dc41a0d5d 100644
> --- a/winsup/cygwin/include/asm/socket.h
> +++ b/winsup/cygwin/include/asm/socket.h
> @@ -72,5 +72,8 @@ details. */
>  #define SO_ERROR        0x1007          /* get error status and clear */
>  #define SO_TYPE         0x1008          /* get socket type */
>  
> +#define SO_REUSEPORT  (SO_REUSEADDR | SO_BROADCAST)
> +				/* allow local port reuse - synth on Windows */
> +
>  #endif /* _ASM_SOCKET_H */
>  
> -- 
> 2.45.1
