Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3B78D3858D21; Thu, 24 Oct 2024 10:27:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3B78D3858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729765660;
	bh=mUa90Yy8h3URJ5c+oxidS5jJBrSj+yPN4o9ZBTpbAog=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=nTXvM3CFIJtNubMgjdCar1+CN+tP817i8n+Rijn07oEi4zROewxp7jVXET/UcXZUA
	 I+Zbnt+fHNAEf3nIZpzOcWGXJJdrNAslE21enWKhJrgc685VMuITLzIOo7babDqAsf
	 CfLvG2m3EI2iypU8sEEV6wy5VtHQ9i+44XLNTsVw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1E387A80965; Thu, 24 Oct 2024 12:27:38 +0200 (CEST)
Date: Thu, 24 Oct 2024 12:27:38 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: lockf: Make lockf() return ENOLCK when too
 many locks
Message-ID: <ZxohGlGP4USo-q04@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241024085921.7156-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024085921.7156-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Oct 24 17:59, Takashi Yano wrote:
> Previously, lockf() printed a warning message when the number of locks
> per file exceeds the limit (MAX_LOCKF_CNT). This patch makes lockf()
> return ENOLCK in that case rather than printing the warning message.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256528.html
> Fixes: 31390e4ca643 ("(inode_t::get_all_locks_list): Use pre-allocated buffer in i_all_lf instead of allocating every lock.  Return pointer to start of linked list of locks.")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/flock.cc | 68 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> index 5550b3a5b..b05005dab 100644
> --- a/winsup/cygwin/flock.cc
> +++ b/winsup/cygwin/flock.cc
> @@ -610,17 +614,13 @@ inode_t::get_all_locks_list ()
>  	  dbi->ObjectName.Buffer[LOCK_OBJ_NAME_LEN] = L'\0';
>  	  if (!newlock.from_obj_name (this, &i_all_lf, dbi->ObjectName.Buffer))
>  	    continue;
> -	  if (lock - i_all_lf >= MAX_LOCKF_CNT)
> -	    {
> -	      system_printf ("Warning, can't handle more than %d locks per file.",
> -			     MAX_LOCKF_CNT);
> -	      break;
> -	    }
> +	  assert (lock - i_all_lf < MAX_LOCKF_CNT);

Shouldn't that be a <=?  The original test above was off-by-one, right?

But I still don't get it.  The successful assert() will end the process
as well, just like api_fatal.  Shouldn't this situation just return
ENOLCK as well, as the commit message suggests?


Thanks,
Corinna
