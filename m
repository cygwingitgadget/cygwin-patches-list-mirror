Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 3C6123857C75
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 11:14:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3C6123857C75
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 10SBERcw025778;
 Thu, 28 Jan 2021 20:14:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 10SBERcw025778
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Make terminal read() thread-safe.
Date: Thu, 28 Jan 2021 20:14:07 +0900
Message-Id: <20210128111409.581-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 28 Jan 2021 11:14:56 -0000

Currently read() for console and pty slave are somehow
not thread-safe. These patches fix the issue.

Takashi Yano (2):
  Cygwin: console: Make read() thread-safe.
  Cygwin: pty: Make slave read() thread-safe.

 winsup/cygwin/fhandler_console.cc | 7 +++----
 winsup/cygwin/fhandler_tty.cc     | 6 ++++++
 winsup/cygwin/select.cc           | 3 ---
 3 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.30.0

