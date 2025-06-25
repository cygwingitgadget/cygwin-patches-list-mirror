Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id CAAA63857C67
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 15:56:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CAAA63857C67
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CAAA63857C67
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750866999; cv=none;
	b=YsS1E67GDD2OV3udteL8bbq01ICGcrPFNXL/qoJG4BoqIhviK9mdnrAiHhCIONHzftypUZoT8XDPWSfE0soX3uw5NcYgv9OyMT86sSTT0lMPgWIM5cdP7n8WA/CLHn49xIrTiVsJ8TvGtpTV5jrAnnKkol12m+xQjfOvuieFkaE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750866999; c=relaxed/simple;
	bh=AGS8gPylcM9Emlnke45YB+N20jMVJTSSMD0v428ly6Q=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mKgEq6Jn0RewtcnBItxAZYd+wVUMMKbfvqjDxtUY9NOQguxBPV5U1z04ESbPyjyjm+RZ4KcUQanaSbrOdhOS29RvZ9NN02OFCYq11N86QOEWYyNqELSTD/kH5RYoxUIgrtO0S6WLbS40XLivAbeOFNrNQzP22Egrok2tDz8aKS0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CAAA63857C67
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=USlDiXmy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750866997; x=1751471797;
	i=johannes.schindelin@gmx.de;
	bh=Lety4OXX0wro+tEigWZ4OmOSXFNSDV3lQmMBJTkEOwU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=USlDiXmyywXjAnLBXEHq8CPLyE5fYoFwCaHOQSqzsm8JckvhUaFZcucL4xEe/eJ3
	 mj/hwnX27hjRjRND7gPMHsFaqe5z+JCLNyhk83pRFJPhEoz3TVJgWCqpYPPKN+TBl
	 c4z7BPLbHcNmR93jjllIo4QHPg/E01wR4kE0uMY3R4O/uydvbal5ykFpuVdUxGuor
	 NzYGwuqeS5NjNuhGb5S5anqh1KngnjBl5iw2zJ4+O0KhgbAJiF9taNp3VCDHMNpbR
	 ystAGiIdV10lI8OpE8qky3WG5nOkaTMJftiaZjHbhQuYaiRiDZLaHgXHyCm/l9aSC
	 Uhga3PKjkqW46FRflA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1uLD5n1r6c-00KuYO; Wed, 25
 Jun 2025 17:56:37 +0200
Date: Wed, 25 Jun 2025 17:56:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <20250625212658.2f607120a5e7fd709cf8022e@nifty.ne.jp>
Message-ID: <35fb9069-817b-7416-d810-be0187fc96a8@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp> <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
 <4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de> <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp> <20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp> <a379f48a-e0db-7769-2968-9c4df5293a0d@gmx.de> <20250625212658.2f607120a5e7fd709cf8022e@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C8B1Sq7+gdSTezS2itFKZb5vyPLcSfbEnQbeOMs2Zl0ceTh0Ylw
 NCmvNja/JbY+bQhflGBO0xwn2BOuPuhqsDvmSIGp1DIG2MrknkHJ72BIInoO5CFPoOtuoX/
 MHOIWs3oQp3In80aRbeHsRiUmyLX2MUPnSS3WbZt/IcIvCOehwQx+jzpq63o9K+1p0nQgwb
 RN+CNl+2t4Hq+UwUTXhpg==
UI-OutboundReport: notjunk:1;M01:P0:jO0wLZWpYnM=;O+lGd0oBnsv7mTBiE9WaVdCQ+Dy
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Takashi Yano wrote:

> On Wed, 25 Jun 2025 14:07:15 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> >=20
> > On Wed, 25 Jun 2025, Takashi Yano wrote:
> >=20
> > > On Wed, 25 Jun 2025 19:55:34 +0900
> > > Takashi Yano wrote:
> > > >=20
> > > > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > > > Johannes Schindelin wrote:
> > > > >=20
> > > > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > > > >=20
> > > > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > > > >=20
> > > > > > > I'd revise the patch as follows. Could you please test if th=
e
> > > > > > > following patch also solves the issue?
> > > > > >=20
> > > > > > Will do.
> > > > >=20
> > > > > For the record, in my tests, this fixed the hangs, too.
> > > >=20
> > > > Thanks for testing.
> > > > However, I noticed that this patch changes the behavior Corinna wa=
s
> > > > concerned about.
> > >=20
> > > The behaviour change can be checked using attached test case.
> >=20
> > I do not understand what this undocumented code is trying to demonstra=
te,
> > not without any explanation.
> >=20
> > Could you rework it so that it becomes a proper test in the test suite
> > that verifies that Cygwin behaves as desired, please?
>=20
> What the comment in the source code says:
>=20
>       /* NtWriteFile returns success with # of bytes written =3D=3D 0 if=
 writing
>          on a non-blocking pipe fails because the pipe buffer doesn't ha=
ve
>      sufficient space.
>=20
>      POSIX requires
>      - A write request for {PIPE_BUF} or fewer bytes shall have the
>        following effect: if there is sufficient space available in the
>        pipe, write() shall transfer all the data and return the number
>        of bytes requested. Otherwise, write() shall transfer no data and
>        return -1 with errno set to [EAGAIN].
>=20
>      - A write request for more than {PIPE_BUF} bytes shall cause one
>        of the following:
>=20
>       - When at least one byte can be written, transfer what it can and
>         return the number of bytes written. When all data previously
>         written to the pipe is read, it shall transfer at least {PIPE_BU=
F}
>         bytes.
>=20
>       - When no data can be written, transfer no data, and return -1 wit=
h
>         errno set to [EAGAIN]. */
>=20
>       /* Independent of being blocking or non-blocking, if we're here,
>          the pipe has less space than requested.  If the pipe is a
>          non-Cygwin pipe, just try the old strategy of trying a half
>          write.  If the pipe has at
>          least PIPE_BUF bytes available, try to write all matching
>          PIPE_BUF sized blocks.  If it's less than PIPE_BUF,  try
>          the next less power of 2 bytes.  This is not really the Linux
>          strategy because Linux is filling the pages of a pipe buffer
>          in a very implementation-defined way we can't emulate, but it
>          resembles it closely enough to get useful results. */

I do not understand what part of that code comment refers to either
documented behavior or to a thorough test you performed. To the contrary,
the code comment merely states "NtWriteFile returns success with # of
bytes written =3D=3D 0 if writing on a non-blocking pipe fails because the
pipe buffer doesn't have sufficient space." without backing up that claim
with a reference.

That's not good. I cannot give my blessing to your code change because you
haven't yet given me any reason to be confident in it. I must therefore
suspect that there are faults in it, based on the story the commit history
of `winsup/cygwin/fhandler/pipe.cc` tells.

Ciao,
Johannes
