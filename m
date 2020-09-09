Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 2E93E3959E6A
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 15:28:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2E93E3959E6A
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 089FS82R025865;
 Thu, 10 Sep 2020 00:28:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 089FS82R025865
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 2/2] Cygwin: pty: Fix input charset for non-cygwin apps
 with disable_pcon.
Date: Thu, 10 Sep 2020 00:28:00 +0900
Message-Id: <20200909152800.791-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909152800.791-1-takashi.yano@nifty.ne.jp>
References: <20200909152800.791-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 09 Sep 2020 15:28:33 -0000

- If the non-cygwin apps is executed under pseudo console disabled,
  multibyte input for the apps are garbled. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_tty.cc | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0bfc32ea9..1b021661f 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -295,8 +295,22 @@ fhandler_pty_master::accept_input ()
   bytes_left = eat_readahead (-1);
 
   HANDLE write_to = get_output_handle ();
+  tmp_pathbuf tp;
   if (to_be_read_from_pcon ())
-    write_to = to_slave;
+    {
+      write_to = to_slave;
+      UINT cp_to = GetConsoleCP ();
+      if (get_ttyp ()->term_code_page != cp_to)
+	{
+	  static mbstate_t mbp;
+	  char *mbbuf = tp.c_get ();
+	  size_t nlen = NT_MAX_PATH;
+	  convert_mb_str (cp_to, mbbuf, &nlen,
+			  get_ttyp ()->term_code_page, p, bytes_left, &mbp);
+	  p = mbbuf;
+	  bytes_left = nlen;
+	}
+    }
 
   if (!bytes_left)
     {
-- 
2.28.0

