Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 63B86385E005; Wed, 15 Jan 2025 12:24:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 63B86385E005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736943877;
	bh=Zz/D9VIHHTrJEOEb3ZPaUpT66stSm43xNaKShmHQdBE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=b0FWUJ+Imtj2t7vtupEd22oNu/DaGY/RaqiHyVFvKaPYNeXLdolI5GpSBuiFxzX+/
	 lG8R+T0+fZ2KskhLypr+SOoscj8aHscVVMVLbUjG+4akddFOd2SXmLDIxJuHnwE2WI
	 kgljXhvuX4Nent7TrJgo6LZcJrCBc3IaYA+4tk5M=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 013D8A80D2F; Wed, 15 Jan 2025 13:24:33 +0100 (CET)
Date: Wed, 15 Jan 2025 13:24:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 3/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Message-ID: <Z4epAbWGD7cMCDfU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <b02f73ea85c1a9e6cd1a7ebc116fde12f5f6ccc4.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UN78IouepuUwme@calimero.vinschen.de>
 <ba870968-a3ce-4732-8276-7dabd7a167b2@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba870968-a3ce-4732-8276-7dabd7a167b2@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 13 11:01, Brian Inglis wrote:
> On 2025-01-13 05:58, Corinna Vinschen wrote:
> But not in a standard Cygwin gcc 12 build which uses:
> 
> $ grep -A2 kill_ /usr/lib/gcc/x86_64-pc-cygwin/12/include/stdatomic.h
> #define kill_dependency(Y)			\
>   __extension__					\
>   ({						\
>     __auto_type __kill_dependency_tmp = (Y);	\
>     __kill_dependency_tmp;			\
>   })
> 
> and I missed checking earlier and qualifies? :^<
> 
> Should I change those comments to "available in" and qualify stdatomic.h
> with GCC or lib/gcc?

CMPLX doesn't need any qualifier.  The stuff from gcc should be noted as
from the gcc package, yes.


Corinna
