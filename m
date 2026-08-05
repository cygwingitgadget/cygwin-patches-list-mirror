Return-Path: <SRS0=8hwm=F6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id C60974BAE7E8
	for <cygwin-patches@cygwin.com>; Wed,  5 Aug 2026 07:21:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C60974BAE7E8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C60974BAE7E8
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785914513; cv=none;
	b=nyTw88d6BjiPJkcpT+WqDIZJ5LHf0n/ggqYF7MNK9sU0LiquA4FC5M5BJk0Zyeuwx6PuLmFheYOKHMqn3zl0W+unABvQiZZ5XOZ++4pNsBP9NXakJ5UjiFKsNZva0aOccfcoxSoPGTEVzRk2+eThlrfiJtJGL2C5zgdinwWmyrc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785914513; c=relaxed/simple;
	bh=MmQqeRXn4eewJSippkUojikGWrFINNDoPHjVeXeq3S8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=mB0ov7NymFyQ8dtvCiV1GaLaW/rMFolHMwrDA0P/cq8kCTMAZ7S1FKUaP+Yvvqqw9A2avK+0Dt6hGHDEVx5pDk6STvH/seA65BzSsyZBCWKTb28oC5UsEexGRiIYTaszFPbnBcF9t4o34zT8zLa/WsutvcayPw8rjHWqaR7vsxE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=E32r4Pe0
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C60974BAE7E8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=E32r4Pe0
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260805072150252.NVGL.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 5 Aug 2026 16:21:50 +0900
Date: Wed, 5 Aug 2026 16:21:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: open: Do not set tentative fhandler to fdtab
 (B)
Message-Id: <20260805162148.7453004ad035e2e33820e8e1@nifty.ne.jp>
In-Reply-To: <ada5ea77-42ea-975b-89c4-fc6c920236d6@gmx.de>
References: <20260803105520.1232-1-takashi.yano@nifty.ne.jp>
	<20260803105520.1232-2-takashi.yano@nifty.ne.jp>
	<ada5ea77-42ea-975b-89c4-fc6c920236d6@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785914510;
 bh=JqKdUTvKNGwsLEWpcW/vnFY2Sd5E1WWyI+WzL9gaE9s=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=E32r4Pe0di5/npDQmuTJHH6D23kQ1frpLY3VAytav27d+KookV5uqWoqZCV6H3JtwEbVeReY
 lAo4BhO20ptznLIjOYuMv5CcK0YcIT0zzJ2GlBqNgU6oia5PQIwxAksDzZU53f3A3z25+Fz99/
 CXRHmPo1MHpTM6rZiBK8D6iGe9esKcvYCJtHoYDJlb+iHys7QMKn3xV2LLdUkOcszCck1oMOyD
 91BSAdC6t2CHD6dxEO9zpNj/XCCWN1bJYcDGZE+za+ifE3CisMHHd530rgQmHLHI9pFv5Utbxo
 //adTz97Wb4EVm1OOwQQizjnt6Sp2TYM3T+I/3VTcVpc6mqw==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing!

