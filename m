Return-Path: <SRS0=u+jC=RY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 625BB3858D20
	for <cygwin-patches@cygwin.com>; Mon, 28 Oct 2024 11:25:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 625BB3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 625BB3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730114722; cv=none;
	b=xLcG15Z2xGm1awMtFIXLtnu2ckXkk3rywfX1jcuY4k5as99QVVHAfWtZB94hAF95uKMWe3GKUfhL392qTyMw47RywuuHcoFlyZMV8OODVzSlXvANCeHzWjShNpInZws8wBk9UX7ryE3kIdUu+ng2aM+jocPelPEseMa466v08Pc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730114722; c=relaxed/simple;
	bh=GDfKbXQh2Vn/FtJ1jdXB1w+717rU4K/GbBGTGS3pSNA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=jxPqqOIwdmwgNuFOUVwvuow9k0/vsvGITgIrIRpOmCQ9iw6vaNrEr9emj/NLr9oRm5D58BCECgz/3uXHyAo+8mQF9O9CSFGBeH/Bwiqc8PYkqf15M082TJf/vJ5OAiaU7kTumyh61t9slbPZ67LCB44akL5OwVhLoDD5bumZQA4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20241028112517681.FIHA.9629.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Oct 2024 20:25:17 +0900
Date: Mon, 28 Oct 2024 20:25:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20241028202516.0dd4c86cb2efa9f7db8c856d@nifty.ne.jp>
In-Reply-To: <20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
	<Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
	<20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
	<ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
	<20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
	<Zx9fk6yQ1etCVwek@calimero.vinschen.de>
	<20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730114717;
 bh=OlMa1wDNc4ZgUpctNVRftR6LUm95VRWdyOqoXrn6/v8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=t7mV8vuoLPEpkWCzvVdvfhF2XwcJuvHR8/dvtD85hsVkVeo/1nyllTmAqJqruWIoT0tUvbOj
 CuufNzNNByWL5rIsL2CmW8KJjVB9l/TeKj4O3DspsOpHuTFGhSpas8FgA5X6q4BeVDPNnfvjac
 dXyPuZl/2yiLaGgPXTSsnQ5feyO+NBNagWse6jTnyrzD6VtBzK1/8PxCr8jd7ZajZQXdzwktK4
 OO+VzXGbfbSqFvTs58+DLo+7IGAnj5WBdrqL9bVr9lbJdSgS3vVS0SrXpVzmyyfiXrkb7219Kk
 tMwJHrn0IJSWYzL+GlG6MUfbeoV2mYzdl4iRosRtf+2MoA2Q==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 28 Oct 2024 20:23:01 +0900
Takashi Yano wrote:
> Hi Corinna,
> 
> On Mon, 28 Oct 2024 10:55:31 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Oct 27 17:57, Takashi Yano wrote:
> > > Hi Corinna,
> > > 
> > > On Thu, 24 Oct 2024 12:21:04 +0200
> > > Corinna Vinschen wrote:
> > > > > > Before:
> > > > > > 
> > > > > >   $ ./x 40000
> > > > > >   pipe capacity: 65536
> > > > > >   write: writable 1, 40000 25536
> > > > > >   write: writable 1, 24576 960
> > > > > >   write: writable 0, 512 448
> > > > > >   write: writable 0, 256 192
> > > > > >   write: writable 0, 128 64
> > > > > >   write: writable 0, 64 0
> > > > > >   write: writable 0, -1 / Resource temporarily unavailable
> > > > > > 
> > > > > > After:
> > > > > > 
> > > > > >   $ ./x 40000
> > > > > >   pipe capacity: 65536
> > > > > >   write: writable 1, 40000 25536
> > > > > >   write: writable 1, 25536 0
> > > > > >   write: writable 0, -1 / Resource temporarily unavailable
> > > > > > 
> > > > > > This way, we get into the EAGAIN case much faster again, which was
> > > > > > one reason for 170e6badb621.
> > > > > > 
> > > > > > Does this make more sense, and if so, why?  If this is really the
> > > > > > way to go, the comment starting at line 634 (after applying your patch)
> > > > > > will have to be changed as well.
> > > > > 
> > > > > Perhaps, I did not understand intent of 170e6badb621. Could you please
> > > > > provide the test program (./x)? I will check my code.
> > > > 
> > > > I attached it.  If you call it with just the number of bytes per write,
> > > > e.g. `./x 12345', the writes are blocking.  If you add another parameter,
> > > > e.g. `./x 12345 1', the writes are nonblocking.
> > > 
> > > Thanks for the test case.
> > > I think I could restore the previous behaviour. Please try v9 patch.
> > > 
> > > CYGWIN_NT-10.0-19045 HP-Z230 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin
> > > $ ./a.exe 40000 1
> > > pipe capacity: 65536
> > > write: writable 1, 40000 25536
> > > write: writable 1, 24576 960
> > > write: writable 0, -1 / Resource temporarily unavailable
> > > 
> > > Just after the commit 170e6badb621 (master branch)
> > 
> > Oops.  You tested in the wrong spot.  The original patch wasn't quite
> > polished, the followup patches 1ed909e047a2 and 686e46ce7148 are also
> > required to show the intended behaviour, and the intended behaviour is
> > the same in the blocking and non-blocking case...
> > 
> > > $ ./a.exe 40000 1
> > > pipe capacity: 65536
> > > write: writable 1, 40000 25536
> > > write: writable 1, 24576 960
> > > write: writable 0, -1 / Resource temporarily unavailable
> > 
> > So this should actually be:
> > 
> >   pipe capacity: 65536
> >   write: writable 1, 40000 25536
> >   write: writable 1, 24576 960
> >   write: writable 0, 512 448
> >   write: writable 0, 256 192
> >   write: writable 0, 128 64
> >   write: writable 0, 64 0
> >   write: writable 0, -1 / Resource temporarily unavailable
> > 
> > just as in the blocking case.
> 
> I have just tried commit 686e46ce714803f47d3183c954ceaf51976157cc,
> however the result is the same:
> CYGWIN_NT-10.0-19045 HP-Z230 3.6.0-dev-182-g686e46ce7148.x86_64 2024-10-28 11:17 UTC x86_64 Cygwin
> $ ./a.exe 40000 1
> pipe capacity: 65536
> write: writable 1, 40000 25536
> write: writable 1, 24576 960
> write: writable 0, -1 / Resource temporarily unavailable
> 
> What is wrong???

Is the test case I used different from yours? Without the 2nd arg,
$ ./a.exe 40000
pipe capacity: 65536
write: writable 1, 40000 25536
write: writable 1, SIGALRM 24576 960
write: writable 0, SIGALRM -1 / Interrupted system call

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
