Return-Path: <SRS0=lOez=RU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id C66A83858D21
	for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 14:27:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C66A83858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C66A83858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729780061; cv=none;
	b=XycAo8Lfbxi/JmIkQxa6P4G6IsT2mxseNwfc9m/ltmxzk6HSBYlQMKKdihOcdi4wtzB/2CGFp8IQsUfk/+IlkeV8rRziPxSotECPe3VqZhGPwqn9WcgsQvMugW9prx9fdyyw92DJC0smdvZWK6E0ERwIaj+g70Zwb7w7sQUtVSg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729780061; c=relaxed/simple;
	bh=Am1qa+D8wNwfAahMVH7hHhig6C4MvDab7pI6jmm++IE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Ei9bx6e78p8mhmU8bqm75dh5rnlobelj0VcLDw/3v+e5paL7g/L95YfTDb8aCoUfNySGkxzO4YeZn7a1HAngbYJhfWZCtRSyDdthhNZRP4/P2wRymTrm1MXdvh9a2wwhzk4fw/DfTAePDyXyuEna8b5rocwlBDJazJeoyQfkpu4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20241024142733558.TMDW.115271.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 23:27:33 +0900
Date: Thu, 24 Oct 2024 23:27:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: lockf: Make lockf() return ENOLCK when too
 many locks
Message-Id: <20241024232731.bea548d7689b487a380af4be@nifty.ne.jp>
In-Reply-To: <ZxohGlGP4USo-q04@calimero.vinschen.de>
References: <20241024085921.7156-1-takashi.yano@nifty.ne.jp>
	<ZxohGlGP4USo-q04@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1729780053;
 bh=PqWqW29r3vCuq4u6PD4mnb5u4/lbQoBQF9fkkB7JWjg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=reYowuaK2aefseLXsh8wlrRWRB/NB0D3Gc++xFdPyrNFdx9Xh0/iZZjKL4e5cy9xiweT1ziV
 n2UYWq7/37G53WLDn2PZI1goNTtbl5/n23uTPQ9Vjn7W8Qm2yM+8ZqraRj1YyeJvrZFKUCN4aJ
 uJMZ4KOj4Kr8GADTceaxCoGzDsXD92vqhgx8aQPlXxRI6u6u0GFwS6Kl56+00gTGzw1ekWrMQH
 zSd1D0pfXU15Xh6EMIEaKlYTsvxQ9KpHG1QyHuDRz2qlX/LMo9Wk8IbTbniqvQVDGV1m281cxE
 +LA4zYLoTMFlkyT1R3QvVYlpbNdkSheF7oCkS8z2rR0p/tWA==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 24 Oct 2024 12:27:38 +0200
Corinna Vinschen wrote:
> On Oct 24 17:59, Takashi Yano wrote:
> > Previously, lockf() printed a warning message when the number of locks
> > per file exceeds the limit (MAX_LOCKF_CNT). This patch makes lockf()
> > return ENOLCK in that case rather than printing the warning message.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256528.html
> > Fixes: 31390e4ca643 ("(inode_t::get_all_locks_list): Use pre-allocated buffer in i_all_lf instead of allocating every lock.  Return pointer to start of linked list of locks.")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/flock.cc | 68 +++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 60 insertions(+), 8 deletions(-)
> > 
> > diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> > index 5550b3a5b..b05005dab 100644
> > --- a/winsup/cygwin/flock.cc
> > +++ b/winsup/cygwin/flock.cc
> > @@ -610,17 +614,13 @@ inode_t::get_all_locks_list ()
> >  	  dbi->ObjectName.Buffer[LOCK_OBJ_NAME_LEN] = L'\0';
> >  	  if (!newlock.from_obj_name (this, &i_all_lf, dbi->ObjectName.Buffer))
> >  	    continue;
> > -	  if (lock - i_all_lf >= MAX_LOCKF_CNT)
> > -	    {
> > -	      system_printf ("Warning, can't handle more than %d locks per file.",
> > -			     MAX_LOCKF_CNT);
> > -	      break;
> > -	    }
> > +	  assert (lock - i_all_lf < MAX_LOCKF_CNT);
> 
> Shouldn't that be a <=?  The original test above was off-by-one, right?

Just after this line,
      new (lock++) lockf_t (newlock);
will executed unconditionally. If lock - i_all_lf == MAX_LOCKF_CNT here,
lock++ will exceed the area allocated by tp.w_get(). Therefore,
This should not be a "<=".

> But I still don't get it.  The successful assert() will end the process
> as well, just like api_fatal.  Shouldn't this situation just return
> ENOLCK as well, as the commit message suggests?

If once the number of locks exceeds the MAX_LOCKF_CNT, lf_findoverlap()
cannot work correctly. This means unlocking also does not work correctly
for the locks. So, detecting excess at here is too late. We should catch
the phenomenon before it happens.

This is done at the points such as:

@@ -1368,6 +1382,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
        case 0: /* no overlap */
          if (needtolink)
            {
+             if (lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
+               return ENOLCK;
              *prev = lock;
              lock->lf_next = overlap;
              lock->create_lock_obj ();

in this patch. Since this checks the worst case of increment of the locks,
ENOLCK may be returned before using up the area. For example, the Christian's
test case gets ENOLCK at 909'th lockf() call even with MAX_LOCKF_CNT == 910,
i.e. 2 steps before reaching maximum. This two lockf_t space is reserved for
unlocking because unlocking can increase the total number of locks in the
case that "overlap contains lock", i.e. ovcase == 2. Even for other cases,
number of the locks is increased if get_obj_handle_count (lf_obj) > 1.

Even with these cases, we can return ENOLCK for lockf(F_ULOCK), however
some of applications do not assume that lockf(F_ULOCK) of the cases
other than ovcase == 2. For this reason, my patch reserves two lockf_t
spaces for lockf(F_ULOCK), i.e. lf_clearlock().

It might be better to add these explanation as a comment in the source...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
