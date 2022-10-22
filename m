Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
	by sourceware.org (Postfix) with ESMTPS id 0791F3858C62
	for <cygwin-patches@cygwin.com>; Sat, 22 Oct 2022 06:08:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0791F3858C62
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj136180.dynamic.ppp.asahi-net.or.jp [220.150.136.180]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id 29M67rKo001309;
	Sat, 22 Oct 2022 15:07:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 29M67rKo001309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1666418874;
	bh=mCOaAru9YTxZ/Jwz78kpN8cLtzr+xYnCxNNzbnNsB0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tQhhJrPN/R18EujHJEl9n8P5BlCltONvSgfIuGvhDrG7Al7K2Tgv9mvmmaqkF2GmT
	 iQFxcSerWT6dEER7ZypEHtHDMINYzcs06uPGe0NegIPkZInc5mQIyKBlzviG+7+LX2
	 E+JS0Kmnu6v2G/G4kT4FMxNB2LO4jeiLDf4DDdKC52Wrl6y+IR9cwjiZgReenK/AcX
	 sW8QQbu6aWt/0NzSbE3L6ZujH7n9Mlm8Zzglnk7ZEveuMuxxDaYp7TjQYTDBfdRUCi
	 a6ZOAC8pWU4/IZzws8fdJsPMa1JH5XKFKN2HfPZfkhOJDtzAQKM89S0mDM5u0FnRKN
	 /4KKLZEKXZAMw==
X-Nifty-SrcIP: [220.150.136.180]
Date: Sat, 22 Oct 2022 15:07:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Fix `Bad address` when running `cmd /c [...]`
Message-Id: <20221022150754.b60ed857badc06a7648c7dc3@nifty.ne.jp>
In-Reply-To: <9E4B94F4-2E88-4B95-AEB0-24B083662D32@gmx.de>
References: <8rqs6n82-0oq9-2200-944n-74s7o699385o@tzk.qr>
	<20221022103639.0be6d01709fc99d06b3d0d41@nifty.ne.jp>
	<20221022105406.12f2c65e497e80df4014a8fb@nifty.ne.jp>
	<20221022143709.b54643c7b29b3d6260382e85@nifty.ne.jp>
	<9E4B94F4-2E88-4B95-AEB0-24B083662D32@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 22 Oct 2022 07:55:53 +0200
Johannes Schindelin wrote:
> It's not very nice to simply drop my work, and then not even link to your "counter".

I am sorry, however, your patch can be indirectly reached
via link https://github.com/msys2/msys2-runtime/issues/108
in my counter patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
