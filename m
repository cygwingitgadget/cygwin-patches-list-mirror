Return-Path: <SRS0=5VGh=KK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0003.nifty.com (mta-snd00010.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id B22733858D28
	for <cygwin-patches@cygwin.com>; Mon,  4 Mar 2024 10:59:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B22733858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B22733858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709549953; cv=none;
	b=AwD5+nXps6cavB95h86KBBIN30v4cF1fuMr9R9P/e0eZySusZy/bkZ0vd03bdUJ2NFzKjDApZkzTeJEFO7uWe6bUxDXN7Uu0a53cWFz/wFFhqBHxK0aF6AolT1YYAWG4t/l+46eklDFTvUFp0gG+9keHqvd4F/zkWsxNFERjtPA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709549953; c=relaxed/simple;
	bh=FgrOfZlAkJtPB2Hk3CW6LmhIaDIhBVLQEXit7aeleZw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=k9MEDpoJ64vlHG2VLepOFa5fplHM730sMEPVofsXnVk3FgDaccg8zphJ4bglcWcp0v/X1SaYskjCZnYtZ7Jc2S72maulyuorY5lMVi/SJU0/GHbuKZdlbncZzhIRHWaionibfnJU/DBZtAaWJDPMBiN7dw9KD+t8UuTAITdsUq8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0003.nifty.com with ESMTP
          id <20240304105907070.GUHP.94728.localhost.localdomain@nifty.com>;
          Mon, 4 Mar 2024 19:59:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Kate Deplaix <kit-ty-kate@outlook.com>
Subject: [PATCH] Cygwin: console: Fix a race issue between close() and open().
Date: Mon,  4 Mar 2024 19:58:29 +0900
Message-ID: <20240304105849.21549-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The open() call for console sometimes fails if the console owner
process is closing the console by close() at the same time. This
is due to mismatch state of con.owner variable and attaching state
to the console. With this patch, checking con.owner and attaching
to con.owner sequence in open(), and resetting con.owner and freeing
console sequence in close() are guarded by output_mutex to avoid
such a race issue.
Addresses: https://cygwin.com/pipermail/cygwin/2024-March/255575.html

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from other terminals.")
Reported-by: Kate Deplaix <kit-ty-kate@outlook.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 58 ++++++++++++++++++-------------
 winsup/cygwin/release/3.5.2       |  4 +++
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 67ea95466..1c0d5c815 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -687,14 +687,6 @@ fhandler_console::set_unit ()
     {
       devset = (fh_devices) shared_console_info[unit]->tty_min_state.getntty ();
       _tc = &(shared_console_info[unit]->tty_min_state);
-      if (!created)
-	{
-	  while (con.owner > MAX_PID)
-	    Sleep (1);
-	  pinfo p (con.owner);
-	  if (!p)
-	    con.owner = myself->pid;
-	}
     }
 
   dev ().parse (devset);
@@ -1744,11 +1736,23 @@ fhandler_console::open (int flags, mode_t)
   set_handle (NULL);
   set_output_handle (NULL);
 
+  setup_io_mutex ();
+  acquire_output_mutex (mutex_timeout);
+
+  do
+    {
+      pinfo p (con.owner);
+      if (!p)
+	con.owner = myself->pid;
+    }
+  while (false);
+
   /* Open the input handle as handle_ */
   bool err = false;
   DWORD resume_pid = attach_console (con.owner, &err);
   if (err)
     {
+      release_output_mutex ();
       set_errno (EACCES);
       return 0;
     }
@@ -1759,6 +1763,7 @@ fhandler_console::open (int flags, mode_t)
 
   if (h == INVALID_HANDLE_VALUE)
     {
+      release_output_mutex ();
       __seterrno ();
       return 0;
     }
@@ -1768,6 +1773,7 @@ fhandler_console::open (int flags, mode_t)
   resume_pid = attach_console (con.owner, &err);
   if (err)
     {
+      release_output_mutex ();
       set_errno (EACCES);
       return 0;
     }
@@ -1778,14 +1784,16 @@ fhandler_console::open (int flags, mode_t)
 
   if (h == INVALID_HANDLE_VALUE)
     {
+      release_output_mutex ();
       __seterrno ();
       return 0;
     }
   set_output_handle (h);
   handle_set.output_handle = h;
+  release_output_mutex ();
+
   wpbuf.init ();
 
-  setup_io_mutex ();
   handle_set.input_mutex = input_mutex;
   handle_set.output_mutex = output_mutex;
 
@@ -1895,25 +1903,20 @@ fhandler_console::close ()
 	}
     }
 
-  release_output_mutex ();
-
-  if (shared_console_info[unit] && con.owner == myself->pid
-      && master_thread_started)
+  if (shared_console_info[unit] && con.owner == myself->pid)
     {
-      char name[MAX_PATH];
-      shared_name (name, CONS_THREAD_SYNC, get_minor ());
-      thread_sync_event = OpenEvent (MAXIMUM_ALLOWED, FALSE, name);
-      con.owner = MAX_PID + 1;
-      WaitForSingleObject (thread_sync_event, INFINITE);
-      CloseHandle (thread_sync_event);
+      if (master_thread_started)
+	{
+	  char name[MAX_PATH];
+	  shared_name (name, CONS_THREAD_SYNC, get_minor ());
+	  thread_sync_event = OpenEvent (MAXIMUM_ALLOWED, FALSE, name);
+	  con.owner = MAX_PID + 1;
+	  WaitForSingleObject (thread_sync_event, INFINITE);
+	  CloseHandle (thread_sync_event);
+	}
       con.owner = 0;
     }
 
-  CloseHandle (input_mutex);
-  input_mutex = NULL;
-  CloseHandle (output_mutex);
-  output_mutex = NULL;
-
   CloseHandle (get_handle ());
   CloseHandle (get_output_handle ());
 
@@ -1926,6 +1929,13 @@ fhandler_console::close ()
 	  || get_device () == (dev_t) myself->ctty))
     free_console ();
 
+  release_output_mutex ();
+
+  CloseHandle (input_mutex);
+  input_mutex = NULL;
+  CloseHandle (output_mutex);
+  output_mutex = NULL;
+
   if (shared_console_info[unit] && myself->ctty != tc ()->ntty)
     {
       UnmapViewOfFile ((void *) shared_console_info[unit]);
diff --git a/winsup/cygwin/release/3.5.2 b/winsup/cygwin/release/3.5.2
index 7d8df9489..fd3c768de 100644
--- a/winsup/cygwin/release/3.5.2
+++ b/winsup/cygwin/release/3.5.2
@@ -5,3 +5,7 @@ Fixes:
   is already unmapped due to race condition. To avoid this issue,
   shared console memory will be kept mapped if it belongs to CTTY.
   Addresses:  https://cygwin.com/pipermail/cygwin/2024-February/255561.html
+
+- Fix a race issue between console open() and close() which is caused
+  by state mismatch between con.owner and console attaching state.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-March/255575.html
-- 
2.43.0

