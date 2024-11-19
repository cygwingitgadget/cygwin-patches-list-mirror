Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2FA103858CDA; Tue, 19 Nov 2024 09:49:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2FA103858CDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732009781;
	bh=uG1MdLV55fesDYWqhRe/sTEsrFjdlC37z4fPGxzeSYs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=xltC6S+fvwLkkzOL+6OZ2c85LLkpDYk0YacrS5ltz0h2GcABqosEaLET1xgPYTvcj
	 xC+VHcbunpyk3mhxgAGi1aYo078KUeGC5IeaX4v+zRj291izojBTbzdu92Cx4QqSBa
	 CxAg60Lxu+cLmvKXSeTSXp0Tp8go91RzBadpMjIA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 267C2A80A6B; Tue, 19 Nov 2024 10:49:39 +0100 (CET)
Date: Tue, 19 Nov 2024 10:49:39 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: lockf: Fix access violation in
 lf_clearlock().
Message-ID: <ZzxfM9T2uy5Bdiao@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
 <20241115131422.2066-2-takashi.yano@nifty.ne.jp>
 <ZztjYs4Cu28xZgtl@calimero.vinschen.de>
 <20241119173939.5ba0cb14459b3da22d226262@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119173939.5ba0cb14459b3da22d226262@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 19 17:39, Takashi Yano wrote:
> On Mon, 18 Nov 2024 16:55:14 +0100
> Corinna Vinschen wrote:
> > On Nov 15 22:14, Takashi Yano wrote:
> > > The commit ae181b0ff122 has a bug that the pointer is referred bofore
> > > NULL check in the function lf_clearlock(). This patch fixes that.
> > > 
> > > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
> > > Fixes: ae181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many locks")
> > > Reported-by: Sebastian Feld <sebastian.n.feld@gmail.com>
> > > Reviewed-by:
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/flock.cc | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
> > > index 3821bddd6..794e66bd7 100644
> > > --- a/winsup/cygwin/flock.cc
> > > +++ b/winsup/cygwin/flock.cc
> > > @@ -1524,6 +1524,10 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
> > >    lockf_t *lf = *head;
> > >    lockf_t *overlap, **prev;
> > >    int ovcase;
> > > +
> > > +  if (lf == NOLOCKF)
> > > +    return 0;
> > > +
> > >    inode_t *node = lf->lf_inode;
> > >    tmp_pathbuf tp;
> > >    node->i_all_lf = (lockf_t *) tp.w_get ();
> > > @@ -1531,8 +1535,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
> > >    uint32_t lock_cnt = node->get_lock_count ();
> > >    bool first_loop = true;
> > >  
> > > -  if (lf == NOLOCKF)
> > > -    return 0;
> > >    prev = head;
> > >    while ((ovcase = lf_findoverlap (lf, unlock, SELF, &prev, &overlap)))
> > >      {
> > > -- 
> > > 2.45.1
> > 
> > LGTM, please push.
> 
> Thanks for reviewing this patch. Could you please review
>  [PATCH v2] Cygwin: flock: Fix overlap handling in lf_setlock() and lf_clearlock()
> as well?

Give me a bit of time.  While the patch might fix the problem, what
bugs me is the deviation from upstream code.  We will at least need
a few comments to explain why we don't follow the upstream behaviour.


Corinna
