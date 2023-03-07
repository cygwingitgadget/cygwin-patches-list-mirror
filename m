Return-Path: <SRS0=/Ih6=67=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
	by sourceware.org (Postfix) with ESMTPS id 38AE03858C66
	for <cygwin-patches@cygwin.com>; Tue,  7 Mar 2023 03:30:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 38AE03858C66
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-05.nifty.com with ESMTP id 3273U6sn010998;
	Tue, 7 Mar 2023 12:30:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 3273U6sn010998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1678159806;
	bh=dWaoIYq3oDrp9jdUfUdEES6qW2LMIlQgoqVJh/mpoeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ztcao5C2eOc9xZKckoL0E7DZ3QwOxa659ED3UtV0eoqk0/tXx0QeDMte4casHeJ74
	 RN0q4dvGxsxQFFJVJ1VSRM7rRnhY+ibFhM0ZipEZQnjQJTgr+Eox5YRKyogPSuOekY
	 DyF7uSHqvdjamXxKm4cB7n706wbW9g3aAJtbllmKfQZHL8vSpZgCGv8bv9gWyj8Xm7
	 QCtb3/95Il5WFcnKqRUSRK0gubDo0Bpz0+sGV5+6Y2N9MtYLWHcxYWauvcyoj+LCbp
	 ZglwLRje2sXtchshOlsCfvjGlAtvyfpckegoyt1Nw7ujfNa5rInjGoXZWbJ+Tdi0tO
	 KEPNpQfOBlBVg==
X-Nifty-SrcIP: [220.150.135.41]
Date: Tue, 7 Mar 2023 12:30:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
Cc: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] [PATCH] Cygwin: ctty: Replace ctty constant with
 more descriptive macros.
Message-Id: <20230307123006.17e133d2bc274354f965badb@nifty.ne.jp>
In-Reply-To: <DM8PR09MB7095179671A47284BE556204A5B79@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20230307023316.1190-1-takashi.yano@nifty.ne.jp>
	<DM8PR09MB7095179671A47284BE556204A5B79@DM8PR09MB7095.namprd09.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 7 Mar 2023 02:42:49 +0000
"Lavrentiev, Anton (NIH/NLM/NCBI) [C]" wrote:

> Can't help but notice that these two lines are not exactly logically equivalent:
>  format_process_ctty (void *data, char *&destbuf)
>  {
>    _pinfo *p = (_pinfo *) data;
> -  if (p->ctty < 0)
> +  if (!CTTY_IS_VALID (p->ctty))
> 
> And here as well:
> 
> {
>    if (str == NULL)
>      str = _my_tls.locals.ttybuf;
> -  if (myself->ctty < 0)
> +  if (!CTTY_IS_VALID (myself->ctty))

Thanks.
You are right, however, ctty value 0 is never used, so no problem I think.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
