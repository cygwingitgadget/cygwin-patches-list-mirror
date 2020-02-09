Return-Path: <cygwin-patches-return-10052-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128900 invoked by alias); 9 Feb 2020 15:00:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128862 invoked by uid 89); 9 Feb 2020 15:00:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: condef-09.nifty.com
Received: from condef-09.nifty.com (HELO condef-09.nifty.com) (202.248.20.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2020 15:00:49 +0000
Received: from conuserg-04.nifty.com ([10.126.8.67])by condef-09.nifty.com with ESMTP id 019EkQ55017565	for <cygwin-patches@cygwin.com>; Sun, 9 Feb 2020 23:46:26 +0900
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 019Ek4RV005877;	Sun, 9 Feb 2020 23:46:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 019Ek4RV005877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581259570;	bh=NytCkrdXIjC7eK4Tudrz9u02x1iBWM93HNRWS+ftuJY=;	h=From:To:Cc:Subject:Date:From;	b=BH3t99MA0vfwfkYuh4XD34MppBB4/3I1oDr9MWkKaUuNsMiq3I4TmgGN5GNDjMFzX	 9NFG2ktod3cbqfFFe/n1QpK4Fn9jx12WtkVES0b11kMUeRBBxwdjrFDmYAmCLq6Nlv	 qikTI4WsJ7q93TnhtVOMAniH4lfJ2y+78g1onRbnxR64VPa7BoqrNjqc0fI748k8Kc	 Mi22T2V2SZwnvGzyMsU1VfB/2x/rSNWWQ2eoEK3Cs/N5KE/NMWrUpizGc/Pit8/E78	 zuTNOtifEB/AsG/AVo3rN69AYTaenZ1rouJvLAzjoUZnsW2OguezhcHMDu8tMh2HcF	 3bhXjMI/V5XHw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/4] Remove debug codes and organize with some fixes.
Date: Sun, 09 Feb 2020 15:00:00 -0000
Message-Id: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00158.txt

Takashi Yano (4):
  Cygwin: pty: Define mask_switch_to_pcon_in() in fhandler_tty.cc.
  Cygwin: pty: Avoid screen distortion on slave read.
  Cygwin: pty: Remove debug codes and organize related codes.
  Cygwin: pty: Add missing member initialization for struct pipe_reply.

 winsup/cygwin/fhandler.h      |  12 +--
 winsup/cygwin/fhandler_tty.cc | 144 +++++++++++++++-------------------
 winsup/cygwin/select.cc       |  23 ------
 3 files changed, 67 insertions(+), 112 deletions(-)

-- 
2.21.0
