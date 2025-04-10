Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2E392385DDDF; Thu, 10 Apr 2025 10:43:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2E392385DDDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1744281813;
	bh=CuYH5zpfIQEbEmh6n61zphC0zor/xL4aAYBz9Dr/WP0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=b0BV7L/1OvyfETS2M8ISuAIbjFfd9G3sWzfhH+0issQ1czcBr9v9c9QpK/2JSd2kA
	 n+HtSFKz/J9Iaz53dOlBrUynyGCbXmwDhE1VhbYxAYsJwe/jf0GT6Ccf6dwTrophNc
	 JURQQqHK1B5x/3UKfX3zRBXId7BVg1zgFugR4548=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 10480A80C95; Thu, 10 Apr 2025 12:43:31 +0200 (CEST)
Date: Thu, 10 Apr 2025 12:43:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: fhandler_local: Fix get_inet_addr_local to
 retrieve correct type
Message-ID: <Z_eg0w3LZD1y9KJb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Z_eDE8Gw7WuGGnuT@calimero.vinschen.de>
 <TYTPR01MB10923408B508C363BC8979A6CF8B72@TYTPR01MB10923.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYTPR01MB10923408B508C363BC8979A6CF8B72@TYTPR01MB10923.jpnprd01.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Yuyi,

On Apr 10 17:11, Yuyi Wang wrote:
> For a datagram socket received by recvfrom, the type param is not
> assigned correctly, making fhandler_socket_local::connect() to return
> WSAEPROTOTYPE.
> ---
>  winsup/cygwin/fhandler/socket_local.cc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/socket_local.cc b/winsup/cygwin/fhandler/socket_local.cc
> index 270a1ef31..ea5ee67cc 100644
> --- a/winsup/cygwin/fhandler/socket_local.cc
> +++ b/winsup/cygwin/fhandler/socket_local.cc
> @@ -87,6 +87,8 @@ get_inet_addr_local (const struct sockaddr *in, int inlen,
>        addr.sin_addr.s_addr = htonl (INADDR_LOOPBACK);
>        *outlen = sizeof addr;
>        memcpy (out, &addr, *outlen);
> +      if (type)
> +	*type = SOCK_DGRAM;
>        return 0;
>      }

Thanks, that's better.  Would you mind sending a v3 with the following
additional entries in the commit message?

Fixes: 2617a91597ca ("* fhandler_socket.cc (get_inet_addr): Handle abstract AF_LOCAL socket.")
Signed-Off-by: <you>


Thanks,
Corinna
