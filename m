Return-Path: <SRS0=VJJm=6A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:28])
	by sourceware.org (Postfix) with ESMTPS id 786D73858031
	for <cygwin-patches@cygwin.com>; Mon, 24 Nov 2025 13:59:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 786D73858031
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 786D73858031
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:28
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763992779; cv=none;
	b=wjXwIJphErk8Mi2KAyY9Axl+mGE4B44062mRk31q2eytuHSQfD/2pWFCzwDY8qPGzA5V/0sDkJdZm8hg5IO+6mfNPL0giTVS+GymFZ+6yjE+1y4NI0XH3mJYArvzdErpJtRQPbNZhQPhIRgmrHy7ZnXhcPcFfmuVPwbZNXNo6Es=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763992779; c=relaxed/simple;
	bh=jPG7dK+O6L6QrH47LNOr7DCS95wzF0CjBli9bBLDwpk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=UxYXB3u765nGQj1vS73HTLfWpmoFkz1meFiyvet99QlPWUKRpOlcSkHCPwwUgAKxhLaORkTHapyO48S0A36P4d+NUH9F0WCExWfJrA2/Xb4JZIWBBgTdGN1KLkIVSJzYe9lrgr6vB4klj9N2JVuJ0SHI88Dwr/2ASkI4BLgumcI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 786D73858031
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=eT5d4nx4
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20251124135936720.MPIC.78984.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 24 Nov 2025 22:59:36 +0900
Date: Mon, 24 Nov 2025 22:59:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already
 released
Message-Id: <20251124225933.b32dd342d5d0795dee496e8d@nifty.ne.jp>
In-Reply-To: <20251124223546.9d3e2b5085fb2d71dca3479f@nifty.ne.jp>
References: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
	<aSRKB6KpYHIViSD_@calimero.vinschen.de>
	<aSRY7wyUJFby7XHZ@calimero.vinschen.de>
	<20251124223546.9d3e2b5085fb2d71dca3479f@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763992776;
 bh=kI1JQmYlGSBEZJq7Kwz2g3GzODTCO8HcA8vjbcQtLXw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=eT5d4nx4EndEot06AhGdSVj6c7npyOkwZ/OnuunwA7ogwOErZSr42cs5xiZzLrdnf41TiF4B
 ggPSC4EoXEODOmuVEFmXatfbcjw5eDNuaMdFC0t0WTaLqG3x2zrBxX+OvVK1PdW6icJd8uBH8e
 rHUmgiI3D74ZsNKq737WzxkNelVatvTYp9x+HZQyOE54lmOyQTPLCT18lvUoFGzQcyZjJFS3NZ
 9FCAx4CYBqMC1CQeeDZ6DxhHNeTU2LuozRguoBk7jrpfyVC4VhmfWCGHNJPtiDYdX5j2ljVEJW
 iLGjalhZ+q+SVll3cnDw8RTcDbzEujNIR8Rq2bwKZWYCNrvw==
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 24 Nov 2025 22:35:46 +0900
Takashi Yano wrote:
> Hi Corinna,
> 
> On Mon, 24 Nov 2025 14:09:03 +0100
> Corinna Vinschen wrote:
> > On Nov 24 13:05, Corinna Vinschen wrote:
> > > So I wonder...
> > > 
> > > Wouldn't this simple patch just moving the tmp_pathbuf up into
> > > fhandler_base::lock() fix the problem just as well, plus avoiding
> > > multiple w_get() calls?
> > 
> > Version 2 of the patch.  Rather than calling get_all_locks_list()
> > from lf_setlock() *and* lf_clearlock(), call it right from
> > fhandler_base::lock() to avoid calling the function twice.
> > Also, move comment.
> > 
> > diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> > index e03caba27a8e..e486ad7f5ece 100644
> > --- a/winsup/cygwin/flock.cc
> > +++ b/winsup/cygwin/flock.cc
> > @@ -945,6 +945,7 @@ fhandler_base::lock (int a_op, struct flock *fl)
> >  {
> >    off_t start, end, oadd;
> >    int error = 0;
> > +  tmp_pathbuf tp;
> >  
> >    short a_flags = fl->l_type & (F_OFD | F_POSIX | F_FLOCK);
> >    short type = fl->l_type & (F_RDLCK | F_WRLCK | F_UNLCK);
> > @@ -1149,6 +1150,9 @@ restart:	/* Entry point after a restartable signal came in. */
> >        return -1;
> >      }
> >  
> > +  /* Create temporary space for the all locks list. */
> > +  node->i_all_lf = (lockf_t *) tp.w_get ();
> > +
> >    switch (a_op)
> >      {
> >      case F_SETLK:
> > @@ -1157,6 +1161,11 @@ restart:	/* Entry point after a restartable signal came in. */
> >        break;
> >  
> >      case F_UNLCK:
> > +      /* lf_clearlock() is called from here as well as from lf_setlock().
> > +	 lf_setlock() already calls get_all_locks_list(), so we don't call it
> > +	 from lf_clearlock() but rather here to avoid calling the (potentially
> > +	 timeconsuming) function twice if called through lf_setlock(). */
> > +      node->get_all_locks_list ();
> >        error = lf_clearlock (lock, &clean, get_handle ());
> >        lock->lf_next = clean;
> >        clean = lock;
> > @@ -1218,7 +1227,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
> >    lockf_t **head = lock->lf_head;
> >    lockf_t **prev, *overlap;
> >    int ovcase, priority, old_prio, needtolink;
> > -  tmp_pathbuf tp;
> >  
> >    /*
> >     * Set the priority
> > @@ -1229,8 +1237,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
> >    /*
> >     * Scan lock list for this file looking for locks that would block us.
> >     */
> > -  /* Create temporary space for the all locks list. */
> > -  node->i_all_lf = (lockf_t *) (void *) tp.w_get ();
> >    while ((block = lf_getblock(lock, node)))
> >      {
> >        HANDLE obj = block->lf_obj;
> > @@ -1543,9 +1549,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
> >      return 0;
> >  
> >    inode_t *node = lf->lf_inode;
> > -  tmp_pathbuf tp;
> > -  node->i_all_lf = (lockf_t *) tp.w_get ();
> > -  node->get_all_locks_list (); /* Update lock count */
> >    uint32_t lock_cnt = node->get_lock_count ();
> >    bool first_loop = true;
> >  
> > @@ -1631,10 +1634,7 @@ static int
> >  lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl)
> >  {
> >    lockf_t *block;
> > -  tmp_pathbuf tp;
> >  
> > -  /* Create temporary space for the all locks list. */
> > -  node->i_all_lf = (lockf_t *) (void * ) tp.w_get ();
> >    if ((block = lf_getblock (lock, node)))
> >      {
> >        if (block->lf_obj)
> 
> Thanks. Your patch looks better than mine, however, this
> does not fix the second error in the report; i.e.,
> 
> tmp_dir: /tmp/flockRsYGNU
> done[7]
> done[3]
> lock error: 14 - Bad address: 3
> assertion "lock_res == 0" failed: file "main.c", line 40, function: thread_func
>                                                                                Aborted
> 
> while mine does. I'm not sure why...

fhandler_base::lock() seems necessary to be reentrant for the original
test case, because, your v2 patch + making i_all_lf local variable
solves the issue. Please see my v2 patch.

What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
