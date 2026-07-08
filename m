Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id ACDEC4BA2E09
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 04:03:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ACDEC4BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ACDEC4BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783483412; cv=none;
	b=v6q8gosRh48OFEh23fBihcg3+tJtloRC1xQ6/ZB8Q2uwzhGcmdf3pWcPo4paEvQT8TwSzgW9t01A29kSncTHyNVT+FGGIUy+yXFon8DdfaOAwKD8A8oSgpce4np9IXTQ9DT7itL2KF98j8jCHhOQe/CZBEgiCPEBeTUYwaehcJU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783483412; c=relaxed/simple;
	bh=9gCds2ftjZkORNHHNAcXZQO3ru4E0FCE66B13QbYfgI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=V8LYwD0ONiN1aUqHNCs+BxpkLum5eSCziS54LU2H/oPFt2Un520P0OOUdNFFtlxZCOonfGn8Kf2uwyWflQDhVxKfJMBxFXnS7xFwWOnmTkE4KNmFxb/OW4SOxc8Z9H7OsOLEalPGtu6vnjrvxDgAEK2De2SVBkfShzDI1894aNI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DZ2GekmA
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ACDEC4BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DZ2GekmA
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260708040329167.ECZF.44671.HP-Z230@nifty.com>;
          Wed, 8 Jul 2026 13:03:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Cygwin: console: Correct previous NOFLSH fix
Date: Wed,  8 Jul 2026 13:03:12 +0900
Message-ID: <20260708040323.905-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783483409;
 bh=LhgrxukMxTyz/cE6AOyn2zWBq2eU8YdXqOj9VnwJKoU=;
 h=From:To:Cc:Subject:Date;
 b=DZ2GekmAe6cQO2N7sOhzfbhIaBQDGn+YA3/27x9h35EhxI3cf2ANrPhVtjsIBS8wzoURrAAN
 Qh4A3PYtY/Kn7MJX7k6WeCgpnrQXsNn/ZNL2oyNLYyA5kdOUIe+tbTvRJsz9DnkHoK5/pTaXzS
 219/rxo4TwMhHacEWWd6Lw5z061EW3kLyeGZyB+IJHcZJNlqGSzqsWahnJWhba7AYLg+43Tryh
 /PhIcxO17PGahQutDEyvVfXuFVBlE+5UjgEriq5JjX/kwefkptLeV9hTO+1tnAtAxb5MHGhA2o
 CQ5c61JuALrCs3UQ/6nfLljeoBWlfc729I+lTp3lIoVthDgg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The previous fix for NOFLSH mode does not work as intended.

discard_key_events(), added in "Cygwin: console: Fix NOFLSH behaviour a
bit", loops on ReadConsoleInputW() until it has consumed the requested
number of records, but ReadConsoleInputW() blocks while the console
input buffer is empty. sigflush() calls it with a hard-coded count of
one and no guarantee that a record is actually queued: in the
master-thread path the signalling record has already been read out of
the buffer before sigflush() runs, so the call blocks until, and then
swallows, the user's next keystroke.

To avoid this, this patch does not discard input when process_sigs()
is called from cons_master_thread, where the value of `fh` is NULL,
because discarding will be done in cons_master_thread.

And because the ReadConsoleInputW() return value is unchecked, a failed
read leaves the count indeterminate, so "n -= n1" can underflow and spin.
Check return value of ReadConsoleInputW() and abort if it fails.

Moreover, discard_key_event(1) does not work as intended if the first
key event is not a bKeyDown event correspoding to the signalling key.
Use discard_key_events(0) instead. This means discarding input events
to the current position processed. Since the key-strokes prior to the
signalling key are already in the readahead buffer, so this call discards
only the signalling key. The important point here is to discard input
before releasing input_mutex by release_input_mutex_if_necessary(),
because, if not, cons_master_thread starts to process key events before
discarding signalling key event because the thread can acquire
input_mutex. This causes the signalling key is processed twice.

One separate point: the `process_input_message()` caller wraps
`discard_key_events()` in `acquire_attach_mutex()` + `attach_console
(con.owner)`, but the `sigflush()` call site does not, so the
`ReadConsoleInputW()` there runs against whatever console the calling
process happens to be attached to. With the guard above the worst case
is a no-op when the calling process happens not to be attached, so
it would be more correct to move the attach into the helper itself.

This patch also fixes two more special cases. One is done_with_debugger
case. When `gdb cat` is executed and the `cat` is running, Ctrl-C
discards all the key events including the events after Ctrl-C. This
is because tcflush() is used for the purpose. Use discard_key_events(0)
instead. The other case is not_signalled_but_done case. Previously,
when `cat | non-cygwin-app` is executed and Ctrl-C is pressed, but
the `Ctrl-C` is not VINTR, line_edit() wrongly returned
line_edit_signalled even though `cat` is not signalled by Ctrl-C.
In this case, `cat` should receive Ctrl-C as a input char, while
`non-cygwin-app` has been killed by Ctrl-C. Fix this in line_edit().

