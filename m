Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 339E93858D1E
 for <cygwin-patches@cygwin.com>; Fri,  4 Mar 2022 23:43:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 339E93858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 224NgNs8009453;
 Sat, 5 Mar 2022 08:42:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 224NgNs8009453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646437353;
 bh=su4qEOCdwqqVpsHfw2v6KEyXDJ65rN4mQ90Gba5lH2o=;
 h=From:To:Cc:Subject:Date:From;
 b=hzk3wkE3R3P+clJMQ4hExoJ7bfNXl7ahLctVJ0ZlfLq+IysxbajTYKDLZzCDV2YH1
 HUheurWLX2vroDI46l+l1YGJu1J9zZm9Hfh6V5a1eVaY1uOZeDKfbTxbil9GEtFGS7
 QovTJf3MGxSQRMTX4ZhuIYf8uIrKGihVnL3kD8SpHZ06rDv05P1ODlLln5I4YneLJz
 WKowCKoK4VDrW0Zmel1gZfOy6AZKpM12icC8oaEA8OFYL38ARm3R97taOByvuYalci
 bwKICR3zZZm7Zvsbhg6aSukllZO8jMd8+8uUWJk1kxbiO1LTQj9W16YfWRM+QDxAjr
 UISeEz1nlxQWQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Add several further comments to the pty code.
Date: Sat,  5 Mar 2022 08:42:22 +0900
Message-Id: <20220304234222.2319-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 04 Mar 2022 23:43:10 -0000

---
 winsup/cygwin/fhandler_tty.cc | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0c762d75e..c2e612580 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -76,6 +76,13 @@ void release_attach_mutex (void)
 
 inline static bool process_alive (DWORD pid);
 
+/* This functions looks for a process which attached to the same console
+   with current process and is matched to given conditions:
+     match: If true, return given pid if the process pid attaches to the
+	    same console, otherwise, return 0. If false, return pid except
+	    for given pid.
+     cygwin: return only process's pid which has cygwin pid.
+     stub_only: return only stub process's pid of non-cygwin process. */
 DWORD
 fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
 					     bool cygwin, bool stub_only)
@@ -158,6 +165,7 @@ set_switch_to_nat_pipe (HANDLE *in, HANDLE *out, HANDLE *err)
     *err = replace_err->get_output_handle_nat ();
 }
 
+/* Determine if the given path is cygwin binary. */
 static bool
 path_iscygexec_a_w (LPCSTR na, LPSTR ca, LPCWSTR nw, LPWSTR cw)
 {
@@ -3860,6 +3868,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 
   if (dir == tty::to_cyg && ttyp->pcon_activated)
     { /* from handle is console handle */
+      /* Reaches here for nat->cyg case with pcon activated. */
       INPUT_RECORD r[INREC_SIZE];
       DWORD n;
       while (PeekConsoleInputA (from, r, INREC_SIZE, &n) && n)
@@ -3931,7 +3940,8 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	}
     }
   else
-    {
+    { /* Reaches here when both cyg->nat and nat->cyg cases with
+	 pcon not activated or cyg->nat case with pcon activated. */
       DWORD bytes_in_pipe;
       while (::bytes_available (bytes_in_pipe, from) && bytes_in_pipe)
 	{
@@ -3964,9 +3974,11 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	}
     }
 
-  if (dir == tty::to_nat)
+  /* Fix input_available_event which indicates availability in cyg pipe. */
+  if (dir == tty::to_nat) /* all data is transfered to nat pipe,
+			     so no data available in cyg pipe. */
     ResetEvent (input_available_event);
-  else if (transfered)
+  else if (transfered) /* There is data transfered to cyg pipe. */
     SetEvent (input_available_event);
   ttyp->pty_input_state = dir;
   ttyp->discard_input = false;
-- 
2.35.1

