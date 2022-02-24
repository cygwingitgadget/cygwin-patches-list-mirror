Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id E51ED385841F
 for <cygwin-patches@cygwin.com>; Thu, 24 Feb 2022 08:42:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E51ED385841F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 21O8gM36015162;
 Thu, 24 Feb 2022 17:42:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21O8gM36015162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645692148;
 bh=wr4L06/gKz6aOOSVZadzRZ6tlmcnjUuAGtJCZ1KgXaE=;
 h=From:To:Cc:Subject:Date:From;
 b=W0Zb/aky/H7NWKY2H+E76YrIFto+4I5oVwJORP9ajiAa9GRjh+jyGz1z8QhUKXH/3
 hqgOMSycuZclyAExoKeblZ1s715epkRnWIbNRW5Vw5aef453401nSXUzAJBUZYh3WY
 QL2HpHUjTYMdm8IWVSJprqlbycRT1saeMXO3T/EIYafZZwbUzQkWnUq4/MlxPkFkEt
 0rbciL97j60deumt+cJb/4stIb2cfoDnfiNbUc+4F2kUXwrHXgMnw1p6YaULG/sXmb
 KHbld3FHHE2deAunMAtucWxYIAnQR2SKPeRR6OMvhMLcHmAr39/YADK+o8zZ4rtt+X
 rwMKp18Q/gbyQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Restore CTRL_BREAK_EVENT handling.
Date: Thu, 24 Feb 2022 17:42:12 +0900
Message-Id: <20220224084212.6238-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 24 Feb 2022 08:43:03 -0000

- The recent change by the commit "Cygwin: console: Redesign handling
  of special keys." breaks the handling of CTRL_BREAK_EVENT. The login
  shell in console exits on Ctrl-Break key. This patch fixes the issue.
---
 winsup/cygwin/exceptions.cc       | 13 ++++++-------
 winsup/cygwin/fhandler_console.cc | 11 +++--------
 winsup/cygwin/sigproc.cc          |  3 +--
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 356d69d6a..73bf68939 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1146,6 +1146,11 @@ ctrl_c_handler (DWORD type)
   if (!pinfo (cygwin_pid (GetCurrentProcessId ())))
     return TRUE;
 
+  if (type == CTRL_C_EVENT && ::cygheap->ctty
+      && !cygheap->ctty->need_console_handler ())
+    /* Ctrl-C is handled in fhandler_console::cons_master_thread(). */
+    return TRUE;
+
   tty_min *t = cygwin_shared->tty.get_cttyp ();
 
   /* If process group leader is non-cygwin process or not exist,
@@ -1169,14 +1174,8 @@ ctrl_c_handler (DWORD type)
        (to indicate that we have handled the signal).  At this point, type
        should be a CTRL_C_EVENT or CTRL_BREAK_EVENT. */
     {
-      int sig = SIGINT;
-      /* If intr and quit are both mapped to ^C, send SIGQUIT on ^BREAK */
-      if (type == CTRL_BREAK_EVENT
-	  && t->ti.c_cc[VINTR] == 3 && t->ti.c_cc[VQUIT] == 3)
-	sig = SIGQUIT;
       t->last_ctrl_c = GetTickCount64 ();
-      t->kill_pgrp (sig);
-      t->output_stopped = false;
+      fhandler_termios::process_sigs ('\003', (tty *) t, ::cygheap->ctty);
       t->last_ctrl_c = GetTickCount64 ();
       return TRUE;
     }
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index b290cde08..843a96f9a 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -699,11 +699,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
   if (sig == SIGTTIN)
     {
       set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
-      if (con.disable_master_thread)
-	{
-	  con.disable_master_thread = false;
-	  init_console_handler (false);
-	}
+      con.disable_master_thread = false;
     }
   if (sig == SIGTTOU)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
@@ -1406,7 +1402,8 @@ bool
 fhandler_console::open_setup (int flags)
 {
   set_flags ((flags & ~O_TEXT) | O_BINARY);
-  myself->set_ctty (this, flags);
+  if (myself->set_ctty (this, flags) && !myself->cygstarted)
+    init_console_handler (true);
   return fhandler_base::open_setup (flags);
 }
 
@@ -1422,8 +1419,6 @@ fhandler_console::post_open_setup (int fd)
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
 
-  init_console_handler (need_console_handler ());
-
   fhandler_base::post_open_setup (fd);
 }
 
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 16ea5031b..4d7d273ae 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1392,8 +1392,7 @@ wait_sig (VOID *)
 	  sig_held = true;
 	  break;
 	case __SIGSETPGRP:
-	  if (::cygheap->ctty)
-	    init_console_handler (::cygheap->ctty->need_console_handler ());
+	  init_console_handler (true);
 	  break;
 	case __SIGTHREADEXIT:
 	  {
-- 
2.35.1

