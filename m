Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 034193858416
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 07:38:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 034193858416
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 034193858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750837101; cv=none;
	b=xrKzDTL9YdTsIITpTFQDNz7eZqapSCUOLRitbFKrdy+h5mh0ZcfN2oBZVE87oOsxX8MisSyqSFx82p9OZNC/LBU8yRPAZWzEnMyZ7EnNTdvKsE5Rya5U4f/vLrze/UOEADk2XMrtWd55ktGykpLAO0JiKeh7Q2AM7dU2L8I8Av4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750837101; c=relaxed/simple;
	bh=jxt2EFVarKjI649ojuz4S9D4WU0sZp0F1vEZep18kck=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ncell1OAs61UnwcJ95ivHwHw1a2LiP4nwoQjJuvKtrLK4cGpmMhhFhaY4aQRTzMg3k5QDnBMDHSAXn2ILjzPiOPBrxcVZTrqR0rDg0qbvnjUjG0FbBy34ZqlmySwEhsXnXeL7dGkwRb7HhVgV69y0CPAO4RsisU4x+NqPMzEwDg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 034193858416
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=oPuXgpoa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750837099; x=1751441899;
	i=johannes.schindelin@gmx.de;
	bh=WlaBVjI/ZI4f8ivL8o7pY73RQYP0r82O0kCPCCV/c6c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oPuXgpoa0/h2ZPVQLaANr4zjq2Te984tyksjK6xABjlWS/T5uqT1WybrCLVoZxyA
	 ROnKcCxH7GOdK1YVIoRUXXQGMfGLpwY4nPZoBcTvq5betS77rEeQF/Ql/PkG+w/UY
	 9+gA+4lAbnkJqGD0k4/WUfOinrp5DGhBxmv2dI55ALXTJvbBdm3lgqvePaaY/uel7
	 yqkDjDbDi4cJTv/zIk2tyCHTz7717/4AywQQLZ/usI6x7MKYBvoxsoX2H51meYuCj
	 dy3OpQmzC5yruLnuaf7VAr5RaZAzZPWjA6m04kXmaRVrZ/+5nkeg6+2nBYe4bnj0a
	 oCHtj4ZXpFfX3H49Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1vB3yR1pvQ-00b3Xs; Wed, 25
 Jun 2025 09:38:19 +0200
Date: Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
Message-ID: <4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
 <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rcfTC8AotQ2DkQgZKJvwFR3gB01eyr/1m3FrE6hBFzcBxmIHqQe
 TzaR9XvcTaKdK8920VWzoADUnWIyWNohPPM/RUtn+tBENRfk1BwXTRXOpDCgztfX6LERfAK
 dtkCAYWgXvJU//q74hBxfZ9vCPUrqkfLNTwpRXDt+IbIQovIlOPNT/Pznn39TonpSOVV86G
 zFZicyvfX7ijE9VKSbiJA==
UI-OutboundReport: notjunk:1;M01:P0:71ooispgORM=;M3kprzt7HlDWpkIqyb57mYrAWYS
 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
 V2WgWmZi/6Ti5Mdn4O2GLMKFm9dEVcAu4lNm0A==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Johannes Schindelin wrote:

> On Wed, 25 Jun 2025, Takashi Yano wrote:
>=20
> > I'd revise the patch as follows. Could you please test if the
> > following patch also solves the issue?
>=20
> Will do.

For the record, in my tests, this fixed the hangs, too.

The only two issues I found aren't new in your revision, but I'd really
like to address them, too:

- When running that `git clone` in a PowerShell inside a Windows Terminal,
  Ctrl+C does not work, the SSH process simply continues.

- Also, terminating the SSH process from a separate terminal window via
  `Stop-Process` (not `kill`, as I had mistakenly reported earlier)
  somehow corrupts the PowerShell session such that even a single
  keystroke in it will bring down the entire Windows Terminal window after
  a few seconds.

Ciao,
Johannes
