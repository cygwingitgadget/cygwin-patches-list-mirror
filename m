Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5080A384D173; Fri, 21 Nov 2025 19:04:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5080A384D173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763751890;
	bh=97gAPsiMQ3VcqdqR70VIjxM4SFqFN+M3B/mR33Atcj4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=SdWoDA0zcpCiRU3AM9NpTdFrnc1ZyFawAlCfhYuvXHYZI1wlvKte1acx43iwmJZIo
	 0drN4pvpy/S0SQWOwyZKrX6DdNQZIwgpIcooeX4jPlobutsom4N80KkMPlKFYe+gcV
	 veXT52xbESuHXQo30qv8mfz+NNCAJ8EXT9jRW7HQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 75617A80D1D; Fri, 21 Nov 2025 20:04:48 +0100 (CET)
Date: Fri, 21 Nov 2025 20:04:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Add a configure-time check for minimum w32api
 headers version
Message-ID: <aSC30HAFpdjJ0tFj@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251121132455.8864-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251121132455.8864-1-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Nov 21 13:24, Jon Turney wrote:
> Since we now require w32api-headers >= 13 for the
> AllocConsoleWithOptions() prototype and flags, add a configure-time
> check for that, as I've mused about a couple of times before.
> 
> This maybe gives a more obvious diagnosis of the problem than 'not
> declared' errors, and is perhaps more self-documenting about our
> expectations here.
> 
> After this, most of the other conditionals on __MINGW64_VERSION_MAJOR
> can probably be removed.
> ---
>  winsup/configure.ac | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/winsup/configure.ac b/winsup/configure.ac
> index e7ac814b1..05b5a9897 100644
> --- a/winsup/configure.ac
> +++ b/winsup/configure.ac
> @@ -57,6 +57,23 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
>  AC_CHECK_TOOL(STRIP, strip, strip)
>  AC_CHECK_TOOL(WINDRES, windres, windres)
>  
> +required_w32api_version=13
> +AC_MSG_CHECKING([w32api-headers version])
> +AC_COMPILE_IFELSE([
> +  AC_LANG_SOURCE([[
> +    #include <_mingw.h>
> +
> +    #if __MINGW64_VERSION_MAJOR < $required_w32api_version
> +    #error "w32api-headers version >= $required_w32api_version required"
> +    #endif
> + ]])
> +],[
> +  AC_MSG_RESULT([yes])
> +],[
> +  AC_MSG_RESULT([no, >= $required_w32api_version required])
> +  AC_MSG_ERROR([required w32api-headers version not met])
> +])
> +
>  AC_ARG_ENABLE(debugging,
>  [AS_HELP_STRING([--enable-debugging],[Build a cygwin DLL which has more consistency checking for debugging])],
>  [case "${enableval}" in
> -- 
> 2.51.0

:+1:

Do you have removing the __MINGW64_VERSION_MAJOR conditionals in the loop
as well?


Thanks,
Corinna
