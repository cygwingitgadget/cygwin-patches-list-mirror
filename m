Return-Path: <SRS0=e8/d=E6=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 8F6EC4BA79AD
	for <cygwin-patches@cygwin.com>; Sat,  4 Jul 2026 12:38:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8F6EC4BA79AD
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8F6EC4BA79AD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783168740; cv=none;
	b=DvQ1rvGWcg5nHaKnb+EAF/eRRxbm/DxI2/Q0Zd7qaXJm09cX8P+mTtd9sTNSFCTuZYaFc4CGd10IeutFH3csmfvp554LPQNzfpDAvXY7HqUNAO9HlJ76JqM/K4KAUW+IubWUexNSPLoYRajwXHVe/8aBFFBX0EDlXgZv0j74/A8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783168740; c=relaxed/simple;
	bh=qud/kpbfH2zfM4uHcFSbzmzhD6qWljGbMjZFNm80OZY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mnQi1FqCaohgvuUimF8Xgxa7nMgXdRQS6VdxmpxbBF1CYOCCuBtnfAUTDfe3lFY48iuEoVFSoDYWiqbckJh2zO4uOBKkdVp8Cv+CaqBGSXapHUyAl2Itsl0c4YnBB+TCgqiCzc9jHTw4MOGAOm+gC2n7MIACzQLCpnyH7blfE+0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KqjkLm/O
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8F6EC4BA79AD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KqjkLm/O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783168732; x=1783773532;
	i=johannes.schindelin@gmx.de;
	bh=aexpI4ZaZI6BJZe4/z57XKVIqD7wKUEkK7yRsTcq8J8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KqjkLm/OSXmYrnotPRIhzvIAHbTBzoMgj42GDnqisiZLpSzL1VnDIe7hyWbno9k5
	 ZV6NdhNrgTNXQxBiZWpimewwzVsvB6akgCQ+oFOKsVSIxj1a7O3mgwxJ5wO4SKXfj
	 yLZxEqCVm4ZTJ0gIoujfFmdBgU6HlaPsrOhjH8704HgKOHs4YyDtllWg/TV+UlJ5C
	 j7gW47HDVfpHh1G7NkBgyg5+Mnt+1HtGC0zk1Sf+5WslAVlgt50ZDbBOSHNsWhOs/
	 A1/D9+7E7lC+YOybUR/sJfaO7cS+kxSr8J8dedeuH1aA9wEvCB8KyPpx4iYf+gzC3
	 27khPAMI6hDHP7RnTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1xJ98t2RDT-00gn9J; Sat, 04
 Jul 2026 14:38:52 +0200
Date: Sat, 4 Jul 2026 14:38:55 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: re-enable the master thread before
 selecting cygwin input mode
In-Reply-To: <20260630114735.118967-1-takashi.yano@nifty.ne.jp>
Message-ID: <69136f7a-24a3-0d96-7ef5-2d444aad8d7c@gmx.de>
References: <20260630114735.118967-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=83233281589620911783168735142343
X-Provags-ID: V03:K1:K0LR0E7O72MijraNu5g0rah+Jza8qXdiKflDbpHtYndZXh3mFoh
 ncQWIDD5784zfyILQF9V4GQFMC/70alKeYwv/pR68RXZ8f67WjdP9dtXT3zzI4taF5sZGIg
 soSEPKTLnu4E9KSeILfxcyYFOcWq2tdFHAFTSqkG3XaCYO+YDRgFeiblnI1kzRpSKHbXtic
 Y2OSB9riPr7a6yaaDDOXg==
