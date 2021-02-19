Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 23B7D393C845
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 08:44:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 23B7D393C845
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 11J8iEEu005989;
 Fri, 19 Feb 2021 17:44:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 11J8iEEu005989
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Cygwin: pty, console: Make FLUSHO and Ctrl-O work.
Date: Fri, 19 Feb 2021 17:44:00 +0900
Message-Id: <20210219084402.1072-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 19 Feb 2021 08:44:46 -0000

- With these patches, FLUSHO and Ctrl-O (VDISCARD) get working.

Takashi Yano (2):
  Cygwin: pty: Make FLUSHO and Ctrl-O work.
  Cygwin: console: Add support for FLUSHO and Ctrl-O.

 winsup/cygwin/fhandler.h          |  1 +
 winsup/cygwin/fhandler_console.cc | 11 +++++++++++
 winsup/cygwin/fhandler_tty.cc     | 17 +++++++++++------
 winsup/cygwin/select.cc           |  5 +++++
 winsup/cygwin/tty.cc              |  1 +
 winsup/cygwin/tty.h               |  1 +
 6 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.30.0

