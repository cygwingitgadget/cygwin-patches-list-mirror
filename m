Return-Path: <SRS0=1xMm=ZJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 54103385703B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 04:54:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 54103385703B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 54103385703B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750913685; cv=none;
	b=TgvW9gKppbDRyBVZaKf8uY1tN3EtC+cHMpuKl6KqzoA3osOQ6PLRFRkFyxtQ/2gfDGN4o5YsE3QDVueNiB/FePthK5FSTBdRCtyUyT9SpQXTO1R7MGSvSU0I4AAzufZIOKY7r0EzOTNzls62gqV11xzIIvC4Im1Hp9FYusuH1aU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750913685; c=relaxed/simple;
	bh=O9P0b3QRhTCktB9fGe8vGQj+U7zlXFvo64Y042F8Q2s=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=u0Hd1pxs49C8bRd3Xm0e5de5OxypTYUVv9JmNIjFqkBK27OUqGkPg9MK3HJ0IPfWP/PCrj7k1LeYKa91DJFavj2Vxhgf/ytFeKNCJalNQe6yQAqOuYY59JXy75osbLBhypjU/+MR56+qMtFOVJS1s9H+tW09zUoyLUJK3sY6G4s=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 54103385703B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ccygbAZf
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20250626045442532.VSRS.38814.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 13:54:42 +0900
Date: Thu, 26 Jun 2025 13:54:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250626135440.e030b756a7168ce4844f2683@nifty.ne.jp>
In-Reply-To: <35fb9069-817b-7416-d810-be0187fc96a8@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
	<20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
	<701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
	<4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
	<20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
	<20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
	<a379f48a-e0db-7769-2968-9c4df5293a0d@gmx.de>
	<20250625212658.2f607120a5e7fd709cf8022e@nifty.ne.jp>
	<35fb9069-817b-7416-d810-be0187fc96a8@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750913682;
 bh=V04NNVKPm8tkN8E480QC6bO7lSskMAjG1JnBUpxfrgM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ccygbAZfPFCZCf0cqjpa42HKOloPc1GzIsPWRng4qCSKSVsIsIvnfQOGYrqGzIxnqKvzb/KN
 k8d7QmUM5eJYAfSeDcrSGeTbtvLV8Xn2r1O5Wtoi/i6Bv3nLJ6qzrQuAot0IettNEpLsnQEK9o
 lWV++Da4weQrao1h5qIWayyXScesSZx75znaWGuPi0Meri2Mat9+UGv0ra8lRH3OT/lLPxJevH
 mou8oF0dA0mL27TX1huOdK/6koVnvEZwHkWOhb6PWHx6+2PZ6oYptoumfEDOPtxWu499LPjXeH
 I1mYzg/IJ645eNRmFSMqYVE/0IrpQ4I9eMt6+ppH6MghrWVQ==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Jun 2025 17:56:35 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 25 Jun 2025, Takashi Yano wrote:
> 
> > On Wed, 25 Jun 2025 14:07:15 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > Hi Takashi,
> > > 
> > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > 
> > > > On Wed, 25 Jun 2025 19:55:34 +0900
> > > > Takashi Yano wrote:
> > > > > 
> > > > > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > > > > Johannes Schindelin wrote:
> > > > > > 
> > > > > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > > > > > 
> > > > > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > > > > > 
> > > > > > > > I'd revise the patch as follows. Could you please test if the
> > > > > > > > following patch also solves the issue?
> > > > > > > 
> > > > > > > Will do.
> > > > > > 
> > > > > > For the record, in my tests, this fixed the hangs, too.
> > > > > 
> > > > > Thanks for testing.
> > > > > However, I noticed that this patch changes the behavior Corinna was
> > > > > concerned about.
> > > > 
> > > > The behaviour change can be checked using attached test case.
> > > 
> > > I do not understand what this undocumented code is trying to demonstrate,
> > > not without any explanation.
> > > 
> > > Could you rework it so that it becomes a proper test in the test suite
> > > that verifies that Cygwin behaves as desired, please?
> > 
> > What the comment in the source code says:
> > 
> >       /* NtWriteFile returns success with # of bytes written == 0 if writing
> >          on a non-blocking pipe fails because the pipe buffer doesn't have
> >      sufficient space.
> > 
> >      POSIX requires
> >      - A write request for {PIPE_BUF} or fewer bytes shall have the
> >        following effect: if there is sufficient space available in the
> >        pipe, write() shall transfer all the data and return the number
> >        of bytes requested. Otherwise, write() shall transfer no data and
> >        return -1 with errno set to [EAGAIN].
> > 
> >      - A write request for more than {PIPE_BUF} bytes shall cause one
> >        of the following:
> > 
> >       - When at least one byte can be written, transfer what it can and
> >         return the number of bytes written. When all data previously
> >         written to the pipe is read, it shall transfer at least {PIPE_BUF}
> >         bytes.
> > 
> >       - When no data can be written, transfer no data, and return -1 with
> >         errno set to [EAGAIN]. */
> > 
> >       /* Independent of being blocking or non-blocking, if we're here,
> >          the pipe has less space than requested.  If the pipe is a
> >          non-Cygwin pipe, just try the old strategy of trying a half
> >          write.  If the pipe has at
> >          least PIPE_BUF bytes available, try to write all matching
> >          PIPE_BUF sized blocks.  If it's less than PIPE_BUF,  try
> >          the next less power of 2 bytes.  This is not really the Linux
> >          strategy because Linux is filling the pages of a pipe buffer
> >          in a very implementation-defined way we can't emulate, but it
> >          resembles it closely enough to get useful results. */
> 
> I do not understand what part of that code comment refers to either
> documented behavior or to a thorough test you performed. To the contrary,

The point is that when avail < PIPE_BUF, wirte() doesn't fill all the
available space. This behaviour is a mimic of Linux.
With the patchs
https://github.com/git-for-windows/git/issues/5688#issuecomment-2996103559
https://cygwin.com/pipermail/cygwin-patches/2025q2/013897.html
write() fills all available pipe space. That breaks the code intent,
regardless of whether the behaviour is correct thing.

With cygwin 3.6.3, the result of check-non-blocking-write.c is
w:65536
r:2048
w:1
w:-1
w:-1
w:1024
w:512
w:256
w:128
w:64
w:32
w:16
w:8
w:4
w:2
w:-1

while the result with above patches is
w:65536
r:2048
w:1
w:2047
w:-1
w:-1
w:-1
w:-1
w:-1
w:-1
w:-1
w:-1
w:-1
w:-1
w:-1
w:-1

And with nga888's patch, the result is
w:65536
r:2048
w:1
w:-1
w:-1
w:1024
w:512
w:256
w:128
w:64
w:32
w:16
w:8
w:4
w:2
w:-1
where the intent of the code is kept.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
