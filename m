Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id E1F833858D1E
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 10:35:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E1F833858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 21QAZ4sc005910;
 Sat, 26 Feb 2022 19:35:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 21QAZ4sc005910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645871709;
 bh=3yLN6QICarVM9/gmPdjgxhOHfKUCbFiVKce0idhy43I=;
 h=From:To:Cc:Subject:Date:From;
 b=PX6cKfJIJsyfm9M+cGn1WYrJuj9X5FVO8dmh69X+r9VYqKibKvu7Qs9Wow4Omy3Oy
 HqffTmu286aTtZya7eVEEu0jPZ/kEiiGKhwzreUBh2sZ/p2mVUQEjv2rO+VLJp59k5
 kAZdH4MCQ7VvBNlwvLSPA6a/gnJMdys9zBOqT2tAAX+bjKFcSEyTxFev+gJ7FE8nnM
 +Wiccu++1J+Jlzh+AhE3vDGhmtIXmEAqtEarmGCj1r8TMwAkjpj1hm+tNG2smFTZ/B
 lO1kvx/OOG+XRcOrbrk6M6tYY+idSXJkAk3H2KOh/rbVOJxBv8C63MjIQdfuoZarIZ
 ZYC0msSa4J20Q==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix issues of apps which open pty.
Date: Sat, 26 Feb 2022 19:34:55 +0900
Message-Id: <20220226103456.1495-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 26 Feb 2022 10:35:38 -0000

- After some recent changes for special keys handling break the
  apps which open pty (such as script command). If the app which
  opens pty is executed in console, the following issues occur.
    1) If the script command was started from non-cygwin shell
       (such as cmd.exe), another cygwin app started in pty slave
       cannot receive Ctrl-C.
    2) If non-cygwin app is executed in pty slave, the app which
       opened the pty (e.g. script command) crashes by Ctrl-C.
  This patch fixes these issues.
---
 winsup/cygwin/fhandler.h          |  2 +-
 winsup/cygwin/fhandler_console.cc | 20 ++++++++++----------
 winsup/cygwin/fhandler_termios.cc | 14 +++++++++-----
 winsup/cygwin/fhandler_tty.cc     |  2 +-
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 7ddf7e450..0652075b0 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1921,7 +1921,7 @@ class fhandler_termios: public fhandler_base
   HANDLE& get_output_handle_nat () { return output_handle; }
   static process_sig_state process_sigs (char c, tty *ttyp,
 					 fhandler_termios *fh);
-  static bool process_stop_start (char c, tty *ttyp, bool on_ixany);
+  static bool process_stop_start (char c, tty *ttyp);
   line_edit_status line_edit (const char *rptr, size_t nread, termios&,
 			      ssize_t *bytes_read = NULL);
   void set_output_handle (HANDLE h) { output_handle = h; }
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 843a96f9a..aa0f26450 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -189,7 +189,7 @@ void
 fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 {
   termios &ti = ttyp->ti;
-  DWORD output_stopped_at = 0;
+  int processed_up_to = -1;
   while (con.owner == myself->pid)
     {
       DWORD total_read, n, i;
@@ -210,6 +210,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 			     input_rec, INREC_SIZE, &total_read);
 	  break;
 	case WAIT_TIMEOUT:
+	  processed_up_to = -1;
 	case WAIT_SIGNALED:
 	case WAIT_CANCELED:
 	  break;
@@ -232,11 +233,10 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	      ttyp->kill_pgrp (SIGWINCH);
 	    }
 	}
