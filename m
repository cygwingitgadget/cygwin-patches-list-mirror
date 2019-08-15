Return-Path: <cygwin-patches-return-9566-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15570 invoked by alias); 15 Aug 2019 05:02:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15561 invoked by uid 89); 15 Aug 2019 05:02:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 05:02:32 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-04.nifty.com with ESMTP id x7F52Fil006491;	Thu, 15 Aug 2019 14:02:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com x7F52Fil006491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565845341;	bh=O1+tOKY9CB8EQ/iz0tZTsWxaShOGY4FWM+qmNAcXakQ=;	h=From:To:Cc:Subject:Date:From;	b=n/PL5DJdcqsHZiTCjno6JzK4B8C/8GewLhoUmF/7yTe2EMI+nDVNxwgbi2qKglaPD	 i21sBFkJhe/hDNahXjmIMhq6bbdNQh9fy7sDqDkZiFwi4JTYAJG0q5Jx7Mlaqk3m1m	 7qeOp/kWT5dBYzPQU1vCi/zBwGG/QrW+kWx/fcsliS9cLTkrTf0Vuq1dIDzE8oWPnq	 oi07x78mHCDH6U4y0yIaDnSvwsIEFEqdo0zHrqHShaInO2QM+/ySZ+NlR0BJGA1/48	 Sa91qqZpdid51lpi3Q5Y70tOqfyqEzjOJm/AMw9JjFHfV4nvI4OMnGyjYhw+4pnHS8	 uy3VcXw9Hfoog==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Workaround for horizontal tab on console (again)
Date: Thu, 15 Aug 2019 05:02:00 -0000
Message-Id: <20190815050205.6331-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00086.txt.bz2

The workaround commit 33a21904a702191cebf0e81b4deba2dfa10a406c does not
work as expected if the window size is changed while screen is alternated.
This patch fixes the issue.

Takashi Yano (1):
  Cygwin: console: Fix workaround for horizontal tab position

 winsup/cygwin/fhandler_console.cc | 47 +++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)

-- 
2.21.0
