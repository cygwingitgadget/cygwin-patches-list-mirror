Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id A1DC63858D29
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 23:27:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A1DC63858D29
Received: from localhost.localdomain (y084061.dynamic.ppp.asahi-net.or.jp
 [118.243.84.61]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 12LNQsM9020384;
 Mon, 22 Mar 2021 08:27:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 12LNQsM9020384
X-Nifty-SrcIP: [118.243.84.61]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/3] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Date: Mon, 22 Mar 2021 08:26:44 +0900
Message-Id: <20210321232647.56-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 21 Mar 2021 23:27:22 -0000

Takashi Yano (3):
  Cygwin: syscalls.cc: Make _get_osfhandle() return appropriate handle.
  Cygwin: pty: Add hook for GetStdHandle() to return appropriate handle.
  Cygwin: pty: Clear input_available_event if pipe is empty on close.

 winsup/cygwin/fhandler_tty.cc | 31 ++++++++++++++++++++++++-------
 winsup/cygwin/syscalls.cc     | 13 ++++++++++++-
 2 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.30.2

