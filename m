Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id D250F385780C
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 11:51:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D250F385780C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D250F385780C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750852265; cv=none;
	b=Uzk/WxtMzLaAcKc2yzJuUth2vRM9ngba5EvfeNxHpj35FLjxnx49vohJ/XhrVps96Q29XkA87zs3B2umE9mQtgII/aqihBffG57iUemf2M0pRf32Ninc5iexlB2JsL1n7qWRASMVFdRjS5FGLB4XxScEECb56Kq9Q3eXcXkw+Ok=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750852265; c=relaxed/simple;
	bh=LLRHhosaZzVlgNXXqOp+fYd5VDpFeTt6I+uQfpB14Y4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=UnzkstokZW4Sj1HhuKwbFgWndtQowyKdGuiiTLvHHqe4fwWGhHi3tKzVK/qH3p469ckKlt/kHWU+zJx/FONrxP+idP2O7IJtecRxqyHVq1wp+S50HQk5CxJSsyvya56E3szqspk6+VjR502oIUU8tv5IayArxIpEf8Akm0yfPJY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D250F385780C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L1073R/M
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20250625115103087.JPDR.88147.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 20:51:03 +0900
Date: Wed, 25 Jun 2025 20:51:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
In-Reply-To: <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
	<20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
	<701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
	<4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
	<20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__25_Jun_2025_20_51_02_+0900_xOw0IrQJ1VO1bRHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750852263;
 bh=rNGdkdexilFxxMcErOE6hNIAjbhagXYhIwZn2rV57Lw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=L1073R/MGUWGwbOG05raHk1l1l6oQhFm25psG7+lH8AHxvtLFgvMsPGg4Ll0+hckmPOrA3Lq
 4hohOoy806xZqjhLXb8+b1B93KnVB4Dxx5m9fQVko01dvseymvicw+guGNGpMOOMIVN/NMT7kn
 jV/UhM4s8vLBncujRp+fwqVPimNVE7Kb6uqUx/uiYDGXTFd/DI9IYsDPqYbmM0qNN3r4nhoFp1
 OaK0twoufBvQ+n98doIrAvUX914W1qm0VUZiP6DuG0te2Y06GbjJvg4P66znEMYOuyAN67o4Nl
 k+gFtQHXmjtHyHuY/P+IPyLhNlBroaSJMnzqA2p6rxxLox9A==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__25_Jun_2025_20_51_02_+0900_xOw0IrQJ1VO1bRHl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 19:55:34 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> > 
> > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > 
> > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > 
> > > > I'd revise the patch as follows. Could you please test if the
> > > > following patch also solves the issue?
> > > 
> > > Will do.
> > 
> > For the record, in my tests, this fixed the hangs, too.
> 
> Thanks for testing.
> However, I noticed that this patch changes the behavior Corinna was
> concerned about.

The behaviour change can be checked using attached test case.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__25_Jun_2025_20_51_02_+0900_xOw0IrQJ1VO1bRHl
Content-Type: text/x-csrc;
 name="check-non-blocking-write.c"
Content-Disposition: attachment;
 filename="check-non-blocking-write.c"
Content-Transfer-Encoding: 7bit

#include <unistd.h>
#include <stdio.h>
#include <limits.h>
#include <fcntl.h>

#define PIPE_SIZE 65536

int main()
{
	int fd[2];
	char buf[PIPE_SIZE];
	int flags;

	pipe(fd);

	/* Set non-blocking */
	flags = fcntl(fd[1], F_GETFL);
	flags |= O_NONBLOCK;
	fcntl(fd[1], F_SETFL, flags);

	/* Fill pipe */
	printf("w:%d\n", write(fd[1], buf, PIPE_SIZE));
	/* Free PIPE_BUF/2 bytes */
	printf("r:%d\n", read(fd[0], buf, PIPE_BUF/2));

	/* Write PIPE_BUF bytes */
	printf("w:%d\n", write(fd[1], buf, 1));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF-1));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF+1));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));

	return 0;
}

--Multipart=_Wed__25_Jun_2025_20_51_02_+0900_xOw0IrQJ1VO1bRHl--
