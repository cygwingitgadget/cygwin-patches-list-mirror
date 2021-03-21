Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id D78603857C7B
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 04:00:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D78603857C7B
Received: from localhost.localdomain (y084061.dynamic.ppp.asahi-net.or.jp
 [118.243.84.61]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 12L3xrTf027869;
 Sun, 21 Mar 2021 12:59:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 12L3xrTf027869
X-Nifty-SrcIP: [118.243.84.61]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Rename input named pipes.
Date: Sun, 21 Mar 2021 12:59:53 +0900
Message-Id: <20210321035953.1671-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 21 Mar 2021 04:00:35 -0000

- Currently, the name of input pipe is "ptyNNNN-from-master" for
  cygwin process, and "ptyNNNN-to-slave" for non-cygwin process.
  These are not only inconsistent with output pipes but also very
  confusing.
  With this patch, these are renamed to "ptyNNNN-from-master-cyg"
  and "ptyNNNN-from-master" respectively.
---
 winsup/cygwin/fhandler_tty.cc | 2 +-
 winsup/cygwin/tty.cc          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 643a357ad..02e94efcc 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2787,7 +2787,7 @@ fhandler_pty_master::setup ()
       goto err;
     }
 
-  __small_sprintf (pipename, "pty%d-to-slave", unit);
+  __small_sprintf (pipename, "pty%d-from-master", unit);
   /* FILE_FLAG_OVERLAPPED is specified here in order to prevent
      PeekNamedPipe() from blocking in transfer_input().
      Accordig to the official document, in order to access the handle
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 3c016315c..269b87735 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -159,8 +159,8 @@ tty::not_allocated (HANDLE& r, HANDLE& w)
 {
   /* Attempt to open the from-master side of the tty.  If it is accessible
      then it exists although we may not have privileges to actually use it. */
-  char pipename[sizeof("ptyNNNN-from-master")];
-  __small_sprintf (pipename, "pty%d-from-master", get_minor ());
+  char pipename[sizeof("ptyNNNN-from-master-cyg")];
+  __small_sprintf (pipename, "pty%d-from-master-cyg", get_minor ());
   /* fhandler_pipe::create returns 0 when creation succeeds */
   return fhandler_pipe::create (&sec_none, &r, &w,
 				fhandler_pty_common::pipesize, pipename,
-- 
2.30.1

