Return-Path: <SRS0=mEoq=W3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 7C8B33858C48
	for <cygwin-patches@cygwin.com>; Wed,  9 Apr 2025 06:19:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7C8B33858C48
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7C8B33858C48
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744179555; cv=none;
	b=lpAnvxYWEODi/By0AJQQTFu0kZ3NTDm6pclxvYLp7bWi1PdcJaoNIiOcGvhRgOsarw9CDOftqpWDrBTFnw1KdVacxqG4Imzly/9I9xfOpKmdxZ/R22/fHbd9qpqABI6HCKrUG+oP8nCwm28Mi+QGPxeNVkHNW1sBS+cVtXGMBiY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744179555; c=relaxed/simple;
	bh=SPaFNWhqdM2AbCQRptO7R2rRL00uXocLuRpKUznME3Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=rW5U4V5QkEXLP97TOIkQjVLmfirRD1MTmrcTOn+E84p/woU7Yuy8FakJtlS308NVB44UKe1vi2xp8MUc3a7UOeA9eB6ChI+bjw7nfVlrgMicoNQfc4X5P8afewZ4UPORD+d38vb1yFNwNuw+FRfz2cnQ1U+bXtkU3YaNA1R8m4w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C8B33858C48
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZWKVDdh8
Received: from localhost.localdomain by mta-snd-e04.mail.nifty.com
          with ESMTP
          id <20250409061912454.NEXJ.90539.localhost.localdomain@nifty.com>;
          Wed, 9 Apr 2025 15:19:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: termios: Implement tcflow(), tcdrain(), TCXONC, TIOCINQ
Date: Wed,  9 Apr 2025 15:18:51 +0900
Message-ID: <20250409061858.1125-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1744179552;
 bh=fuQODglRbT0Si+ANtFoKOCW4+dHu5Zf8a+2nhhUbzVM=;
 h=From:To:Cc:Subject:Date;
 b=ZWKVDdh8s4sumMWuQnZrDDPFbZcpCoCtslHFPbVujGPPEU8JbZY3HPus5oLs62keUdnUOlE1
 36dLu2wG7z8byTFkb8hnEpAEeITKzYVAT4Wh5nmXU8ecOE8/z+bo87HqCfSGyXftpY0Buw1vws
 XOMkPn5Oy0TyHcCDxrsK5vHHbk3s+eiVult+/NMUzwVqdk4KHxe3gackwcAiS037qJHKdcC9sr
 ey2X7J2+LF6i/GypUIfAtQSZHY7XnMKbk7X1Ry8Cyo2f9ZlCCaNpjGLYoDxZQgqXD+ahG2V53v
 SW7xc8CfWWBnr7OlZECe/ekliQNlZieRrgrn2wlM4j8bFGvw==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, tcflow() and tcdrain() were missing from console and pty.
ioctl() command: TCXONC, TIOCINQ, and TCFLSH were also missing.
Due to this, "stress-ng --pty 1" failed. This patch implements them.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc       | 30 +++++++++++++++++++++---
 winsup/cygwin/fhandler/pty.cc           | 30 ++++++++++++++++++++++++
 winsup/cygwin/fhandler/termios.cc       | 31 +++++++++++++++++++++----
 winsup/cygwin/include/sys/termios.h     |  1 +
 winsup/cygwin/local_includes/fhandler.h |  7 ++++--
 winsup/cygwin/local_includes/tty.h      |  6 ++++-
 6 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index a38487f9b..c61364391 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -509,7 +509,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		case not_signalled_but_done:
 		case done_with_debugger:
 		  processed = true;
-		  ttyp->output_stopped = false;
+		  ttyp->output_stopped &= ~BY_VSTOP;
 		  if (ti.c_lflag & NOFLSH)
 		    goto remove_record;
 		  con.num_processed = 0;
@@ -1144,6 +1144,15 @@ fhandler_console::read (void *pv, size_t& buflen)
 
   push_process_state process_state (PID_TTYIN);
 
+  if (get_ttyp ()->input_stopped && is_nonblocking ())
+    {
+      set_errno (EAGAIN);
+      buflen = (size_t) -1;
+      return;
+    }
+  while (get_ttyp ()->input_stopped)
+    cygwait (10);
+
   size_t copied_chars = 0;
 
   DWORD timeout = is_nonblocking () ? 0 :
