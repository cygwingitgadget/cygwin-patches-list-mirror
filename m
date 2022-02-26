Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id 060003858D1E
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 06:47:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 060003858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 21Q6lOQ3014661
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 15:47:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 21Q6lOQ3014661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645858045;
 bh=6fqZoQBcGQKrOCPfcEAHFFyQZ34euWDyVwEEC0DYOTo=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=o0tbUpCAk2tYHnrLK9e1Al6ZDX8u9qNSzFGqA4qdmVmf8bPLYPGL0kk0A5/a6db4G
 6Cylv7LyKhnrVuPUu+BHarW16eKUSDWA1ADM2OtyLbECv2ewb1EHoEOA4NJF0p6PPq
 jJwwCfT2hR8p9sim7ZwCdZM38QVALln9IazYn92U2xgFNRJXTM+Wu0oD2ZclIDj7f1
 HzYFSArXmYMOd2bbXFdgixyBPtc0fIvNQqrd3LlbXpLDqI19gukWMXDGX81aDoQmRX
 wTHlSliBljIpuO25/q93tV3lJbU5zT0vRWm/DNIyGru6jgAnoMyYr+LnTk03X2pwd8
 RrTYrpXKwAwmA==
X-Nifty-SrcIP: [119.150.36.16]
Date: Sat, 26 Feb 2022 15:47:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pinfo: Fix exit code when non-cygwin app
 exits by Ctrl-C.
Message-Id: <20220226154736.5c2ae47bc814e5be45266412@nifty.ne.jp>
In-Reply-To: <20220224142429.888-1-takashi.yano@nifty.ne.jp>
References: <20220224142429.888-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 26 Feb 2022 06:47:51 -0000

On Thu, 24 Feb 2022 23:24:29 +0900
Takashi Yano wrote:
> - Previously, if non-cygwin app exits by Ctrl-C, exit code was
>   0x00007f00. With this patch, the exit code will be 0x00000002,
>   which means process exited by SIGINT.
> ---
>  winsup/cygwin/exceptions.cc | 6 +++++-
>  winsup/cygwin/pinfo.cc      | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)

I am sorry, but I pushed not v2 but v1 patch by mistake.
I will submit new additional patch to cygwin-patches@cygwin.com.

Please check it again.

Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
