Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 338E63858D39; Thu, 19 Dec 2024 10:17:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 338E63858D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1734603472;
	bh=0t8AzVNl1zTTUmt7nHK/Ljhf1xB+1H2p/JxuSwRKN1Q=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=piIspEK6uVkCfl+mMSRFPDQnXBJmrXLwhA/P3vLYmp1iY8GkbVTg/GT2brzXJL5gL
	 LDlXOh+91WXz0KBexpctNh4xqHcd5HqdP9envUHTYJHBzd4C1DfqXsMzt9uEm64nt2
	 k/U+G6/DNzYiHXvBsIko5p9Aa5fSpgAlD2pnfPKA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8F363A8096C; Thu, 19 Dec 2024 11:17:49 +0100 (CET)
Date: Thu, 19 Dec 2024 11:17:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mmap fixes
Message-ID: <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

I'm replying to your "Fixes" question right here.

On Dec 18 12:16, Ken Brown wrote:
> The two attached patches fix the bugs reported in
> 
>  https://cygwin.com/pipermail/cygwin/2024-December/256911.html
> 
> and
> 
>   https://cygwin.com/pipermail/cygwin/2024-December/256913.html
> 
> The second one is still under discussion on the cygwin list and may turn out
> to be wrong.
> 
> Ken

> From a8ce46ae4353988827a2d646b63d14a6abb8bc90 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Wed, 18 Dec 2024 11:39:31 -0500
> Subject: [PATCH 1/2] Cygwin: mmap: fix protection when unused pages are
>  recycled
> 
> Previously, when unused pages from an mmap_record were recycled, they
> were given the protection of the mmap_record rather than the
> protection requested in the mmap call.  Fix this by adding a "prot"
> parameter to mmap_list::try_map and mmap_record::map_pages to keep
> track of the requested protection.  Then use prot in the call to
> VirtualProtect.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256911.html
> Fixes: ??

Fixes: f90e23f2714cb ("*autoload.cc (NtCreateSection): Define.")

Darn the old CVS entries...

The patch looks good.  I just wonder if the new argument should be
called "new_prot" or "req_prot" to say a bit stronger that this
overrides the old prot... 

Anyway, LGTM.

I'm not quite sure with the second patch, though...

> From c09bc8669696aeb6fd75e2e715d7859f94af6ad2 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Wed, 18 Dec 2024 11:43:09 -0500
> Subject: [PATCH 2/2] Cygwin: mmap_list::try_map: fix a condition in a test of
>  an mmap request
> 
> In testing whether the requested area is contained in an existing
> mapped region, an incorrect condition was used due to a
> misinterpretation of the u_addr and u_len variables.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256913.html
> Fixes: ?

Fixes: c68de3a262fe5 ("* mmap.cc (class mmap_record): Declare new map_pages method with address parameter.")

> Signed-off-by: Ken Brown <kbrown@cornell.edu>
> ---
>  winsup/cygwin/mm/mmap.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
> index a2041ce63d45..8dd93230e69c 100644
> --- a/winsup/cygwin/mm/mmap.cc
> +++ b/winsup/cygwin/mm/mmap.cc
> @@ -648,7 +648,7 @@ mmap_list::try_map (void *addr, size_t len, int prot, int flags, off_t off)
>  	  break;
>        if (rec)
>  	{
> -	  if (u_addr > (caddr_t) addr || u_addr + len < (caddr_t) addr + len
> +	  if (u_addr > (caddr_t) addr || u_len < len
>  	      || !rec->compatible_flags (flags))

While this is strictly correct, I wonder if this shouldn't be

  if (u_addr > (caddr_t) addr || u_addr + u_len < (caddr_t) addr + len ...

for plain readability.  The problem is, you can't see what match()
really returns, an intersection or the entire free region.  That's
what I stumbled over in the cygwin ML.

This way, the code immediately tells the reader that we want to make
sure that [addr,addr+len] is a region completely inside the region
[u_addr,u_addr+u_len], without needing to know what exactly match()
returns.  And it would still be correct, even if we redefine match().

What do you think?


Thanks,
Corinna