-      for (i = 0; i < total_read; i++)
+      for (i = processed_up_to + 1; i < total_read; i++)
 	{
 	  wchar_t wc;
 	  char c;
-	  bool was_output_stopped;
 	  bool processed = false;
 	  switch (input_rec[i].EventType)
 	    {
@@ -256,14 +256,12 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		  ttyp->output_stopped = false;
 		  if (ti.c_lflag & NOFLSH)
 		    goto remove_record;
+		  processed_up_to = -1;
 		  goto skip_writeback;
 		default: /* not signalled */
 		  break;
 		}
-	      was_output_stopped = ttyp->output_stopped;
-	      processed = process_stop_start (c, ttyp, i > output_stopped_at);
-	      if (!was_output_stopped && ttyp->output_stopped)
-		output_stopped_at = i;
+	      processed = process_stop_start (c, ttyp);
 	      break;
 	    case WINDOW_BUFFER_SIZE_EVENT:
 	      SHORT y = con.dwWinSize.Y;
@@ -284,14 +282,16 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 remove_record:
 	  if (processed)
 	    { /* Remove corresponding record. */
-	      memmove (input_rec + i, input_rec + i + 1,
-		       sizeof (INPUT_RECORD) * (total_read - i - 1));
+	      if (total_read > i + 1)
+		memmove (input_rec + i, input_rec + i + 1,
+			 sizeof (INPUT_RECORD) * (total_read - i - 1));
 	      total_read--;
 	      i--;
 	    }
 	}
+      processed_up_to = total_read - 1;
       if (total_read)
-	/* Write back input records other than interrupt. */
+	/* Writeback input records other than interrupt. */
 	WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
 skip_writeback:
       ReleaseMutex (p->input_mutex);
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 383e20764..b236c1b62 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -344,10 +344,12 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      (myself->dwProcessId, false);
 	  if (resume_pid && fh && !fh->is_console ())
 	    {
+	      if (::cygheap->ctty && ::cygheap->ctty->is_console ())
+		init_console_handler (false);
 	      FreeConsole ();
 	      AttachConsole (p->dwProcessId);
 	    }
-	  if (fh && p == myself)
+	  if (fh && p == myself && being_debugged ())
 	    { /* Avoid deadlock in gdb on console. */
 	      fh->tcflush(TCIFLUSH);
 	      fh->release_input_mutex_if_necessary ();
@@ -372,6 +374,8 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	    {
 	      FreeConsole ();
 	      AttachConsole (resume_pid);
+	      if (::cygheap->ctty && ::cygheap->ctty->is_console ())
+		init_console_handler (true);
 	    }
 	}
       if (p && p->ctty == ttyp->ntty && p->pgid == pgid)
@@ -447,7 +451,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
       return signalled;
     }
 not_a_sig:
-  if (need_discard_input)
+  if ((ti.c_lflag & ISIG) && need_discard_input)
     {
       if (!(ti.c_lflag & NOFLSH) && fh)
 	{
@@ -462,7 +466,7 @@ not_a_sig:
 }
 
 bool
-fhandler_termios::process_stop_start (char c, tty *ttyp, bool on_ixany)
+fhandler_termios::process_stop_start (char c, tty *ttyp)
 {
   termios &ti = ttyp->ti;
   if (ti.c_iflag & IXON)
@@ -478,7 +482,7 @@ restart_output:
 	  ttyp->output_stopped = false;
 	  return true;
 	}
-      else if ((ti.c_iflag & IXANY) && ttyp->output_stopped && on_ixany)
+      else if ((ti.c_iflag & IXANY) && ttyp->output_stopped)
 	goto restart_output;
     }
   if ((ti.c_lflag & ICANON) && (ti.c_lflag & IEXTEN)
@@ -526,7 +530,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	default: /* Not signalled */
 	  break;
 	}
-      if (process_stop_start (c, get_ttyp (), true))
+      if (process_stop_start (c, get_ttyp ()))
 	continue;
       /* Check for special chars */
       if (c == '\r')
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 4aafe08fa..2440318b8 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2301,7 +2301,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      nlen--;
 	      i--;
 	    }
-	  process_stop_start (buf[i], get_ttyp (), true);
+	  process_stop_start (buf[i], get_ttyp ());
 	}
 
       DWORD n;
-- 
2.35.1

