Return-Path: <SRS0=3N9S=II=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 419BD4BA5434
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:17:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 419BD4BA5434
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 419BD4BA5434
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336635; cv=none;
	b=E047OzIad1WKBv4uT9ZPfNwZxRLbQNxoajhGiGh725p0hCFa+ss2CtmkhnQxQiNeInDbjdobV0ITaNujxGttre5sKBglSWXV/ayU03Epy+H2VXfHgQ8Gzl+8t1FZD8/8sV/AjTC2xdcYmwTdWIoKsCTzYnzaz4FsISaIKnNc2Zc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336635; c=relaxed/simple;
	bh=9IWE5m1TvaxzIV22oi+L0PNP4P37TIXMoZDI7v+AKVo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=s2UvNe/xRH3fHNOhYu4gSYoRV3O3NKNPFPRKOHWK2PsVoirShTBmgbMMJ6vqCyBEN4n5MYLV6dkjZ63iOxh45VDVU+moW56USLerficGJ2T11bKcvj5V8dezFfAPuwkrilYUZXfiXUz/dr0rRzQ5nhTe14dU4JFDgrA3UvKiZCw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=uHvqLeRt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 419BD4BA5434
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=uHvqLeRt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792336634; x=1792941434;
	i=johannes.schindelin@gmx.de;
	bh=TMnQ0Z2ZICnZQJNokuXTkobhpIWVG8cWHihySyJVKEk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uHvqLeRtwvPt8zoz9JzGnqZI0h8rMNeJZurSm+iH5WGKc7wANQvEfEkiGPOopd1Y
	 5ZZfsQSt7k3zD5h55N9g0E2LGyMWPoSGaG+P63kvAJPdAmmypV/FRPC5UUB1agqpG
	 6T9icIbQFib9Oxr/5JavOspVcHyS2OtjrCMAjrIKl5vJoWUFC+6N0BurEqU/UFnfa
	 5p629KOtpIZLWbl/JPFK/eKx+agXiksYxXAJ9F4zXq7NqlESK+T0X5K0Ftsno4MmZ
	 6Sgp9CLvQpOKDndOpU6E9Gl83/nAMyPWv0Z6COU1Xj+2O+zESYYiRh3QCTigoJqp6
	 IO+pTxQlIMJmM1Hd0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1wfr5a05AS-00qdC9; Sun, 18
 Oct 2026 17:17:14 +0200
Date: Sun, 18 Oct 2026 17:17:13 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/6] Cygwin: pty: preserve terminal replies after PTY
 adoption
In-Reply-To: <pull.10.v3.cygwin.1792335902.gitgitgadget@gmail.com>
Message-ID: <0e784d92-bb9c-65d7-425f-113091a2b412@gmx.de>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com> <pull.10.v3.cygwin.1792335902.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:CQv8MigGE787ygqyD9tAa9gJI/naWFe5ppo56P1h4TBHOSpUDaj
 Kib4MF3UslpV34uFeIVFDeI27/nzoFYR3Nn4INCtxzOhSEofD3g/xdQqfJsMzIkf2gxUlfS
 jEOr9EzCUzhbrmqgmCUtD7K2bxNHpF/kCN4E7EAOVn6DGrnf7gVEqKZOdAjDOy2rJkX2E4Y
 NTVy05VK3QyHoUcJI/Bcg==
UI-OutboundReport: notjunk:1;M01:P0:ILg0pmBmoWg=;PuAr3+CJ8EFdC9uqEt+dkhpIwXO
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi,

Sorry about the double-post; While submitting, I noticed that I forgot the
`Changes since v2` part as well as the correction to no longer claim that
these patches are easily cherry-picked. I stopped the automation, but not
before it had sent out 0/6 and 1/6.

This is the incorrectly-sent cover letter, please ignore.

My apologies!
Johannes


On Sun, 18 Oct 2026, Johannes Schindelin via GitGitGadget wrote:

