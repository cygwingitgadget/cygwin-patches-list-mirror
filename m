Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 816383857C73
 for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2020 08:30:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 816383857C73
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 09Q8TfwJ012519;
 Mon, 26 Oct 2020 17:29:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 09Q8TfwJ012519
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix race condition in initialization of pseudo
 console.
Date: Mon, 26 Oct 2020 17:29:31 +0900
Message-Id: <20201026082931.85-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 26 Oct 2020 08:30:06 -0000

- If output of non-cygwin process is piped to cygwin process, such
  as less, the non-cygwin process sometimes fails to start and hangs.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8910af1e7..c5a081ebd 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -784,8 +784,6 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     return;
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
-  get_ttyp ()->h_pseudo_console = NULL;
-  get_ttyp ()->pcon_start = false;
 }
 
 ssize_t __stdcall
@@ -2620,7 +2618,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   char *p;
   int len;
   int x1, y1, x2, y2;
-  tcflag_t c_lflag;
   DWORD t0;
 
   /* Check if terminal has ANSI escape sequence. */
@@ -2629,8 +2626,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 
   /* Check if terminal has CSI6n */
   WaitForSingleObject (input_mutex, INFINITE);
-  c_lflag = get_ttyp ()->ti.c_lflag;
-  get_ttyp ()->ti.c_lflag &= ~ICANON;
   /* Set h_pseudo_console and pcon_start so that the response
      will sent to io_handle rather than io_handle_cyg. */
   get_ttyp ()->h_pseudo_console = (HPCON *) -1; /* dummy */
@@ -2687,10 +2682,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
       break;
     }
   while (len);
-  WaitForSingleObject (input_mutex, INFINITE);
   get_ttyp ()->h_pseudo_console = NULL;
-  get_ttyp ()->ti.c_lflag = c_lflag;
-  ReleaseMutex (input_mutex);
 
   if (len == 0)
     return true;
@@ -2711,7 +2703,6 @@ not_has_csi6n:
      in master write(). Therefore, clear it here manually. */
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->h_pseudo_console = NULL;
-  get_ttyp ()->ti.c_lflag = c_lflag;
   ReleaseMutex (input_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
-- 
2.29.0

