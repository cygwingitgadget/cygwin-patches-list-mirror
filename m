Return-Path: <SRS0=+gxg=EX=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 37C104BA2E16
	for <cygwin-patches@cygwin.com>; Sat, 27 Jun 2026 07:24:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 37C104BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 37C104BA2E16
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782545052; cv=none;
	b=ryYJwYckRY9qor/2U/ggEPO3eBQbheLNwofRrtcAGaOl/e1w0rhGlTOJp8lEy1HHV5mX8dZQHUMklWVF/HG6HH3EuTYKKuwaRLQSrSBp6o8f+Xl9aN0sC18DLDlb4tfFhc1HrMlb8cZZ2IZEOa3jZgsVBOCBcG6AolgwsTYDVhY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782545052; c=relaxed/simple;
	bh=c8+FhUbv3mL7fyTT5MGVsiaviWDGEZMRH5YHkRDDlPM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=CWXdoGaVMCgnznx3kdV/oWWbfjNAsmBeyYCSAKrK25aWvs5P5pF5fb8PcwPHlbk17ETmQou/JinLR9L9Q4TjlsECFpgB00Z4X6hCI3dxySECVv8/8+YnzmkW1RybBNXCsOYsquXHP6X6LQ2GJzJPgK4dN83+lqNoLrVdfijdxL8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OWaiWAIs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 37C104BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OWaiWAIs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782545047; x=1783149847;
	i=johannes.schindelin@gmx.de;
	bh=vDTYLQ7lhOg9i1tB+XAV90CXqnk6wH/VxEK4+GFqd6k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OWaiWAIsuF1S8Sk7/QXU15PC2rvFhxLch07imdE3fE6Nao3VzszlegyMNjdcRGoY
	 1ke0nVvBPQt9t1ZJ9V/LnZpHKUz2/nFQ2zGa5mZModaOoX8OkYwP8YGS3dEgj+yJP
	 lAqhpcMrNo3XhvXSYBElenWzZAMYx8X7m+K6iAcIuj0xoLzWOg6ewzuzM+hSA9CR+
	 Yj+0BMqLJfDzEYangitNYkc9f9y0LNwEwCgn8ezCle/TMj3GRLbVg6iMjrt+cRJSS
	 xs9UUYHrKmeckwr4+ivFcXnSYXRVYbwXHVwYDSAWuXMFG3AwpbI+b7sua6ZUsjwtU
	 uKvl4ycBaLeSjERzUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHG8g-1wQ7ly3qQi-007ivG; Sat, 27
 Jun 2026 09:18:50 +0200
Date: Sat, 27 Jun 2026 09:18:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>, Mark Geisert <mark@maxrnd.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app
 exits
In-Reply-To: <20260613140917.27155-4-takashi.yano@nifty.ne.jp>
Message-ID: <b9c76c12-c300-69c1-b6e3-5b03396ed8e0@gmx.de>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp> <20260613140917.27155-4-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:cJvvs5gKSS/BB/vUXCVhWWfmb8vPkpuFUGyV5lq8P+UNGKrRqhq
 8KwiWxO8OOar5UHQ7V+yB6sHQIVgHMiPc8i5lCrm9CQJtWr6zOl7d6t5eQ9MOuREiTByueF
 lgSzTfIGLhQyXhgD5lToxJ7UIeTY6k+u9NPQ+QAo8NnhQ61PfN1HBfUZZ2sE7WKJYye6U9i
 mF+yLlKrfQ/qaB0tWAHYg==
UI-OutboundReport: notjunk:1;M01:P0:wgcsDPD16nc=;SwYh2f2CveqAoBiNmbzfNDAeY44
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_LOTSOFHASH,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi, Mark,

I had started working on those patches, been pulled away, and meant coming
back to them but failed. The work was tracked in
https://github.com/git-for-windows/msys2-runtime/pull/131, but I
admittedly did not find the time to complete the work earlier.

There are fixes in that PR (in addition to UI tests based on AutoHotKey
that helped me catch a couple of bugs) for the following three issues:


On Sat, 13 Jun 2026, Takashi Yano wrote:

> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index b3a8d57cc..f4473bb69 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -388,6 +388,52 @@ atexit_func (void)
>      }
>  }
> =20
> +void
> +fhandler_pty_slave::req_fixup_pcon_state (void)
> +{
> +  while (true)
> +    {
> +      WaitForSingleObject (input_mutex, mutex_timeout);
> +      if (!get_ttyp ()->pcon_start_pid)
> +	break;
> +      /* Another request is on going. */
> +      ReleaseMutex (input_mutex);
> +      yield ();
> +    }
> +
> +  DWORD n;
> +  /* indicates that this "ESC[6n" is just for fixing-up corsor position=
 */
> +  get_ttyp ()->req_fixup_pcon_cur_pos =3D true;
> +  get_ttyp ()->req_xfer_input =3D true; /* indicates that this "ESC[6n"
> +					 is just for transfer input */
> +  get_ttyp ()->pcon_start =3D true;
> +  get_ttyp ()->pcon_start_pid =3D myself->pid;
> +  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
> +  ReleaseMutex (input_mutex);
> +  while (get_ttyp ()->pcon_start_pid)
> +    /* wait for completion of fixing-up in master::write(). */
> +    yield ();

Both of these loops are unbounded, and both depend on somebody else
clearing `pcon_start_pid`. If the master never replies (terminal closing,
broken pipe, or the previous requester died mid-handshake), the exiting
process spins forever in the second loop, and a stale slot wedges the next
exiting process in the first one. This commit also drops the
`pcon_start_pid =3D 0` reset that `close_pseudoconsole()` used to do, so t=
he
stale-slot case is no longer self-healing across pcon teardown either.

Bounding both waits with a 3-second `GetTickCount64()` deadline, clearing
our own `pcon_start_pid` on timeout only if it is still ours, and
restoring the `close_pseudoconsole()` reset as a backstop makes the
pathological case degrade to a slightly stale cursor rather than a hung
exit.

The fix I would propose is in
https://github.com/git-for-windows/msys2-runtime/pull/131/changes/c366a1c0=
2e66a242a3437f6b9335c2319c095c92:

=2D- snip --
=46rom c366a1c02e66a242a3437f6b9335c2319c095c92 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 25 Jun 2026 13:41:42 +0200
Subject: [PATCH] Cygwin: pty: bound the cursor-sync round-trip so an exiti=
ng
 process cannot hang

The cursor-position fixup added in "Cygwin: pty: Fixup pty state after
a cygwin app exits" runs from cleanup() on every foreground Cygwin-app
exit while a pseudo console is active, and it waits on two unbounded
loops for the master to answer the "ESC[6n" it just sent: one that
spins until the pcon_start_pid slot is free, and one that spins until
the master clears the slot again. pcon_start_pid is only ever cleared
once master::write() parses the terminal's reply, so if that reply
never comes, because the terminal is going away, the forwarding pipe
is broken, or a previous requester died mid-handshake, the exiting
process spins on yield() forever and never exits.

Bound both waits with a three second deadline using GetTickCount64(),
and on timeout clear our own pcon_start_pid slot, but only if it is
still ours, so a give-up does not stomp a later requester. Also restore
the pcon_start and pcon_start_pid reset that the same commit removed
from close_pseudoconsole(); it is the backstop that keeps a requester
which died without clearing its slot from wedging the next one. The
worst case is now a slightly stale cursor after a timeout rather than a
process that refuses to exit.

Fixes: b34394d456b6 ("Cygwin: pty: Fixup pty state after a cygwin app exit=
s")
Assisted-by: Opus 4.8
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/fhandler/pty.cc | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index c79fd1f975..669e18238b 100644
=2D-- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -226,6 +226,7 @@ atexit_func (void)
 void
 fhandler_pty_slave::req_fixup_pcon_state (void)
 {
+  ULONGLONG deadline =3D GetTickCount64 () + 3000;
   while (true)
     {
       WaitForSingleObject (input_mutex, mutex_timeout);
@@ -233,6 +234,10 @@ fhandler_pty_slave::req_fixup_pcon_state (void)
 	break;
       /* Another request is on going. */
       ReleaseMutex (input_mutex);
+      if (GetTickCount64 () > deadline)
+	/* A previous requester is stuck; give up this sync rather than
+	   spin forever. */
+	return;
       yield ();
     }
=20
@@ -245,9 +250,25 @@ fhandler_pty_slave::req_fixup_pcon_state (void)
   get_ttyp ()->pcon_start_pid =3D myself->pid;
   WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
   ReleaseMutex (input_mutex);
-  while (get_ttyp ()->pcon_start_pid)
+  deadline =3D GetTickCount64 () + 3000;
+  while (get_ttyp ()->pcon_start_pid && GetTickCount64 () <=3D deadline)
     /* wait for completion of fixing-up in master::write(). */
     yield ();
+  /* If the master never answered (e.g. the terminal is going away),
+     clear our own request so a stale pcon_start_pid cannot wedge the
+     next requester. */
+  if (get_ttyp ()->pcon_start_pid =3D=3D (pid_t) myself->pid)
+    {
+      WaitForSingleObject (input_mutex, mutex_timeout);
+      if (get_ttyp ()->pcon_start_pid =3D=3D (pid_t) myself->pid)
+	{
+	  get_ttyp ()->req_fixup_pcon_cur_pos =3D false;
+	  get_ttyp ()->req_xfer_input =3D false;
+	  get_ttyp ()->pcon_start =3D false;
+	  get_ttyp ()->pcon_start_pid =3D 0;
+	}
+      ReleaseMutex (input_mutex);
+    }
 }
=20
 void
@@ -4007,6 +4028,10 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp,=
 DWORD force_switch_to)
 	  ttyp->pcon_activated =3D false;
 	  ttyp->switch_to_nat_pipe =3D false;
 	  ttyp->nat_pipe_owner_pid =3D 0;
+	  /* Safety net: if a req_fixup_pcon_state() requester died without
+	     clearing its slot, do not leave pcon_start_pid set forever. */
+	  ttyp->pcon_start =3D false;
+	  ttyp->pcon_start_pid =3D 0;
 	}
       if (ttyp->pcon_handle_ready_event)
 	{
=2D-  snap --

> +}
> +
> +void
> +fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
> +{
> +  HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +				   get_ttyp ()->nat_pipe_owner_pid);
> +  HANDLE h_pcon_out =3D NULL;
> +  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> +		   GetCurrentProcess (), &h_pcon_out,
> +		   0, TRUE, DUPLICATE_SAME_ACCESS);
> +  CloseHandle (pcon_owner);
> +  DWORD target_pid =3D get_ttyp ()->nat_pipe_owner_pid;
> +  DWORD resume_pid =3D
> +    fhandler_pty_common::attach_console_temporarily (target_pid);
> +  COORD cur_pos =3D {(SHORT) (x - 1), (SHORT) (y - 1)};
> +  SetConsoleCursorPosition (h_pcon_out, cur_pos);
> +  fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
> +  CloseHandle (h_pcon_out);
> +}
> +
>  #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
>  /* CreateProcess() is hooked for GDB etc. */
>  DEF_HOOK (CreateProcessA);
> @@ -1162,6 +1208,19 @@ err_no_msg:
>  bool
>  fhandler_pty_slave::open_setup (int flags)
>  {
> +  if (get_ttyp ()->pcon_activated)
> +    {
> +      HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> +				       get_ttyp ()->nat_pipe_owner_pid);
> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> +		       GetCurrentProcess (), &get_handle_nat (),
> +		       0, TRUE, DUPLICATE_SAME_ACCESS);
> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> +		       GetCurrentProcess (), &get_output_handle_nat (),
> +		       0, TRUE, DUPLICATE_SAME_ACCESS);
> +      CloseHandle (pcon_owner);

