Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 046E2385DDDC; Wed,  2 Jul 2025 12:14:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 046E2385DDDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751458466;
	bh=tBIZVe+eRX9guNUhPaBhmHtpmivZROakCtsnSI4Z+0w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RLU0ZsXl9yedJB/fReCNOXNt1qNGrWUI36SaQH8KB+UZgpenqr+gSlmraHAmJSt02
	 SKEpZzacP/+fe9ne0UO3mWzsNEv9+Gs1hpBvopa+4Ujw1cT6n2dV6kcNeS+4dI6Q4v
	 U/PvGrFZRDNmY3Nv4P4WGbcNJhhlqQ2gQ/tAQAe0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E848BA80CFD; Wed, 02 Jul 2025 14:14:23 +0200 (CEST)
Date: Wed, 2 Jul 2025 14:14:23 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/6] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <aGUinzcfN90Sj8sJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <eb1ac9d3-350b-1df4-72ea-bcfe4861ceaf@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb1ac9d3-350b-1df4-72ea-bcfe4861ceaf@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  1 16:42, Jeremy Drake via Cygwin-patches wrote:
> stdin and stdout were alreadly allowed for popen, but implementing
> posix_spawn in terms of spawn would require stderr as well.
> 
> Replace the conveniently-located 4 filler bytes with int __stderr so
> that child_info_spawn doesn't have to grow.
> 
> Introduce a struct for passing additional args to ch_worker.spawn, since
> there are getting to be quite a lot of additional args.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/cygwin/dcrt0.cc                    |  2 ++
>  winsup/cygwin/local_includes/child_info.h | 16 ++++++++++++---
>  winsup/cygwin/spawn.cc                    | 25 ++++++++++++-----------
>  winsup/cygwin/syscalls.cc                 | 14 ++++++-------
>  4 files changed, 35 insertions(+), 22 deletions(-)

This patch is ok-ish.  I suggested another layout of the
child_info_spawn::worker args in opther mail to this list, maybe you
want to discuss this...

Thanks,
Corinna
