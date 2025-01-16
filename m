Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 52100384D19A; Thu, 16 Jan 2025 18:40:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 52100384D19A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737052819;
	bh=CO8414pej9HhD5rSuz4gsUizdPsq+QWm9lP5Vies0T8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Kp0/nr/Iuw57U4Zx/wA8AJfcXywg5zpJ/rNWF0SBnK6rytwv/WX4oJmnarOG16Agi
	 WP2OXoK0kkDTZRY8KHOuDGmcMaZnU4tLocbNcQyL0esr2zcXxVmxmNOhx8YZqz9doz
	 HC9UELe45q9B97yz1UjCrJ47mSGMo9Itq+0sO0hg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B0592A80DAA; Thu, 16 Jan 2025 19:40:17 +0100 (CET)
Date: Thu, 16 Jan 2025 19:40:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
Message-ID: <Z4lSkZYfY83rpCCv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <8351d131d2aae253f9172f723484f6f6ffa564d9.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8351d131d2aae253f9172f723484f6f6ffa564d9.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 15 12:39, Brian Inglis wrote:
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 949333b0c36c..0b23a2251028 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -16,6 +16,9 @@ ISO/IEC DIS 9945 Information technology
>  - Issue 8.</para>
>  
>  <screen>
> +    CMPLX			(available in "complex.h" header)
> +    CMPLXF			(available in "complex.h" header)
> +    CMPLXL			(available in "complex.h" header)

As I wrote before, we don't need these hints.  They only make sense
if they are provided by another package than cygwin-devel, and then...

> +    atomic_compare_exchange_strong		(available in "stdatomic.h" header)

...it should be noted like this:

> +    atomic_compare_exchange_strong		(available in external "gcc-g++" package)
> [...]
> +    kill_dependency		(available in GCC "stdatomic.h" header)

However... it's questionable, if the availability via the compiler
itself, is really worth to be mentioned.  After all, you can't build
without that package anyway.  So if you installed cygwin-devel, you
also installed gcc-g++ compulsorily.

So I would not add a hint to standard symbols defined by the compiler
package itself.

> +    be16toh			(available in "endian.h" header)
> +    be32toh			(available in "endian.h" header)
> [...]

Part of Cygwin, no hint here.

> +    bind_textdomain_codeset	(available in external gettext "libintl" library)
> +    bindtextdomain		(available in external gettext "libintl" library)
> [...]

Either "gettext" or "libintl", not both.

> +    getentropy			(Cygwin DLL)
> +    getlocalename_l		(Cygwin DLL)
> +    in6addr_any			(Cygwin DLL)
> +    in6addr_loopback		(Cygwin DLL)
> +    posix_getdents		(Cygwin DLL)

Erm?  Why do you mention that?

> +    pthread_cleanup_pop		(available in "pthread.h" header)
> +    pthread_cleanup_push	(available in "pthread.h" header)

No hint here.


Thanks,
Corinna
