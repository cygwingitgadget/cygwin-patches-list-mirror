Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 413373857819
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 13:41:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 413373857819
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 089DeqLd022890;
 Wed, 9 Sep 2020 22:40:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 089DeqLd022890
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/2] Cygwin: pty: Changes regarding charset conversion.
Date: Wed,  9 Sep 2020 22:40:41 +0900
Message-Id: <20200909134043.1864-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: **
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
X-List-Received-Date: Wed, 09 Sep 2020 13:41:32 -0000

Takashi Yano (2):
  Cygwin: pty: Revise convert_mb_str() function.
  Cygwin: pty: Fix input charset for non-cygwin apps with disable_pcon.

 winsup/cygwin/fhandler_tty.cc | 130 +++++++++++++++++++++++-----------
 1 file changed, 88 insertions(+), 42 deletions(-)

-- 
2.28.0

