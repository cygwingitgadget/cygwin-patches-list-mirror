Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id 865343858C27
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 17:16:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 865343858C27
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 1BPHGYKe027174;
 Sun, 26 Dec 2021 02:16:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1BPHGYKe027174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1640452594;
 bh=DV3s2Qcptoxeizizr/t05t95kj1LDPYyvbw7FnYtAik=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=v7wR2/76Rnzxbx7qIFI3LpVQPg0GZK9dgRRbgNQGPm5CcDCjD4PUcBfxNv8xt1vKw
 d4Xj3TPOEG50OasijmM7ncuOj7nj1bzHOMUwJKSX7Sa8sVo+uQbiqqkmEQs1aZZo1u
 bJjF+Jd394zupTXrIVAHNknONfEcjykra8ed+eO3KgZvqzu75b4mmrIkdkmxvuM4kL
 uacfiYde4yKorxgCcjYxsgoQDScUYB/Mrq4k2D7qb75YuN26enexvRej9x/srJMzbd
 hK2h8o7cCi7Ee0vdpfGKqcIPz79VL2pzE3CKLxZ7O10PwIH1nhel/PKRqUYFeOr58A
 M3foYbw4WDBIw==
X-Nifty-SrcIP: [14.3.233.132]
Date: Sun, 26 Dec 2021 02:16:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Message-Id: <20211226021639.80aa08c25bc16ae0ceaf19a6@nifty.ne.jp>
In-Reply-To: <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 25 Dec 2021 17:16:52 -0000

On Sun, 26 Dec 2021 02:10:10 +0900
Takashi Yano wrote:
> 	if (phi->NumberOfHandles > n_handle) {
> 		HeapFree(GetProcessHeap(), 0, phi);
> 		exit(1);
> 	}
[...]
> 	if (shi->NumberOfHandles > n_handle) {
> 		HeapFree(GetProcessHeap(), 0, shi);
> 		exit(1);
> 	}

Sorry, please remove above lines.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
