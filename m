Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 144363858D37
 for <cygwin-patches@cygwin.com>; Wed, 16 Feb 2022 09:43:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 144363858D37
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 21G9gxeQ030116
 for <cygwin-patches@cygwin.com>; Wed, 16 Feb 2022 18:43:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21G9gxeQ030116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645004580;
 bh=LctgFblFHyHuJd44xvciE4o/b/sxhIpUm6TBr0qx6rw=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=f73nkvJnBjTIHGbXib4ADWSFOlQtZDft7G7bh0LjpRHuGK1C5rJttxUb90OXnd0VV
 WF3oV9eFBIBFfSl/OTDUaB0yDlZJtW3oHatHU2nVp9nW/Gh6qKB8goxjCOBJdagwNl
 v268TQR35NwC0XUpZ5u/cN9OSJyw4DhDZqPeYo3Q5BHQMc0dsaad7JunjqWoCXHqNG
 /L9zVwmNRX5LFEdc+SyQUkQ88B00eZfTV3T3jeK/FYSR+BeDzyzyTIi7Pp9cYmaZdy
 wBSeBFRtogL76Jebnd8WVSfCiM2mGvmdJ2agJlFGMr4FrGOq7XHnRSCSVm2nNbEmBj
 1h2DXFfOKwjaQ==
X-Nifty-SrcIP: [119.150.36.16]
Date: Wed, 16 Feb 2022 18:43:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: wincap: Add capabilities for Windows 11.
Message-Id: <20220216184300.f043bb387c5c590ea13fa9f9@nifty.ne.jp>
In-Reply-To: <20220216093311.2055-1-takashi.yano@nifty.ne.jp>
References: <20220216093311.2055-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 16 Feb 2022 09:43:31 -0000

On Wed, 16 Feb 2022 18:33:11 +0900
Takashi Yano <takashi.yano@nifty.ne.jp> wrote:
> -	if (likely (version.dwBuildNumber >= 19041))
> +	if (likely (version.dwBuildNumber >= 22000))
> +	  caps = &wincap_11;
> +	if (version.dwBuildNumber >= 19041)

Sorry, here is a bug. I have sent v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
