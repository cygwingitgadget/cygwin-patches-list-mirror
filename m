Return-Path: <SRS0=+cfa=A7=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 6A9034BA543C
	for <cygwin-patches@cygwin.com>; Fri, 27 Feb 2026 16:02:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6A9034BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6A9034BA543C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772208133; cv=none;
	b=poLRhR4GajYXN9l/e5d++R/1Tt0uhbE2tH63sEJcWZHf8VyaZxazkckMhX6pXHk0vMgwZl90vYEOCgsTKu7bwmIuSVLvUWEY/MX25ocLJap9ZcfyVcDRpwc4G/f8fg9pFCm9PtYyLR6IUdxIW6eV1jausn0BCuVJJmHcw2EEwdc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772208133; c=relaxed/simple;
	bh=DDXc5g5TvhTHk46kVlUsELHtyjA2RB54WwoCtFVz3Rw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lRSzX/0hJyCqUn1uAc3VsavDSZ0ErdnTidQA12vq4XmEZ5+n8sBKC8eVGvCR5B3BamivDgoQ7dqRZ0btBHorxI/3x0IKlRQ2FIRDRV9XgcInm8eVheQeWuI038xCm6gdnadjTni7MqhjuNJIEjj9VSKJbxJSpC42oionfuAUd2o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A9034BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mANKvwPF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772208132; x=1772812932;
	i=johannes.schindelin@gmx.de;
	bh=+aN0Kcb4Ena40YDJVXHvKMdo7t1xRbaxBpgG1n3RB2o=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mANKvwPFUBDQANx5A+sQS3TECKgupSmKFNjXAFB0CA/PCxvHLzxty38HymUzaKzt
	 Pwf+vT3OWcSviPv2UIS8lbJIKE9gcvG8/dDic9UI2njVdXtru5IwkkEf/xIA3Yefn
	 OA5W6rITsQ6miZcWBSjUPJmsvj5IN/D8hNstGhkDOutg0vfjmVlQyUVci5BeSmWYG
	 IGKf9cB2lFe6raOdtwyuFEvM2Q+7EX6kdfM0tx755+xz0jqUm0r4NCZO43Izp7Pia
	 Z+nVmfvDFQw3fS+Zoqa8a8EurzQogvxM7jy+HfBwjnwEc8YP0eJCJrZWQdHIE6Ggu
	 aBDkv6yOe9Ae6aRq8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1vLMN704RZ-00b0j6; Fri, 27
 Feb 2026 17:02:12 +0100
Date: Fri, 27 Feb 2026 17:02:09 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Discard remnants of win32-input-mode
In-Reply-To: <20260223080031.320-1-takashi.yano@nifty.ne.jp>
Message-ID: <57c90d88-a1a0-b484-807c-e4e673dbf68c@gmx.de>
References: <20260223080031.320-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SF+i2eIm2ULDWshwNIO7qpVOCNxPyWqyBv8NgcQUc2voJXMkZ0+
 QKn6gIVb9AnVhKJhqNGEjqMIx+TK0S91PKZIXHpfKnuzlqIEL6TCwCisN4rlSwDuECkM981
 1rpLIDi97LXJJpAMPhZy2sBBAifDUa0yGsVR/yfnQtzKti4i1rQgLyvfs6sUB7cCB6bb8zW
 hwz4OeSlmpzpftWQHO/qg==
UI-OutboundReport: notjunk:1;M01:P0:fQ8IlFTOooI=;eYhVFtFy/KhN2ftTpuRHQVMUS4N
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 23 Feb 2026, Takashi Yano wrote:

> In Windoes 11, some remnants sequences of win32-input-mode used by
> pseudo console occasionally sent to shell which start non-cygwin
> apps. With this patch, the remnants sequneces just after closing
> pseudo console will be discarded.

Could you kindly advise how to reproduce this?

I have been investigating a related pcon transition issue (character
reordering during pseudo console oscillation, see
https://github.com/cygwingitgadget/cygwin/pull/6, which I plan on
contributing in a bit) and initially suspected the same root cause. After
analyzing your patch, I believe these are genuinely different bugs, but I
think the time-based heuristic is the wrong approach for this one.

> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index b30cb0128..b90b2b609 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2504,6 +2504,16 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>        return len;
>      }
> =20
> +  /* Remnants of win32-input-mode sequence in pcon_activated mode */
> +  bool is_remnants_to_nat =3D
> +    GetTickCount64 () - get_ttyp ()->pcon_close_time < 32

As you noted in your follow-up, 32ms is not enough, and even ~200ms may
not suffice on a loaded system. Any fixed number will be too short for
some users under some conditions.

I believe the underlying problem is that the pseudo console's conhost
sends `\x1b[?9001h` (win32-input-mode enable) through the output pipe, and
`pty_master_fwd_thread()` forwards it to the terminal emulator without
filtering. Once the terminal enters win32-input-mode, it encodes
keystrokes as `\x1b[Vk;Sc;Uc;Kd;Cs;Rk_` sequences. When the pcon closes,
there is a propagation delay before the mode-disable (`\x1b[?9001l`)
reaches the terminal, and keystrokes typed during that window arrive at
`master::write()` in the wrong encoding.

Beyond the timeout fragility, the current approach also discards
keystrokes rather than decoding them (the win32-input-mode format contains
all the information needed to reconstruct the original keystroke), and the
pattern match can false-positive on legitimate CSI sequences that happen
to end with `_`.

I think the proper fix is to filter `\x1b[?9001h` (and the corresponding
`\x1b[?9001l`) in `pty_master_fwd_thread()`, preventing the terminal from
ever entering win32-input-mode. This is consistent with the existing
architecture: that function already strips several categories of pcon
output artifacts that should not leak to the terminal (window-title
sequences containing "cygwin-console-helper.exe", `CSI > Pm m`, `OSC Ps ;
? BEL/ST`). Win32-input-mode enable falls in the same category.

The native app should not be affected because it talks to conhost via the
Win32 console API (`ReadConsoleInput`), not via VT sequences.

Ciao,
Johannes
