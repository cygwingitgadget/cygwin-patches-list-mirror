Return-Path: <SRS0=dMBQ=EG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 6D2F64152D36
	for <cygwin-patches@cygwin.com>; Wed, 10 Jun 2026 16:36:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6D2F64152D36
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6D2F64152D36
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781109369; cv=none;
	b=pu1h33LaCrJm0LKepbW9qjHyQL5w4XOIMs6I8qhrLTaBcFdqaA85UxPPSt/xNS5npR3gqfDIKa16IbtsV7vlcSsiv8D6jCm600jIUOPsXPTxBNdrYMaUU7aeyWlbZ6oabJCnVBkuKKFHMxjjlGR+s6WKuc4vo0/0QuqNzmSvntE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781109369; c=relaxed/simple;
	bh=YRgz3XV/9UdgIuKHE6nQs5HCPUkj1wiPyeH7uZznj48=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=hVKSt8U45RIxcj/+Kp05WeozA/PzAf4M5NSu7Ep4AwnmHt1hG7i7aLfyL1rIHjEasVQKXOq+jXr5IHImMhmLqWueRT0TVvnBz6pTmTiRZwVlK9sttrragH3nL14fDhYcDI7jgNy2YnO6f+9nsuM6rBGQjhhGN5XzhV6/MShgnYM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ONLvQ6+L
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D2F64152D36
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ONLvQ6+L
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260610163601741.KSYW.3198.HP-Z230@nifty.com>;
          Thu, 11 Jun 2026 01:36:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
Date: Thu, 11 Jun 2026 01:35:13 +0900
Message-ID: <20260610163533.10187-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781109361;
 bh=GjjILjjb6PHqItj200D53kOaIoiKOiy3xZKplfs1m8k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ONLvQ6+LnRs2XdPUUTDzzvvBpeB8oP803IujkA7tuWe7zKwMRHCItKLuE0vJO/yfeyEZMpEp
 XFCGd2TZ91R8KdfFVjDKSgG42aymjUF1ei+WuSYbiVR1aTllSidLEotrlXcmXE2oxqHGF68sP8
 vJc87lZpsqLKNduFY/5FXt31h4XYZfQvf0ToEgRKpu0kx1vS6ThOBjCUp/tyBjdDPvN+9o5vCm
 Px8DZEpTBKgNsg+CudhemlCUFDG5EHn9gpbqWYmar7WnRohzS11zsvSoi5UBvo/KdqLT3BXNC6
 pvdo2Jr7tuFNS886XcchNWKdTNybCB/DLZ5MHUV5kVX5/19w==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If you run "stty noflsh; cat" in "bash", and stop "cat" by Ctrl-C,
a stray ^C is passed to "bash". The current code calls tcflush() if
NOFLSH is not set, however, tcflush() is not called when NOFLSH is
set. So, Ctrl-C remains in console input buffer. This should be
discarded even in NOFLSH mode. This patch introduces a helper
function discard_key_events() and call it to erase Ctrl-C in the
console input buffer.

Note that even with this patch, NOFLSH is not fully functional in
console because the readahead buffer is unique to process, so it
cannot be inherited to other processes. However, it should work
intra process.

Fixes: 118e51be1d04 ("(tty_min::kill_pgrp): Handle tty flush when signal detected.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc       | 20 +++++++++++++++++---
 winsup/cygwin/fhandler/termios.cc       | 10 +++++++---
 winsup/cygwin/local_includes/fhandler.h |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index a5e6cd89d..9ac492980 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1744,17 +1744,31 @@ out:
     discard_len = 0;
   if (discard_len)
     {
-      DWORD discarded;
       acquire_attach_mutex (mutex_timeout);
       DWORD resume_pid = attach_console (con.owner);
-      ReadConsoleInputW (get_handle (), input_rec, discard_len, &discarded);
+      discard_key_events (discard_len);
       detach_console (resume_pid, con.owner);
       release_attach_mutex ();
-      con.num_processed -= min (con.num_processed, discarded);
     }
   return stat;
 }
 
+void
+fhandler_console::discard_key_events (size_t n)
+{
+  DWORD discarded = 0;
+  INPUT_RECORD input_rec[INREC_SIZE];
+  DWORD n1 = min (INREC_SIZE, n);
+  while (n)
+    {
+      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
+      n -= n1;
+      discarded += n1;
+      n1 = min (INREC_SIZE, n);
+    }
+  con.num_processed -= min (con.num_processed, discarded);
+}
+
 bool
 dev_console::fillin (HANDLE h)
 {
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index ca5fa4b7e..605258731 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -666,9 +666,13 @@ fhandler_termios::sigflush ()
      be NULL while this is alive.  However, we can conceivably close a
      ctty while exiting and that will zero this. */
   if ((!have_execed || have_execed_cygwin) && tc ()
-      && (tc ()->getpgid () == myself->pgid)
-      && !(tc ()->ti.c_lflag & NOFLSH))
-    tcflush (TCIFLUSH);
+      && (tc ()->getpgid () == myself->pgid))
+    {
+      if (!(tc ()->ti.c_lflag & NOFLSH))
+	tcflush (TCIFLUSH);
+      else
+	discard_key_events (1);
+    }
 }
 
 pid_t
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 4f5605524..49e0e7983 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1983,6 +1983,7 @@ class fhandler_termios: public fhandler_base
   pid_t tcgetsid ();
   virtual int fstat (struct stat *buf);
   int tcflow (int);
+  virtual void discard_key_events (size_t n) {}
 
   fhandler_termios (void *) {}
 
@@ -2363,6 +2364,7 @@ private:
   void wpbuf_put (char c);
   void wpbuf_send ();
   int fstat (struct stat *buf);
+  void discard_key_events (size_t n);
 
   class console_unit
   {
-- 
2.51.0

