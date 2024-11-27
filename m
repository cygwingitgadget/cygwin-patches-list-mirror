Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C956B3858D35; Wed, 27 Nov 2024 15:40:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C956B3858D35
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732722012;
	bh=y2vhPAkUk4gdu0HPFtYSro/0rKEIVjK9eiHTZmszHMM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ivK70L5XC+N/txKxajr59y+qCWEWOSKAD1x7vzLYP/2/M+a2My05qyxtSmfVyS/8J
	 rnt1RHD3Xn2sexy+pAPBLZVq6bYJB0ieRS4Gx9e5ihiYvlEXpO5QeSishem6exnySy
	 amU6uxwF7Vj5k/FyaM0eUHprTegsXQZjzvKqPB0U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0C304A80E4D; Wed, 27 Nov 2024 16:40:08 +0100 (CET)
Date: Wed, 27 Nov 2024 16:40:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: setpriority, sched_setparam: fail if Windows
 sets a lower priority
Message-ID: <Z0c9V2PwRmfqJrfE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <b34f5c79-b703-7862-c2c3-5cbc0f8dad5c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b34f5c79-b703-7862-c2c3-5cbc0f8dad5c@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 10:39, Christian Franke wrote:
> A minor improvement of POSIX emulation.
> 
> -- 
> Regards,
> Christian
> 

> From 7d089e109f32fe44f331ca142e8dc8747f0e9db3 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Wed, 27 Nov 2024 10:26:38 +0100
> Subject: [PATCH] Cygwin: setpriority, sched_setparam: fail if Windows sets a
>  lower priority
> 
> Windows silently sets a lower priority than requested if the new priority
> requires administrator privileges.  Revert to previous priority and fail
> with EACCES or EPERM in this case.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/local_includes/miscfuncs.h |  1 +
>  winsup/cygwin/miscfuncs.cc               | 29 ++++++++++++++++++++++++
>  winsup/cygwin/release/3.6.0              |  5 ++++
>  winsup/cygwin/sched.cc                   |  2 +-
>  winsup/cygwin/syscalls.cc                |  4 ++--
>  5 files changed, 38 insertions(+), 3 deletions(-)

Pushed.


Thanks,
Corinna

