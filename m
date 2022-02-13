Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id EA9E1385840F
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:40:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EA9E1385840F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvL000575;
 Sun, 13 Feb 2022 23:39:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvL000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763194;
 bh=CwriTp+6kEvBnR+CKWca0Vzp7nnIzRqspKDPliWWlco=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m3rlNIdKVsmyBvUuN0VGd5HQFf4c2F1d826Fp7cWW2BCj9CxadMiWXoMmZh3iTmNr
 +wYj9G1b4WKC0B0cocTU6XNXqJ1N6fjZpUJKKi//RgZLJMKE4skcjYNkDkdV2q4oT0
 vAsElNq0JJY7C9vHkJtOIxV6eBhFShUt0gFm+hfliKAhnYYPODFvN4wiJbuXYOqXzI
 83bPIqivh084n4axs2J6wqXup2BrNGM+FZvrPWlHqRfFlafyqIUO2tX92Z2y1OsGYz
 Sch32UUCkZnQnsj4hcxdFoj5g3ri3XdyVcBFaPeAIBX7w15sPR70zJFufNDMcm4Em4
 w81vzZlCc2rHA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/8] Cygwin: pty: Revise the code to wait for completion of
 forwarding.
Date: Sun, 13 Feb 2022 23:39:06 +0900
Message-Id: <20220213143910.1947-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
References: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Sun, 13 Feb 2022 14:40:15 -0000

- With this patch, the code to wait for completion of forwarding of
  output from non-cygwin app is revised so that it can more reliably
  detect the completion.
---
 winsup/cygwin/fhandler_tty.cc |  5 ++++-
 winsup/cygwin/tty.cc          | 11 ++++++-----
 winsup/cygwin/tty.h           |  3 ++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 7e065c46a..7e733e49a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1118,7 +1118,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       if (WaitForSingleObject (h_gdb_process, 0) == WAIT_TIMEOUT)
 	{
 	  if (isHybrid)
-	    get_ttyp ()->wait_pcon_fwd (false);
+	    get_ttyp ()->wait_pcon_fwd ();
 	}
       else
 	{
@@ -2705,6 +2705,9 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
   for (;;)
     {
       p->ttyp->pcon_last_time = GetTickCount ();
+      DWORD n;
+      p->ttyp->pcon_fwd_not_empty =
+	::bytes_available (n, p->from_slave_nat) && n;
       if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 789528856..da75b8dd2 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -240,6 +240,7 @@ tty::init ()
   pcon_pid = 0;
   term_code_page = 0;
   pcon_last_time = 0;
+  pcon_fwd_not_empty = false;
   pcon_start = false;
   pcon_start_pid = 0;
   pcon_cap_checked = false;
@@ -367,7 +368,7 @@ tty_min::setpgid (int pid)
 }
 
 void
-tty::wait_pcon_fwd (bool init)
+tty::wait_pcon_fwd ()
 {
   /* The forwarding in pseudo console sometimes stops for
      16-32 msec even if it already has data to transfer.
@@ -377,11 +378,11 @@ tty::wait_pcon_fwd (bool init)
      thread when the last data is transfered. */
   const int sleep_in_pcon = 16;
   const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
-  if (init)
-    pcon_last_time = GetTickCount ();
-  while (GetTickCount () - pcon_last_time < time_to_wait)
+  int elapsed;
+  while (pcon_fwd_not_empty
+	 || (elapsed = GetTickCount () - pcon_last_time) < time_to_wait)
     {
-      int tw = time_to_wait - (GetTickCount () - pcon_last_time);
+      int tw = pcon_fwd_not_empty ? 10 : (time_to_wait - elapsed);
       cygwait (tw);
     }
 }
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 519d7c0d5..2cd12a665 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -116,6 +116,7 @@ private:
   DWORD pcon_pid;
   UINT term_code_page;
   DWORD pcon_last_time;
+  bool pcon_fwd_not_empty;
   HANDLE h_pcon_write_pipe;
   HANDLE h_pcon_condrv_reference;
   HANDLE h_pcon_conhost_process;
@@ -166,7 +167,7 @@ public:
   void set_master_ctl_closed () {master_pid = -1;}
   static void __stdcall create_master (int);
   static void __stdcall init_session ();
-  void wait_pcon_fwd (bool init = true);
+  void wait_pcon_fwd ();
   bool pcon_input_state_eq (xfer_dir x) { return pcon_input_state == x; }
   bool pcon_fg (pid_t pgid);
   friend class fhandler_pty_common;
-- 
2.35.1

