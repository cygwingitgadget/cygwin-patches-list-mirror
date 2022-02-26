Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 0032F3858D1E
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 10:36:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0032F3858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 21QAZlQ7006316;
 Sat, 26 Feb 2022 19:35:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21QAZlQ7006316
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645871751;
 bh=VfjGbJS3BTpYCpcCT1o8cLuvdJNJKt1N25xwbDLoLHY=;
 h=From:To:Cc:Subject:Date:From;
 b=CpUslE+hlh02J7t/2hpAyqiaoP/qU+kc/juvg0+EBx7fju/DQjHG78eqIwjums6ZR
 4nKy1paUFaBNCszGVYNplXZl4C1pMcrYY6NUB8GMz7EGgG6jN9hPcGVA+fmBctmH5P
 4IcEzM0n7Tzry+1nYyStMHUM3vegxUroX/QmWHTeNSCLAHIvI+WVg8ZVIEKQQ6GTaR
 yIAlxwbthRF25Vqr+Xn0nMZhbqipzU7aB49WWznGGQrBQdLnW/kYelVfjLlSvL5mZt
 Ds+E58Dlnbhyaj9Y24MRUk4jzk7TboW0MlGOx36WwwlornGW/FSlAnaKHU6rEyLfHU
 PMAFzu3PG4CsA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Stop to send CTRL_C_EVENT if pcon activated.
Date: Sat, 26 Feb 2022 19:35:38 +0900
Message-Id: <20220226103538.1506-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 26 Feb 2022 10:36:08 -0000

- The commit "Cygwin: console: Redesign handling of special keys."
  removes special treatment for pty in with pseudo console activated,
  however, it is necessary on second thought. This is because sending
  CTRL_C_EVENT to non-cygwin apps will be done in pseudo console,
  therefore, sending it in fhandler_pty_master::write() duplicates
  that event for non-cygwin apps.
---
 winsup/cygwin/fhandler.h          |  2 ++
 winsup/cygwin/fhandler_termios.cc | 11 ++++-------
 winsup/cygwin/fhandler_tty.cc     | 11 +++++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 0652075b0..fda5a4ec9 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1958,6 +1958,7 @@ class fhandler_termios: public fhandler_base
   virtual void cleanup_before_exit () {}
   virtual void setpgid_aux (pid_t pid) {}
   virtual bool need_console_handler () { return false; }
+  virtual bool need_send_ctrl_c_event () { return true; }
 };
 
 enum ansi_intensity
@@ -2492,6 +2493,7 @@ public:
   void get_master_thread_param (master_thread_param_t *p);
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   void set_mask_flusho (bool m) { get_ttyp ()->mask_flusho = m; }
+  bool need_send_ctrl_c_event ();
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index b236c1b62..568523390 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -359,16 +359,12 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	     instead. */
 	  if ((p->process_state & PID_NEW_PG)
 	      && (p->process_state & PID_NOTCYGWIN))
-	    {
-	      GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT,
-					p->dwProcessId);
-	      need_discard_input = true;
-	    }
-	  else if (!ctrl_c_event_sent)
+	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, p->dwProcessId);
+	  else if ((!fh || fh->need_send_ctrl_c_event () || cyg_leader)
+			  && !ctrl_c_event_sent)
 	    {
 	      GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0);
 	      ctrl_c_event_sent = true;
-	      need_discard_input = true;
 	    }
 	  if (resume_pid && fh && !fh->is_console ())
 	    {
@@ -377,6 +373,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      if (::cygheap->ctty && ::cygheap->ctty->is_console ())
 		init_console_handler (true);
 	    }
+	  need_discard_input = true;
 	}
       if (p && p->ctty == ttyp->ntty && p->pgid == pgid)
 	{
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 2440318b8..9855f54eb 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -4105,3 +4105,14 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
     }
   ReleaseMutex (pcon_mutex);
 }
+
+bool
+fhandler_pty_master::need_send_ctrl_c_event ()
+{
+  /* If pseudo console is activated, sending CTRL_C_EVENT to non-cygwin
+     apps will be done in pseudo console, therefore, sending it in
+     fhandler_pty_master::write() duplicates that event for non-cygwin
+     apps. So return false if pseudo console is activated. */
+  return !(to_be_read_from_pcon () && get_ttyp ()->pcon_activated
+    && get_ttyp ()->pcon_input_state == tty::to_nat);
+}
-- 
2.35.1

