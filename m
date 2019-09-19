Return-Path: <cygwin-patches-return-9703-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38523 invoked by alias); 19 Sep 2019 12:05:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38514 invoked by uid 89); 19 Sep 2019 12:05:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=divided
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Sep 2019 12:05:47 +0000
Received: from Express5800-S70 (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id x8JC5PRs014684	for <cygwin-patches@cygwin.com>; Thu, 19 Sep 2019 21:05:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x8JC5PRs014684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568894725;	bh=xHFR5uoQw503Nt3ocU0DAJ4FQmuftfjHjhFet+L0B7A=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=2EUHTpimC6h6eHkZVAqa7tf31XIiWJrJEDdKlPG+lKCcOO+zxZ50Yw0LNiGxY7DVK	 cEuCnxNdNoJ6JfyLwIrd8UKv5JxdoUg8TWAKWYaMG/GbamZDIaEr43JV1UsLiPdIio	 Gq91usl25QAxi6kYTBTfNnaBINlKLGnh/dClkEkiMAePXf78AQv+yma2XizoIdmyd1	 WD8W2sjlDeWzPbztoLPRzpX2BlBWXZXm4roIoVJ3bHkMc7LZ/iko9Herdsk67fCnXi	 YD+6WYCvtM70Z7zutCjgcdPuny+b2QpT6AhjXiQtP78wAlpjobaLK0y0jFfaUB3sNa	 dA7z6NXneIKCQ==
Date: Thu, 19 Sep 2019 12:05:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/1] Cygwin: console: Revive Win7 compatibility.
Message-Id: <20190919210534.89ec0eda071132bb0c66ba20@nifty.ne.jp>
In-Reply-To: <7aa9ec47cbde83bcd4c618433a98275f16ace6f6.camel@redhat.com>
References: <20190918204955.2131-1-takashi.yano@nifty.ne.jp>	<20190918204955.2131-2-takashi.yano@nifty.ne.jp>	<7aa9ec47cbde83bcd4c618433a98275f16ace6f6.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00223.txt.bz2

On Wed, 18 Sep 2019 17:31:30 -0400
Yaakov Selkowitz wrote:
> Would it make sense to define this using wincap so it is 2048 for
> Win7/2K8 and 3276 for newer versions?

Thanks for advice. Of cource it is possible, however, I don't think
it is necessary. IMHO, the buffer size of 2048 is more than enough
for console keyboard input. Even if the number of records exceeds
2048, call of process_input_message() will be divided into several
transactions without loss of data. Previously, process_input_message()
was called byte by byte, so the current implementation is much better
than that even with the buffer whose depth is 2048.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
