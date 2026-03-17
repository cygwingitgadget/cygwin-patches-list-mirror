Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id A56594C3187E
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 12:24:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A56594C3187E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A56594C3187E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773750293; cv=none;
	b=aEn4/oUxASw+Eb+52IeFPIgpAwtirSooMdGm6vn7ATMNIfd2FhXmxGdpFJY5oyOuoBnLiQ2cM4oXiAc0vvIApQFPeYrclSygYN47TWTHxqnY4tQt1I9bPz/vOL/rUMRKr7EY87Z5HEBJp63bje3/syAhFZIR0dR0DbLhv5Frsmg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773750293; c=relaxed/simple;
	bh=jZLCdVJIQlUanzBgPT+eYlZGk3vQV+WMFjskhyEjhy8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=YSqq+DSoP5P4q4wyeylPNm0aY6DNY/jAP+DHabqIlPkl2uMblFdM9gmMFEdqEJ7czsZ3ToPZkGGBsW0WRUgur+zR5sFriFTslWYgs/J/HxEXMu2giYwIrvjeqOV8t5UBbwuynF9kw0LDpTBDHjF+KddRH7TB4yHNiQTHouPeHpo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A56594C3187E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rB5y3+37
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260317122450346.NPPH.36235.HP-Z230@nifty.com>;
          Tue, 17 Mar 2026 21:24:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/6] Cygwin: console: Fix master thread for a pseudo console
Date: Tue, 17 Mar 2026 21:23:05 +0900
Message-ID: <20260317122433.721-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
 <20260317122433.721-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773750290;
 bh=BEkMTqGUdPofbPoYOsPYg0WVr9yjNasSD2R9g3mCEqU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rB5y3+37uGYKmyWIYfwxaBqCzpF/tklnZs/tFCleFhn/4jiTklCml7AIQL4YqAiU+Av+Q3b8
 D9I2ke2A02vi9Ff5ukxCnVuCZ5BdDrEn9CYozaMy8UAfFJdkFe9Zd0Ls0Kfrc7LxU50//Od0t9
 vu+esFhaojmuZPi6iMwzrkN9TnRAFGnP0ZZH3LjCLyroyL8XEw95AuA3covHBswdSVvI6EvSIr
 s4sG9q73ZbtzarqVLa6pn62uOUn7Ez4sHtSEu+8lUQp0GVbPiKxIEEkV5pjTZrW3yOQ21U9swT
 ZPE8uwLsIo1EYYbJzyuRWM7r1IudrSjvCr53PsuOAByuTOrA==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/console.cc | 101 ++++++++----------------------
 1 file changed, 27 insertions(+), 74 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 9fd3ff506..582505cb8 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -306,58 +306,32 @@ cons_master_thread (VOID *arg)
 
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
-	{
-	  const WINDOW_BUFFER_SIZE_RECORD
-	    *aw = &a[i].Event.WindowBufferSizeEvent;
-	  const WINDOW_BUFFER_SIZE_RECORD
-	    *bw = &b[i].Event.WindowBufferSizeEvent;
-	  if (aw->dwSize.X != bw->dwSize.X
-	      || aw->dwSize.Y != bw->dwSize.Y)
-	    return false;
-	}
-      else if (a[i].EventType == MENU_EVENT)
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
+	  if (a[i].Event.KeyEvent.uChar.UnicodeChar !=
+	      b[j].Event.KeyEvent.uChar.UnicodeChar)
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
@@ -584,11 +558,8 @@ remove_record:
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
 	      /* Try to fix */
 	      acquire_attach_mutex (mutex_timeout);
@@ -603,15 +574,13 @@ remove_record:
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
@@ -620,30 +589,14 @@ remove_record:
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

