Return-Path: <SRS0=+3/h=F6=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id A25FC4BA79A5
	for <cygwin-patches@cygwin.com>; Wed,  5 Aug 2026 09:30:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A25FC4BA79A5
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A25FC4BA79A5
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785922207; cv=none;
	b=oU2LrkMTc1HpZB2q4Vzt8LZ4fFZI94JacPXNJhQwYErUQZm5U8qwJ/5ai40xRTydfXhZ9HvP9ibz95KnAXs4eINpuh1pTK4Xc2ykiN8tyxIWBq3dK6ORLpkMWuMV7fNJVQBiyIffiXNNuusNXQLTKj77ZFcocH/88a6x6DfpZDE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785922207; c=relaxed/simple;
	bh=i9aKpjfNmubO3iVMZclrwPrdqiac0y9uCbhnLLF7WZ0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UaWxRUt+m/AQnge3w+2xClbliX4u0fzJkBxUxoH4BRk4A3aq9sQP5DrkSLI/aP1oZMsYdglsVa0w9FxtYHhGqbhKZ9BPa9s3sr3Dkx+XHQKy/TUXhzWELV7KnUBOIDIPRi6zS15jZEeqPnPkrYtZBjk9WrXyrJbZ9NdVWkrgesc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FEuL2vZF
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A25FC4BA79A5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FEuL2vZF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785922196; x=1786526996;
	i=johannes.schindelin@gmx.de;
	bh=RWmwJ3oU6SltKZuv8FYb90suHpyLhImEoR3rAsOETHY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FEuL2vZFuBXlX6HIA98h9L5hRw+tR/dNnqeWrQ+JyxeJTO7KWfcxPdV1vKEpAx+w
	 /g8m9MlYmtW4hfkC4yL3ZNH/vhtg7Ly8EYieitkSPeyISnVFV5Kyhjc5bCYojqUln
	 tgRTKB3gE2T6uSVhfyE2zLxvCMtzapGZwC6p7AD5FBqlgvP+VDt4ac4RovEmNt8Wu
	 p868JZvVKAQm7b3cNGUsLa6G55UQ33AP5jNxTZOjHXDGL0fz0ZbWNSnDMLWJgrocy
	 7gbL4NzT5mf6qZK41CKKhUfUULC0O49px37lwVH4LmiqbKhymM6/JyxKMh6Dq45uc
	 U3betxDuVbqg0QPB/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3ir-1wSdNn1gmh-00IbpA; Wed, 05
 Aug 2026 11:29:56 +0200
Date: Wed, 5 Aug 2026 11:29:54 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Do not set tentative fhandler to
 fdtab
In-Reply-To: <20260805071801.1079-1-takashi.yano@nifty.ne.jp>
Message-ID: <66632651-46ee-abb0-4173-5fe5dbb6b438@gmx.de>
References: <20260805071801.1079-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:FJ43wCIxmKdv6w3leoVJxVs5vnKGZMbL0joF3/uvpbEQZzsprHb
 hknWmXgCa9Zc5v5G/tPhlavsXvI9rH1pYpPWgtlko7MxMQX2gqiKT6iK9VZquCr7RfkOnuZ
 V4GTanB4khJk4Q9Dd2P5XVrML3qyaiw9085CLgkJ4NPZ2Z+HZkeYXRWHGEEnWEsTd8HFmyn
 pQbVYfJPCNR1DAW5Nu+bw==
UI-OutboundReport: notjunk:1;M01:P0:J3jN4i+9+/U=;viaLoXKds5q3Kyi/RsSRJDQk7Es
 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
 /bGkFYA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This is exactly what I was hoping for. v2 addresses every point from the
last round.

