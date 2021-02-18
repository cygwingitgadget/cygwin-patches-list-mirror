Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id BC4BB386F83C
 for <cygwin-patches@cygwin.com>; Thu, 18 Feb 2021 09:06:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BC4BB386F83C
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 11I95mai001212;
 Thu, 18 Feb 2021 18:05:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 11I95mai001212
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Reflect tty settings to pseudo console mode.
Date: Thu, 18 Feb 2021 18:05:39 +0900
Message-Id: <20210218090539.1560-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 18 Feb 2021 09:06:14 -0000

- With this patch, tty setting such as echo, icanon, isig and onlcr
  are reflected to pseudo console mode.
---
 winsup/cygwin/fhandler_tty.cc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5afede859..e4c35ea41 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3261,6 +3261,33 @@ skip_create:
   if (get_ttyp ()->previous_output_code_page)
     SetConsoleOutputCP (get_ttyp ()->previous_output_code_page);
 
+  do
+    {
+      termios &t = get_ttyp ()->ti;
+      DWORD mode;
+      /* Set input mode */
+      GetConsoleMode (hpConIn, &mode);
+      mode &= ~(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
+      if (t.c_lflag & ECHO)
+	mode |= ENABLE_ECHO_INPUT;
+      if (t.c_lflag & ICANON)
+	mode |= ENABLE_LINE_INPUT;
+      if (mode & ENABLE_ECHO_INPUT && !(mode & ENABLE_LINE_INPUT))
+	/* This is illegal, so turn off the echo here, and fake it
+	   when we read the characters */
+	mode &= ~ENABLE_ECHO_INPUT;
+      if ((t.c_lflag & ISIG) && !(t.c_iflag & IGNBRK))
+	mode |= ENABLE_PROCESSED_INPUT;
+      SetConsoleMode (hpConIn, mode);
+      /* Set output mode */
+      GetConsoleMode (hpConOut, &mode);
+      mode &= ~DISABLE_NEWLINE_AUTO_RETURN;
+      if (!(t.c_oflag & OPOST) || !(t.c_oflag & ONLCR))
+	mode |= DISABLE_NEWLINE_AUTO_RETURN;
+      SetConsoleMode (hpConOut, mode);
+    }
+  while (false);
+
   return true;
 
 cleanup_pcon_in:
-- 
2.30.0

