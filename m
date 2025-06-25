Return-Path: <SRS0=0tR4=ZI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 3B3D23858D20
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 06:00:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3B3D23858D20
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3B3D23858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750831204; cv=none;
	b=SO4fBduF27hdRs48w7TfxB9valMEdH9BZzvu5meKtHr7qqRodYnzsQjOrB+h92DGNuFdCL/HicCvAuLpfsBf+L0o+WXU/EgCx8MlKYK/MNPSKxQfcnu4LS+24VZpe/9aHAbdwH4CTMzkfQycFv6fdQN28C0wmgKWngb/Gndu8v4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750831204; c=relaxed/simple;
	bh=I+1/Ad6gzdhbp0V8764ur/iuuvfG30JIuiQ07JQfqGM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PeRxAL6Q+zzhPjC7c6rSSmikuptwGhr3bFxBKZGStzH+xgQaTtlt35UICaZQLIpR9Mwev5OKP0kL4eKwH1FwOXzK3YnQSsKbG9bDIHo8sWlJfwDR74fcCbxoS5yegmvp30BR8/zkZJjMRtlvz6GbfahyOwgfJZf2QGG2mm0ZhTo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3B3D23858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KsdCpG1v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750831197; x=1751435997;
	i=johannes.schindelin@gmx.de;
	bh=I+1/Ad6gzdhbp0V8764ur/iuuvfG30JIuiQ07JQfqGM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KsdCpG1v+kwPHYnNg5IjVw+2j3mM/qlBnBzWy9RFR4AtL+KKaCjPl7VwurXUuvE4
	 vKqJdd9/yhe/PK9ZmB3PbdUGPuxPVR0NBO/fZ03uyvxCztlHTkilT86h1IRqs054W
	 UUSiLVChBfMCd3Cc6KPS+2S1nIdWgwwXUGoKGGhv5nvkk3OH5HN5/k77vDmOcW3pT
	 s3tQHdYNcRCv9K+/Gt8aDUSr8Ln/c0xmiTrVJD3eCQKtTYILjOLiO9LVxCJPvcCK6
	 YxCLjrtxtJGdiMfWZfBkDGLYdHcduQ80VgI+WWxAZSSHtZWj/EW00Bc466Qeu/Ixo
	 Ar0CrB6nkFCHD3hvBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwbz-1uag2G0yXx-009QLO; Wed, 25
 Jun 2025 07:59:57 +0200
Date: Wed, 25 Jun 2025 07:59:54 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
In-Reply-To: <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
Message-ID: <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann> <62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de> <20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:D4MAS60AfR3MNrmbD1jyjmhwXrR8lQlglxaHeWuB6PNG2gHvkpS
 pchP87whH5imuVcPZ3h3B50VdbqmtF9Yru3gBrvPGW2qwVPgOXISaXGlXF4LI8sGrbl/xdr
 Nu+aZhjrBPGefhjO+CDxHZON0jRLbTMqbQjivdDzmNT/Qhdc6GiNMVcBG6YyA2JjO9rUqEr
 ICQtLdLdQHn8MubQnDFkw==
UI-OutboundReport: notjunk:1;M01:P0:cJOX9ZEGr4Y=;wlLaKJqI0cQo5v0xO99dQTT/+eR
 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
 KPyEcoxwZKuUfvg3
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 25 Jun 2025, Takashi Yano wrote:

> I found the patch blocks non-blocking write in some condition.

Could you please describe these conditions?

> I'd revise the patch as follows. Could you please test if the
> following patch also solves the issue?

Will do.

Thank you,
Johannes
