Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 744DF4BA9009
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:56:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 744DF4BA9009
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 744DF4BA9009
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774695418; cv=none;
	b=iI8Vt9BpBQWSiWWCacWhGjVYA67isYUftxY2QZEt4UeEF6Txt45l9PqZ6z8suQFtfiQXUvm7cF4/UpR1FaVgUlmVaBMmmLE8mWM/o7G8gTt+tXXaGKA1sZTnRh4XkOYTlQ4cF/3RBv2SgtDTC5zsAKB5P6zdUb3KXsGidN5SM/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774695418; c=relaxed/simple;
	bh=ZEPqRwpkWCVzjFZwEHdfC96eRIn6fbeJz1dqjEK9vqI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=hs/R36m6K+6rHFwwk1Ls3k2vyjXZk8cHxOeJC77p7ZitpEI+E40jbQP96eYNv1uPcWvPGuf0wqRf3aVB6tC7bAYaJu0OLssFiM5RRd49j5hbY3W3boiRCuEcPtB4slkehopaQqCLjINXsdCZNcq5AQkMlmXh6MUXjNOYGRjYIbY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 744DF4BA9009
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DJFOtLGf
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260328105655629.LDAO.58584.HP-Z230@nifty.com>;
          Sat, 28 Mar 2026 19:56:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 2/7] Cygwin: pty: Add workaround for handling of backspace when pcon enabled
Date: Sat, 28 Mar 2026 19:55:46 +0900
Message-ID: <20260328105632.1916-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
 <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774695415;
 bh=FBiBnkrXdL0IfZU/kLODBLrEskDPAm1ahHk4jpqu5pU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DJFOtLGfQACAqKV71BJvNk+k4EdEXR8ZBrkI5X+K1nzKX0W8zZFV1RZ3gM7zHdCqh1aNpQqF
 b+/GoS7wiOlgYQL2uDvNGbtRREKtL/0MR7kcp7DTKxKIjqkNuM2auYGIuEr6Xw+zcdqzMgl5yZ
 5pcNsBvRtGxZ4+TX9xYkEgNpBv+9tRbxrh4ATsPeNYF5JGoCOMSmHUNryG8ZoA31K8A47ADlVT
 ZlrLJPmszDTEG9kR6iKQrkLlbFNxgzwowief2DUseFqeXuw+DpsYPj2PbiCqKwWAijeRu0lIPy
 8VMmYa3RpFYJoaI+MkaC4tDIFzYNbaj0+ZgvRLwxBLJKvYPg==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, pseudo console has an undesired key conversion that
the Ctrl-H is translated into Ctrl-Backspace (not Backspace).
The reverse VT input path in conhost's `_DoControlCharacter()` maps
the byte 0x08 to a Ctrl+Backspace key event (VK_BACK with
LEFT_CTRL_PRESSED and character 0x7F). This was introduced in PR #3935
(Jan 2020) to make Ctrl+Backspace delete whole words. In September
2022, PR #13894 rewrote the forward path to properly implement DECBKM
(Backarrow Key Mode), but the reverse path was never updated to match,
breaking the roundtrip.

Due to this behaviour, inrec_eq() in cons_master_thread() fails to
compare backspace/Ctrl-H events in the input record sequence. This
patch is a workaround for the issue that replaces Ctrl-H with backspace
(0x7f), which will be translated into Ctrl-H in pseudo console.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/console.cc       | 12 +++-
 winsup/cygwin/fhandler/pty.cc           | 74 ++++++++++++++++++++++---
 winsup/cygwin/local_includes/fhandler.h |  2 +
 3 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 2f46bbc6c..2a52ba575 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -318,6 +318,16 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 	     written event. Therefore they are ignored. */
 	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
 	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
+	  WCHAR c1 = ak->uChar.UnicodeChar;
+	  WCHAR c2 = bk->uChar.UnicodeChar;
+	  if (inside_pcon)
+	    {
+	      /* Workaround for pseudo console in Windows 11 */
+	      if (c1 == 8) /* Ctrl-H */
+		c1 = 127; /* Backspace */
+	      if (c2 == 8) /* Ctrl-H */
+		c2 = 127; /* Backspace */
+	    }
 	  /* On Windows 11, conhost normalizes wRepeatCount from 0 to 1
 	     on readback. Treat them as equivalent for comparison. */
 	  WORD r1 = ak->wRepeatCount;
