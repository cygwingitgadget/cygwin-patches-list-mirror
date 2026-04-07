Return-Path: <SRS0=Vzu2=CG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 177524BA2E05
	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2026 12:29:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 177524BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 177524BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775564954; cv=none;
	b=uTl3ZyNSy4C0uWAQrP8oM2iG4NW3MZiFuIHYYC7zylt6/mrWzRfWpKGKXTgshr3/gW942AeRxiVBMABkRY2RKvMDm+GzjXw41XJ/7vaqd4Z4jShDSzHyovbU65ZkvkmOJuaYQ9H9pHLet7eIHJbJ8kVRDyu9ZXVpa0iiCgflTEo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775564954; c=relaxed/simple;
	bh=G1AEaW9k60LNXky/GCq9koakDwuxNyVZc5/Xhmsoadg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=v6t4wV5aG0CoLhulyggZ11aeGGunF05jSeHP7oyjbws9OYXkKb4cYL+nSd7iYcsVBDZNLO2QtzHeeNOASZSPhvb8Rr6oKusApO7heKoU+t2zMnc5woLN3j0ktveXNuuz0Pn8lnaCl1OLoX8LL76WW/aPoRd6msxoVdPhwOWi2PY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 177524BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FZSRYvQS
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260407122911446.CVEA.116672.HP-Z230@nifty.com>;
          Tue, 7 Apr 2026 21:29:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 3/3] Cygwin: console: Fix master thread for OpenConsole.exe
Date: Tue,  7 Apr 2026 21:26:30 +0900
Message-ID: <20260407122852.2153-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407212747.b84f2178e723c9645cd06799@nifty.ne.jp>
References: <20260407212747.b84f2178e723c9645cd06799@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1775564951;
 bh=RMqnZf7c8+UU88QfCbEavdkIvtpvQZ5RdWHdW+wqekY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FZSRYvQSBFyALwjnx5abjKcbIgNpmKTgEp6yBFDX9rTeW8Wh95vIAXO1eCYhRD5gV7zNJ4qH
 hF6tUR1/w650nlN5fa77Z8oXERM+yVP20G/xzssGguBAMxQx82vZlfLkXZayO4UYUroIW8ojV0
 Sye/g85CnQmGXIsyE5bY6r1736YDxwda5OvBg6UXVVscfQScBm/adnc2onbW41U7rq7F/w8Gsb
 5gMF+BJfk6/4t2m9WVct1Z2mkEGmxbN8x8uXRdIrRqLLt9oZnWOFGCoG03wmp2FJ5zWJTvcS/U
 oxULxeP5vZhv6Zn309XpOllRMzp5QRtg7tnVxj3JJ6Qz+3Lw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the console is originating from a pseudo console, current master
thread code does not work as expected if ENABLE_VIRTUAL_TERMINAL_INPUT
flag is set, particularly when OpenConsole.exe is used. This is because
the pseudo console does not preserve all the key event as is.
All bKeyDown == 0 events will be omitted from the input record written
by WriteConsoleInput() and events regarding pressing shift/control/alt
keys will be dropped as well.

This patch adds strip_inrec() function to remove all the key events
of bKeyDown == 0 or UnicodeChar == 0 before comparing/writing input
record. This function is called only when the console is originating
from a pseudo console and ENABLE_VIRTUAL_TERMINAL_INPUT flag is set.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/console.cc | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 39c4f6ff0..3da3a80db 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -305,6 +305,23 @@ cons_master_thread (VOID *arg)
   return 0;
 }
 
+static inline DWORD
+strip_inrec (INPUT_RECORD *r, DWORD n)
+{
+  /* Pseudo console with OpenConsole.exe removes the events
+     whose bKeyDown is 0 as well as ones whose charcode is 0. */
+  DWORD j = 0;
+  for (DWORD i = 0; i < n; i++)
+    {
+      if (r[i].EventType != KEY_EVENT)
+	r[j++] = r[i];
+      else if (r[i].Event.KeyEvent.bKeyDown
+	       && r[i].Event.KeyEvent.uChar.UnicodeChar)
+	r[j++] = r[i];
+    }
+  return j;
+}
+
 /* Compare two INPUT_RECORD sequences */
 static inline bool
 inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
@@ -417,6 +434,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
   while (con.owner == GetCurrentProcessId ())
     {
       DWORD total_read, n, i;
+      DWORD mode;
+      bool need_strip = false;
 
       if (con.disable_master_thread)
 	{
@@ -472,6 +491,23 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	{
 	case WAIT_OBJECT_0:
 	  acquire_attach_mutex (mutex_timeout);
+	  /* When ENABLE_VIRTUAL_TERMINAL_INPUT is set, the key events
+	     are not preserved as is. Particularly, when OpenConsole.exe
+	     is used, the following key events are simlified so much.
+	     Writing the events:
+	         press shift key -> press 'A' key ->
+	         release 'A' key -> release shift key
+	     results in only one key event whth:
+	         uChar.UnicodeChar = 0x41,
+		 wVirtualKeyCode = 0,
+		 wVirtualScanCode = 0,
+		 dwControlKeyState = 0,
+		 bKeyDown = 1
+	     Therefore, we need fixup the input record by calling
+	     strip_inrec() if the ENABLE_VIRTUAL_TERMINAL_INPUT flag is
+	     set, so that the input records are compared as expected. */
+	  GetConsoleMode (p->input_handle, &mode);
+	  need_strip = inside_pcon && (mode & ENABLE_VIRTUAL_TERMINAL_INPUT);
 	  total_read = 0;
 	  while (cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0
 		 && total_read < inrec_size)
@@ -483,6 +519,8 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	      total_read += len;
 	    }
 	  release_attach_mutex ();
+	  if (need_strip)
+	    total_read = strip_inrec (input_rec, total_read);
 	  break;
 	case WAIT_TIMEOUT:
 	  con.num_processed = 0;
@@ -607,6 +645,8 @@ remove_record:
 	      acquire_attach_mutex (mutex_timeout);
 	      PeekConsoleInputW (p->input_handle, input_tmp, inrec_size, &n);
 	      release_attach_mutex ();
+	      if (need_strip)
+		n = strip_inrec (input_tmp, n);
 	      if (n < min (total_read, inrec_size))
 		break; /* Someone has read input without acquiring
 			  input_mutex. ConEmu cygwin-connector? */
@@ -625,6 +665,8 @@ remove_record:
 		  n += len;
 		}
 	      release_attach_mutex ();
+	      if (need_strip)
+		n = strip_inrec (input_tmp, n);
 	      bool fixed = false;
 	      for (DWORD ofs = n - total_read; ofs > 0; ofs--)
 		{
-- 
2.51.0