@@ -2131,6 +2140,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	release_output_mutex ();
 	return -1;
       case FIONREAD:
+      case TIOCINQ:
 	{
 	  DWORD n;
 	  int ret = 0;
@@ -2183,6 +2193,14 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	  return 0;
 	}
 	break;
+      case TCXONC:
+	res = this->tcflow ((int)(intptr_t) arg);
+	release_output_mutex ();
+	return res;
+      case TCFLSH:
+	res = this->tcflush ((int)(intptr_t) arg);
+	release_output_mutex ();
+	return res;
     }
 
   release_output_mutex ();
@@ -4172,8 +4190,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 void
 fhandler_console::doecho (const void *str, DWORD len)
 {
-  bool stopped = get_ttyp ()->output_stopped;
-  get_ttyp ()->output_stopped = false;
+  int stopped = get_ttyp ()->output_stopped;
+  get_ttyp ()->output_stopped = 0;
   write (str, len);
   get_ttyp ()->output_stopped = stopped;
 }
@@ -4711,3 +4729,9 @@ fhandler_console::cons_mode_on_close ()
 
   return tty::restore; /* otherwise, restore */
 }
+
+int
+fhandler_console::tcdrain ()
+{
+  return 0;
+}
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 3128b92da..b882b903e 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1304,6 +1304,15 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 
   push_process_state process_state (PID_TTYIN);
 
+  if (get_ttyp ()->input_stopped && is_nonblocking ())
+    {
+      set_errno (EAGAIN);
+      len = (size_t) -1;
+      return;
+    }
+  while (get_ttyp ()->input_stopped)
+    cygwait (10);
+
   if (ptr) /* Indicating not tcflush(). */
     mask_switch_to_nat_pipe (true, true);
 
@@ -1650,6 +1659,7 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
       retval = this->tcsetpgrp ((pid_t) (intptr_t) arg);
       goto out;
     case FIONREAD:
+    case TIOCINQ:
       {
 	DWORD n;
 	if (!bytes_available (n))
@@ -1664,6 +1674,12 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
 	  }
       }
       goto out;
+    case TCXONC:
+      retval = this->tcflow ((int)(intptr_t) arg);
+      goto out;
+    case TCFLSH:
+      retval = this->tcflush ((int)(intptr_t) arg);
+      goto out;
     default:
       return fhandler_base::ioctl (cmd, arg);
     }
@@ -2342,6 +2358,7 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
     case TIOCSPGRP:
       return this->tcsetpgrp ((pid_t) (intptr_t) arg);
     case FIONREAD:
+    case TIOCINQ:
       {
 	DWORD n;
 	if (!bytes_available (n))
@@ -2352,6 +2369,10 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
 	*(int *) arg = (int) n;
       }
       break;
+    case TCXONC:
+      return this->tcflow ((int)(intptr_t) arg);
+    case TCFLSH:
+      return this->tcflush ((int)(intptr_t) arg);
     default:
       return fhandler_base::ioctl (cmd, arg);
     }
@@ -4194,3 +4215,12 @@ fhandler_pty_common::resume_from_temporarily_attach (DWORD resume_pid)
     }
   release_attach_mutex ();
 }
+
+int
+fhandler_pty_common::tcdrain ()
+{
+  DWORD n;
+  while (bytes_available (n) && n > 0)
+    cygwait (10);
+  return 0;
+}
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index a3cecdb6f..19d6220bc 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -491,16 +491,16 @@ fhandler_termios::process_stop_start (char c, tty *ttyp)
     {
       if (CCEQ (ti.c_cc[VSTOP], c))
 	{
-	  ttyp->output_stopped = true;
+	  ttyp->output_stopped |= BY_VSTOP;
 	  return true;
 	}
       else if (CCEQ (ti.c_cc[VSTART], c))
 	{
 restart_output:
-	  ttyp->output_stopped = false;
+	  ttyp->output_stopped &= ~BY_VSTOP;
 	  return true;
 	}
-      else if ((ti.c_iflag & IXANY) && ttyp->output_stopped)
+      else if ((ti.c_iflag & IXANY) && (ttyp->output_stopped & BY_VSTOP))
 	goto restart_output;
     }
   if ((ti.c_lflag & ICANON) && (ti.c_lflag & IEXTEN)
@@ -540,7 +540,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	  fallthrough;
 	case not_signalled_but_done:
 	case done_with_debugger:
-	  get_ttyp ()->output_stopped = false;
+	  get_ttyp ()->output_stopped &= ~BY_VSTOP;
 	  continue;
 	case not_signalled_with_nat_reader:
 	  disable_eof_key = true;
@@ -915,3 +915,26 @@ fhandler_termios::get_console_process_id (DWORD pid, bool match,
       }
   return res_pri ?: res;
 }
