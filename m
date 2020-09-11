Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 16CF33986039
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 10:55:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 16CF33986039
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 08BAsik8003469;
 Fri, 11 Sep 2020 19:54:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 08BAsik8003469
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Prevent garbled output for existing non-cygwin
 apps.
Date: Fri, 11 Sep 2020 19:54:40 +0900
Message-Id: <20200911105440.199-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Fri, 11 Sep 2020 10:55:10 -0000

- If pseudo console is disabled, non-cygwin apps do not detect
  console device. In this case, some apps output UTF-8 regardless
  of the locale setting. At least git-for-windows, rust-based apps
  and node.js do that. This patch provides backward compatibility
  as default behaviour by setting console codepage to the charset of
  the locale. Even in the cases above, garbled output is prevented
  with this patch in most cases because mintty uses UTF-8 by default.

  I beleave this is not really a problem in cygwin side but that in
  app side, however, some users complain about garbled output with
  existing apps in MSYS2 (which is based on cygwin) in which pseudo
  console is disabled by default.
---
 winsup/cygwin/fhandler_tty.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index ee5c6a90a..3d93bef30 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1835,7 +1835,11 @@ fhandler_pty_slave::setup_locale (void)
   extern UINT __eval_codepage_from_internal_charset ();
 
   if (!get_ttyp ()->term_code_page)
-    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
+    {
+      get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
+      SetConsoleCP (get_ttyp ()->term_code_page);
+      SetConsoleOutputCP (get_ttyp ()->term_code_page);
+    }
 }
 
 void
-- 
2.28.0

