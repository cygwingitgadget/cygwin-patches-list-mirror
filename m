Return-Path: <cygwin-patches-return-9966-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6433 invoked by alias); 21 Jan 2020 02:22:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6422 invoked by uid 89); 21 Jan 2020 02:22:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=tty, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 21 Jan 2020 02:22:13 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-06.nifty.com with ESMTP id 00L2M3hm018393;	Tue, 21 Jan 2020 11:22:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com 00L2M3hm018393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579573328;	bh=s2QiNydcKkcHJ+mo5j+nup2s/xMztF421C9vZRQrAK4=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=zzQRMpT9HbvAAH6joN+KufbIqBq7Nw/oeo3Htw1hgpbw+a4doxAPbzf82KuaXmBrs	 c5tne2fZEi6TYghRuGhRSZKtkxSNEk2PeFym1RpKsu+xcqXjDx8UApTdyO5oyLNowU	 LYFNeDVUXUFnGN96Tdk09VEiTw9o/8WBmZMp2cM1SR0G2jvITLxDb1GFBkHaTIwBFh	 vJ8dwVrip9tt9j4Pnl/y1oanvBwRlJA4ibDy3NGR5dCdvlEkQmxAGDMaL3YQ1PlGOA	 7U18gztz+hcY/japBwSDpDrIQjRFfymld/SQH0cIGY8S7dNhbLkX6HriwcI8Hbr+c9	 wjssn6/FdMrhA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding by master_fwd_thread.
Date: Tue, 21 Jan 2020 02:22:00 -0000
Message-Id: <20200121022202.2960-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200121111556.ceb40aa746220718b44dfb25@nifty.ne.jp>
References: <20200121111556.ceb40aa746220718b44dfb25@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00072.txt

- Though this rarely happens, sometimes the first printing of non-
  cygwin process does not displayed correctly. To fix this issue,
  the code for waiting for forwarding by master_fwd_thread is revised.
---
 winsup/cygwin/fhandler_tty.cc | 15 +++++++++++----
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a5db0967b..6c050e32a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -648,7 +648,7 @@ fhandler_pty_master::process_slave_output (char *buf, size_t len, int pktmode_on
       /* If echo pipe has data (something has been typed or pasted), prefer
          it over slave output. */
       if (echo_cnt > 0)
-      	{
+	{
 	  if (!ReadFile (echo_r, outbuf, rlen, &n, NULL))
 	    {
 	      termios_printf ("ReadFile on echo pipe failed, %E");
@@ -1109,7 +1109,7 @@ skip_console_setting:
     }
   else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
     {
-      Sleep (20);
+      cygwait (get_ttyp ()->fwd_done, INFINITE);
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
 	get_ttyp ()->pcon_pid = myself->pid;
@@ -1151,7 +1151,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       SetConsoleMode (get_handle (), mode & ~ENABLE_ECHO_INPUT);
     }
   if (get_ttyp ()->switch_to_pcon_out)
-    Sleep (20); /* Wait for pty_master_fwd_thread() */
+    /* Wait for pty_master_fwd_thread() */
+    cygwait (get_ttyp ()->fwd_done, INFINITE);
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->switch_to_pcon_out = false;
@@ -2202,6 +2203,8 @@ fhandler_pty_master::close ()
 	    }
 	  release_output_mutex ();
 	  master_fwd_thread->terminate_thread ();
+	  CloseHandle (get_ttyp ()->fwd_done);
+	  get_ttyp ()->fwd_done = NULL;
 	}
     }
 
@@ -2718,7 +2721,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 	      SetConsoleMode (get_output_handle (), mode);
 	      if (!get_ttyp ()->switch_to_pcon_out)
-		Sleep (20);
+		cygwait (get_ttyp ()->fwd_done, INFINITE);
 	      if (get_ttyp ()->pcon_pid == 0 ||
 		  kill (get_ttyp ()->pcon_pid, 0) != 0)
 		get_ttyp ()->pcon_pid = myself->pid;
@@ -3000,11 +3003,14 @@ fhandler_pty_master::pty_master_fwd_thread ()
   termios_printf ("Started.");
   for (;;)
     {
+      if (::bytes_available (rlen, from_slave) && rlen == 0)
+	SetEvent (get_ttyp ()->fwd_done);
       if (!ReadFile (from_slave, outbuf, sizeof outbuf, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
 	}
+      ResetEvent (get_ttyp ()->fwd_done);
       ssize_t wlen = rlen;
       char *ptr = outbuf;
       if (get_pseudo_console ())
@@ -3367,6 +3373,7 @@ fhandler_pty_master::setup ()
       errstr = "pty master forwarding thread";
       goto err;
     }
+  get_ttyp ()->fwd_done = CreateEvent (&sec_none, true, false, NULL);
 
   setup_pseudoconsole ();
 
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 695ce91f1..ef9bbc1ff 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -245,6 +245,7 @@ tty::init ()
   num_pcon_attached_slaves = 0;
   term_code_page = 0;
   need_redraw_screen = false;
+  fwd_done = NULL;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index cd4c0ed44..b291fd3c1 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -106,6 +106,7 @@ private:
   int num_pcon_attached_slaves;
   UINT term_code_page;
   bool need_redraw_screen;
+  HANDLE fwd_done;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.21.0
