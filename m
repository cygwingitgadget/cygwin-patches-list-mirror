Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9F4FC3858D34; Thu,  9 Jan 2025 18:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F4FC3858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736447416;
	bh=LhxjJxADKKWE5Ifb0M5XKY8cpUjRpJj3slGOx4U8Eeg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=p8o2qL5GE4rKY0Xy0LGDQ33f1lEpbLlBOlUcy9Oyuq+xnNTcSM7Zo6/Xx9/TCVw+W
	 KamzY5XDJq7GYGoN9N+5JUeHFfSZqtFeVEqgRaqKf9Cf+G0gZPTjKsVvdwBfhYSWQ6
	 x+eaq5U0zQi4GgmZjkPrtcc/1yZQxRhuJpXKMQvs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C8E4BA80C65; Thu,  9 Jan 2025 19:30:14 +0100 (CET)
Date: Thu, 9 Jan 2025 19:30:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] Cygwin: mmap: remove is_mmapped_region()
Message-ID: <Z4AVtkCRMHwBi4Gv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <37f2bead-dd87-490b-82d1-ecb0854b50ef@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37f2bead-dd87-490b-82d1-ecb0854b50ef@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Jan  8 18:03, Ken Brown wrote:
> From d3c62d48f87044d7607d81559c58ae06df5839af Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Fri, 20 Dec 2024 12:17:34 -0500
> Subject: [PATCH 2/5] Cygwin: mmap: remove is_mmapped_region()
> 
> The last use was removed in commit 29a126322783 ("Simplify stack
> allocation code in child after fork").
> 
> Signed-off-by: Ken Brown <kbrown@cornell.edu>
> ---
>  winsup/cygwin/local_includes/winsup.h |  1 -
>  winsup/cygwin/mm/mmap.cc              | 34 ---------------------------
>  2 files changed, 35 deletions(-)

LGTM.


Thanks,
Corinna

