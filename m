Return-Path: <SRS0=Ctoq=WW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id C5D5B384A419
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 01:58:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C5D5B384A419
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C5D5B384A419
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743731924; cv=none;
	b=oOweOpUO/s/rbDx7ZSKskZ4AU1AB9UJBecB09tfWYhd6MoO/I4cYydZhIO9bFx7oaWC/MdOEFeOXo6NHIYxNG+4nMleapucaXgdEGw2mjXLqD6ZzAEdLKLLq5s8HAv8F8bsxZy+Nvbl3OsjalJqaim9po9Dpi2kNCHB/BCrHCOE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743731924; c=relaxed/simple;
	bh=xrBaycytTLgnWpU4qh4XasMP82+wXiRnK4GIG3jvkrI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=yCy1HKlt4uN0txw91A9s8ado+wwf7UJBDhozzEAx3M2xpmxxYiG9yx0WnIxuLN4gzxCHvxU9ighEXWnqwacx9Qerodm3el/t2KjqgECDtGLqawYViZ+l1vTYlW2i3zCP5Yc9WUIrnku63KyxPAVz0TStdMbns3FazmYyiddC+F4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C5D5B384A419
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=n7v3Wmot
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20250404015840701.ILAN.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 4 Apr 2025 10:58:40 +0900
Date: Fri, 4 Apr 2025 10:58:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
Message-Id: <20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp>
In-Reply-To: <ec45497d-a248-1056-4993-da137267b7c5@jdrake.com>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp>
	<969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de>
	<ec45497d-a248-1056-4993-da137267b7c5@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743731920;
 bh=78gaOP09iwHWi9fJorlugBNLj+95mey+/aIKhDWls5k=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=n7v3Wmotyn1PscsFQ+BsFlOVBP1+CCOwRA/fyuZiiNQCSM7CGdr4ATxO42ViLEMdhXQBqm1U
 LKkiFhRWw/8EYIcvQh7pyoo3M93ofTJdfFY8gUtzgZjJPmcZrWZyDQGXE+onpB+KKdaHftbP0b
 9LxhzjZdH1Gku5q9ndH+RA4ExsbSG5OnL8F6bhgUkLIBDICnVVZxZNYfW1uYPDJGzzbtfHfyEv
 qhvxLHMi0/pdyZQxA9fOrSOmkhliYvwEniT45ZoTB6AD/10MGsWxYagf/0gMsv0EdtZEPqj4gA
 i69xignXzR/Q+f1ZHpm16sFYIu7yHiO2WpPUg7h6GgPAc3nA==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 3 Apr 2025 10:01:07 -0700 (PDT)
Jeremy Drake wrote:
> On Thu, 3 Apr 2025, Johannes Schindelin wrote:
> 
> > I still have a question that I would like to be answered in the commit
> > message, too:
> >
> > If `signal_arrived` is only initialized in `fixup_after_fork()` but user
> > callbacks that use this are called by `atforkchild()`, why did this not
> > trigger _all the time_ before your reordering of the calls?
> 
> Based on my recollections, Takashi probably knows better
> 
> 1) there has to be a pthread_atfork child callback registered
> 2) this callback has to call raw_write
> 3) raw_write now calls cygwait (which is now reenterancy-safe due to other
> fallout from this)
> 4) cygwait allows signals to be processed, so needs the signal-handling
> stuff to be properly initialized.
> 
> I'm guessing, if raw_write doesn't need to wait (ie, there's room in the
> pipe for the write) it doesn't hit the signal stuff.

Thanks for the explanation. Actually, cygwait() waits for a mutex at the
beginning of raw_write(). This is introduced by the commit 7ed9adb356df,
so the bug does not affect before that commit.

> But I get your request for explaining the scenario in the commit message.

I'll add the descriptions requested by Johannes before push. Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
