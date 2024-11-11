Return-Path: <SRS0=Rgej=SG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 915413858D21
	for <cygwin-patches@cygwin.com>; Mon, 11 Nov 2024 09:14:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 915413858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 915413858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731316458; cv=none;
	b=xEaOD5OnfPEEykrmOh+35n4WTJO8QVKuwKiZGBJtbCtEvvggGa4kn7fxIO3XuI7F+5C8Io5yZAX9BDJ4qUhBZGSkvFk1sYfMYUUoWtis+2HDt/5gQ5K0lEpUd1Q1+i7GKtNKSs5JZLbkpe1BlOkC6fJbMwZBSfzlS6LxFRQbJH0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731316458; c=relaxed/simple;
	bh=bxEIF3QS+uL83lTQaK4gG9h1cObxgos18j/aqlmvIRo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=O1PZCze+V0yu4vI3WuH+/gY5axPsxFh1SuB8RmOJ3GeXXzrvtzsWCLZYWO9rtTlTgwC5P7LckAYI1yFPu8j/mb3xg8gJ+/OHLLHyIXWEF9e4DbHD8qH9KYx9rzbh7CRNfMefiVI1qJF7ffDeG4uCgB1+Lbluy08ETPEXpEee1HE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20241111091408566.LNSC.7571.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 11 Nov 2024 18:14:08 +0900
Date: Mon, 11 Nov 2024 18:14:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix clean up conditions in close()
Message-Id: <20241111181406.2b652a346e2ff89e7151e0a6@nifty.ne.jp>
In-Reply-To: <a18fbf5a-ba01-45e7-b734-6be340837060@SystematicSW.ab.ca>
References: <20241108114309.1718-1-takashi.yano@nifty.ne.jp>
	<a18fbf5a-ba01-45e7-b734-6be340837060@SystematicSW.ab.ca>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1731316448;
 bh=bCIsaZ8Qu2r5cghr7XsMDnuCc3J3hZpIkUnDUuQyMEE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=kvAUx1pfwGoyb76lmLzm4JzRNngKlfzCqVDGZ3cFy5jH9fXfIgqmonF+rPcQxe9/ESkq3NHZ
 BwBRQr5zPa3KODFF/JEkGM65baGoIOAVdGgEY1JhaFJYmd7nAtUrznxLaTcwvG9FzPSUFxbimj
 nWa0xz5IA5ybekMzEJ+r0xyO6mafeEygBwURIn0/enOO0hFeR+qboCXs521pXO1ePezRoLcegx
 e6QmWUx0dBw+FmAHwLZZBUI4HCgiEXID9fvHkXx2sYuE8tuCLGgQ0spWrH0kiKGtkaBCDsO390
 0Y8nZG/+AElvT6CrmCh1GrQDdNMAaoLSiS4uKXlG0E5nE2rQ==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 8 Nov 2024 18:26:47 -0700
Brian Inglis wrote:

> It might be better if you could please document the wrong premise, as well as 
> the right premise, and the reason for choosing the latter over the former, as in 
> your other console patches?

Yeah, you are right. I was cutting corner at that moment.
The wrong premis was that I thought myself->cygstarted is
true for process which start in shell by exec command.
Actually, the process inherits the myself->cygstartd from
the shell.

New code dtermines how many handles exist by checking the
current process is console owner process which started
cons_master_thread.

The commit message cannot be revised, so, I'd like to
add comment to source code as well as the explanation
for following magic number 2 and 3.

> In the comparison vs handle count, the reason for hard coding those magic 
> numbers would perhaps be better expressed by defining meaningful symbolic names 
> for those numbers, maybe also a named macro for picking the magic number to use, 
> and some explanation of what those numbers, comparisons, and settings represent.

Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
