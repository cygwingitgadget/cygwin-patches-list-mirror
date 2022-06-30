Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 3047C3858010
 for <cygwin-patches@cygwin.com>; Thu, 30 Jun 2022 19:05:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3047C3858010
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (ak044095.dynamic.ppp.asahi-net.or.jp [119.150.44.95])
 (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 25UJ4aji027400;
 Fri, 1 Jul 2022 04:04:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 25UJ4aji027400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1656615877;
 bh=5usJsjXtw0Q4BUZ/nUr6Bwf2gFhLdidUq2rLMATwdvI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VNQbh7aw9TdnSkVxlNReuCLt6VXg/6CLp09ybn0ZQw4KySwtheQUXY9Fod8aja2+Y
 5/wNd/t1erT0s+/LYqj5ESz9YqtV9yqUs68b+A6iZkCeD/NfbFzMgi/xmKaoSGpxnv
 b4dMWvepOup0Dq+2kWE+QrJe2CXVKDVHbpY4WDaTUY53z7/ljfAEG7sMbnAlGm1mt+
 XS8IarFe6d4uzUpZ0eZEkPJeHfYEAkqKZ4LupbvfJ/J9E0L9bSPyjxENFmrwaUQdLA
 y/tz2gE8BIrB84vRWsMzHnf0nXwGLoo0vYrA8oI5k9Gg5zHKk6Hc3pufMTzCA35u9s
 b4Izu0euVP72g==
X-Nifty-SrcIP: [119.150.44.95]
Date: Fri, 1 Jul 2022 04:04:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: spawn: Treat empty path as the
 current directory.
Message-Id: <20220701040436.d1e0f8151fffe03a0823b99d@nifty.ne.jp>
In-Reply-To: <DM8PR09MB7095DDCF46700AB235A53717A5BA9@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
 <DM8PR09MB7095DDCF46700AB235A53717A5BA9@DM8PR09MB7095.namprd09.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 30 Jun 2022 19:05:24 -0000

On Thu, 30 Jun 2022 18:35:04 +0000
"Lavrentiev, Anton \(NIH/NLM/NCBI\) \[C\] wrote:
> >                However, use of this feature is deprecated, and POSIX
> >                notes that a conforming application shall use an explicit
> >                pathname (e.g., .)  to specify the current working
> >                directory.
> 
> Since "SHALL" does not mean "MUST", I think this patch is correct.

In the POSIX standard, "SHALL" is used almost interchangeably
with "MUST" as other standard documents do.

https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap01.html#tag_21_01_09

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
