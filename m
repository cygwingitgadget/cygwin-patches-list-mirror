Return-Path: <SRS0=doSl=B3=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id EBF974BA23D0
	for <cygwin-patches@cygwin.com>; Fri, 27 Mar 2026 15:25:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EBF974BA23D0
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EBF974BA23D0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774625141; cv=none;
	b=Hj8qW4smgquZZFU4dtAxpLOBR+udLc8J9oiWE6U8LK0ZSDdnRc6HGZfE/xXuU9F7pLqITwaIkDb9kthKtc+P9hM6qD1on8nqYp8iedOD3XoHlzKCMiunxWek15PwRb1Cu+hAmFhc+PUhbZY2WhzgsP56ydJSTw/ZA6n8vFffAvk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774625141; c=relaxed/simple;
	bh=CX0Tfnpebgf0fbBf2cqoBO2ROtTad58ymU8K2GIJtSA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=L0ecW1MeiHoyHVLR0MN4pWzVAkJuT/Vyu+KEwKIaE9u50hNAQLdX/HYxKFWqFagogfge1YHWMGefv8rFFuDOQ7mfuOjjOJ9wu8QRDMijg0SfEjbcZ26RjMr+9aisNVxJp6uBBmzzLn2M7qsEn4W2b+En5Szhe4guVTWJf/SNwAk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EBF974BA23D0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=EVQypN/Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774625139; x=1775229939;
	i=johannes.schindelin@gmx.de;
	bh=bXvisSlriGSINeamIxbqeabx5532EsDQEsJX9Ls493Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EVQypN/ZqgIEOOcXWUdJMcREQ2HQ+qIHTHkxAf+u9Qnr6tuOytpp4rBPz9C9bsSw
	 4R95IX15+kX1l8ZKynyUTH83SQPfS6A8oN3TR7rxxZiAKhJqcRAQjWi8c7QVj1MeT
	 Km1dHYFsOCTIG4zoJG/Z9/dPHfPqcvrfWeQZDOu6qLuhIvcXYB7K/eGvY+/NSsPc3
	 1tzNjAiH5S/Xw5bUGgy6ho7hgbyQNdIDIpfTqG+WPmcEVV32ehteFlATXI3Q6D98O
	 aPTulMlrmuRV/upOs5GcfJEEyDXUoBBA6fBMYRZhUtVCHGZnUdTIxDRUGgpifTbJ0
	 8GTw2PUP1bGkrWu98w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1w4HMI2wNF-00QvjU; Fri, 27
 Mar 2026 16:25:39 +0100
Date: Fri, 27 Mar 2026 16:25:37 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 6/7] Cygwin: pty: Guard to_be_read_from_nat_pipe() by
 pipe_sw_mutex
In-Reply-To: <20260325130453.62246-7-takashi.yano@nifty.ne.jp>
Message-ID: <90a27c2f-e001-abd8-9a7f-e85fc5ab4d92@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-1-takashi.yano@nifty.ne.jp> <20260325130453.62246-7-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lecDbnnX4SDeS0rGamnOAVbOX0eycqR/zNEyTZAS4C4cgA3SuPT
 MobTt1aLWb+WXAaHue55YTya80VYF3SKHF2iXwNwuO12tdEk/rtUtTCpuroxYQDXFu9vjJZ
 oR+oZwwTl8hgU9uRA1uFj6B7bPCifLWSpMms/lXg+6ll59Nef9IzoKlPmtvUd6rX+v+KwVG
 awZH+HWYL/l8Whxd1iIMw==
UI-OutboundReport: notjunk:1;M01:P0:kJ8k+2JipRU=;2of6NR5IL00ivZAvTuLs5wa7iW7
 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
 eGNFWzKGtLsqgOs/jugTHDYg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This patch is essential: without it, `master::write()` can read
`switch_to_nat_pipe`, `pcon_activated`, and `pty_input_state` at
different points during a slave-side transition, making an inconsistent
routing decision that sends keystrokes to the wrong pipe. The fix is
sound.

A few notes inline, plus a request to rework the commit message.

On Wed, 25 Mar 2026, Takashi Yano wrote:

> If to_be_read_from_nat_pipe() is called during pipe switching between
> cygwin pipe and nat pipe, the return value mignt not as expected due

Typo: "mignt" -> "might".

> to incomplete state change. With this patch, to_be_read_from_nat_pipe()
> is guarded by pipe_sw_mutex to avoid that. In addition, duration of
> the acquiring the pipe_sw_mutex is reduced to avoid deadlock.

