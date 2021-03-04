Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 0FD82384803A
 for <cygwin-patches@cygwin.com>; Thu,  4 Mar 2021 08:56:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0FD82384803A
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 1248uXLe007738;
 Thu, 4 Mar 2021 17:56:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 1248uXLe007738
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix a race issue in startup of pseudo console.
Date: Thu,  4 Mar 2021 17:56:34 +0900
Message-Id: <20210304085634.1659-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 04 Mar 2021 08:56:59 -0000

- If two non-cygwin apps are started simultaneously and this is the
  first execution of non-cygwin apps in the pty, these occasionally
  hang up. The cause is the race issue between term_has_pcon_cap(),
  reset_switch_to_pcon() and setup_pseudoconsole(). This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_tty.cc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 3fcaa8277..930501d01 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1118,15 +1118,20 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 	    }
 	}
     }
-  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
-      && !!pinfo (get_ttyp ()->pcon_pid))
-    /* There is a process which is grabbing pseudo console. */
-    return;
   if (isHybrid)
     return;
+  WaitForSingleObject (pcon_mutex, INFINITE);
+  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
+      && !!pinfo (get_ttyp ()->pcon_pid))
+    {
+      /* There is a process which is grabbing pseudo console. */
+      ReleaseMutex (pcon_mutex);
+      return;
+    }
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->pcon_activated = false;
+  ReleaseMutex (pcon_mutex);
 }
 
 ssize_t __stdcall
@@ -3538,6 +3543,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
     goto maybe_dumb;
 
   /* Check if terminal has CSI6n */
+  WaitForSingleObject (pcon_mutex, INFINITE);
   WaitForSingleObject (input_mutex, INFINITE);
   /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle rather than io_handle_cyg. */
@@ -3573,6 +3579,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   while (len);
   get_ttyp ()->pcon_activated = false;
   get_ttyp ()->pcon_pid = 0;
+  ReleaseMutex (pcon_mutex);
   if (len == 0)
     goto not_has_csi6n;
 
@@ -3588,6 +3595,7 @@ not_has_csi6n:
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
+  ReleaseMutex (pcon_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
   return false;
-- 
2.30.1

