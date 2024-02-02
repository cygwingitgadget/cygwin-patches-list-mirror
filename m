Return-Path: <SRS0=QiAG=JL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0004.nifty.com (mta-snd00002.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id 1989F3858C53
	for <cygwin-patches@cygwin.com>; Fri,  2 Feb 2024 05:29:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1989F3858C53
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1989F3858C53
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706851793; cv=none;
	b=mSafZ6CcSMH1QXuAca9/cevSPmKr/9gUS6bgq/b8P1LhtlYfIbB2nWLVVpajh6Ew9y7tRNNiB2bbBuGUQdpKOoIVNc59JxxKBK/naCqf9OcCBN27CHwJ+IIT0aH6g5zgB33CTz46+TnQ/RJP92ScC4S9OvRytFeJ+CQg+7Qo8a0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706851793; c=relaxed/simple;
	bh=VarOAbDnZiI6QAmN7F+VmOYXIcdpezzb1IHGcrAzJcc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oisaLws2+JmLbDAex/WtXFnk7+TDynyMIWJmSvrLjwolYA/+zkSiZGk3G2zAkny/5q7obDXaSs2O1C8/ra83xiNKKpx/RTdoNxCh4SlfE/3XR0QvhVZSNH9QvvhctAFCQS6PmgS1Es7sMCn8J//RerkqVd5AFxkSh2mzFKI/vEA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0004.nifty.com with ESMTP
          id <20240202052941873.FIUM.109344.localhost.localdomain@nifty.com>;
          Fri, 2 Feb 2024 14:29:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: console: Fix exit code for non-cygwin process.
Date: Fri,  2 Feb 2024 14:29:05 +0900
Message-ID: <20240202052923.881-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If non-cygwin process is executed in console, the exit code is not
set correctly. This is because the stub process for non-cygwin app
crashes in fhandler_console::set_disable_master_thread() due to NULL
pointer dereference. This bug was introduced by the commit:
3721a756b0d8 ("Cygwin: console: Make the console accessible from
other terminals."), that the pointer cons is accessed before fixing
when it is NULL. This patch fixes the issue.

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from other terminals.")
Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index b924a6bf3..6a42b4949 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -4537,9 +4537,6 @@ fhandler_console::need_console_handler ()
 void
 fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
 {
-  const _minor_t unit = cons->get_minor ();
-  if (con.disable_master_thread == x)
-    return;
   if (cons == NULL)
     {
       if (cygheap->ctty && cygheap->ctty->get_major () == DEV_CONS_MAJOR)
@@ -4547,6 +4544,9 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
       else
 	return;
     }
+  const _minor_t unit = cons->get_minor ();
+  if (con.disable_master_thread == x)
+    return;
   cons->acquire_input_mutex (mutex_timeout);
   con.disable_master_thread = x;
   cons->release_input_mutex ();
-- 
2.43.0

