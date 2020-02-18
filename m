Return-Path: <cygwin-patches-return-10081-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56997 invoked by alias); 18 Feb 2020 04:08:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56987 invoked by uid 89); 18 Feb 2020 04:08:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Feb 2020 04:08:56 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id 01I48WE5013188	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2020 13:08:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 01I48WE5013188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581998912;	bh=JM3ypz3YLyKptexcGQj8Pn3oCaoSndpjCBRDTcosMpo=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=WPd2YY/dN6yldC+jaJ3UYYNE+EbyTHfx57q3RfaGifhiTBMY08UfY9aCsWxrLAJei	 DQ7CreWbLeBwWNeJcQ3bdOZaUdwovZdGe7KJvU/24LTHrkl7ZrQie8K15rhm0osDhZ	 7zTCSxW+LUNCYKG5fDZzNWB2t73s87+iS3mITmw9RoOoov94GFph6JUBfogSBQeMXm	 QkRZ0YgNIVGZVzJM0/6GTD4ZOWX1WNw4ADxwLzZG3g7jgGkespmgYhcM30q/gTEQxk	 3PdrswbmLhdtz7o7ADT9oBtMEm7LggpdNGaqPeyoDCx7s6fVPIp4eshDdF0aglLQkZ	 LdHpUa7h97H+w==
Date: Tue, 18 Feb 2020 04:08:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Change timing of set/unset xterm compatible mode.
Message-Id: <20200218130846.b740d6e302082d034437fd2b@nifty.ne.jp>
In-Reply-To: <20200217184545.43be636858734d029f2f5a11@nifty.ne.jp>
References: <20200216081322.1183-1-takashi.yano@nifty.ne.jp>	<20200217090015.GB4092@calimero.vinschen.de>	<20200217184545.43be636858734d029f2f5a11@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00187.txt

Hi Corinna,

On Mon, 17 Feb 2020 18:45:45 +0900
Takashi Yano wrote:
> On Mon, 17 Feb 2020 10:28:19 +0100
> Corinna Vinschen wrote:
> > On second thought, also consider that switching the mode and
> > reading/writing is not atomic.  You'd either have to add locking, or you
> > may suffer the same problem on unfortunate task switching.
> 
> Hmm, it may be. Let me consider. It may need time, so please
> go ahead for 3.1.3.

I have submitted a patch for this issue. Could you please
have a look?

I also submitted a patch for ioctl() FIONREAD in console.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
