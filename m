Return-Path: <SRS0=TCz0=E7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 2662D4BA2E07
	for <cygwin-patches@cygwin.com>; Sun,  5 Jul 2026 15:37:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2662D4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2662D4BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783265878; cv=none;
	b=gsqXyGyMfObtJrl86zrg66Ita2/Wcmxb2NJOnNlUnJWmRXRyMY1gxXoMI375EnrNtXaXNlTyv2jU9kjL2U/1mW/6vIG1iZQDhoceZ5CPBYspYzQhnJ6r1+VFx+LeIHNkX84JBN3s+tCNK7oV7RIPh09aLNYr5gxTQalhZJ1DZwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783265878; c=relaxed/simple;
	bh=eyTU5Mw+RAuzWfmMgQK76TtSSxyaysDQWXL+fxVCyzo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=O2rMpRzouQ/lJAHtp8eRMpFEVazmt8kWsFwG1P0e4paDG/ue/rSvpE8dIQ8FwtA+kSVOJzqhmhT/d9VmRy19cnw2QVzr/6VIFsgyHWuAToAsMNWaZWK4+pqkl1XKVH+pC5mGIbYqtlxfos/I+/SOABaWsnX0U9AC5mh9ST3WoSA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JCrwAAr3
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2662D4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JCrwAAr3
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260705153751990.LJXK.44671.HP-Z230@nifty.com>;
          Mon, 6 Jul 2026 00:37:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: console: Correct previous NOFLSH fix
Date: Mon,  6 Jul 2026 00:37:35 +0900
Message-ID: <20260705153745.1827-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783265872;
 bh=RJ3HxEK+bPR4BBil/wJAxSyp5lP2W7CofmgUHKx0XnM=;
 h=From:To:Cc:Subject:Date;
 b=JCrwAAr3+ppMeQGOv+6qo673RzkSCNFReVlA/X/RbzGjpLHItWN6R2VGK9VD+4Lwm4Z/5pem
 Sz+BO2NkTaGuqyCBt6ARPn0fry6XGqgamaVEdovoMuMG/0tW3SROtuy9I4GnQrzzXGEVAG9hJH
 Z0OhtUZoYFmwL6VrLyaAC3vXAHn+CtNaaqODESjkyaJhb7FkO8fQiekP6w6fCTwEFSj9u7FHc2
 ZWfVLAhmj+DpO2Y2bo5Uj85W+CL8pFQ8oW4xDQiaMR6UqtL8uQnJvd2DbMdUkDPCyIsb5F8QZW
 pSAzqsOQPQZ90jABrgTpI9DLqAIY6BZIf9HvY+2GBdyxkWUg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: 66324edf64a9 ("Cygwin: console: Fix NOFLSH behaviour a bit")
Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

v2: Use discard_key_events(0) instead of tcflush(TCIFLUSH), which
    discards events to the current position processed.

 winsup/cygwin/fhandler/console.cc       | 25 +++++++++++++++----------
 winsup/cygwin/fhandler/termios.cc       | 20 ++++++++++----------
 winsup/cygwin/local_includes/fhandler.h |  1 +
 3 files changed, 26 insertions(+), 20 deletions(-)

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
index 605258731..6395a99ea 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -444,10 +444,14 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
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
@@ -666,13 +670,9 @@ fhandler_termios::sigflush ()
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

