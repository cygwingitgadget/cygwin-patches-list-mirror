Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 79EC43857704; Mon, 25 Nov 2024 11:33:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 79EC43857704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732534439;
	bh=YNhce6v6Q167daxX/BHqKCyMhkwtolnSbTduNMHgC5c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mIg4NkKVacaeW8OCW6jYD5e0mdafDmWOkDd/CpSNUqVi9+EVcU1/7VEfS0PyMpx0I
	 lUuXM8Jms1SqfhaOjDzkGSeYBmWhLkMiLpxa9cuBLOyoKR89VrBMtrqtcO176pSDAX
	 2Ric+w3VP6B7n+tpT9PkRXjtAvsi0k+cgAHu6wDM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 749E3A80B7F; Mon, 25 Nov 2024 12:33:57 +0100 (CET)
Date: Mon, 25 Nov 2024 12:33:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
Message-ID: <Z0RgpZA35z9S-ksG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4df78487-fdbd-7b63-d7ab-92377d44b213@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Christian,


can you please add a Fixes: to the commit messages of both
of your patches?

On Nov 23 19:56, Christian Franke wrote:
> sched_setscheduler(pid, sched_getscheduler(pid), param) should behave like
> sched_setparam(pid, param).
> 
> -- 
> Regards,
> Christian
> 

> From a67e6679cc2bb199713b1f783d5219cb8364f5f4 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Sat, 23 Nov 2024 19:50:29 +0100
> Subject: [PATCH] Cygwin: sched_setscheduler: allow changes of the priority
> 
> Behave like sched_setparam() if the requested policy is identical
> to the fixed value (SCHED_FIFO) returned by sched_getscheduler().
> 

Fixes: ...?

> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/release/3.6.0 | 3 +++
>  winsup/cygwin/sched.cc      | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Thanks,
Corinna
