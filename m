Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 045553858D29
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 23:27:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 045553858D29
Received: from localhost.localdomain (y084061.dynamic.ppp.asahi-net.or.jp
 [118.243.84.61]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 12LNQsMD020384;
 Mon, 22 Mar 2021 08:27:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 12LNQsMD020384
X-Nifty-SrcIP: [118.243.84.61]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/3] Cygwin: pty: Add hook for GetStdHandle() to return
 appropriate handle.
Date: Mon, 22 Mar 2021 08:26:46 +0900
Message-Id: <20210321232647.56-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210321232647.56-1-takashi.yano@nifty.ne.jp>
References: <20210321232647.56-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sun, 21 Mar 2021 23:27:50 -0000

- Currently, GetStdHandle(STD_INPUT_HANDLE) returns input handle for
  non-cygwin process. If cygwin process read from non-cygwin pipe,
  this causes hang up because master writes input to cygwin pipe.
  Also, setup_locale() is called to make charset conversion for output
  handle work properly.
---
 winsup/cygwin/fhandler_tty.cc | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 02e94efcc..682264130 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -118,7 +118,7 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
   fhandler_pty_slave *ptys_pcon = NULL;
   while ((fd = cfd.next ()) >= 0)
     {
-      if (*in == cfd->get_handle () ||
+      if (*in == cfd->get_handle () || *in == cfd->get_handle_cyg () ||
 	  (fd == 0 && *in == GetStdHandle (STD_INPUT_HANDLE)))
 	replace_in = (fhandler_base *) cfd;
       if (*out == cfd->get_output_handle () ||
@@ -140,12 +140,7 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
   if (!iscygwin && ptys_pcon)
     ptys_pcon->set_switch_to_pcon ();
   if (replace_in)
-    {
-      if (iscygwin && ptys_pcon->pcon_activated ())
-	*in = replace_in->get_handle_cyg ();
-      else
-	*in = replace_in->get_handle ();
-    }
+    *in = replace_in->get_handle ();
   if (replace_out)
     *out = replace_out->get_output_handle ();
   if (replace_err)
@@ -157,6 +152,7 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
 DEF_HOOK (CreateProcessA);
 DEF_HOOK (CreateProcessW);
 DEF_HOOK (exit);
+DEF_HOOK (GetStdHandle);
 
 static BOOL WINAPI
 CreateProcessA_Hooked
@@ -300,6 +296,23 @@ exit_Hooked (int e)
   exit_Orig (e);
 }
 
+static HANDLE WINAPI
+GetStdHandle_Hooked (DWORD h)
+{
+  HANDLE r = GetStdHandle_Orig (h);
+  cygheap_fdenum cfd (false);
+  while (cfd.next () >= 0)
+    if (cfd->get_major () == DEV_PTYS_MAJOR)
+      {
+	fhandler_pty_slave *ptys =
+	  (fhandler_pty_slave *) (fhandler_base *) cfd;
+	ptys->setup_locale ();
+	if (r == cfd->get_handle ())
+	  return cfd->get_handle_cyg ();
+      }
+  return r;
+}
+
 static void
 convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
 		UINT cp_from, const char *ptr_from, size_t len_from,
@@ -2349,6 +2362,7 @@ fhandler_pty_slave::fixup_after_exec ()
   DO_HOOK (NULL, CreateProcessW);
   if (CreateProcessA_Orig || CreateProcessW_Orig)
     DO_HOOK (NULL, exit);
+  DO_HOOK (NULL, GetStdHandle);
 }
 
 /* This thread function handles the master control pipe.  It waits for a
-- 
2.30.2

