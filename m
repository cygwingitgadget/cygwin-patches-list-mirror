Return-Path: <SRS0=aQVm=BR=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id EA4F04BBCD86
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 14:57:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EA4F04BBCD86
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EA4F04BBCD86
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773759445; cv=none;
	b=qbTc6EPYH8xwV18PBZcHW+TXWdgWeIBSiGlUPsrSJYzfIo++R35TeaVF3T21WPy3Jk54BoPbv6xiHXSV4F3tkW2aSAKnt/4fevAgMP/bahmSch4Y6XjnN1QrGlSLESECXfUMY4dBYi5dmC04XBB9zUTHo0NydnFGvYonO5/UrYk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773759445; c=relaxed/simple;
	bh=zHcBMhZai4CTRJvvKlSaNu7OqPRjUGVxndZOw69IcQo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ah5AGqNXKc8DFmjaB7H6gAMBjWdxlvNkGKKIIOMgLwk0QrMiLU/NuTCzxDmutbe22zlY2ygAVT/edhnnyYDb84qO5apQSwOUAA5EnfRD2WymT1MSbSBiBJX1noj82SGhpHUB1r5KWi342WEhK7tgWTTqQWsAIyCdJ5zBztUBpy0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EA4F04BBCD86
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ra9cP/j8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773759438; x=1774364238;
	i=johannes.schindelin@gmx.de;
	bh=zHcBMhZai4CTRJvvKlSaNu7OqPRjUGVxndZOw69IcQo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ra9cP/j8s0ffiXcH4LLXPxefwJw6y8j2MTlOvtzbCdpCeglNfIf1XGEkyydeWWlh
	 4q1gfOb8QXOFNmnr4EXCvxGQcjYumiahyhUmkD/BIvOHt3Wp8iTeXlXzznbEjHcf0
	 MYgLBVlXYYlsY/uLkaCefPjVocNj9xq/+hWxtGCXWBba/nSAI1TepSyoyajVRwgd5
	 GgsFhZYn1Z1eXue5MhMOHOAh4URJl59L6NVOdI8t+JAN2kQPWJ5NTKjmUv6cK88aP
	 wx/lOs/kRk0eMv1gIl4lFLJZVe7xsp1zAGIe9tmgVZlYyId9Y6M+WbyXXTaoXoU+3
	 llllV3NN6i8Gxoy0oA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1w1gF03pHz-00HX3R; Tue, 17
 Mar 2026 15:57:17 +0100
Date: Tue, 17 Mar 2026 15:57:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Fix out-of-order keystrokes
In-Reply-To: <d6fd357c-c1eb-487c-df77-81614354d5ed@gmx.de>
Message-ID: <c5167e49-a4c9-cb71-374e-a33172c2efae@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com> <20260303212405.25a2db7d786ac2db324e8f7a@nifty.ne.jp> <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de> <20260310175652.a7c404ae59c02560956cfb59@nifty.ne.jp> <20260317212208.cb8ac446f8da721cd82d3e51@nifty.ne.jp>
 <d6fd357c-c1eb-487c-df77-81614354d5ed@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:emqiLaiHrG95NomDVLDZtgQpAiM0GjX2IEaUa/hT1IiqYNLs3Ep
 aqiFZmEa3kf7pmJXAaF6clzT1kfbqfXthXiNaRyj1xD8/3v6Qi5yZzPG7CNmdXvu6UMjcGZ
 RR+MSHN18usQwLBgaaAjhzOIUrA+9BhrZoXJ5CtJ/nkwiinl980Fj1BMdS4JMDgjgm4C048
 1RppkmjKyVI+e6hElZZNg==
UI-OutboundReport: notjunk:1;M01:P0:AoADhPy95/s=;D0W2cUu0DIoFWl4m/s++BgjKnCN
 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
 pT
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 17 Mar 2026, Johannes Schindelin wrote:

> On Tue, 17 Mar 2026, Takashi Yano wrote:
>=20
> > Could you please test?
>=20
> Yes, I tested. There is already a problem in the `cmd.exe` test I
> introduced in response to your feedback. What it does is to launch
> `cmd.exe`, wait a few milliseconds, and then start typing `echo
> <long-string>`.
>=20
> As you can see from the output here, that does not work. The first two
> characters never make it to `cmd.exe`, and besides, `cmd.exe` is then
> stuck:
>=20
> -- snip --
> $ cmd.exe
> eMicrosoft Windows [Version 10.0.26200.7984]c
> (c) Microsoft Corporation. All rights reserved.
>=20
> D:\git-sdk-64\usr\src\MSYS2-packages\msys2-runtime\src\wip\ui-tests\msys=
2>ho ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
> -- snap --

Oh, I see what happened. I tested the wrong patches: You sent your series
in reply to mine, but did not mark it as "v1.5" or "v2" or anything, so my
script picked up the first 4 patches from my original patch series, and
the last two from yours.

And then you sent the v2 of your 4/6 as a stand-alone patch (i.e. not
inside the thread):
https://inbox.sourceware.org/cygwin-patches/20260317141043.410-1-takashi.y=
ano@nifty.ne.jp/raw
This not-v2 and then only one patch v2 business is quite confusing, to be
honest.

So now I tested with your 1/6-3/6, v2 4/6, then 5/6 and 6/6. This time,
`cmd.exe` does not even show up:

=2D- snip --
me@work MINGW64 /d/git-sdk-64/usr/src/MSYS2-packages/msys2-runtime/src/wip=
/ui-tests/msys2 (main)
$ cmd.exe
ech|
=2D- snap --

The `|` there is not even a real pipe symbol, but the cursor. I couldn't
use regular copy and paste because MinTTY is now hanging so badly that it
does not react to mouse interactions anymore, I had to use Windows+Shift+T
to OCR the text.

Maybe it is time to take a step back, stop offering patches, and analyze
this by first talking about what is _supposed_ to happen in the scenario
tested by the AutoHotKey script? I mean, it's not written down anywhere
what the Pseudo Console support code is _supposed_ to do, apart from the
code itself, and since that code has bugs (obviously) it cannot serve as
proper documentation of the intended design.

Ciao,
Johannes
