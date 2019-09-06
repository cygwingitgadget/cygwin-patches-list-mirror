Return-Path: <cygwin-patches-return-9651-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106834 invoked by alias); 6 Sep 2019 14:52:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106756 invoked by uid 89); 6 Sep 2019 14:52:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:726, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 14:52:19 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x86Eq1oR027509;	Fri, 6 Sep 2019 23:52:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x86Eq1oR027509
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567781525;	bh=GZ95XeSKHwgBrQYfw6NIY2PXij7XON+rtQPLtdBfpVU=;	h=From:To:Cc:Subject:Date:From;	b=EUxzHbO0hbM+dKhjOiHLjv4l6xrSDxykq+hogGRUR2S9IggAob/HCKECdudw8iiLc	 0l0wclpS5Kj8olWq0mqK8qFldVziQ07/DQbchTNxADLw/mJq15ozEeP2Ehd2c/1EvX	 F9p6Vec80068JyXiKWZXkky2S551nIR6Cer3FbmK4A5dm4oVxe1R9A1hmF3nJePO5Z	 oGDQnbaK+ehJuVU3W5w8bQiDylnyxYSxZVasgCTOctuqMW00EoQya6YnV/wOQ8bgub	 PR/GD7RiPHqtjv2oOOyQQu7RIAggw+WUysBHBSlG77+uViZDwbepWZmb8J1muc1MBC	 hESaO0aJDgMrQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Fri, 06 Sep 2019 14:52:00 -0000
Message-Id: <20190906145200.802-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00171.txt.bz2

- When the I/O pipe is switched to the pseudo console side, the
  behaviour of Ctrl-C is unstable. This rarely happens, however,
  for example, shell sometimes crashes by Ctrl-C in that situation.
  This patch fixes that issue.

v3:
Fix mistake in v2.

v2:
Remove the code which accidentally clears ENABLE_ECHO_INPUT flag.

Takashi Yano (1):
  Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.

 winsup/cygwin/fhandler.h      |   4 +-
 winsup/cygwin/fhandler_tty.cc |  33 +++++----
 winsup/cygwin/select.cc       |   2 +-
 winsup/cygwin/spawn.cc        | 128 +++++++++++++++++-----------------
 4 files changed, 89 insertions(+), 78 deletions(-)

-- 
2.21.0
