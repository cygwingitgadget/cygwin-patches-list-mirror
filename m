Return-Path: <SRS0=4mOZ=BT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 0EA7C4B1A297
	for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 10:56:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0EA7C4B1A297
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0EA7C4B1A297
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773917802; cv=none;
	b=tqArOuB1Q8EBAGLELr/brMi8oCSZt6ACYWiDmgCMRRVr5y7z1DTXi8xnhf5A+pZ58CZe5tzy/nSCXkTiBi+AA5xl+Pt9mz1vFav1peADVQYndps7pPGoz0ouD98ywx53Rfs38KM54NtTr9nIpFSJiDIVh8A23/sSY6UBa7WGl6Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773917802; c=relaxed/simple;
	bh=ljI73bEIPdZwdqy7CxQwtpUqO5ZVs8M/DBl6Lf7+C+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=d3BpMlUJeMNR8rDrIWGaAKVghldyJQDFD9bOv0TaGXybugo+C6x8a+FOZ4aA0wDQhDBJOF3qSRoAarHQ59iZdGdLGuTvXYvAUt6UC4L4ws/pQ27Ym9IyspnMDwYceq/DjCcpTVipIs2hLF6oWgGU3/WhnH0DxToqgwKNHQ8LZZQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0EA7C4B1A297
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L56V3Be3
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260319105632108.LPWF.19957.HP-Z230@nifty.com>;
          Thu, 19 Mar 2026 19:56:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 1/6] Cygwin: console: Fix master thread for a pseudo console
Date: Thu, 19 Mar 2026 19:55:15 +0900
Message-ID: <20260319105608.597-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
References: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
 <20260319105608.597-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773917792;
 bh=76aCVLGxALpAC3MZBBFnw2M+WAQNJjqaopXyR1pn4K4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L56V3Be3dUkptDYKFLeW7ovIb9x7AGS0Z2GEEpuTt+k4jrMT5Iw7jkfp9P+I1oKq+KYmFVja
 ivlqYErvM0C40Jx3XAb579E6HMDkqiqIC3xLmFrJZCIunBtzI6BmpjzLiO4joT2ZDI05mDOxQz
 s/nYY5GB5sGQhvW+y7nWb7MiOTbMcnE2Wg8HLXU4XdudltQ/c0QC4cTi2zr9HS0vZbhN3woZIL
 wbcY2K4mS6+SPQI+pOsxZqs40/600DEL5QBtdD89LH7okDm83Aj5nEkVzCyiFC982luEOaVIGs
 urKX5M8iK0LwX4RB4CKhG1baT9OooVjdAlHW8fOkL/8bDsIA==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the console is originating from a pseudo console, teh current
master thread code does not work as expected. This is because the
pseudo console does not keep all the event as is.

So, the event sequence read by ReadConsoleInput() is not match with
the sequence written by WriteConsoleInput(). Length of the event
sequence is also mismatch.

This happens when a cygwin app is executed from non-cygwin shell
such as cmd.exe, powershell.exe, etc. The symptom is that the
typed keys order is sometimes swapped and disordered.

With this patch, to address this problem, `inrec_eq()` compares
only key-down events and ignores other events. In addition, the
algorithm is modified so that it never depends on the sequence
length.

Addresses: https://github.com/git-for-windows/git/issues/5632
Fixes: ff4440fcf768 ("Cygwin: console: Introduce new thread which handles input signal.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 114 ++++++++++--------------------
 1 file changed, 39 insertions(+), 75 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 9fd3ff506..a36bbd0e2 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -306,58 +306,37 @@ cons_master_thread (VOID *arg)
 
 /* Compare two INPUT_RECORD sequences */
 static inline bool
-inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
+inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n1, DWORD n2)
 {
-  for (DWORD i = 0; i < n; i++)
+  DWORD i = 0, j = 0;
+  while (i < n1 && j < n2)
     {
-      if (a[i].EventType != b[i].EventType)
-	return false;
-      else if (a[i].EventType == KEY_EVENT)
-	{ /* wVirtualKeyCode, wVirtualScanCode and dwControlKeyState
-	     of the readback key event may be different from that of
-	     written event. Therefore they are ignored. */
-	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
-	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
-	  if (ak->bKeyDown != bk->bKeyDown
-	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
-	      || ak->wRepeatCount != bk->wRepeatCount)
-	    return false;
-	}
-      else if (a[i].EventType == MOUSE_EVENT)
-	{
-	  const MOUSE_EVENT_RECORD *am = &a[i].Event.MouseEvent;
-	  const MOUSE_EVENT_RECORD *bm = &b[i].Event.MouseEvent;
-	  if (am->dwMousePosition.X != bm->dwMousePosition.X
-	      || am->dwMousePosition.Y != bm->dwMousePosition.Y
-	      || am->dwButtonState != bm->dwButtonState
-	      || am->dwControlKeyState != bm->dwControlKeyState
-	      || am->dwEventFlags != bm->dwEventFlags)
-	    return false;
-	}
-      else if (a[i].EventType == WINDOW_BUFFER_SIZE_EVENT)
+      while (i < n1 && (a[i].EventType != KEY_EVENT
+			|| !a[i].Event.KeyEvent.bKeyDown
+			|| !a[i].Event.KeyEvent.uChar.UnicodeChar))
+	i++;
+      while (j < n2 && (b[j].EventType != KEY_EVENT
+			|| !b[j].Event.KeyEvent.bKeyDown
+			|| !b[j].Event.KeyEvent.uChar.UnicodeChar))
+	j++;
+
+      if (i < n1 && j < n2)
 	{
-	  const WINDOW_BUFFER_SIZE_RECORD
-	    *aw = &a[i].Event.WindowBufferSizeEvent;
-	  const WINDOW_BUFFER_SIZE_RECORD
-	    *bw = &b[i].Event.WindowBufferSizeEvent;
-	  if (aw->dwSize.X != bw->dwSize.X
-	      || aw->dwSize.Y != bw->dwSize.Y)
-	    return false;
-	}
-      else if (a[i].EventType == MENU_EVENT)
-	{
-	  const MENU_EVENT_RECORD *am = &a[i].Event.MenuEvent;
-	  const MENU_EVENT_RECORD *bm = &b[i].Event.MenuEvent;
-	  if (am->dwCommandId != bm->dwCommandId)
-	    return false;
-	}
-      else if (a[i].EventType == FOCUS_EVENT)
-	{
-	  const FOCUS_EVENT_RECORD *af = &a[i].Event.FocusEvent;
-	  const FOCUS_EVENT_RECORD *bf = &b[i].Event.FocusEvent;
-	  if (af->bSetFocus != bf->bSetFocus)
+	  WCHAR c1 = a[i].Event.KeyEvent.uChar.UnicodeChar;
+	  WCHAR c2 = b[j].Event.KeyEvent.uChar.UnicodeChar;
+	  if (c1 == 127) /* Backspace */
+	    c1 = 8; /* Ctrl-H */
+	  if (c2 == 127) /* Backspace */
+	    c2 = 8; /* Ctrl-H */
+	  if (c1 != c2)
 	    return false;
 	}
+      else if (i >= n1 && j >= n2)
+	return true;
+      else
+	return false;
+      i++;
+      j++;
     }
   return true;
 }
