Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 31BA73857C5C
 for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2022 13:33:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 31BA73857C5C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 224DX4oJ017123;
 Fri, 4 Mar 2022 22:33:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 224DX4oJ017123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646400790;
 bh=y2gslNYvn4M9nwc+sXwnac/N6pZ0ilHzM4Kicgyju9c=;
 h=From:To:Cc:Subject:Date:From;
 b=oiqLlsfyl/k27dN1KtDDTAERE/AvoUC7751xiFjM5iRIB4arjVOL2nkz4G39jS8Bh
 aprRf5dTSPc1FtlDXkrl7cU1vHGfk1Ws6n+DRGBQgGFc0v/ZfSsGyJbbKPQgszfrIK
 Q0T2waocDAoQXm9jXX3ruBhowpd2sptIHwAWLw/xRps4vHHELYwdtwbXKTgIABKwHR
 +0ftgJ1WxQ6PMtYtymv1QH0qTw8DFREtz/hopGdmOhanChcxzo/Pfz3PlHD4BYOFiW
 nzScaTwxaINGtJPkX3rGHtKNDP0uKqehqxLZq7fZ5RW65akrC5VDvzSB/CJN1FR1PL
 nWzqKXJ4k+aWQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Update some comments in pty code.
Date: Fri,  4 Mar 2022 22:32:56 +0900
Message-Id: <20220304133257.1204-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 04 Mar 2022 13:33:29 -0000

---
 winsup/cygwin/fhandler_tty.cc | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a0a5a70ba..cba25ee84 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -525,8 +525,11 @@ fhandler_pty_master::accept_input ()
   if (to_be_read_from_nat_pipe ()
       && get_ttyp ()->pty_input_state == tty::to_nat)
     {
-      write_to = to_slave_nat;
+      /* This code is reached if non-cygwin app is foreground and
+	 pseudo console is not enabled. */
+      write_to = to_slave_nat; /* write to nat pipe rather than cyg pipe. */
 
+      /* Charset conversion for non-cygwin apps. */
       UINT cp_to;
       pinfo pinfo_target = pinfo (get_ttyp ()->invisible_console_pid);
       DWORD target_pid = 0;
@@ -607,7 +610,8 @@ fhandler_pty_master::accept_input ()
     }
 
   if (write_to == get_output_handle ())
-    SetEvent (input_available_event);
+    SetEvent (input_available_event); /* Set input_available_event only when
+					 the data is written to cyg pipe. */
   ReleaseMutex (input_mutex);
   return ret;
 }
@@ -1113,7 +1117,7 @@ nat_pipe_owner_self (DWORD pid)
   return (pid == (myself->exec_dwProcessId ?: myself->dwProcessId));
 }
 
-/* This function is called from many pty slave functions. The purpose
+/* This function is called from some pty slave functions. The purpose
    of this function is cleaning up the nat pipe state which is marked
    as active but actually not used anymore. This is needed only when
    non-cygwin process is not terminated cleanly. */
@@ -1207,7 +1211,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
     }
   if (isHybrid)
     return;
-  if (get_ttyp ()->pcon_start) /* Pseudo console is initialization on going */
+  if (get_ttyp ()->pcon_start) /* Pseudo console initialization is on going */
     return;
   DWORD wait_ret = WaitForSingleObject (pipe_sw_mutex, mutex_timeout);
   if (wait_ret == WAIT_TIMEOUT)
@@ -2161,7 +2165,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   push_process_state process_state (PID_TTYOU);
 
   if (get_ttyp ()->pcon_start)
-    {
+    { /* Reaches here when pseudo console initialization is on going. */
       /* Pseudo condole support uses "CSI6n" to get cursor position.
 	 If the reply for "CSI6n" is divided into multiple writes,
 	 pseudo console sometimes does not recognize it.  Therefore,
@@ -2201,6 +2205,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	}
       if (state == 2)
 	{
+	  /* req_xfer_input is true if "ESC[6n" was sent just for
+	     triggering transfer_input() in master. In this case,
+	     the responce sequence should not be written. */
 	  if (!get_ttyp ()->req_xfer_input)
 	    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
 	  ixput = 0;
@@ -2211,7 +2218,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       ReleaseMutex (input_mutex);
 
       if (!get_ttyp ()->pcon_start)
-	{
+	{ /* Pseudo console initialization has been done in above code. */
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
 	  bool pcon_fg = (pp && get_ttyp ()->getpgid () == pp->pgid);
 	  /* GDB may set WINPID rather than cygwin PID to process group
@@ -2243,7 +2250,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   WaitForSingleObject (input_mutex, mutex_timeout);
   if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
       && get_ttyp ()->pty_input_state == tty::to_nat)
-    {
+    { /* Reaches here when non-cygwin app is foreground and pseudo console
+	 is activated. */
       tmp_pathbuf tp;
       char *buf = (char *) ptr;
       size_t nlen = len;
@@ -2277,6 +2285,10 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       return len;
     }
 
+  /* The code path reaches here when pseudo console is not activated
+     or cygwin process is foreground even though pseudo console is
+     activated. */
+
   /* This input transfer is needed when cygwin-app which is started from
      non-cygwin app is terminated if pseudo console is disabled. */
   if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
@@ -3197,7 +3209,8 @@ fhandler_pty_slave::setup_pseudoconsole ()
 	{ /* Send CSI6n just for requesting transfer input. */
 	  DWORD n;
 	  WaitForSingleObject (input_mutex, mutex_timeout);
-	  get_ttyp ()->req_xfer_input = true;
+	  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
+						 is just for transfer input */
 	  get_ttyp ()->pcon_start = true;
 	  get_ttyp ()->pcon_start_pid = myself->pid;
 	  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
-- 
2.35.1

