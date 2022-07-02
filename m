Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 6A17E3857830
 for <cygwin-patches@cygwin.com>; Sat,  2 Jul 2022 02:11:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6A17E3857830
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 2622BFhS007419;
 Sat, 2 Jul 2022 11:11:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 2622BFhS007419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1656727879;
 bh=XOqOcHgcqZVynPvNbFDiz2NZbqgA3nRDHU3MnAM1JWc=;
 h=From:To:Cc:Subject:Date:From;
 b=cPqJ15zx0a9sC5Uf93c3mqkYgNELRjeMnEDxaklWruTzjDUrYFQS1fVdqcMm/Twqo
 cfk7Nnbw4XzLHQRj+FmUqAWJuk7ngGJsU1yOk5dRQidHaMw4z4TPxMLLIIZIHPJOp3
 G3xZYwvS4JndWatkh38ZogmtjEDGOgR+Fxgz9cy5M2yRxldruB2SO8wlJAs8Y4Q3u1
 N/3a13lG5mJyqSEE2FaxXok1pgM1MaK9gZMGiDT35EyuvMXFIBl2ABfGUYZeQMoiBC
 5/uoPrBHSvfXKjfsn2oInxoruizx7dx+TsUhaQR9gWwekHvLj9mWluveA8ZkERsj6t
 VUcn2qidInhMw==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Allow pasting very long text input.
Date: Sat,  2 Jul 2022 11:11:06 +0900
Message-Id: <20220702021106.1939-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sat, 02 Jul 2022 02:11:42 -0000

- Currently, if the text longer than 1024 byte is pasted in console,
  some of the text is discarded. This patch fixes the issue.
Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251764.html
---
 winsup/cygwin/fhandler.h          |   1 +
 winsup/cygwin/fhandler_console.cc | 121 +++++++++++++++++++++++-------
 winsup/cygwin/release/3.3.6       |   4 +
 winsup/cygwin/wincap.cc           |  12 +++
 winsup/cygwin/wincap.h            |   2 +
 5 files changed, 113 insertions(+), 27 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index d7c358e7f..d5ec56a6d 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2091,6 +2091,7 @@ class dev_console
   char *cons_rapoi;
   bool cursor_key_app_mode;
   bool disable_master_thread;
+  bool master_thread_suspended;
   int num_processed; /* Number of input events in the current input buffer
 			already processed by cons_master_thread(). */
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 345117888..4f462e3e8 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -289,7 +289,18 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
   const int additional_space = 128; /* Possible max number of incoming events
 				       during the process. Additional space
 				       should be left for writeback fix. */
