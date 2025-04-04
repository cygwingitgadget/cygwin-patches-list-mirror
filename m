Return-Path: <SRS0=Ctoq=WW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 01998384978D
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 13:53:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 01998384978D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 01998384978D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743774821; cv=none;
	b=nIem0+ejyM27zvrIEAop6BFt8p2CjFKxypgS1/PI8OKxLgZ3do4E21rahINbCESslzVorp/hXnqS1c5vVcJpwYXQ04ZvQ+CXdfBq9UZSk2uc3LVZU0L6/l1piO19190tJFy2hWmUdyUhNdlmpj5HP6oS+ZluiWOlVFfLjypWsck=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743774821; c=relaxed/simple;
	bh=ixT4QbhX0nh8sYxjR/swElccy52Q+2EgKrDPxLw91JQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=XbtRnETLN2dO5diTW4q4GmkZJ7ouZjZnHAq+5BCukcm1umCnaedzhSYh5XxVI2PEVFN75Qe0lfDNLQXtgbfBHuwHk4A0/s6Ci1VQHP+klowdgw1gPKwWdWkQKIYoTx6a4XR0XRq50z5uhpTtfi7vGSl2v5p9BmTNjKNSXGYd3hM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 01998384978D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AL8H8eD4
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20250404135338816.LQCX.78984.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 4 Apr 2025 22:53:38 +0900
Date: Fri, 4 Apr 2025 22:53:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
Message-Id: <20250404225337.08412ac9089cc9a066cae4da@nifty.ne.jp>
In-Reply-To: <57624128-5aa1-b47f-a192-2b342eb2072b@gmx.de>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp>
	<969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de>
	<ec45497d-a248-1056-4993-da137267b7c5@jdrake.com>
	<20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp>
	<C262E1A5-1B14-4D38-AE47-2EC7709DB6D1@gmx.de>
	<20250404210609.b0d38a4cac7e195ad20a9ced@nifty.ne.jp>
	<57624128-5aa1-b47f-a192-2b342eb2072b@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743774818;
 bh=z6yG0drth0AjK2cyyKzSa7jO7z3XdOeXwbrcA0+Xt1c=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=AL8H8eD4ZHtJVEwZ25a3oR6yD8s3TkCR8FaV6nFdJZbUVwXt+JEv96zOsk19P2Jin4W9wSgo
 At+5ILCzJvYJacOntRK1ii4gUrefeUFicV/1Xna29M3A+OBofYBZKNDxwtZugIeYhmPJrCtdNK
 s7NCspjkAA4mvHMG8RIQkBWkJBq8D8My5VbykGii6bGGmf8Zl7vMMOTG761mR5qPCLVp9xUuJv
 k/nuUCmsxc0C5H2oDCm/y5iN2jW4y2jMOTpBFIM793As76uLnMFJ9W3d+rvQvzUmJ63nqeHhHp
 FMHlux/d3SCMDOrkkQAh3qgulrrvv8Nii+8Sm1q80fWgZcBw==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 4 Apr 2025 14:13:57 +0200 (CEST)
Johannes Schindelin wrote:
> On Fri, 4 Apr 2025, Takashi Yano wrote:
> > On Fri, 04 Apr 2025 07:27:09 +0200 Johannes Schindelin wrote:
> >
> > > Is Jeremy's guess "if raw_write doesn't need to wait (ie, there's room
> > > in the pipe for the write) it doesn't hit the signal stuff" correct?
> > > If so, it would be good to add that part to the commit message because
> > > the commit would otherwise still be incomplete.
> >
> > That's not correct. Indeed, raw_write() waits for room in the pipe,
> > however, it does not matter in this case. The probelm occurs at
> > cygwait() which waits for pipe mutex as already mentioned in the commit
> > message.
> 
> So what is the explanation, then, that this hung only occasionally and not
> all the time?

As far as I investigated, the event handle signal_arrived was never
initialized all the time. Therefore, the its value is just copied
from the parent. The event signal_arrived is not inheritable, so, 
the handle value is basically not a valid one.

However, the handle value of win32 is a small value such as 0x1ac,
it can easily be the same value with other existing handle.
I observed two cases, one was the value of signal_arrived was a
valid handle value but was not the event handle, the other was the
value was a valid event handle (but not initialize as signal_arrived).

I'm not quite sure why, but most of the cases were one of the above.
Then sometimes its value is really invalid.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
