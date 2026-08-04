Return-Path: <SRS0=eqke=F5=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 455AA4BB1C38
	for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2026 08:37:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 455AA4BB1C38
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 455AA4BB1C38
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785832656; cv=none;
	b=b4YS962/ZBaTKZuDl9TprM2gxnoY+fZtZx42+BszK0cF+s/LmWC23lWsxmh8IWNmZsqWdisXWxx8BuX/JI8PmhmQpPHZVg2zh8Psjvrku/xC72k0rIr3NzHeyM7psCmMoXGAHVxgzMtKhFI/Z2xey+6lMNQhrxbAt4jHDcpvTrE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785832656; c=relaxed/simple;
	bh=HRYh3sdOziVdT8JgMRyhtvbejOSI3sRQNFMWGIOu/6o=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Mt5aTy/v4nbEPzaHE8N2ImIG7Jlk4u0Q4h8mGLeU2pXUMdIXJJAiGIFyg36HghMWfbyvLdFLLBB+vlv0CM7d8UopcuXP/4jeqEG0Ljdj0sNqRcjQnKc4ZM2ci6Jia8kwdRX0J/x41sLrMVUXubOGEh+afZsXG5h0uPyZqXgT0DY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MxABcnKP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 455AA4BB1C38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MxABcnKP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785832655; x=1786437455;
	i=johannes.schindelin@gmx.de;
	bh=gyzB+6g2qTA13gZEfnOopwKbiJ432p1sN3vedboiQ7o=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MxABcnKP6nlZd/BVN4w/qlG+/eqeg2eZE8fp3Otv5qfof30TC2S+K9GUzONNxPnH
	 7d36puwVp6Sd4aQP/8XKyhvUqj2GYlRoDneSh1XkKncs4L33RkuNtsljB8xlTaiwj
	 D6JsZYwNjkWteD8z9MX61zxVnxD68hgg3QV3XgS8hfJHoD/Pquo3sw3+oqczLoayO
	 tMVpxVaSrjPYEHeHLmniEvoHiEbWbFzKQG+6X3j8E6tdIrvqV6/YdJUuLyXy7IeS3
	 kV/IoMMBqDu78ObOjhdfMrYOW+ybteCZNVr6S+sCnxGockvjzIDPWrUb4mMr/1w4O
	 O6FGAtnsDgtpFItQMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1wrism44Cg-009HvQ; Tue, 04
 Aug 2026 10:37:35 +0200
Date: Tue, 4 Aug 2026 10:37:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: open: Do not set tentative fhandler to fdtab
 (B)
In-Reply-To: <20260803105520.1232-2-takashi.yano@nifty.ne.jp>
Message-ID: <ada5ea77-42ea-975b-89c4-fc6c920236d6@gmx.de>
References: <20260803105520.1232-1-takashi.yano@nifty.ne.jp> <20260803105520.1232-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Zi9Z/+DeD2OmdoH+W2lLm4q0z2tI00vDqz/AsN6taMCyw7I8zSS
 VZJqM2pCjzQ8l+DihAFY3DR+B4JSRQCxRfIFHeHGxvxm3KNHCGUSakI0SciA6rgnr6Y3oQY
 YM4C6mUEEEXTLjRg7esSrgAILwaeOm7g/AmAdyjlH2jSkbfpWlUoWMinRiZumxQjQIMy0sU
 /Y8u6q/Z8UuND376y/TaQ==
UI-OutboundReport: notjunk:1;M01:P0:A/GHTDb3TvM=;QLh9YT+cN54lVFH6c+4hOjQXqyi
 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
 8DoOkRQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for implementing both variants. Having them side by side makes
the trade-off concrete in a way the v2 thread could only gesture at.

My preference is (B), the same recommendation I made on v2. Concretely,
this piece:

On Mon, 3 Aug 2026, Takashi Yano wrote:

> Tentative assignment of fhandler to fdtab introduced by the commit
> 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
> causes the undesired behaviour. The commit intended that fhandler
> was just a marker for reservation of fd. However, another cygwin
> call may assume that the fd is valid and in use, and may operate on
> it.
>=20
> This patch introduces a special value ((fhandler_base *) -1) for
> fdtab that marks the fd as reserved and means it cannot be assigned
> for another open(), etc.