By the time we get here, `open()` has already installed real duplicates of
the cyg master-side pipe ends into `io_handle_nat` and
`output_handle_nat`. Overwriting them through `&get_handle_nat()` /
`&get_output_handle_nat()` without closing the previous values first leaks
two handles on every pcon-backed grandchild open. The `OpenProcess()`
return is also not NULL-checked: when the nat-pipe owner has already
exited, both `DuplicateHandle()` calls fail silently and leave the nat
slots NULL, which then breaks the slave's input routing in ways that are
hard to reason about after the fact.

The fix is to close the existing handles first, skip the replacement when
`OpenProcess()` returns NULL, and treat the two duplications as one
transaction so a partial failure does not leave the slave in a
half-installed state. I implemented that in
https://github.com/git-for-windows/msys2-runtime/pull/131/changes/6238d106=
537d6e130efe9084353850349e9c593d:

=2D- snip --
=46rom 6238d106537d6e130efe9084353850349e9c593d Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 25 Jun 2026 13:41:43 +0200
Subject: [PATCH] Cygwin: pty: do not leak nat handles when adopting the pc=
on's
 in open_setup()

When a Cygwin process opens a pty slave whose pseudo console is already
active, open() has just installed duplicates of the cyg master-side
pipe ends into io_handle_nat and output_handle_nat. The pcon adoption
added in "Cygwin: pty: Fixup pty state after a cygwin app exits"
overwrites those two slots via &get_handle_nat() / &get_output_handle_nat(=
)
without closing them first, so two handles leak on every pcon-backed
grandchild open. It also hands the result of OpenProcess() straight to
DuplicateHandle() without a NULL check, so if the nat-pipe owner has
already exited both duplications fail and leave the nat slots NULL,
which then breaks the slave's input routing.

