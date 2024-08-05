Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 893CA3858401; Mon,  5 Aug 2024 10:22:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 893CA3858401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1722853333;
	bh=SJfkQnOz94CcqJNlh3Bxdj5+ilhElkYREf4cQG4WNCU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JaEP2mL4wtBg2SDOafJhSejJ9466ATJXKGNEmn19Gw2XK542CTZmyJprLQcCjGtsS
	 Hi86GCiTi458x8XtNOtJ7RXNC5yYRtbPnffOLPDwY0qP+9MtjpbIHiYy5eMeakOxsY
	 6azt1NkyY/+bjEhmC+RirQNwyEvMfu4tKhYB4lvs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 72496A807E3; Mon,  5 Aug 2024 12:22:11 +0200 (CEST)
Date: Mon, 5 Aug 2024 12:22:11 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/6] Cygwin: Fix warnings about narrowing conversions of
 socket ioctls
Message-ID: <ZrCn00PXmRT77OKj@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-6-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240804214829.43085-6-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Aug  4 22:48, Jon Turney wrote:
> Fix gcc 12 warnings about narrowing conversions of socket ioctl constants
> when used as case labels, e.g:
> 
> > ../../../../src/winsup/cygwin/net.cc: In function ‘int get_ifconf(ifconf*, int)’:
> > ../../../../src/winsup/cygwin/net.cc:1940:18: error: narrowing conversion of ‘2152756069’ from ‘long int’ to ‘int’ [-Wnarrowing]
> ---
>  winsup/cygwin/net.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
> index 08c584fe5..b76af2d19 100644
> --- a/winsup/cygwin/net.cc
> +++ b/winsup/cygwin/net.cc
> @@ -1935,7 +1935,7 @@ get_ifconf (struct ifconf *ifc, int what)
>  	{
>  	  ++cnt;
>  	  strcpy (ifr->ifr_name, ifp->ifa_name);
> -	  switch (what)
> +	  switch ((long int)what)
>  	    {
>  	    case SIOCGIFFLAGS:
>  	      ifr->ifr_flags = ifp->ifa_ifa.ifa_flags;
> -- 
> 2.45.1

The only caller, fhandler_socket::ioctl, passes an unsigned int
value to get_ifconf. Given how the value is defined, it would be
more straightforward to convert get_ifconf to

  get_ifconf (struct ifconf *ifc, unsigned int what);

wouldn't it?


Thanks,
Corinna
