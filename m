Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 15436385841D
 for <cygwin-patches@cygwin.com>; Wed, 24 Nov 2021 03:41:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 15436385841D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 1AO3fDfd016947
 for <cygwin-patches@cygwin.com>; Wed, 24 Nov 2021 12:41:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1AO3fDfd016947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637725274;
 bh=O3iUNodHQKjDmH13lQlA8WVku8tgziPQUlUA2cr4xQs=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=QMnWJ4bdTO1Cfbut7ZNQnwgQmmjiJfG4wlAUdJp5LixM8Wbnc6/VKfugMFt3ZFyAA
 hnkOsf1ksm4zKNKjZdB2KfqzHOVrukaahhghGKKeVYkboTkJiApWTKc+GwsdueN6b6
 W4Z9Ub8OnKfx/YbdjxgzZda/3eEqMprHwxZ8YTkjIYOTdGxeQTX9bgLuPLIogDUm5n
 Yrrl1LRT+sWTJmnfdC4nxyx5+w8X7dxlvkCb2wADfL4czrMKy9pGqF0/FSDHgAWZnU
 P6bNJFwo/BVWU+9fsngEvj5n1t0S5vNofrfVhs25OxgMqfddf2RTqC1v1mxmLYW2Ln
 ZdM8jBfvxM7ng==
X-Nifty-SrcIP: [110.4.221.123]
Date: Wed, 24 Nov 2021 12:41:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_fifo::raw_read: handle STATUS_PENDING
Message-Id: <20211124124124.e8ff32bc50dbbf21e94d6dc0@nifty.ne.jp>
In-Reply-To: <9bb59713-39a9-99c4-04b6-b4d5a0f74ea2@cornell.edu>
References: <9bb59713-39a9-99c4-04b6-b4d5a0f74ea2@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 24 Nov 2021 03:41:42 -0000

On Tue, 23 Nov 2021 15:59:05 -0500
Ken Brown wrote:
> Patch attached.  Takashi, since you wrote the analogous patch for pipes, could 
> you take a look?

This one also LGTM.


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