@@ -397,7 +376,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
   termios &ti = ttyp->ti;
   while (con.owner == GetCurrentProcessId ())
     {
-      DWORD total_read, n, i;
+      DWORD total_read, n, i, prev_n;
 
       if (con.disable_master_thread)
 	{
@@ -548,6 +527,7 @@ remove_record:
       con.num_processed = total_read;
       if (total_read)
 	{
+	  prev_n = 0;
 	  do
 	    {
 	      /* Writeback input records other than interrupt. */
@@ -584,12 +564,14 @@ remove_record:
 	      acquire_attach_mutex (mutex_timeout);
 	      PeekConsoleInputW (p->input_handle, input_tmp, inrec_size, &n);
 	      release_attach_mutex ();
-	      if (n < min (total_read, inrec_size))
-		break; /* Someone has read input without acquiring
-			  input_mutex. ConEmu cygwin-connector? */
 	      if (inrec_eq (input_rec, input_tmp,
-			    min (total_read, inrec_size)))
+			    min (total_read, inrec_size), n))
 		break; /* OK */
+	      if (con.owner != GetCurrentProcessId ())
+		break;
+	      if (n == prev_n) /* Fix failes without new input */
+		break; /* Giving up */
+	      prev_n = n;
 	      /* Try to fix */
 	      acquire_attach_mutex (mutex_timeout);
 	      n = 0;
@@ -603,15 +585,13 @@ remove_record:
 		}
 	      release_attach_mutex ();
 	      bool fixed = false;
-	      for (DWORD ofs = n - total_read; ofs > 0; ofs--)
+	      for (DWORD ofs = 1; ofs < n; ofs++)
 		{
-		  if (inrec_eq (input_rec, input_tmp + ofs, total_read))
+		  if (inrec_eq (input_rec, input_tmp + ofs, total_read, n - ofs))
 		    {
 		      memcpy (input_rec + total_read, input_tmp,
 			      m::bytes (ofs));
-		      memcpy (input_rec + total_read + ofs,
-			      input_tmp + total_read + ofs,
-			      m::bytes (n - ofs - total_read));
+		      total_read += ofs;
 		      fixed = true;
 		      break;
 		    }
@@ -620,30 +600,14 @@ remove_record:
 		{
 		  for (DWORD i = 0, j = 0; j < n; j++)
 		    if (i == total_read
-			|| !inrec_eq (input_rec + i, input_tmp + j, 1))
+			|| !inrec_eq (input_rec + i, input_tmp + j, 1, 1))
 		      {
-			if (total_read + j - i >= n)
-			  { /* Something is wrong. Giving up. */
-			    acquire_attach_mutex (mutex_timeout);
-			    DWORD l = 0;
-			    while (l < n)
-			      {
-				DWORD len;
-				WriteConsoleInputW (p->input_handle,
-						    input_tmp + l,
-						    min (n - l, inrec_size),
-						    &len);
-				l += len;
-			      }
-			    release_attach_mutex ();
-			    goto skip_writeback;
-			  }
 			input_rec[total_read + j - i] = input_tmp[j];
 		      }
 		    else
 		      i++;
+		  total_read = n;
 		}
-	      total_read = n;
 	    }
 	  while (true);
 	}
-- 
2.51.0

