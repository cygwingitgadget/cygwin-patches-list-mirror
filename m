Return-Path: <cygwin-patches-return-9988-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122917 invoked by alias); 23 Jan 2020 14:00:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122763 invoked by uid 89); 23 Jan 2020 14:00:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 14:00:26 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id 00NE0CAv031459	for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 23:00:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 00NE0CAv031459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579788012;	bh=g4Zuh9JXcGTJpQVoUORTtMlE5NHmjoAaLQjYiTTES50=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=2LuoL1cDh1FEiF4y8cHP31pZ8qZmaw6dSBTBnqfTr0KGcQ6qCfoN+Del9XVMTNbni	 bUcjKcn/rV37x6yBjXehD02b+nkOc4tqMFkknRssr7rtMAnmp9/09gX9VMfvkyjEto	 IpN3qw5RXTOOvyR8vLh/UShpnT0xCZ7j67xRd6uOVEfVNwKYYj7LmaPQzlQ93jA5Zs	 xY2kA4WZ+i98wR3MMEF3bFTRzXyvnbSLBQuqMv1Uqoy+6nxqJE2Z91QqrMKVXIzpc5	 cGROTzndsBkkqr3oxbIR4bFjD+dN/xn3KFxiYGhl5/HbnYuZ4hcKOpe658Ro0S6zv6	 WVziG+BXS3FIQ==
Date: Thu, 23 Jan 2020 14:00:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
Message-Id: <20200123230027.4d1bb55023f7b75c3655fced@nifty.ne.jp>
In-Reply-To: <CAFLRLk_XGNXX+ot4+CTRsQ_mPRhJgcK9MKEzv3MtGvQR550fcA@mail.gmail.com>
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp>	<20200123043007.1364-1-takashi.yano@nifty.ne.jp>	<20200123125154.GD263143@calimero.vinschen.de>	<CAFLRLk_XGNXX+ot4+CTRsQ_mPRhJgcK9MKEzv3MtGvQR550fcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00094.txt

On Thu, 23 Jan 2020 21:39:50 +0800
Koichi Murase wrote:
>       0 [main] XXXX (YYYY) shared_info::initialize: size of shared
>       memory region changed from 50104 to 49080

Is there any process alived using diffrent version of cygwin1.dll?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
