Return-Path: <cygwin-patches-return-9666-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66157 invoked by alias); 9 Sep 2019 12:08:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66137 invoked by uid 89); 9 Sep 2019 12:08:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:359, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Sep 2019 12:08:43 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x89C8Pis021844;	Mon, 9 Sep 2019 21:08:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x89C8Pis021844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568030910;	bh=+Z0AQ5ETiDiofP2tD70+2NuVzoC1FA1Q375uOi0ZJPY=;	h=From:To:Cc:Subject:Date:From;	b=2XgLlKxXL4GCHAxuGfes7+LH+HaaAL+tcJovgomjh+DRWkync1JDYm7YUjUrDVGgm	 8omxGNkQ0mpXM47GfqbGUOS9+ee2LcKKYTzWv6iHDzzgqQakmb4bQO+aS9b/rai73c	 S0kR7N53rujgCivpLVVKXRKTEuTmNgdYYbWSejqbOIMyPwtjDX6HEF8owGBJKdnIz5	 xnMUaY83zUiP1ZOlQr3Vc4l6AWLkmGfOm3m3vPRQO2Nqs3/Ecef74CVr3NyGgVIiBa	 e8F8Ec0hqbmR9lJpXJr4/SiFbyJpG8Pci2hRerGR96aJI7n35TkvInU/BbS24HgDG3	 2cZdEXRNPEPrQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: pty: Prevent the helper process from exiting by Ctrl-C.
Date: Mon, 09 Sep 2019 12:08:00 -0000
Message-Id: <20190909120820.201-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00186.txt.bz2

The helper process cygwin-console-helper.exe exsited by Ctrl-C
in some situation. This patch fixes this issue.

Takashi Yano (1):
  Cygwin: pty: Prevent the helper process from exiting by Ctrl-C.

 winsup/utils/cygwin-console-helper.cc | 1 +
 1 file changed, 1 insertion(+)

-- 
2.21.0
