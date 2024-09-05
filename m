Return-Path: <SRS0=+UMj=QD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 5A294385843B
	for <cygwin-patches@cygwin.com>; Thu,  5 Sep 2024 13:18:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5A294385843B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5A294385843B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725542329; cv=none;
	b=v1VWppv7TExyZLFoDyDLu9zSppRWrjcDC3u9J4wEiBBXMMV7LfdNW9xFCXAwvmLIDrsDzSLV9hKjylJPyOwIoyxAomze1FBuAkOytCFCG11wyHhoGhGsCkcgqzCQCJnBq7FAGjZLE1+YM9tBjkMg/S0A7OTLJGOgJZPfC2W44os=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725542329; c=relaxed/simple;
	bh=9fOlLdSZTyBYfIWNsX6CxcixrU7g6FbMM5pjNehhRG8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Hg+a0uoxIm9c5xiIpjLf9OOnx+zf0xVmQjATrkISIennjECDlx4UHeeXqxDBBEJERX3cK4U4umZAFRLwLHwSRKdoxqACrOSo2LMmxJUfZbxc4/cCBXE/o3eSBMm8nAIom4ZbJYw/eqc2+IbOOXzrLmsoN59I+sE7dXzmyVE5hj8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20240905131842949.BKQI.81160.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 5 Sep 2024 22:18:42 +0900
Date: Thu, 5 Sep 2024 22:18:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240905221841.002f3f6fa53baa468b0cd136@nifty.ne.jp>
In-Reply-To: <20240902233313.171fb48cc8243cd095d7280f@nifty.ne.jp>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
	<ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
	<a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
	<20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
	<20240902233313.171fb48cc8243cd095d7280f@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725542323;
 bh=lHHsQnMNRdXdSIeLIin18fjr/dHZXONloY9HRoEExZc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=eYFoB2KD/86xG9InegRUjgCfFPQVulNj7ZiWBlhlORp/IDMLnSgQq+5nvXahrBXyqeCraldO
 Dxc5weRtPU7zVcaKgXpDdmgMUMT8fWEqyAPEAPMZLIpFgHTc2x6knkkrADFOi8di8qJflcwL11
 03ZbWUwaoGOihkO9KeWR+rt9DhhsK2dAElcMpVyBMgae4jjFFNMYRQnQu6Ullluj8fjigPSKCx
 xHNM245VzpT2ttJ6hvysQwezse2lGKG4KDRr9vwZHm0Tjchr3q93YIxtunEf6nQqq5nlDOdVt4
 sRKXheJwNE5l1l14C1EtWbGSEXsSEIV2Fm3LhNIBAbF61GtA==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna, Ken and Johannes

On Mon, 2 Sep 2024 23:33:13 +0900
Takashi Yano wrote:
> On Mon, 2 Sep 2024 22:50:45 +0900
> Takashi Yano wrote:
> > On Mon, 2 Sep 2024 14:48:35 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > I have tested it and the symptom is addressed.
> > 
> > Thanks for testing.
> > 
> > > I do have to wonder whether it is intentional that calling
> > > `set_pipe_non_blocking(false)` followed by `set_pipe_non_blocking(true)`
> > > on an originally-non-blocking pipe will "restore" it to blocking mode,
> > > though.
> > 
> > I'm not sure how such symptom occurs.
> > 
> > Calling `set_pipe_non_blocking(true)` on an originally-non-blocking pipe
> > will set `was_blocking_read_pipe` to false.
> > 
> > Furthermore, regardless of the value of `was_blocking_read_pipe`, calling
> > set_pipe_non_blocking(false) always sets the pipe blocking mode. It is not
> > due to "restore" logic.
> 
> Ah...
> However, if a cygwin app executes non-cygwin app and the non-cygwin app exits,
> the read pipe remains on blocking mode. Then the cygwin app cannot handle
> signal on blocking read() after that.
> 
> Let me consider...

I have submit a new patch for these issues.
With this pathch the strategy of pipe read/write for blocking/non-blocking
is re-designed. To eliminate toggling the pipe blocking mode, cygwin pipe
is always blocking mode basically, and non-blocking mode is sumulated by
raw_read() and raw_write().

The new patch will be posted shortly with subject:
[PATCH] Cygwin: pipe: Switch pipe mode to blocking mode by defaut

What do you think of this idea?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
