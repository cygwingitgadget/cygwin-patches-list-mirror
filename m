Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 28E513858C60
 for <cygwin-patches@cygwin.com>; Mon, 28 Feb 2022 11:16:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 28E513858C60
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 21SBGLDo014777;
 Mon, 28 Feb 2022 20:16:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 21SBGLDo014777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646046988;
 bh=aQvSMXPWQTqGJXmgGyzLIIDe9oAVS56EkNRA206m+80=;
 h=From:To:Cc:Subject:Date:From;
 b=sdtUIrvkLDik+/4jBKhqUjrHhXsHUc0t1y3B/yA1nfQuoWdk6Sg11zbAPcw1I4BgU
 Re0yQoOEzYMSk2UdljTXsZnADr6DyEHU8NVi1mbm8P6m1I79lwXxjlXqZJ45dHqMuj
 LZcGe+PXAYLx+hpiEWNqtCP33aglKSyWwwFdxGGA4vg03bBImd9ijq04FqH8INvrNx
 TipO2Pm5lEH5SwKv0nCyWyjmQv/y+eed11YbZDbIJM3O5FtuzA0FK072vLZ291Ps5N
 DhJe5jxJ57tHtl2kBSfEBNfuY0P2KO+bHukGr6i50OwCHEAvQAkzs6P0feXWeQOoAr
 LfPcG0xOPYAmQ==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Improve the code to avoid typeahead key
 swapping.
Date: Mon, 28 Feb 2022 20:16:11 +0900
Message-Id: <20220228111611.1169-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 28 Feb 2022 11:16:47 -0000

- The commit "Cygwin: console: Prevent the order of typeahead input
  from swapped." did not fully resolve the issue. If keys are typed
  during input buffer fix, the order of key event may be swapped.
  This patch fixes the issue again.
---
 winsup/cygwin/fhandler_console.cc | 75 +++++++++++++++++--------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 88c0f894b..920dd4be0 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -188,12 +188,23 @@ cons_master_thread (VOID *arg)
 void
 fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 {
+  const int additional_space = 128; /* Possible max number of incoming events
+				       during the process. Additional space
+				       should be left for writeback fix. */
+  const int inrec_size = INREC_SIZE + additional_space;
+  struct
+  {
+    inline static size_t bytes (size_t n)
+      {
+	return sizeof (INPUT_RECORD) * n;
+      }
+  } m;
   termios &ti = ttyp->ti;
   int processed_up_to = -1;
   while (con.owner == myself->pid)
     {
       DWORD total_read, n, i;
-      INPUT_RECORD input_rec[INREC_SIZE];
+      INPUT_RECORD input_rec[inrec_size];
 
       if (con.disable_master_thread)
 	{
@@ -203,6 +214,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 
       WaitForSingleObject (p->input_mutex, mutex_timeout);
       total_read = 0;
+      bool nowait = false;
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
@@ -211,16 +223,13 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  if (total_read == INREC_SIZE /* Working space full */
 	      && cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0)
 	    {
-	      const int incr = 1;
-	      size_t bytes = sizeof (INPUT_RECORD) * (total_read - incr);
-	      /* Discard oldest incr events. */
-	      memmove (input_rec, input_rec + incr, bytes);
-	      total_read -= incr;
-	      processed_up_to =
-		(processed_up_to + 1 >= incr) ? processed_up_to - incr : -1;
+	      const int incr = min (processed_up_to + 1, additional_space);
 	      ReadConsoleInputW (p->input_handle,
 				 input_rec + total_read, incr, &n);
-	      total_read += n;
+	      /* Discard oldest n events. */
+	      memmove (input_rec, input_rec + n, m.bytes (total_read));
+	      processed_up_to -= n;
+	      nowait = true;
 	    }
 	  break;
 	case WAIT_TIMEOUT:
@@ -298,7 +307,7 @@ remove_record:
 	    { /* Remove corresponding record. */
 	      if (total_read > i + 1)
 		memmove (input_rec + i, input_rec + i + 1,
-			 sizeof (INPUT_RECORD) * (total_read - i - 1));
+			 m.bytes (total_read - i - 1));
 	      total_read--;
 	      i--;
 	    }
@@ -306,45 +315,45 @@ remove_record:
       processed_up_to = total_read - 1;
       if (total_read)
 	{
-	  /* Writeback input records other than interrupt. */
-	  WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
-	  size_t bytes = sizeof (INPUT_RECORD) * total_read;
 	  do
 	    {
-	      const int additional_size = 128; /* Possible max number of
-						  incoming events during
-						  above process. */
-	      const int new_size = INREC_SIZE + additional_size;
-	      INPUT_RECORD tmp[new_size];
+	      INPUT_RECORD tmp[inrec_size];
+	      /* Writeback input records other than interrupt. */
+	      WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
 	      /* Check if writeback was successfull. */
-	      PeekConsoleInputW (p->input_handle, tmp, new_size, &n);
-	      if (memcmp (input_rec, tmp, bytes) == 0)
+	      PeekConsoleInputW (p->input_handle, tmp, inrec_size, &n);
+	      if (n < total_read)
+		break; /* Someone has read input without acquiring
+			  input_mutex. ConEmu cygwin-connector? */
+	      if (memcmp (input_rec, tmp, m.bytes (total_read)) == 0)
 		break; /* OK */
 	      /* Try to fix */
 	      DWORD incr = n - total_read;
 	      DWORD ofst;
 	      for (ofst = 1; ofst <= incr; ofst++)
-		if (memcmp (input_rec, tmp + ofst, bytes) == 0)
+		if (memcmp (input_rec, tmp + ofst, m.bytes (total_read)) == 0)
 		  {
-		    ReadConsoleInputW (p->input_handle, tmp, new_size, &n);
-		    DWORD m;
-		    WriteConsoleInputW (p->input_handle, tmp + ofst,
-					total_read, &m);
-		    WriteConsoleInputW (p->input_handle, tmp, ofst, &m);
-		    if ( n > ofst + total_read)
-		      WriteConsoleInputW (p->input_handle,
-					  tmp + ofst + total_read,
-					  n - (ofst + total_read), &m);
+		    ReadConsoleInputW (p->input_handle, tmp, inrec_size, &n);
+		    memcpy (input_rec, tmp + ofst, m.bytes (total_read));
+		    memcpy (input_rec + total_read, tmp, m.bytes (ofst));
+		    if (n > ofst + total_read)
+		      memcpy (input_rec + total_read + ofst,
+			      tmp + ofst + total_read,
+			      m.bytes (n - (ofst + total_read)));
+		    total_read = n;
 		    break;
 		  }
-	      if (ofst > incr) /* Hard to fix */
-		break; /* Giving up */
+	      if (ofst > incr)
+		break; /* Writeback was not atomic. Or someone has read
+			  input without acquiring input_mutex.
+			  Giving up because hard to fix. */
 	    }
 	  while (true);
 	}
 skip_writeback:
       ReleaseMutex (p->input_mutex);
-      cygwait (40);
+      if (!nowait)
+	cygwait (40);
     }
 }
 
-- 
2.35.1

