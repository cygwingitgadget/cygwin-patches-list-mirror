Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 107653856942; Thu, 10 Apr 2025 08:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 107653856942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1744274198;
	bh=zhfONDfw2l1kRxo1d5kCA4KDfrSGlRvTxZKCpr5Ld9k=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=b9lPuAC6JNnG8kDGomfCX+Uo+IppY6JDTTaKv92ru4ZMdHJlBvhxNEZZq0yjtKt9O
	 QM1eyQFyHFYuGjQr3scT85/oVnO8BPzAY2MwoSMAYj+2qMnnPLWVrDFW9YPw6ypDRK
	 9r3r+7eiOcnP8HB4c/Ap7HULPABv0xaBsdzmyX6I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AE8BFA80C94; Thu, 10 Apr 2025 10:36:35 +0200 (CEST)
Date: Thu, 10 Apr 2025 10:36:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_local: Fix get_inet_addr_local to
 retrieve correct type
Message-ID: <Z_eDE8Gw7WuGGnuT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <TYCPR01MB10926E79742DCF95AA5CD2928F8B42@TYCPR01MB10926.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCPR01MB10926E79742DCF95AA5CD2928F8B42@TYCPR01MB10926.jpnprd01.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Yuyi,

On Apr  9 23:58, Yuyi Wang wrote:
> For a datagram socket received by recvfrom, the type param is not
> assigned correctly, making fhandler_socket_local::connect() to return
> WSAEPROTOTYPE.
> ---
>  winsup/cygwin/fhandler/socket_local.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/fhandler/socket_local.cc b/winsup/cygwin/fhandler/socket_local.cc
> index 270a1ef31..340a2b33c 100644
> --- a/winsup/cygwin/fhandler/socket_local.cc
> +++ b/winsup/cygwin/fhandler/socket_local.cc
> @@ -87,6 +87,7 @@ get_inet_addr_local (const struct sockaddr *in, int inlen,
>        addr.sin_addr.s_addr = htonl (INADDR_LOOPBACK);
>        *outlen = sizeof addr;
>        memcpy (out, &addr, *outlen);
> +      *type = SOCK_DGRAM;

type is a default parameter and can be NULL.  It's only non-NULL if
called from fhandler_socket_local::connect.  Checking the pointer would
be prudent.


Thanks,
Corinna