Fixes: 66324edf64a9 ("Cygwin: console: Fix NOFLSH behaviour a bit")
Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Use discard_key_events(0) instead of tcflush(TCIFLUSH), which
    discards events to the current position processed.
v3: Fix behaviour of two special cases: done_with_debugger and
    not_signalled_but_done

 winsup/cygwin/fhandler/console.cc       | 25 +++++++++++++---------
 winsup/cygwin/fhandler/termios.cc       | 28 ++++++++++++++-----------
 winsup/cygwin/local_includes/fhandler.h |  1 +
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 730bb0b45..cc4591c14 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1718,6 +1718,7 @@ fhandler_console::process_input_message (size_t len)
 	  continue;
 	}
 
+      num_input_events_processed = i + 1;
       num_chars += nread;
       if (toadd)
 	{
@@ -1748,17 +1749,11 @@ out:
   /* Discard processed recored. */
   DWORD discard_len = min (total_read, i + 1);
   /* If input is signalled, do not discard input here because
-     tcflush() is already called from line_edit(). */
-  if (stat == input_signalled && !(ti->c_lflag & NOFLSH))
+     discard_key_events() is already called from line_edit(). */
+  if (stat == input_signalled)
     discard_len = 0;
   if (discard_len && (len || stat != input_ok))
-    {
-      acquire_attach_mutex (mutex_timeout);
-      DWORD resume_pid = attach_console (con.owner);
-      discard_key_events (discard_len);
-      detach_console (resume_pid, con.owner);
-      release_attach_mutex ();
-    }
+    discard_key_events (discard_len);
   return stat;
 }
 
@@ -1766,15 +1761,25 @@ void
 fhandler_console::discard_key_events (size_t n)
 {
   DWORD discarded = 0;
+  if (n == 0)
+    {
+      n = num_input_events_processed;
+      num_input_events_processed = 0;
+    }
   INPUT_RECORD input_rec[INREC_SIZE];
   DWORD n1 = min (INREC_SIZE, n);
+  acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   while (n)
     {
-      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
+      if (!ReadConsoleInputW (get_handle (), input_rec, n1, &n1) || !n1)
+	break;
       n -= n1;
       discarded += n1;
       n1 = min (INREC_SIZE, n);
     }
+  detach_console (resume_pid, con.owner);
+  release_attach_mutex ();
   con.num_processed -= min (con.num_processed, discarded);
 }
 
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 605258731..9971bb1d9 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -353,7 +353,10 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      fhandler_pty_common::attach_console_temporarily (p->dwProcessId);
 	  if (fh && p == myself && being_debugged ())
 	    { /* Avoid deadlock in gdb on console. */
-	      fh->tcflush(TCIFLUSH);
+	      if (fh->is_console ())
+		fh->discard_key_events (0 /* to current position */);
+	      else
+		fh->tcflush(TCIFLUSH);
 	      fh->release_input_mutex_if_necessary ();
 	    }
 	  /* CTRL_C_EVENT does not work for the process started with
@@ -444,10 +447,14 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	goto not_a_sig;
 
       termios_printf ("got interrupt %d, sending signal %d", c, sig);
-      if (!(ti.c_lflag & NOFLSH) && fh)
+      if (fh)
 	{
-	  fh->eat_readahead (-1);
-	  fh->discard_input ();
+	  if (!(ti.c_lflag & NOFLSH))
+	    {
+	      fh->eat_readahead (-1);
+	      fh->discard_input ();
+	    }
+	  fh->discard_key_events (0 /* to current position */);
 	}
       if (fh)
 	fh->release_input_mutex_if_necessary ();
@@ -525,11 +532,12 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
       switch (process_sigs (c, get_ttyp (), this))
 	{
 	case signalled:
-	case not_signalled_but_done:
 	case done_with_debugger:
 	  sawsig = true;
 	  get_ttyp ()->output_stopped &= ~BY_VSTOP;
 	  continue;
+	case not_signalled_but_done:
+	  break;
 	case not_signalled_with_nat_reader:
 	  disable_eof_key = true;
 	  break;
@@ -666,13 +674,9 @@ fhandler_termios::sigflush ()
      be NULL while this is alive.  However, we can conceivably close a
      ctty while exiting and that will zero this. */
   if ((!have_execed || have_execed_cygwin) && tc ()
-      && (tc ()->getpgid () == myself->pgid))
-    {
-      if (!(tc ()->ti.c_lflag & NOFLSH))
-	tcflush (TCIFLUSH);
-      else
-	discard_key_events (1);
-    }
+      && (tc ()->getpgid () == myself->pgid)
+      && !(tc ()->ti.c_lflag & NOFLSH))
+    tcflush (TCIFLUSH);
 }
 
 pid_t
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 8e9cbef4b..d11b3ec4f 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2201,6 +2201,7 @@ private:
   HANDLE input_mutex, output_mutex;
   handle_set_t handle_set;
   _minor_t unit;
+  size_t num_input_events_processed;
 
   /* Used when we encounter a truncated multi-byte sequence.  The
      lead bytes are stored here and revisited in the next write call. */
-- 
2.51.0

