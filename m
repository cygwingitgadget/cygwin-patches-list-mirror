Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 070BF3858CD1; Thu,  9 Jan 2025 18:58:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 070BF3858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736449088;
	bh=mkRjnwmi+oqIlbF9JzycAgEtH5RPkMykBsnZ7txoi0o=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JEJGJDN6DeYPtj0bLyKXNJuF3V2VyQBU49XBEFPI0GZO1MqMuZk52qWCZUfWZ27Ae
	 3QPQ2agjQJ9xHGyTToa5Fmso9F+oc7jR7PPSIo9ND2R993n4sVSwSKqepXhbVFa0yq
	 cnwf5sQHqus+Msvdv5rKqR5hltLUeDFDRsqHjw9o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D1FE0A80C65; Thu,  9 Jan 2025 19:58:05 +0100 (CET)
Date: Thu, 9 Jan 2025 19:58:05 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: mmap_list::try_map: simplify
Message-ID: <Z4AcPZulCpl7Zb0b@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <980ea390-abbd-4894-b80b-906ac1cca243@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <980ea390-abbd-4894-b80b-906ac1cca243@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan  8 18:04, Ken Brown wrote:
> From c01da9db1e76869621b63f8075505fa49acf0d56 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Sun, 29 Dec 2024 18:20:07 -0500
> Subject: [PATCH 4/5] Cygwin: mmap_list::try_map: simplify
> 
> Save the result of mmap_record::find_unused pages, and then pass that
> result to the appropriate version of mmap_record::map_pages.  Add a
> new parameter of type off_t to the latter to make this possible, and
> change its return from off_t to bool.  This saves map_pages from
> having to call find_unused_pages again.
> 
> Signed-off-by: Ken Brown <kbrown@cornell.edu>
> ---
>  winsup/cygwin/mm/mmap.cc | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

LGTM.

Thanks,
Corinna
