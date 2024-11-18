Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 04FCB3858C62; Mon, 18 Nov 2024 15:55:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 04FCB3858C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1731945323;
	bh=AyoDmCO6blRqS24zP7gfusvg6q+kV8rEt9z6vmSzxtE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=e3DzwkjPBQlZzBUWkbsYoOZtA0TATt2dhXNYmlwVe46rB9DHcFw1k2x4Fgaa3i0Fd
	 oUiRcHwFcILjUNUA5qazVHuh7opQBWXEY4vBvXBbIH/ByvnpElvhto2lzsXIFMbVzo
	 mRgdwb32OMUdYVLw/BUBGgrhYfkSwnDkFw3+kt74=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 77879A814E0; Mon, 18 Nov 2024 16:55:14 +0100 (CET)
Date: Mon, 18 Nov 2024 16:55:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: lockf: Fix access violation in
 lf_clearlock().
Message-ID: <ZztjYs4Cu28xZgtl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
 <20241115131422.2066-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115131422.2066-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 15 22:14, Takashi Yano wrote:
> The commit ae181b0ff122 has a bug that the pointer is referred bofore
> NULL check in the function lf_clearlock(). This patch fixes that.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
> Fixes: ae181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many locks")
> Reported-by: Sebastian Feld <sebastian.n.feld@gmail.com>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/flock.cc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> index 3821bddd6..794e66bd7 100644
> --- a/winsup/cygwin/flock.cc
> +++ b/winsup/cygwin/flock.cc
> @@ -1524,6 +1524,10 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
>    lockf_t *lf = *head;
>    lockf_t *overlap, **prev;
>    int ovcase;
> +
> +  if (lf == NOLOCKF)
> +    return 0;
> +
>    inode_t *node = lf->lf_inode;
>    tmp_pathbuf tp;
>    node->i_all_lf = (lockf_t *) tp.w_get ();
> @@ -1531,8 +1535,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
>    uint32_t lock_cnt = node->get_lock_count ();
>    bool first_loop = true;
>  
> -  if (lf == NOLOCKF)
> -    return 0;
>    prev = head;
>    while ((ovcase = lf_findoverlap (lf, unlock, SELF, &prev, &overlap)))
>      {
> -- 
> 2.45.1

LGTM, please push.

Thanks,
Corinna
