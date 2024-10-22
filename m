Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D8A303858D20; Tue, 22 Oct 2024 16:03:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D8A303858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729613024;
	bh=NiRKhn/mA7vpEY9o0aWo1SKiMFPAjxRG0RQsyWpLOzg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=j7Ke3QSkpocOQRdZV+N+f3UHuCcJWGt4z/gKtwmUs3wIfpN+Z24hc9CRNVqT6D8Kf
	 fWDjZBqzXoLTodDbHUrMhPMEHiUgAPDqh/e2k+cMsWHjlby04Si1QYM15KTiH/l6Dw
	 dJl3hX2PVy677y40BJeR1T8R/GT0iiCmX1ruCou0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CEADAA80CE1; Tue, 22 Oct 2024 18:03:42 +0200 (CEST)
Date: Tue, 22 Oct 2024 18:03:42 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: lockf: Fix adding a new lock over multiple
 locks
Message-ID: <ZxfM3tim5uRzgU6J@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241020092650.835-1-takashi.yano@nifty.ne.jp>
 <20241020092650.835-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020092650.835-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Oct 20 18:26, Takashi Yano wrote:
> Previously, adding a new lock by lockf() over multiple existing locks
> failed. This is due to a bug that lf_setlock() tries to create a lock
> that has already been created. This patch fixes the issue.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256528.html
> Fixes: a998dd705576 ("* flock.cc: Implement all advisory file locking here.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/flock.cc | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> index 0f1efa01d..5550b3a5b 100644
> --- a/winsup/cygwin/flock.cc
> +++ b/winsup/cygwin/flock.cc
> @@ -1454,13 +1454,14 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
>  	  /*
>  	   * Add the new lock before overlap.
>  	   */
> -	  if (needtolink) {
> +	  if (needtolink)
> +	    {
>  	      *prev = lock;
>  	      lock->lf_next = overlap;
> -	  }
> +	      lock->create_lock_obj ();
> +	    }
>  	  overlap->lf_start = lock->lf_end + 1;
>  	  lf_wakelock (overlap, fhdl);
> -	  lock->create_lock_obj ();
>  	  overlap->create_lock_obj ();
>  	  break;
>  	}
> -- 
> 2.45.1

LGTM.

Thanks,
Corinna
