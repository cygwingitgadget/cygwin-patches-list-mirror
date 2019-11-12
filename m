Return-Path: <cygwin-patches-return-9831-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74276 invoked by alias); 12 Nov 2019 12:58:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 74267 invoked by uid 89); 12 Nov 2019 12:58:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 12 Nov 2019 12:58:41 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id xACCwTdE000497	for <cygwin-patches@cygwin.com>; Tue, 12 Nov 2019 21:58:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xACCwTdE000497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573563509;	bh=3d+WtlhtV6I1V8/xyrK7q6djpbaQ81sAfFq/PIuWP8o=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=pwghx3egs8MF2+DXQaJ50Rz4HjJHhlPZSo+wqCYEaBER77H9KTSqKbwWnZ0t3TbGE	 WlzcfbkigoypwcEsn6s04LUdrXgNo+LOPWbXx5gUemO2GinmJDp1VbWmH9j8bnEsdb	 vEUtm6pdaJyetulBt5Akb3H0FugwQ6D3jlUbmVHcdFXX6tcLPZ0D+JvETAu3CQLCZk	 3Vs0Sgq1pkuAn+3OyQBRxHhKCZgE6exmGpoQ1NoTeTZhxiOPQAj3Ij97MRdeOEF4Qr	 +4gHG1evObGcX5P9+DXpu7lcpBUX88GBFvUH5vUct541+lmytc7XugNtiHCxtaWQSD	 2r8TP/tcbdyCA==
Date: Tue, 12 Nov 2019 12:58:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191112215838.459efd392c64b3c8190f3493@nifty.ne.jp>
In-Reply-To: <fa81169e-c539-dbde-bdac-61d7b22ae842@ssi-schaefer.com>
References: <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp>	<20191022134048.GP16240@calimero.vinschen.de>	<20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp>	<20191023120542.GA16240@calimero.vinschen.de>	<20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp>	<20191024093817.GD16240@calimero.vinschen.de>	<20191024191724.f44a44745f16f78595ae1b43@nifty.ne.jp>	<20191024133305.GF16240@calimero.vinschen.de>	<20191108110955.GC3372@calimero.vinschen.de>	<20191108224232.c58ba683250a438a44e15e56@nifty.ne.jp>	<20191111091755.GF3372@calimero.vinschen.de>	<fa81169e-c539-dbde-bdac-61d7b22ae842@ssi-schaefer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00102.txt.bz2

Hi Corinna and Michael,

On Mon, 11 Nov 2019 11:04:54 +0100
Michael Haubenwallner wrote:
> On 11/11/19 10:17 AM, Corinna Vinschen wrote:
> > I tested it and I think this is a great step forward.  Dropping
> > $TERM checks and clear screen sequence is the way to go!
> 
> I second that!

Thanks for testing. I will submit this patch since you like it.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
