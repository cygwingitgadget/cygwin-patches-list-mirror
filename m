Return-Path: <SRS0=tR/4=4T=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
	by sourceware.org (Postfix) with ESMTPS id E9C493858425
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 10:29:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E9C493858425
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-04.nifty.com with ESMTP id 2BLASufe018438
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 19:28:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BLASufe018438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671618537;
	bh=kepk7zufAVQYFjqQLPyu0o+4ei6lpcRBHkPfrepVEH8=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=Y4hfDN0+mQWuwDDvBoH7s+0Fp+E60SJcmGN/rM9gRzYWSjvGM8oL7sH1DJmjw2/nh
	 2GL3QxYhhPbjAhSn4uFe5isYOpYqZj7yyW9TWxpq9tS+zzET2+8LNXMZ3eKNWomDmq
	 UHxmNRMNXUTT16OKaYXScKQ7r9AY9PNVXPIMDXalhDikh0Uk2vk+5LaNIfsTtHsRHX
	 7RMQI9v/DUjwsEYa+hvspiY6OGvyuKCsJ8nakl/+yOue8M7ZDOE6430Cn8mKthJzlC
	 ongferl0DPpxjh3l24Wmu4kgAY4dsmWlNTaOI88MfoLIAt2fgJVW5MPLYM16CoFMc+
	 IZEKTWlVs6LhQ==
X-Nifty-SrcIP: [220.150.135.41]
Date: Wed, 21 Dec 2022 19:28:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make the console accessible from other
 terminals.
Message-Id: <20221221192857.1d8c0b394c26f51f91dbcad6@nifty.ne.jp>
In-Reply-To: <20221221192343.32699d22e6d113ce9195de8f@nifty.ne.jp>
References: <20221220124521.499-1-takashi.yano@nifty.ne.jp>
	<Y6ItllXJ8J20cEbp@calimero.vinschen.de>
	<20221221192343.32699d22e6d113ce9195de8f@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 21 Dec 2022 19:23:43 +0900
Takashi Yano wrote:
> However, fstat() does not return appropriate information,
> so, I implemented fhandler_console::fstat(). I also set proper
> errno for that case. Please see v2 patch.

Please apply the patches in the following order:

[PATCH v2] Cygwin: pinfo: Align CTTY behavior to the statement of POSIX.
[PATCH] Cygwin: devices: Make generic console devices invisible from pty.
[PATCH v2] Cygwin: console: Make the console accessible from other terminals.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
