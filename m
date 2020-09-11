Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 3C14E3986039
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 10:54:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3C14E3986039
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 08BAs54L009439;
 Fri, 11 Sep 2020 19:54:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 08BAs54L009439
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Date: Fri, 11 Sep 2020 19:54:01 +0900
Message-Id: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 11 Sep 2020 10:54:33 -0000

- In convert_mb_str(), exclude ISO-2022 and ISCII from the processing
  for the case that the multibyte char is splitted in the middle.
  The reason is as follows.
  * ISO-2022 is too complicated to handle correctly.
  * Not sure what to do with ISCII.
---
 winsup/cygwin/fhandler_tty.cc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 37d033bbe..ee5c6a90a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -117,6 +117,9 @@ CreateProcessW_Hooked
   return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
 
+#define IS_ISO_2022(x) ( (x) >= 50220 && (x) <= 50229 )
+#define IS_ISCII(x) ( (x) >= 57002 && (x) <= 57011 )
+
 static void
 convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
 		UINT cp_from, const char *ptr_from, size_t len_from,
@@ -126,8 +129,10 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
   tmp_pathbuf tp;
   wchar_t *wbuf = tp.w_get ();
   int wlen = 0;
-  if (cp_from == CP_UTF7)
-    /* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
+  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
+    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
+       - ISO-2022 is too complicated to handle correctly.
+       - FIXME: Not sure what to do for ISCII.
        Therefore, just convert string without checking */
     wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
 				wbuf, NT_MAX_PATH);
-- 
2.28.0

