Return-Path: <cygwin-patches-return-10172-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130733 invoked by alias); 4 Mar 2020 01:49:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130724 invoked by uid 89); 4 Mar 2020 01:49:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Mar 2020 01:49:01 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id 0241mur8023311	for <cygwin-patches@cygwin.com>; Wed, 4 Mar 2020 10:48:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 0241mur8023311
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583286536;	bh=mOZ41fD/QsEGdeQsn+7vwbJun9sQhztxOnLFV7KN7Vo=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=AAvCdMl8c61Jn0GEMebQhyoGwryV2V+nyHNATbITh7X3GEtW7HjiIpbGP66JuqAG5	 GSyCLo9BcSHvkUNvL+ZJu4Dnm3tHvxfCD1QyZEoIKOxjezdvlJtQrdydrbP75XXtQ4	 EfJsUsgPQyl7fABxGEykZirLDWbK8jw98o9X4Kk6pRGLqvnCtoCpwBYZPwHHS1t+MZ	 UNYzvIWMC8LEYYt2rebg9Lx0TdTLp+2bbZofqr6bBuMkiahSMN1bWdDnSYXvJKtHW3	 Usz1MK098xoknswEc8MjOLXiMBgsCHVo8Uvesqs3PV6MUkSD0T5e5EDDCtl7OHJv0L	 3wtkA0xGsWe0w==
Date: Wed, 04 Mar 2020 01:49:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Collect handling of wpixput and wpbuf into a helper class.
Message-Id: <20200304104858.123db5286f1112cef986a2f4@nifty.ne.jp>
In-Reply-To: <a4ff7dc0-0e14-28f8-373c-34ab221524ec@t-online.de>
References: <877f246b-08c2-6ccd-faac-6c90661212e5@t-online.de>	<20200303093535.f27696d9250af844c0eaec52@nifty.ne.jp>	<a4ff7dc0-0e14-28f8-373c-34ab221524ec@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00278.txt

On Tue, 3 Mar 2020 21:03:38 +0100
Hans-Bernhard Bröker wrote:
> OTOH the MS documentation calls this DWORD* an "optional output" 
> argument.  If I'm reading that right, it means it should be fine to just 
> pass NULL to indicate that we don't need it:
> 
> inline void sendOut (HANDLE &handle)
> {
>    WriteConsoleA (handle, buf, ixput, 0, 0);
> }
> 
> The same would apply to all the other calls of WriteConsoleA, it seems.

Yeah, it could be. However, please note that it should be
saparate patch if you remove wn from WriteConsoleA() other
than wpbuf related.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
