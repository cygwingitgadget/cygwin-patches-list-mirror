Return-Path: <cygwin-patches-return-10083-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8286 invoked by alias); 18 Feb 2020 09:17:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3901 invoked by uid 89); 18 Feb 2020 09:17:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Feb 2020 09:17:43 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id 01I9HOp8029820	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2020 18:17:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 01I9HOp8029820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582017445;	bh=f2VkTPFGVE1JfXOxBsmjYWQxHEkjRTTmz+kI/CAbxjY=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=mW7rp2sSdMoTL8xKVoP56OqzFB006mlMoTpk87xMYGBrQe1FJ9xoRrosdU/MiFERu	 fG1uKqFYsJM+tpYOAwYxiUItVU2ANsc9or0SP8cn6fETv5xpx7Wm93547kzJ+xP4PO	 5MQJ0UAHGVbnOF+Kj+y+b3nL++B/9wKbuvSgkUsic5F4NivTy6SO9lR05wxbjSb0bo	 LnZc0XJCKa0c0qLLtfOSUvVs9OHfs1HPTpUEyPC5b6/zvzJ2onJAQglPP4fN3lGahV	 gR85vYtEqN3pv3nnateKaNtyuismJ8hYTCDyjbuAZddRrozpJ6JUnvcqA7/bP5G6bp	 m/SxHldQHjREQ==
Date: Tue, 18 Feb 2020 09:17:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Change timing of set/unset xterm compatible mode.
Message-Id: <20200218181727.bd933223057cb2b8f42ac918@nifty.ne.jp>
In-Reply-To: <20200218130846.b740d6e302082d034437fd2b@nifty.ne.jp>
References: <20200216081322.1183-1-takashi.yano@nifty.ne.jp>	<20200217090015.GB4092@calimero.vinschen.de>	<20200217184545.43be636858734d029f2f5a11@nifty.ne.jp>	<20200218130846.b740d6e302082d034437fd2b@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00189.txt

On Tue, 18 Feb 2020 13:08:46 +0900
Takashi Yano wrote:
> On Mon, 17 Feb 2020 18:45:45 +0900
> Takashi Yano wrote:
> > On Mon, 17 Feb 2020 10:28:19 +0100
> > Corinna Vinschen wrote:
> > > On second thought, also consider that switching the mode and
> > > reading/writing is not atomic.  You'd either have to add locking, or you
> > > may suffer the same problem on unfortunate task switching.
> > 
> > Hmm, it may be. Let me consider. It may need time, so please
> > go ahead for 3.1.3.
> 
> I have submitted a patch for this issue. Could you please
> have a look?

I have just submitted v2 patch. Could you please check this one?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
