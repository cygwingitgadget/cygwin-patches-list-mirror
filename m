Return-Path: <SRS0=AK3Y=E7=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id AF0F44BA2E08
	for <cygwin-patches@cygwin.com>; Sun,  5 Jul 2026 08:10:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AF0F44BA2E08
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AF0F44BA2E08
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783239052; cv=none;
	b=REDaX0hgS73PSqo/ZB3YOMVPVzqAwLbranw7TV6By2cK0d0YvlKPL5rLRqc6e0twYi+vF5n2uo7/CTB+6xyPBqeJ+mDgEZUie9AcZiECQRu9L4oxsacdwXlafOQp0td9NNxa6psJ9nLvDsZ8hzyTzLJNYEgCxjQceD0Y9OjhXws=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783239052; c=relaxed/simple;
	bh=HPkr+faH0T+5vf62PzF9KC5XT4QSjG1uGwusEpD5GaU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rhHBOmeAexqCxKIU27Eska3GaJjZ3KOpDKDG+HZLIykJbI2GXqRMyG61o3ScN8RH09DUt7g99d6x1dsiIUPE4U0hfpDB9JGS9g4Ue51aShpimni575+qmN03hysp4kg3bU0hSJHxZZ+fM8aB+YgMK5Q657gihtBhSXKw9xpcJd8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hZMhwQ6O
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AF0F44BA2E08
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hZMhwQ6O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783239050; x=1783843850;
	i=johannes.schindelin@gmx.de;
	bh=5i0ERsMJ3BbYAUzn5w5BDp+E2k9lYKJBMHniyyix/LI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hZMhwQ6O7Fsp9tc1SC+wVfz4QbJt7/N5uhsU66Il4RngO/HqvMorCJ2KeJKTM8K0
	 xx9LRrqwTuR3919S1rbKxHt+y4Ka57i2R/jjwxJichH37RRt0UeCfLMf8WC6yAPhd
	 Jpx3bY57dD9y1NP6gfpx3mnrWZ/1zYdqyKnvFNPMYHyYVIbOClg4z46sysQkV0x11
	 4y1+nYWgUqRVNfFDvVR4YmRm5BInvojVwZE+RzB80VqY4a8Qtt2wtHXm6Iihb1fUO
	 Vfb0JeHAZ4Q3Z0UDAz202Apbw8V0117QOj0tQ0gSx0RLbiFgQsX8u1KXm66q48z8z
	 qLKncpBms23o5XdyRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MulqD-1wxor31KEN-013xuy; Sun, 05
 Jul 2026 10:10:50 +0200
Date: Sun, 5 Jul 2026 10:10:51 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
In-Reply-To: <20260630081436.2427-1-takashi.yano@nifty.ne.jp>
Message-ID: <67131026-6c13-7d7e-f80f-56565aea5aa2@gmx.de>
References: <20260630081436.2427-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:17OBEx1HLEyyM5VtjrdNMKpqceoiCPi9W+shKyiAKKJ30EJz2Yf
 AT2A8jyCPbo8anlmm6J9baqdG49YXBSU4vYSyeJ8+smtvRJ91KmcS5bVsRzNhfubrKehyDE
 05XELr7qnWSAZPE2RQQmeR+grVX688y/dIt5Ln6YrM3yD/yPMQMAD4gHlA+yBlOrc+qkn7z
 vMk+VST2DMxP89Im8PYlA==
UI-OutboundReport: notjunk:1;M01:P0:UPOF0PICLrI=;wylxxYm/7/Ke0mJbKWZRWF+FnaI
 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
 2U7bM3vj7HDLWDT9So=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for v2. The overall direction (blocking the nat-pipe transfer
while a cygwin reader is active on the cyg-pipe) is correct, and the new
cleanup hook is a good defensive addition against a slave that exits
mid-read wedging the pipe state. I do want to flag one hazard, though,
which I think v2 introduces by moving `slave_reading` and `num_reader`
from the fhandler into the shared `tty` struct.

