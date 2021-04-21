Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 8FC3A3846457
 for <cygwin-patches@cygwin.com>; Wed, 21 Apr 2021 03:06:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8FC3A3846457
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 13L3649j013542;
 Wed, 21 Apr 2021 12:06:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 13L3649j013542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618974371;
 bh=4filkDK542E6YuaxgStYPN9omA4kMSL4euTe4wsBeJE=;
 h=From:To:Cc:Subject:Date:From;
 b=NJRZq4Sd3GskwEXzQcGLdGEl+L3s007Kj1YfZ3x4SP953PGeUSD93RAYMwUp3gAFR
 SYqGwXaxsDmQGPymHllCiExyMBPywtifACrqpT3xJHh9f/BK1R8oThSbMqRigmsCk2
 p/DhZAJof0ulutD710ysnai/mZ17VU+gYkWOaItIdA4drmfY5L4sCAfhK1DMmWP725
 Z4i/PKKC1EUq4YILZcaf9xiS6ageYYVwxKbt8BNqOLz9hY+6FozkXP+JSnSaD2kEob
 N2CdUsu0ej7zo6bTKuvrCT9aJ7R065mSwHV0zmU1N6KrpTaoQlZG20bLzoQflh6+j/
 soNebdrD8F3Dw==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Additional race issue fix regarding pseudo
 console.
Date: Wed, 21 Apr 2021 12:06:00 +0900
Message-Id: <20210421030600.3793-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
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
X-List-Received-Date: Wed, 21 Apr 2021 03:06:28 -0000

- In commit bb93c6d7, the race issue was not completely fixed. In
  the pseudo console inheritance, if the destination process to
  which the ownership of pseudo console switches, is found but exits
  before switching, the inheritance fails. Currently, this extremely
  rarely happens. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 47 +++++++++++------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index d44728795..e4480771b 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -64,6 +64,8 @@ struct pipe_reply {
 
 extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
 
+inline static bool pcon_pid_alive (DWORD pid);
+
 DWORD
 fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
 					     bool cygwin, bool stub_only)
@@ -90,20 +92,18 @@ fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
 	else
 	  {
 	    pinfo p (cygwin_pid (list[i]));
-	    if (!!p && p->dwProcessId && p->exec_dwProcessId
-		&& p->dwProcessId != p->exec_dwProcessId)
+	    if (!!p && p->exec_dwProcessId)
 	      {
-		res_pri = list[i];
+		res_pri = stub_only ? p->exec_dwProcessId : list[i];
 		break;
 	      }
-	    if (!!p && !res)
+	    if (!p && !res && pcon_pid_alive (list[i]) && stub_only)
+	      res = list[i];
+	    if (!!p && !res && !stub_only)
 	      res = list[i];
 	  }
       }
-  if (stub_only)
-    return res_pri;
-  else
-    return res_pri ?: res;
+  return res_pri ?: res;
 }
 
 static bool isHybrid;
@@ -3384,35 +3384,17 @@ fallback:
 void
 fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 {
-  DWORD switch_to_stub = 0, switch_to = 0;
-  DWORD new_pcon_pid = 0;
+  DWORD switch_to = 0;
   if (force_switch_to)
     {
-      switch_to_stub = force_switch_to;
-      new_pcon_pid = force_switch_to;
+      switch_to = force_switch_to;
       ttyp->setpgid (force_switch_to + MAX_PID);
     }
   else if (pcon_pid_self (ttyp->pcon_pid))
     {
       /* Search another process which attaches to the pseudo console */
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
-      switch_to = get_console_process_id (current_pid, false, true);
-      if (switch_to)
-	{
-	  pinfo p (cygwin_pid (switch_to));
-	  if (p)
-	    {
-	      if (p->exec_dwProcessId)
-		switch_to_stub = p->exec_dwProcessId;
-	      new_pcon_pid = p->exec_dwProcessId;
-	    }
-	}
-      else
-	{
-	  switch_to = get_console_process_id (current_pid, false, false);
-	  if (switch_to)
-	    new_pcon_pid = switch_to;
-	}
+      switch_to = get_console_process_id (current_pid, false, true, true);
     }
   if (ttyp->pcon_activated)
     {
@@ -3420,7 +3402,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
       ttyp->previous_output_code_page = GetConsoleOutputCP ();
       if (pcon_pid_self (ttyp->pcon_pid))
 	{
-	  switch_to = switch_to_stub ?: switch_to;
 	  if (switch_to)
 	    {
 	      /* Change pseudo console owner to another process */
@@ -3454,7 +3435,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	      CloseHandle (ttyp->h_pcon_conhost_process);
 	      CloseHandle (ttyp->h_pcon_in);
 	      CloseHandle (ttyp->h_pcon_out);
-	      ttyp->pcon_pid = new_pcon_pid;
+	      ttyp->pcon_pid = switch_to;
 	      ttyp->h_pcon_write_pipe = new_write_pipe;
 	      ttyp->h_pcon_condrv_reference = new_condrv_reference;
 	      ttyp->h_pcon_conhost_process = new_conhost_process;
@@ -3513,8 +3494,8 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
     }
   else if (pcon_pid_self (ttyp->pcon_pid))
     {
-      if (switch_to_stub)
-	ttyp->pcon_pid = new_pcon_pid;
+      if (switch_to)
+	ttyp->pcon_pid = switch_to;
       else
 	{
 	  ttyp->pcon_pid = 0;
-- 
2.31.1

