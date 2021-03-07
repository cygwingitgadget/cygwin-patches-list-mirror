Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 87857386185F
 for <cygwin-patches@cygwin.com>; Sun,  7 Mar 2021 01:41:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 87857386185F
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 1271fBlh004778;
 Sun, 7 Mar 2021 10:41:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 1271fBlh004778
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console, pty: Stop ignoring Ctrl-C by IGNBRK.
Date: Sun,  7 Mar 2021 10:41:11 +0900
Message-Id: <20210307014111.1065-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 07 Mar 2021 01:41:48 -0000

- Perhaps current code misunderstand meaning of the IGNBRK. As far
  as I investigated, IGNBRK is concerned with break signal in serial
  port but there is no evidence that it has effect to ignore Ctrl-C.
  This patch stops ignoring Ctrl-C by IGNBRK for non-cygwin apps.
---
 winsup/cygwin/fhandler_console.cc | 2 +-
 winsup/cygwin/fhandler_tty.cc     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 96a8729e8..0b33a1370 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -484,7 +484,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 	/* This is illegal, so turn off the echo here, and fake it
 	   when we read the characters */
 	flags &= ~ENABLE_ECHO_INPUT;
-      if ((t->c_lflag & ISIG) && !(t->c_iflag & IGNBRK))
+      if (t->c_lflag & ISIG)
 	flags |= ENABLE_PROCESSED_INPUT;
       break;
     }
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 244147a80..4358bceec 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2165,8 +2165,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	}
 
       WaitForSingleObject (input_mutex, INFINITE);
-      if ((ti.c_lflag & ISIG) && !(ti.c_iflag & IGNBRK)
-	  && !(ti.c_lflag & NOFLSH) && memchr (buf, '\003', nlen))
+      if ((ti.c_lflag & ISIG) && !(ti.c_lflag & NOFLSH)
+	  && memchr (buf, '\003', nlen))
 	get_ttyp ()->discard_input = true;
       DWORD n;
       WriteFile (to_slave, buf, nlen, &n, NULL);
@@ -3307,7 +3307,7 @@ skip_create:
 	/* This is illegal, so turn off the echo here, and fake it
 	   when we read the characters */
 	mode &= ~ENABLE_ECHO_INPUT;
-      if ((t.c_lflag & ISIG) && !(t.c_iflag & IGNBRK))
+      if (t.c_lflag & ISIG)
 	mode |= ENABLE_PROCESSED_INPUT;
       SetConsoleMode (hpConIn, mode);
       /* Set output mode */
-- 
2.30.1

