Return-Path: <SRS0=Wqcg=EA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1020.nifty.com (mta-snd01004.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id EDF163858002
	for <cygwin-patches@cygwin.com>; Tue, 15 Aug 2023 23:35:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDF163858002
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1020.nifty.com with ESMTP
          id <20230815233521138.TUUE.131070.localhost.localdomain@nifty.com>;
          Wed, 16 Aug 2023 08:35:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Add missing pinfo check in transfer_input().
Date: Wed, 16 Aug 2023 08:35:06 +0900
Message-Id: <20230815233506.1390-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit 10d083c745dd has a bug that lacks a check for pinfo pointer
value for master_pid. This causes segmentation fault if the process
whose pid is master_pid no longer exists. This patch fixes the issue.

Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index db3b77ecf..607333f52 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3835,7 +3835,9 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
     to = ttyp->to_slave ();
 
   pinfo p (ttyp->master_pid);
-  HANDLE pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
+  HANDLE pty_owner = NULL;
+  if (p)
+    pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
   if (pty_owner)
     {
       DuplicateHandle (pty_owner, to, GetCurrentProcess (), &to,
-- 
2.39.0

