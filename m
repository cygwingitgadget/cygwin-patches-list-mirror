Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 763363858D26; Wed, 26 Feb 2025 16:13:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 763363858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740586405;
	bh=GtNFLIJVjbV5dtFtNckHPv6fhz27VyczTfo9xV6oJx4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=tzerBORdcOTCuKWqRAoAG8B845gXCtp/yTGP2KeBOJ2AiM4g8pOQ97Q3tuZM1sbuv
	 VVyRK9fvZSRkriI7NFSshh7mC5ol3/53mfd99ye1nPtzYDW4f0wwtuwAtBoUIN6aCu
	 bxI10/2K0QYq9GJ8QX0DL7jm16C9QkgRiVW4cUNI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6E04DA80905; Wed, 26 Feb 2025 17:13:23 +0100 (CET)
Date: Wed, 26 Feb 2025 17:13:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Add spawn family of functions to docs
Message-ID: <Z789o-abSInykDk_@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013423.html>
 <20250226063815.52755-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226063815.52755-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

a few points:

On Feb 25 22:37, Mark Geisert wrote:
> In the doc tree, add a new section "Other system interfaces[...]" that
> lists the spawn family of functions, most of the exposed cygwin internal
> functions that a user might have use for, and some other functions
> duplicating Windows or DOS interfaces that might have some utility.
> 
> ---
>  winsup/doc/posix.xml | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 43e860b0d..b9443eaae 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -1762,6 +1762,41 @@ ISO®/IEC DIS 9945 Information technology
>  
>  </sect1>
>  
> +<sect1 id="std-other"><title>Other system interfaces, some from Windows:</title>
> +
> +<screen>
> +    _alloca			(Windows)

Uhm... yeah, we export this symbol.  Because it's (incorrectly) used by
some apps like cmake.  They should use alloca which translates to
__builtin_alloca in GCC, but... well...  OTOH, do we really WANT to
expose this via our docs?  I think no.

> +    _feinitialise

_feinitialise is internal only and called from the DLL init code.
We export this symbol only for old applications, see Cygwin's fenv.c.

> +    _get_osfhandle		(Windows)
> +    _pipe			(Windows)

We export _pipe, but I don't remember why, and it's not in any
header.  We shouldn't document it.

Looks good, otherwise.


Thanks,
Corinna
