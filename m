Return-Path: <SRS0=e+TF=GG=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id DEBA34BA2E03
	for <cygwin-patches@cygwin.com>; Thu, 13 Aug 2026 09:43:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DEBA34BA2E03
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DEBA34BA2E03
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786614192; cv=none;
	b=OAcJGdPpF01bZjGAUdvMQtVs6PfwUJVM8Mve1p7B6M0dxZlOpR8a0yNR95DJBooqeOAmsnpnMys897kf97k9lOZPmmRTRb1K90Bk2OXxugifmN8TVJDOYo/eXjiD27DX6FVWf2X64S+qqpOTPF9fbp/Mu3UxF4UQeQktvagOSXc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786614192; c=relaxed/simple;
	bh=xasUHqM6sBSva9QoHd7FYStKs/xk4D7UoADUqoe5lxs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=kTJAplOb27fF+SDukaT9eddXJUtU5PZK7mEpDdZ6rOpGaK4B2wFuVG3bHm93Heo1uQGhbZamE0RP+fh6uwbMvFC6Xn0qHgx8bl/lR5N6yWxPUlcfpVOwXvkLIADZQ4YjgAPTtOxqOoRk4Qc0VNz/9LEJPS/3H6Gp/1VjclULHCw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VFy7Aker
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DEBA34BA2E03
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=VFy7Aker
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786614189; x=1787218989;
	i=johannes.schindelin@gmx.de;
	bh=Nsh/Yk6h+VJiFWvUDt6FzHmdEJKtDtP+yJWvtHhB4zc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VFy7AkerRgGsbWxPuLfP0mpfJsNAvveudfMQfO+wFwuDHkVA+7V2xlp5CoP2n6pP
	 5hQF9YmRqnLFc1K2ZyCq7haTBooVqFRDtcHanrQ7Ci3jcEXJcnio7pLfPX5k7zp2q
	 sQ4H1qXTDWoT4PI1gouX/bw5KaNxHm2xRKJ8v+56OSnzGxoXgiLuTvyhUlMeqN/KA
	 SVH0J289sailZtzkBmPBzI9WNom3JK6EjyCcV7AlkvF/ZHCtlinDHxJC7vFlSwA98
	 ULgXO6DUPuD9snVo1X+4ARvnmHEx+KasqTcq31hOzYyreNnu8CwVaR9xJv7JfWTJu
	 3iOuaPxBA9nEj3bwlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1waS8a1oy1-00Vzm4; Thu, 13
 Aug 2026 11:43:09 +0200
Date: Thu, 13 Aug 2026 11:43:08 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?6aOb6aOb6aOb?= <chenlijon@gmail.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH/RFC] console: avoid master-thread suspend request from
 non-master processes
In-Reply-To: <CAD8hRBMi6qaH8xP4Zw0j0VpTz0CFLRRU2cb--H4FCZcpQ=nhEA@mail.gmail.com>
Message-ID: <ce83818a-25df-197d-a9bd-26ac0af6c536@gmx.de>
References: <CAD8hRBMi6qaH8xP4Zw0j0VpTz0CFLRRU2cb--H4FCZcpQ=nhEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=8323329150523291117866141901941190
X-Provags-ID: V03:K1:6fmWiG2DStL0C/XFT/RnOiZCNG+o36mWbuHGkxhzUO28v8fimF+
 qcr8W0GLuUvGrAg+HOpSFft6IXuNFn9j3Ui/XViOKQnx33325GeS9860U8y7M0NmozI0fB0
 tNFpUZ04AWkKQkaR5Zmp0gbtAo2ZC/xd8DvuQdwxb+TAlNDoBQe6/Syi9jNKiad4HMX1zpH
 Vd/vQe8eOhv5p1FYKknKg==
UI-OutboundReport: notjunk:1;M01:P0:eAGuZmiGfRg=;aqkhWeVV1thCvOD24DEuv+s+ctY
 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
 1ks9MLNsOJVs447/lak=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329150523291117866141901941190
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, 13 Aug 2026, =E9=A3=9B=E9=A3=9B=E9=A3=9B wrote:

