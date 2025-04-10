Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EF4A7386587A; Thu, 10 Apr 2025 13:20:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EF4A7386587A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1744291249;
	bh=lqvGn+0kk8vSGJEvGYt8Tk635CnQdVRCMmJVzVKuZrE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=UK96IcQB2BHglPpt4AQV02r9tDE8Si8u7CvS5NMCRUf+TUeqwlgC8O1O8Ki7iza8x
	 E77julL5ATFjcq4qD7Od3hdKBNwKN+6nVQiiniDCWi5DKYFDRxFmDv8yAGtqdNZH+b
	 7QY/imAoiVfIqojCBgWG6z2/DuuNBWZ+9pUb4xUs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4D0CDA80C95; Thu, 10 Apr 2025 15:20:46 +0200 (CEST)
Date: Thu, 10 Apr 2025 15:20:46 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: fhandler_local: Fix get_inet_addr_local to
 retrieve correct type
Message-ID: <Z_fFrlBQ9Wa7MMVM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Z_eg0w3LZD1y9KJb@calimero.vinschen.de>
 <TYCPR01MB109261F895332F0C2ABBCC304F8B72@TYCPR01MB10926.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCPR01MB109261F895332F0C2ABBCC304F8B72@TYCPR01MB10926.jpnprd01.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Apr 10 20:27, Yuyi Wang wrote:
> For a datagram socket received by recvfrom, the type param is not
> assigned correctly, making fhandler_socket_local::connect() to return
> WSAEPROTOTYPE.
> 
> Fixes: 2617a91597ca ("* fhandler_socket.cc (get_inet_addr): Handle abstract AF_LOCAL socket.")
> Signed-Off-by: Yuyi Wang <Strawberry_Str@hotmail.com>
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

Pushed.

Thanks,
Corinna
