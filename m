Return-Path: <SRS0=8BlN=73=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 792403858C62;
	Tue,  4 Apr 2023 15:11:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 792403858C62
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680621077; i=johannes.schindelin@gmx.de;
	bh=AtFXUvjjraocWiV5FbZRxjFIoVBKapj2nt/30x+Y6G8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=HGX9Z9SR9o+DL/n98dctwEtRTt1Lh/k/MC91eSA7mDPyBqXM95VNAMvARc7QD0Sp3
	 kHf4fqk830AiaXlCWUKvNxU9mGZtOSmfoKP1/WGaMbg7yEaveBbvPShHyC8r7h0Mmf
	 oBgFGhEJX7YX27Rig8XgVMdtcpng8m5qNnXiE2WnUafE8OmbsmGd8wnDScgYzLtPte
	 2ZpcgeUjSqgMds7VPjZUYKSHde73aXjmYGPYRSmAG0jS19mBYsZAc/e5bRXzUGkjTC
	 nkIxFCmf1HDJ3sB4vA/Z2Z8Vz3X9nRFrD0fHUDNKMbeCLEgzUJRxROcb6nSeiZM7Y0
	 i6zVQh9nD9rcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1qeos61Ehz-00xOID; Tue, 04
 Apr 2023 17:11:17 +0200
Date: Tue, 4 Apr 2023 17:11:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
In-Reply-To: <ZCsnyGMLSGY1nHbe@calimero.vinschen.de>
Message-ID: <330cda66-a65f-6f91-7669-d4d21443b4f3@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de> <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de> <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
 <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de> <8b84ada5-ae6c-febf-e412-365fe2f919fe@gmx.de> <ZCrUq1P4kOr7D44O@calimero.vinschen.de> <f6abb639-8120-fdb1-86ae-103565730789@gmx.de> <ZCsnyGMLSGY1nHbe@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZjrW+tghPdh3lm0fpSpuZoqwXvirq8cxA6vAiihdhhlcU/bcpj9
 gVeTtc01cJFDVdSGH2WFeFMh2QC9UkxeDgcRxG/TxKYVRHlNxkI+U/O5tqnr73lizomIY2e
 iC6FhkxuYPCa+hh+VYnvczQrgRo2ET4gK7tphut85LIVwKJcyCJxRnXyauMJJWmjZD6ryks
 Q9DtvnBZvBqnK5/6Xi0Mw==
UI-OutboundReport: notjunk:1;M01:P0:RN5WMBDukzk=;7ISRYJ4CSpSsJ6FszAzVpbYryhw
 Q0FUuW120z1QQ5GKkAd2g/RL3LPrnySwNm9XcHrsGAx0yWVVG8QwNAt5njEPW3a/mWq9FWzP/
 hY8QwV56xG0jhd71xwDrv/YkIhV1PwU7VeOMkCgT525c3xrIHsPKEtCJ3tw/xcFmrqm1B/7S+
 HHOzv+i+abJM+8b1Mk5o5kuNG0SB9OAYyaZvX7HVl8eZy9dmGKnqClmE1qS9zGuHvqoDwjhRh
 w5a+V98gQBkqCcnb0+kVIBmL+H0mlXyHdlrdnmUw9FyEZ6KQ7fHiKzsAVSBkH2JGWzf+6G18G
 t/DoIg7Baqsgf/XPZFx24S+ZB8gQvn8hw55rD/8vJPWqZrOBiPFMEqSBAwNjTsUVjhg2cQkZC
 4vWkZRaguzpqBLC//ArjctYUdev8enK7ZLit88ShhGwClALhp0GYhi2M3ypbfWPWbd6lsNdwk
 4lygu87e9tcX6Ev+1tK51D2B3U05dKML+gcytNUsbkIcAhS8Ca/cW3HJMOmWq1GmqCO8jI/m4
 7gonEAumicmaTmwIZ0gUPiDOp4BjbPt+IwwuRc/AtQtffZ8MPl1/3X9x5f4qfsmEi5EBUMnF4
 yOf4+tfI23Xf94icZ+jZd7X4jAzjgkMSo0lcdsgs+klK8XgdSUMeC+OSAUJvGsi6T+yZPloh+
 KUKjD6qD4UVrHgEnMvafj+mI6KCw+k48ILlDCu088MlK42V8/IlpOW0xfdlbqG/osYkgfcjAs
 DzfQV3ckL7gT+MJCIPEvUpS2eF85SOR9Oe8vXQ6deeLnH5PY3CEKKJpCI0+iz/7iSEPHZ6R1c
 aVsTD596VBe+Jcn5g8uNabzVtSEy93/DUf0j4Aw8JetaBiFrJWCe7Bfn1Zb/tT9hHLM78rTZP
 auoftwGZ/zSjJJpFmlj25tPWr5JECnYQO+VKjRigFPsJQI3TdaaTlASn7hmx8uBm445zh9NAI
 tfTCyA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 3 Apr 2023, Corinna Vinschen wrote:

> On Apr  3 15:57, Johannes Schindelin wrote:
> > On Mon, 3 Apr 2023, Corinna Vinschen wrote:
> > > > So here is what is going on:
> > > >
> > > > - The domain is 'IIS APPPOOL'
> > >
> > > There's a domain, so why not pass it to the called function?>
> >
> > Sorry, I was unclear. This domain _is_ used when looking for the uid, =
but
> > then we run into a code path where the UID cannot be determined (becau=
se
> > the domain of the account is not the machine name and the machine is n=
o
> > domain member). The clause in question is here:
> > https://github.com/cygwin/cygwin/blob/cygwin-3.4.6/winsup/cygwin/uinfo=
.cc#L2303-L2310.
> > The Cygwin runtime then returns -1 as UID.
> >
> > The _subsequent_ call to `getpwuid(-1)` is the one where we need to te=
ach
> > Cygwin to respect `db_home: env`. This is the code path taken by OpenS=
SH.
> > And that code path only has an `arg.id` to work with (the `type` is
> > `ID_arg`), and that `arg.id` is invalid. There is no domain in that co=
de
> > path that we could possibly pass to the `get_home()` method.
>
> That makes a lot of sense.  However, wouldn't it be better to return
> some kind of valid uid, rather than working around uid -1?

It would!

> > > > - The name is the name of the Azure Web App
> > > >
> > > > - The sid is 'S-1-5-82-3932326390-3052311582-2886778547-4123178866=
-1852425102'
> > >
> > > Oh well. These are basically the same thing as 1-5-80 service accoun=
ts.
> > > It would be great if we could handle them gracefully instead of
> > > special-case them in a piece of code we just reach because we don't
> > > handle them yet.
> >
> > True, but I don't really understand how they could be handled.
>
> We do something along these lines already for the AzureAD SIDs of type
> S-1-12-1-what-the-heck.  If we do the same for the S-1-5-82 IIS AppPool
> accounts, we may be able to handle this more sanely.  Just search for
> AzureAD in uinfo.cc.
>
> What do you think?

I implemented that, as patch 3 of 4 in the sixth iteration of the patch
series.

It is a bit more involved than I would have loved, but it does the job in
my tests (although I now need the fourth patch for it to work, which was
not the case previously, for obvious reasons).

Ciao,
Johannes
