Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DAE084BAE7FB; Wed, 11 Mar 2026 15:07:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DAE084BAE7FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773241677;
	bh=6GbLRp+uWgAcNV0mMqKkICGcWpuI3856vGQHUT3XdyU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OUBOZczeSnDOdSFgSvFFQhZfWEkcf8m8akPtJC8GFzPXpu3cVx+wjTcvxh3y6yNSs
	 bVJDQ/z4Pe90HppkZpRJIaKxj/Vf+YHX/QBMVc9btlcFZP1VRJwRi81THG8zUPBQ0L
	 NcdxJNzgVyr3oHRkR0cPglFLCswTrgR+FV+SpjCs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E9042A80859; Wed, 11 Mar 2026 16:07:55 +0100 (CET)
Date: Wed, 11 Mar 2026 16:07:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Change mappings of Windows ERROR*QUOTA*
Message-ID: <abGFS3eYD45mhAdc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q1/014707.html>
 <20260305105320.36284-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305105320.36284-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Mar  5 02:52, Mark Geisert wrote:
> While testing the new rlimit implementation, it was noticed fork()
> returns an EIO error on hitting the process count limit.  Per POSIX,
> the error should be EAGAIN.  This patch makes the change.
> 
> Along the way it was noticed Windows ERROR_DISK_QUOTA_EXCEEDED was not
> being mapped to any POSIX error.  This patch changes the mapping to EFBIG.
> 
> Addresses: https://cygwin.com/pipermail/cygwin-patches/2026q1/014707.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: c2f6c0415501 (Cygwin: errmap[]: update comments using current winerror.h)
> 
> ---
>  winsup/cygwin/local_includes/errmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pushed.  Thanks for your thorough review of my rlimit patches.

Does this patch of yours automatically fix the problem that

251204 [main] forker 7130 dofork: child -1 - CreateProcessW failed for ...

is printed to the tty?  If not, I'm looking forward to your patch
fixing that.


Thanks,
Corinna
