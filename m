Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id F0875385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 11:51:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F0875385701F
Received: from localhost.localdomain (ae236159.dynamic.ppp.asahi-net.or.jp
 [14.3.236.159]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 12NBobg3000325;
 Tue, 23 Mar 2021 20:50:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 12NBobg3000325
X-Nifty-SrcIP: [14.3.236.159]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Rename input/output named pipes.
Date: Tue, 23 Mar 2021 20:50:28 +0900
Message-Id: <20210323115028.1275-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 23 Mar 2021 11:51:09 -0000

- Currently, names of output pipes are "pty%d-to-master" and "pty%d-
  to-master-cyg" and names of input pipes are "pty%d-to-slave" and
  "pty%d-from-master". With this patch, these pipes are renamed to
  "pty%d-to-master-nat", "pty%d-to-master", "pty%d-from-master-nat"
  and "pty%d-from-master" respectively.
---
 winsup/cygwin/fhandler_tty.cc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 643a357ad..d755f7d87 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2768,26 +2768,26 @@ fhandler_pty_master::setup ()
     termios_printf ("can't set output_handle(%p) to non-blocking mode",
 		    get_output_handle ());
 
-  char pipename[sizeof ("ptyNNNN-to-master-cyg")];
-  __small_sprintf (pipename, "pty%d-to-master", unit);
+  char pipename[sizeof ("ptyNNNN-from-master-nat")];
+  __small_sprintf (pipename, "pty%d-to-master-nat", unit);
   res = fhandler_pipe::create (&sec_none, &from_slave, &to_master,
 			       fhandler_pty_common::pipesize, pipename, 0);
   if (res)
     {
-      errstr = "output pipe";
+      errstr = "output pipe for non-cygwin apps";
       goto err;
     }
 
-  __small_sprintf (pipename, "pty%d-to-master-cyg", unit);
+  __small_sprintf (pipename, "pty%d-to-master", unit);
   res = fhandler_pipe::create (&sec_none, &get_handle (), &to_master_cyg,
 			       fhandler_pty_common::pipesize, pipename, 0);
   if (res)
     {
-      errstr = "output pipe for cygwin";
+      errstr = "output pipe";
       goto err;
     }
 
-  __small_sprintf (pipename, "pty%d-to-slave", unit);
+  __small_sprintf (pipename, "pty%d-from-master-nat", unit);
   /* FILE_FLAG_OVERLAPPED is specified here in order to prevent
      PeekNamedPipe() from blocking in transfer_input().
      Accordig to the official document, in order to access the handle
-- 
2.31.0

