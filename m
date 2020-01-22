Return-Path: <cygwin-patches-return-9975-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20639 invoked by alias); 22 Jan 2020 16:08:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20615 invoked by uid 89); 22 Jan 2020 16:08:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=sk:get_out, Sleep, from_slave, sk:pty_mas
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 22 Jan 2020 16:08:21 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-02.nifty.com with ESMTP id 00MG82ph013052;	Thu, 23 Jan 2020 01:08:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com 00MG82ph013052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579709287;	bh=I4DNzq52uBM7wJ41Wr+U8NwxWj3IuexaR29rl1PgUCc=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=qqzy3F2iZionZI894XJzd4THD8+1z7IT8mfVo8+qyRw/wA6nHI0i+mFZF7StQQNB8	 iJwiwRIumOHwe9P6oBRHHIs6SEWhyZz87eFyNg8FbOevDl1pTmdbOglNP/CCMNkn9r	 7CWtyQcGW0wUrm79Zw/iLZR/NpbT+pNmD4wjDoCtlqNqKLh9clRtkDIENIk2x/5oFK	 b2JgaWVuhbCpgFhzMKFVFhs5Ay/tcVlcZAbab4WpqELsEWx44QljtdU1BiOzsiS35+	 9Q8P5kHI7OpmZ2KsN0eAJPJsLFHvpGTzaqKWbhLjswhoZvr+lLFG0zLiBYe72+hUON	 ENN09HcH7m3tw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Revise code waiting for forwarding again.
Date: Wed, 22 Jan 2020 16:08:00 -0000
Message-Id: <20200122160755.867-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200123010011.e34b6999f3e852d2b9eb4787@nifty.ne.jp>
References: <20200123010011.e34b6999f3e852d2b9eb4787@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00081.txt

- After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
  cygwin programs which call both printf() and WriteConsole() are
  frequently distorted. This patch reverts waiting function to dumb
  Sleep().
---
 winsup/cygwin/fhandler_tty.cc | 30 +++++++++++++++++++-----------
 winsup/cygwin/tty.cc          |  3 ++-
 winsup/cygwin/tty.h           |  3 ++-
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1710f2520..404216bf6 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1109,7 +1109,9 @@ skip_console_setting:
     }
   else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
     {
-      cygwait (get_ttyp ()->fwd_done, INFINITE);
+      DWORD elasped = GetTickCount () - get_ttyp ()->last_push_time;
+      if (elasped < get_ttyp ()->max_fwd_latency)
+	Sleep (get_ttyp ()->max_fwd_latency - elasped);
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
 	get_ttyp ()->pcon_pid = myself->pid;
@@ -1151,8 +1153,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       SetConsoleMode (get_handle (), mode & ~ENABLE_ECHO_INPUT);
     }
   if (get_ttyp ()->switch_to_pcon_out)
-    /* Wait for pty_master_fwd_thread() */
-    cygwait (get_ttyp ()->fwd_done, INFINITE);
+    Sleep (get_ttyp ()->max_fwd_latency);
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->switch_to_pcon_out = false;
@@ -1187,6 +1188,8 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
     if (!try_reattach_pcon ())
       goto detach;
 
+  get_ttyp ()->last_push_time = GetTickCount ();
+
   char *buf;
   size_t nlen;
   DWORD origCP;
@@ -2210,8 +2213,6 @@ fhandler_pty_master::close ()
 	    }
 	  release_output_mutex ();
 	  master_fwd_thread->terminate_thread ();
-	  CloseHandle (get_ttyp ()->fwd_done);
-	  get_ttyp ()->fwd_done = NULL;
 	}
     }
 
@@ -2728,7 +2729,11 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 	      SetConsoleMode (get_output_handle (), mode);
 	      if (!get_ttyp ()->switch_to_pcon_out)
-		cygwait (get_ttyp ()->fwd_done, INFINITE);
+		{
+		  DWORD elasped = GetTickCount () - get_ttyp ()->last_push_time;
+		  if (elasped < get_ttyp ()->max_fwd_latency)
+		    Sleep (get_ttyp ()->max_fwd_latency - elasped);
+		}
 	      if (get_ttyp ()->pcon_pid == 0 ||
 		  kill (get_ttyp ()->pcon_pid, 0) != 0)
 		get_ttyp ()->pcon_pid = myself->pid;
@@ -3010,14 +3015,12 @@ fhandler_pty_master::pty_master_fwd_thread ()
   termios_printf ("Started.");
   for (;;)
     {
-      if (::bytes_available (rlen, from_slave) && rlen == 0)
-	SetEvent (get_ttyp ()->fwd_done);
       if (!ReadFile (from_slave, outbuf, sizeof outbuf, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
 	}
-      ResetEvent (get_ttyp ()->fwd_done);
+
       ssize_t wlen = rlen;
       char *ptr = outbuf;
       if (get_pseudo_console ())
@@ -3025,7 +3028,13 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  /* Avoid duplicating slave output which is already sent to
 	     to_master_cyg */
 	  if (!get_ttyp ()->switch_to_pcon_out)
-	    continue;
+	    {
+	      DWORD elasped = GetTickCount () - get_ttyp ()->last_push_time;
+	      if (get_ttyp ()->last_push_time &&
+		  elasped > get_ttyp ()->max_fwd_latency)
+		get_ttyp ()->max_fwd_latency = elasped;
+	      continue;
+	    }
 
 	  /* Avoid setting window title to "cygwin-console-helper.exe" */
 	  int state = 0;
@@ -3380,7 +3389,6 @@ fhandler_pty_master::setup ()
       errstr = "pty master forwarding thread";
       goto err;
     }
-  get_ttyp ()->fwd_done = CreateEvent (&sec_none, true, false, NULL);
 
   setup_pseudoconsole ();
 
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index ef9bbc1ff..b290a41e1 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -245,7 +245,8 @@ tty::init ()
   num_pcon_attached_slaves = 0;
   term_code_page = 0;
   need_redraw_screen = false;
-  fwd_done = NULL;
+  max_fwd_latency = 20;
+  last_push_time = 0;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index b291fd3c1..ba2b9074a 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -106,7 +106,8 @@ private:
   int num_pcon_attached_slaves;
   UINT term_code_page;
   bool need_redraw_screen;
-  HANDLE fwd_done;
+  DWORD max_fwd_latency;
+  DWORD last_push_time;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.21.0