On Tue, 4 Aug 2026 10:37:32 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for implementing both variants. Having them side by side makes
> the trade-off concrete in a way the v2 thread could only gesture at.
> 
> My preference is (B), the same recommendation I made on v2. Concretely,
> this piece:
> 
> On Mon, 3 Aug 2026, Takashi Yano wrote:
> 
> > Tentative assignment of fhandler to fdtab introduced by the commit
> > 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
> > causes the undesired behaviour. The commit intended that fhandler
> > was just a marker for reservation of fd. However, another cygwin
> > call may assume that the fd is valid and in use, and may operate on
> > it.
> > 
> > This patch introduces a special value ((fhandler_base *) -1) for
> > fdtab that marks the fd as reserved and means it cannot be assigned
> > for another open(), etc.
> 
> The single distinguished value keeps one source of truth in the slot
> itself, so the lock-free `cygheap_fdget` fast path keeps working with just
> one added comparison, and there is no second array to keep consistent.
> (A)'s parallel `bool *reserved` array duplicates the "is this slot spoken
> for" state and has to be kept in lockstep with `fds[]` across `extend()`,
> fork, and exec. That is safe, but it is exactly the "separate flag" shape
> I wanted to avoid. So (B)'s mechanism is the one I want, provided it is
> complete.
> 
> It is not yet complete, though. The most important gap: the sentinel is
> masked _only_ inside `dtable::operator[]`.
> 
> > 
> > Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
> > Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/dtable.cc                | 13 ++++++++-----
> >  winsup/cygwin/local_includes/cygheap.h |  6 +++---
> >  winsup/cygwin/local_includes/dtable.h  | 15 ++++++++++++---
> >  winsup/cygwin/syscalls.cc              |  8 ++++----
> >  4 files changed, 27 insertions(+), 15 deletions(-)
> > 
> > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > index e4d1cdf8f..fffc9bad5 100644
> > --- a/winsup/cygwin/dtable.cc
> > +++ b/winsup/cygwin/dtable.cc
> > @@ -247,9 +247,12 @@ out:
> >  void
> >  dtable::release (int fd)
> >  {
> > -  if (fds[fd]->need_fixup_before ())
> > -    dec_need_fixup_before ();
> > -  fds[fd]->dec_refcnt ();
> > +  if (fds[fd] && fds[fd] != FDTAB_RESERVED)
> > +    {
> > +      if (fds[fd]->need_fixup_before ())
> > +	dec_need_fixup_before ();
> > +      fds[fd]->dec_refcnt ();
> > +    }
> >    fds[fd] = NULL;
> >    if (fd <= 2)
> >      set_std_handle (fd);
> > @@ -267,7 +270,7 @@ cygwin_attach_handle_to_fd (char *name, int fd, HANDLE handle, mode_t bin,
> >      fd = -1;
> >    else
> >      {
> > -      cygheap->fdtab[fd] = fh;
> > +      cygheap->fdtab.set_fhandler (fd, fh);
> >        cygheap->fdtab[fd]->inc_refcnt ();
> >        fh->init (handle, myaccess, bin ?: fh->pc_binmode ());
> >      }
> > @@ -425,7 +428,7 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
> >        if (!fh->open_setup (openflags))
> >  	api_fatal ("open_setup failed, %E");
> >        fh->usecount = 0;
> > -      cygheap->fdtab[fd] = fh;
> > +      cygheap->fdtab.set_fhandler (fd, fh);
> >        cygheap->fdtab[fd]->inc_refcnt ();
> >        set_std_handle (fd);
> >        paranoid_printf ("fd %d, handle %p", fd, handle);
> > diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_includes/cygheap.h
> > index 74cfff652..db740f03d 100644
> > --- a/winsup/cygwin/local_includes/cygheap.h
> > +++ b/winsup/cygwin/local_includes/cygheap.h
> > @@ -569,10 +569,10 @@ class cygheap_fdmanip
> >    }
> >    virtual void release () { cygheap->fdtab.release (fd); }
> >    operator int &() {return fd;}
> > -  operator fhandler_base* &() {return cygheap->fdtab[fd];}
> > +  operator fhandler_base* () {return cygheap->fdtab[fd];}
> >    operator fhandler_socket* () const {return reinterpret_cast<fhandler_socket *> (cygheap->fdtab[fd]);}
> >    operator fhandler_pipe* () const {return reinterpret_cast<fhandler_pipe *> (cygheap->fdtab[fd]);}
> > -  void operator = (fhandler_base *fh) {cygheap->fdtab[fd] = fh;}
> > +  void operator = (fhandler_base *fh) {cygheap->fdtab.set_fhandler (fd, fh);}
> >    fhandler_base *operator -> () const {return cygheap->fdtab[fd];}
> >    bool isopen () const
> >    {
> > @@ -609,7 +609,7 @@ class cygheap_fdnew : public cygheap_fdmanip
> >      if (cygheap->fdtab[fd])
> >        cygheap->fdtab[fd]->inc_refcnt ();
> >    }
> > -  void operator = (fhandler_base *fh) {cygheap->fdtab[fd] = fh;}
> > +  void operator = (fhandler_base *fh) {cygheap->fdtab.set_fhandler (fd, fh);}
> >  };
> >  
> >  class cygheap_fdget : public cygheap_fdmanip
> > diff --git a/winsup/cygwin/local_includes/dtable.h b/winsup/cygwin/local_includes/dtable.h
> > index 7803fae1b..910a7e849 100644
> > --- a/winsup/cygwin/local_includes/dtable.h
> > +++ b/winsup/cygwin/local_includes/dtable.h
> > @@ -17,6 +17,7 @@ details. */
> >  class suffix_info;
> >  
> >  #define BFH_OPTS (PC_NULLEMPTY | PC_FULL | PC_POSIX)
> > +#define FDTAB_RESERVED ((fhandler_base *) -1)
> >  class dtable
> >  {
> >    fhandler_base **fds;
> > @@ -26,10 +27,12 @@ class dtable
> >    static const int initial_archetype_size = 8;
> >    size_t first_fd_for_open;
> >    int cnt_need_fixup_before;
> > +  fhandler_base * const null_fds;
> >  public:
> >    size_t size;
> >  
> > -  dtable () : archetypes (NULL), narchetypes (0), farchetype (0), first_fd_for_open(3), cnt_need_fixup_before(0) {}
> > +  dtable () : archetypes (NULL), narchetypes (0), farchetype (0),
> > +  first_fd_for_open(3), cnt_need_fixup_before(0), null_fds (NULL) {}
> >    void init () {first_fd_for_open = 3;}
> >  
> >    void dec_need_fixup_before ()
> > @@ -51,7 +54,8 @@ public:
> >    inline int not_open (int fd)
> >    {
> >      lock ();
> > -    int res = fd < 0 || fd >= (int) size || fds[fd] == NULL;
> > +    int res = fd < 0 || fd >= (int) size
> > +      || fds[fd] == NULL || fds[fd] == FDTAB_RESERVED;
> >      unlock ();
> >      return res;
> >    }
> > @@ -61,7 +65,11 @@ public:
> >    void init_std_file_from_handle (int fd, HANDLE handle);
> >    int dup3 (int oldfd, int newfd, int flags);
> >    void fixup_after_exec ();
> > -  inline fhandler_base *&operator [](int fd) const { return fds[fd]; }
> > +  inline void set_fhandler (int fd, fhandler_base *fh) {fds[fd] = fh;}
> > +  inline fhandler_base *operator [](int fd) const
> > +  {
> > +    return (fds[fd] == FDTAB_RESERVED) ? null_fds : fds[fd];
> > +  }
> 
> The five fork/exec fixup loops (`set_file_pointers_for_exec`,
> `fixup_before_fork`, `fixup_after_fork`, `fixup_before_exec`, and
> `fixup_after_exec`) read the private `fds[]` member directly and treat any
> non-NULL slot as a live handler. `FDTAB_RESERVED` is `(fhandler_base *)
> -1`, not NULL, so it passes that test and gets dereferenced (the
> `get_flags()` call in `set_file_pointers_for_exec`, for one). That is the
> consumer set I enumerated in the v2 discussion. And it is reachable in
> exactly the window the reservation exists to cover: a FIFO `open()` that
> blocks in `open_with_arch()` with the fdtab lock released, while another
> thread forks or execs. The child- and exec-side fixups run over a copied
> cygheap that still holds the sentinel, and `set_file_pointers_for_exec`,
> `fixup_after_fork`, and `fixup_after_exec` run unconditionally.
> 
> This would make the issues worse than they are right now. Today those
> loops dereference a constructed-but-not-yet-opened `fhandler`: wrong, but
> a valid object. With this patch they dereference `(fhandler_base *) -1`
> outright. The fix is to route every raw `fds[]` iterator through the same
> masking (a small private accessor that maps the sentinel to NULL, used by
> those loops) rather than masking only in `operator[]`.
> 
> And the five loops are not the only way around `operator[]`: `dtable`
> still exposes `operator fhandler_base **()`, handing out the raw `fds`
> array with the sentinel unmasked. Unlike the loops, this one is a latent
> trapdoor, not a live crash _today_; its only caller in the tree is the
> `!cygheap->fdtab` allocated-check in `init_cygheap`, which tests the base
> pointer for NULL and never indexes a slot. It matters anyway: the
> invariant this patch relies on (that every reader is funneled through
> `operator[]`) is not one the class can actually enforce while it publicly
> advertises the raw pointer, so anyone who later iterates `cygheap->fdtab`
> as the array silently gets `(fhandler_base *) -1`. This is really why the
> reservation must be hidden in the storage layer, not masked in a single
> accessor that both the five loops and this conversion sidestep.
> 
> Second, the new `operator[]` reads `fds[fd]` twice, once in the comparison
> and once in the returned value. A NULL-to-reserved transition between the
> two loads hands the sentinel back to a lock-free reader, which is the very
> thing the single distinguished value was meant to preclude (my "no risk of
> a torn read" from before). Reading the slot once into a local and
> comparing that closes the window.
> 
> Third, lower priority because it is shared with (A): explicit-target
> writers still overwrite a reservation (`dup2`/`dup3`, and
> `cygwin_attach_handle_to_fd` with an explicit fd) because `not_open()`
> reports a reserved slot as free. This is only reachable by targeting an fd
> number that `open()` has not yet returned, so it is not a blocker, but it
> is worth a guard or at least a comment.
> 
> Two nits, neither blocking. The error-cleanup path now goes through
> `release()`, which additionally calls `set_std_handle()` for the standard
> descriptors, a side effect the previous bare assignment to NULL did not
> have; a dedicated unreserve helper would avoid it. And `null_fds` is
> unnecessary now that `operator[]` returns by value; returning NULL
> directly after a single load is simpler.
> 
> For the record, the rest of the conversion from returning a reference to
> returning by value _is_ complete: every former assignment through
> `fdtab[fd]` was converted to `set_fhandler()`, so that part is solid.
> 
> Net: (B) is the design I would strongly prefer. I would like to see it
> land once the raw `fds[]` readers are covered and the double read is
> collapsed to a single load.

I’ve posted the v2 patch with the issues you pointed out fixed.
I’d appreciate a re-review.

Thanks in advance.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
