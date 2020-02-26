Return-Path: <cygwin-patches-return-10122-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50446 invoked by alias); 26 Feb 2020 11:12:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50437 invoked by uid 89); 26 Feb 2020 11:12:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=cygwinpatches, black
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 11:12:21 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id 01QBCA5i019430	for <cygwin-patches@cygwin.com>; Wed, 26 Feb 2020 20:12:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 01QBCA5i019430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582715530;	bh=3Do45cEhhxK7yuzayjHOjq4pXTzmIChjVgKc1v0J/kk=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=uTZG9hDpHwp/b/i1X8B3wHQOnJcwT2EL8aJcs4KwQ6hts0/emzpP1kHuI7aaxUxpV	 khBzqGwDBdeNMsHkt3MnC0+fWnevtJ/PcwACUhSp8Ktyexrd6mnI7C28oltTYPOiAW	 wC2pz+tNMJSQMODZBUDbNA8U/IiMy6NgHpWhPieta3LJBPcz92UY7uYSAyLGLR269P	 WR04GSBPDmeWT7lC27jWmMEVfNumPIRstPvLT5iN6DmiKBk/UqXrxKG9bZ7sNiY5oI	 cKAdm0FnGKfiIa/opE5MCO25OYUS6d11ttiDiTizFmqIPTwqr7cVDii9/FZetmTvhB	 wRXgg+42La3vQ==
Date: Wed, 26 Feb 2020 11:12:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-Id: <20200226201223.f84202de00a3f4ec65ceb64a@nifty.ne.jp>
In-Reply-To: <20200225171438.1243-2-takashi.yano@nifty.ne.jp>
References: <20200225171438.1243-1-takashi.yano@nifty.ne.jp>	<20200225171438.1243-2-takashi.yano@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00228.txt

Hi Corinna,

On Wed, 26 Feb 2020 02:14:37 +0900
Takashi Yano wrote:
> - Cygwin console with xterm compatible mode causes problem reported
>   in https://www.cygwin.com/ml/cygwin-patches/2020-q1/msg00212.html
>   if background/foreground colors are set to gray/black respectively
>   in Win10 1903/1909. This is caused by "CSI Ps L" (IL), "CSI Ps M"
>   (DL) and "ESC M" (RI) control sequences which are broken. This
>   patch adds a workaround for the issue. Also, workaround code for
>   "CSI3J" and "CSI?1049h/l" are unified into the codes handling
>   escape sequences above.

Hmm, this fix seems to be not enough...
Could you please wait?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
