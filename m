Return-Path: <cygwin-patches-return-10117-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73867 invoked by alias); 25 Feb 2020 17:14:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73855 invoked by uid 89); 25 Feb 2020 17:14:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*ne.jp, ESC, esc, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Feb 2020 17:14:54 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 01PHEi74028298;	Wed, 26 Feb 2020 02:14:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 01PHEi74028298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582650890;	bh=NnztqFQ6/Cx9c1tYgXoH29O2BdemjVpAmXSyBqvTtyc=;	h=From:To:Cc:Subject:Date:From;	b=ijaYvGq618f8isysnkc+36QBTdEAnQfESGn2ExBlIZHmnXcoxTHYAbpCPM2nkoHJg	 9Z2oBfux0tfq0TSzPwRyTAH2Bg4Nhk/8gROIvYGEHlGa7Lf3wj0A/SuuBg6yHWmOts	 zk2eM5q1gSBMDKg/xsuoiCAdkXMHDsgJ1DmFwX6AUswTLJL3t31lWhLnJDu4C1S6V2	 qMoGBAIzU4VDZ95HHI+kvyiEFxvUpS7SoJk+r0OpjDDMeUXBUGerLj+O4pxf2fdv7g	 q24zH7eCIqb1GaVfm958IjgmRC4WW/bL2hliWFlDJu5X+6YoIMwdn0yBVCKieK+P++	 +JTUpPu5vcH1Q==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Modify handling of several ESC sequences in xterm mode.
Date: Tue, 25 Feb 2020 17:14:00 -0000
Message-Id: <20200225171438.1243-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00223.txt

Takashi Yano (2):
  Cygwin: console: Add workaround for broken IL/DL in xterm mode.
  Cygwin: console: Add support for REP escape sequence to xterm mode.

 winsup/cygwin/fhandler_console.cc | 215 ++++++++++++++++++++++++++----
 winsup/cygwin/wincap.cc           |  20 +++
 winsup/cygwin/wincap.h            |   4 +
 3 files changed, 216 insertions(+), 23 deletions(-)

-- 
2.21.0
