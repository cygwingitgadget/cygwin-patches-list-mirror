Return-Path: <SRS0=0Xp7=FR=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id D5ACA4BA2E07
	for <cygwin-patches@cygwin.com>; Thu, 23 Jul 2026 11:47:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D5ACA4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D5ACA4BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784807236; cv=none;
	b=lfSIlTGNFGNqm9E++ea5llCEIT1Sb//apqwijrP1echr2hPP/5CaWQ4/GfZ+R065fhgGcTROA89b2h47zqCxWkdSc6VmV63mFXWCavuE0TwfyE5BfPtNjgfFhALCFZozSf6tlC2zSKlJvVPv3R+xcEQDY8C9f4cjt8OKP7PxgIU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784807236; c=relaxed/simple;
	bh=0OaUxqFmJpstr+SdgJIfRpYYjbc8OH8X4VSIdoC+CfE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=DB/Doh1Dgko2oh/pAuw+y8f8KcSlAci6b2oYeZqkfXUzxjghONdaDoPAqqIPQV66DwVnnxf0Wv8arLxSwK9jf+UqYD2nIdXi85fghcnbYgR6zmon5h2AXYC+PBOezp0qZd8t6E1d4tqyj+9Vf331pR73zh22xIzjjYHnPQmj8vw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qUensc1+
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D5ACA4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=qUensc1+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784807234; x=1785412034;
	i=johannes.schindelin@gmx.de;
	bh=XM0PZF8+MADoN8KJW8G69eOgJ2lSFz3B02QMklrKc50=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qUensc1+RR6acBL9eGHBFKnYg96hq4H/o6WccXmTr2HyIvGmutiEYV97rcoeISiG
	 ZwpBqZ4z3XCB1WRYNHs6TOfM0I94ifc2xxztiJ1wgSSAxLqeFD7Q0wpvD9dOAIh0E
	 3YuiB5yBuL5NtnhjQxOMjp6Bnq4H9q9ahJCUzqLdHrXaEM84F8nhHGuUlzLl+3Y/R
	 4CJDfHFHL2rSLJ9FhNbiH2atLmX73IB7O2n65f55sffoWG2Bz1uQwxHMWWTYpMxkF
	 e+8toahNLuDlec45zF52CNs1BL65oE4cgr5VfJj8jGgmUL+HvSKKQfAKT1pWEyvWb
	 Rx7AdKXVrh3plN6oqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1x3MvV1XdH-0153vS; Thu, 23
 Jul 2026 13:47:14 +0200
Date: Thu, 23 Jul 2026 13:47:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix cursor position on new nat app in
 existing pcon
In-Reply-To: <20260720200802.436-1-takashi.yano@nifty.ne.jp>
Message-ID: <9bdf8a92-bc23-109c-0905-78139f0bfe54@gmx.de>
References: <20260720200802.436-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:P5vW5/+6kIavimpxSNQIU+N72LnBzpJS9gOFKGTpejZyUCMPNVr
 xWBysu+lyL8fVzAgntDlSm42EzsoVZnODLE5n6GWhTOz9mJCgfab2QZBOjTJ7ZzaXzjZAgg
 0oIKtHd2p7poPXujUuGvujo1L1qGElr9jfq3RMgpJS2A30j6z1hb8wKmCNS6ePJWw13iHrG
 xatl+nwQrY3HaXSTTZbew==
UI-OutboundReport: notjunk:1;M01:P0:31TLm8yA2+U=;yLXTwC9MY8tK6FC7/+Y1U1P/WJj
 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
 rX5wHCWwAEEvkj+tShTI0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thanks! This is correct and well-targeted. It should go in.

On Tue, 21 Jul 2026, Takashi Yano wrote:

> Previously, the steps: cmd.exe -> bash -> cmd.exe exhibit broken
> cursor position even with the commit b34394d456b6 ("Cygwin: pty:
> Fixup pty state after a cygwin app exits").
>=20
> This patch sets req_fixup_pcon_cur_pos also when reusing existing
> pseudo console as well as req_xfer_input.

The coupling in `setup_pseudoconsole()` is sound: Before this patch, only
`req_xfer_input` would be set, and a reply to CSI6n would simply be
swallowed. With this patch, the reply is consumed instead (and
intentionally not forwarded), the same handshake `req_fixup_pcon_state()`
already performs.

It complements b34394d456 (Cygwin: pty: Fixup pty state after a cygwin app
exits, 2026-06-13) by covering the sibling boundary: a new native app
reusing the existing pseudo console (your cmd.exe -> bash -> cmd.exe
case), rather than a cygwin app exiting.

One pre-existing race, not a blocker: the reuse branch sets
`pcon_start_pid` without the spin-until-clear reservation loop
`req_fixup_pcon_state()` uses, and the master clears `pcon_start_pid`
outside `input_mutex` (the store sits just past `ReleaseMutex`). So an
overlapping handshake from another process can clobber it to zero early,
and the slave stops spinning before its own DSR reply is handled. Before
this patch that stray late reply was harmless (swallowed); now it could
drive a stale `fixup_pcon_cursor_position()`. Probability is very low, and
the same exposure already exists via `req_fixup_pcon_state()`, so the
verdict stands. Optional separate fix: move the clear inside
`input_mutex`, and/or give the reuse branch the reservation loop.

  Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Johannes

> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index f3df55f34..a100c868e 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -3850,6 +3850,7 @@ fhandler_pty_slave::setup_pseudoconsole ()
>  	  WaitForSingleObject (input_mutex, mutex_timeout);
>  	  get_ttyp ()->req_xfer_input =3D true; /* indicates that this "ESC[6n=
"
>  						 is just for transfer input */
> +	  get_ttyp ()->req_fixup_pcon_cur_pos =3D true;
>  	  get_ttyp ()->pcon_start =3D true;
>  	  get_ttyp ()->pcon_start_pid =3D myself->pid;
>  	  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
> --=20
> 2.51.0
>=20
>=20
