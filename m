Return-Path: <cygwin-patches-return-9636-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79716 invoked by alias); 5 Sep 2019 10:44:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79707 invoked by uid 89); 5 Sep 2019 10:44:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 10:44:55 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x85AiitU031038;	Thu, 5 Sep 2019 19:44:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x85AiitU031038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567680289;	bh=lyMKkmZ122/CfQ9wtgzuFTvek1AmpQ1rfhGVnZKecdA=;	h=From:To:Cc:Subject:Date:From;	b=z1fovqyZu6f0bD1PxzyBvc7c/V/DbqzS0+vnoOevkZHlVl0oZg7xfWhVFmdypw7uV	 CGEqnt3JpDk4b/BLwJWUM72i2O/ynZS6jKCyRqrgflHRjdjF2+dMDJP/dDGj77nvMk	 DIjZpQAQDIs44NmxJxVDadhYo1r2lK0w+Lm5+tlFu7QosSoXx1kGI0IjNzHqc2jDZ2	 Of9PNRq38UhR9E9WYHQ3plp9A3ErBNJZyPtSx9kclWX+FMTZOSbJlew0H1SyxKVd8q	 GXfQbmNsMYDa+WwXeNDrwgyc1j8IM6b8Rrb8lDwc8PShWKT9Gh71cq2WeZ969G7oSM	 aeKKho5oiNA1A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: pty: Fix potential state mismatch regarding pseudo console.
Date: Thu, 05 Sep 2019 10:44:00 -0000
Message-Id: <20190905104441.2075-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00156.txt.bz2

- PTY with pseudo console support sitll has problem which potentially
  cause state mismatch between state variable and real console state.
  This patch fixes this issue.

Takashi Yano (1):
  Cygwin: pty: Fix potential state mismatch regarding pseudo console.

 winsup/cygwin/dtable.cc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.21.0
