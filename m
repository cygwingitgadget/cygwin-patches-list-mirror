Return-Path: <SRS0=co2e=QA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id 75529385DDE9
	for <cygwin-patches@cygwin.com>; Mon,  2 Sep 2024 13:50:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 75529385DDE9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 75529385DDE9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725285050; cv=none;
	b=R7laHPDCPBvOOw4KgwS7CjmLv4ArD4doVIrwcrx4LmdB015DY7+LaZ6gc1e/wOXkwe9gHTglse6jV39Y9JvGXBgFzlXGhiC0WH/vNOfJ3TOyWWq75LcEpoCJ0khBC5WN4FqNcKeKkhfveUPlVzAII0/KL1i8LeIAgcqh3w6TZHA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725285050; c=relaxed/simple;
	bh=TeCvmdE+BBmZF1UIKXPWNTEklQjOLZ6WN2e7Ufkxv7A=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=QvOJEhcnT7cq8hcZM+dMbQ0qhMzc0UmAZ3GdVmjXGDINDwfG/uHe3/lot8cRPXTGOLAoW1ThOcFfok5kNdbAh4t+y1++CgCdCDulaCCu/LAUeGySpWGxlnCFQqe11xWzhnZEa29WNUp8618QsOufM3BYPL5/WY7NhmZjSIpzXQc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20240902135046452.XLRE.94949.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 2 Sep 2024 22:50:46 +0900
Date: Mon, 2 Sep 2024 22:50:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
In-Reply-To: <a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
	<ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
	<a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725285046;
 bh=7JK9QWAJ7+r8+lSRHp/i3+v2LG3rTmJBRKIxn1SguPM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=rBjtKrHT7lg+K75VDjLJ/vMWU7ohPdmvMCtfQ32mQsA11RsJDIwNXInQbsNevbOkMMBMNX3c
 VX9xvLRXWyoTAEF55X9Uhuatqt8F4RgUiVeXNCXcNXXMOA2ESBUP+sReBMXfCY2jxJic0BNyLY
 IrfPG+xTpN7zq7g69cBnngEbX0B6NUpCYiShxA+pIdtiQ/XTz4utcDeSgBDYm1g9W4n8zx36cy
 wNZrIVAHNS1+9XwIUn0mZulZ8Th3qYV43MQig4licrS2OJw8S537zJtnzUKPmH/+6ygARDweOc
 J2qrJQLuCAnsHOPfHDHk64iOf6YWmG62yoIFweNTUQgRbELg==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_BL_SPAMCOP_NET,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Sep 2024 14:48:35 +0200 (CEST)
Johannes Schindelin wrote:
> I have tested it and the symptom is addressed.

Thanks for testing.

> I do have to wonder whether it is intentional that calling
> `set_pipe_non_blocking(false)` followed by `set_pipe_non_blocking(true)`
> on an originally-non-blocking pipe will "restore" it to blocking mode,
> though.

I'm not sure how such symptom occurs.

Calling `set_pipe_non_blocking(true)` on an originally-non-blocking pipe
will set `was_blocking_read_pipe` to false.

Furthermore, regardless of the value of `was_blocking_read_pipe`, calling
set_pipe_non_blocking(false) always sets the pipe blocking mode. It is not
due to "restore" logic.

> In other words, where I would have expected undesired logic to be removed,
> or at least to be adjusted, the patch instead adds code on top, adding
> even more logic.
> 
> > I just wonder if the whole code could be simplified, if we set
> > the pipe to non-blocking only temporarily while reading or writing,
> > while the pipe is blocking all the time otherwise:
> >
> > - Create pipe blocking
> >
> > - set_pipe_non_blocking(true);
> >   NtReadFile() or NtWriteFile();
> >   set_pipe_non_blocking(false)
> >
> > How costly is it to call NtSetInformationFile(FilePipeInformation)
> > for each read/write?
> 
> That would potentially be a remedy, but I would worry that this design
> takes a decidedly single-thread world-view. While that may be appropriate
> in the context of the scenario described in the bug report, it may very
> well be inappropriate for Cygwin in general.

In the first place, it is obvious that multiple threads writing and
reading from the same pipe at the same time causes undefined behavior,
regardless of whether the pipe mode is toggled or not, isn't it?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
