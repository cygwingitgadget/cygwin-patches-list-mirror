Return-Path: <cygwin-patches-return-9559-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53225 invoked by alias); 12 Aug 2019 13:48:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53135 invoked by uid 89); 12 Aug 2019 13:47:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 13:47:57 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x7CDlgv1024878;	Mon, 12 Aug 2019 22:47:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x7CDlgv1024878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1565617666;	bh=ZXarD6PEIL3Pkv5vuy58OISWYooFacqt66RkkpKzN2w=;	h=From:To:Cc:Subject:Date:From;	b=Atn7h7c0gJnsJROJm2+YNawxf0lfeYEJGBbtpU8JkZFL0CsGOlY7r+Q9UfQQ7Lrp/	 FTO99bkiV6zMftJl7D7XZIRF9Hqo9DksgEgFOvLzPqOcdE1186CWQxxAkhO1e53DQ3	 q7bzCrNe1T7oXyxGNPprZotN0+nhg15S0oeE0ccipON6U8tMchOGBiuqLcMfCpo2HF	 qwQ0KD+gtyNABlSdCjtTUCnVMC8+LMBMprMEykA1iNvlfffbXJipyWrGKLjEgFKFP5	 cbdQEQDMWA4zNr+s6giG01lD8b+4rEsWP7Nm2YVY9Nz2vV2o9DcROivTVODJBUrVTs	 KAGkOlxA3tZfA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Workaround for bug of hrizontal tab on console.
Date: Mon, 12 Aug 2019 13:48:00 -0000
Message-Id: <20190812134742.2151-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00079.txt.bz2

In cygwin test release 3.1.0-0.1, the horizontal tab setting is broken
after resizing console window. This seems to be a bug of xterm
compatible mode of windows console. This patch fixes this problem.

Takashi Yano (1):
  Cygwin: console: Add workaround for windows xterm compatible mode bug.

 winsup/cygwin/fhandler_console.cc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.21.0
