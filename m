Return-Path: <SRS0=IEpW=ZU=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 04FDF3857B94
	for <cygwin-patches@cygwin.com>; Mon,  7 Jul 2025 10:50:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 04FDF3857B94
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 04FDF3857B94
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751885435; cv=none;
	b=uMMy/MieWkC030eIquKtk4iBblsoVJbsjNurctnoQioVb6sHBGPOOKBaTZMa4BEPhiYlq9Pn0yuUYdOnUOWfXsDbExk4RhM2xbYwQNpvptLNeJ3L+Sk2iK8vvrxcB4hEDZiGLdL+W+uhrLfpZdYtbzxjRTvWKmnDmsOZLtXJB9g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751885435; c=relaxed/simple;
	bh=WzOTO0qSjkb9Erfe2ee5W5J/rtAUo2OTJR9DtrzF5/c=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jnVeF5YE1c1KuQfxGtAIH1AzN0CU3JmoMeszIgFvHm4bwo03eGBK/ucbH4GIufI6BcJfZK2h8D+kcBwlmnxSNbxZhA0MVeW0MG2+yJhFb1e0Y1x9yVuUXXHr5Q+syVU7s1rR7/j/rs77NT7ZZc9EHt+sel3qNhX6jQJ7WTGIoZ0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 04FDF3857B94
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dD3vIpm/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751885426; x=1752490226;
	i=johannes.schindelin@gmx.de;
	bh=WzOTO0qSjkb9Erfe2ee5W5J/rtAUo2OTJR9DtrzF5/c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dD3vIpm/RvD5HnFhOSvorRVyJrEQ4itB0yEjKxvMbUKXZKJrWP560rFvSnKt92L8
	 qv2a/3YFfvldQZHmO/1spjk/XfKAJftV/L6s7eVruEm5TcZcFNSAePUffqzWpooRQ
	 ruuzq6Pdd/UaJ70UWZCzDY6JW5somyE2KUqAaKHbC/K4alyEn+j6FG3DcKqnx2BVL
	 acIBpcSmfS+LLd7uquIDKlmg0kWzUPOlNtzl9pDgZCDsQuUGCVt2uXAr1KjuB+Zgr
	 7Vupvn6IjE59mBer6m641VDczJN2pQswrCWGYSkTXo+o9m+H65yYwdQhTrzu51e1f
	 PhOSt+TsGdOk1Qdtdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDnI-1uOFZ60zPi-009zi4; Mon, 07
 Jul 2025 12:50:26 +0200
Date: Mon, 7 Jul 2025 12:50:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
Message-ID: <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp> <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de> <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp> <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de>
 <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7HsYM5CL8Uiw49vr3i9eV/Ng1THAcUjEW2Tb0wkP5IGsPmEPENL
 U/lanNlXE7GK1TWpb/nSqq0+rYaY/visG1ZaAVglUpYpieDV5+O8cL0lP8IMts+pyiTv2cS
 puw0g48fHjOuCCYTIeJhiKaQroI07xd1po2I73UKL8OPAYU/FQTFgxPw1WuQpqlFcJaofBU
 6gHv/jQ6aL8QR1WTVgglg==
UI-OutboundReport: notjunk:1;M01:P0:e61b9syKwT8=;/xXJJr1fjEcckoYFMpKbxgrFx3q
 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
 FQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 3 Jul 2025, Takashi Yano wrote:

> On Thu, 3 Jul 2025 11:15:44 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > On Thu, 3 Jul 2025, Takashi Yano wrote:
> >=20
> > > I noticed this patch needs additional fix. Please apply also
> > > https://cygwin.com/pipermail/cygwin-patches/2025q3/014053.html
> >=20
> > Thank you for the update!
> >=20
> > I am curious, though: Under what circumstances does this patch make a
> > difference? I tried to deduce this from the diff and the commit
> > message but was unable to figure it out.
>=20
> In my environment, the command cat | /cygdrive/c/windows/system32/ping
> -t localhost in Command Prompt cannt stop with single Ctrl-C. ping is
> stopped, but cat remains without the sencond patch, IIRC.

I have added this as an (AutoHotKey-based) integration test to
https://github.com/git-for-windows/msys2-runtime/pull/105 and was able to
verify that your fix is necessary to let that test pass.

Speaking of tests: Have you had any time to consider how to accompany your
fix by a regression test in `winsup/testsuite/`?

For several days, I tried to find a way to reproduce a way to reproduce
the SSH hang using combinations of Cygwin programs and MINGW
programs/Node.JS scripts and did not find any. FWIW I don't think that
MINGW programs or Node.JS scripts would be allowed in the test suite,
anyway, but I wanted to see whether I could replicate the conditions
necessary for the hang without resorting to SSH and `git.exe` _at all_.

I deem it crucial to start including tests with your fixes that can be run
automatically, and that catch regressions in the CI builds.

Ciao,
Johannes
