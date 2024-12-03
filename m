Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 11ABB3858D33
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 12:36:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 11ABB3858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 11ABB3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733229388; cv=none;
	b=vs4tYBNaSXIIrIdS5EkggR0I2DX7xqTdLNt3Qx9IH47ZRUSy6YP5OzL0M2I7Lzhc3Xb5OZl+vJUVuugsiuxh6L7kRjO+WBvCw1f7IjpdK5vyclQCSd4kmiLonQS06VhvJQkt0wNHItemdUC1SPO1YeSTZ5pa8oFw7NlqfE0hsrU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733229388; c=relaxed/simple;
	bh=t7YV49QYCOkTx1AjBiNawOnaWkTaZuR050b8P3vT9g4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ZXT/GfzPMOJfMKfFSQrYj8nOZJL9zY2wgyNJKVfWnk6AYVkPivo3lhc9gMeGqBbJ6EBuwtRudAQOhFAzqP5Y24+xSlWAX3aK/+rIwEeOlvcuGjehH3tFy/yMfWHkdtaBX0RTmziizEYqQJTBmMSlg3BUJkA+TsNe9R7q8y4l37E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 11ABB3858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bg1xWQPP
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20241203123626252.HVJY.12429.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Dec 2024 21:36:26 +0900
Date: Tue, 3 Dec 2024 21:36:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/7] Cygwin: signal: Optimize the priority of the sig
 thread
Message-Id: <20241203213625.70aadacf345dd79a9c7053e8@nifty.ne.jp>
In-Reply-To: <Z03Dco0-3zegUX7w@calimero.vinschen.de>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
	<20241126085521.49604-5-takashi.yano@nifty.ne.jp>
	<Z0dOoZwvFlgsCJNd@calimero.vinschen.de>
	<20241129205816.38feaf80bfef27cc563dd5ad@nifty.ne.jp>
	<Z03Dco0-3zegUX7w@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733229386;
 bh=k9FsBEP7IpM7TnBlOT4ffWNyas4u9RQ1jka3aYSiU6w=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=bg1xWQPPTK3eYn1kQny4MdcgYc0i1ASvXETMM41Y0D4I+E/nG32fbYtMF+drxkSl4+MWt+Rz
 ey6GWHhZSMeV6brv5Y3bHUYbUnP1yOQwy9sKsgPWxXP/ZkuvFGpyAC2MvNmArP9VGIPhX6KETY
 Qia8GMzCP0nty2yqOSxtRtKpzvh2d4BD1Dc0sf8gLUobEgWR3kQdy4qT017K5nZKq3xRiuAUVM
 OvJGcJDJ+cEOLO1OSJmcxeMk8cvZQs2wFIFZPTa6gC4cnnfeaS/JW+NzsQqwF1m/+ePPbWbQsW
 Y23YHfdNVlmxkYqjEfS3UILneL+BbWPZLCL0V1JhJZQ4w42Q==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Dec 2024 15:25:54 +0100
Corinna Vinschen wrote:
> On Nov 29 20:58, Takashi Yano wrote:
> > On Wed, 27 Nov 2024 17:53:53 +0100
> > Corinna Vinschen wrote:
> > Hmmm, just setting THREAD_PRIORITY_NORMAL might be appropriate.
> > See v3 patch.
> > 
> > > The culprit of the behaviour you're seeing is the fact that *all*
> > > cygthread's are running with THREAD_PRIORITY_HIGHEST prio.
> > > 
> > > Maybe it's time to rethink this.  Most (none?) of the cygthreads really
> > > need highest priority.  This *may* have been useful when we only had a
> > > single CPU core, but these times have gone by, and cygthreads serve
> > > quite a few tasks which don't need THREAD_PRIORITY_HIGHEST.
> > > 
> > > We could try to start all threads with normal priority, and
> > > only threads suffering from priority problems could be moved to
> > > another prio.
> > 
> > Enough testing will be necessary for that, I think.
> 
> I see what you mean, so yeah, let's try it your way and cherry-pick
> into 3.5.

You mean applying the 4th patch to master branch, then apply another
patch which drops setting THREAD_PRIORITY_HIGHEST. Right?

> For the main branch, we should really try to drop setting all
> cygthreads to THREAD_PRIORITY_HIGHEST and leave it as the discretion
> of the thread itself to manage its priority.
> 
> Also, even if a higher prio is required for one thread or another,
> THREAD_PRIORITY_ABOVE_NORMAL might be sufficient in most cases.

Just in my short trial, there is no problem even without HIGHEST
proiority. I'd test that more.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