The single distinguished value keeps one source of truth in the slot
itself, so the lock-free `cygheap_fdget` fast path keeps working with just
one added comparison, and there is no second array to keep consistent.
(A)'s parallel `bool *reserved` array duplicates the "is this slot spoken
for" state and has to be kept in lockstep with `fds[]` across `extend()`,
fork, and exec. That is safe, but it is exactly the "separate flag" shape
I wanted to avoid. So (B)'s mechanism is the one I want, provided it is
complete.

It is not yet complete, though. The most important gap: the sentinel is
masked _only_ inside `dtable::operator[]`.

>=20
> Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()=
")
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/dtable.cc                | 13 ++++++++-----
>  winsup/cygwin/local_includes/cygheap.h |  6 +++---
>  winsup/cygwin/local_includes/dtable.h  | 15 ++++++++++++---
>  winsup/cygwin/syscalls.cc              |  8 ++++----
>  4 files changed, 27 insertions(+), 15 deletions(-)
>=20
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index e4d1cdf8f..fffc9bad5 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -247,9 +247,12 @@ out:
>  void
>  dtable::release (int fd)
>  {
> -  if (fds[fd]->need_fixup_before ())
> -    dec_need_fixup_before ();
> -  fds[fd]->dec_refcnt ();
> +  if (fds[fd] && fds[fd] !=3D FDTAB_RESERVED)
> +    {
> +      if (fds[fd]->need_fixup_before ())
> +	dec_need_fixup_before ();
> +      fds[fd]->dec_refcnt ();
> +    }
>    fds[fd] =3D NULL;
>    if (fd <=3D 2)
>      set_std_handle (fd);
> @@ -267,7 +270,7 @@ cygwin_attach_handle_to_fd (char *name, int fd, HAND=
LE handle, mode_t bin,
>      fd =3D -1;
>    else
>      {
> -      cygheap->fdtab[fd] =3D fh;
> +      cygheap->fdtab.set_fhandler (fd, fh);
>        cygheap->fdtab[fd]->inc_refcnt ();
>        fh->init (handle, myaccess, bin ?: fh->pc_binmode ());
>      }
> @@ -425,7 +428,7 @@ dtable::init_std_file_from_handle (int fd, HANDLE ha=
ndle)
>        if (!fh->open_setup (openflags))
>  	api_fatal ("open_setup failed, %E");
>        fh->usecount =3D 0;
> -      cygheap->fdtab[fd] =3D fh;
> +      cygheap->fdtab.set_fhandler (fd, fh);
>        cygheap->fdtab[fd]->inc_refcnt ();
>        set_std_handle (fd);
>        paranoid_printf ("fd %d, handle %p", fd, handle);
> diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/loca=
l_includes/cygheap.h
> index 74cfff652..db740f03d 100644
> --- a/winsup/cygwin/local_includes/cygheap.h
> +++ b/winsup/cygwin/local_includes/cygheap.h
> @@ -569,10 +569,10 @@ class cygheap_fdmanip
>    }
>    virtual void release () { cygheap->fdtab.release (fd); }
>    operator int &() {return fd;}
> -  operator fhandler_base* &() {return cygheap->fdtab[fd];}
> +  operator fhandler_base* () {return cygheap->fdtab[fd];}
>    operator fhandler_socket* () const {return reinterpret_cast<fhandler_=
socket *> (cygheap->fdtab[fd]);}
>    operator fhandler_pipe* () const {return reinterpret_cast<fhandler_pi=
pe *> (cygheap->fdtab[fd]);}
> -  void operator =3D (fhandler_base *fh) {cygheap->fdtab[fd] =3D fh;}
> +  void operator =3D (fhandler_base *fh) {cygheap->fdtab.set_fhandler (f=
d, fh);}
>    fhandler_base *operator -> () const {return cygheap->fdtab[fd];}
>    bool isopen () const
>    {
> @@ -609,7 +609,7 @@ class cygheap_fdnew : public cygheap_fdmanip
>      if (cygheap->fdtab[fd])
>        cygheap->fdtab[fd]->inc_refcnt ();
>    }
> -  void operator =3D (fhandler_base *fh) {cygheap->fdtab[fd] =3D fh;}
> +  void operator =3D (fhandler_base *fh) {cygheap->fdtab.set_fhandler (f=
d, fh);}
>  };
> =20
>  class cygheap_fdget : public cygheap_fdmanip
> diff --git a/winsup/cygwin/local_includes/dtable.h b/winsup/cygwin/local=
_includes/dtable.h
> index 7803fae1b..910a7e849 100644
> --- a/winsup/cygwin/local_includes/dtable.h
> +++ b/winsup/cygwin/local_includes/dtable.h
> @@ -17,6 +17,7 @@ details. */
>  class suffix_info;
> =20
>  #define BFH_OPTS (PC_NULLEMPTY | PC_FULL | PC_POSIX)
> +#define FDTAB_RESERVED ((fhandler_base *) -1)
>  class dtable
>  {
>    fhandler_base **fds;
> @@ -26,10 +27,12 @@ class dtable
>    static const int initial_archetype_size =3D 8;
>    size_t first_fd_for_open;
>    int cnt_need_fixup_before;
> +  fhandler_base * const null_fds;
>  public:
>    size_t size;
> =20
> -  dtable () : archetypes (NULL), narchetypes (0), farchetype (0), first=
_fd_for_open(3), cnt_need_fixup_before(0) {}
> +  dtable () : archetypes (NULL), narchetypes (0), farchetype (0),
> +  first_fd_for_open(3), cnt_need_fixup_before(0), null_fds (NULL) {}
>    void init () {first_fd_for_open =3D 3;}
> =20
>    void dec_need_fixup_before ()
> @@ -51,7 +54,8 @@ public:
>    inline int not_open (int fd)
>    {
>      lock ();
> -    int res =3D fd < 0 || fd >=3D (int) size || fds[fd] =3D=3D NULL;
> +    int res =3D fd < 0 || fd >=3D (int) size
> +      || fds[fd] =3D=3D NULL || fds[fd] =3D=3D FDTAB_RESERVED;
>      unlock ();
>      return res;
>    }
> @@ -61,7 +65,11 @@ public:
>    void init_std_file_from_handle (int fd, HANDLE handle);
>    int dup3 (int oldfd, int newfd, int flags);
>    void fixup_after_exec ();
> -  inline fhandler_base *&operator [](int fd) const { return fds[fd]; }
> +  inline void set_fhandler (int fd, fhandler_base *fh) {fds[fd] =3D fh;=
}
> +  inline fhandler_base *operator [](int fd) const
> +  {
> +    return (fds[fd] =3D=3D FDTAB_RESERVED) ? null_fds : fds[fd];
> +  }

The five fork/exec fixup loops (`set_file_pointers_for_exec`,
`fixup_before_fork`, `fixup_after_fork`, `fixup_before_exec`, and
`fixup_after_exec`) read the private `fds[]` member directly and treat any
non-NULL slot as a live handler. `FDTAB_RESERVED` is `(fhandler_base *)
-1`, not NULL, so it passes that test and gets dereferenced (the
`get_flags()` call in `set_file_pointers_for_exec`, for one). That is the
consumer set I enumerated in the v2 discussion. And it is reachable in
exactly the window the reservation exists to cover: a FIFO `open()` that
blocks in `open_with_arch()` with the fdtab lock released, while another
thread forks or execs. The child- and exec-side fixups run over a copied
cygheap that still holds the sentinel, and `set_file_pointers_for_exec`,
`fixup_after_fork`, and `fixup_after_exec` run unconditionally.

This would make the issues worse than they are right now. Today those
loops dereference a constructed-but-not-yet-opened `fhandler`: wrong, but
a valid object. With this patch they dereference `(fhandler_base *) -1`
outright. The fix is to route every raw `fds[]` iterator through the same
masking (a small private accessor that maps the sentinel to NULL, used by
those loops) rather than masking only in `operator[]`.

And the five loops are not the only way around `operator[]`: `dtable`
still exposes `operator fhandler_base **()`, handing out the raw `fds`
array with the sentinel unmasked. Unlike the loops, this one is a latent
trapdoor, not a live crash _today_; its only caller in the tree is the
`!cygheap->fdtab` allocated-check in `init_cygheap`, which tests the base
pointer for NULL and never indexes a slot. It matters anyway: the
invariant this patch relies on (that every reader is funneled through
`operator[]`) is not one the class can actually enforce while it publicly
advertises the raw pointer, so anyone who later iterates `cygheap->fdtab`
as the array silently gets `(fhandler_base *) -1`. This is really why the
reservation must be hidden in the storage layer, not masked in a single
accessor that both the five loops and this conversion sidestep.

Second, the new `operator[]` reads `fds[fd]` twice, once in the comparison
and once in the returned value. A NULL-to-reserved transition between the
two loads hands the sentinel back to a lock-free reader, which is the very
thing the single distinguished value was meant to preclude (my "no risk of
a torn read" from before). Reading the slot once into a local and
comparing that closes the window.

Third, lower priority because it is shared with (A): explicit-target
writers still overwrite a reservation (`dup2`/`dup3`, and
`cygwin_attach_handle_to_fd` with an explicit fd) because `not_open()`
reports a reserved slot as free. This is only reachable by targeting an fd
number that `open()` has not yet returned, so it is not a blocker, but it
is worth a guard or at least a comment.

Two nits, neither blocking. The error-cleanup path now goes through
`release()`, which additionally calls `set_std_handle()` for the standard
descriptors, a side effect the previous bare assignment to NULL did not
have; a dedicated unreserve helper would avoid it. And `null_fds` is
unnecessary now that `operator[]` returns by value; returning NULL
directly after a single load is simpler.

For the record, the rest of the conversion from returning a reference to
returning by value _is_ complete: every former assignment through
`fdtab[fd]` was converted to `set_fhandler()`, so that part is solid.

Net: (B) is the design I would strongly prefer. I would like to see it
land once the raw `fds[]` readers are covered and the double read is
collapsed to a single load.

Ciao,
Johannes

>    bool select_read (int fd, select_stuff *);
>    bool select_write (int fd, select_stuff *);
>    bool select_except (int fd, select_stuff *);
> @@ -76,6 +84,7 @@ public:
>    void fixup_before_fork (DWORD win_proc_id);
>    void lock () {lock_process::locker.acquire ();}
>    void unlock () {lock_process::locker.release ();}
> +  void reserve (int fd) { fds[fd] =3D FDTAB_RESERVED; }
>  };
> =20
>  fhandler_base *build_fh_dev (const device&, const char * =3D NULL);
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 5465d6c09..af7471a7f 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1558,8 +1558,8 @@ open (const char *unix_path, int flags, ...)
>  	  cygheap->fdtab.unlock ();
>  	  __leave;		/* errno already set */
>  	}
> -      cygheap->fdtab[fd] =3D fh; /* tentative setting to mark as used *=
/
> -      cygheap->fdtab.unlock();
> +      cygheap->fdtab.reserve (fd);
> +      cygheap->fdtab.unlock ();
> =20
>        if (fh->dev () =3D=3D FH_PROCESSFD && fh->pc.follow_fd_symlink ()=
)
>  	{
> @@ -1588,7 +1588,7 @@ open (const char *unix_path, int flags, ...)
>  		    FILE_OPEN_FOR_BACKUP_INTENT);
> =20
>        cygheap->fdtab.lock ();
> -      cygheap->fdtab[fd] =3D fh;
> +      cygheap->fdtab.set_fhandler (fd, fh);
>        fh->inc_refcnt ();
>        cygheap->fdtab.unlock ();
> =20
> @@ -1601,7 +1601,7 @@ open (const char *unix_path, int flags, ...)
>      if (res < 0 && fd >=3D 0)
>        {
>  	cygheap->fdtab.lock ();
> -	cygheap->fdtab[fd] =3D NULL; /* Mark as unused */
> +	cygheap->fdtab.release (fd);
>  	cygheap->fdtab.unlock ();
>        }
>    if (res < 0 && fh)
> --=20
> 2.51.0
>=20
>=20