Close the old slots before replacing them, skip the replacement
entirely when OpenProcess() returns NULL so we degrade to the handles
open() installed, and make the pair transactional so a partial success
cannot leave one original slot and one pcon slot.

Fixes: b34394d456b6 ("Cygwin: pty: Fixup pty state after a cygwin app exit=
s")
Assisted-by: Opus 4.8
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/fhandler/pty.cc | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 669e18238b..acf7da9319 100644
=2D-- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1072,13 +1072,33 @@ fhandler_pty_slave::open_setup (int flags)
     {
       HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
 				       get_ttyp ()->nat_pipe_owner_pid);
-      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
-		       GetCurrentProcess (), &get_handle_nat (),
-		       0, TRUE, DUPLICATE_SAME_ACCESS);
-      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
-		       GetCurrentProcess (), &get_output_handle_nat (),
-		       0, TRUE, DUPLICATE_SAME_ACCESS);
-      CloseHandle (pcon_owner);
+      if (pcon_owner)
+	{
+	  HANDLE new_in =3D NULL, new_out =3D NULL;
+	  bool ok_in =3D DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+				       GetCurrentProcess (), &new_in,
+				       0, TRUE, DUPLICATE_SAME_ACCESS);
+	  bool ok_out =3D DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
+				        GetCurrentProcess (), &new_out,
+				        0, TRUE, DUPLICATE_SAME_ACCESS);
+	  if (ok_in && ok_out)
+	    {
+	      /* Close the cyg master-side handles open() installed before
+		 replacing them, so they do not leak. */
+	      CloseHandle (get_handle_nat ());
+	      CloseHandle (get_output_handle_nat ());
+	      set_handle_nat (new_in);
+	      set_output_handle_nat (new_out);
+	    }
+	  else
+	    {
+	      if (new_in)
+		CloseHandle (new_in);
+	      if (new_out)
+		CloseHandle (new_out);
+	    }
+	  CloseHandle (pcon_owner);
+	}
     }
=20
   set_flags ((flags & ~O_TEXT) | O_BINARY);
=2D- snap --

> +    }
> +
>    set_flags ((flags & ~O_TEXT) | O_BINARY);
>    myself->set_ctty (this, flags);
>    report_tty_counts (this, "opened", "");
> @@ -1171,6 +1230,9 @@ fhandler_pty_slave::open_setup (int flags)
>  void
>  fhandler_pty_slave::cleanup ()
>  {
> +  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () =3D=3D mys=
elf->pgid)
> +    req_fixup_pcon_state ();
> +
>    /* This used to always call fhandler_pty_common::close when we were e=
xecing
>       but that caused multiple closes of the handles associated with thi=
s pty.
>       Since close_all_files is not called until after the cygwin process=
 has
> @@ -2478,7 +2540,14 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>  	      /* req_xfer_input is true if "ESC[6n" was sent just for
>  		 triggering transfer_input() in master. In this case,
>  		 the response sequence should not be written. */
> -	      if (!get_ttyp ()->req_xfer_input)
> +	      if (get_ttyp ()->req_fixup_pcon_cur_pos)
> +		{
> +		  int x, y;
> +		  sscanf (wpbuf, "\033[%d;%dR", &y, &x);
> +		  fixup_pcon_cursor_position (x, y);

The `sscanf()` return is dropped, so a malformed or truncated
cursor-position reply hands uninitialised `x` and `y` straight into
`SetConsoleCursorPosition()` via the COORD cast.
`fixup_pcon_cursor_position()` itself has the same `OpenProcess()` NULL
hazard as above, plus an unchecked `DuplicateHandle()` whose `h_pcon_out`
is then used unconditionally.

Gating the call on `sscanf (...) =3D=3D 2`, clamping the coordinates into =
the
valid SHORT range before the COORD cast, and adding the missing NULL
checks in the helper closes all three holes:
https://github.com/git-for-windows/msys2-runtime/pull/131/changes/5de332d1=
b7c289ff9f3b02f2dedc9e9842fbbf04

=2D- snip --
=46rom 5de332d1b7c289ff9f3b02f2dedc9e9842fbbf04 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Thu, 25 Jun 2026 13:41:44 +0200
Subject: [PATCH] Cygwin: pty: validate the cursor-position reply before mo=
ving
 the pcon cursor

The CSI6n reply handler added in "Cygwin: pty: Fixup pty state after a
cygwin app exits" runs sscanf() on the terminal's response but ignores
its return value, so a malformed or partial reply leaves the x and y
locals uninitialised and hands them to SetConsoleCursorPosition(),
which is exactly the cursor corruption the commit set out to prevent.

Only call the fixup when sscanf() reports both coordinates parsed, and
in fixup_pcon_cursor_position() clamp the coordinates into the valid
SHORT range before the COORD cast so a stray reply cannot wrap into a
negative position. While there, check OpenProcess() for NULL (the
nat-pipe owner may have exited) and check the DuplicateHandle() result
instead of using a possibly-NULL screen-buffer handle.

Fixes: b34394d456b6 ("Cygwin: pty: Fixup pty state after a cygwin app exit=
s")
Assisted-by: Opus 4.8
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/fhandler/pty.cc | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index acf7da9319..522f46e0f2 100644
=2D-- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -274,12 +274,23 @@ fhandler_pty_slave::req_fixup_pcon_state (void)
 void
 fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
 {
+  /* A malformed or out-of-range reply must not be turned into a wrapped
+     negative COORD. */
+  if (x < 1 || y < 1 || x > 0x7fff || y > 0x7fff)
+    return;
   HANDLE pcon_owner =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE,
 				   get_ttyp ()->nat_pipe_owner_pid);
+  if (!pcon_owner)
+    /* The nat-pipe owner is gone; nothing to sync to. */
+    return;
   HANDLE h_pcon_out =3D NULL;
-  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
-		   GetCurrentProcess (), &h_pcon_out,
-		   0, TRUE, DUPLICATE_SAME_ACCESS);
+  if (!DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
+			GetCurrentProcess (), &h_pcon_out,
+			0, TRUE, DUPLICATE_SAME_ACCESS))
+    {
+      CloseHandle (pcon_owner);
+      return;
+    }
   CloseHandle (pcon_owner);
   DWORD target_pid =3D get_ttyp ()->nat_pipe_owner_pid;
   DWORD resume_pid =3D