> MSYS Vim launched by native Git from Bash in MinTTY can delete the first
> line, enter Insert mode or insert RGB text at startup. The problem is
> incorrect PTY adoption, and the same problem applies to the Cygwin runti=
me
> (but is less common because native Windows programs are not mixed with
> Cygwin programs as ofte as with MSYS programs).
>=20
> I merged v1 of this into Git for Windows v2.56.0, as it was somewhat
> pressing.
>=20
> This patch is based on cygwin-3_6-branch, but is easily cherry-picked on=
to
> master, too.
>=20
> Changes since v1:
>=20
>  * Instead of changing input routing when the program changes terminal m=
ode,
>    v2 changes it already when the foreground Cygwin program starts throu=
gh
>    exec().
>  * Added a test case that gets run as part of Cygwin's test suite.
>=20
> Johannes Schindelin (6):
>   Cygwin: pty: restore foreground input routing after exec
>   Cygwin: testsuite: allow cygrun without the testing namespace
>   Cygwin: testsuite: cover foreground PTY input recovery after exec
>   Cygwin: pty: recover input for children of native programs
>   Cygwin: testsuite: cover PTY input recovery with a native parent
>   Cygwin: testsuite: cover queued native input with pcon disabled
>=20
>  winsup/cygwin/fhandler/pty.cc                 |  52 +++-
>  winsup/cygwin/local_includes/fhandler.h       |   2 +
>  winsup/testsuite/.gitattributes               |   1 +
>  winsup/testsuite/Makefile.am                  |  27 +++
>  winsup/testsuite/cygrun.c                     |  12 +-
>  winsup/testsuite/cygrun.sh                    |   7 +-
>  winsup/testsuite/mingw/Makefile.am            |   5 +-
>  winsup/testsuite/mingw/pty-native-input.c     | 171 ++++++++++++++
>  .../winsup.api/pty-background-native.c        | 223 ++++++++++++++++++
>  9 files changed, 483 insertions(+), 17 deletions(-)
>  create mode 100644 winsup/testsuite/.gitattributes
>  create mode 100644 winsup/testsuite/mingw/pty-native-input.c
>  create mode 100644 winsup/testsuite/winsup.api/pty-background-native.c
>=20
>=20
> base-commit: 867eb7748e6e5a0e8430ce9f46af27b4b1e8f204
> Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-=
10%2Fdscho%2Ffix-vim-terminal-replies-v3
> Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-10/=
dscho/fix-vim-terminal-replies-v3
> Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/10
>=20
> Range-diff vs v2:
>=20
>  1:  7f0615fc8 ! 1:  8a6255016 Cygwin: pty: restore foreground input rou=
ting after exec
>      @@ Commit message
>           The existing debugger-recovery handover can do this once the a=
ttachment
>           mutex has been reopened.
>      =20
>      +    Note that this logic must be careful to keep the `disable_pcon=
` mode
>      +    working as-is.
>      +
>           Addresses: https://github.com/git-for-windows/git/issues/6403
>           Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>           Assisted-by: GPT-6.1 Sol
>      @@ winsup/cygwin/fhandler/pty.cc: void
>       -    fixup_after_fork (NULL);	/* No parent handle required. */
>       +    {
>       +      fixup_after_fork (NULL);	/* No parent handle required. */
>      -+      fixup_input_state_for_cygwin_app ();
>      ++      if (get_ttyp ()->pcon_activated)
>      ++	fixup_input_state_for_cygwin_app ();
>       +    }
>       =20
>          /* Hook Console API */
>  2:  4f53a727d =3D 2:  ebf384575 Cygwin: testsuite: allow cygrun without=
 the testing namespace
>  3:  92d13761f =3D 3:  cceb823af Cygwin: testsuite: cover foreground PTY=
 input recovery after exec
>  4:  f1a25a8e5 ! 4:  2b13ec62f Cygwin: pty: recover input for children o=
f native programs
>      @@ Commit message
>           is too early. If `stdin` and `stdout` share a PTY, initializin=
g `stdout`
>           later can perform the handover `stdin` missed.
>      =20
>      +    Note that we must be careful not to break the `disable_pcon` m=
ode with
>      +    this new logic.
>      +
>           Addresses: https://github.com/git-for-windows/git/issues/6403
>           Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>           Assisted-by: GPT-6.1
>      @@ winsup/cygwin/fhandler/pty.cc: fhandler_pty_slave::init (HANDLE =
h, DWORD a, mode
>       +void
>       +fhandler_pty_slave::post_open_setup (int fd)
>       +{
>      -+  if (fd =3D=3D 0)
>      ++  if (fd =3D=3D 0 && get_ttyp ()->pcon_activated)
>       +    fixup_input_state_for_cygwin_app ();
>       +}
>       +
>  5:  5bbc7634a =3D 5:  cdd3d9ce9 Cygwin: testsuite: cover PTY input reco=
very with a native parent
>  -:  --------- > 6:  4469693b5 Cygwin: testsuite: cover queued native in=
put with pcon disabled
>=20
> --=20
> cygwingitgadget
>=20
