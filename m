Return-Path: <SRS0=YyUz=5Q=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
	by sourceware.org (Postfix) with ESMTPS id 6FB933858D39
	for <cygwin-patches@cygwin.com>; Thu, 19 Jan 2023 13:19:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6FB933858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-01.nifty.com with ESMTP id 30JDIlIh026930
	for <cygwin-patches@cygwin.com>; Thu, 19 Jan 2023 22:18:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 30JDIlIh026930
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1674134327;
	bh=JXTz4DFvKQsl+dYpgDiPVabdT2DTJZoP9OZBr1wnnBw=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=ckCforcAz65F8csjtEQaX/zXwoB9IS1EOnhMDmp8pmCQvazPqORhlrHuf5GCtmFvf
	 yr6TKa59kWzgHmxlHoxzAWFAgnOjqhXWif/bxRRDLat/Cbetr+1ArQIqsvgKIhHCT0
	 KHn3y7NT9rS/9/2jnZx+quenrLj6dESZ9UiyQXkTzwRY9oqkL/0NmMCi4o1eaFopGA
	 TcVCe9TZtfMB/qqWrWHy5t82giJfsi4nnC8A0A6FEM+dzZcknDdn+6bVA0zDW24Wmy
	 SBi7uh7Uo3LW1QMOqU8cxbdIlQbJTwRSNiI/lEuvqaFHWewV22+PBB1r5usEkxSnE/
	 Rh8GvjpY3Ajbg==
X-Nifty-SrcIP: [220.150.135.41]
Date: Thu, 19 Jan 2023 22:18:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dsp: Fix a problem that fcntl() does not take
 effect.
Message-Id: <20230119221847.b38a363a47424992070a3d10@nifty.ne.jp>
In-Reply-To: <20230119131005.2012-1-takashi.yano@nifty.ne.jp>
References: <20230119131005.2012-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 19 Jan 2023 22:10:05 +0900
Takashi Yano wrote:
> Previously, fhandler_dev_dsp (OSS) has a problem that fcntl() does
> not take effect at all. This patch fixes the issue.
> 
> Sighed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>

Sorry, s/Sighed/Signed/g

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
