Return-Path: <SRS0=bLel=FB=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id E336F4BA2E07
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 10:44:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E336F4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E336F4BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783421044; cv=none;
	b=j3gKeUNhkc7mkJJbIvTQimsg4dsIIkXc5PR1Y3TqN+SN/EG7FGrMyiGi2WfaKag0TUsL5LL3hSWadCrlt2uEhI6KHxoEzGALo1ri0CM8MguCG+qgmXIWoSBJGYSevmQ/kTWavXg9fw2jXmd22GiWMngfuSElfGqVC0h/dmk9W2w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783421044; c=relaxed/simple;
	bh=ZCiTUhiwJwd+RHc6l+UcktAmUyS7KR9y56hcX7dX8IM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jiC/ME/9nSpvYdBYlQh8+/XycJIBvCZhPoBqYWnaFIP7mroBh0jkoQAC2wjH2lKa8WMdBurYN9v+TnKUsVY9srLMGO44SAIbUfl6SakZf4h4vzYypFPkN3ecd6QZCGFrLTJ3CZeJa1EvdMjHPjCH1+TSLCYamqt8TFjDiGCvv4w=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=i1JOvzI8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E336F4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=i1JOvzI8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783421042; x=1784025842;
	i=johannes.schindelin@gmx.de;
	bh=8cJLreTOVIDep3dTTvki5CMQ6GF29HGCN1Aiv8r4JBk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i1JOvzI8ibTuoQzJS9xPGRoXBAcST8Ul6Fb1OHyFA4XDMtVu1n0rvFFP4pPSPjfQ
	 I0FraxNoIxMYjyeiYfBUPaH8u/sCzwjPMDZaScVuAvmiZiedhosCTX/872+SKktmU
	 JVWY+Eh3VRrLGn1Ptj4GM+t7UNkXWtJ0evSD2QN8kV1HOT6EduFlEXlnwqO1ThHxS
	 XDu2ZBvppifinSs4NWRkXTe/k4JpHjgsT9yP8PsL2RllrxYIyuf7tTcthKYGvZsrx
	 9RSt2DuPKKdC1/eNTOxMbebFBZoLK96X0nMOHtUk2IaI1/p0W/1lwNcR3doi2m1jL
	 FtJcRR/Hp7Cxr1xYWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE2D-1wO0IT2rQx-00VxsH; Tue, 07
 Jul 2026 12:44:02 +0200
Date: Tue, 7 Jul 2026 12:44:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
In-Reply-To: <20260706032038.100981-1-takashi.yano@nifty.ne.jp>
Message-ID: <b5da6489-1222-5721-a361-2adb50830e2a@gmx.de>
References: <20260706032038.100981-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:YggmN2OQM9Z4qtIXy+2xKWasYZ8Ue5h6Oq0uzj2Hc3dFD4wFW+1
 vEU9JPp+4iy6pXO+pMOYDRH7dhKOHvV4sWj3n/J3g6BgpUdUhp3L+wlJTh9YilRJN8NL8NE
 8umq8X11gNvFT6CSjg2+xoLW5qv5yzJBdmcqLkCjmERClAbRVpAeKiK8NZXtwdO6AQmk6+f
 KID7JE6f/uafnEvHiveWQ==
UI-OutboundReport: notjunk:1;M01:P0:P4RpfXbmp8E=;BL711jNlwsl5xOYtuGabrXD7o2X
 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
 t+KKfcMgYo1zJCYCUvRObQ8U5iC6NAfrghjzVCQ
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for v3. Reverting the shared storage cleanly closes the
cross-process HANDLE hazard, and wrapping the CreateEvent/CloseHandle
block in acquire_attach_mutex/release_attach_mutex closes the
OpenEvent-based TOCTOU I had flagged on v2. One substantive concern
remains, around lock ordering.

