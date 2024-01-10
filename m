Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C90093858C52; Wed, 10 Jan 2024 15:31:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C90093858C52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1704900666;
	bh=fFI+NgNuqb1HygKz7FRn5M2bUODcTHPVmZsLDM5cPPU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ONVIOGtiLGClHvLoN36HYd2dCbQM3lgtltksh8iDIjZM9R7UoLnLIVUgNJCHZ/OwC
	 zTbTZHcZCDHR4hqKSMX9P45wicwiZyk5C0+GMnTnTrjaJ0axy8iDcyOIlxdjwjJ9J4
	 yldtuPjUooPZvFvBV/UOZlehzDgDWxWmPlpHNt+k=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D36EFA80CD0; Wed, 10 Jan 2024 16:31:04 +0100 (CET)
Date: Wed, 10 Jan 2024 16:31:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: Disable writing core dumps by default.
Message-ID: <ZZ64OHkYYM8yBwQ4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240110135705.557-1-jon.turney@dronecode.org.uk>
 <20240110135705.557-3-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110135705.557-3-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 13:57, Jon Turney wrote:
> Change the default core limit from unlimited to 0 (disabled)
> ---
>  winsup/cygwin/mm/cygheap.cc | 2 +-
>  winsup/doc/new-features.xml | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/mm/cygheap.cc b/winsup/cygwin/mm/cygheap.cc
> index a20ee5972..3dc0c011f 100644
> --- a/winsup/cygwin/mm/cygheap.cc
> +++ b/winsup/cygwin/mm/cygheap.cc
> @@ -294,7 +294,7 @@ cygheap_init ()
>        cygheap->locale.mbtowc = __utf8_mbtowc;
>        /* Set umask to a sane default. */
>        cygheap->umask = 022;
> -      cygheap->rlim_core = RLIM_INFINITY;
> +      cygheap->rlim_core = 0;
>      }
>    if (!cygheap->fdtab)
>      cygheap->fdtab.init ();
> diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
> index b6daadc2b..a22b78a60 100644
> --- a/winsup/doc/new-features.xml
> +++ b/winsup/doc/new-features.xml
> @@ -99,6 +99,12 @@ is now written on a fatal error. Otherwise, if it's greater than zero, a text
>  format .stackdump file is written, as previously.
>  </para></listitem>
>  
> +<listitem><para>
> +The default RLIMIT_CORE is now 0, disabling the generation of core dump or
> +stackdump files. Use e.g. <code>ulimit -c unlimited</code> or <code>ulimit -c
> +1024</code> to enable them again.
> +</para></listitem>
> +
>  </itemizedlist>
>  
>  </sect2>
> -- 
> 2.42.1

+1
