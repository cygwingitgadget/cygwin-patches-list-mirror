Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9CD9F3865460; Fri,  7 Jul 2023 09:46:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9CD9F3865460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688723177;
	bh=eVVsVhCuEPNIXhGYWd7T/QHp6LhsVZVc5RKDVkviaik=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=yPl4j/LqlRNRs4ORYfGoZ6XqyD7XEWTd2WSAxhP/lMm4PCsgvCrtXDtiCaBaqiwWL
	 66R9EakcCt1TOYZ7qjHHYKqSiHOyKOIaFv4fR6+0MC57J+GZeiErGfra6Qj44Cgcaa
	 NOHfTUDhK1++gzPtrmEE01FlARhmxCjtr5+ucCG0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E4CDBA80BDA; Fri,  7 Jul 2023 11:46:15 +0200 (CEST)
Date: Fri, 7 Jul 2023 11:46:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: stat(): Fix "Bad address" error on stat()
 for /dev/tty.
Message-ID: <ZKfe55PgjTJwWmIQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
 <20230707033458.1034-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707033458.1034-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jul  7 12:34, Takashi Yano wrote:
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index 18e0f3097..2aae2fd65 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -600,7 +600,13 @@ fh_alloc (path_conv& pc)
>  	case FH_TTY:
>  	  if (!pc.isopen ())
>  	    {
> -	      fhraw = cnew_no_ctor (fhandler_console, -1);
> +	      if (CTTY_IS_VALID (myself->ctty))
> +		{
> +		  if (iscons_dev (myself->ctty))
> +		    fhraw = cnew_no_ctor (fhandler_console, -1);
> +		  else
> +		    fhraw = cnew_no_ctor (fhandler_pty_slave, -1);
> +		}

What happens if CTTY_IS_VALID fails at this point?  There's no
`else' catching that situation?

>  	      debug_printf ("not called from open for /dev/tty");
>  	    }
>  	  else if (!CTTY_IS_VALID (myself->ctty) && last_tty_dev


Thanks,
Corinna
