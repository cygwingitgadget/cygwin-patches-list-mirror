Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 53EC8385828B; Mon, 13 Jan 2025 11:04:38 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9A24DA80A67; Mon, 13 Jan 2025 12:04:36 +0100 (CET)
Date: Mon, 13 Jan 2025 12:04:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
Message-ID: <Z4TzRLHGdvcxfT_y@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92eb753b-055a-4171-a1d0-56bc8572d174@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 16:18, Ken Brown wrote:
> Patch attached.
> 
> This turned out to be completely trivial, unless I'm missing something. I
> tested it with several programs that use mmap, and it seems OK.
> 
> Ken

> From 654e5c83da077b67683a1aefd79a414ed6067e51 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Fri, 10 Jan 2025 14:39:46 -0500
> Subject: [PATCH] Cygwin: mmap: use 64K pages for bookkeeping
> 
> It was convenient to use pages of size 4K (Windows page size) for
> bookkeeping when we were using filler pages.  But all references to
> filler pages were removed in commit ceda26c9d35b ("Cygwin: mmap:
> remove __PROT_FILLER and the associated methods"), so this is no
> longer necessary.  Switch to using pages of size 64K (Windows
> allocation granularity) for everything.
> 
> Signed-off-by: Ken Brown <kbrown@cornell.edu>
> ---
>  winsup/cygwin/mm/mmap.cc | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Sounds good to me.


Thanks,
Corinna
