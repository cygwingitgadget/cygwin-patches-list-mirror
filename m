Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id B81593858D28
 for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2022 08:44:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B81593858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 2318iRRb028598;
 Fri, 1 Apr 2022 17:44:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2318iRRb028598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1648802667;
 bh=1zp0LlI4Kv5ft5j6tLmPbBG6Nuh2GrbivI5ygAqTL9U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=a56ZcBbsz5bIyoa1n6mcwKzm69zJU4vX3UU/fI1IFxtcNsi/JZ7Qpfmtscj21vTMC
 BCab/A05ezHEn/ywqnDqlyECTIPSsgXKUhg3tScDHtGuzb41thcO1h7DPVx4mO43y+
 8H4nAC4/gqUCA0W4YvVel0Co8JX0Reci9mG31JUmiFsxxEoINdx8bxrKWNqtbUXjuL
 VKoV/vs6PHMtGQESoXYCfxwTeij318IbHlNSwIViSHTMSF8po5e8WVjrsjO7JU3UIM
 vWbeeOtsD7ZlSo7HQwWHV7/RGYbULCCeStC68jLkEJoe+3b+wxkQ+iKCiYQzGzH2m5
 QLnYexr39Af1g==
X-Nifty-SrcIP: [119.150.44.95]
Date: Fri, 1 Apr 2022 17:44:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
Message-Id: <20220401174440.37fa2bb79cc64a0c20e4b3ed@nifty.ne.jp>
In-Reply-To: <20220330091716.f4541fdff98f2b0aa0c1ec2f@nifty.ne.jp>
References: <20220329090753.47207-1-takashi.yano@nifty.ne.jp>
 <alpine.BSO.2.21.2203290816270.56460@resin.csoft.net>
 <20220330091716.f4541fdff98f2b0aa0c1ec2f@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 01 Apr 2022 08:44:57 -0000

On Wed, 30 Mar 2022 09:17:16 +0900
Takashi Yano wrote:
> On Tue, 29 Mar 2022 08:21:11 -0700 (PDT)
> Jeremy Drake wrote:
> > This block seems to be inside a loop over handles.  Would it make sense to
> > move the `tty_min dummy_tty` through `t->kill_pgrp` lines outside the
> > loop, and set a flag in the loop instead, so the pgrp only needs to be
> > signaled (killed) once rather than for each handle that needs closing?
> 
> Thanks for the advice. I will submit v5 patch reflecting your advice.

I revised the patch again a bit so that __SIGNONCYGCHLD will
be sent only if it is really necessary.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