"duration of the acquiring the pipe_sw_mutex" is awkward. More
importantly, the commit message buries the most critical aspect of this
patch: the lock ordering constraint.

The key insight is this: `to_be_read_from_nat_pipe()` is called from
`master::write()`, which already holds `input_mutex`. If
`to_be_read_from_nat_pipe()` now acquires `pipe_sw_mutex`, the lock
order on the master side becomes: `input_mutex` first, then
`pipe_sw_mutex`. Meanwhile, `cleanup_for_non_cygwin_app()` and
`setpgid_aux()` previously acquired `pipe_sw_mutex` first, then
`input_mutex` (via `transfer_input()`). That is a textbook lock ordering
problem ("ABBA deadlock").

The restructuring in this patch fixes it by ensuring those functions
release `pipe_sw_mutex` before acquiring `input_mutex`, maintaining a
consistent lock order.

I would suggest a commit message body that explains:

  (a) the inconsistent-read problem (reading `switch_to_nat_pipe`,
      `pcon_activated`, etc. without holding `pipe_sw_mutex`),
  (b) the solution (guard `to_be_read_from_nat_pipe()` with
      `pipe_sw_mutex`),
  (c) the lock ordering constraint and how the restructuring of
      `cleanup_for_non_cygwin_app()` and `setpgid_aux()` avoids the
      ABBA deadlock, and
  (d) the `pcon_start` spin-wait design (why the function returns
      false immediately when `pipe_sw_mutex` cannot be acquired and
      `pcon_start`/`pcon_start_pid` is set).

That way a future reader does not have to reverse-engineer the
reasoning from the diff.

Maybe something like this?

    `to_be_read_from_nat_pipe()` reads several shared-memory fields
    (`switch_to_nat_pipe`, `pcon_activated`, `pty_input_state`) to
    decide whether keystrokes should go to the nat pipe. It is called
    from `master::write()` on every keystroke. Without synchronization,
    the slave can be in the middle of a pipe switch (changing these
    fields in `setup_for_non_cygwin_app()`, `cleanup_for_non_cygwin_app()`=
,
    or `setpgid_aux()`) while the master reads a half-updated snapshot,
    making an inconsistent routing decision that sends keystrokes to the
    wrong pipe.

    Guard `to_be_read_from_nat_pipe()` with `pipe_sw_mutex` so it
    always reads a consistent state. The spin-wait at entry handles the
    pseudo console initialization case: when `pipe_sw_mutex` is held by
    the slave during `setup_pseudoconsole()` and `pcon_start` is set,
    the function returns false immediately, routing keystrokes to the
    cyg pipe through `line_edit()` where the CSI6n response handler
    expects them.

    Acquiring `pipe_sw_mutex` inside `to_be_read_from_nat_pipe()`
    creates a lock ordering constraint: `master::write()` holds
    `input_mutex` before calling `to_be_read_from_nat_pipe()`, so the
    master's lock order is `input_mutex` then `pipe_sw_mutex`.
    Previously, `cleanup_for_non_cygwin_app()` and `setpgid_aux()`
    acquired `pipe_sw_mutex` first and then `input_mutex` (for
    `transfer_input()`), which is the reverse order and would deadlock.
    Restructure both functions to release `pipe_sw_mutex` before
    acquiring `input_mutex`, maintaining a consistent lock order
    throughout.

>=20
> Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.=
")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 50 +++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 0de6ec007..c7e3ddf50 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1311,22 +1311,44 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (boo=
l mask, bool xfer)
>  bool
>  fhandler_pty_common::to_be_read_from_nat_pipe (void)
>  {
> +  /* If the slave is in setup_pseudoconsole(), pipe_sw_mutex cannot
> +     be acquired because the slave has it. In this case pcon_start
> +     will be asserted. During pcon_start, other input than response
> +     to CSI6n should be go to cyg-pipe. So, wait for pcon_start and
> +     return false. */
> +  while (WaitForSingleObject (pipe_sw_mutex, 0) =3D=3D WAIT_TIMEOUT)
> +    if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_pid)
> +      return false;
> +    else
> +      yield ();
> +
> +  bool ret =3D false;
>    if (!get_ttyp ()->switch_to_nat_pipe)
> -    return false;
> +    goto out;
> =20
> -  char name[MAX_PATH];
> -  shared_name (name, TTY_SLAVE_READING, get_minor ());
> -  HANDLE masked =3D OpenEvent (READ_CONTROL, FALSE, name);
> -  CloseHandle (masked);
> +  do
> +    {
> +      char name[MAX_PATH];
> +      shared_name (name, TTY_SLAVE_READING, get_minor ());
> +      HANDLE masked =3D OpenEvent (READ_CONTROL, FALSE, name);
> +      CloseHandle (masked);
> =20
> -  if (masked) /* The foreground process is cygwin process */
> -    return false;
> +      if (masked) /* The foreground process is cygwin process */
> +	goto out;
> +    }
> +  while (false);

