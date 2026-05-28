Return-Path: <SRS0=+fqX=DZ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 5C5C14BA2E38
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 14:20:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5C5C14BA2E38
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5C5C14BA2E38
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779978039; cv=none;
	b=JCrd7bNq7h2uywucu9OZeX93z7AEpsw4EPRpbuhuKc07bAPCq2xf0Zu0yv6D+AGKOYTaGnq3rItzdN2yXqYFdbjhg0L75TYr5RKnB4nMhBsU34GJezk4Y/VSpVqVy86pptI0skfepsCsoL/6H7mtTd1uiQVR+bj64Refkir3y6E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779978039; c=relaxed/simple;
	bh=iLs0DuLasDPyVg1DpoINQEOM4oMw34CoeGmc86as6J4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=iodCTfEM2Sl5LeV+4fCU7tSgamQAVO6d5wM4h8z0krtxs673oWJXqypA0SqB0s0VrKfvwEzC/MuqBuG+JdmzLtIsKW+r+CvwKzirY7p4jsskWOzTeeqUIBwRoTIT5A7PNMLKslR5UyiOwphWVflgdnp9esqQ1uHQRrnpMw9KlUg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=CdlX26P9
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5C5C14BA2E38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=CdlX26P9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779978038; x=1780582838;
	i=johannes.schindelin@gmx.de;
	bh=iLs0DuLasDPyVg1DpoINQEOM4oMw34CoeGmc86as6J4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CdlX26P9Cc6uQcAy8eRmj+jqy5H7eSgtSrGzigyEtpNeNr9mNN8fXUBiNeROs6g2
	 OaLH2Vx6bMHqMkH8SuSJtjrNVSXHh6ATggwSwbqAZrGVsppyNrKtGAeCvZPWV+ck3
	 3UViVPo1TTOymKNTHpRl9gzma3L1FQblBA3K7PakW3MAcHi10bCLrGp5l+qH11TFE
	 0bR6KgpnMjYvxwOtRBCdwcd706uJa1LfJKZ8iN6C5RI6bSUEuy/rNhe3uaVdVjFaW
	 gkx0Y0Mz8FkB6vc6bVk9PDJeRch23L1GViacwzSgqYTyB2IwIkgjFbvj9mAprhFci
	 ZZ1xgknbMFetl3oetw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1xMXID09Jz-013w1A; Thu, 28
 May 2026 16:20:38 +0200
Date: Thu, 28 May 2026 16:20:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <70268126-9ef3-3f0e-776f-26a233c8db3a@gmx.de>
Message-ID: <d35323da-2d69-6fa1-fdc4-d84b3e07c407@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp> <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de> <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp> <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de> <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
 <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de> <20250715162741.bd33f1249f088ba6947fbd32@nifty.ne.jp> <2ad7299d-9561-fcd9-9fec-8b492c48caee@gmx.de> <6e67d97e-60a0-4bff-8a4e-cf4e90411603@SystematicSW.ab.ca> <2fa791d4-9569-432d-b062-68bb8136e1ef@SystematicSW.ab.ca>
 <70268126-9ef3-3f0e-776f-26a233c8db3a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7Jj0VZ+KLpIc6GB6Nl26dbCPZFgZan35ZVl/KXliWmWsN3ZQZoa
 KbDvNvFP5d+7AcdffJ6jxIKnHV+iGb6Z7KfsxWCKsbv56osw6ONBaxIGFWsXgml9OOX6YOh
 sYIaqXA+5t/PHFuZtY1BnyXjsQqhxoQE/a+YNdoLt7bNKnieHJZftAIfDdhqoSfZ87Qjaa1
 CY0Z1ii4szgG+vPRjhdkg==
UI-OutboundReport: notjunk:1;M01:P0:vBllzZ0A5+E=;OiTDGqhyxg8afrTEQjjCA0qErT7
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Brian, me again,

On Sat, 7 Mar 2026, Johannes Schindelin wrote:

> On Thu, 18 Dec 2025, Brian Inglis wrote:
>=20
> > On 2025-12-18 15:24, Brian Inglis wrote:
> > > On 2025-12-18 00:45, Johannes Schindelin wrote:
> > > > If Cygwin were merely a personal project of yours, I would underst=
and and
> > > > probably agree.
> > > >
> > > > However, Cygwin is used (via the MSYS2 runtime) in Git for Windows=
, and by
> > > > extension millions of users rely on it.
> > > >
> > > > Therefore, it would be good to at least publish those local tests.
> > > > Ideally, a good deal of thought should be spent on figuring out a =
way to
> > > > integrate the tests into the CI builds.
> > > >
> > > > You mentioned winsup/testsuite, and I do agree that it sounds more=
 than
> > > > just tricky to integrate the tests there. Essentially, you would p=
robably
> > > > end up reimplementing AutoHotKey's fundamental functionality: send=
ing
> > > > keystrokes and inspecting the results.
> > > >
> > > > Now, to be sure, running AutoHotKey-based tests is a lot more fini=
cky than
> > > > running winsup/testsuite. In the absence of any better idea, thoug=
h, I
> > > > would take the confidence from having tests over not having tests,=
 any
> > > > day. After all, you and I are both fully aware of the unfortunate =
pattern
> > > > in the code under discussion where on multiple occasions, bug fixe=
s
> > > > introduced new bugs whose fixes introduced yet other bugs, etc ad =
nauseam.
> > > > If AutoHotKey-based tests can help break that pattern, let's integ=
rate
> > > > them.
> > >=20
> > > Who will port AHK to Cygwin tools to make it available as a package?

In the meantime, I managed (with the assistance of Claude Opus, without
which I could not have justified the time I would have needed to spend on
this) to get it to compile with mingw-w64's GCC:

https://github.com/msys2/MINGW-packages/tree/HEAD/mingw-w64-autohotkey

It is definitely not for the faint of heart: 21 patches on top of regular
AutoHotKey, some of them necessary specifically to compile using Clang.
And to be honest, my assembly is not good enough to have been able to
write those patches. It's just good enough to review them.

It's probably too much on top of upstream AutoHotKey to put into a Cygwin
package, right?

Ciao,
Johannes
