Return-Path: <SRS0=qb86=BH=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id D48664BA2E10
	for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2026 08:23:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D48664BA2E10
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D48664BA2E10
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772871798; cv=none;
	b=fPsXqSma9APTLlUuRDhok48m1oMM1lImpRKLuqtLae1whTisWfuNdqpmuASqW8ca80YW7OxAISrikiT/dubTUyPU5f8FgzqvZC+61Dt1q1xXJbUugJImEIDQqOZ4Z9SU0nDbVBb/eYhtf+NIF0EMf15H8W/8ijo68cqIz5EY3qA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772871798; c=relaxed/simple;
	bh=h0kBi2sNmnH85caGFm3W4NFRmkaurT65GT6umf/wcLI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=iTEqyC4hvrgF6515JtFkNhaxw7kLVrdXj6c7LfKx6WzPVNO67IxVVddtTfU6xdWRJn5vr6VGRuhngWUL+AElBx51lL/2VGZzHMVT1KgiAZyNapB7exvEkKGvIaUqAgWBxS58ObYwzbPkAf5pwVT5I8HTUs5eAUj3xy7ghLvnuVw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D48664BA2E10
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UeL5ts8c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772871796; x=1773476596;
	i=johannes.schindelin@gmx.de;
	bh=PsqvI50LyM+CR5K1bbLGjqW4NgjD9G/RS1PYflO4+eU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UeL5ts8ccJJhF1qeR/yZ/5Et0qbz3BRFVJL2Vpfdove570s1oPtXDlrPoqFynAHa
	 4zf5j8KkzvBBJucX/wRGzrXAPoXlZqHjz5Z+v3PPN08CYYLDJpXuVdyXyv7+zUTLj
	 4pi8V/3+MwpDiP6n3O7pZhWybPHlZAp+uNpUzi1rkps94uui9Diy20iZCun+Yrlxw
	 EiVFhSrZL8m1bUl8+EsjK2qk67rfZNIGYaztM/sZasJy6iESbzfmfQ5fzuPCxjN7p
	 5OkihfDCes4hJD0aA9mcbXiN6DXYliO+QpXRrKX+txwygOqiUGZuSrZbK1N++JvtW
	 BZL7NCm/BUBKqko2NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1vKUMg2DdS-00h47N; Sat, 07
 Mar 2026 09:23:16 +0100
Date: Sat, 7 Mar 2026 09:23:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <2fa791d4-9569-432d-b062-68bb8136e1ef@SystematicSW.ab.ca>
Message-ID: <70268126-9ef3-3f0e-776f-26a233c8db3a@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp> <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de> <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp> <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de> <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
 <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de> <20250715162741.bd33f1249f088ba6947fbd32@nifty.ne.jp> <2ad7299d-9561-fcd9-9fec-8b492c48caee@gmx.de> <6e67d97e-60a0-4bff-8a4e-cf4e90411603@SystematicSW.ab.ca>
 <2fa791d4-9569-432d-b062-68bb8136e1ef@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-914565253-1772871763=:89"
Content-ID: <03a0f702-d758-39bb-c860-3deffe302e0c@gitforwindows.org>
X-Provags-ID: V03:K1:92iQB9fYDomiAvmMMH/H2Zfsv/D58pAsIvzRukNEwssaBdIh43+
 Z7ymurCoLd3HVGlBxPIs6RQZ5IUTxvkgCdTJu89yynaULt4CP6Ofa+N0VLcKu1VFba0Dysn
 G+2JejCLvCKKXMIDXBClkx9KUeor+ljYQUbX0gAIbb/aWKyoQcMEFLE4UqjfLpQYI+u1x6J
 BMKIm07jHzqNgbVgMkpyA==
UI-OutboundReport: notjunk:1;M01:P0:TSi5V0v7B1c=;SqG7blbd+xBmVvcBXrdThIy/z2C
 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
 R8kuw3akuPONh72lMe5x
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-914565253-1772871763=:89
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <a89d334a-d0fb-260b-a179-907f7545bb78@gitforwindows.org>

Hi Brian,

On Thu, 18 Dec 2025, Brian Inglis wrote:

> On 2025-12-18 15:24, Brian Inglis wrote:
> > On 2025-12-18 00:45, Johannes Schindelin wrote:
> > > If Cygwin were merely a personal project of yours, I would understan=
d and
> > > probably agree.
> > >
> > > However, Cygwin is used (via the MSYS2 runtime) in Git for Windows, =
and by
> > > extension millions of users rely on it.
> > >
> > > Therefore, it would be good to at least publish those local tests.
> > > Ideally, a good deal of thought should be spent on figuring out a wa=
y to
> > > integrate the tests into the CI builds.
> > >
> > > You mentioned winsup/testsuite, and I do agree that it sounds more t=
han
> > > just tricky to integrate the tests there. Essentially, you would pro=
bably
> > > end up reimplementing AutoHotKey's fundamental functionality: sendin=
g
> > > keystrokes and inspecting the results.
> > >
> > > Now, to be sure, running AutoHotKey-based tests is a lot more finick=
y than
> > > running winsup/testsuite. In the absence of any better idea, though,=
 I
> > > would take the confidence from having tests over not having tests, a=
ny
> > > day. After all, you and I are both fully aware of the unfortunate pa=
ttern
> > > in the code under discussion where on multiple occasions, bug fixes
> > > introduced new bugs whose fixes introduced yet other bugs, etc ad na=
useam.
> > > If AutoHotKey-based tests can help break that pattern, let's integra=
te
> > > them.
> >=20
> > Who will port AHK to Cygwin tools to make it available as a package?
> >=20
> > Alternatively, do we really need to:
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0https://www.autohotkey.com/boards/viewtopic.p=
hp?t=3D9806

I do understand the concern, at the same time I do not see any good
alternative to AutoHotKey-based testing because constructing the exact
scenarios under which the bugs trigger _is_ difficult.

> Also, you can do a lot using read with -p prompt (example queries xterm =
info):
>=20
> 	read -s -t 1 -N 128 -p $'\E['"$p"'t' -d t r
>=20
> where $p are CSI query params in prompt, delimiter 't', reply $r.

While this works to replicate _some_ issues, note that in particular with
the pseudo console (and `disable_pcon`) quite a few bugs require careful
timing, which you simply cannot simulate using `read`.

Mind you, even with AutoHotKey it is often difficult to recreate buggy
scenarios in a reliable way. For the `Fix out-of-order keystrokes` patch
series I am iterating on right now, it took me four days to get to an
AutoHotKey-based test that would reliably reproduce the out-of-order bug.

Ciao,
Johannes

--8323328-914565253-1772871763=:89--
