Return-Path: <cygwin-patches-return-9113-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31873 invoked by alias); 5 Jul 2018 23:13:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31855 invoked by uid 89); 5 Jul 2018 23:13:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=died
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Jul 2018 23:12:59 +0000
Received: from Express5800-S70 (ntsitm315127.sitm.nt.ngn.ppp.infoweb.ne.jp [125.3.30.127]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id w65NCPKT020825;	Fri, 6 Jul 2018 08:12:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w65NCPKT020825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1530832346;	bh=mCTmwTEnsaGgcpP2XEmr7JyhrTvEIp2oqh1DZ2PurDg=;	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;	b=SQ4bIbuLSPxFC5Bl+ULmily9nvBRXgUAF8AlXtNQuH8GYNnFQefRR9OJbkPVkC2wj	 4xmJ/l5U8p9+pPSZKELFzObTo9TCOz5NOHSqSi1n7y+rrzZXf+DXGx1S6N4EbZIP7o	 /pt+86rvEUSTf3BUv40fwXum8UKSx1sAGtMuRCYs5zlAqMTiECwO9ffkuQk1nWLdEc	 aFVZcytHIbPov3XElCKVaWYbD3CUlAqAEbY8RqquA8OFdNPlqUoKWCbwo0eBn6EZWp	 hgtXpuTF/MF7a5/9KLtuhyd0/uoSqw1igJqGgeOItr7LjAmCoCeK0ZsyQFvu3guvyg	 r5c6XYhXnJQiQ==
Date: Thu, 05 Jul 2018 23:13:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: Why /dev/kmsg was deleted from cygwin1.dll in git?
Message-Id: <20180706081228.0d4da340f67b3d171510675e@nifty.ne.jp>
In-Reply-To: <542e03d3-b4ee-18b1-7ab5-2b28e37aed17@SystematicSw.ab.ca>
References: <20180704044424.813ee03eff360d6bcb58446b@nifty.ne.jp>	<20180704105420.GN3111@calimero.vinschen.de>	<20180704220138.26b42dc96fb1b49a9dc693d2@nifty.ne.jp>	<20180704145247.GS3111@calimero.vinschen.de>	<20180706002924.1b29830bd08668a067509508@nifty.ne.jp>	<542e03d3-b4ee-18b1-7ab5-2b28e37aed17@SystematicSw.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00008.txt.bz2

Hi Brian,

On Thu, 5 Jul 2018 12:38:08 -0600
Brian Inglis wrote:
> Isn't this moot as the supported package is syslog-ng, which seems to work okay?

Not only inetutils syslogd but also syslog-ng does not work in cygwin
git HEAD. I confirmed syslog-ng gets back working with the patch I posted.

Moreover, syslog-ng does not remove /dev/log even after exiting normally.
This means my first patch removing the code may cause the problem below.

On Fri, 6 Jul 2018 00:29:24 +0900
Takashi Yano wrote:
> On Wed, 4 Jul 2018 16:52:47 +0200
> Corinna Vinschen wrote:
> > What the code does is to check if we have a listener on the /dev/msg UDP
> > socket, otherwise log data may get lost or, IIRC, the syslog call may
> > even hang.  So removing this code sounds like a bad idea.
...
> usual case, no problem happens. However if syslogd is killed by signal
> 9 or died accidently, /dev/log remains without listener. In this case,
> the problem you mentioned may happen.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
