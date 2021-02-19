Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 4ADDE393C851
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 08:45:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4ADDE393C851
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 11J8iEF0005989;
 Fri, 19 Feb 2021 17:44:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 11J8iEF0005989
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: console: Add support for FLUSHO and Ctrl-O.
Date: Fri, 19 Feb 2021 17:44:02 +0900
Message-Id: <20210219084402.1072-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210219084402.1072-1-takashi.yano@nifty.ne.jp>
References: <20210219084402.1072-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Fri, 19 Feb 2021 08:45:03 -0000

- With this patch, FLUSHO and Ctrl-O (VDISCARD) get working.
---
 winsup/cygwin/fhandler_console.cc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index ca8eb6400..6ded9eabf 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -259,6 +259,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		    {
 		      ttyp->kill_pgrp (sig);
 		      ttyp->output_stopped = false;
+		      ti.c_lflag &= ~FLUSHO;
 		      /* Discard type ahead input */
 		      goto skip_writeback;
 		    }
@@ -286,6 +287,13 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 			   && c && i >= output_stopped_at)
 		    goto restart_output;
 		}
+	      if ((ti.c_lflag & ICANON) && (ti.c_lflag & IEXTEN)
+		  && CCEQ (ti.c_cc[VDISCARD], c))
+		{
+		  if (input_rec[i].Event.KeyEvent.bKeyDown)
+		    ti.c_lflag ^= FLUSHO;
+		  processed = true;
+		}
 	      break;
 	    case WINDOW_BUFFER_SIZE_EVENT:
 	      SHORT y = con.dwWinSize.Y;
@@ -3052,6 +3060,9 @@ fhandler_console::write (const void *vsrc, size_t len)
   if (bg <= bg_eof)
     return (ssize_t) bg;
 
+  if (get_ttyp ()->ti.c_lflag & FLUSHO)
+    return len; /* Discard write data */
+
   if (get_ttyp ()->output_stopped && is_nonblocking ())
     {
       set_errno (EAGAIN);
-- 
2.30.0

