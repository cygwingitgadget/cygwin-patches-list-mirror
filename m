Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id C88CC386EC3A
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 08:07:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C88CC386EC3A
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 08987KQB011725;
 Wed, 9 Sep 2020 17:07:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 08987KQB011725
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: pty: Fix input charset for non-cygwin apps with
 disable_pcon.
Date: Wed,  9 Sep 2020 17:07:21 +0900
Message-Id: <20200909080721.409-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909080721.409-1-takashi.yano@nifty.ne.jp>
References: <20200909080721.409-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 09 Sep 2020 08:08:02 -0000

- If the non-cygwin apps is executed under pseudo console disabled,
  multibyte input for the apps are garbled. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_tty.cc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e7485af72..7fa8c99e8 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -309,8 +309,18 @@ fhandler_pty_master::accept_input ()
   bytes_left = eat_readahead (-1);
 
   HANDLE write_to = get_output_handle ();
+  tmp_pathbuf tp;
+  char *mbbuf = tp.c_get ();
   if (to_be_read_from_pcon ())
-    write_to = to_slave;
+    {
+      write_to = to_slave;
+      static mbpend_t mbpend;
+      size_t nlen = NT_MAX_PATH;
+      convert_mb_str (GetConsoleCP (), mbbuf, &nlen,
+		      get_ttyp ()->term_code_page, p, bytes_left, &mbpend);
+      p = mbbuf;
+      bytes_left = nlen;
+    }
 
   if (!bytes_left)
     {
-- 
2.28.0

