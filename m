Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 52CA93851C3E
 for <cygwin-patches@cygwin.com>; Thu, 28 May 2020 03:43:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 52CA93851C3E
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 04S3hBfY005043;
 Thu, 28 May 2020 12:43:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04S3hBfY005043
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix a bug in free_attached_console().
Date: Thu, 28 May 2020 12:43:05 +0900
Message-Id: <20200528034305.243-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 28 May 2020 03:43:41 -0000

- After commit 7659ff0f5afd751f42485f2684c799c5f37b0fb9, nohup does
  not work as expected. This patch fixes the issue.

  Addresses:
  https://cygwin.com/pipermail/cygwin-developers/2020-May/011885.html
---
 winsup/cygwin/fhandler_tty.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index df08dd20a..f29a2c214 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -188,7 +188,10 @@ set_ishybrid_and_switch_to_pcon (HANDLE h)
 inline void
 fhandler_pty_slave::free_attached_console ()
 {
-  if (freeconsole_on_close && get_minor () == pcon_attached_to)
+  bool attached = get_ttyp () ?
+    fhandler_console::get_console_process_id (get_helper_process_id (), true)
+    : (get_minor () == pcon_attached_to);
+  if (freeconsole_on_close && attached)
     {
       FreeConsole ();
       pcon_attached_to = -1;
-- 
2.26.2

