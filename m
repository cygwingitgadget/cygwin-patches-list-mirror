Return-Path: <SRS0=4mOZ=BT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 3EAEA4BB58E3
	for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 10:56:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3EAEA4BB58E3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3EAEA4BB58E3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773917811; cv=none;
	b=vk8os9y49ArvTiQh0+fr9t+GulgwmjQ+qEYIlg47p4jsX8XXbgMj/SDmJ1jy8lxISk4q2ZO9sQIjlFKRjtr5kzKAKFRojHKavQSSAsvWXroUHwJR/mk0BAf31g5Ip/YU1S613NDtK9hfqD0qR7jrehf6H7obpajomPZLv0v97q8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773917811; c=relaxed/simple;
	bh=N1rqONKyYDbrIWw5A2xwlPCwgNw6OJkJqQjPEsrEXZw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BhzxLeXD3gSLFMPX6qSAcro3HsQJiHsfSeLmDQu2mpYsz9N1AJzORWkmjph01abm9vlVD91ud5C4VJMAcYMmDR/vu/tpcAt5JzrOhlJ4apz3PYbbos1hgrW9koqm74SKBjZk4TbEoLum6yDJCr1uBU4hxCgJtz5WZu/qV6gJHR4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3EAEA4BB58E3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oYYk4a7R
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260319105647935.LPYF.19957.HP-Z230@nifty.com>;
          Thu, 19 Mar 2026 19:56:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 2/6] Cygwin: pty: Add workaround for handling of backspace when pcon enabled
Date: Thu, 19 Mar 2026 19:55:16 +0900
Message-ID: <20260319105608.597-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
References: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
 <20260319105608.597-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773917808;
 bh=Hl3cZYKCwMuXuHu3RZJ96QZ/l5YMZcJ61+DRez5Oi8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oYYk4a7RSGMKA4uDhlGWpUhBwQILHiMzTpcDCq30li9eWFuiFImVj9WOE0rwGjQI3fY1/0VY
 q238+PI7ysW+/LBIEZo65cLO8l/2BFS7m/T1DIbatsz/jUJTil4QJ+lG0Gd0IXa1fXuXXwTCE1
 9hjh0VYZBI/ecWOF4Iipdzf6AqwcIH0u3lgPCHiIyK8HpOPY/X9ejw3i5AwMrULSEi2Dts8vo4
 ViFpAL/BnJ7rbL3GBe7EW+Nm8AkcNCGiLbspkSCvzT4sO3FuUjHxkVFXcZCbhcNa553kJOwZo+
 hzbODD40bRACf1NVaTHVyJfU+Yf3V782LciQ3AkrNqTrl61w==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, pseudo console has a weird behaviour that the Ctrl-H
is translated into Ctrl-Backspace (not Backspace). Similary, Backspace
(0x7f) is translated into Ctrl-H. Due to this behaviour, inrec_eq()
in cons_master_thread() fails to compare backspace/Ctrl-H events in
the input record sequence. This patch is a workaround for the issue
that replaces Ctrl-H with backspace (0x7f), which will be translated
into Ctrl-H in pseudo console.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/console.cc | 12 ++++---
 winsup/cygwin/fhandler/pty.cc     | 57 ++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index a36bbd0e2..2b1b50f0a 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -324,10 +324,14 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n1, DWORD n2)
 	{
 	  WCHAR c1 = a[i].Event.KeyEvent.uChar.UnicodeChar;
 	  WCHAR c2 = b[j].Event.KeyEvent.uChar.UnicodeChar;
-	  if (c1 == 127) /* Backspace */
-	    c1 = 8; /* Ctrl-H */
-	  if (c2 == 127) /* Backspace */
-	    c2 = 8; /* Ctrl-H */
+	  if (inside_pcon)
+	    {
+	      /* Workaround for backspace behaviour in Windows 11 */
+	      if (c1 == 8)
+		c1 = 127;
+	      if (c2 == 8)
+		c2 = 127;
+	    }
 	  if (c1 != c2)
 	    return false;
 	}
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 371e67103..72a8ba140 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2266,28 +2266,65 @@ fhandler_pty_master::write (const void *ptr, size_t len)
     { /* Reaches here when non-cygwin app is foreground and pseudo console
 	 is activated. */
       tmp_pathbuf tp;
-      char *buf = (char *) ptr;
+      char *buf = tp.c_get ();
       size_t nlen = len;
       if (get_ttyp ()->term_code_page != CP_UTF8)
 	{
 	  static mbstate_t mbp;
-	  buf = tp.c_get ();
 	  nlen = NT_MAX_PATH;
 	  convert_mb_str (CP_UTF8, buf, &nlen,
 			  get_ttyp ()->term_code_page, (const char *) ptr, len,
 			  &mbp);
 	}
+      else
+	memcpy (buf, ptr, nlen);
+
+      /* Retrieve console mode */
+      HANDLE h_pcon_in = get_ttyp ()->h_pcon_in;
+      DWORD cons_mode;
+      if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
+	{
+	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					   get_ttyp ()->nat_pipe_owner_pid);
+	  DuplicateHandle (pcon_owner, h_pcon_in,
+			   GetCurrentProcess (), &h_pcon_in,
+			   0, FALSE, DUPLICATE_SAME_ACCESS);
+	  CloseHandle(pcon_owner);
+	  DWORD resume_pid =
+	    attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+	  GetConsoleMode (h_pcon_in, &cons_mode);
+	  resume_from_temporarily_attach (resume_pid);
+	  CloseHandle (h_pcon_in);
+	}
+      else
+	GetConsoleMode (h_pcon_in, &cons_mode);
 
-      for (size_t i = 0; i < nlen; i++)
+      for (size_t i = 0, j = 0; i < nlen; i++)
 	{
 	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
-	  if (r == done_with_debugger)
+	  if (r != done_with_debugger)
 	    {
-	      for (size_t j = i; j < nlen - 1; j++)
-		buf[j] = buf[j + 1];
-	      nlen--;
-	      i--;
+	      char c = buf[i];
+	      if (!(cons_mode & ENABLE_VIRTUAL_TERMINAL_INPUT))
+		/* Workaround for pseudo console in Windows 11 */
+		/* Undesired backspace conversion in pseudo console does
+		   not happen if ENABLE_VIRTUAL_TERMINAL_INPUT is set. */
+		switch (c)
+		  {
+		  case '\010': /* Ctrl-H */
+		    c = '\177'; /* Backspace */
+		    break;
+		  case '\177': /* Backspace */
+#if 0 /* Unfortunately, Ctrl-H will be translated into Ctrl-Backspace
+	 (not Backspace) */
+		    c = '\010'; /* Ctrl-H */
+#endif
+		    break;
+		  }
+	      buf[j++] = c;
 	    }
+	  else
+	    nlen--;
 	}
 
       DWORD n;
@@ -4031,6 +4068,10 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 	    if (r[i].EventType == KEY_EVENT && r[i].Event.KeyEvent.bKeyDown)
 	      {
 		DWORD ctrl_key_state = r[i].Event.KeyEvent.dwControlKeyState;
+		if (r[i].Event.KeyEvent.uChar.AsciiChar == '\010' /* Ctrl-H */
+		    && !(ctrl_key_state & ALT_PRESSED))
+		  /* Workaround for pseudo console in Windows 11 */
+		  r[i].Event.KeyEvent.uChar.AsciiChar = '\177'; /* Backspace */
 		if (r[i].Event.KeyEvent.uChar.AsciiChar)
 		  {
 		    if ((ctrl_key_state & ALT_PRESSED)
-- 
2.51.0

