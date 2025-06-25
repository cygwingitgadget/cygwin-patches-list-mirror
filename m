Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id E91643858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:11:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E91643858039
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E91643858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750853494; cv=none;
	b=URWTwG6bXMDdRMfSAciB3GTRgYdRJINtPPBTRrfjDpG5CTfNgPLhxdWKizR0pU4yHQBtVEODs4DBph+EqMK3hHCKhVkqS7++36Gi8VufqHGAM15/tKgwgPmcZ/71W5qqZ80YxM5uqQgF+RBxvdbDMbsL21P62f8AUGEDTEPfDKc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750853494; c=relaxed/simple;
	bh=/d+0Pq94oIdU+47Nl8ZCx4oTyrbJsXWky4OLkIJ6J8A=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=FOTIEWx/flK9WUF5qbHXWyFJ138/AUPdW6hcUcuCwxs/E2+2bq7Ts2xNQYWovpWEf7O+fvYqkIDa2BfVq01LU8J0uAT9mx5DP39T+OY3cJuZgkT9xhojsyWgbi4iiZIPRpiVfUcQY6VBK7DoeG5pd1TxS4RS4HlPzUKYmvogUbs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E91643858039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=EUNBbJJp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750853492; x=1751458292;
	i=johannes.schindelin@gmx.de;
	bh=/d+0Pq94oIdU+47Nl8ZCx4oTyrbJsXWky4OLkIJ6J8A=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EUNBbJJpJWwhcTVKFiMxNN/QFgDo9ovNeNnu9WUiCtGqKVogyByTZIBdolV/t0Bz
	 hnrFingJ/r+GnA1ZIfPbZpcRwV/XFmniUp0+ZaAvUkW76grWwBWgPJQCK1G8fUQIa
	 y+seov5rdwYzmu7CEQL+3LLdGbOx8CdFWXo03rWJPZJtjs6RA9N3o8qbC3hkSvU/1
	 W87YwcU7qx3NNc3hRclh136DMlcysiP2D6TvXXtnU9qnOjvN9WhWNXtC0yPIEG3fU
	 9hcOYlBRr+fWzvnih2FaoIunoBctP3jqeRWx0PtL4R8nT7WwxoDQWEA8UaG02rHFG
	 QV4BIAXJ5O1qcEAWBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1v1Gt22bX6-00lLMO; Wed, 25
 Jun 2025 14:11:32 +0200
Date: Wed, 25 Jun 2025 14:11:31 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <20250625200341.5c0d893a7d129ead53c89338@nifty.ne.jp>
Message-ID: <2630206b-ed31-5244-4355-6ef182cbada5@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp> <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
 <20250625200341.5c0d893a7d129ead53c89338@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aYhgkuylODR+jDrFhavM1m0ZZEqUJNrYAV+U8RcfytWFpOn7Hvx
 LVDYw6o8M6ev7nlC5wj664ncw+GMIPuhALh+nI3FfNlE2Aexin/Gc3I+VU5vMY2aS+q4MMj
 gCY054FqUUZg2RnvU/OYEhlZ4tDSBw7Gz6K/hCJMNJ1guUM1qhl7mVHBeARznP1LvAVCTDE
 EmCmNgwXI9wyDSDCx7giQ==
UI-OutboundReport: notjunk:1;M01:P0:zis0L51yv9g=;bJipjHjbeFxANGGGbaWM4FMCaGv
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Takashi Yano wrote:

> On Wed, 25 Jun 2025 07:59:54 +0200 (CEST)
> Johannes Schindelin wrote:
>=20
> > On Wed, 25 Jun 2025, Takashi Yano wrote:
> >=20
> > > I found the patch blocks non-blocking write in some condition.
> >=20
> > Could you please describe these conditions?
>=20
> Just try to write more data than pipe space at once.

I do not understand what you mean.

Could you turn this into a test case of Cygwin's own test suite, please?

Ciao,
Johannes
