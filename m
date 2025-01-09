Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A28203858D34; Thu,  9 Jan 2025 19:18:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A28203858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736450312;
	bh=pxLfozpyps4oSZ7S+XZkGnfog9fZyg5u5uYxWwacItg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ICUeIwkvt+jAesmkHZFFz1wX20OfXaRVS//WLvdW0mkPSG78ZQ7fcvn2aBpUnXiEd
	 ciNINRzVKlWVuhKv69afGrybhRKV2AibEbovKZWmYIrq/x80iV1xT2BBcgdvq7yBqy
	 51Umj+Z8u2t3kHcBdFo3POn5ATu/n31hDZoTxSTY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 031DFA80C65; Thu,  9 Jan 2025 20:18:30 +0100 (CET)
Date: Thu, 9 Jan 2025 20:18:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Cygwin: remove
 winsup/cygwin/local_includes/mmap_helper.h
Message-ID: <Z4AhBn4Wfj2JjU7W@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <22b45a82-79f5-464a-86d4-dbdc10251012@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22b45a82-79f5-464a-86d4-dbdc10251012@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan  8 18:04, Ken Brown wrote:
> From 8c3a918c346a9ae97e219679d780c9b716588fc8 Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Sun, 29 Dec 2024 18:47:54 -0500
> Subject: [PATCH 5/5] Cygwin: remove winsup/cygwin/local_includes/mmap_helper.h
> 
> None of its macros and functions are used anymore.
> 
> Signed-off-by: Ken Brown <kbrown@cornell.edu>
> ---
>  winsup/cygwin/local_includes/mmap_helper.h | 89 ----------------------
>  1 file changed, 89 deletions(-)
>  delete mode 100644 winsup/cygwin/local_includes/mmap_helper.h

LGTM.

Funny.  The patch introducing the header and using these methods has
been reverted right away, on the same day in 2006.  Only the header was
kept intact accidentally.  So we're dragging this unused header with us
for almost 20 years.  Time flies... :)


Thanks,
Corinna

