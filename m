Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 5E1FF4BA2E0F
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 14:46:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5E1FF4BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5E1FF4BA2E0F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773845165; cv=none;
	b=bIKlyVEp1qVibPD0qd5Rh18Sh/tqgtQ6SGAN2IL5YLv7GLLmBJ1QlZr4DrqEzjGFIOPZH99GWmbxM6UO+n7V0Qhw81vucMnDwvXUvmqPYuhobWjUosy0E2bjI5/5utg/tk8seyY0/dSHNxZoDKig2UFQxfXpInQRRvwXasVDV2I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773845165; c=relaxed/simple;
	bh=a2ONtyAKJ106wpqj6IZ4Pob+9nBsNatwcpG7aaffZz4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=J4fVTcj6hpHH5f6qJYVRfDvdP8QcKIPSawkvgLOlSLf1DPq0dcMmxg/a5A0p0l4q+GqxZnAzynT1YbE1yC6KIk0lxiHc4zxOuv/Hwdm9ECL3WNa2PizkIdAwIqqmdQyXYQuO1E57n7Tt77HplCDoSQBmLEFqfyT6cI7BO081W7g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5E1FF4BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QQcQjBQR
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260318144602289.TMDN.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 23:46:02 +0900
Date: Wed, 18 Mar 2026 23:46:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/6] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
Message-Id: <20260318234600.211af0aa09c330d145649239@nifty.ne.jp>
In-Reply-To: <20260318220114.7ce48e354fdc4d3014b1b991@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
	<20260317122433.721-1-takashi.yano@nifty.ne.jp>
	<20260317122433.721-3-takashi.yano@nifty.ne.jp>
	<2f8628d2-b79a-95a6-480d-7508375958d5@gmx.de>
	<20260318202032.54cf28ea83d863082f1bb153@nifty.ne.jp>
	<20260318220114.7ce48e354fdc4d3014b1b991@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773845162;
 bh=IXbaZRlW5Tjn25xVUjpVcdos5hhZ5lHuxwKblSQ8zhc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=QQcQjBQR/PxVR+1tEKH3ZtohqnaNTvU+8w/RMr0giwYjtSRtYa0C7Svq63onDjyz/qMNEk7b
 HTLwZenP0r+XX5hhrh0lRT7KjD3CkXWY5hTtLcJyrG7LrST+DtTctg+vXyuJqLQ8AXxDI2NCL4
 momxFVOvk7wYl8wzVkB2q9x+/Vr6HY0v5O6M9nBQdSUyVMDTdygHugyVWWEog/20EZlV05qWrf
 TZl/fLauFVVwQ4Jg7RHbehREm9+DgAUE9enUh2TWCc6K4k5OZLrYQxYxBtew6YvjEwuUPywya6
 6FM4IztMqgxNDm/vuH1LZKJ2xfjblLj2NcVH5+COtnq0svNA==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 18 Mar 2026 22:01:14 +0900
Takashi Yano wrote:
> On Wed, 18 Mar 2026 20:20:32 +0900
> Takashi Yano wrote:
> > Hi Johannes,
> > 
> > On Tue, 17 Mar 2026 16:28:28 +0100 (CET)
> > Johannes Schindelin wrote:
> > > This cannot be correct, and I am rather convinced that the idea behind the
> > > patch (interleaving `WriteFile()` calls to the pipe with sending raw
> > > keyboard events via `WriteConsoleInput()` to a _different_ handle) will
> > > _never_ be robust enough.
> > 
> > Then, only the thing we can do till fixing the issue upstream, is
> > writing all chars using WriteConsoleInput() instead of WriteFile()...
> > 
> > What do you think?
> 
> On second thought, replacing Ctrl-H with '\x7f' might be enough.
> Please see PATCH 2/6 v2.

Sorry, something has been broken with the patch set:
PATCH 1/6
PATCH 2/6 v2
PATCH 3/6
PATCH 4/6 v2
PATCH 5/6
PATCH 6/6 v2

Please wait a while.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
