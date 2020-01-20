Return-Path: <cygwin-patches-return-9955-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81844 invoked by alias); 20 Jan 2020 02:51:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81832 invoked by uid 89); 20 Jan 2020 02:51:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=sk:master_, displayed, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 02:51:23 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 00K2oxAH029775;	Mon, 20 Jan 2020 11:51:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 00K2oxAH029775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579488664;	bh=2seUQ5HttXG+iJlEKlq9wTQpnhr7umNyhbkqSdzxffo=;	h=From:To:Cc:Subject:Date:From;	b=L5BLKm5EseONmmljOkFEK37+b7kJ98e+JiuAUsur+LyOkQLtUSiHc571WCRuI+AJy	 entqOnNrVrW4qbGHj69dpI4c29puZ7tDgHR+NkBliajh6PsDZ+pUM5jgTNzYKZkDrU	 oBQ6d6m9oDv3Km8CrL3p7dlgGTmWIDEtKHqKPsPWKBQP4KZniSYiS5W1I75LuLDx8I	 TBXc4ggkSG7bhw1uWlg9391vDogYHjsLZV63F/q0eWqiXJt0y1Wnb+A9JLbWckKWqR	 XYq2r786e3io82Y9klFG3kiexD0gEpWjtFiRurMpKPLTruoBFYT2nGabonqU17IsI0	 9Euia+EN+4MlQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Revise code waiting for forwarding by master_fwd_thread.
Date: Mon, 20 Jan 2020 02:51:00 -0000
Message-Id: <20200120025058.1568-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00061.txt

- Though this rarely happens, sometimes the first printing of non-
  cygwin process does not displayed correctly. To fix this issue,
  the code for waiting for forwarding by master_fwd_thread is revised.
---
 winsup/cygwin/fhandler.h      |  1 +
 winsup/cygwin/fhandler_tty.cc | 16 +++++++++++++---
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c0d56b4da..f3301b059 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2201,6 +2201,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   }
   void setup_locale (void);
   void set_freeconsole_on_close (bool val);
+  void wait_forwarding (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a5db0967b..c839b9806 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1109,7 +1109,7 @@ skip_console_setting:
     }
   else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
     {
-      Sleep (20);
+      wait_forwarding ();
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
 	get_ttyp ()->pcon_pid = myself->pid;
@@ -1151,7 +1151,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       SetConsoleMode (get_handle (), mode & ~ENABLE_ECHO_INPUT);
     }
   if (get_ttyp ()->switch_to_pcon_out)
-    Sleep (20); /* Wait for pty_master_fwd_thread() */
+    wait_forwarding (); /* Wait for pty_master_fwd_thread() */
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->switch_to_pcon_out = false;
@@ -2718,7 +2718,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 	      SetConsoleMode (get_output_handle (), mode);
 	      if (!get_ttyp ()->switch_to_pcon_out)
-		Sleep (20);
+		wait_forwarding ();
 	      if (get_ttyp ()->pcon_pid == 0 ||
 		  kill (get_ttyp ()->pcon_pid, 0) != 0)
 		get_ttyp ()->pcon_pid = myself->pid;
@@ -2991,6 +2991,15 @@ pty_master_thread (VOID *arg)
   return ((fhandler_pty_master *) arg)->pty_master_thread ();
 }
 
+void
+fhandler_pty_slave::wait_forwarding (void)
+{
+  const DWORD time_to_wait = 40;
+  DWORD elasped = GetTickCount () - get_ttyp ()->last_fwd_time;
+  if (elasped < time_to_wait)
+    Sleep (time_to_wait - elasped);
+}
+
 DWORD
 fhandler_pty_master::pty_master_fwd_thread ()
 {
@@ -3000,6 +3009,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
   termios_printf ("Started.");
   for (;;)
     {
+      get_ttyp ()->last_fwd_time = GetTickCount ();
       if (!ReadFile (from_slave, outbuf, sizeof outbuf, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 695ce91f1..095838f1b 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -245,6 +245,7 @@ tty::init ()
   num_pcon_attached_slaves = 0;
   term_code_page = 0;
   need_redraw_screen = false;
+  last_fwd_time = GetTickCount ();
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index cd4c0ed44..d6b22359a 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -106,6 +106,7 @@ private:
   int num_pcon_attached_slaves;
   UINT term_code_page;
   bool need_redraw_screen;
+  DWORD last_fwd_time;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.21.0
