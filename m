Return-Path: <cygwin-patches-return-9669-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81521 invoked by alias); 13 Sep 2019 19:34:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81511 invoked by uid 89); 13 Sep 2019 19:34:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Sep 2019 19:34:53 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x8DJYjl1018527;	Sat, 14 Sep 2019 04:34:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x8DJYjl1018527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568403290;	bh=VaXqNOy8Cyr7Ii9wp4r5B0cjtvgVuEMd546luZ1Y/hg=;	h=From:To:Cc:Subject:Date:From;	b=L9zeNH7y2DDSdmsdvWkt4nGw3ZU7c94X4zZdrwqRQqwPUy+b08m7bp+K5Xr0Vl+3O	 NDDz2dR5hjpXmtsiGtelCS6jD1Ai6oP5VnGlac/SUDtKsSsAU2LZsLhweB7W4FTXx7	 cUsNiVtYFu2D9XRWCTM+y9ICWPU1B/72bVWjz7RrcQRP9ctojXSfrmHEnuWtO1W5FR	 6fzQH5q+E6vJDKBN0ZhHpU3vmXdOVxfUp+IBF+HTb0p3+UO6921g85eBv6C3mK5Vie	 hQFLx69JxOt/yhumiqEa/9mBal74nnUdgLI7GfdYaS6LJV8kuI4kh0R4BhEpT83eGa	 ojDNLjYjgKAEQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: console: Fix read() in non-canonical mode.
Date: Fri, 13 Sep 2019 19:34:00 -0000
Message-Id: <20190913193439.1566-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00189.txt.bz2

- In non-canonical mode, cygwin console returned only one character
  even if several keys are typed before read() called. This patch
  fixes this behaviour.

Takashi Yano (1):
  Cygwin: console: Fix read() in non-canonical mode.

 winsup/cygwin/fhandler_console.cc | 606 ++++++++++++++++--------------
 1 file changed, 315 insertions(+), 291 deletions(-)

-- 
2.21.0
