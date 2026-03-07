Return-Path: <SRS0=qb86=BH=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id BB7EA4BA2E11
	for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2026 07:44:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BB7EA4BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BB7EA4BA2E11
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772869474; cv=none;
	b=Eh7ezI54j0Ixf46NgZD4txjD89qjNucyNVdGX0UtMP/vgSPxmqmh1BIsjuJj7m3G9ui30F+D6w1/SBvTiQGPO/MfFZM/JhG9M3WOP/lr7DVbRTgo6uN4nZAXxSKC0BKfFdQPWQh4salJWbKbkDRkSiMWI5v3EaE1ldnK5SzWEaE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772869474; c=relaxed/simple;
	bh=cwzHxiti4tR3IA6Be/vaOCcRoLWdC5IQdr2HARARls0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=RLT4lpxazZ6XchT1VbxVOz/cgXWqDHeLl+FirnLUfx1myucLXdMYLSiulPFLbxyGK7aZKf7Xsgtq7sD4vWl2xEp3llxtweQTfdFQbjYgySy2Q1HrhQI+Irz+wT3uzoTKexnTW9qgMejAGTrADVXPXmbbwOIbrfT+Xk/oYZZ9o7Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BB7EA4BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=PsLoB2Jt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772869466; x=1773474266;
	i=johannes.schindelin@gmx.de;
	bh=FyrJijOdM5oWaNNlE8FCGi4VeyFo4FrijRHJgHhqHVg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PsLoB2JtgFe4P9cxYGh+TvgskDqI6r3nJcqnEzI2wEco4Bhqt8ite4qzo4ofxZjU
	 whGX2vd0F09pv0woz7GcsyhNvsatix56NuAKdOtded541DGqersYP2bB9dCrpO4Bt
	 HXUs0xFtiMNXYNtutAqNfWXgxaSw9sAzVcUqyjA45wVHqxnG4FJADpFWgbEu45v4Q
	 QS6MmeR3ht7oc3Vnu/QB+tNIMCORd6leXlS8OOs2QAJwhAiO+hc182Pi3mPA/Ju6V
	 QWPl9TwX1JErCZ68juSLbVVSoofz5osn6MkqtZNOa1tYkjlcehPfLJ3+MAWuiXizz
	 lY4NjQc4/8EG9rbgtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1vSzwv2oeh-00k4D3; Sat, 07
 Mar 2026 08:44:26 +0100
Date: Sat, 7 Mar 2026 08:44:24 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Fix out-of-order keystrokes
In-Reply-To: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
Message-ID: <d734978f-4941-616a-b7f0-a688d463f912@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com> <20260303212405.25a2db7d786ac2db324e8f7a@nifty.ne.jp> <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7iSDMJ+EjuaQZeuZMHlbOfrITp8hx5LEj/FuDEzk5+U2RHJhJxh
 GfH7/ElLr9Pf/vbaGFY53qN4WTWWUrxizt9WfKUCi9cWxY8YzxdUh8S08vGfwZMg52eqPeg
 edUbGqelZ+flVvysP03cznEqIZIqZM6wmXVTqlITfkmgipYCzVA/jOKyT2ubB4K/qWtuGEs
 sSjntLabP1pWqA3G8zx9g==
UI-OutboundReport: notjunk:1;M01:P0:zbrzkvZCbls=;qAFsDmGjAHSsOx4w1LrisILxIry
 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
 e307Dy15NJ3WFUN8BKXBa4YqWhp5Y
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 6 Mar 2026, Johannes Schindelin wrote:

> On Tue, 3 Mar 2026, Takashi Yano wrote:
>=20
> > On Mon, 02 Mar 2026 14:24:36 +0000
> > "Johannes Schindelin wrote:
> > > A Git for Windows user reported that typing in a Bash session while =
a native
> > > Windows program is running (or has just exited) can produce scramble=
d input
> > > -- e.g. typing "git log" yields "igt olg":
> > > https://github.com/git-for-windows/git/issues/5632
> > >=20
> >=20
> > [...]
> >=20
> > In addition, after applying these four patches, non-cygwin apps
> > lose its input. Please try cmd.exe in pcon_activated mode.
>=20
> When I tried this with the MSYS2 runtime, it simply worked. But when I
> tried it in Cygwin, it reproduced! To be clear, this is the meaning I
> extracted from the quoted text:
>=20
> 	Patch 2/4 "Cygwin: pty: Remove pcon_start readahead flush that
> 	displaces readline data" is too broad, it breaks the scenario when
> 	in an interactive Bash session in a MinTTY window (without
> 	`disable_pcon`), `cmd.exe` is launched interactively: You will see
> 	the typed characters, but `cmd.exe` won't receive them.
>=20
> And this indeed reproduced here, but only with Cygwin. In MSYS2, it stil=
l
> worked with the patches as-are. I will keep investigating, but in the
> meantime I'd like to propose this fixup:
>=20
> -- snip --
> Subject: [PATCH] fixup! Cygwin: pty: Remove pcon_start readahead flush t=
hat
>  displaces readline data
>=20
> ---
>  winsup/cygwin/fhandler/pty.cc | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 693e1a8062..1a3c50721b 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2216,6 +2216,11 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>        if (!get_ttyp ()->pcon_start)
>  	{ /* Pseudo console initialization has been done in above code. */
>  	  pinfo pp (get_ttyp ()->pcon_start_pid);
> +	  if (get_ttyp ()->switch_to_nat_pipe
> +	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
> +	    {
> +	      get_ttyp ()->pty_input_state =3D tty::to_nat;
> +	    }
>  	  get_ttyp ()->pcon_start_pid =3D 0;
>  	}
> =20
> -- snap --

Unfortunately, I only tested this with `cmd.exe` without verifying that it
won't reintroduce the originally-reported problem. And sure enough, it
does.

The reason is no longer "data stealing", it's the fast path bypassing
`line_edit()` for some keystrokes. The result is the same: some keystrokes
arrive at `line_edit()` while the backspaces arrive at the `nat` pipe via
said fast path.

If you have any splendid idea how to fix this problem so that both the
`cmd.exe` as well as the oscillation problem are fixed, please do share.

Ciao,
Johannes
