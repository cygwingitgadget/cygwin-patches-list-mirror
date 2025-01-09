Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EA5AB3858D34; Thu,  9 Jan 2025 18:57:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EA5AB3858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736449064;
	bh=Bwo3HlaQDyWRLltNdsQRBzLuFLxQvBvb8IyL0qlp+bk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OcX8YgfY36A7YtJrrQgdgiCrPL8XvZXMSwH5cO65zsPzQarkLCv2rxxDO/TqgdZek
	 3LBrbS0P+sf9MMEFwGBlyNXYowaWTBxImTlChTSQa89io/qMAosp/4zXuE2/U6Q5h1
	 mlwF9d9EPaoDi3mNnP0X6t+LkTb7HDB14RoqjkAI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4E69DA80C65; Thu,  9 Jan 2025 19:57:43 +0100 (CET)
Date: Thu, 9 Jan 2025 19:57:43 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/5] Cygwin: mmap: remove __PROT_FILLER and the
 associated methods
Message-ID: <Z4AcJx4KSdyMZ60i@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <dc8fa635-bc5e-4ef4-824a-0d2a73e838bc@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc8fa635-bc5e-4ef4-824a-0d2a73e838bc@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan  8 18:03, Ken Brown wrote:
> From 87e07edb7c53f425c86579d013d29efd3f905203 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Fri, 20 Dec 2024 13:11:22 -0500
> Subject: [PATCH 3/5] Cygwin: mmap: remove __PROT_FILLER and the associated
>  methods
> 
> This is left over from 32 bit Cygwin and is no longer used.
> 
> Signed-off-by: Ken Brown <kbrown@cornell.edu>
> ---
>  winsup/cygwin/mm/mmap.cc | 31 +++++++------------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/winsup/cygwin/mm/mmap.cc b/winsup/cygwin/mm/mmap.cc
> index 13e64c23256c..9e6415de9951 100644
> --- a/winsup/cygwin/mm/mmap.cc
> +++ b/winsup/cygwin/mm/mmap.cc
> @@ -27,14 +27,8 @@ details. */
>     is to support mappings longer than the file, without the file growing
>     to mapping length (POSIX semantics). */
>  #define __PROT_ATTACH   0x8000000
> -/* Filler pages are the pages from the last file backed page to the next
> -   64K boundary.  These pages are created as anonymous pages, but with
> -   the same page protection as the file's pages, since POSIX applications
> -   expect to be able to access this part the same way as the file pages. */
> -#define __PROT_FILLER   0x4000000
> -
> -/* Stick with 4K pages for bookkeeping, otherwise we just get confused
> -   when trying to do file mappings with trailing filler pages correctly. */
> +
> +/* Stick with 4K pages for bookkeeping. */
>  #define PAGE_CNT(bytes) howmany((bytes), wincap.page_size())

LGTM.

Given we don't do filler pages because Windows doesn't let us anyway, we
could switch to 64K allocation_granularity() bookkeeping now, too.


Thanks,
Corinna
