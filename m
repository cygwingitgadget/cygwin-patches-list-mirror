Return-Path: <cygwin-patches-return-10011-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63466 invoked by alias); 27 Jan 2020 11:23:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63446 invoked by uid 89); 27 Jan 2020 11:23:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jan 2020 11:22:57 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-02.nifty.com with ESMTP id 00RBMS5A026238;	Mon, 27 Jan 2020 20:22:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com 00RBMS5A026238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1580124154;	bh=SKgmZHFSt2YtNapb1IvmjXfHZbNckKqKKxpvktYJM0A=;	h=From:To:Cc:Subject:Date:From;	b=Xrt+ASa6rY3z+DWVDKPoLsRsU+yZNG9bDU/YSkUqDulUpGgr6ykzesYtV6akHM+a4	 ICOaum81+GL0hOoVjvMPWoDUerBmhSfmt0Zsq0/9SEOV1OjCWD+EyBLDFr1xMwyiVe	 ZcJ7fdN0+2w0ek94X2qVyrLE9rKnJ2dtbda3nEDGxXKXm9laXfCfwB/mJ1rLwkMMoa	 OkkVEKRy/bhlQ+cqkcgbaaxMYaHPHMeeq8VRZmjOs6pwMYkERP2Odgh3Jl6bpfh8bY	 Ip1cVdbdBZANyAwl9KsokWGZ+46N4/zSJLZ6BDtfsCgdD4BhzhkQvWJqXHZPLBum5v	 gGkMRdIJ8xxOA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5] Cygwin: pty: Revise code waiting for forwarding again.
Date: Mon, 27 Jan 2020 11:23:00 -0000
Message-Id: <20200127112224.1322-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00117.txt

- After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
  cygwin programs which call both printf() and WriteConsole() are
  frequently distorted. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h      |  1 +
 winsup/cygwin/fhandler_tty.cc | 37 +++++++++++++++++++++++++++++------
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 35190c0fe..9ce321c8c 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2209,6 +2209,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   }
   void setup_locale (void);
   void set_freeconsole_on_close (bool val);
+  void wait_pcon_fwd (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 71a1f42ba..3e5017f19 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1109,7 +1109,7 @@ skip_console_setting:
     }
   else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
     {
-      cygwait (get_ttyp ()->fwd_done, INFINITE);
+      wait_pcon_fwd ();
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
 	get_ttyp ()->pcon_pid = myself->pid;
@@ -1152,7 +1152,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
   if (get_ttyp ()->switch_to_pcon_out)
     /* Wait for pty_master_fwd_thread() */
-    cygwait (get_ttyp ()->fwd_done, INFINITE);
+    wait_pcon_fwd ();
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->switch_to_pcon_out = false;
@@ -2680,6 +2680,16 @@ fhandler_pty_slave::set_freeconsole_on_close (bool val)
   freeconsole_on_close = val;
 }
 
+void
+fhandler_pty_slave::wait_pcon_fwd (void)
+{
+  acquire_output_mutex (INFINITE);
+  get_ttyp ()->pcon_last_time = GetTickCount ();
+  ResetEvent (get_ttyp ()->fwd_done);
+  release_output_mutex ();
+  cygwait (get_ttyp ()->fwd_done, INFINITE);
+}
+
 void
 fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 {
@@ -2727,7 +2737,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 	      SetConsoleMode (get_output_handle (), mode);
 	      if (!get_ttyp ()->switch_to_pcon_out)
-		cygwait (get_ttyp ()->fwd_done, INFINITE);
+		wait_pcon_fwd ();
 	      if (get_ttyp ()->pcon_pid == 0 ||
 		  kill (get_ttyp ()->pcon_pid, 0) != 0)
 		get_ttyp ()->pcon_pid = myself->pid;
@@ -3009,14 +3019,29 @@ fhandler_pty_master::pty_master_fwd_thread ()
   termios_printf ("Started.");
   for (;;)
     {
-      if (::bytes_available (rlen, from_slave) && rlen == 0)
-	SetEvent (get_ttyp ()->fwd_done);
+      if (get_pseudo_console ())
+	{
+	  /* The forwarding in pseudo console sometimes stops for
+	     16-32 msec even if it alerady has data to transfer.
+	     If the time without transfer exceeds 32 msec, the
+	     forwarding has supposed to be finished. */
+	  const int sleep_in_pcon = 16;
+	  const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
+	  get_ttyp ()->pcon_last_time = GetTickCount ();
+	  while (::bytes_available (rlen, from_slave) && rlen == 0)
+	    {
+	      acquire_output_mutex (INFINITE);
+	      if (GetTickCount () - get_ttyp ()->pcon_last_time > time_to_wait)
+		SetEvent (get_ttyp ()->fwd_done);
+	      release_output_mutex ();
+	      Sleep (1);
+	    }
+	}
       if (!ReadFile (from_slave, outbuf, sizeof outbuf, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
 	}
-      ResetEvent (get_ttyp ()->fwd_done);
       ssize_t wlen = rlen;
       char *ptr = outbuf;
       if (get_pseudo_console ())
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index ef9bbc1ff..a3d4a0fc8 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -246,6 +246,7 @@ tty::init ()
   term_code_page = 0;
   need_redraw_screen = false;
   fwd_done = NULL;
+  pcon_last_time = 0;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index b291fd3c1..755897d7d 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -107,6 +107,7 @@ private:
   UINT term_code_page;
   bool need_redraw_screen;
   HANDLE fwd_done;
+  DWORD pcon_last_time;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.21.0