The `do { ... } while (false)` block around the `TTY_SLAVE_READING`
check: this wraps a simple linear sequence with no `break` and no
actual loop. It looks like an artifact of the restructuring, perhaps to
scope the `name` variable. Could this be simplified to a plain block
`{ ... }`? That would be less surprising to a reader.

Regarding the spin-wait at the top of `to_be_read_from_nat_pipe()`:
the `else yield()` path blocks `master::write()` indefinitely when
`pipe_sw_mutex` is held by the slave for reasons other than
`pcon_start`. The comment says the slave holds it "briefly during state
transitions," which is true in practice, but it would be worth noting
this blocking behavior in the commit message so that future readers
understand the assumption.

Thanks,
Johannes

>    if (!pinfo (get_ttyp ()->getpgid ()))
>      /* GDB may set invalid process group for non-cygwin process. */
> -    return true;
> +    {
> +      ret =3D true;
> +      goto out;
> +    }
> =20
> -  return get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
> +  ret =3D get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
> +out:
> +  ReleaseMutex (pipe_sw_mutex);
> +  return ret;
>  }
> =20
>  void
> @@ -3948,7 +3970,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR=
 *env)
>      goto maybe_dumb;
> =20
>    /* Check if terminal has CSI6n */
> -  WaitForSingleObject (pipe_sw_mutex, INFINITE);
>    WaitForSingleObject (input_mutex, mutex_timeout);
>    /* Set pcon_activated and pcon_start so that the response
>       will sent to io_handle_nat rather than io_handle. */
> @@ -3984,7 +4005,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR=
 *env)
>    while (len);
>    get_ttyp ()->pcon_activated =3D false;
>    get_ttyp ()->nat_pipe_owner_pid =3D 0;
> -  ReleaseMutex (pipe_sw_mutex);
>    if (len =3D=3D 0)
>      goto not_has_csi6n;
> =20
> @@ -4000,7 +4020,6 @@ not_has_csi6n:
>    get_ttyp ()->pcon_start =3D false;
>    get_ttyp ()->pcon_activated =3D false;
>    ReleaseMutex (input_mutex);
> -  ReleaseMutex (pipe_sw_mutex);
>  maybe_dumb:
>    get_ttyp ()->pcon_cap_checked =3D true;
>    return false;
> @@ -4318,7 +4337,6 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (ha=
ndle_set_t *p, tty *ttyp,
>  						DWORD force_switch_to)
>  {
>    ttyp->wait_fwd ();
> -  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
>    if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
>      {
>        DWORD switch_to =3D get_winpid_to_hand_over (ttyp, force_switch_t=
o);
> @@ -4334,6 +4352,7 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (ha=
ndle_set_t *p, tty *ttyp,
>  	  ReleaseMutex (p->input_mutex);
>  	}
>      }
> +  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
>    if (ttyp->pcon_activated)
>      close_pseudoconsole (ttyp, force_switch_to);
>    else
> @@ -4352,6 +4371,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
>    if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
>        && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
>      {
> +      ReleaseMutex (pipe_sw_mutex);
>        WaitForSingleObject (input_mutex, mutex_timeout);
>        acquire_attach_mutex (mutex_timeout);
>        transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> @@ -4362,6 +4382,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
>    else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
>  	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
>      {
> +      ReleaseMutex (pipe_sw_mutex);
>        bool attach_restore =3D false;
>        HANDLE from =3D get_handle_nat ();
>        DWORD resume_pid =3D 0;
> @@ -4389,7 +4410,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
>  	release_attach_mutex ();
>        ReleaseMutex (input_mutex);
>      }
> -  ReleaseMutex (pipe_sw_mutex);
> +  else
> +    ReleaseMutex (pipe_sw_mutex);
>  }
> =20
>  bool
> --=20
> 2.51.0
>=20
>=20
