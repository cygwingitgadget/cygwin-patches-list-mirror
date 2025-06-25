Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 8F4D03858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:27:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8F4D03858039
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8F4D03858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750854421; cv=none;
	b=DOdbJNY3WEnaHU57CdVkw5CBttm1CCFiLC0h54CJ0tvFX3tRcHxvYHhgkfKEeNMP+fdkGmNx4BpP1cM6l5Rnq2yLbeLRigtGNYr53aMbodyE9hWHnY6cx2jS9+4WQlfRQWZIgh8T9v1KQELSdj+CVbdWcVCdyov7VJn+e9np49s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750854421; c=relaxed/simple;
	bh=eAjNYOKBqsIKYkj1x5mcxt/9mhJzfqAFGzSH1x5nO0k=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Gn+tu9ANJqVE+O8Th6BwsgtdaQlRkYTco3d5xM4XBMJJ6ICx9Zk+qhAmJVC9gRCldNZbgelL+2mNpy5GzYv6gk/LBdL/ZZ9TTyqHGY3nyqpUwN2fpa6wEJZQGtYtZT1Ewt4Tht3eNY15p1YU0KwDijKji3WKOc9e0Zh7CZ7jhNY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8F4D03858039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Gsg+jXIG
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20250625122658801.WLUB.23755.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 21:26:58 +0900
Date: Wed, 25 Jun 2025 21:26:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250625212658.2f607120a5e7fd709cf8022e@nifty.ne.jp>
In-Reply-To: <a379f48a-e0db-7769-2968-9c4df5293a0d@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
	<20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
	<701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
	<4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
	<20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
	<20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
	<a379f48a-e0db-7769-2968-9c4df5293a0d@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750854418;
 bh=ObNgdy+OWK0j6GfV1duXNurDlLFJcdsQLHxILHXv/6k=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Gsg+jXIGaM5QgcwNXprnExWCEi9pGQPBYSxsJa3hOz6suJeS9Z/7JydktBrH8qNC89PieTif
 3EA2gs6WTov749iUpQjtctNklxPFgPpHDSzM99/Zbjk/3789rD4s3VxJllufMCdW0mt8prSPMQ
 rvE6IAtGGn8Sy5ta2sLH+pLauPM9NuB4TpLEqTtAaSXWn2sXbj/2ZNdufs9b2kOEhnT5G2jFWF
 NtVMk+zqat95xdOdEPtJx4w/v+evGHYsvC5xDZMb12NMgrYN/kprXFC0OOXCi9cAcO7XlxmAcE
 VjD7jZl87ehrVrEKtzkZA54Erf/mgJS0VOm98sOGwn6Zl2fg==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Jun 2025 14:07:15 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 25 Jun 2025, Takashi Yano wrote:
> 
> > On Wed, 25 Jun 2025 19:55:34 +0900
> > Takashi Yano wrote:
> > > 
> > > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > > 
> > > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > > > 
> > > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > > > 
> > > > > > I'd revise the patch as follows. Could you please test if the
> > > > > > following patch also solves the issue?
> > > > > 
> > > > > Will do.
> > > > 
> > > > For the record, in my tests, this fixed the hangs, too.
> > > 
> > > Thanks for testing.
> > > However, I noticed that this patch changes the behavior Corinna was
> > > concerned about.
> > 
> > The behaviour change can be checked using attached test case.
> 
> I do not understand what this undocumented code is trying to demonstrate,
> not without any explanation.
> 
> Could you rework it so that it becomes a proper test in the test suite
> that verifies that Cygwin behaves as desired, please?

What the comment in the source code says:

      /* NtWriteFile returns success with # of bytes written == 0 if writing
         on a non-blocking pipe fails because the pipe buffer doesn't have
     sufficient space.

     POSIX requires
     - A write request for {PIPE_BUF} or fewer bytes shall have the
       following effect: if there is sufficient space available in the
       pipe, write() shall transfer all the data and return the number
       of bytes requested. Otherwise, write() shall transfer no data and
       return -1 with errno set to [EAGAIN].

     - A write request for more than {PIPE_BUF} bytes shall cause one
       of the following:

      - When at least one byte can be written, transfer what it can and
        return the number of bytes written. When all data previously
        written to the pipe is read, it shall transfer at least {PIPE_BUF}
        bytes.

      - When no data can be written, transfer no data, and return -1 with
        errno set to [EAGAIN]. */

      /* Independent of being blocking or non-blocking, if we're here,
         the pipe has less space than requested.  If the pipe is a
         non-Cygwin pipe, just try the old strategy of trying a half
         write.  If the pipe has at
         least PIPE_BUF bytes available, try to write all matching
         PIPE_BUF sized blocks.  If it's less than PIPE_BUF,  try
         the next less power of 2 bytes.  This is not really the Linux
         strategy because Linux is filling the pages of a pipe buffer
         in a very implementation-defined way we can't emulate, but it
         resembles it closely enough to get useful results. */

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
