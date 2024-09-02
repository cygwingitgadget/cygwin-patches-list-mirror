Return-Path: <SRS0=co2e=QA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id F412F3858D37
	for <cygwin-patches@cygwin.com>; Mon,  2 Sep 2024 13:57:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F412F3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F412F3858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725285429; cv=none;
	b=rD8jaTUEO2mEiAOliLnFg4TuzIssi53r9k8oC7WeBnvIiY1qia0dOvHxFou9BV7miHTqFMrZtCykeuHTQWEuVfHCv+tEec2y3Nlg2Al/uBnaw7NKJ1HVCKs/61ZHJcRONPUX4f00jyFORVP1WcmQGaoOwPbRrlQswqozmRhVxXE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725285429; c=relaxed/simple;
	bh=8z/3HQmVcPNcZbiiU0t0JZZ5n6aWl0IrPpq1ztU6+28=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EvfKEpr7GiJ4Z1byohZfQjRz5z+I6h2+J6/JsT07Hsxs2hL7lpaTO06lDGaqAviijZKvBcNem34xo5FCud0xtOSsZBL1VRahOrZdD6UJxthG5g3T8JeJBugrYTXec2G/qbyzh5UJ7h+QJFWHSY5iIH4BBGbUZy6tFAZK+HkvEeg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20240902135706243.QDHJ.81160.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 2 Sep 2024 22:57:06 +0900
Date: Mon, 2 Sep 2024 22:57:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
Message-Id: <20240902225705.5571fc0c260cf7a960a9b8c0@nifty.ne.jp>
In-Reply-To: <20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp>
	<ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
	<a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
	<20240902225045.21e496d3af5b70b0a8c47c7d@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725285426;
 bh=vMek1+a0pnjoZoOUpzwRyrg8XeN3eB1Zs9ZAn4hJ+n0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tJRpFAcWl/rD5dPmJTSBsHtt5od527JpkSrqAbXbyhOiOi67exuO+mOZhssdVWXFbDM5X5Kq
 VQa9wC1Aly8d0cDKZVQV/3fRDTVW5i8rEpE9NVckANRRObL9i43X5wsPqKS7M10nZ9Cu2PWzhn
 M6C9/ihqbtfspPch+tqdhZ8iBU+b2ojn30XZhixqxk0YeLifdWMNdAMM2pyk4w9m+Vm/mUOdlm
 z2LVXxhV0Hm9PF9gXPFSqLdNzZlFpQZuKXyxKvGZ+psls7lv5CYl/S3tBVEvStElvA+1g0iHgw
 aUC4mvR5J6gtHmnQZ1e5BplY17vrfbXmsjInguHtB1kQNRMA==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Sep 2024 22:50:45 +0900
Takashi Yano wrote:
> On Mon, 2 Sep 2024 14:48:35 +0200 (CEST)
> Johannes Schindelin wrote:
> > That would potentially be a remedy, but I would worry that this design
> > takes a decidedly single-thread world-view. While that may be appropriate
> > in the context of the scenario described in the bug report, it may very
> > well be inappropriate for Cygwin in general.
> 
> In the first place, it is obvious that multiple threads writing and
> reading from the same pipe at the same time causes undefined behavior,
> regardless of whether the pipe mode is toggled or not, isn't it?

As for the current implementation, raw_read() is protected by a mutex,
so the results are somewhat predictable. However, raw_write() is not.
Should we add write_mtx also for raw_write()?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
