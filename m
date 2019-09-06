Return-Path: <cygwin-patches-return-9649-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18847 invoked by alias); 6 Sep 2019 14:43:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18392 invoked by uid 89); 6 Sep 2019 14:43:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 14:43:03 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x86EgdUP013938;	Fri, 6 Sep 2019 23:42:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x86EgdUP013938
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567780964;	bh=7W7e3xN7RBF+rlyNCXK2Utm39ps0+ACwXXwMN3CkM/Q=;	h=From:To:Cc:Subject:Date:From;	b=H8fX/9nNHo7o5TN5ByNE/1kN7lTp4tHtwUueHC0ls1xgE4woJT4V5ithPpebkg4hN	 +tUcp2BNgbDI3bh4N6Vd6WtSBbLsdmn5ANf1JImOTSNfND6MBHR3Kygh04a3gd9baj	 ECHfHej0YVShNmrpu7U1K4quvBNMgnsmN8xOCFhU3tiCaxcK+hjkKU0f9rkVJtFdDv	 0sTvMej71VMuRXPInj1Gc3UX3DXlOamqzOMXETq+ZZt7e/OseOU63od5PIuWe7Aqq1	 VCu33Kzp3r+Pw1HiIrPoAuYs7hp1mR5QAaZo26vWsuO2JvIJrCib8iU2G9uE4vhi47	 rTUNJ35BikTBA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Fri, 06 Sep 2019 14:43:00 -0000
Message-Id: <20190906144239.671-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00169.txt.bz2

- When the I/O pipe is switched to the pseudo console side, the
  behaviour of Ctrl-C is unstable. This rarely happens, however,
  for example, shell sometimes crashes by Ctrl-C in that situation.
  This patch fixes that issue.

v2:
Remove the code which accidentally clears ENABLE_ECHO_INPUT flag.

Takashi Yano (1):
  Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.

 winsup/cygwin/fhandler.h      |   4 +-
 winsup/cygwin/fhandler_tty.cc |  32 +++++----
 winsup/cygwin/select.cc       |   2 +-
 winsup/cygwin/spawn.cc        | 128 +++++++++++++++++-----------------
 4 files changed, 88 insertions(+), 78 deletions(-)

-- 
2.21.0
