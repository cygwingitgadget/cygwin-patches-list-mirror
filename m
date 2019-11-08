Return-Path: <cygwin-patches-return-9817-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55092 invoked by alias); 8 Nov 2019 12:01:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55082 invoked by uid 89); 8 Nov 2019 12:01:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:473
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Nov 2019 12:01:39 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id xA8C1KMA008428	for <cygwin-patches@cygwin.com>; Fri, 8 Nov 2019 21:01:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com xA8C1KMA008428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573214481;	bh=nw9taPaGfaKn2LAjq56IGa8de8bViAq3Pii+eYHa6z0=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=WlJVpoEyrN+C9fty6FVtO7y+hEZ2GjD/5mY9x7ADe6Mw02Waybah/8wqqNPzosBZ4	 I5eLi+FdN5Gqyr79Kk48dr9t4C2+Vgz6sDbH4a5c6DA0k4cm0SF1PKA6zj+xWEmDVu	 R0tQorR+rLQNv0W+vxbGNNdVvzjnqSzilxMTs/l8ciMgJ1kDPwW12k8Wi7k+ttS6tH	 2iu1y8OaQnrI2waRLkwzEnpMeZiXCbzkTTACu++TOsK963cbpCYuxub4acur6BNwt9	 Ny+SpMtdTX2ivPL8UWaOQdcfqmh+CggEtFasCr/EjRiVcLJaeatEd6xPRsOli3gsIc	 Dk1qzpzHcB4xQ==
Date: Fri, 08 Nov 2019 12:01:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console, pty: Prevent error in legacy console mode.
Message-Id: <20191108210131.4f7cce83de5a957e97e8aa1f@nifty.ne.jp>
In-Reply-To: <20191108092230.GY3372@calimero.vinschen.de>
References: <20191106162929.739-1-takashi.yano@nifty.ne.jp>	<20191108092230.GY3372@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00088.txt.bz2

Hi Corinna,

On Fri, 8 Nov 2019 10:22:30 +0100
Corinna Vinschen wrote:
> Pushed, albeit I'm still missing a bit of description here.  Just a one
> liner is a bit low on info during `git log'.  I'd really appreciate more
> descriptive log messages...

Oh! Does "log message" mean git commit message? I misundersood that
it meant strace log message. Sorry.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
