Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 2E8EA3858024
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 04:02:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2E8EA3858024
Received: from localhost.localdomain (y084061.dynamic.ppp.asahi-net.or.jp
 [118.243.84.61]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 12L41QmZ028950;
 Sun, 21 Mar 2021 13:02:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 12L41QmZ028950
X-Nifty-SrcIP: [118.243.84.61]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: pty: Add hook for GetStdHandle() to return
 appropriate handle.
Date: Sun, 21 Mar 2021 13:01:26 +0900
Message-Id: <20210321040126.1720-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Sun, 21 Mar 2021 04:02:34 -0000

- Currently, GetStdHandle(STD_INPUT_HANDLE) returns input handle for
  non-cygwin process. If cygwin process read from non-cygwin pipe,
  this causes hang up because master writes input to cygwin pipe.
  Also, setup_locale() is called to make charset conversion for output
  handle work properly.
---
 winsup/cygwin/fhandler_tty.cc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 02e94efcc..c1f11f399 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -157,6 +157,7 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
 DEF_HOOK (CreateProcessA);
 DEF_HOOK (CreateProcessW);
 DEF_HOOK (exit);
+DEF_HOOK (GetStdHandle);
 
 static BOOL WINAPI
 CreateProcessA_Hooked
@@ -300,6 +301,23 @@ exit_Hooked (int e)
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
@@ -2349,6 +2367,7 @@ fhandler_pty_slave::fixup_after_exec ()
   DO_HOOK (NULL, CreateProcessW);
   if (CreateProcessA_Orig || CreateProcessW_Orig)
     DO_HOOK (NULL, exit);
+  DO_HOOK (NULL, GetStdHandle);
 }
 
 /* This thread function handles the master control pipe.  It waits for a
-- 
2.30.1