> Hi,
> I have been investigating a reproducible hang in highly parallel builds =
on
> Windows 11, especially while building LibreOffice with multiple jobs.
> The hang appears to involve fhandler_console::close() calling:
>=20
> set_disable_master_thread (true, this);
>=20
>=20
> even from processes that do not have a local console master thread.
>=20
> set_disable_master_thread() updates the shared disable_master_thread sta=
te
> and then waits for:
>=20
> while (con.master_thread_suspended !=3D x)
>   Sleep (1);
>=20
> During testing I captured a case where one process published a suspend
> request (true) and started waiting for
>=20
>  master_thread_suspended =3D=3D true,
>=20
> but another process later published false into the same shared state bef=
ore
> the first request had completed.
>=20
> The first process was then left waiting indefinitely.
> In the captured trace, both requesting processes had:
>=20
> master_thread_started =3D 0
>=20
> while the actual console owner/master-thread process was a different
> process.

Thanks for the trace; it exposes a real race:
`set_disable_master_thread()` publishes shared state, drops `input_mutex`,
then waits, allowing another process to overwrite the request.

> A minimal guard in
>  fhandler_console::close() avoids this:
>=20
> if (master_thread_started)
>   set_disable_master_thread (true, this);
>=20
> This prevents processes without a local master thread from entering the
> master-thread suspend request/wait path.
> The intent is not to change Windows process/thread scheduling. It only
> restricts Cygwin's shared console master-thread control to a process whi=
ch
> actually has a local master thread.
> This also avoids non-master processes entering a wait loop whose complet=
ion
> condition may be invalidated by another process modifying the same share=
d
> state.

The proposed guard does not fix this bug. `master_thread_started` is
process-local and false in every non-owner, so it says nothing about the
owner's master thread. It would also leave the following `tty::restore`
changes running while that thread remains active, undoing the ordering
introduced by `733d5a953fa9`. Other callers could still overwrite the
shared state, too.

Could you capture, on unpatched HEAD, the stuck process' call site and
stack, `con.owner` and whether it is alive, plus both shared flags?

Cross-process request serialization is likely needed, and I believe that
Takashi's patch (now at v12, see
https://inbox.sourceware.org/cygwin-patches/20260807121459.3116-1-takashi.=
yano@nifty.ne.jp/)
is the right approach, even if v12 still has a known lock-order deadlock.

Ciao,
Johannes

> Test results:
>=20
> Windows 11
> AMD Ryzen 7 9800X3D
> Intel i7-13620
> parallel LibreOffice builds
>=20
> repeated high-parallelism testing
> full LibreOffice build completed successfully with the guard applied
> Without the guard, I was able to reproduce the hang and capture the requ=
est
> overwrite described above.
> With the guard restored, the full LibreOffice build completed successful=
ly
> with exit code 0.
>=20
> One possible trade-off is that processes without a local master thread c=
an
> no longer request suspension of the console master thread through this
> path. So this narrows some existing cross-process master-thread control
> behavior.
>=20
> So far I have not observed a functional regression from this restriction=
 on
> the tested Windows 11 systems.
> My current understanding is that the important behavioral change is very
> small: processes without master_thread_started no longer enter the
> potentially unbounded set_disable_master_thread() wait path.
> I would appreciate feedback on whether this ownership restriction is
> consistent with the intended console master-thread design.
> Thanks.
>=20
>=20
>=20
>=20
> =F0=9F=AB=86Trace Process Log=F0=9F=AB=86
>=20
> Process A:
>   started=3D0
>   publish disable=3D1
>   wait for suspended=3D1
>=20
> Process B:
>   started=3D0
>   publish disable=3D0
>   completes immediately
>=20
> Process A:
>   never completes
>=20

--8323329150523291117866141901941190--
