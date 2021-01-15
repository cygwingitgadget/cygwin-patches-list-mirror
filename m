Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 2851B3858034
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 08:33:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2851B3858034
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10F8WSAV017561;
 Fri, 15 Jan 2021 17:32:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10F8WSAV017561
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/5] Some revisions for pty and console code.
Date: Fri, 15 Jan 2021 17:32:08 +0900
Message-Id: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 15 Jan 2021 08:33:05 -0000

Takashi Yano (5):
  Cygwin: pty: Add workaround for rlwrap 0.40 or later.
  Cygwin: console: Revise the code to switch xterm mode.
  Cygwin: pty: Make close_pseudoconsole() be a static member function.
  Cygwin: pty: Prevent pty from changing code page of parent console.
  Cygwin: pty: Make master thread functions be static.

 winsup/cygwin/fhandler.h          |  56 ++++--
 winsup/cygwin/fhandler_console.cc | 159 +++++++++++-----
 winsup/cygwin/fhandler_tty.cc     | 305 +++++++++++++++++++++++-------
 winsup/cygwin/select.cc           |  15 +-
 winsup/cygwin/spawn.cc            |  42 +++-
 winsup/cygwin/tty.cc              |   2 +
 winsup/cygwin/tty.h               |   2 +
 7 files changed, 440 insertions(+), 141 deletions(-)

-- 
2.30.0

