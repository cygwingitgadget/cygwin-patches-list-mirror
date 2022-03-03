Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 9AC803858D20
 for <cygwin-patches@cygwin.com>; Thu,  3 Mar 2022 18:14:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9AC803858D20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 223IE7Em029816;
 Fri, 4 Mar 2022 03:14:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 223IE7Em029816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646331252;
 bh=tPJdX/+M2FQa+Ayp2dQf2J3AhTWLccN9Gqb9HcdfBME=;
 h=From:To:Cc:Subject:Date:From;
 b=aQgGUwJECY86bQyxAUMfvHsyvGgFpa5UbhPIwixkRxLLGvKU53cA3R1YZz9q3VV9/
 kfPR9qR05U2M99L/QgBtMOorcB34JhCDIddy0aJHO4cULwphUN5a6xoITjvbOlKfpp
 IB5ahDK2lJatNaoTP9gnWQC/O0NrN9Sl7ZE6+zlqK8ORfu889gnclFZ3brVe3yzDGO
 yhodRONs35y8TPIsqi5TsiZtbSeTU9YQ+8uo/QKhFa5WfqIaUw4EHClTF2iQnCv6CR
 sLXMIdcx+Fr16ako5M5FXpu98H7vLX0UqN06wzuy5FHmSKzKXpkOoG/m0RqXmjz+3z
 d3cn37KZDAvWw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Rename nat_pipe_owner_alive() to process_alive().
Date: Fri,  4 Mar 2022 03:14:01 +0900
Message-Id: <20220303181401.5101-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 03 Mar 2022 18:14:38 -0000

- The function nat_pipe_owner_alive() is used even for the process
  which is not a nat pipe owner, so, it is renamed to process_alive().
---
 winsup/cygwin/fhandler_tty.cc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 43668975f..be3e6fcba 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -74,7 +74,7 @@ void release_attach_mutex (void)
   ReleaseMutex (attach_mutex);
 }
 
-inline static bool nat_pipe_owner_alive (DWORD pid);
+inline static bool process_alive (DWORD pid);
 
 DWORD
 fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
@@ -107,7 +107,7 @@ fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
 		res_pri = stub_only ? p->exec_dwProcessId : list[i];
 		break;
 	      }
-	    if (!p && !res && nat_pipe_owner_alive (list[i]) && stub_only)
+	    if (!p && !res && process_alive (list[i]) && stub_only)
 	      res = list[i];
 	    if (!!p && !res && !stub_only)
 	      res = list[i];
@@ -1086,8 +1086,11 @@ fhandler_pty_slave::set_switch_to_nat_pipe (void)
 }
 
 inline static bool
-nat_pipe_owner_alive (DWORD pid)
+process_alive (DWORD pid)
 {
+  /* This function is very similar to _pinfo::alive(), however, this
+     can be used for non-cygwin process which is started from non-cygwin
+     shell. In addition, this checks exit code as well. */
   if (pid == 0)
     return false;
   HANDLE h = OpenProcess (PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
@@ -1208,7 +1211,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
   if (wait_ret == WAIT_TIMEOUT)
     return;
   if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid)
-      && nat_pipe_owner_alive (get_ttyp ()->nat_pipe_owner_pid))
+      && process_alive (get_ttyp ()->nat_pipe_owner_pid))
     {
       /* There is a process which owns nat pipe. */
       if (!to_be_read_from_nat_pipe ()
@@ -3421,7 +3424,7 @@ skip_create:
     }
   while (false);
 
-  if (!nat_pipe_owner_alive (get_ttyp ()->nat_pipe_owner_pid))
+  if (!process_alive (get_ttyp ()->nat_pipe_owner_pid))
     get_ttyp ()->nat_pipe_owner_pid = myself->exec_dwProcessId;
 
   if (hpcon && nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
@@ -4044,7 +4047,7 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
     {
       fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
       ptys->get_ttyp ()->switch_to_nat_pipe = true;
-      if (!nat_pipe_owner_alive (ptys->get_ttyp ()->nat_pipe_owner_pid))
+      if (!process_alive (ptys->get_ttyp ()->nat_pipe_owner_pid))
 	ptys->get_ttyp ()->nat_pipe_owner_pid = myself->exec_dwProcessId;
     }
   bool pcon_enabled = false;
-- 
2.35.1

