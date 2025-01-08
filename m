Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1777F3858D28; Wed,  8 Jan 2025 15:34:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1777F3858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736350448;
	bh=izHbK0C9LGkgjJm3A1Xvz2Vg0ekFRKLLeJuytzmFHhg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=p16IcIWx478Ss/fwDv6p25IYq2b+d3ekpOavZT1v9D/GFNMKK3iBJRfUeuyE737VV
	 mwghdDYSr5BqIrMVoc81BuIVGM0fxcwfVx8Q3EjJyKladKVxyPIfklJQ0z0BjZFueY
	 Hw3gzyst5gHPChhkLBMfHrCftl6s7fqjMAEJGdFo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 44202A805BC; Wed,  8 Jan 2025 16:34:06 +0100 (CET)
Date: Wed, 8 Jan 2025 16:34:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Some mmap code cleanup
Message-ID: <Z36a7hMUUE3qKQEb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <934687ad-4ad9-4b41-a252-005033cd2e65@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <934687ad-4ad9-4b41-a252-005033cd2e65@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

any chance you could resend the patches as a patch series with a single
patch per email?  It would be nice if we could review and, if necessary,
discuss the patches independently of each other.  git send-email usually
does that for you.


Thanks,
Corinna


On Dec 30 14:44, Ken Brown wrote:
> Patches attached.
> 
> Ken Brown (5):
>   Cygwin: mmap: refactor mmap_record::match
>   Cygwin: mmap: remove is_mmapped_region()
>   Cygwin: mmap: remove __PROT_FILLER and the associated methods
>   Cygwin: mmap_list::try_map: simplify
>   Cygwin: remove winsup/cygwin/local_includes/mmap_helper.h
> 
>  winsup/cygwin/local_includes/mmap_helper.h |  89 ---------------
>  winsup/cygwin/local_includes/winsup.h      |   1 -
>  winsup/cygwin/mm/mmap.cc                   | 126 +++++++--------------
>  3 files changed, 44 insertions(+), 172 deletions(-)
>  delete mode 100644 winsup/cygwin/local_includes/mmap_helper.h
> 
> -- 
> 2.45.1
