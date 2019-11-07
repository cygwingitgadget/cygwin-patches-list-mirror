Return-Path: <cygwin-patches-return-9811-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1022 invoked by alias); 7 Nov 2019 00:48:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 911 invoked by uid 89); 7 Nov 2019 00:48:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:69a4bcd, H*i:sk:69a4bcd, preview, H*MI:sk:69a4bcd
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 07 Nov 2019 00:48:43 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id xA70mHwI006809;	Thu, 7 Nov 2019 09:48:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com xA70mHwI006809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573087698;	bh=p3t0J3veZU8+pRRbOydhjpihfBZJAtjfBchIPTDP9k0=;	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;	b=gTEU3aqZunAx4Vu7vWKnH5ZvUpzc7OKfeaQoVGiejIZR9nJ++Qb8Pc2vTLXmr8kFn	 OH6HTinbfRT0BiCJLTgtRZThZJhSWtMAH4aK13otllKtE7WWS5bm8ehWhimcMSecGO	 JsYCU83y47hq831LFCNgit3vLPSb4EQeGxrNlwXCWrs6ceMop/vHg4fbKClS1OHoOr	 w9wceCey8vooMJATAiMR11Xj7+g3S+TgPqxpayCYo/FfhqUwwHyQ3V0ebr1WRbVH0X	 1JN2+raaH8aNdgYU4HSxTcwQq53EMo2KBuyuXYxsEyamXIcbvKU1SxEk+HJDuy29D1	 j3lyeiG7Eecmg==
Date: Thu, 07 Nov 2019 00:48:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Cygwin: console, pty: Prevent error in legacy console mode.
Message-Id: <20191107094824.45ae476b459ee825f59154ef@nifty.ne.jp>
In-Reply-To: <69a4bcdb-6ae2-7772-d940-c304fd7d7c81@SystematicSw.ab.ca>
References: <20191106115909.429-1-takashi.yano@nifty.ne.jp>	<70126295-3dc8-7d1c-75ba-e5d60fe60b3e@SystematicSw.ab.ca>	<20191107004406.00ffd699bed4c625f2ffde0b@nifty.ne.jp>	<69a4bcdb-6ae2-7772-d940-c304fd7d7c81@SystematicSw.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00082.txt.bz2

On Wed, 6 Nov 2019 09:37:11 -0700
Brian Inglis wrote:
> Is this not executed on every object creation and on every fork?

No. It is executed only in the first console object.

> If that is not the case, then legacy_console/() should be a singleton
> object/method, constructed when accessed, or in wincap, like
> has_con_24bit_colors() - is_con_legacy().

con.is_legacy is in shared_console_info which is shared among
console instances for identical console.

> When user explicitly sets TERM before starting Cygwin, or after forking, Cygwin
> does not touch it, so you should not, and perhaps the legacy console check
> should be added there:
> 
> newlib-cygwin/winsup/doc/setup-env.xml:
> <para>
> The <envar>TERM</envar> environment variable specifies your terminal
> type.  It is automatically set to <literal>cygwin</literal> if you have
> not set it to something else.
> </para>
> 
> newlib-cygwin/winsup/cygwin/environ.cc:
>    /* If console has 24 bit color capability, TERM=xterm-256color,
>       otherwise, TERM=cygwin */
>    if (!sawTERM)
> -    envp[i++] = strdup (wincap.has_con_24bit_colors () ? xterm : cygterm);
> +    envp[i++] = strdup (wincap.has_con_24bit_colors () &&
> !wincap.is_con_legacy() ? xterm : cygterm);

In command prompt, the new feature is disabled if legacy
console mode is enabled. However, it is still enabled in
windows terminal (preview) even if legacy console mode is
enabled.

So the code I posted checks the availability by return
value of SetConsoleMode(). This needs handle to console.
Therefore, the check can not be done in wincap.

I revised the code so that TERM is set only if it was
not set when cygwin was started. Please look at v3 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
