Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 6BF63387086C
 for <cygwin-patches@cygwin.com>; Thu, 28 May 2020 13:49:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6BF63387086C
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 04SDnRwj021665;
 Thu, 28 May 2020 22:49:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 04SDnRwj021665
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Prevent meaningless ResizePseudoConsole() calls.
Date: Thu, 28 May 2020 22:49:26 +0900
Message-Id: <20200528134926.488-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 28 May 2020 13:49:59 -0000

- This patch prevents to call ResizePseudoConsole() unless the pty
  is resized.
---
 winsup/cygwin/fhandler_tty.cc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f29a2c214..b091765b3 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2615,18 +2615,18 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
       *(struct winsize *) arg = get_ttyp ()->winsize;
       break;
     case TIOCSWINSZ:
-      /* FIXME: Pseudo console can be accessed via its handle
-	 only in the process which created it. What else can we do? */
-      if (get_pseudo_console () && get_ttyp ()->master_pid == myself->pid)
-	{
-	  COORD size;
-	  size.X = ((struct winsize *) arg)->ws_col;
-	  size.Y = ((struct winsize *) arg)->ws_row;
-	  ResizePseudoConsole (get_pseudo_console (), size);
-	}
       if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
 	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
 	{
+	  /* FIXME: Pseudo console can be accessed via its handle
+	     only in the process which created it. What else can we do? */
+	  if (get_pseudo_console () && get_ttyp ()->master_pid == myself->pid)
+	    {
+	      COORD size;
+	      size.X = ((struct winsize *) arg)->ws_col;
+	      size.Y = ((struct winsize *) arg)->ws_row;
+	      ResizePseudoConsole (get_pseudo_console (), size);
+	    }
 	  get_ttyp ()->winsize = *(struct winsize *) arg;
 	  get_ttyp ()->kill_pgrp (SIGWINCH);
 	}
-- 
2.26.2

