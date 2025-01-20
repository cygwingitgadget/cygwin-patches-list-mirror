Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 9B1BC3858D21
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 16:07:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9B1BC3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9B1BC3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737389241; cv=none;
	b=VIeLYJMLVyffXHsMSv2fCnU9KDc/Cwz9XATjBRAAu1bagGZ5HUVssFfSvVR/bawYUwiD8vRHPQKdPO+I5F4x9vTSbCFacgTIAsbjOvc1fOaNspVEMRCnma7QtB6FBH6jMt5FDHL8XNpKKt3pcIXpz+ElcKuvhIDuxuufoKajm8Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737389241; c=relaxed/simple;
	bh=G9rS9CNuS8p9EwOy+feHy8X4UAk/FPy6uuvkmXVY63Q=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=BoHDMA8Kp8YjbBwk7afZNEcSqZo4w2KtH4a1lpLAggzm5ziTO+PeKBRt66l3bJEex4tWN+sX0L4NdyMKtert8kV0XKrswih+LlUCBk6RlRmrxWbewTxbOhALFyUAJ8/+RWF5DRlJm98UsqkZ8V1L/bEZAKzCTY2ylv2Ji/LXluo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9B1BC3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Xa2orj+Q
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20250120160718856.QZQB.55939.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 01:07:18 +0900
Date: Tue, 21 Jan 2025 01:07:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250121010717.dfe8220d8e192c78c356e86b@nifty.ne.jp>
In-Reply-To: <Z45xfvmN1s6oGJKE@calimero.vinschen.de>
References: <20250120085249.1242380-1-takashi.yano@nifty.ne.jp>
	<20250120085249.1242380-3-takashi.yano@nifty.ne.jp>
	<Z45xfvmN1s6oGJKE@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737389238;
 bh=3lC7MLnPFlYLj3mKMbf304JcHzjHpoqH3wVzaXiTAHc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Xa2orj+QOfGWLNe21Z2/5DkYcrORpKKweAZ4vDN54IMjdyffw0qCMRSEDr1yR8TuUYGPqZkW
 mhQPDSeHjezs7/AOZt4tYMLtykCyvYxI4doyYY07fzAXawE+jSMmjHjowpgX85nIQYEan280tf
 QTyoqLMqVVpa+J9BB1u2m6eIw7odx+fBucMr68ORXC2Llz73D1RxesLgrnUbht7S5Bvot9VP1M
 01PimS3f2j/bMSBmC67WGkv1Hpa2myKdKwUl4kqlrv4xItDBXFMxTeEtDeN12EjZ/DNcjA0yja
 ODSj/nORpgLR2snSq3eDcugfSOg/r72CNunXk2SpLUFUgsXA==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 20 Jan 2025 16:53:34 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> do you want to keep it this way, or do you rather want to change
> cygwait to use a local timer?

I prefer changing cygwait() to use a local timer because:
1) It makes the __SIGFLUSHFAST patch much simpler.
2) I wonder signal handler may calls APIs that use cygwait()
   internally, where the similar will happen.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
