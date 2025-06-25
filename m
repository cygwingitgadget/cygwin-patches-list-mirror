Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.226.35])
	by sourceware.org (Postfix) with ESMTPS id 9181F3858039
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 10:55:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9181F3858039
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9181F3858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750848939; cv=none;
	b=HswND/DSc84iFtus2v1avFokYNTKovVSSXZXWXsY5lbq/57caPVjGuvTn70fsV+7agDTw8U/OATiNkcWmdSuB10p3Duoi+4nVY0T4GSTprIbIre1unVzhcieimxCP87qlqfvo5aKaBncWhNejz5DpIBRjhPp5bksERjw1hIB3fs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750848939; c=relaxed/simple;
	bh=hB9GaB2as0FYyRGcCuuzx9//wD65aPFRYYaC3T1DMz0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=FVRiUYfXC5q62oq2NNSvwJ5972X+i7CI01g8S9sDGl5BwvPsrREhvuM0b03j4wATtVUlpIfTy34DNmSCw5aDyuBfDfRqEJkQbbVH8XNzV7poHmwpQY3sM4yPuWYoUConbJVaGLuyH1a8ADmERqsaAobeu+AVPqUVEeNZWXEobX0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9181F3858039
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qVWVPPTN
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20250625105535336.GFDT.47114.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 19:55:35 +0900
Date: Wed, 25 Jun 2025 19:55:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
In-Reply-To: <4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
	<20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
	<701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
	<4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750848935;
 bh=g4MbhKxqqO4C408auW9RPYW6vwcO0G3XJb2mK0/RSEA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=qVWVPPTNB+2F3OW1Out2yz4cMjZPtiPNSnwDQVxhPbP0SQEL/7TUpELr5PsCY8mVkI6NJmPa
 PEmHiJgJHFTYQdTPPSySzTW/4ahXuyqYw/oFIo55LUHmuJ6di/j3dUp97Vy/kzLk+YoMyeOKOA
 ZjKyL9D2owzeGTGiE/2AIo+m0FEbzD2otWspgKevECU/6YDV6E/OhxuY1BiGOYfKPbjYu9fieF
 sTUODir4ph1LpVHJVNntOtuOnmGsT90skuEgy+tPj2gLFWxkv2ARRNYIxZKxyS5YeUIiTdHKoe
 y7+fsmjHP7fPpCVhUL6wDa0Dh1sIESshlVddV7c7DGL21gQg==
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> 
> > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > 
> > > I'd revise the patch as follows. Could you please test if the
> > > following patch also solves the issue?
> > 
> > Will do.
> 
> For the record, in my tests, this fixed the hangs, too.

Thanks for testing.
However, I noticed that this patch changes the behavior Corinna was
concerned about.

After trying various things, I found yet another solution for the issue.

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index e35d523bb..e36aa57fc 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -647,7 +647,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	    }
 	  if (!NT_SUCCESS (status))
 	    break;
-	  if (io.Information > 0 || len <= PIPE_BUF || short_write_once)
+	  if (io.Information > 0 || len <= PIPE_BUF)
 	    break;
 	  /* Independent of being blocking or non-blocking, if we're here,
 	     the pipe has less space than requested.  If the pipe is a

Corinna, what do you think?

Johannes, could you please test this patch as well?

> The only two issues I found aren't new in your revision, but I'd really
> like to address them, too:
> 
> - When running that `git clone` in a PowerShell inside a Windows Terminal,
>   Ctrl+C does not work, the SSH process simply continues.

This seems because ssh does not receive SIGINT. If you issue
kill -2 <pid>
ssh stops. Who should propagate SIGINT to cygwin ssh executed
by non-cygwin app (Git for Windows) in this case?

> - Also, terminating the SSH process from a separate terminal window via
>   `Stop-Process` (not `kill`, as I had mistakenly reported earlier)
>   somehow corrupts the PowerShell session such that even a single
>   keystroke in it will bring down the entire Windows Terminal window after
>   a few seconds.
> 
> Ciao,
> Johannes

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