+
+int
+fhandler_termios::tcflow (int action)
+{
+  switch (action)
+    {
+    case TCOOFF:
+      get_ttyp ()->output_stopped |= BY_TCFLOW;
+      return 0;
+    case TCOON:
+      get_ttyp ()->output_stopped = 0;
+      return 0;
+    case TCIOFF:
+      get_ttyp ()->input_stopped |= BY_TCFLOW;
+      return 0;
+    case TCION:
+      get_ttyp ()->input_stopped = 0;
+      return 0;
+    default:
+      set_errno (EINVAL);
+      return -1;
+    }
+}
diff --git a/winsup/cygwin/include/sys/termios.h b/winsup/cygwin/include/sys/termios.h
index d1b4a0af5..4c030426c 100644
--- a/winsup/cygwin/include/sys/termios.h
+++ b/winsup/cygwin/include/sys/termios.h
@@ -18,6 +18,7 @@ details. */
 #define	TIOCMBIC	0x5417
 #define	TIOCMSET	0x5418
 #define	TIOCINQ		0x541B
+#define TCXONC		0x540A
 #define TIOCSCTTY	0x540E
 
 /* TIOCINQ is utilized instead of FIONREAD which has been
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 8c71d8495..2177cec87 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1979,6 +1979,7 @@ class fhandler_termios: public fhandler_base
   virtual off_t lseek (off_t, int);
   pid_t tcgetsid ();
   virtual int fstat (struct stat *buf);
+  int tcflow (int);
 
   fhandler_termios (void *) {}
 
@@ -2143,12 +2144,12 @@ class dev_console
   char cons_rabuf[40];  // cannot get longer than char buf[40] in char_command
   char *cons_rapoi;
   bool cursor_key_app_mode;
-  bool disable_master_thread;
+  volatile bool disable_master_thread;
   tty::cons_mode curr_input_mode;
   tty::cons_mode curr_output_mode;
   DWORD prev_input_mode;
   DWORD prev_output_mode;
-  bool master_thread_suspended;
+  volatile bool master_thread_suspended;
   int num_processed; /* Number of input events in the current input buffer
 			already processed by cons_master_thread(). */
 
@@ -2273,6 +2274,7 @@ private:
   int tcflush (int);
   int tcsetattr (int a, const struct termios *t);
   int tcgetattr (struct termios *t);
+  int tcdrain ();
 
   int ioctl (unsigned int cmd, void *);
   int init (HANDLE, DWORD, mode_t, int64_t = 0);
@@ -2391,6 +2393,7 @@ class fhandler_pty_common: public fhandler_termios
   DWORD __acquire_output_mutex (const char *fn, int ln, DWORD ms);
   void __release_output_mutex (const char *fn, int ln);
 
+  int tcdrain ();
   int close (int flag = -1);
   off_t lseek (off_t, int);
   bool bytes_available (DWORD& n);
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 2a047d73f..a418ab1f9 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -30,6 +30,9 @@ details. */
 #define MIN_CTRL_C_SLOP 50
 #endif
 
+#define BY_TCFLOW 2
+#define BY_VSTOP  1
+
 typedef void *HPCON;
 
 #include "devices.h"
@@ -43,7 +46,8 @@ class tty_min
 
 public:
   pid_t pgid;
-  bool output_stopped;		/* FIXME: Maybe do this with a mutex someday? */
+  volatile int output_stopped;	/* FIXME: Maybe do this with a mutex someday? */
+  volatile int input_stopped;
   fh_devices ntty;
   ULONGLONG last_ctrl_c;	/* tick count of last ctrl-c */
   bool is_console;
-- 
2.45.1

