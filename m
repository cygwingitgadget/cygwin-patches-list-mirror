Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id AE7BE3857B90
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:07:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AE7BE3857B90
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AE7BE3857B90
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750853244; cv=none;
	b=Ga6rdTmjQxxblmc6X4WYbudE9rdbhQk++KLzPANIQJsJ4KDLa1NOD/HqQ/hePzGffv+PpmU0cScNcMT4UOopJFRBHaOkHQpP5s1kcL8sSoq70+bWxYYGia0JIAC7Vu00Cpc6908/SA6f/wAlnuLREmWeKrAKD1NmajTrLo7l7ak=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750853244; c=relaxed/simple;
	bh=H8uHHo8/qbhwu2qETYozSoDuiUrda2RX9ZdVeXz3x2M=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=aTWerEQx1ZnH4+QhFRW5qRD+YORI6D/dOghL1ed6fYQUXs5uKGewY+t+kJT1avH9rsx1PnfD6FnDTa4DltdBzxtkCLNclVmzv9oTKScVhtVdUzKa6Z88FPB+zX9XawwybHiortCdsjQ5++HewkB8sDzQnoPE66zBAKz/yG6AXzc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AE7BE3857B90
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bywN6bdo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750853237; x=1751458037;
	i=johannes.schindelin@gmx.de;
	bh=H8uHHo8/qbhwu2qETYozSoDuiUrda2RX9ZdVeXz3x2M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bywN6bdo4wAtXOtInD0K7Gn91jlsN9aVuX1w6ljcCIbVVEX9F8iC9dDrwaVBYGPZ
	 dbq8n6xhAa60SrBqm4HoONlnrM4cCljdN8QnXhs31W5NjXxVW2tY/6l4S+bpxIHdT
	 JYZQAtW3Say3W9N2ihJTB6Sq/B6dfgl1Z/a0ENo3Fa74sZ9GeSpMWRPvy4il3+xrR
	 NJoZb5+2uq2b9DfL7oFEH1mRHQ3Jjv1ZnL/I2MZj8qW2mfCv3t1MZ1MVGsOr9D49V
	 x4Zb8p2GYuRpLKjd/N9mMz2QqqZog6h9TyU1BCCSmW5t9b1/WiVHa0OkOMfOVTwIk
	 GLBJbXvVNA4SjqJi2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1ugJcP087A-016KdC; Wed, 25
 Jun 2025 14:07:17 +0200
Date: Wed, 25 Jun 2025 14:07:15 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
Message-ID: <a379f48a-e0db-7769-2968-9c4df5293a0d@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp> <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
 <4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de> <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp> <20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/ILv3naTHDw3qBgLTq884UEjizlk80atjvSfZRsC1Vc7o2fUcCV
 HsdOV4gfnn9KNxx+2MHDf7d7POcJnkOF7kPMyxzT6UBVTNzIuLFOkWH5ft7gB6SJ0mnE8qE
 R9jvEH9C7/F5Rcy6BfmWb/bG9Pkz5HfL1DSTxdA7EEBkDODIqhR7+Z56lYpAuwVC6zBasrz
 R0DH+9C6n4CArJLaZPF1g==
UI-OutboundReport: notjunk:1;M01:P0:9ptDLVATfMk=;uo24ErbBP8ShOO1gT0yDfKC4Q5c
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Takashi Yano wrote:

> On Wed, 25 Jun 2025 19:55:34 +0900
> Takashi Yano wrote:
> >=20
> > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > Johannes Schindelin wrote:
> > >=20
> > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > >=20
> > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > >=20
> > > > > I'd revise the patch as follows. Could you please test if the
> > > > > following patch also solves the issue?
> > > >=20
> > > > Will do.
> > >=20
> > > For the record, in my tests, this fixed the hangs, too.
> >=20
> > Thanks for testing.
> > However, I noticed that this patch changes the behavior Corinna was
> > concerned about.
>=20
> The behaviour change can be checked using attached test case.

I do not understand what this undocumented code is trying to demonstrate,
not without any explanation.

Could you rework it so that it becomes a proper test in the test suite
that verifies that Cygwin behaves as desired, please?

Ciao,
Johannes