-  const int inrec_size = INREC_SIZE + additional_space;
+  DWORD inrec_size = INREC_SIZE + additional_space;
+  INPUT_RECORD *input_rec =
+    (INPUT_RECORD *) malloc (inrec_size * sizeof (INPUT_RECORD));
+  INPUT_RECORD *input_tmp =
+    (INPUT_RECORD *) malloc (inrec_size * sizeof (INPUT_RECORD));
+
+  if (!input_rec || !input_tmp)
+    return; /* Cannot continue */
+
+  DWORD inrec_size1 =
+    wincap.cons_need_small_input_record_buf () ? INREC_SIZE : inrec_size;
+
   struct m
   {
     inline static size_t bytes (size_t n)
@@ -301,7 +312,6 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
   while (con.owner == myself->pid)
     {
       DWORD total_read, n, i;
-      INPUT_RECORD input_rec[inrec_size];
 
       if (con.disable_master_thread)
 	{
@@ -309,25 +319,55 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  continue;
 	}
 
+      acquire_attach_mutex (mutex_timeout);
+      GetNumberOfConsoleInputEvents (p->input_handle, &total_read);
+      release_attach_mutex ();
+      if (total_read > INREC_SIZE)
+	{
+	  cygwait (40);
+	  acquire_attach_mutex (mutex_timeout);
+	  GetNumberOfConsoleInputEvents (p->input_handle, &n);
+	  release_attach_mutex ();
+	  if (n < total_read)
+	    {
+	      /* read() seems to be called. Process special keys
+		 in process_input_message (). */
+	      con.master_thread_suspended = true;
+	      continue;
+	    }
+	  total_read = n;
+	}
+      con.master_thread_suspended = false;
+      if (total_read + additional_space > inrec_size)
+	{
+	  DWORD new_inrec_size = total_read + additional_space;
+	  INPUT_RECORD *new_input_rec = (INPUT_RECORD *)
+	    realloc (input_rec, new_inrec_size * sizeof (INPUT_RECORD));
+	  INPUT_RECORD *new_input_tmp = (INPUT_RECORD *)
+	    realloc (input_tmp, new_inrec_size * sizeof (INPUT_RECORD));
+	  if (new_input_rec && new_input_tmp)
+	    {
+	      inrec_size = new_inrec_size;
+	      input_rec = new_input_rec;
+	      input_tmp = new_input_tmp;
+	      if (!wincap.cons_need_small_input_record_buf ())
+		inrec_size1 = inrec_size;
+	    }
+	}
+
       WaitForSingleObject (p->input_mutex, mutex_timeout);
       total_read = 0;
-      bool nowait = false;
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
-	  acquire_attach_mutex (mutex_timeout);
-	  ReadConsoleInputW (p->input_handle,
-			     input_rec, INREC_SIZE, &total_read);
-	  if (total_read == INREC_SIZE /* Working space full */
-	      && cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0)
+	  total_read = 0;
+	  while (cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0)
 	    {
-	      const int incr = min (con.num_processed, additional_space);
-	      ReadConsoleInputW (p->input_handle,
-				 input_rec + total_read, incr, &n);
-	      /* Discard oldest n events. */
-	      memmove (input_rec, input_rec + n, m::bytes (total_read));
-	      con.num_processed -= n;
-	      nowait = true;
+	      DWORD len;
+	      ReadConsoleInputW (p->input_handle, input_rec + total_read,
+				 min (inrec_size - total_read, inrec_size1),
+				 &len);
+	      total_read += len;
 	    }
 	  release_attach_mutex ();
 	  break;
@@ -416,33 +456,56 @@ remove_record:
 	{
 	  do
 	    {
-	      INPUT_RECORD tmp[inrec_size];
 	      /* Writeback input records other than interrupt. */
 	      acquire_attach_mutex (mutex_timeout);
-	      WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
+	      n = 0;
+	      while (n < total_read)
+		{
+		  DWORD len;
+		  WriteConsoleInputW (p->input_handle, input_rec + n,
+				      min (total_read - n, inrec_size1), &len);
+		  n += len;
+		}
 	      /* Check if writeback was successfull. */
-	      PeekConsoleInputW (p->input_handle, tmp, inrec_size, &n);
+	      PeekConsoleInputW (p->input_handle, input_tmp, inrec_size1, &n);
 	      release_attach_mutex ();
-	      if (n < total_read)
+	      if (n < min (total_read, inrec_size1))
 		break; /* Someone has read input without acquiring
 			  input_mutex. ConEmu cygwin-connector? */
-	      if (inrec_eq (input_rec, tmp, total_read))
+	      if (inrec_eq (input_rec, input_tmp,
+			    min (total_read, inrec_size1)))
 		break; /* OK */
 	      /* Try to fix */
 	      acquire_attach_mutex (mutex_timeout);
-	      ReadConsoleInputW (p->input_handle, tmp, inrec_size, &n);
+	      n = 0;
+	      while (cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0)
+		{
+		  DWORD len;
+		  ReadConsoleInputW (p->input_handle, input_tmp + n,
+				     min (inrec_size - n, inrec_size1), &len);
+		  n += len;
+		}
 	      release_attach_mutex ();
 	      for (DWORD i = 0, j = 0; j < n; j++)
-		if (i == total_read || !inrec_eq (input_rec + i, tmp + j, 1))
+		if (i == total_read
+		    || !inrec_eq (input_rec + i, input_tmp + j, 1))
 		  {
 		    if (total_read + j - i >= n)
 		      { /* Something is wrong. Giving up. */
 			acquire_attach_mutex (mutex_timeout);
-			WriteConsoleInputW (p->input_handle, tmp, n, &n);
+			WriteConsoleInputW (p->input_handle, input_tmp, n, &n);
+			n = 0;
+			while (n < total_read)
+			  {
+			    DWORD len;
+			    WriteConsoleInputW (p->input_handle, input_rec + n,
+				      min (total_read - n, inrec_size1), &len);
+			    n += len;
+			  }
 			release_attach_mutex ();
 			goto skip_writeback;
 		      }
-		    input_rec[total_read + j - i] = tmp[j];
+		    input_rec[total_read + j - i] = input_tmp[j];
 		  }
 		else
 		  i++;
@@ -452,9 +515,10 @@ remove_record:
 	}
 skip_writeback:
       ReleaseMutex (p->input_mutex);
-      if (!nowait)
-	cygwait (40);
+      cygwait (40);
     }
+  free (input_rec);
+  free (input_tmp);
 }
 
 bool
@@ -549,6 +613,7 @@ fhandler_console::setup ()
       shared_console_info->tty_min_state.is_console = true;
       con.cursor_key_app_mode = false;
       con.disable_master_thread = true;
+      con.master_thread_suspended = false;
       con.num_processed = 0;
     }
 }
