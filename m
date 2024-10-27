Return-Path: <SRS0=KPxw=RX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.114])
	by sourceware.org (Postfix) with ESMTPS id C37F13858429
	for <cygwin-patches@cygwin.com>; Sun, 27 Oct 2024 08:57:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C37F13858429
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C37F13858429
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.114
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730019447; cv=none;
	b=sAGExN99SsOdQC5cTMTfoHpCAIvfWhaSxxWfzyiTyBn0iwQxYFXZWBha3HikGUTxDieix8lQmP7etFLOOe/Xw/Kfe7wzymedQyFcNqE7tTpkONC60yqJ1gt670W+ExkkcnLessFSKUHsSP81FNmqlIKvuQH+ACkNHidI7POgN+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730019447; c=relaxed/simple;
	bh=9nfR5HM7tcOMSKnyO/NyuyZCLCcgxQnMkIHUXjvKHXY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=beprqr54itp7Nm1r8Jo/v6NrIE/BwHmIyY74OkiO7f2gSSqaU5uGdo13jGCbcSifnLqhil+ER7bJvwzBVWlZuXUuO+AQSbW4nEbeC8+CV+Z4/mSAp0TIMbAdVkSxmKKTNOkxW6I2cvvYV/mSn6DuJVCnPv8G6X3tyuZOhe9arQk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20241027085723048.ZRLB.44461.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Oct 2024 17:57:23 +0900
Date: Sun, 27 Oct 2024 17:57:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
In-Reply-To: <ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
	<Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
	<20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
	<ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730019443;
 bh=wzndV2y+yYi6QFBcX4sfh4ipbn2LlEI3ReTHjUDrlWw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=EFAmrSCXw9ZX8T8CXIsgK0qB997QuY1gkdOZM+594X9aQ04subShiwSYvdEFkP9ThR5YpQKr
 Y9ZU87A/4Sz2MZprUINnXgZUsaTewRh4zWs0ADBhvWmuqQmZqYoenHG0ZsHN2AWqdVgKYWn8Ad
 Mrd6Ew95NbdDG/X7HCo34K9ntIFD/AJt/FRzSX/ZGZt49bug71oLiRdOYTxXp7/CTlkt2b6HDX
 Nq0Y3ayZrBwjexCHsmOPtQmHEJCzEzC7hVXOXyhRpnoO/wj55ct77rRpzqUOGjR8uyAygWvivB
 vr1XdxAN6xNwn/r3Yute5pqXPiIgWU3h4Lwl1lm5ODWbVXpA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Thu, 24 Oct 2024 12:21:04 +0200
Corinna Vinschen wrote:
> > > Before:
> > > 
> > >   $ ./x 40000
> > >   pipe capacity: 65536
> > >   write: writable 1, 40000 25536
> > >   write: writable 1, 24576 960
> > >   write: writable 0, 512 448
> > >   write: writable 0, 256 192
> > >   write: writable 0, 128 64
> > >   write: writable 0, 64 0
> > >   write: writable 0, -1 / Resource temporarily unavailable
> > > 
> > > After:
> > > 
> > >   $ ./x 40000
> > >   pipe capacity: 65536
> > >   write: writable 1, 40000 25536
> > >   write: writable 1, 25536 0
> > >   write: writable 0, -1 / Resource temporarily unavailable
> > > 
> > > This way, we get into the EAGAIN case much faster again, which was
> > > one reason for 170e6badb621.
> > > 
> > > Does this make more sense, and if so, why?  If this is really the
> > > way to go, the comment starting at line 634 (after applying your patch)
> > > will have to be changed as well.
> > 
> > Perhaps, I did not understand intent of 170e6badb621. Could you please
> > provide the test program (./x)? I will check my code.
> 
> I attached it.  If you call it with just the number of bytes per write,
> e.g. `./x 12345', the writes are blocking.  If you add another parameter,
> e.g. `./x 12345 1', the writes are nonblocking.

Thanks for the test case.
I think I could restore the previous behaviour. Please try v9 patch.

CYGWIN_NT-10.0-19045 HP-Z230 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin
$ ./a.exe 40000 1
pipe capacity: 65536
write: writable 1, 40000 25536
write: writable 1, 24576 960
write: writable 0, -1 / Resource temporarily unavailable

Just after the commit 170e6badb621 (master branch)
$ ./a.exe 40000 1
pipe capacity: 65536
write: writable 1, 40000 25536
write: writable 1, 24576 960
write: writable 0, -1 / Resource temporarily unavailable

With v8 patch:
$ ./a.exe 40000 1
pipe capacity: 65536
write: writable 1, 40000 25536
write: writable 1, 25536 0
write: writable 0, -1 / Resource temporarily unavailable

With v9 patch:
$ ./a.exe 40000 1
pipe capacity: 65536
write: writable 1, 40000 25536
write: writable 1, 24576 960
write: writable 0, -1 / Resource temporarily unavailable

However, I am not sure if this is the right thing.
In Linux (debian), I got the same result as above:
Linux debian2 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1 (2024-09-30) x86_64 GNU/Linux
$ ./a.out 40000 1
pipe capacity: 65536
write: writable 1, 40000 25536
write: writable 1, 24576 960
write: writable 0, -1 / Resource temporarily unavailable

But, even with v9 patch, the behaviour is not same as linux for another
case.

Please try:
$ ./a.out `expr 65536 - 4096 + 543` 1
pipe capacity: 65536
write: writable 1, 61983 3553
write: writable 0, 543 3010
write: writable 0, 543 2467
write: writable 0, 543 1924
write: writable 0, 543 1381
write: writable 0, 543 838
write: writable 0, 543 295
write: writable 0, -1 / Resource temporarily unavailable

$ ./a.out `expr 65536 - 4096 + 1234` 1
pipe capacity: 65536
write: writable 1, 62674 2862
write: writable 0, 1234 1628
write: writable 0, 1234 394
write: writable 0, -1 / Resource temporarily unavailable

Is this realy an intentional behaviour? If so, I could not understand
for what the behaviour is...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
