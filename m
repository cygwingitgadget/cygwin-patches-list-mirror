Return-Path: <cygwin-patches-return-9974-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13197 invoked by alias); 22 Jan 2020 16:06:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13116 invoked by uid 89); 22 Jan 2020 16:06:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=AAAA, Revise, sk:std_out, windows.h
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 22 Jan 2020 16:06:04 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id 00MG5qrn027182	for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 01:05:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00MG5qrn027182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579709152;	bh=4DrUlmziWTbJdzLFTDVvt7GCidPCOJhb2dWHMpfBaAI=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=m5oaBo8UoaVddym+B8NjlYeqIqr1VfKSfWDLS9we/PsfPN8nc9PC9AnRcElPnYjIg	 KmfB3aBOVZdAxVYhQA+5wyP7V1xt4zPVEzrztiIwyIMJT0sDePQ2dVXKlsvCg+L2Fl	 Z5B+uAdlLKR2xapzJeC7w9yEJhLei7zIImX9odFiN8s30S18KAxMJKpCIzuAp/gJ2X	 8r2i1ysz+o+bsLzgojVuvj1PxPtOIJx/aOVE6gkgztZkJ71Zp0wdXSGINCRMW5Xj37	 bzWlP5vTabypli2XdYGEhLi9xhHEbiNAUmhBjVCHIb5jPgFHKiEfYSKLGig1mCuSk9	 B8G+TRxB6Hqnw==
Date: Wed, 22 Jan 2020 16:06:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding by master_fwd_thread.
Message-Id: <20200123010555.009fa315b3814ae24d01eafe@nifty.ne.jp>
In-Reply-To: <20200123010011.e34b6999f3e852d2b9eb4787@nifty.ne.jp>
References: <20200121111556.ceb40aa746220718b44dfb25@nifty.ne.jp>	<20200121022202.2960-1-takashi.yano@nifty.ne.jp>	<20200121093735.GN20672@calimero.vinschen.de>	<20200123010011.e34b6999f3e852d2b9eb4787@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00080.txt

On Thu, 23 Jan 2020 01:00:11 +0900
Takashi Yano wrote:
> /* Test code */
> #include <windows.h>
> #include <stdio.h>
> 
> int main()
> {
>     DWORD n;
>     printf("AAAA\n");
>     WriteConsole(GetStdHandle(STD_OUTPUT_HANDLE), "BBBB\r\n", 6, &n, 0);
>     return 0;
> }

The problem occurs when the code above is compiled as cygwin binary.
Not windows native binary. In other words, use cygwin-gcc rather than
mingw-gcc. 

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
