Return-Path: <SRS0=Ab5w=5A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
	by sourceware.org (Postfix) with ESMTPS id E6BDD3858D1E
	for <cygwin-patches@cygwin.com>; Tue,  3 Jan 2023 03:33:05 +0000 (GMT)
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id 3033WoU1032163
	for <cygwin-patches@cygwin.com>; Tue, 3 Jan 2023 12:32:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 3033WoU1032163
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1672716770;
	bh=aW53tXCC/p9lfrdVHPgL/0VA/nUeJbT1iIYb3US9X+A=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=as8HQtt46SelJF82NX/szk7I8xq5Zt6hB9/vb1kfCNBPumrIvum6OoPd0NgYPl4v1
	 tqRaxXH3QcG+38kic1jvncwwnlN8LoxHFeritfc13t7C3GC1rx3H4oOyKaRFN3KXVA
	 jGZ4zg5+sLOW2txGjqbsTUIo45VlsavQ/O1l578idzIUM7cHi7ltD6pzWQ4NuAryuZ
	 HfszjpqrdJzcjBk2S9QeXec19JVH84bL0Dr2tMBf4re8oZZFqC4SJ672+BVAI1GvIo
	 oOrT0MrvrCcWQSEXZ5rWkvWW1/hec5FW52rCrZbDWGdD3X0NIWyx+LgyhllCAdxcUZ
	 HxGfk571MClhg==
X-Nifty-SrcIP: [220.150.135.41]
Date: Tue, 3 Jan 2023 12:32:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: newlib-cygwin master shortlog missing cygwin release tags
Message-Id: <20230103123252.56e90e85c32c270662bbbc6b@nifty.ne.jp>
In-Reply-To: <a50c2610-3fb0-f1d6-0e89-a7b622f768b3@Shaw.ca>
References: <a50c2610-3fb0-f1d6-0e89-a7b622f768b3@Shaw.ca>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Jan 2023 18:44:10 -0700
Brian Inglis wrote:
> I am confused looking at master shortlog missing cygwin release tags:
> 
> https://sourceware.org/git/?p=newlib-cygwin.git;a=shortlog;h=refs/heads/master
> 
> the only cygwin tags shown are cygwin-3.5.0-dev and cygwin-3.4.0 the day before 
> and nothing else back until 2021-10-28 cygwin-3.4.0-dev and cygwin-3_3_0-release 
> the day before, whereas the summary page shows more tags and different dates:
> 
> tags
> 2 weeks ago	cygwin-3.4.3		Cygwin 3.4.3 release	tag
> 3 weeks ago	cygwin-3.4.2		Cygwin 3.4.2 release	tag
> 3 weeks ago	cygwin-3.4.1		Cygwin 3.4.1 release	tag
> 4 weeks ago	cygwin-3.5.0-dev				tag
> 4 weeks ago	cygwin-3.4.0		Cygwin 3.4.0 release	tag
> 5 weeks ago	cygwin-3.4.0-dev				tag
> 3 months ago	cygwin-3_3_6-release	Cygwin 3.3.6 release	tag
> 7 months ago	cygwin-3_3_5-release	Cygwin 3.3.5 release	tag
> 11 months ago	cygwin-3_3_4-release	Cygwin 3.3.4 release	tag
> 12 months ago	cygwin-3_3_3-release	Cygwin 3.3.3 release	tag
> 13 months ago	cygwin-3_3_2-release	Cygwin 3.3.2 release	tag
> 14 months ago	cygwin-3_3_1-release	Cygwin 3.3.1 release	tag
> 14 months ago	cygwin-3_3_0-release	Cygwin 3.3.0 release	tag
> 
> so what am I not getting?

Recently, some branches other than master are used
for the releases.

-+--------+---------------------> master (cygwin-3.5.0-dev)
  \        \
   \        \-------------------> cygwin-3_4-branch
    \
     \------------] cygwin-3_3-branch (cygwin-3_3_6-release etc.)

You can access them by e.g.:
git log origin/cygwin-3_4-branch
git log origin/cygwin-3_3-branch

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
