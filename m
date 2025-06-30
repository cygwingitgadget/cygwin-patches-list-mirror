Return-Path: <SRS0=HGQb=ZN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 322F1385C6DC
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 17:24:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 322F1385C6DC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 322F1385C6DC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751304297; cv=none;
	b=RswMhgJBgIi0IC29s5dzvxRxww8chF8PcnjTxB+QFaXvPpyyNDVj7zaF1yxnbBZ2Q7oGGLljm4LExwBE+yrK/+4LwHgucHObdm+9WnM9lJcIVHCjjPoC9Xr3VcMB/MfAzzugyzdHTwr56/0OXSezaqUxSEyThsS5qYmoTyMCMa0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751304297; c=relaxed/simple;
	bh=gwg+R47VymZ7vhHa4mZNuwir6NMAcsgKmpnS3+BMeyI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EF5r1eA3Eg9n/loS/z0RGoLVM3yEp1FJ7KW92aqzCGVxLF/jTEixMbilhbiTHv2/fqhavEWf/HYnxkQhZr1C3Tc/yCMcCl0zOe+JoQ5FlY/E2q7QyLinvkKomnP7gpgJ+xf5bylFfjjtN/O4DHk24ppdC3gc9uFWV/acy7Yx93k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 322F1385C6DC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EUkhisMF
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20250630172452992.ZXSZ.61558.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 1 Jul 2025 02:24:52 +0900
Date: Tue, 1 Jul 2025 02:24:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Simplify raw_write() a bit (Drop using
 chunk)
Message-Id: <20250701022452.daecc600a7e992b8fadd1a50@nifty.ne.jp>
In-Reply-To: <59dc1841-3dc1-2e16-e794-908eb594de87@gmx.de>
References: <20250627100835.442-1-takashi.yano@nifty.ne.jp>
	<59dc1841-3dc1-2e16-e794-908eb594de87@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751304293;
 bh=bZWduhlS2lWph9ORa4tJiWARYaruCjsLz7YhSulgR+g=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=EUkhisMFLmeEGcWyMMzDzXoHhwfh2Yd/rxgdXDbIrrltlutHLkyQWB7nFw/OPbBcGp0mn+w+
 kNnzT1xLh7JHC6+5NEcwe7o4BVIxIrowpjKidR8Du/bzoZXdKUpKlUOoqqLyHgJtG7CjnIpAIm
 u6QTT9ShZ3ez97G1XjDiDIhWzrUUMh7sRLqIAgsdtfG+JM3PUOSnxgdCFilc3f3W6eAAkxtO+F
 j5FGFEVxxDpHFWQZZNsgV5u431bwxsmyHrAqI+8e8e5/tbiXm1CX76wzKB806RMNfuRUUJ3PbG
 lZTNBdXcJ73GaAtMjYGxNwLMdzROnRdXVZxu8UmIO2G4JDnw==
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 30 Jun 2025 12:18:27 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 27 Jun 2025, Takashi Yano wrote:
> 
> > There are tree variables for similar purpose in raw_write(), avail,
> > chunk, and len1. avail is the amount of writable space in the pipe.
> > len1 is the data length to attempt to NtWriteFile(). And chunk is
> > intermediate value to calculate len1 from avail which holds
> > min(avail, len). Here, chunk has no clear role among them. In fact,
> > it appears to obscure the intent of the code for the reader.
> > 
> > This patch removes the use of chunk and obtains len1 directly from
> > avail.
> 
> Now that this diff no longer conflicts with the SSH hang fix (because you
> dug deeper and identified a different part of the code as needing to be
> fixed), I'd be very happy if you fast-tracked this patch.

Thansk for reviewing all the pipe fix patches. I'll push them.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