UI-OutboundReport: notjunk:1;M01:P0:vo+QOUgiygc=;n3GH8RTHR9O1hTm8tUyTvm4ni3U
 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
 =
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--83233281589620911783168735142343
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Tue, 30 Jun 2026, Takashi Yano wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> When a cygwin program and a non-cygwin program run in the same foregroun=
d
> process group (for example the pipeline `cat | ping`), Ctrl-C stopped
> interrupting the cygwin program after "Cygwin: console: Ensure the maste=
r
> thread runs only when it is supposed to".
>=20
> The console only delivers Ctrl-C as a raw 0x03 byte (which the console
> master thread reads and turns into a SIGINT for the foreground process
> group) while that thread is live. When it is suspended or disabled,
> set_input_mode (tty::cygwin) instead requests ENABLE_PROCESSED_INPUT, so
> the console raises a CTRL_C_EVENT and the 0x03 byte never reaches the
> master thread. The referenced commit reordered the two enable paths,
> bg_check () and post_open_setup (), so that set_input_mode (tty::cygwin)
> runs while disable_master_thread is still set; that leaves
> ENABLE_PROCESSED_INPUT on and the cygwin program never receives its SIGI=
NT.
>=20
> Clear disable_master_thread before selecting cygwin input mode in those =
two
> paths, so the mode is configured with the master thread already live and
> ENABLE_PROCESSED_INPUT stays off. The disable paths and the synchronous
> suspension that the referenced commit added are left unchanged, so
> non-cygwin programs still get the master thread reliably suspended.
>=20
> Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs onl=
y when it is supposed to")
> Assisted-by: Opus 4.8
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Co-Authored-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---

Thank you for extending this patch! My only concern: The commit message
still says "the two enable paths,=C2=A0bg_check () and post_open_setup ()"=
 and
"Clear=C2=A0disable_master_thread before selecting cygwin input mode in th=
ose
two paths."

With the `cleanup_for_non_cygwin_app()` hunk added, this needs to say
three paths and enumerate them. Also, "clear" isn't accurate for the
cleanup path where the argument is `con.owner =3D=3D GetCurrentProcessId()=
`,
not literal `false`. Maybe "set `disable_master_thread` to its target
value before..."?

The functional change looks like a real improvement over the version I had
sent. The reorder is internally consistent, the asymmetry with the
"disable" paths is correct, and the change is a strict improvement (no
regressions for the owner of the `tty:restore` sub-cases, and closes a
latent bug for the non-owner `tty::cygwin` sub-case). I integrated it into
https://github.com/git-for-windows/msys2-runtime/pull/131 just to be extra
certain, and the AutoHotKey-based UI tests still show that the tested
scenarios do not regress.

Thank you!
Johannes

>  winsup/cygwin/fhandler/console.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 1e4367816..730bb0b45 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -991,6 +991,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle=
_set_t *p)
>    termios *ti =3D shared_console_info[unit] ?
>      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
>    /* Cleaning-up console mode for non-cygwin app. */
> +  set_disable_master_thread (con.owner =3D=3D GetCurrentProcessId ());
>    /* conmode can be tty::restore when non-cygwin app is
>       exec'ed from login shell. */
>    tty::cons_mode conmode =3D cons_mode_on_close (p);
> @@ -998,7 +999,6 @@ fhandler_console::cleanup_for_non_cygwin_app (handle=
_set_t *p)
>      set_output_mode (conmode, ti, p);
>    if (con.curr_input_mode !=3D conmode)
>      set_input_mode (conmode, ti, p);
> -  set_disable_master_thread (con.owner =3D=3D GetCurrentProcessId ());
>  }
> =20
>  /* Return the tty structure associated with a given tty number.  If the
> @@ -1191,8 +1191,8 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>       in the same process group. */
>    if (sig =3D=3D SIGTTIN && con.curr_input_mode !=3D tty::cygwin)
>      {
> -      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
>        set_disable_master_thread (false, this);
> +      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
>      }
>    if (sig =3D=3D SIGTTOU && con.curr_output_mode !=3D tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> @@ -2111,8 +2111,8 @@ fhandler_console::post_open_setup (int fd)
>    /* Setting-up console mode for cygwin app started from non-cygwin app=
. */
>    if (fd =3D=3D 0)
>      {
> -      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
>        set_disable_master_thread (false, this);
> +      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
>      }
>    else if (fd =3D=3D 1 || fd =3D=3D 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> --=20
> 2.51.0
>=20
>=20

--83233281589620911783168735142343--