@@ -2424,8 +2435,8 @@ fhandler_pty_master::write (const void *ptr, size_t =
len)
 	      if (get_ttyp ()->req_fixup_pcon_cur_pos)
 		{
 		  int x, y;
-		  sscanf (wpbuf, "\033[%d;%dR", &y, &x);
-		  fixup_pcon_cursor_position (x, y);
+		  if (sscanf (wpbuf, "\033[%d;%dR", &y, &x) =3D=3D 2)
+		    fixup_pcon_cursor_position (x, y);
 		  get_ttyp ()->req_fixup_pcon_cur_pos =3D false;
 		}
 	      else if (!get_ttyp ()->req_xfer_input)
=2D- snap --

Again, I am sorry for the lack of my presence in this thread!

Ciao,
Johannes

> +		  get_ttyp ()->req_fixup_pcon_cur_pos =3D false;
> +		}
> +	      else if (!get_ttyp ()->req_xfer_input)
>  		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
>  	      ixput =3D 0;
>  	      state =3D 0;
> @@ -4100,8 +4169,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp=
, DWORD force_switch_to)
>  	  ttyp->pcon_activated =3D false;
>  	  ttyp->switch_to_nat_pipe =3D false;
>  	  ttyp->nat_pipe_owner_pid =3D 0;
> -	  ttyp->pcon_start =3D false;
> -	  ttyp->pcon_start_pid =3D 0;
>  	}
>        if (ttyp->pcon_handle_ready_event)
>  	{
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 322592bf1..2fa30cbce 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2533,6 +2533,7 @@ class fhandler_pty_slave: public fhandler_pty_comm=
on
>    void setpgid_aux (pid_t pid);
>    static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termio=
s *fh);
>    void replace_nat_handles (HANDLE new_input, HANDLE new_output);
> +  void req_fixup_pcon_state (void);
>  };
> =20
>  #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (uni=
t))
> @@ -2639,6 +2640,7 @@ public:
>    void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
>    bool need_send_ctrl_c_event ();
>    void apply_line_edit_to_transferred_input ();
> +  void fixup_pcon_cursor_position (int x, int y);
>  };
> =20
>  class fhandler_dev_null: public fhandler_base
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_in=
cludes/tty.h
> index 507f7772e..c5102eb81 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -145,6 +145,7 @@ private:
>    xfer_dir pty_input_state;
>    bool discard_input;
>    bool stop_fwd_thread;
> +  bool req_fixup_pcon_cur_pos;
> =20
>  public:
>    HANDLE from_master_nat () const { return _from_master_nat; }
> --=20
> 2.51.0
>=20
>=20
