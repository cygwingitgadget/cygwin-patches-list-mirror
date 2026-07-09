Return-Path: <SRS0=y6DA=FD=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 6DACD4BA5435
	for <cygwin-patches@cygwin.com>; Thu,  9 Jul 2026 08:13:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6DACD4BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6DACD4BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783584813; cv=none;
	b=N2a6642ZCRPUGGBNl5TZP0CFuJTngWgjJF0QuinVehCjHqD7c5kqbWDa2WOUNhbEP5EGW9WRt3ltMSFNrRthTmsT32ECyIKHllEZUA0Ptg5f2c2uoi0/RKpG+i2q4XVHRrcjO6LnsDlNWYpw0BwCexHDs8C0FfdiHimDvu7U8Ek=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783584813; c=relaxed/simple;
	bh=+nzTDjW6FREetCCLTqD7YJ3kolSVGRN/Llp0RYGRZ9I=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Kl6h7cosvy683zQQBdTDHM10t0882RzEkFJmN5YgCgJK5q9km2D8w7g6ipAyZSKaYdZgTr2h6jzYywylSIcrALdglDaZi/ZUWJ+MHmMHXWVJg0LhyLcNug0BsIf1lf7LQzlUWeY809fvGV9Z3GHtuQjv+bzGx20mKtCtLKbWFz4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=r5UYEBT/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6DACD4BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=r5UYEBT/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783584805; x=1784189605;
	i=johannes.schindelin@gmx.de;
	bh=XYVbL1zBlDxKpup13wr/l7hqjlTq90AVise8iwEnCiU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r5UYEBT/ZMEwoxds85zqG3gbS8Iwo38+ispL41j/HXUaymBBP4QcxaNd4qlct3zL
	 KzR95luUtTy9wiI3uzFYM15O2/4Ex8kP0HcFn2O+37K3ATY7MyfDm5clTSefX/5BF
	 4r6X/DDhzcpGq+6ElTnFMA6zvu2nLnsKkOT2Vft+eAjXG8ZNtDSpTxM8yp1zZtaRi
	 8pdus2t5gX47kEYGQmAZeStFF59DDFR0ep2jkjHZgBa37rEyqAKSvuZ4PmMC4Ood5
	 TfDRbPuCVpp4xZ34jXNCVkO9ZBtclimTpVXIG5Eo2iDfF4LvoW251TO8VWazXanJJ
	 ioftUfD5unxCMfPphQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGeB-1wY5FW1eNv-00YvLI; Thu, 09
 Jul 2026 10:13:25 +0200
Date: Thu, 9 Jul 2026 10:13:26 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Fix nat_pipe_owner_pid when gdb runs
 non-cygwin app
In-Reply-To: <20260708143017.1073-1-takashi.yano@nifty.ne.jp>
Message-ID: <843d06c0-22a2-1937-6b6a-92adb4d09342@gmx.de>
References: <20260708143017.1073-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:BrVFPo+AVlr955E3OZA9bjYD22mc24XMXNEJJ6FZ/BM7YzTjuzI
 q2OY4duVBlvOnXaLiTTQwsyYSHPgPl1A+eDSItOyxNw7FNY+v5xQnxTUuKBUFhY08afeXzw
 WA8q9+JO4GNJXf7EW/FIukgsfJ6NJjnjK76tZjjny0fUPz7jlOohJCMTVya9PGjicbmyEJZ
 AAotnLpAXUsVDCbnVey9A==
UI-OutboundReport: notjunk:1;M01:P0:7/yPzVh4gyE=;cwL/B8qJza+XK0N2DL2wgrxaN6x
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 8 Jul 2026, Takashi Yano wrote:

> Previously, nat_pipe_owner_pid was incorrectly set to 0 when the
> inferior of gdb was a non-cygwin app. Due to this bug, repeatedly
> running a non-cygwin app under gdb could lead to an unexpected crash.
>=20
> This occurred because the previous code in setup_for_non_cygwin_app()
> set nat_pipe_owner_pid to exec_dwProcessId, which is correct when the
> caller is the stub process of the non-cygwin app. However, when the
> caller is gdb, the owner should be gdb itself, so nat_pipe_owner_pid
> must be set to myself->dwProcessId.
>=20
> With this fix, attach_console_temporarily() can be called with target
> pid equal to the process's own pid, in which case the attach operation
> is skipped.
>=20
> Fixes: 1e6c51d74136 ("Cygwin: pty: Reorganize the code path of setting u=
p and closing pcon.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
> v2: Skip attaching operation when attaching to myself is requested.

=46rom what I can see, the fix is correct. Three non-blocking notes:

The new source comment (and the commit message) has exec_dwProcessId and
dwProcessId the wrong way round, I think. exec_dwProcessId holds the
stub's own pid, saved before the overlay; dwProcessId is what gets
repointed to the native child. The code still does the right thing because
`exec_dwProcessId ?: dwProcessId` reduces to "our own pid" on every path
that reaches it, which is exactly what the owner-self check already
assumes. But the commentary as written will mislead the next reader.

The sibling assignment in `setup_pseudoconsole()` still writes
exec_dwProcessId directly, without the fallback. Harmless today because
its sole caller sets the owner first, but leaving the two spots
inconsistent invites a future regression. Worth applying the same `?:`
there.

Also: I believe that the bug is not really gdb-specific: _any_ Cygwin
process that spawns a non-cygwin app through the CreateProcess hook
without _P_OVERLAY hits it. If that is so, the subject and log undersell
the scope.

In any case, I happily provide my:

  Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Ciao,
Johannes

>=20
>  winsup/cygwin/fhandler/pty.cc | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 1b453a499..6ef4fa506 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -4734,7 +4734,11 @@ fhandler_pty_slave::setup_for_non_cygwin_app (boo=
l nopcon,
>        fhandler_pty_slave *ptys =3D (fhandler_pty_slave *) fh;
>        ptys->get_ttyp ()->switch_to_nat_pipe =3D true;
>        if (!process_alive (ptys->get_ttyp ()->nat_pipe_owner_pid))
> -	ptys->get_ttyp ()->nat_pipe_owner_pid =3D myself->exec_dwProcessId;
> +	/* In normal case where the current process is the stub process for
> +	   non-cygwin app, set owner to exec_dwProcessId (non-cygwin app).
> +	   However, in gdb case, gdb itself should be the owner. */
> +	ptys->get_ttyp ()->nat_pipe_owner_pid =3D
> +	  myself->exec_dwProcessId ? : myself->dwProcessId;
>      }
>    bool pcon_enabled =3D false;
>    if (!nopcon)
> @@ -4862,6 +4866,8 @@ fhandler_pty_common::attach_console_temporarily (D=
WORD target_pid)
>  {
>    DWORD resume_pid =3D 0;
>    acquire_attach_mutex (mutex_timeout);
> +  if (target_pid =3D=3D GetCurrentProcessId ())
> +    return target_pid;
>    pinfo pinfo_resume (myself->ppid);
>    if (pinfo_resume)
>      resume_pid =3D pinfo_resume->dwProcessId;
> @@ -4880,6 +4886,11 @@ fhandler_pty_common::attach_console_temporarily (=
DWORD target_pid)
>  void
>  fhandler_pty_common::resume_from_temporarily_attach (DWORD resume_pid)
>  {
> +  if (resume_pid =3D=3D GetCurrentProcessId ())
> +    {
> +      release_attach_mutex ();
> +      return;
> +    }
>    bool console_exists =3D (resume_pid !=3D (DWORD) -1);
>    if (!console_exists || resume_pid)
>      {
> --=20
> 2.51.0
>=20
>=20
