Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id B85853857C5A
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 09:58:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B85853857C5A
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 0889vslk022452;
 Tue, 8 Sep 2020 18:57:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0889vslk022452
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix input charset for non-cygwin apps with
 disable_pcon.
Date: Tue,  8 Sep 2020 18:57:56 +0900
Message-Id: <20200908095757.2042-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 08 Sep 2020 09:58:30 -0000

- If the non-cygwin apps is executed under pseudo console disabled,
  multibyte input for the apps are garbled. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_tty.cc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 6de591d9b..afaa4546e 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -271,8 +271,17 @@ fhandler_pty_master::accept_input ()
   bytes_left = eat_readahead (-1);
 
   HANDLE write_to = get_output_handle ();
+  char *buf = NULL;
   if (to_be_read_from_pcon ())
-    write_to = to_slave;
+    {
+      write_to = to_slave;
+      size_t nlen;
+      buf = convert_mb_str (GetConsoleCP (), &nlen,
+			    get_ttyp ()->term_code_page,
+			    (const char *) p, bytes_left);
+      p = buf;
+      bytes_left = nlen;
+    }
 
   if (!bytes_left)
     {
@@ -305,6 +314,8 @@ fhandler_pty_master::accept_input ()
 	    }
 	}
     }
+  if (buf)
+    mb_str_free (buf);
 
   SetEvent (input_available_event);
   ReleaseMutex (input_mutex);
-- 
2.28.0

