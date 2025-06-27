Return-Path: <SRS0=IwXV=ZK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e02.mail.nifty.com (mta-sp-e02.mail.nifty.com [106.153.228.2])
	by sourceware.org (Postfix) with ESMTPS id F0AD83858C50
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 11:15:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F0AD83858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F0AD83858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.2
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751022937; cv=none;
	b=m8AbqT4eba759acXj+6hkwidUjxazb9mv7E2Yr1mLngHxAPx1R2X7VJg1XCL4lOApw4p6fUIdDMRxuzUpwPvdQBPhDvHixeliPLAvI//hUlMTzCtzHDaKtaQP5pVqbXSwSEumsnhKNK8HqEWWWT7lYoROE1sK9oK6ll7mlTJrEg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751022937; c=relaxed/simple;
	bh=Fgc6EuS525keGrLq+mKzjTJ96fWi2JxZ4QZUDGegofg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=MJTPxvGOdfQP37tWAgO71mXmMDIH+Lv/7PNwvYOSVWYa24HAKKuWp4DclCTcS4PZG/4Pjr+QIg3g6S1fMq5/JyGyYQAG4GLVVp9QZarefPxjuc71y0no1g4Nb7ZYRk5wgBycSo4w/BqxtNd5MC7WoH0XksrGgPYo6/Plbfm3SFQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mta-snd-e02.mail.nifty.com by mta-sp-e02.mail.nifty.com
          with ESMTP
          id <20250627111504779.HGZ.116258.mta-snd-e02.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 20:15:04 +0900
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20250627111504725.MWWQ.120311.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 20:15:04 +0900
Date: Fri, 27 Jun 2025 20:15:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Fix SSH hang with non-cygwin pipe reader
Message-Id: <20250627201504.4ce78ca9d82d87dbb1c5751d@nifty.ne.jp>
In-Reply-To: <1a3de144-cbdb-87c8-d6e9-4ba3ae61765e@gmx.de>
References: <20250627100607.430-1-takashi.yano@nifty.ne.jp>
	<1a3de144-cbdb-87c8-d6e9-4ba3ae61765e@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751022904;
 bh=5YjngvNiLvgLAnGpLV7iovcNHvYKSBBGNsH/tJ9jM6w=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=FVFYT5RRXKx/aOjHA8h60YAK2lmFZrO2oUhvpMNlEgqjHIkCqPx5FPt5pVQl7TM4zqsKlj1/
 GBTMoz6SUe7VlK6wviI0xDXB5jVkiw3nnCYYntdwfTMXUrDTEUoEKBEtmBkODPhxMuk1qIraV4
 Hq1bQfUjYDR18eS3iPpByHqG5UW6p/YcRjx2PzBorpS/RSIPev6Nj9a/cx+YhHhjv9aKN7DKua
 aIZ/nSl6EG+CHpDERCZcyRVNtbwKn2fbRF4c2r+mRLVf+W6SaqV3iPxP94p+tDOLaroqTiXIJ4
 I9xTJfVGDyAQFzZPvWCCFaVeqlxAHF+ZeOm9qsm3wUMQhQRQ==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 27 Jun 2025 12:25:18 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> Good explanation, thank you for improving your commit message writing
> skill.

Thanks.

> > Also, pipe_data_available() returns PDA_UNKNOWN rather than 1 when the
> > pipe space estimation fails so that select() and raw_write() can perform
> > appropriate fallback handling.
> 
> This looks unrelated? Would this not rather be in a separate patch, to
> make it substantially easier to review for correctness?

I'll make a separate patch.

> P.S.: One thing that strikes me as immediately concerning is this part:
> 
> > -	  if (avail < 1)	/* error or pipe closed */
> > +	  if (avail == PDA_UNKNOWN && real_non_blocking_mode)
> > +	    avail = len1;
> 
> That means that the next loop iteration will call `NtWriteFile()` with
> `len1` bytes (`len1` now being identical to `avail`), even if `len1` can
> be substantially larger than `PIPE_BUF` (in my tests, it got stuck at
> `len1 == 2097152` in some instances), which is highly likely to be
> undesirable.

I don't think so. avail = len1 is performed only when real_non_blocking_mode.
In real non blocking mode, we can call NtWriteFile() with larger data than
actual pipe space without blocking.

When you observed `len1 == 2097152`, perhaps avail was 1, I guess.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
