Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id AA92C3858409
 for <cygwin-patches@cygwin.com>; Mon, 13 Dec 2021 09:09:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AA92C3858409
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (v050141.dynamic.ppp.asahi-net.or.jp
 [124.155.50.141]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 1BD99N8a021990;
 Mon, 13 Dec 2021 18:09:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1BD99N8a021990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639386563;
 bh=0XbZBOW7A04MR+INXxLiwe3w1YfVTG3lbjR0sV92WQY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Uoyc/Su8Ko43Ky6t9Eni+o7uVLwI2kjsE/FOqadunAsZQJoG/auPsJSTCVV8N1LKK
 dgXExuNegJ8ryJ/uEKkXyOwM01VXZNopYJ/UgooqSLgXJ7MVnsvBMI6pD7cLKxHl5m
 0uzs7D3O8I103zcjIHnYTcsXt9lDICQN5ERTXp2k2V5uXLppfFn4X5T02ZiKVY8FKW
 D9Bivo2ZB3rXEucY/MqKwADZWS9Trzxt1u4ZC3fDX56l4ae8HiTNf+OaVeUtGZponb
 d09U1v4yqjnPTEX1xLhHnruN3151I0usInjE37mzKPFxG42bo6cN2nh/m7WvLFqJ9F
 TPfkUoqdRkc4w==
X-Nifty-SrcIP: [124.155.50.141]
Date: Mon, 13 Dec 2021 18:09:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Reduce unecessary input transfer.
Message-Id: <20211213180935.58cc9cf6324d97f12e960b09@nifty.ne.jp>
In-Reply-To: <20211211224030.bf6dc202f01bdd2f4eff32d9@nifty.ne.jp>
References: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet>
 <20211210192040.71f88b263b8c20f2f61db310@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2112101152320.90@tvgsbejvaqbjf.bet>
 <20211211224030.bf6dc202f01bdd2f4eff32d9@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 13 Dec 2021 09:09:51 -0000

On Sat, 11 Dec 2021 22:40:30 +0900
Takashi Yano wrote:
> On Fri, 10 Dec 2021 12:12:44 +0100 (CET)
> Johannes Schindelin wrote:
> > On Fri, 10 Dec 2021, Takashi Yano wrote:
> > > Could you please test if the following patch solves the issue?
> > 
> > It does!
> 
> It seems that you already apply this patch to msys2, however,
> this is just an experimental patch to identify the cause of
> the problem.
> 
> Please wait a while for actual patch.

I submitted the patch to cygwin-patches@cygwin.com yesterday.

[PATCH] Cygwin: pty: Add missing input transfer when switch_to_pcon_in state.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
