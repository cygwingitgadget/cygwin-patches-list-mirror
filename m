Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id BD7F2385840C
 for <cygwin-patches@cygwin.com>; Mon, 13 Dec 2021 12:34:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org BD7F2385840C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (v050141.dynamic.ppp.asahi-net.or.jp
 [124.155.50.141]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 1BDCXU1L018577
 for <cygwin-patches@cygwin.com>; Mon, 13 Dec 2021 21:33:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1BDCXU1L018577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639398810;
 bh=l3kNt27aHUgsLb9e7Isjb51Ve42kS2qpWA+RqK5lcIs=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=EvvToM11XbN+ECqNuRv93TdW4LlfeYLmvmM9KKyZJp0ByAMg9nezk/uFC1CMLJVGQ
 uJHVSuETs7PPTNaFK8OGq7egaF02lxsPwnuzN/OxV6Re9XjkJGLQBh3mf8Rthaa6mH
 6BAgbMUt7L2LUkLWwzGTVy8OucZMujR2vLEADpW0oNNQaCBKA2xMln7hhZ+Qn6Fefx
 +WTyl6xDHhwflpJtWMowjDeOB+5qaSYMAhpFlkvIdxewBd7yyXsVpNoNdmBho31wQf
 yzITvFvadL7eVDXQhfcTgUP5nB1EhXNwtd6piaocnTZVBfS8/Is3FsnrQlE4vIBNbY
 CkqBdc15vi+mw==
X-Nifty-SrcIP: [124.155.50.141]
Date: Mon, 13 Dec 2021 21:33:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Reduce unecessary input transfer.
Message-Id: <20211213213331.1c6ab616264b2354bd47f5b8@nifty.ne.jp>
In-Reply-To: <20211213180935.58cc9cf6324d97f12e960b09@nifty.ne.jp>
References: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet>
 <20211210192040.71f88b263b8c20f2f61db310@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2112101152320.90@tvgsbejvaqbjf.bet>
 <20211211224030.bf6dc202f01bdd2f4eff32d9@nifty.ne.jp>
 <20211213180935.58cc9cf6324d97f12e960b09@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 13 Dec 2021 12:34:09 -0000

On Mon, 13 Dec 2021 18:09:35 +0900
Takashi Yano wrote:
> On Sat, 11 Dec 2021 22:40:30 +0900
> Takashi Yano wrote:
> > On Fri, 10 Dec 2021 12:12:44 +0100 (CET)
> > Johannes Schindelin wrote:
> > > On Fri, 10 Dec 2021, Takashi Yano wrote:
> > > > Could you please test if the following patch solves the issue?
> > > 
> > > It does!
> > 
> > It seems that you already apply this patch to msys2, however,
> > this is just an experimental patch to identify the cause of
> > the problem.
> > 
> > Please wait a while for actual patch.
> 
> I submitted the patch to cygwin-patches@cygwin.com yesterday.
> 
> [PATCH] Cygwin: pty: Add missing input transfer when switch_to_pcon_in state.

Sorry, this has a problem with pseudo console enabled.
I will submit additional patch for that shortly.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
