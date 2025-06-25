Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 930A43857C67
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 15:58:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 930A43857C67
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 930A43857C67
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750867084; cv=none;
	b=bBLKufbMlO0fIMJSgguZJKfgIVyAsKbyd1ddHHIrfnywcOqE2kXrJIr3asmqjYNg7v50WRG41YpPWjxmsq7q0lkBF/GNJlNVrLZb8Xrh4ytITSi216dmN7jecRvgKLXiL5Ma1D7kvo7oIQkpN/CKWeQUJHY+JRMJrT0J8FPxU0c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750867084; c=relaxed/simple;
	bh=thikU1sv3f0c3Z7mJSV0rHwVhG4X57GFwDsJiL0n6lw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ema7yOasMuS2HBaV6mU1aU3u7MIFBfR2fpcZ8xu80pdHhZVzNd9I6FyCGvQNrTOqYFXpPRlSAve7wLGeqtTAzh4MKYa8Y17G+rhkWt6WGpD4P6ViHMl1dV4DVNRMqwZk/1HZiJU/5dxOxC4DwUXEl9TID6Ky7DRCCxCj2hZqia0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 930A43857C67
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=hNDdKHhB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750867078; x=1751471878;
	i=johannes.schindelin@gmx.de;
	bh=thikU1sv3f0c3Z7mJSV0rHwVhG4X57GFwDsJiL0n6lw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hNDdKHhBn5wrdgE5dz3op990FNyPW7yv/g54q3czBd+AXGc1j4KTUGSpUTtBlcCT
	 +uPly4+gbevlYH8yEuGy3MszyZG6dwJcmjNQe5RtHV9evsq8MfEpAEdwAw6J7YfVh
	 eauSS/5EmdwpoaTH+DCJftpFbVn4sMZHy1PcwSLXVSLUWSIdz7FHk4oVrSuTcW7g7
	 0kagNNOLJ7FXuOjtfqK1LNAm8ImR2AkR4LC6dXQjh5oNSByOrBMzQQClUBcJ5zOmo
	 Arm1Z4RN7BJ5chZ4pVcV1chvA4d54IdyHvHCVw6kg1GGzLiGZQsEKsXj+pJBFAR0M
	 V1XneT23vFWUqou2rA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXtY-1uLlMU0Y7c-00KMMF; Wed, 25
 Jun 2025 17:57:58 +0200
Date: Wed, 25 Jun 2025 17:57:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <20250625211754.c9b38091a64362f2d28da1f8@nifty.ne.jp>
Message-ID: <934bc894-d2c4-2a7a-e236-abec9e1717fb@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp> <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
 <4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de> <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp> <20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp> <20250625211754.c9b38091a64362f2d28da1f8@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pEXdYfTwE02dMeSU0/yblWBvxzPUy/n3FBEnio26QgLtiU/BOI7
 6Q6EboUJ4JV35paSy53fKyMXHOMZ+611xFoNpRgoASdpDLN7zTm3FtI9cYQXZWYBi66QxpK
 +iAgdpPEg+QOIMiD2H+QES0wZLeHYzkx3l8KGEurZHKYQhUJstC2CjKN8Z6YkKQIBN/oVv3
 cY32ahjaY7BDk2nLDeHnQ==
UI-OutboundReport: notjunk:1;M01:P0:kM+DBxGoUW8=;0PsdSYIc8CTXfArtNoDxErdv+G6
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Takashi Yano wrote:

> On Wed, 25 Jun 2025 20:51:02 +0900
> Takashi Yano wrote:
> > On Wed, 25 Jun 2025 19:55:34 +0900
> > Takashi Yano wrote:
> > > Hi Johannes,
> > >=20
> > > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > > Hi Takashi,
> > > >=20
> > > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > > >=20
> > > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > > >=20
> > > > > > I'd revise the patch as follows. Could you please test if the
> > > > > > following patch also solves the issue?
> > > > >=20
> > > > > Will do.
> > > >=20
> > > > For the record, in my tests, this fixed the hangs, too.
> > >=20
> > > Thanks for testing.
> > > However, I noticed that this patch changes the behavior Corinna was
> > > concerned about.
> >=20
> > The behaviour change can be checked using attached test case.
>=20
> Hmm, then, nga888(Andrew Ng @github)'s solution seems to be
> the best one.
> https://github.com/git-for-windows/git/issues/5688#issuecomment-29959528=
82

"Best" by what rationale? That it passes the attached test case (which is
not a test case, by the way, as there are no assertions that can fail, and
it is not integrated into the test case, please fix both aspects before
you call it a test case).

Ciao,
Johannes

>=20
> The test result of the attached STC is the same as that of cygwin 3.6.3.
