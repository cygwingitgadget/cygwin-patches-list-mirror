Return-Path: <SRS0=s/Q1=54=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
	by sourceware.org (Postfix) with ESMTPS id 71CBB3858D28
	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023 11:18:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 71CBB3858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id 30VBIVnY027778
	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2023 20:18:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 30VBIVnY027778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1675163911;
	bh=CFQGeQoGP0oxkTRYU82Z9uG/1yU82xdWoPsuH/DntA8=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=whBDCOnKzsPk4i4d4W1icOfeHVlfGBe4T8v6nRvLloajEeVQ1Uok+uq9ZdDW7gAJQ
	 L7GNL5OwAUaVkk83KnO6vmShxqSwQUP+JG+FUessqsfbiOXI2i5PubPNxQoWAO60Vj
	 5kFMI6Ox+nGQz34a3Udsh65i37xkGUN9Xw8hjL0jjNcXQZ3ZNNEepsiBZZLaVJblNa
	 VFad+ySxoe2CSv32zseHMQRk80okCg5zSz/NFIuPONgVTwk0YKWfTkE+cayG2L5oKK
	 TMFFPe76zIZ3ySSUjY1bl5XaslQEVEOEDVnqUZTUVI1x6Xk0Da1hzaisMFR21YTh8o
	 NwNHouhYldLFg==
X-Nifty-SrcIP: [220.150.135.41]
Date: Tue, 31 Jan 2023 20:18:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dsp: Implement SNDCTL_DSP_SETFRAGMENT ioctl().
Message-Id: <20230131201830.e558ac83a4b0ab3f5cdd4914@nifty.ne.jp>
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
> LGTM.  Given how much I *don't* use the audio stuff in Cygwin,
> would you just like to take over maintainership for this code?

Thanks. I could take care of it if you don't mind?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
