Return-Path: <cygwin-patches-return-9808-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16202 invoked by alias); 6 Nov 2019 15:44:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16159 invoked by uid 89); 6 Nov 2019 15:44:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1042
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 15:44:24 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id xA6Fi49O008180;	Thu, 7 Nov 2019 00:44:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com xA6Fi49O008180
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573055045;	bh=Dnt6K4KiwgUJodUTlx1kw4HefXIx67G7UXnvgTe2jxM=;	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;	b=whVQY8LHozff3HcCOqrIsnue8TXz63ajl+ZNCbmelPREIQ3WcPtliahHIU45hTN6h	 qiQyZfe20+pubOsSsBV97qX1m8+G5a27dgWoAf9IjaL04CjZDm5X5K/UT4YGOtCyRR	 qou77Pw2K23dpSJv1xLQQMePSy4VF8rql8Zxv7J1+6Vk7JaQOkuS0FPL1dmWicdoTw	 mXM9CHOFjJweQgMPDaYgYwE/EypQJWgunMczvKeeR4ieYp1nu6AVEbK9xxeSfCCh+x	 TmXtDPjEuIBxlP5fxXAb1/mQ7lF/pebIRo70jS2iwgqZDUppP9av79IR5Z8muWxkZs	 n/Rsrz1pzdRtg==
Date: Wed, 06 Nov 2019 15:44:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Cygwin: console, pty: Prevent error in legacy console mode.
Message-Id: <20191107004406.00ffd699bed4c625f2ffde0b@nifty.ne.jp>
In-Reply-To: <70126295-3dc8-7d1c-75ba-e5d60fe60b3e@SystematicSw.ab.ca>
References: <20191106115909.429-1-takashi.yano@nifty.ne.jp>	<70126295-3dc8-7d1c-75ba-e5d60fe60b3e@SystematicSw.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00079.txt.bz2

On Wed, 6 Nov 2019 08:06:55 -0700
Brian Inglis wrote:
> > +      if (con.is_legacy)
> > +	setenv ("TERM", "cygwin", 1);
> >      }
> 
> handlers should not be changing user's env vars: that is the user's selection to
> get their preferred operation in their apps.
> 
> If you need to set TERM, shouldn't you also set it appropriately for non-legacy
> console?

The environment TERM is set to cygwin or xterm-256color in environ.cc
based on wincap.has_con_24bit_colors().

However, if legacy console mode is enabled, new terminal capability
compatible with xterm is disabled. So TERM is override to cygwin by
the code above.

This is done only in the first initialization stage, so TERM value
set by user in .login, .bashrc, .tcshrc and etc, ... will be kept.

Only the case in which TERM is overrid is:
1) Enable console legacy mode.
2) Open command prompt.
3) set TERM
4) start cygwin

What situation do you assume this causes problem?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
