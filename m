Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 026263858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 12:17:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 026263858039
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 026263858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750853878; cv=none;
	b=v0t2q1NwUMuyJO6cx0ARdf5ORrsNwCwPVRCCq5pyGoubnV9TuMHR4vOSZ2c05OPF7J3wamn4LXMf8zCGC4feWPZ5ygI2A1XKYkIUbX0SeaKnysZGZaf5mzWkfbVCEDeKbm7GYrFcOAMNSn7Rg10T/1EBsLryWtnWl3lVcWe1IF4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750853878; c=relaxed/simple;
	bh=E+PkcyoAGvs6yay7iKGswU+/WSs5zv6bVCE93f45eHI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EKhcTWHpaZ5tcEHnt1rlLRwFhfS6ZDUTAi2BGVTttmVIXVCs3ytjsxqkGYN8IHjsF/T57+d3xxChhhqSM6943eX7Yx9EvPkTJClANh3PCzkxlR862QLBc0WxikLTUNzwRHZpvRf8W2lDZKIPRdavQmVijdbLrvQmUHSemOPhj7g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 026263858039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nxN1M+7y
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20250625121755366.LRLE.47226.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 21:17:55 +0900
Date: Wed, 25 Jun 2025 21:17:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250625211754.c9b38091a64362f2d28da1f8@nifty.ne.jp>
In-Reply-To: <20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
	<20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
	<701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
	<4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
	<20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
	<20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__25_Jun_2025_21_17_54_+0900_pPfoBTLlpB0EZZDR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750853875;
 bh=BPvkdWvxFmvlHBap1ET4/6rIgocxntk5rJWBJ14lKBA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=nxN1M+7yBxGf2eMBGXM9FCRnpW7Ln9S/pkskM6qUZ6CToUegtZPuuWX4C1GHJtq8VJKhheQe
 JXXALYXdAwNSZQJlRJJVLvXaDi+EwVJEWW82EQaPlmxhJ46XIzd/2ddkIyuD8xMvOGLAT5cunq
 2D76fKExvErUR4YDhXBmkyGm+AzCsQrRxzHq9uWptFfkBcNcJ6yixnQC6K8sCFr/4EUTZ8+eX9
 yr9kq6xW/nU2pNeMIJf3zcZ4YrOkiAyIbBMBO6qm39AEAJ7DK951NByDBbkcg/clniWFmDGxfA
 /oavzuWna3axY1tJomUz1iaNi5Y/EOnC3hyx671zz0iDMsdQ==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__25_Jun_2025_21_17_54_+0900_pPfoBTLlpB0EZZDR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 20:51:02 +0900
Takashi Yano wrote:
> On Wed, 25 Jun 2025 19:55:34 +0900
> Takashi Yano wrote:
> > Hi Johannes,
> > 
> > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > Hi Takashi,
> > > 
> > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > > 
> > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > > 
> > > > > I'd revise the patch as follows. Could you please test if the
> > > > > following patch also solves the issue?
> > > > 
> > > > Will do.
> > > 
> > > For the record, in my tests, this fixed the hangs, too.
> > 
> > Thanks for testing.
> > However, I noticed that this patch changes the behavior Corinna was
> > concerned about.
> 
> The behaviour change can be checked using attached test case.

Hmm, then, nga888(Andrew Ng @github)'s solution seems to be
the best one.
https://github.com/git-for-windows/git/issues/5688#issuecomment-2995952882

The test result of the attached STC is the same as that of cygwin 3.6.3.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__25_Jun_2025_21_17_54_+0900_pPfoBTLlpB0EZZDR
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
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));
	printf("w:%d\n", write(fd[1], buf, PIPE_BUF*2));

	return 0;
}

--Multipart=_Wed__25_Jun_2025_21_17_54_+0900_pPfoBTLlpB0EZZDR--
