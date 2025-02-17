Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 604233858D21; Mon, 17 Feb 2025 10:22:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 604233858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739787722;
	bh=o2GylwFBlJt06BsNufKyHsb9SeIPhaK9Nv6bHksWLYM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OnlP3dtpU40qMK5Myvq/EI8Ej6ywK90yLDxWU4oIzt5MZ2I4E0ntOiLA63JcqoGWL
	 0azdJW1MzaLeyGqSkB35WMIeDU13sDItCjOAIkAM4VvDcyPCEYr+QhhmFvGotxP8ue
	 2t+7XvfaxK2EeIaWqePUNdhflxobtOOGsGef8t3U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5B49EA817D5; Mon, 17 Feb 2025 11:22:00 +0100 (CET)
Date: Mon, 17 Feb 2025 11:22:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add spawn family of functions to docs
Message-ID: <Z7MNyLzVvY_Mm_bH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250216214657.2303-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250216214657.2303-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 16 13:46, Mark Geisert wrote:
> In the doc tree, change the title of section "Other UNIX system
> interfaces..." to "Other system interfaces...".  Add the spawn family of
> functions noting their origin as Windows.
> 
> The title change seems warranted as neither the spawn family of
> functions nor the listed clock_setres() function originated from UNIX
> systems.
> 
> ---
>  winsup/doc/posix.xml | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Yeah, this is probably the right thing to do.  I'm jsut waiting
for Brian in terms of the POSIX doc update.  That's why I wait with
the eaccess and acl functions as well.


Thanks,
Corinna