@@ -602,6 +667,8 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
       break;
     case tty::cygwin:
       flags |= ENABLE_WINDOW_INPUT;
+      if (con.master_thread_suspended)
+	flags |= ENABLE_PROCESSED_INPUT;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
 	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
       else
@@ -4173,5 +4240,5 @@ fhandler_console::close_handle_set (handle_set_t *p)
 bool
 fhandler_console::need_console_handler ()
 {
-  return con.disable_master_thread;
+  return con.disable_master_thread || con.master_thread_suspended;
 }
diff --git a/winsup/cygwin/release/3.3.6 b/winsup/cygwin/release/3.3.6
index f1a4b7812..44a7bcf9d 100644
--- a/winsup/cygwin/release/3.3.6
+++ b/winsup/cygwin/release/3.3.6
@@ -22,3 +22,7 @@ Bug Fixes
   if events are inquired in multiple pollfd entries on the same fd
   at the same time.
   Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251732.html
+
+- Fix a console problem that the text longer than 1024 bytes cannot
+  be pasted correctly.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251764.html
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 0f0b77de8..30da7e1e9 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -45,6 +45,7 @@ wincaps wincap_7 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_query_process_handle_info:false,
     has_con_broken_tabs:false,
     has_broken_attach_console:true,
+    cons_need_small_input_record_buf:true,
   },
 };
 
@@ -75,6 +76,7 @@ wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -105,6 +107,7 @@ wincaps wincap_8_1 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -135,6 +138,7 @@ wincaps  wincap_10_1507 __attribute__((section (".cygwin_dll_common"), shared))
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -165,6 +169,7 @@ wincaps  wincap_10_1607 __attribute__((section (".cygwin_dll_common"), shared))
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -195,6 +200,7 @@ wincaps wincap_10_1703 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -225,6 +231,7 @@ wincaps wincap_10_1709 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -255,6 +262,7 @@ wincaps wincap_10_1803 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -285,6 +293,7 @@ wincaps wincap_10_1809 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -315,6 +324,7 @@ wincaps wincap_10_1903 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -345,6 +355,7 @@ wincaps wincap_10_2004 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
@@ -375,6 +386,7 @@ wincaps wincap_11 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
     has_broken_attach_console:false,
+    cons_need_small_input_record_buf:false,
   },
 };
 
diff --git a/winsup/cygwin/wincap.h b/winsup/cygwin/wincap.h
index e06b82f1f..9fff12909 100644
--- a/winsup/cygwin/wincap.h
+++ b/winsup/cygwin/wincap.h
@@ -39,6 +39,7 @@ struct wincaps
     unsigned has_query_process_handle_info			: 1;
     unsigned has_con_broken_tabs				: 1;
     unsigned has_broken_attach_console				: 1;
+    unsigned cons_need_small_input_record_buf			: 1;
   };
 };
 
@@ -97,6 +98,7 @@ public:
   bool	IMPLEMENT (has_query_process_handle_info)
   bool	IMPLEMENT (has_con_broken_tabs)
   bool	IMPLEMENT (has_broken_attach_console)
+  bool	IMPLEMENT (cons_need_small_input_record_buf)
 
   void disable_case_sensitive_dirs ()
   {
-- 
2.36.1

