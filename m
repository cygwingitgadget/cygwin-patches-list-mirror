Return-Path: <SRS0=DLLh=KJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1009.nifty.com (mta-snd01010.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id B4B5A3858C55
	for <cygwin-patches@cygwin.com>; Sun,  3 Mar 2024 10:21:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B4B5A3858C55
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B4B5A3858C55
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709461276; cv=none;
	b=aWvlHTKat3c4+bNTdMUz+ilXSOYMnRKtQtcRw6A7eNZSNCD2gGUo6BZ9auhDdahupYkRr9WszNbTc/DWqpVXI8BxkiOKDNBLTvU50hPckjbIrFXsz04A6rv8JhglUQ/who1sHm9bqgXT1yRq+yhM9zCpcf2EtjvOsnYdQd4KgLI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709461276; c=relaxed/simple;
	bh=xLFNv7xtvj1gprter5MRoLWW/PHDSLUCP9eYHtunz8Y=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=M0btDVR4YUtvOPB7mBKJwvm27QZ19pH+4pnpzJGbPcc+ep8i3NQ7nLRFatP0s5jFINtfYJDII0dnpb0DhopwntJmgQ9xZSvKOOu/qRNpk7b8lsX8pxL6YFsluWJ1KD2Nlfqo70yAGXEhbCeb/gLTZUrRD/x60iIdgIjoR47LqAk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta1009.nifty.com with ESMTP
          id <20240303102110386.EOEW.65055.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 3 Mar 2024 19:21:10 +0900
Date: Sun, 3 Mar 2024 19:21:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-Id: <20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
In-Reply-To: <b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
	<b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 3 Mar 2024 10:34:44 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> thank you for the fix! I can confirm that it addresses the problem
> demonstrated by the reproducer in that MSYS2-runtime ticket.

Thanks for testing!

> After noticing that we enumerate all the processes (which is an expensive
> operation) just to skip all of the non-Cygwin ones anyway, I wonder if it
> wouldn't be smarter to go through the internal list of cygpids and take it
> from there, skipping the `SystemProcessInformation` calls altogether.

Yeah, that makes sens. I'll submit v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
