Return-Path: <cygwin-patches-return-9641-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95447 invoked by alias); 5 Sep 2019 13:22:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95434 invoked by uid 89); 5 Sep 2019 13:22:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 13:22:52 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x85DMT8W017033;	Thu, 5 Sep 2019 22:22:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x85DMT8W017033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567689754;	bh=2Ze+ZMTfa3i3X0Y7As4pReCL4ysP4Njrh/fM4cW1tcU=;	h=From:To:Cc:Subject:Date:From;	b=syRk9bazQEoKY4+ePzYF8BxOw1K5RYyd2UTzzGR8Fo5L6PxORGnpFhuiNSmUt+X2b	 eucYknmATyeY/4VMicc5Ob80qZljKaJCEvzrZlk+fx7wp4TgV0izhKiy/6Q/U0YZOu	 RO4HW2Pt2eXatkr7avnoQtcIIHVDCHgzmI3zirAu0Vb75YnFU1ltjOum/Nlq3cBDnL	 WsVl3VD8Ol2v/Tjthd7MIaElbHUdetpffagJdrMau2lwuelsNXBNcmpP/rgRYbmq8P	 9jLmQlY1bJlC6espIUk+EX01DRHOdTJyxQJyLPwZQyIVyXSLw1aRtgJ2WHuUbqE5ft	 tQ+oRTBJi7A+w==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Cygwin: pty: Make it sure to show up system error messages.
Date: Thu, 05 Sep 2019 13:22:00 -0000
Message-Id: <20190905132227.1967-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00161.txt.bz2

- Forcibly attach to pseudo console in advance so that the error
  messages by system_printf() is displayed to screen reliably.
  This is needed when stdout is redirected to another pty. In this
  case, process has two ptys opened. However, process can attach
  to only one console. So it is necessary to change console attached.

Takashi Yano (1):
  Cygwin: pty: Make it sure to show up system error messages.

 winsup/cygwin/fhandler_tty.cc | 55 +++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 6 deletions(-)

-- 
2.21.0
