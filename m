Return-Path: <cygwin-patches-return-9594-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64988 invoked by alias); 4 Sep 2019 01:44:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64858 invoked by uid 89); 4 Sep 2019 01:44:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-10.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Therefore, Speed, H*r:authenticated, HX-Spam-Relays-External:Sendmail
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:44:55 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-05.nifty.com with ESMTP id x841iibB012450;	Wed, 4 Sep 2019 10:44:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com x841iibB012450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561491;	bh=9CWzmxOQVttS/1kq2/jDefqCQkFO+YDsCbfLTpRNZ4k=;	h=From:To:Cc:Subject:Date:From;	b=lC4Adry8cMPtz4U3bPWdiKzcpE8rxAvLdA2m0SVobM3OJe1Hy110Do5rfxiAferdh	 SPxCfcU9iKu1P0QuRt4bGF1Ax9gyF0WJ4MQiqTmEJLg/hz61Ubefv7KqMzVJTHjHL7	 UtrX11SQuGMw0i+3bMI5tEvC+58jFkCeNfJ0XpmcntnmlNhL2Q98KjF8sT7WRZbqmd	 iKZhThttbsLXRbCdN9RZqp+3C4hktkPV2QTwPED1+irMf5H9uZhqFLKzONdIw0TyBb	 t2/wS9ETxCjY/C4iyJmXq3B0447U1/JxMWIfB5e2ipYreSsEOiGC31JbeijHUK5sT7	 vL7IvnB/HsL7A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/4] Some fixes for PTY with pseudo console support (1)
Date: Wed, 04 Sep 2019 01:44:00 -0000
Message-Id: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00114.txt.bz2

[PATCH 1/4] Cygwin: pty: Code cleanup
- Cleanup the code which is commented out by #if 0 regarding pseudo
  console.
- Remove #if 1 for experimental code which seems to be stable.

[PATCH 2/4] Cygwin: pty: Speed up a little hooked Win32 API for pseudo console.
- Some Win32 APIs are hooked in pty code for pseudo console support.
  This causes slow down. This patch improves speed a little.

[PATCH 3/4] Cygwin: pty: Move function hook_api() into hookapi.cc.
- PTY uses Win32 API hook for pseudo console suppot. The function
  hook_api() is used for this purpose and defined in fhandler_tty.cc
  previously. This patch moves it into hookapi.cc.

[PATCH 4/4] Cygwin: pty: Limit API hook to the program linked with the APIs.
- API hook used for pseudo console support causes slow down.
  This patch limits API hook to only program which is linked
  with the corresponding APIs. Normal cygwin program is not
  linked with such APIs (such as WriteFile, etc...) directly,
  therefore, no slow down occurs. However, console access by
  cygwin.dll itself cannot switch the r/w pipe to pseudo console
  side. Therefore, the code to switch it forcely to pseudo
  console side is added to smallprint.cc and strace.cc.

Takashi Yano (4):
  Cygwin: pty: Code cleanup
  Cygwin: pty: Speed up a little hooked Win32 API for pseudo console.
  Cygwin: pty: Move function hook_api() into hookapi.cc.
  Cygwin: pty: Limit API hook to the program linked with the APIs.

 winsup/cygwin/fhandler_tty.cc | 136 +++++++++++-----------------------
 winsup/cygwin/hookapi.cc      |  34 +++++++++
 winsup/cygwin/smallprint.cc   |   5 ++
 winsup/cygwin/strace.cc       |  29 ++------
 winsup/cygwin/winsup.h        |   1 +
 5 files changed, 89 insertions(+), 116 deletions(-)

-- 
2.21.0
