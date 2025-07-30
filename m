Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7E58A3858C50; Wed, 30 Jul 2025 12:21:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7E58A3858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753878060;
	bh=8W+gX/3mDjwbWvDnnanWkUr+XshTKgpiqKRDM+skl4o=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OGT/T0jnOiQVo5t42X5wzqFbkhTxxGnQZpga0GUh3J3zQia2K1ZFQPZPt6Ul32lJ1
	 Z1GU1RKIeCJm+Tz85t8eskOU7c1Etn2+olQfIQUA+cAXDCH+rwNkG6FDeaO0WovexZ
	 xXYEJp81ksr8nE8Can00rmWgli3aPkklS+z0ph4U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AAF09A80BCC; Wed, 30 Jul 2025 14:20:58 +0200 (CEST)
Date: Wed, 30 Jul 2025 14:20:58 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
Message-ID: <aIoOKpzb557bX0cE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 25 16:10, Jeremy Drake via Cygwin-patches wrote:
> A sized delete (with a std::size_t parameter) was added in C++14 (but
> doesn't combine with nothrow_t)
> 
> An aligned new/delete (with a std::align_val_t parameter) was added in
> C++17, and combinations with the sized delete and nothrow_t variants.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> I added #pragma GCC diagnostic ignored "-Wc++17-compat" preemptively to
> cxx.cc to match what was done with c++14-compat with the one sized delete
> that was already present (presumably because it broke things when GCC
> started to emit that instead of the non-sized delete).
> 
> The default new implementation uses calloc, so I'm not sure if it's
> expected that the aligned new call memset to zero the returned memory.
> It'd be easy enough to add if necessary.
> 
> GCC will need to be updated circa
> https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/i386/cygwin-w64.h;h=160a290a03d00f6408252f5d8751fea7cd44e1be;hb=HEAD#l27
> but only after this change is stable because it will cause linker errors
> if the new __wrap symbols are not exported.
> 
> Does there need to be a version bump somewhere to make sure a module
> linked against a new libcygwin.a doesn't run against an old cygwin1.dll,
> resulting in _cygwin_crt0_common.cc writing too much data to
> default_cygwin_cxx_malloc?
> 
>  winsup/cygwin/cxx.cc                      | 120 +++++++++++++++++++++-
>  winsup/cygwin/cygwin.din                  |  12 +++
>  winsup/cygwin/lib/_cygwin_crt0_common.cc  |  59 +++++++++++
>  winsup/cygwin/libstdcxx_wrapper.cc        |  99 ++++++++++++++++++
>  winsup/cygwin/local_includes/cygwin-cxx.h |  14 +++
>  5 files changed, 299 insertions(+), 5 deletions(-)

LGTM.  Please push (to main only, at least for now)


Thanks,
Corinna