On Wed, 5 Aug 2026, Takashi Yano wrote:

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
>=20
> Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()=
")
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  winsup/cygwin/dtable.cc                | 29 ++++++++++++-----------
>  winsup/cygwin/local_includes/cygheap.h |  6 ++---
>  winsup/cygwin/local_includes/dtable.h  | 32 ++++++++++++++++++++++++--
>  winsup/cygwin/syscalls.cc              | 13 +++++++----
>  4 files changed, 57 insertions(+), 23 deletions(-)
>=20
> diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> index e4d1cdf8f..7a4fd7dca 100644
> --- a/winsup/cygwin/dtable.cc
> +++ b/winsup/cygwin/dtable.cc
> @@ -13,6 +13,7 @@ details. */
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <wchar.h>
> +#include <assert.h>
> =20
>  #define USE_SYS_TYPES_FD_SET
>  #include <winsock.h>
> @@ -123,7 +124,7 @@ dtable::get_debugger_info ()
>  	    fhandler_base *fh =3D build_fh_name (std[i]);
>  	    if (!fh)
>  	      continue;
> -	    fds[i] =3D fh;
> +	    fds.set_fhandler (i, fh);
>  	    if (!fh->open ((i ? (i =3D=3D 2 ? O_RDWR : O_WRONLY) : O_RDONLY)
>  			   | O_BINARY, 0777))
>  	      release (i);
> @@ -233,7 +234,7 @@ dtable::find_unused_handle (size_t start)
>    do
>      {
>        for (size_t i =3D start; i < size; i++)
> -	if (fds[i] =3D=3D NULL)
> +	if (fds[i] =3D=3D NULL && !fds.reserved (i))
>  	  {
>  	    res =3D (int) i;
>  	    goto out;
> @@ -249,8 +250,9 @@ dtable::release (int fd)
>  {
>    if (fds[fd]->need_fixup_before ())
>      dec_need_fixup_before ();
> +  assert (fds[fd]);

Tiny nit, not a blocker: This assert sits _after_ the first dereference
(`fds[fd]->need_fixup_before ()`), so it cannot catch a NULL-or-reserved
slot before that line already faults. It wants to be the first statement
in the function.

>    fds[fd]->dec_refcnt ();
> -  fds[fd] =3D NULL;
> +  fds.set_fhandler (fd, NULL);
>    if (fd <=3D 2)
>      set_std_handle (fd);
>  }
> @@ -263,11 +265,12 @@ cygwin_attach_handle_to_fd (char *name, int fd, HA=
NDLE handle, mode_t bin,
>    if (fd =3D=3D -1)
>      fd =3D cygheap->fdtab.find_unused_handle ();
>    fhandler_base *fh =3D build_fh_name (name);
> -  if (!fh)
> +  if (!fh || cygheap->fdtab.reserved (fd))
>      fd =3D -1;
>    else
>      {
> -      cygheap->fdtab[fd] =3D fh;
> +      cygheap->fdtab.set_fhandler (fd, fh);
> +      assert (cygheap->fdtab[fd]);
>        cygheap->fdtab[fd]->inc_refcnt ();
>        fh->init (handle, myaccess, bin ?: fh->pc_binmode ());
>      }
> @@ -348,7 +351,7 @@ dtable::init_std_file_from_handle (int fd, HANDLE ha=
ndle)
>      handle_to_fn (handle, name);
> =20
>    if (!name[0] && !dev)
> -    fds[fd] =3D NULL;
> +    fds.set_fhandler (fd, NULL);
>    else
>      {
>        fhandler_base *fh;
> @@ -425,7 +428,8 @@ dtable::init_std_file_from_handle (int fd, HANDLE ha=
ndle)
>        if (!fh->open_setup (openflags))
>  	api_fatal ("open_setup failed, %E");
>        fh->usecount =3D 0;
> -      cygheap->fdtab[fd] =3D fh;
> +      cygheap->fdtab.set_fhandler (fd, fh);
> +      assert (cygheap->fdtab[fd]);
>        cygheap->fdtab[fd]->inc_refcnt ();
>        set_std_handle (fd);
>        paranoid_printf ("fd %d, handle %p", fd, handle);
> @@ -795,16 +799,15 @@ dtable::dup3 (int oldfd, int newfd, int flags)
> =20
>    if (!not_open (newfd))
>      close (newfd);
> -  else if ((size_t) newfd >=3D size
> -	   && find_unused_handle (newfd) < 0)
> +  else if (((size_t) newfd >=3D size && find_unused_handle (newfd) < 0)
> +	   || reserved (newfd))

With this, `dup3` (hence `dup2`) and `cygwin_attach_handle_to_fd` with an
explicit fd refuse a reserved target instead of overwriting it. That was
the third gap from the last round.

One raw exposure remains, and I want to record that it is fine: `dtable`
still hands out the underlying array through `operator fhandler_base
**()`. But with the wrapper in place its only callers are `extend()`'s own
bookkeeping (the `memcpy`, the `cfree`, `fds =3D newfds`) and the
`!cygheap->fdtab` allocated-check in `init_cygheap`, neither of which
indexes a slot, so the trapdoor is effectively shut. I also checked the
mechanical consequence of `operator[]` no longer yielding an lvalue: every
former raw `fds[...] =3D` assignment moved to `set_fhandler`
(`get_debugger_info`, `release`, both `init_std_file_from_handle`
branches, `dup3`, `move_fd`), so nothing writes through the masked
accessor.

One more unrelated nit: the new `dup3` branch that rejects a reserved
`newfd` returns -1 without setting `errno`. The `reserved (newfd)`
disjunct falls into the "couldn't extend fdtab" arm, which sets none. It
is only reachable if a `dup2` targets an fd number a concurrent `open()`
is still reserving (undefined territory), so it is cosmetic, but an
`EBADF` there would be tidier.

One pre-existing aside, explicitly out of scope: a multithreaded `fork()`
while another thread is blocked in a FIFO `open()` still leaves the
reserved slot set in the child, where no thread survives to clear it, so
that fd stays unusable there. It no longer crashes (the child's fixup now
skips the masked slot), and it predates this patch (the same window at
`0d3ea0ee` inherits a half-open `fhandler`, which is worse), so nothing to
change here. Just noting it.

So the Reviewed-by stands as added. Thank you for fixing this!

Ciao,
Johannes

>      /* couldn't extend fdtab */
>      {
>        newfh->close ();
>        res =3D -1;
>        goto done;
>      }
> -
> -  fds[newfd] =3D newfh;
> +  fds.set_fhandler (newfd, newfh);
> =20
>    if ((res =3D newfd) <=3D 2)
>      set_std_handle (res);
> @@ -874,8 +877,8 @@ void
>  dtable::move_fd (int from, int to)
>  {
>    // close (to); /* It is assumed that this is close-on-exec */
> -  fds[to] =3D fds[from];
> -  fds[from] =3D NULL;
> +  fds.set_fhandler (to, fds[from]);
> +  fds.set_fhandler (from, NULL);
>  }
> =20
>  void
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
> index 7803fae1b..89c776c2d 100644
> --- a/winsup/cygwin/local_includes/dtable.h
> +++ b/winsup/cygwin/local_includes/dtable.h
> @@ -17,9 +17,30 @@ details. */
>  class suffix_info;
> =20
>  #define BFH_OPTS (PC_NULLEMPTY | PC_FULL | PC_POSIX)
> +#define FDTAB_RESERVED ((fhandler_base *) -1)
>  class dtable
>  {
> -  fhandler_base **fds;
> +  class dtable_fds
> +  {
> +    fhandler_base **fds;
> +  public:
> +    inline void set_fhandler (int fd, fhandler_base *fh) {fds[fd] =3D f=
h;}
> +    inline fhandler_base *operator [](int fd) const
> +    {
> +      fhandler_base *fh =3D fds[fd];
> +      return (fh =3D=3D FDTAB_RESERVED) ? NULL : fh;
> +    }

Moving the masking into the `dtable_fds` accessor is the right move; it is
precisely the "hide it in the storage layer" I was after. The five
fork/exec fixup loops (`set_file_pointers_for_exec`, `fixup_before_fork`,
`fixup_after_fork`, `fixup_before_exec`, `fixup_after_exec`) all read the
member `fds[i]`, so they now see NULL for a reserved slot with no change
at any site; `select_read`/`select_write`/`select_except` and the
free-standing `set_std_handle` likewise. I traced each of them: the
sentinel can no longer reach a dereference through the member. And the
single load into `fh` closes the torn-read window I worried about last
time: one read, compared and returned, so a lock-free `cygheap_fdget` can
never observe the marker escaping the mask.

> +    operator fhandler_base **() {return fds;}
> +    void operator =3D (fhandler_base **ptr) {fds =3D ptr;}
> +    inline void reserve (int fd) { fds[fd] =3D FDTAB_RESERVED; }
> +    inline void unreserve (int fd)
> +    {
> +      if (fds[fd] =3D=3D FDTAB_RESERVED)
> +	fds[fd] =3D NULL;
> +    }
> +    inline bool reserved (int fd) { return fds[fd] =3D=3D FDTAB_RESERVE=
D; }
> +  };
> +  dtable_fds fds;
>    fhandler_base **archetypes;
>    unsigned narchetypes;
>    unsigned farchetype;
> @@ -61,7 +82,11 @@ public:
>    void init_std_file_from_handle (int fd, HANDLE handle);
>    int dup3 (int oldfd, int newfd, int flags);
>    void fixup_after_exec ();
> -  inline fhandler_base *&operator [](int fd) const { return fds[fd]; }
> +  inline void set_fhandler (int fd, fhandler_base *fh)
> +  {
> +    fds.set_fhandler (fd, fh);
> +  }
> +  inline fhandler_base *operator [](int fd) const { return fds[fd]; }
>    bool select_read (int fd, select_stuff *);
>    bool select_write (int fd, select_stuff *);
>    bool select_except (int fd, select_stuff *);
> @@ -76,6 +101,9 @@ public:
>    void fixup_before_fork (DWORD win_proc_id);
>    void lock () {lock_process::locker.acquire ();}
>    void unlock () {lock_process::locker.release ();}
> +  inline void reserve (int fd) { fds.reserve (fd); }
> +  inline void unreserve (int fd) { fds.unreserve (fd); }
> +  inline bool reserved (int fd) { return fds.reserved (fd); }
>  };
> =20
>  fhandler_base *build_fh_dev (const device&, const char * =3D NULL);
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 5465d6c09..5ca02c0a1 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -24,6 +24,7 @@ details. */
>  #include <dirent.h>
>  #include <ntsecapi.h>
>  #include <iptypes.h>
> +#include <assert.h>
>  #include "ntdll.h"
> =20
>  #include <cygwin/version.h>
> @@ -146,7 +147,9 @@ dup_finish (int oldfd, int newfd, int flags)
>    int res;
>    if ((res =3D cygheap->fdtab.dup3 (oldfd, newfd, flags | O_EXCL)) =3D=
=3D newfd)
>      {
> -      cygheap_fdget (newfd)->inc_refcnt ();
> +      cygheap_fdget cfd (newfd);
> +      assert ((fhandler_base *) cfd);
> +      cfd->inc_refcnt ();
>        cygheap->fdtab.unlock ();	/* dup3 exits with lock set on success =
*/
>      }
>    return res;
> @@ -1558,8 +1561,8 @@ open (const char *unix_path, int flags, ...)
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
> @@ -1588,7 +1591,7 @@ open (const char *unix_path, int flags, ...)
>  		    FILE_OPEN_FOR_BACKUP_INTENT);
> =20
>        cygheap->fdtab.lock ();
> -      cygheap->fdtab[fd] =3D fh;
> +      cygheap->fdtab.set_fhandler (fd, fh);
>        fh->inc_refcnt ();
>        cygheap->fdtab.unlock ();
> =20
> @@ -1601,7 +1604,7 @@ open (const char *unix_path, int flags, ...)
>      if (res < 0 && fd >=3D 0)
>        {
>  	cygheap->fdtab.lock ();
> -	cygheap->fdtab[fd] =3D NULL; /* Mark as unused */
> +	cygheap->fdtab.unreserve (fd);
>  	cygheap->fdtab.unlock ();
>        }
>    if (res < 0 && fh)
> --=20
> 2.51.0
>=20
>=20
