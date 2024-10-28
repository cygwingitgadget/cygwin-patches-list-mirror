Return-Path: <SRS0=u+jC=RY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 200E13858D20
	for <cygwin-patches@cygwin.com>; Mon, 28 Oct 2024 11:30:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 200E13858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 200E13858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730115024; cv=none;
	b=KpQJXmKPE8Nf524/J9R21M1SxMlOzq0MrU6/AN/8+qU7YNXlyNTnzdEEL31x6ZxoFzj4uvBkN+i+B7SgnImgC3TAKf9NHJOdP9HePTMeHEDnbGL836dhE7YW2PDT/6ipphVYXxnyU8FHVWuYtwQS1uLsEPHABgWpyxsWTJXAvus=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730115024; c=relaxed/simple;
	bh=o1Oc9ZLY7Zu4NB8Ri2qJema0BS8D3d0+X0jef6pHsh8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=rTaSa9QrzXSJy4QIEjLB9HpV7+j6vHxuDFU6f7aPgze59hytCSkQezrug12GSFG0C8G8eZPKBDJkifveoWCX0GRy+85xYvB2R+PqDQd1qSGx22nRgexNEJ1R+J4CZ7wYcN1/hzcMIVhZ5tK3vq7N1YCym4dCUMdlRDlxtDOw6Mw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20241028113020498.JCBI.84424.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Oct 2024 20:30:20 +0900
Date: Mon, 28 Oct 2024 20:30:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20241028203019.4158316e34926d1afc6fa3cf@nifty.ne.jp>
In-Reply-To: <Zx9fk6yQ1etCVwek@calimero.vinschen.de>
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
	<Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
	<20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
	<ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
	<20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
	<Zx9fk6yQ1etCVwek@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730115020;
 bh=jdeCOsppOqM650DkdLuMx+7RuMve0ctcXSniQ8PUQRE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=NBmXRrv9yBPrG5K8GW1m8cN2b7QwrNOZLWBNRnKoi+Ufoh+UlwkVb4pIdRbEE+MTxwBFuHMF
 lGj7gppZh5KzRXm2vncHP/jRiOI7cs7j/2wMdatgzMaNCN9swtFPbNY84Hy9fdwAD4Azzw+Apb
 eN7Ymoidkf86oJ7F+NERGgPvIW56CtP6YUXFPdEc4fxJMtoPqC50eViGkruKP84t8AhfZwusc7
 bYTpIQAIGgq2XUlYy3AidAIPvadWln4Y7tdBDGk0DDQOp65VW2xMYscyVT+vjBYPA+dFWhroKf
 bHUXQFMB/6SAQaEDfQw7uB5O+SHvE0y5XF3IJBBKBVeVW0yQ==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 28 Oct 2024 10:55:31 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Oct 27 17:57, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Thu, 24 Oct 2024 12:21:04 +0200
> > Corinna Vinschen wrote:
> > > > > Before:
> > > > > 
> > > > >   $ ./x 40000
> > > > >   pipe capacity: 65536
> > > > >   write: writable 1, 40000 25536
> > > > >   write: writable 1, 24576 960
> > > > >   write: writable 0, 512 448
> > > > >   write: writable 0, 256 192
> > > > >   write: writable 0, 128 64
> > > > >   write: writable 0, 64 0
> > > > >   write: writable 0, -1 / Resource temporarily unavailable
> > > > > 
> > > > > After:
> > > > > 
> > > > >   $ ./x 40000
> > > > >   pipe capacity: 65536
> > > > >   write: writable 1, 40000 25536
> > > > >   write: writable 1, 25536 0
> > > > >   write: writable 0, -1 / Resource temporarily unavailable
> > > > > 
> > > > > This way, we get into the EAGAIN case much faster again, which was
> > > > > one reason for 170e6badb621.
> > > > > 
> > > > > Does this make more sense, and if so, why?  If this is really the
> > > > > way to go, the comment starting at line 634 (after applying your patch)
> > > > > will have to be changed as well.
> > > > 
> > > > Perhaps, I did not understand intent of 170e6badb621. Could you please
> > > > provide the test program (./x)? I will check my code.
> > > 
> > > I attached it.  If you call it with just the number of bytes per write,
> > > e.g. `./x 12345', the writes are blocking.  If you add another parameter,
> > > e.g. `./x 12345 1', the writes are nonblocking.
> > 
> > Thanks for the test case.
> > I think I could restore the previous behaviour. Please try v9 patch.
> > 
> > CYGWIN_NT-10.0-19045 HP-Z230 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin
> > $ ./a.exe 40000 1
> > pipe capacity: 65536
> > write: writable 1, 40000 25536
> > write: writable 1, 24576 960
> > write: writable 0, -1 / Resource temporarily unavailable
> > 
> > Just after the commit 170e6badb621 (master branch)
> 
> Oops.  You tested in the wrong spot.  The original patch wasn't quite
> polished, the followup patches 1ed909e047a2 and 686e46ce7148 are also
> required to show the intended behaviour, and the intended behaviour is
> the same in the blocking and non-blocking case...
> 
> > $ ./a.exe 40000 1
> > pipe capacity: 65536
> > write: writable 1, 40000 25536
> > write: writable 1, 24576 960
> > write: writable 0, -1 / Resource temporarily unavailable
> 
> So this should actually be:
> 
>   pipe capacity: 65536
>   write: writable 1, 40000 25536
>   write: writable 1, 24576 960
>   write: writable 0, 512 448
>   write: writable 0, 256 192
>   write: writable 0, 128 64
>   write: writable 0, 64 0
>   write: writable 0, -1 / Resource temporarily unavailable
> 
> just as in the blocking case.
> 
> The ideal commit for testing the intendend behaviour is f78009cb1ccf,
> because that's your regression fix slowing down writes.
> 
> As I wrote in the commit message of 170e6badb621, the idea is to defer
> EAGAIN/EINTR when the write buffer starts to be filled up. 
> 
> The code I came up with does NOT resemble Linux closely, because the way
> Linux pipe buffers work is by some simple but fast paging mechanism,
> which may even lead to pipes being smaller than PIPE_BUF.  Nevertheless,
> except in some border cases, Linux often still returns some non-0 value
> when our former code already returned EAGAIN/EINTR.
> 
> While this was mainly a problem in the blocking case, I thought the
> buffer usage computation should be identical between blocking and
> non-blocking, just as on Linux.
> 
> > Please try:
> > $ ./a.out `expr 65536 - 4096 + 543` 1
> > pipe capacity: 65536
> > write: writable 1, 61983 3553
> > write: writable 0, 543 3010
> > write: writable 0, 543 2467
> > write: writable 0, 543 1924
> > write: writable 0, 543 1381
> > write: writable 0, 543 838
> > write: writable 0, 543 295
> > write: writable 0, -1 / Resource temporarily unavailable

The above case was result in Linux environment.

> > $ ./a.out `expr 65536 - 4096 + 1234` 1
> > pipe capacity: 65536
> > write: writable 1, 62674 2862
> > write: writable 0, 1234 1628
> > write: writable 0, 1234 394
> > write: writable 0, -1 / Resource temporarily unavailable

This also is the result in Linux environment.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
