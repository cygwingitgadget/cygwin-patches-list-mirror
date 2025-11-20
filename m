Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0457D385703C; Thu, 20 Nov 2025 15:19:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0457D385703C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763651951;
	bh=9Sl7OU7lueAwo5C2qEGkg491pzxuUq7lagbBKJj4FZA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=n43b6f6aUHqy1fFUsNFW30uCzy7jcaEGW9mHy0EKk7x3RXRPnWpqwkvOJ+nBk7CGH
	 uKlIjVAeGw+F4bAQ3CRVVaAjVj8K84xzHRsAWT98DqbJA0eq9K7qxcUapq7WzP3OcJ
	 28Ro4hQE55mqsZaBC1oRt7hKlGUwusvTNAXqdvbQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 273DCA80D9F; Thu, 20 Nov 2025 16:19:09 +0100 (CET)
Date: Thu, 20 Nov 2025 16:19:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add a configure-time check for minimum w32api
 headers version
Message-ID: <aR8xbdiYGjTtY_e7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251120144715.4015-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251120144715.4015-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On Nov 20 14:47, Jon Turney wrote:
> Since we now require w32api-headers >= 13 for the
> AllocConsoleWithOptions() prototype, add a configure-time check for
> that, as I've mused about a couple of times before.
> 
> This maybe gives a more obvious diagnosis of the problem than 'not
> declared' errors, and is perhaps more self-documenting about our
> expectations here.

Good idea.

> After this, most of the other conditionals on __MINGW64_VERSION_MAJOR
> can probably be removed.

Yup.

> ---
>  winsup/configure.ac | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/winsup/configure.ac b/winsup/configure.ac
> index e7ac814b1..4137f93eb 100644
> --- a/winsup/configure.ac
> +++ b/winsup/configure.ac
> @@ -57,6 +57,21 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
>  AC_CHECK_TOOL(STRIP, strip, strip)
>  AC_CHECK_TOOL(WINDRES, windres, windres)
>  
> +AC_MSG_CHECKING([for required w32api-headers version])
> +AC_COMPILE_IFELSE([
> +  AC_LANG_SOURCE([[
> +    #include <_mingw.h>
> +
> +    #if __MINGW64_VERSION_MAJOR < 13
> +    #error "insufficient w32api-headers version"
> +    #endif
> + ]])
> +],[
> +  AC_MSG_RESULT([yes])
> +],[
> +  AC_MSG_ERROR([no])
> +])
> +
>  AC_ARG_ENABLE(debugging,
>  [AS_HELP_STRING([--enable-debugging],[Build a cygwin DLL which has more consistency checking for debugging])],
>  [case "${enableval}" in

One problem here: The error message "no" isn't overly helpful to the
unaware developer because it neglects to mention the version requirement.
If you just run configure, what you get is this:

  checking for required w32api-headers version... configure: error: no

Given that this code is checking for the actual version number, to be
bumped as we go along, it would be helpful to tell the dev which version
is supposed to be installed, isn't it?  


Thanks,
Corinna
