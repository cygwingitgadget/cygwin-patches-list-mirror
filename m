Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 59AA5387086D
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 09:07:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 59AA5387086D
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 11I97KPB000557;
 Thu, 18 Feb 2021 18:07:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 11I97KPB000557
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Make tty setting NOFLSH work.
Date: Thu, 18 Feb 2021 18:07:11 +0900
Message-Id: <20210218090711.1612-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 18 Feb 2021 09:07:53 -0000

- With this patch, "stty noflsh" gets working in pty.
---
 winsup/cygwin/fhandler_termios.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index e8daf946b..ae35fe894 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -332,7 +332,8 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	    goto not_a_sig;
 
 	  termios_printf ("got interrupt %d, sending signal %d", c, sig);
-	  eat_readahead (-1);
+	  if (!(ti.c_lflag & NOFLSH))
+	    eat_readahead (-1);
 	  release_input_mutex_if_necessary ();
 	  tc ()->kill_pgrp (sig);
 	  acquire_input_mutex_if_necessary (INFINITE);
-- 
2.30.0

