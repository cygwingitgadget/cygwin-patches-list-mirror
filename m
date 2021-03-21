Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 229723857C7E
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 04:02:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 229723857C7E
Received: from localhost.localdomain (y084061.dynamic.ppp.asahi-net.or.jp
 [118.243.84.61]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 12L41QmV028950;
 Sun, 21 Mar 2021 13:01:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 12L41QmV028950
X-Nifty-SrcIP: [118.243.84.61]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Date: Sun, 21 Mar 2021 13:01:24 +0900
Message-Id: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 21 Mar 2021 04:02:04 -0000

Takashi Yano (2):
  Cygwin: syscalls.cc: Make _get_osfhandle() return appropriate handle.
  Cygwin: pty: Add hook for GetStdHandle() to return appropriate handle.

 winsup/cygwin/fhandler_tty.cc | 19 +++++++++++++++++++
 winsup/cygwin/syscalls.cc     | 13 ++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.30.1