On Tue, 30 Jun 2026, Takashi Yano wrote:

> On the command "cat | non-cygwin-app", `cat` sometimes fails to read
> key input. This happens when `cat` starts to read input before `non-
> cygwin-app` configures pseudo console. This is because pipe state is
> switched to nat-pipe when pseudo console is configured.
>=20
> This patch prevent the pipe state from changing to nat-pipe state if
> some cygwin process is reading input from the cyg-pipe.
>=20
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
> v2: Release all masks owned by myself on cleanup()
>=20
>  winsup/cygwin/fhandler/pty.cc           | 33 +++++++++++++++++++++----
>  winsup/cygwin/local_includes/fhandler.h |  3 +--
>  winsup/cygwin/local_includes/tty.h      |  2 ++
>  3 files changed, 31 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 35e320507..54cd64a47 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -951,7 +951,7 @@ out:
> =20
>  fhandler_pty_slave::fhandler_pty_slave (int unit, dev_t via)
>    : fhandler_pty_common (), inuse (NULL), output_handle_nat (NULL),
> -  io_handle_nat (NULL), slave_reading (NULL), num_reader (0)
> +  io_handle_nat (NULL), masked_cnt (0)
>  {
>    dev_referred_via =3D via;
>    if (unit >=3D 0)
> @@ -1230,6 +1230,10 @@ fhandler_pty_slave::open_setup (int flags)
>  void
>  fhandler_pty_slave::cleanup ()
>  {
> +  fhandler_pty_slave *arch =3D (fhandler_pty_slave *) archetype ? : thi=
s;
> +  while (arch->masked_cnt)
> +    mask_switch_to_nat_pipe (false, false);
> +
>    if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () =3D=3D mys=
elf->pgid)
>      req_fixup_pcon_state ();
> =20
> @@ -1499,11 +1503,18 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (boo=
l mask, bool xfer)
>    WaitForSingleObject (input_mutex, mutex_timeout);
>    if (mask)
>      {
> -      if (InterlockedIncrement (&num_reader) =3D=3D 1)
> -	slave_reading =3D CreateEvent (&sec_none_nih, TRUE, FALSE, name);
> +      if (InterlockedIncrement (&get_ttyp ()->num_reader) =3D=3D 1)
> +	get_ttyp ()->slave_reading =3D
> +	  CreateEvent (&sec_none_nih, TRUE, FALSE, name);
>      }
> -  else if (InterlockedDecrement (&num_reader) =3D=3D 0)
> -    CloseHandle (slave_reading);
> +  else if (InterlockedDecrement (&get_ttyp ()->num_reader) =3D=3D 0)
> +    CloseHandle (get_ttyp ()->slave_reading);

`num_reader` is fine to share (it is just a counter, and the interlocked
increment/decrement pair does the right thing across processes).
`slave_reading`, however, is a `HANDLE`, and HANDLE values are
per-process: they index into the owning process's handle table and are not
portable to another process without `DuplicateHandle`. Storing the raw
value in shared memory and letting an arbitrary process call `CloseHandle`
on it later is therefore hazardous.

Concretely, consider two cygwin readers on the same pty:

Process A takes the first mask. `InterlockedIncrement` returns 1, so A
calls `CreateEvent` and writes A's handle value into `get_ttyp
()->slave_reading`. Process B then takes a second mask; the counter goes
to 2, so B does not create or store anything. A releases first: the
counter goes to 1, so A does not close. B releases last: the counter goes
to 0, and B executes `CloseHandle (get_ttyp ()->slave_reading)`. But that
HANDLE value lives in A's handle table, not B's. In the benign case B gets
`ERROR_INVALID_HANDLE` and the event object leaks (A already lost its slot
in this API, so nobody will ever close it). In the malignant case, that
same numeric HANDLE value happens to be live in B's own handle table
pointing at an unrelated object, which B then closes out from under
itself.

In v1 both fields were per-fhandler, so this could not arise: whichever
fhandler created the event also closed it, in the same process. For the
specific same-process teardown path that v2's `cleanup ()` adds ("release
all masks I still own"), the hazard also does not trigger by construction,
since the process draining `masked_cnt` is the same one that took those
masks. So the concern is purely about the general mask/unmask API contract
now that the storage is shared.

Two questions, then:

First, is cross-process mask ownership actually reachable via the current
call sites (read paths, `cleanup ()`, `close ()`, exec/spawn transitions)?
If every mask is guaranteed to be released by the same process that took
it, the hazard is theoretical and it would suffice to document that
invariant near the field. I have not fully traced this myself and would
trust your reading here.

Second, if it _is_ reachable, would it make sense to mirror the by-name
lookup you already do in `transfer_input ()` on the release side as well,
that is, `OpenEvent` the named event by name inside
`mask_switch_to_nat_pipe (false, ...)` when the counter hits zero and
close the freshly opened handle, so `CloseHandle` always operates on a
handle native to the closing process? Then `slave_reading` in the shared
struct would only serve as the "an event with this name exists" flag, and
no cross-process HANDLE ever gets closed.

One much smaller, non-blocking observation on the check you added at the
top of `transfer_input ()`:

> +
> +  fhandler_pty_slave *arch =3D (fhandler_pty_slave *) archetype ? : thi=
s;
> +  if (mask)
> +    InterlockedIncrement (&arch->masked_cnt);
> +  else
> +    InterlockedDecrement (&arch->masked_cnt);
> =20
>    if (!!masked !=3D mask && xfer && get_ttyp ()->switch_to_nat_pipe)
>      {
> @@ -4401,6 +4412,18 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir=
 dir, HANDLE from, tty *ttyp,
>  				    HANDLE input_available_event,
>  				    HANDLE input_transferred_to_cyg)
>  {
> +  if (dir =3D=3D tty::to_nat)
> +    {
> +      char name[MAX_PATH];
> +      shared_name (name, TTY_SLAVE_READING, ttyp->get_minor ());
> +      HANDLE masked =3D OpenEvent (READ_CONTROL, FALSE, name);
> +      CloseHandle (masked);
> +      if (masked)
> +	/* Cygwin process is reading cyg-pipe.
> +	   Do not transfer input to nat-pipe. */
> +	return;
> +    }

There is a small TOCTOU window here: another thread can take the first
mask (and create the event) in between our `OpenEvent` returning NULL and
our `to_nat` transfer actually starting. The bounded worst case is one
spurious transfer, not corruption, so I do not consider this a blocker;
just noting it for the record in case a tighter interlock via
`input_mutex` is cheap here.

Ciao,
Johannes

> +
>    HANDLE to;
>    if (dir =3D=3D tty::to_nat)
>      to =3D ttyp->to_slave_nat ();
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 8e9cbef4b..d8b6f5950 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2442,8 +2442,7 @@ class fhandler_pty_slave: public fhandler_pty_comm=
on
>  {
>    HANDLE inuse;			// used to indicate that a tty is in use
>    HANDLE output_handle_nat, io_handle_nat;
> -  HANDLE slave_reading;
> -  LONG num_reader;
> +  LONG masked_cnt;
> =20
>    /* Helper functions for fchmod and fchown. */
>    bool fch_open_handles (bool chown);
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_in=
cludes/tty.h
> index c5102eb81..407565ce9 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -146,6 +146,8 @@ private:
>    bool discard_input;
>    bool stop_fwd_thread;
>    bool req_fixup_pcon_cur_pos;
> +  HANDLE slave_reading;
> +  LONG num_reader;
> =20
>  public:
>    HANDLE from_master_nat () const { return _from_master_nat; }
> --=20
> 2.51.0
>=20
>=20
