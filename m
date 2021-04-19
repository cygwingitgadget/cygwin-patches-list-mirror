Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 6D4DA3968C32
 for <cygwin-patches@cygwin.com>; Mon, 19 Apr 2021 10:31:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6D4DA3968C32
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 13JAUmCB006642;
 Mon, 19 Apr 2021 19:31:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 13JAUmCB006642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618828267;
 bh=EaZUyXTN24qNa4YtAO6dEMo0TckprMtOXFhy2226/ls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZwsCFeJIcx8nSsHPXfV/WRN1T4mAOg8ETjXxiy+dlt4yIsna8E5JUUsmat2T9GM8K
 87BcvJVTRmc/vVzeHFWw9pEDqQKZ69FdL+N+babIWrPQ9qYYlfcO8P5MUkD8TxLOuT
 3CJZ8AEHbZseuWTzZ5zjeMqpJNSgRhcNdaPZ7q+AN7fXJuDQQBD6dbS0w6Yg/dW0/8
 JOGBj/3TFLFA+NlwmmSpietx4aQsTIuxzLsuySMaMP0MdG9SUbLyGWcACOuESVYKow
 mBzs+Jif3S85i+H+lusiEPF4ubc+bIk4nJDE1aCu6yCE7BYGvohtbLJyuzx/Ha9i2B
 rlxHmnzXbjk4Q==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: console: Fix race issue regarding
 cons_master_thread().
Date: Mon, 19 Apr 2021 19:30:45 +0900
Message-Id: <20210419103046.21838-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419103046.21838-1-takashi.yano@nifty.ne.jp>
References: <20210419103046.21838-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_BL_SPAMCOP_NET,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Mon, 19 Apr 2021 10:31:30 -0000

- With this patch, the race issue regarding starting/stopping
  cons_master_thread() introduced by commit ff4440fc is fixed.

  Addresses:
    https://cygwin.com/pipermail/cygwin/2021-April/248292.html
---
 winsup/cygwin/fhandler_console.cc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 0b33a1370..e418aac97 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -48,6 +48,7 @@ details. */
 #define con_is_legacy (shared_console_info && con.is_legacy)
 
 #define CONS_THREAD_SYNC "cygcons.thread_sync"
+static bool NO_COPY master_thread_started = false;
 
 const unsigned fhandler_console::MAX_WRITE_CHARS = 16384;
 
@@ -184,6 +185,7 @@ cons_master_thread (VOID *arg)
 		   GetCurrentProcess (), &thread_sync_event,
 		   0, FALSE, DUPLICATE_SAME_ACCESS);
   SetEvent (thread_sync_event);
+  master_thread_started = true;
   /* Do not touch class members after here because the class instance
      may have been destroyed. */
   fhandler_console::cons_master_thread (&handle_set, ttyp);
@@ -370,6 +372,8 @@ fhandler_console::set_unit ()
     }
   if (!created && shared_console_info)
     {
+      while (con.owner > MAX_PID)
+	Sleep (1);
       pinfo p (con.owner);
       if (!p)
 	con.owner = myself->pid;
@@ -1393,14 +1397,16 @@ fhandler_console::close ()
 
   release_output_mutex ();
 
-  if (shared_console_info && con.owner == myself->pid)
+  if (shared_console_info && con.owner == myself->pid
+      && master_thread_started)
     {
       char name[MAX_PATH];
       shared_name (name, CONS_THREAD_SYNC, get_minor ());
       thread_sync_event = OpenEvent (MAXIMUM_ALLOWED, FALSE, name);
-      con.owner = 0;
+      con.owner = MAX_PID + 1;
       WaitForSingleObject (thread_sync_event, INFINITE);
       CloseHandle (thread_sync_event);
+      con.owner = 0;
     }
 
   CloseHandle (input_mutex);
-- 
2.31.1

