Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 8D7A8386EC42
 for <cygwin-patches@cygwin.com>; Sun, 31 May 2020 05:53:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8D7A8386EC42
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 04V5rShx024218;
 Sun, 31 May 2020 14:53:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04V5rShx024218
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/4] Some fixes for pty.
Date: Sun, 31 May 2020 14:53:16 +0900
Message-Id: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 31 May 2020 05:53:51 -0000

Patches for https://cygwin.com/pipermail/cygwin/2020-May/245057.html
and three other issues that were noticed during this fix.

Takashi Yano (4):
  Cygwin: pty: Prevent garbage remained in read ahead buffer.
  Cygwin: console: Discard some unsupported escape sequences.
  Cygwin: pty: Clean up fhandler_pty_master::pty_master_fwd_thread().
  Cygwin: pty: Revise the code which prevents undesired window title.

 winsup/cygwin/fhandler.h          |  3 +-
 winsup/cygwin/fhandler_console.cc | 54 ++++++++++++++++++++++---------
 winsup/cygwin/fhandler_tty.cc     | 41 +++++++++++------------
 3 files changed, 59 insertions(+), 39 deletions(-)

-- 
2.26.2

