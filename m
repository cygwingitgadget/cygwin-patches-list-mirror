Return-Path: <SRS0=jwxA=UN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 06C433858D28
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 22:51:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06C433858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06C433858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737499865; cv=none;
	b=C4bxH0j9+ngqLVeeDYKROVc01B8lSAwLzozqW3d4RodlWcRr3qRZI6jyHJ/LMZx4NqW1Cj9bhQ5XOQOdX0mSxDCwhznuF53VfqxG6djBFZF/Duiky/y2x0zK0snbmllBe6zSZajlT1iQB9xlWlYLsQSmZ7uOSHH96YO77qtRQA4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737499865; c=relaxed/simple;
	bh=hTARLViYIGKhLkC+nEZYtumq3bHpDfI5N1lCU6X6NPw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=BfG4GRh2JUj3Cz3F+PKVza0RNH7+6X852Bj3Ty6pMoL0WwDjmJBeqRkUs6QwwOT+VIqbguXRTTjkGnwkosM7gx0t1hhmaE3TkzepdSXRd/nEfFfFEJNkwuJZ32jbX6CETmNR41lED0GRzDX5Lg0ZSZhtrMJDLcUciQVktlwqxbk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06C433858D28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=drc3Lynz
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20250121225102280.XZUC.87244.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 07:51:02 +0900
Date: Wed, 22 Jan 2025 07:51:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 2/3] Cygwin: cygwait: Make cygwait() reentrant
Message-Id: <20250122075100.46872d41dea5449faffff4af@nifty.ne.jp>
In-Reply-To: <5bef2563-e9d3-2ebd-60d8-60a8f4dcef71@jdrake.com>
References: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
	<20250121031544.1716992-3-takashi.yano@nifty.ne.jp>
	<5bef2563-e9d3-2ebd-60d8-60a8f4dcef71@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737499862;
 bh=X3N3mn3HUQFJJfgI2xnFi8Z6RvBn9keZwvj9N/qNY34=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=drc3Lynz5boKAeXJmQ3wvQ0i4P8BB5/ym9ai9K+L4CDOJrQ0dXbQeOblqbtVKeOqXuXsFOP+
 HBfE4U4GUTN9DQE2u3ubRfrDjXJJP9CPa/2Zt3hKCzHiuENqaDATqmRY18n93brE82v0i+eR+O
 YdUFb6Bq7ysHjdPtRNRES46tDjTz6YRopcINGhXV+DpG73TriUoNtpVNrtJehQ0qn5TuBij3qq
 HIR2GdPafNGh6FmzYugGq/uq1FFAxmZyn7myrO+qgZFki3ODiAehSDshsPlgGRqaiPUFvGl8iR
 EV6f6tWcm8cctseepDqNwexMGjCgOs9hHP2r9tWL0ecvzYtg==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 21 Jan 2025 10:00:23 -0800 (PST)
Jeremy Drake wrote:
> Not important, but
> 
> On Tue, 21 Jan 2025, Takashi Yano wrote:
> 
> > +      if (!_my_tls.locals.cw_timer_inuse)
> > +	_my_tls.locals.cw_timer_inuse = true;
> 
> Couldn't you leave the if out?

That's right, I'm aware of that, but I prioritized making the
intent of the code clearer. I mean, the intent is that "use
_my_tls.locals.cw_timer only if it is not in use".

Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
