Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 407E84BA23E6
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 04:10:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 407E84BA23E6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 407E84BA23E6
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782792628; cv=none;
	b=RHrNxdyhJQkxxG/N4Kgyvxkx2anZcf9oGPJD35AA+Y3apKXKAr/6bPbFgV5xIcKFtKdRBoASlp9sYrhJeauGa+CjcRDi36Iakbc6K6Fpi1ftbicIJ4+d2zK/WrU/Mh1HzxZabC1YRJbsiC2dzLXB0XDpzYqmvOKyj3RT9Dp6xk0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782792628; c=relaxed/simple;
	bh=urO/cwR9EMakLBfT55//tZI7zWNJlMh7ApXyj10nhJw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=OWT2r84agx28mubnM/+X9TUNZD8k2bAGAji6eAkc86UG+woILBGwwxRcLXGDucOc9F9mSHKJ+MdhJITab/WEhvGGkgqkMRdsHkX+GE9CVx5Rs9q8FTqMWN/zQCkGb1dPQv0GEJ0OWbwzq/2brtgLJo8mIrH+Mb/JguUnwZuaqeY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PcyVb4xq
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 407E84BA23E6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PcyVb4xq
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260630041024278.HZIU.18412.HP-Z230@nifty.com>;
          Tue, 30 Jun 2026 13:10:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: console: Correct previous NOFLSH fix
Date: Tue, 30 Jun 2026 13:10:08 +0900
Message-ID: <20260630041017.1006-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782792624;
 bh=KxrCT09pewS3+5no5rWOT96ckemkUFJnx/ImnawJAWo=;
 h=From:To:Cc:Subject:Date;
 b=PcyVb4xqlHCQ5uu4VUq2FQNZc1hAZf5Yp3x+R9qI0nHh/RchN8ZlfDPhOPe83L95IwIOdygO
 Atec8gOMRNTHPbUTP3yFEPjA1fJP9N6p7zv7TBos0weu3YbaR1THRjzskHr55GkdfFLAxlwtFm
 VRrNkomfjcvUdWyw9eOTGc2POagADWylbjAReed7XmZWMQRAl/Q0/v3mcK2xSogvU/IjULGMgC
 p2t1vgwYcyHJWSgfZtxX21EqdMn2Of6FKCYubkTKIA2Az0w9u8Zw6+KDesNxnNEiH0929PUJqH
 ZekiiVgdFOR9KQeqP7I4NUHnJvrucV9zBbUKQvtmeNSfAMzg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
Use tcflush() instead(). Since the ey-strokes prior to the signalling
key are already in the readahead buffer, so tcflush() discards only
the signalling key. The important point here is to discard input before
releasing input_mutex by release_input_mutex_if_necessary(), because,
if not, cons_master_thread starts to process key events before discarding
signalling key event because the thread can acquire input_mutex. This
causes the signalling key is processed twice.

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
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 17 ++++++++---------
 winsup/cygwin/fhandler/termios.cc | 21 +++++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 730bb0b45..925db828c 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1749,16 +1749,10 @@ out:
   DWORD discard_len = min (total_read, i + 1);
   /* If input is signalled, do not discard input here because
      tcflush() is already called from line_edit(). */
-  if (stat == input_signalled && !(ti->c_lflag & NOFLSH))
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
 
@@ -1768,13 +1762,18 @@ fhandler_console::discard_key_events (size_t n)
   DWORD discarded = 0;
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
index 605258731..c59027093 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -444,10 +444,15 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
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
+	  if (fh->is_console ())
+	    fh->tcflush (TCIFLUSH);
 	}
       if (fh)
 	fh->release_input_mutex_if_necessary ();
@@ -666,13 +671,9 @@ fhandler_termios::sigflush ()
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
-- 
2.51.0

