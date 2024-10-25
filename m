Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ECD2F3858D21; Fri, 25 Oct 2024 08:52:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ECD2F3858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729846375;
	bh=aQLGHQd9fu0N2WinH0BGaSD2pynqW7UMOf1O4idxaHQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=IH8ncLWsQWwKScb7Sq1PeG+3joh2r2TLBklcad6grLh4+eO8s1sOSGrCKN7v0W5Os
	 pntV5Ohb0xIUw4dCfaDG5SLMWqgQGhlsPC9/BnR8la1CvIg/OSnnP/o6AXpEYGbbHa
	 cRNZeM9gJNwmbhvMI30KQLTjNH+svhhM8Zq77X/Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D5DF3A8094B; Fri, 25 Oct 2024 10:52:53 +0200 (CEST)
Date: Fri, 25 Oct 2024 10:52:53 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: lockf: Make lockf() return ENOLCK when too
 many locks
Message-ID: <ZxtcZROzLZLAPQO7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241024085921.7156-1-takashi.yano@nifty.ne.jp>
 <ZxohGlGP4USo-q04@calimero.vinschen.de>
 <20241024232731.bea548d7689b487a380af4be@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024232731.bea548d7689b487a380af4be@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Oct 24 23:27, Takashi Yano wrote:
> On Thu, 24 Oct 2024 12:27:38 +0200
> Corinna Vinschen wrote:
> > On Oct 24 17:59, Takashi Yano wrote:
> > > Previously, lockf() printed a warning message when the number of locks
> > > per file exceeds the limit (MAX_LOCKF_CNT). This patch makes lockf()
> > > return ENOLCK in that case rather than printing the warning message.
> > > 
> > > Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256528.html
> > > Fixes: 31390e4ca643 ("(inode_t::get_all_locks_list): Use pre-allocated buffer in i_all_lf instead of allocating every lock.  Return pointer to start of linked list of locks.")
> > > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/flock.cc | 68 +++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 60 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> > > index 5550b3a5b..b05005dab 100644
> > > --- a/winsup/cygwin/flock.cc
> > > +++ b/winsup/cygwin/flock.cc
> > > @@ -610,17 +614,13 @@ inode_t::get_all_locks_list ()
> > >  	  dbi->ObjectName.Buffer[LOCK_OBJ_NAME_LEN] = L'\0';
> > >  	  if (!newlock.from_obj_name (this, &i_all_lf, dbi->ObjectName.Buffer))
> > >  	    continue;
> > > -	  if (lock - i_all_lf >= MAX_LOCKF_CNT)
> > > -	    {
> > > -	      system_printf ("Warning, can't handle more than %d locks per file.",
> > > -			     MAX_LOCKF_CNT);
> > > -	      break;
> > > -	    }
> > > +	  assert (lock - i_all_lf < MAX_LOCKF_CNT);
> > 
> > Shouldn't that be a <=?  The original test above was off-by-one, right?
> 
> Just after this line,
>       new (lock++) lockf_t (newlock);
> will executed unconditionally. If lock - i_all_lf == MAX_LOCKF_CNT here,
> lock++ will exceed the area allocated by tp.w_get(). Therefore,
> This should not be a "<=".
> 
> > But I still don't get it.  The successful assert() will end the process
> > as well, just like api_fatal.  Shouldn't this situation just return
> > ENOLCK as well, as the commit message suggests?
> 
> If once the number of locks exceeds the MAX_LOCKF_CNT, lf_findoverlap()
> cannot work correctly. This means unlocking also does not work correctly
> for the locks. So, detecting excess at here is too late. We should catch
> the phenomenon before it happens.
> 
> This is done at the points such as:
> 
> @@ -1368,6 +1382,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
>         case 0: /* no overlap */
>           if (needtolink)
>             {
> +             if (lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
> +               return ENOLCK;
>               *prev = lock;
>               lock->lf_next = overlap;
>               lock->create_lock_obj ();
> 
> in this patch. Since this checks the worst case of increment of the locks,
> ENOLCK may be returned before using up the area. For example, the Christian's
> test case gets ENOLCK at 909'th lockf() call even with MAX_LOCKF_CNT == 910,
> i.e. 2 steps before reaching maximum. This two lockf_t space is reserved for
> unlocking because unlocking can increase the total number of locks in the
> case that "overlap contains lock", i.e. ovcase == 2. Even for other cases,
> number of the locks is increased if get_obj_handle_count (lf_obj) > 1.
> 
> Even with these cases, we can return ENOLCK for lockf(F_ULOCK), however
> some of applications do not assume that lockf(F_ULOCK) of the cases
> other than ovcase == 2. For this reason, my patch reserves two lockf_t
> spaces for lockf(F_ULOCK), i.e. lf_clearlock().

Ahhhh, that makes sense.

> It might be better to add these explanation as a comment in the source...

Yes, adding comments to outline this would be great.

With the additional comments, you can just push when you're ready.


Thanks,
Corinna
