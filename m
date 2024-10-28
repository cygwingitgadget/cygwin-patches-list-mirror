Return-Path: <SRS0=u+jC=RY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id AF0A03858D20
	for <cygwin-patches@cygwin.com>; Mon, 28 Oct 2024 11:23:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AF0A03858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AF0A03858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730114588; cv=none;
	b=tGpnjI19uSK3oGHGH0XEyz005p5CaRsh1cITq2a9K6t+XpU2CF/WeqnQE8sTkliIoddhMPdweJk5plnQTmqv3GrmcaaCs4+xLjIelfh/fsXr6ubn5O5yM93IkFuBxa0SBqchKwDpFtLwDltQeMFCOYLeklTTMkJnzwvZrhLF9VM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730114588; c=relaxed/simple;
	bh=3q+HjWqvvy4xW6eq6epSMizT6dd0wMG0MhhiphQ1B64=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Rd3lKUbUjUulKa2oeG3GoCuWOFyr2iBdmgc6P3dFo79tgShHp++9HPabuzc4Zk02SM3ZEF/V1ZhQAmqsJ+wrG3Tw6ELaVxuwNm0Z+xARd+ofK/S1bqI6soCMHhrRFK2al6P/5tTS9VKh26klVRcNNqMZ8tIdw0t+tyPuKMZ7BTo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20241028112302528.FAAR.118346.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Oct 2024 20:23:02 +0900
Date: Mon, 28 Oct 2024 20:23:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730114582;
 bh=PE2dYP/R2Pz0/R4OURHYAtpOjUSKMtGh+Ekh37L9zvw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=M8PgIS2MemYXWuZDXzIYiars/Ii/24bqG2dtbOriFWpIwsyj3CjCnjUaE0T5DMUMAxQ8HwSS
 24dmTj5BkkdTXLWjS2nuTIZDzDKdEPTbSlsJFBjE/5bAV4ta3qIvY9I19gLk7AZtxd9Z9Sfh8+
 yGjrLKX2BMLtbJFkU7nWX5xKiqHSd6rrWeTe1cTCKknfD4NRYq3qb1fWztARQKjJ8LbKnjD4Ve
 bFuh9drSuKR/RAJKjKwJK1b3ZGNn5WBB3aIVfszInz8PdTKjFtqKZV9Z9p79vwr35J/wLhmaTf
 T46KQ2oBN43GMQuDA000JmdOOx6/Cx0FewD/Nh3a0mgF3jyA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

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

I have just tried commit 686e46ce714803f47d3183c954ceaf51976157cc,
however the result is the same:
CYGWIN_NT-10.0-19045 HP-Z230 3.6.0-dev-182-g686e46ce7148.x86_64 2024-10-28 11:17 UTC x86_64 Cygwin
$ ./a.exe 40000 1
pipe capacity: 65536
write: writable 1, 40000 25536
write: writable 1, 24576 960
write: writable 0, -1 / Resource temporarily unavailable

What is wrong???

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
