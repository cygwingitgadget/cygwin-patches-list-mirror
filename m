Return-Path: <cygwin-patches-return-10064-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127340 invoked by alias); 10 Feb 2020 15:41:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127331 invoked by uid 89); 10 Feb 2020 15:41:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 15:41:21 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id 01AFfBdD004209	for <cygwin-patches@cygwin.com>; Tue, 11 Feb 2020 00:41:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 01AFfBdD004209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581349272;	bh=5e48/zgHSp+O7w5Eb8BpjOPgXeXP/hRrRwNR8ViAMYU=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=nOVOtbE94PmUerw7RcNNSAquOYL9kgBmIbQMtcYaJDB5NnC0+NaG3eQVeOhc1hfHu	 Up12tMSwkwMqFhtijrQiziOcOfmAMCdo3iHqaRS7CKOn0VHq+ptq10r9M/D+NT1qKG	 W/teZ6r4uIsEfGJUxG/p59L2iQaaNTkrMCX5yy9RNsT33bP8Ixxt8E95z0S+SBUSvA	 /sYMPOxrZXaalmEzJMPx3F5A0x7mjIQ1gsQ1Z5WChug6SNr6XdV13cP8yhqOaY99kj	 mffbkE4h6wqE0CENAEuuRVULDVzueGcCKwZzSEhMfDwbIoXjX2jm/c8fGBru7dPzYY	 RE//m06Wfkh8A==
Date: Mon, 10 Feb 2020 15:41:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add error handling in setup_pseudoconsoe().
Message-Id: <20200211004122.174bfa21eb814c286de43c91@nifty.ne.jp>
In-Reply-To: <20200210151214.39-1-takashi.yano@nifty.ne.jp>
References: <20200210151214.39-1-takashi.yano@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00170.txt

[PATCH] Cygwin: pty: Add error handling in setup_pseudoconsoe().

s/pseudoconsoe/pseudoconsole/
