Return-Path: <cygwin-patches-return-9617-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62607 invoked by alias); 4 Sep 2019 13:47:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62593 invoked by uid 89); 4 Sep 2019 13:47:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 13:47:19 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x84DkqTY014967;	Wed, 4 Sep 2019 22:46:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x84DkqTY014967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567604817;	bh=FTrGlbKOK0n1csW14fPclqG2rqox2rvOxcEOzlwL09A=;	h=From:To:Cc:Subject:Date:From;	b=PPPewvN1VOD7K5ayk7rWw7m68MmBydom7/WivHrvWMs4pqhib/RQKiW2/SVAWCd0M	 fcqKBJ9agmeC2ZOrLyLepsz1kLoo+lMo20MLLrcBRegY0R4aSkhvhsMj1NX66KoVlV	 jiO36HhGqG1Xvrl4AbNku0BiSxS4adsASLwbDchGYpMVfX6ECW84wzDzih8GVfT15R	 mrwM1pdF0YBvTpHtD/Vs3rMOrr42I67Twq1+JxRyLwrjY3X2mqc8hVdVbF+A21Kq1E	 XAouzTnEYJz0uAk1FMpHgvvaPIVlbOk7X1SRETh0fG2LlIFg6H+Kxg/IxaSgpmdRFF	 m6wrTbKvsmjLw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Cygwin: pty: Limit API hook to the program linked with the APIs.
Date: Wed, 04 Sep 2019 13:47:00 -0000
Message-Id: <20190904134651.1750-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00137.txt.bz2

- API hook used for pseudo console support causes slow down.
  This patch limits API hook to only program which is linked
  with the corresponding APIs. Normal cygwin program is not
  linked with such APIs (such as WriteFile, etc...) directly,
  therefore, no slow down occurs. However, console access by
  cygwin.dll itself cannot switch the r/w pipe to pseudo console
  side. Therefore, the code to switch it forcely to pseudo
  console side is added to smallprint.cc and strace.cc.

v2:
Unify set_ishybrid_and_switch_to_pcon() and CHK_CONSOLE_ACCESS()
because they have exactly the same functionality.

Takashi Yano (1):
  Cygwin: pty: Limit API hook to the program linked with the APIs.

 winsup/cygwin/fhandler_tty.cc | 106 +++++++++++++++++++---------------
 winsup/cygwin/smallprint.cc   |   2 +
 winsup/cygwin/strace.cc       |  26 +--------
 winsup/cygwin/winsup.h        |   3 +
 4 files changed, 66 insertions(+), 71 deletions(-)

-- 
2.21.0
