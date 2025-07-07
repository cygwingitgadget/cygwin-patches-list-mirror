Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E674C3857823; Mon,  7 Jul 2025 20:01:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E674C3857823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751918486;
	bh=sxEzwxpDuPeu8XPuVU3E1sNun2pKq+l+pBVrUplkX/A=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=YKriIXCjbVpmPqvPL949krv1Fts6YvhLE0Wgj/EDGBHSTcmgAD7e9AXsjzYJGs+Co
	 1woJ0xrp3bDkJnMlytmV85j+wKttpev7YgN5tHZKzdseEU5lLPALggD0gzMo/S0kRB
	 RH49/vdGJv9D7Xi9U31eIA9rbYNnbLUflkQOH7u0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D3DF4A809E4; Mon, 07 Jul 2025 22:01:24 +0200 (CEST)
Date: Mon, 7 Jul 2025 22:01:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: spawn: apply PID_NEW_PG flag to spawned child
Message-ID: <aGwnlP7zBqmvdUjQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <82c767ad-97d0-ea70-1e1f-2590c8d3a8ca@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82c767ad-97d0-ea70-1e1f-2590c8d3a8ca@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  7 11:33, Jeremy Drake via Cygwin-patches wrote:
> Previously, it was always applied to "myself", which is only appropriate
> in the case of _P_OVERLAY (aka exec).  Apply the flag to "myself" only
> in that case, and apply it to the new child instead in other cases.
> Also, clear the flag from "myself" in the case of a failed exec.
> 
> Fixes: 8d8724ee1b5a ("Cygwin: pty: Fix Ctrl-C handling further for non-cygwin apps.")
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/spawn.cc | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

LGTM.  Please push to both branches.


Thanks,
Corinna
