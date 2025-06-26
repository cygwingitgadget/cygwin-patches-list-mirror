Return-Path: <SRS0=iCjl=ZJ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id AA574385B511
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 15:19:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA574385B511
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA574385B511
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750951195; cv=none;
	b=CBH1g9WrlkYXEk6VMJ9cch15hS8IOpqgJ50xcFtxQ1+ko/hkH68rvKXSxXMwaF4gKiQRvLh3ICmLbhBueQaq5RjowpB3a0KfHHrm+5N+2pcnTIgFssszZmbJgkvybfqQU8ZJc2YI4JB2uCSa6NjJ4YYuh39KFctDsz/qw7qepZs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750951195; c=relaxed/simple;
	bh=S6QryzB3Etmz/gGKH7LelQjiVA+lDrns6o3ME15sWO8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=n/GfTXseMB5nlFH1r/0DcVJB1Ohb2C6G68bcmVUA2O0oiNoxYI5/E1Go30979pPPNUoCVNqNHVI/gRXJo/x1LOTvJ9FwHcY7+oG5eKWqcS0TOH5I2Sl53391Cez6SN5beTMOfNAsG//9REk3lyJeHjCovC0P1Pm5TmbnX5UQVJo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA574385B511
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=PqQRCW3I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750951188; x=1751555988;
	i=johannes.schindelin@gmx.de;
	bh=S6QryzB3Etmz/gGKH7LelQjiVA+lDrns6o3ME15sWO8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PqQRCW3I6GYfJ0xYgdCCRXLDnCPpVPmrDSRjbsv8KiuHkaThrtETiiaHBGUjgW8c
	 d+jTZ1YCT5IZTWGV3mLz2sXmvMoqs82zHuRxX+xrQWZkwON1VQtOLIjyiY8xuOg85
	 4QNmecUD2Av+K7P5fnwkmvtrdNuUp1DrhYSdhuOQYDAnKk/vbvY2Iuk6+smUyHyW9
	 22JuO8uCMI9f/O+DCscOvpdW2sRH6wsYoprW0dhntDVa2Qx5n2GpVbeB6mJI4Eqxy
	 DcAs8pZhhaMktW8d7zzi7tC1KLd10xuT489cyAL72lomvyF11KsI2v28G7agz/W+U
	 F0tu9ZwbjQaaSeKEng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxlzI-1ufM1S1BNe-00wlLa; Thu, 26
 Jun 2025 17:19:48 +0200
Date: Thu, 26 Jun 2025 17:19:46 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <20250626234718.9898ff4ff4e1690b860e29a2@nifty.ne.jp>
Message-ID: <55ff7849-89e4-158f-86f9-21c76bfa3499@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp> <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
 <4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de> <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp> <20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp> <20250625211754.c9b38091a64362f2d28da1f8@nifty.ne.jp> <934bc894-d2c4-2a7a-e236-abec9e1717fb@gmx.de>
 <20250626142249.9a4d7378ec9fd68a7b2b8cb7@nifty.ne.jp> <20250626225926.ab18bbe2324b53b4335a35bb@nifty.ne.jp> <20250626234718.9898ff4ff4e1690b860e29a2@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8xQwL4WPBD2yISIizqSWfkD4tjPKtL57DFB4sFIOz+St9ECIeQ1
 5krcVMPh7mMwOsVDT1Hd52jUoo00YSrVLyI8RWIcSAzwMgMXwJJh6QVMpETGjr/vyDCNLGK
 j3TcmBY6C8zU3HJ/X7giUPTpEG58W74bjnHzdk5AH4FAXBdMNr4v3Dj/1dC4/l1Ai6t4ZV0
 WWsRhLkOgsj1uQmipPsXw==
UI-OutboundReport: notjunk:1;M01:P0:MQe2JA8mJKQ=;q+L5ZI/tmj2OUjNUDVII0Xrrtf0
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 26 Jun 2025, Takashi Yano wrote:

> On Thu, 26 Jun 2025 22:59:26 +0900
> Takashi Yano wrote:
> > On Thu, 26 Jun 2025 14:22:49 +0900
> > Takashi Yano wrote:
> > > On Wed, 25 Jun 2025 17:57:56 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > > Hi Takashi,
> > > >=20
> > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > >=20
> > > > > On Wed, 25 Jun 2025 20:51:02 +0900
> > > > > Takashi Yano wrote:
> > > > > > On Wed, 25 Jun 2025 19:55:34 +0900
> > > > > > Takashi Yano wrote:
> > > > > > > Hi Johannes,
> > > > > > >=20
> > > > > > > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > > > > > > Johannes Schindelin wrote:
> > > > > > > > Hi Takashi,
> > > > > > > >=20
> > > > > > > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > > > > > > >=20
> > > > > > > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > > > > > > >=20
> > > > > > > > > > I'd revise the patch as follows. Could you please test=
 if the
> > > > > > > > > > following patch also solves the issue?
> > > > > > > > >=20
> > > > > > > > > Will do.
> > > > > > > >=20
> > > > > > > > For the record, in my tests, this fixed the hangs, too.
> > > > > > >=20
> > > > > > > Thanks for testing.
> > > > > > > However, I noticed that this patch changes the behavior Cori=
nna was
> > > > > > > concerned about.
> > > > > >=20
> > > > > > The behaviour change can be checked using attached test case.
> > > > >=20
> > > > > Hmm, then, nga888(Andrew Ng @github)'s solution seems to be
> > > > > the best one.
> > > > > https://github.com/git-for-windows/git/issues/5688#issuecomment-=
2995952882
> > > >=20
> > > > "Best" by what rationale? That it passes the attached test case (w=
hich is
> > > > not a test case, by the way, as there are no assertions that can f=
ail, and
> > > > it is not integrated into the test case, please fix both aspects b=
efore
> > > > you call it a test case).
> > >=20
> > > The "bug fix" should not change the current code intent. nga888's pa=
tch
> > > keeps the code intent regarding write size for non-blocking write, w=
hile
> > > other patches do not.
> >=20
> > No! I was wrong.
> > nga888's patch trys to write more than available space just like block=
ing
> > write.
> >=20
> > Let me consider.
>=20
> I think I have found the real cause of the issue and a solution.
> However, I do not have enough time today. I'll work on the patch
> tomorrow.

I really wish that you would make it a habit to explain your thoughts.
There is no need to keep the knowledge so close and thereby preventing
others from working in this with you.

> Plaese wait.

Together with all the Git for Windows users who are waiting for a fix.

Again, I really wish that you would give me a chance to collaborate with
you.

Ciao,
Johannes
