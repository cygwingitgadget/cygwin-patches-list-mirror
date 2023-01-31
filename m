Return-Path: <SRS0=s/Q1=54=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
	by sourceware.org (Postfix) with ESMTPS id 8EE913858D28
	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023 11:21:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8EE913858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-01.nifty.com with ESMTP id 30VBKoxZ022224
	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023 20:20:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 30VBKoxZ022224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1675164050;
	bh=aw0KH4/72UMZAAMgcOnxujyTPpa4vYkmuuUu9B73hKo=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=kdI9xDFAIBP0PlEE0Rxo728MsQk6xuvKsSVOW07NlUjnxdJXMctaZrmvTBv6ZCUBT
	 WcwfODULn0oPzdjuyr0LtNa5Wccqg0fcMpcae0qgNGLXj7ZWwP1SLkD5z8X7ggFO35
	 XggYRr09PfTA1ua4gh09ftmhBj05AoujCJ7hev1ZPg8isdOzpWBjJMszm6k1GkX4Ui
	 +W7M3edKTTRQ7cfgM/+e+2CRhnlH8RufdjW1ww/S2FwbjVhPKQFI+XAGMY3TEdP/VT
	 YI/2ObIG2CFu2TsnUK2C4tv+57iugIiFGZo+6z4YVclK0pMmWbtQyE6Ptk5qUqMQ01
	 aiwMETxuI4XfA==
X-Nifty-SrcIP: [220.150.135.41]
Date: Tue, 31 Jan 2023 20:20:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dsp: Implement SNDCTL_DSP_SETFRAGMENT ioctl().
Message-Id: <20230131202049.d5da058b1865fbe9fda95a8f@nifty.ne.jp>
In-Reply-To: <Y9jfSM8nB6Z+eT3O@calimero.vinschen.de>
References: <20230130130916.47489-1-takashi.yano@nifty.ne.jp>
	<Y9jfSM8nB6Z+eT3O@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 31 Jan 2023 10:28:40 +0100
Corinna Vinschen wrote:
> On Jan 30 22:09, Takashi Yano wrote:
> > Previously, SNDCTL_DSP_SETFRAGMENT was just a fake. In this patch,
> > it has been implemented to allow latency control in some apps.
> > 
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/dsp.cc           | 78 ++++++++++++-------------
> >  winsup/cygwin/local_includes/fhandler.h |  3 +
> >  2 files changed, 42 insertions(+), 39 deletions(-)
> 
> LGTM.  Given how much I *don't* use the audio stuff in Cygwin,
> would you just like to take over maintainership for this code?

BTW, should this pach be applied only for master branch?
What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
