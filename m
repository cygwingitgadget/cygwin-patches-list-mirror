Return-Path: <SRS0=1xMm=ZJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id C7A57385703B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 06:23:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7A57385703B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C7A57385703B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750918992; cv=none;
	b=FZLMdPIWBE5FKNYRL+6E9PwoW20GbfpYNajx919ga0SKS/YfgL6lQD3jCsnn7qoDaLZZcqHyJwlkGdRghR1zsRNgJPT9v/g8fBLqRLQmAeHmJ9Gqv+GRZ5urbx3avpT8t3XZXwOoOaSwXX9GLTYsL3WBE3tBSdKT7THY4nyqvTE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750918992; c=relaxed/simple;
	bh=fLhNZJzxhLJUgc11hULS8fQ6qXw3zQ3PfGIGYUYOxn4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=B9QxCjjztjhjSfCH2yUaWpUbvOWNOgYf2CgHIwQFrITtzZqOX5l1KCCPIYaOwUXfy5Yc205sSgTprwNU/YavKnfQ2cgIfMO4i78K9mQZBIS+KpU0BNS4e69lvZFBR2VutzzaCeRfBywnXTnMbTkp31gBzVhCELleECIVWJh8XWM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C7A57385703B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nWFVMJq5
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20250626062309857.YMLV.111119.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 15:23:09 +0900
Date: Thu, 26 Jun 2025 15:23:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: signal: Do not suspend myself and use VEH
Message-Id: <20250626152307.969a837dd3f6f61a911d287f@nifty.ne.jp>
In-Reply-To: <aFvg3hoUyfr_bVSd@calimero.vinschen.de>
References: <20250625110434.1533-1-takashi.yano@nifty.ne.jp>
	<aFvg3hoUyfr_bVSd@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750918989;
 bh=nReNP7PrDpIN+7V1Hm7HVzpdF/AZRRoLiNXN2baFOdk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=nWFVMJq50mZlDDsPyRblggwjZxdVJQedX9eCbzb0KBEp/7Liwjh0uzZNw4BEG62h9Lo3+TXV
 n2lHGUn/jdCUeaH7dqBV9q1654JlZEUBm9gYeUM+SjfufBiw+yXNTfjOQ3DTnN4+mH/JZr6DiA
 l/LJfBYaePiICBxIa3u8UBOCtaGskYmIoJFYAc+vHupqRwxyo2GQ3c99IY7anIbfYoznVjFHA6
 ulrt5O8t8QTyxZ2c8AFhvR5n+XgxyydrzXvS3OQbrtukotYR/OnVHjjWgOArjELHDQba4dLgje
 YENjG0xhn7WJANnJZ+3RAiex+W5RGlqUKZo7R5siYCObp9MQ==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Jun 2025 13:43:26 +0200
Corinna Vinschen wrote:
> One last question.
> 
> On Jun 25 20:04, Takashi Yano wrote:
> > After the commit f305ca916ad2, some stress-ng tests fail in arm64
> > windows. There seems to be two causes for this issue. One is that
> > calling SuspendThread(GetCurrentThread()) may suspend myself in
> > the kernel. Branching to sigdelayed in the kernel code does not
> > work as expected as the original _cygtls::interrup_now() intended.
> > The other cause is, single step exception sometimes does not trigger
> > exception::handle() for some reason. Therefore, register vectored
> > exception handler (VEH) and use it for single step exception instead.
> > [...]
> > +	  while (!in_singlestep_handler)
> > +	    RtlWaitOnAddress (&in_singlestep_handler, &bool_false,
> > +			      sizeof (bool), NULL);
> 
> Is there *any* situation thinkable which would make this loop run
> forever?  I.e., a situation where the VEH doesn't start?  And,
> would we even have a way to handle that?

I cannot image such situation, but, yes, it is safer to use timeout
and error handling. Please check v4 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
