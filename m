Return-Path: <SRS0=edmR=JW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1009.nifty.com (mta-snd01012.nifty.com [106.153.227.44])
	by sourceware.org (Postfix) with ESMTPS id B76503858C50
	for <cygwin-patches@cygwin.com>; Tue, 13 Feb 2024 14:30:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B76503858C50
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B76503858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.44
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1707834634; cv=none;
	b=suF4AEKFxP2zkO0hNAtYTcAjfOyUG2Z67H0lwhcx83sCldy8FIvuNmsM+Z+Rn2zzhQs4FF0zcM4euwkFs5IKQRgkYQE56sQGlGuCZdh74YfXtn4OTFZyq/UYdQxS4Vm/WHuYL2yN97S8xeWGs2WoUs9uR+qw6yGspotM2uYFt0g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1707834634; c=relaxed/simple;
	bh=tpg/7Hd+/Vc3O2Q9APZ61vAOBpl6Dfye6U7lBEFxetg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=t+sU6DcIUwrMYaZrfFTwwGdBqsjH+HbJ78EicLH+TQnRKjO7yZJ9kZRggVPRkEvw8z70ix8DKFn2tEY3+MufEvh0fdady3fe3WbWe7Fpt7zCYGuyMHXUlj0ZFHETuUz19iKNyh/WF+LFWDAhYsdWSLV9wT5YOcpUqPYoRVx6Kso=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1009.nifty.com with ESMTP
          id <20240213143030844.DDDO.65055.localhost.localdomain@nifty.com>;
          Tue, 13 Feb 2024 23:30:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix potential handle leak regarding CallNamedPipe().
Date: Tue, 13 Feb 2024 23:30:05 +0900
Message-ID: <20240213143015.1889-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In pty master_thread, 6 handles are duplicated when CallNamedPipe()
requests that. Though some of them are not used so should be closed,
they were not. This causes handle leak potentially.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index c5c792144..d31d30b1f 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -936,6 +936,8 @@ fhandler_pty_slave::open (int flags, mode_t)
 	  errmsg = "can't call master, %E";
 	  goto err;
 	}
+      CloseHandle (repl.to_slave_nat); /* not used. */
+      CloseHandle (repl.to_slave); /* not used. */
       from_master_nat_local = repl.from_master_nat;
       from_master_local = repl.from_master;
       to_master_nat_local = repl.to_master_nat;
@@ -1210,6 +1212,10 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		      if (!CallNamedPipe (pipe, &req, sizeof req,
 					  &repl, sizeof repl, &len, 500))
 			return; /* What can we do? */
+		      CloseHandle (repl.from_master); /* not used. */
+		      CloseHandle (repl.to_master); /* not used. */
+		      CloseHandle (repl.to_slave_nat); /* not used. */
+		      CloseHandle (repl.to_slave); /* not used. */
 		      CloseHandle (get_handle_nat ());
 		      set_handle_nat (repl.from_master_nat);
 		      CloseHandle (get_output_handle_nat ());
@@ -3861,10 +3867,20 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
       if (!CallNamedPipe (pipe, &req, sizeof req,
 			  &repl, sizeof repl, &len, 500))
 	return; /* What can we do? */
+      CloseHandle (repl.from_master_nat); /* not used. */
+      CloseHandle (repl.from_master); /* not used. */
+      CloseHandle (repl.to_master_nat); /* not used. */
+      CloseHandle (repl.to_master); /* not used. */
       if (dir == tty::to_nat)
-	to = repl.to_slave_nat;
+	{
+	  CloseHandle (repl.to_slave); /* not used. */
+	  to = repl.to_slave_nat;
+	}
       else
-	to = repl.to_slave;
+	{
+	  CloseHandle (repl.to_slave_nat); /* not used. */
+	  to = repl.to_slave;
+	}
     }
 
   UINT cp_from = 0, cp_to = 0;
-- 
2.43.0