@@ -327,7 +337,7 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 	  if (r2 == 0)
 	    r2 = 1;
 	  if (ak->bKeyDown != bk->bKeyDown
-	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
+	      || c1 != c2
 	      || r1 != r2)
 	    return false;
 	}
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index fbc6152e5..7a7987c04 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1950,7 +1950,8 @@ fhandler_pty_master::fhandler_pty_master (int unit, dev_t via)
     master_thread (NULL), from_master_nat (NULL), to_master_nat (NULL),
     from_slave_nat (NULL), to_slave_nat (NULL), echo_r (NULL), echo_w (NULL),
     dwProcessId (0), to_master (NULL), from_master (NULL),
-    master_fwd_thread (NULL)
+    master_fwd_thread (NULL), h_pcon_in_dupped (NULL),
+    nat_pipe_owner_pid_dupped (0)
 {
   dev_referred_via = via;
   if (unit >= 0)
@@ -2131,6 +2132,10 @@ fhandler_pty_master::close (int flag)
     termios_printf ("error closing from_master %p, %E", from_master);
   from_master = NULL;
 
+  if (h_pcon_in_dupped)
+    ForceCloseHandle (h_pcon_in_dupped);
+  h_pcon_in_dupped = NULL;
+
   return 0;
 }
 
@@ -2241,28 +2246,75 @@ fhandler_pty_master::write (const void *ptr, size_t len)
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
 
-      for (size_t i = 0; i < nlen; i++)
+      if (get_ttyp ()->nat_pipe_owner_pid != nat_pipe_owner_pid_dupped
+	  && !nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
+	{
+	  if (h_pcon_in_dupped)
+	    ForceCloseHandle (h_pcon_in_dupped);
+	  h_pcon_in_dupped = NULL;
+	  nat_pipe_owner_pid_dupped = 0;
+	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					   get_ttyp ()->nat_pipe_owner_pid);
+	  if (pcon_owner)
+	    {
+	      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+			       GetCurrentProcess (), &h_pcon_in_dupped,
+			       0, FALSE, DUPLICATE_SAME_ACCESS);
+	      nat_pipe_owner_pid_dupped = get_ttyp ()->nat_pipe_owner_pid;
+	      CloseHandle(pcon_owner);
+	    }
+	}
+      else
+	{
+	  h_pcon_in_dupped = get_ttyp ()->h_pcon_in;
+	  nat_pipe_owner_pid_dupped = get_ttyp ()->nat_pipe_owner_pid;
+	}
+
+      /* Retrieve console mode */
+      DWORD cons_mode = ENABLE_VIRTUAL_TERMINAL_INPUT;
+      if (h_pcon_in_dupped && memchr (buf, '\010' /* Ctrl-H */, nlen))
+	{
+	  if (!nat_pipe_owner_self (nat_pipe_owner_pid_dupped))
+	    {
+	      DWORD resume_pid =
+		attach_console_temporarily (nat_pipe_owner_pid_dupped);
+	      GetConsoleMode (h_pcon_in_dupped, &cons_mode);
+	      resume_from_temporarily_attach (resume_pid);
+	    }
+	  else
+	    GetConsoleMode (h_pcon_in_dupped, &cons_mode);
+	}
+
+      len = nlen;
+      for (size_t i = 0, j = 0; i < len; i++)
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
+	      /* Workaround for pseudo console in Windows 11 */
+	      if (!(cons_mode & ENABLE_VIRTUAL_TERMINAL_INPUT))
+		/* Undesired backspace conversion in pseudo console does
+		   not happen if ENABLE_VIRTUAL_TERMINAL_INPUT is set. */
+		if (c == '\010') /* Ctrl-H */
+		  c = '\177';  /* Backspace */
+	      buf[j++] = c;
 	    }
+	  else
+	    nlen--;
 	}
 
       DWORD n;
@@ -3998,6 +4050,10 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
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
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 16f55b4f7..7ea04a26c 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2564,6 +2564,8 @@ private:
   HANDLE thread_param_copied_event;
   HANDLE helper_goodbye;
   HANDLE helper_h_process;
+  HANDLE h_pcon_in_dupped;
+  DWORD nat_pipe_owner_pid_dupped;
 
 public:
   HANDLE get_echo_handle () const { return echo_r; }
-- 
2.51.0

