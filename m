Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F16983858D21; Mon, 16 Dec 2024 12:08:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F16983858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1734350895;
	bh=iUULrUJu0/P/qeh22UaZiEjoAFQWQz1o2CRDOO0kz0w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KKRfSoxQqM94qN78ek+uFgFjjpf9qKFoaUrS7KrQQGIguect9B1KJRahHqoGiwIMD
	 rwsBfSHEgcVkxy+TANqdoFB3D1VYwQ3RhErM8fvDfbvspQeAnD0nLcItnn3jq+yV22
	 PEwUr7wVQ71AytCSlQicZR4kot6vqN9YQqzu+X8U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E3881A8088D; Mon, 16 Dec 2024 13:08:13 +0100 (CET)
Date: Mon, 16 Dec 2024 13:08:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: /proc/<PID>/stat: set field (18) according to
 scheduling policy
Message-ID: <Z2AYLcLTL6gz_iw_@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e121cfcb-8e37-7100-76fd-75ee4ca50776@t-online.de>
 <a7d173a9-00d9-9355-a784-6061ad282aa0@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7d173a9-00d9-9355-a784-6061ad282aa0@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec 16 08:48, Christian Franke wrote:
> Christian Franke wrote:
> 
> A slighty changed version is attached. SCHED_IDLE now sets the lowest
> prioritity.
> 
> 
> > 
> > Linux also provides (40) rt_priority and (41) policy. Adding these would
> > require to determine (or fake) fields (26) to (39) first :-)
> > 
> 
> This would also require to decide whether the values of (41) policy should
> be Cygwin (SCHED_OTHER=3) or Linux (...=0) compatible...

Cygwin-compatible.  A tool actually using this feature should check
against SCHED_OTHER of the target system, not the value of a foreign
system or, worse, the constant 0.

> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1348,8 +1348,8 @@ wait_sig (VOID *)
>    /* GetTickCount() here is enough because GetTickCount() - t0 does
>       not overflow until 49 days psss. Even if GetTickCount() overflows,
>       GetTickCount() - t0 returns correct value, since underflow in
> -     unsigned wraps correctly. Pending a signal for more than 49
> -     days makes no sense. */
> +     unsigned wraps correctly. Pending a signal for more thtn 49
> +     days would be noncense. */
>    DWORD t0 = GetTickCount ();
>    for (;;)
>      {

This hunk isn't supposed to be part of the patch, I guess...


Corinna