On Mon, 6 Jul 2026, Takashi Yano wrote:

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
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Release all masks owned by myself on cleanup()
> v3: Reverts the change that made num_reader and slave_reading shared
>=20
>  winsup/cygwin/fhandler/pty.cc | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index ca85ae679..963f95801 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1282,6 +1282,10 @@ fhandler_pty_slave::open_setup (int flags)
>  void
>  fhandler_pty_slave::cleanup ()
>  {
> +  fhandler_pty_slave *arch =3D (fhandler_pty_slave *) archetype ? : thi=
s;
> +  while (arch->num_reader)
> +    mask_switch_to_nat_pipe (false, false);
> +
>    if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () =3D=3D mys=
elf->pgid)
>      req_fixup_pcon_state ();
> =20
> @@ -1543,19 +1547,22 @@ fhandler_pty_slave::write (const void *ptr, size=
_t len)
>  void
>  fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
>  {
> +  acquire_attach_mutex (mutex_timeout);
>    char name[MAX_PATH];
>    shared_name (name, TTY_SLAVE_READING, get_minor ());
>    HANDLE masked =3D OpenEvent (READ_CONTROL, FALSE, name);
>    CloseHandle (masked);
> =20
> +  fhandler_pty_slave *arch =3D (fhandler_pty_slave *) archetype ? : thi=
s;
>    WaitForSingleObject (input_mutex, mutex_timeout);
>    if (mask)
>      {
> -      if (InterlockedIncrement (&num_reader) =3D=3D 1)
> -	slave_reading =3D CreateEvent (&sec_none_nih, TRUE, FALSE, name);
> +      if (InterlockedIncrement (&arch->num_reader) =3D=3D 1)
> +	arch->slave_reading =3D CreateEvent (&sec_none_nih, TRUE, FALSE, name)=
;
>      }
> -  else if (InterlockedDecrement (&num_reader) =3D=3D 0)
> -    CloseHandle (slave_reading);
> +  else if (InterlockedDecrement (&arch->num_reader) =3D=3D 0)
> +    CloseHandle (arch->slave_reading);
> +  release_attach_mutex ();

The acquisition order here is attach_mutex first, then input_mutex.
Elsewhere in pty.cc the established order is the opposite: input_mutex
first, and attach_mutex only around the transfer_input call inside.
See for example setpgid_aux and cleanup_for_non_cygwin_app, both of
which do

        WaitForSingleObject (input_mutex, mutex_timeout);
        ...
        acquire_attach_mutex (mutex_timeout);
        transfer_input (...);
        release_attach_mutex ();
        ...
        ReleaseMutex (input_mutex);

and the same pattern appears at the open_setup path as well as two
further sites in pty.cc.

Since attach_mutex is a per-process unnamed mutex, declared and lazily
created at winsup/cygwin/fhandler/console.cc:1012-1015 in cygwin-3.6.9 as

        extern HANDLE attach_mutex;
        if (!attach_mutex)
          attach_mutex =3D CreateMutex (&sec_none_nih, FALSE, NULL);

this cannot deadlock across processes. It _can_ deadlock intra-process,
though: thread T1 in mask_switch_to_nat_pipe holds attach_mutex and waits
for input_mutex, while thread T2 in setpgid_aux (or any of the other
input_mutex-then-attach_mutex sites) holds input_mutex and waits for
attach_mutex. mutex_timeout is INFINITE on the normal paths (the 0-timeout
variants only appear on the GDB paths), so the resulting hang would be
hard rather than a graceful timeout. Threaded cygwin readers on a pty
(python with threads, tmux, gdb driving an inferior) are the plausible
triggers.

For the record, I had Claude check that no direct caller of
mask_switch_to_nat_pipe already holds input_mutex when calling it (the
read path even explicitly releases input_mutex before the
mask_switch_to_nat_pipe (false, false) call); so the risk is entirely from
a _concurrent_ thread in the same process, not from the caller itself.

Two possible shapes. The simplest is to swap the order inside
mask_switch_to_nat_pipe so it matches the rest of the file: acquire
input_mutex first, then attach_mutex around the CreateEvent/CloseHandle
block, and release in reverse. The interlock against transfer_input's
OpenEvent existence check should still hold, since transfer_input's
callers already take input_mutex before attach_mutex. If instead the new
order is required for some reason I am missing, it would be worth a
comment near the acquire explaining why, plus an audit that no
input_mutex-holding path can want attach_mutex from a concurrent thread.
Does the reasoning make sense to you, and does the swap sound right?

Ciao,
Johannes

> =20
>    if (!!masked !=3D mask && xfer && get_ttyp ()->switch_to_nat_pipe)
>      {
> @@ -4460,6 +4467,18 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir=
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
> +
>    HANDLE to;
>    if (dir =3D=3D tty::to_nat)
>      to =3D ttyp->to_slave_nat ();
> --=20
> 2.51.0
>=20
>=20
