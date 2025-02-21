Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EEDDF3858D20; Fri, 21 Feb 2025 19:51:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EEDDF3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740167495;
	bh=ygn0cbnophV+o6+MgjAHrYXtc34++Whwo+A0mb4ks3w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=iiXL2kPrH465ov03GHg6RNE0a2Q67asgpdp7uxgDoa0cxMU6uV2Ayt9a/xLXxS7/f
	 UcpLMDxt3dLuy1yf3GtXI464CZo2lL/L03Mf2cbYwtnsQCA0bgX8auLvcCE/D2iMCA
	 9PeZtvax9lDeJxCYBLi8+facX+VEmx6CRYueawxw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 92FBBA80C03; Fri, 21 Feb 2025 20:51:26 +0100 (CET)
Date: Fri, 21 Feb 2025 20:51:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: Fix crash if pid of other
 process is used
Message-ID: <Z7jZPtYFgUa6uqMn@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <afe4a843-643e-1254-e1f2-795d3b52c3ac@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afe4a843-643e-1254-e1f2-795d3b52c3ac@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 21 17:32, Christian Franke wrote:
> Obviously my testcases for the SCHED_* enhancement were incomplete, sorry.
> 
> -- 
> Regards,
> Christian
> 

> From a9e48b5d738c2a683826ab220155778f0f57f003 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Fri, 21 Feb 2025 17:25:51 +0100
> Subject: [PATCH] Cygwin: sched_setscheduler: Fix crash if pid of other process
>  is used
> 
> Add missing PID_MAP_RW to allow changes of _pinfo::sched_policy.
> 
> Fixes: 48b189245a13 ("Cygwin: sched_setscheduler: accept SCHED_OTHER, SCHED_FIFO and SCHED_RR")
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/sched.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pushed.

Thanks,
Corinna
