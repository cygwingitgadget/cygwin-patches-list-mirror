Return-Path: <cygwin-patches-return-9682-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21915 invoked by alias); 15 Sep 2019 04:18:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21906 invoked by uid 89); 15 Sep 2019 04:18:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:518, H*i:sk:929c430, H*f:sk:929c430
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 04:18:21 +0000
Received: from Express5800-S70 (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id x8F4IDuc009916	for <cygwin-patches@cygwin.com>; Sun, 15 Sep 2019 13:18:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x8F4IDuc009916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568521093;	bh=ddX7cc43DgSTbNLdplg18hAJgWSs0PAxv1XYzYUgw50=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=fxm2o+3ttPUdVn2lvNDBiPweJg9IsZoaeLO46CknNladlqrEksQWtTcIvX4hyf20G	 t5pn/S7Lj5IQDWQiBSW6mliCuKVYnjBg81ioigoBalDX32nRSXUPkCd/kHzWf8AhqZ	 NXhwfJ5amaifisXCwv+toaxgH2BCWWf/aB34/6BXPbhS+8gIeFYKgc510YyXSIJssW	 hEHy8MhjFBum05BEkGtfzmJ5tRc2rnWcTcrBLh4zXlxA6ak85F+vzo+JRLb4W9xHhA	 OwxI22ieaz7uB5rtsAP/kGjlyy37S0s1VTp+aHo5CeOO+4vdq9I/yUr25+/C//lz6q	 /CJrCaNgFpkUQ==
Date: Sun, 15 Sep 2019 04:18:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Message-Id: <20190915131822.2f2ebc1d117aa040ddbbf65e@nifty.ne.jp>
In-Reply-To: <929c430c-b6bf-148c-34e5-a784101c425c@cornell.edu>
References: <20190906145200.802-1-takashi.yano@nifty.ne.jp>	<3cf7455c-25b6-5c97-3cdb-d68590e44d8f@cornell.edu>	<20190914065234.21c01267db0e0eb3f1347ff2@nifty.ne.jp>	<929c430c-b6bf-148c-34e5-a784101c425c@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00202.txt.bz2

On Sat, 14 Sep 2019 15:29:50 +0000
Ken Brown wrote:
> All pushed.  Thanks.

Thanks.

> Do you think there have been enough changes that I should issue another test 
> release, or do you have more patches in the works?

I have submitted three more patches just now. Hopefully, the functional
fixes have been settled with these patches, so I think it is ready to
issue a new test release.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
