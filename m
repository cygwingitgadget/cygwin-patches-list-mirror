Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 681F73858D21; Mon, 13 Jan 2025 12:58:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 681F73858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736773105;
	bh=PH5MpeYoBbB8SkFsjkiPnbWoyO7ELPPsRB/vl9s2Iqk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZHdnq5RZXxEG0Lba1phWwxMbKXHzQHypthCvg4SYGoGWTAx6ivmoqfJtR6SShweX6
	 a9rUSTBBSM50sq6XhO7P3+Vx6KxJ0JuiMjnTqZ/2eJAvVITEjgqCC94g4tyfpOGDfk
	 +nOulzqKZNzLaulAKldeXfYBMhZQiVY/BiWdPiIM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C5B01A80A67; Mon, 13 Jan 2025 13:58:23 +0100 (CET)
Date: Mon, 13 Jan 2025 13:58:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Message-ID: <Z4UN78IouepuUwme@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <b02f73ea85c1a9e6cd1a7ebc116fde12f5f6ccc4.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b02f73ea85c1a9e6cd1a7ebc116fde12f5f6ccc4.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 17:01, Brian Inglis wrote:
> Add unavailable POSIX additions to Not Implemented section,
> with mentions of headers and packages where they are expected.
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>  winsup/doc/posix.xml | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 17c9ebf6f73f..2e14861802bf 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -1678,9 +1678,17 @@ ISO/IEC DIS 9945 Information technology
>  
>  </sect1>
>  
> -<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single Unix Specification, Volume 7:</title>
> +<sect1 id="std-notimpl"><title>NOT implemented system interfaces from the Single UNIX® Specification Version 5:</title>
>  
>  <screen>
> +    CMPLX			(not available in "complex.h" header)
> +    CMPLXF			(not available in "complex.h" header)
> +    CMPLXL			(not available in "complex.h" header)

Erm... did you have a look into newlib/libc/include/complex.h?

Also, don't add the "(not available ..." stuff if the API is supposed to
be implemented and exported by newlib/Cygwin.

> +    dcgettext_l			(not available in external gettext "libintl" library)
> +    dcngettext_l		(not available in external gettext "libintl" library)
> +    dgettext_l			(not available in external gettext "libintl" library)
> +    dngettext_l			(not available in external gettext "libintl" library)

...so in case of these libintl functions, it's ok, of course.

> +    kill_dependency		(not available in "stdatomic.h" header)

This is in /usr/lib/gcc/x86_64-pc-cygwin/12/include/c++/bits/atomic_base.h


Corinna
