Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id BE4FB4C318AC
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 14:30:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BE4FB4C318AC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BE4FB4C318AC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774017005; cv=none;
	b=XNU1v+NUPvYpqGmoe/OthLK2iDcDJNBIq71o7UdRUM7YpQcZ9a3LCCg0IV+o8S5N3yEGliUeRcLKjFSj+dqBP/sgRuOHaC43PFqVM0kzEZVOAb0Wf+/xdGAazyYafXbvQ7WqLwWhC/6MhIw4M3qIPWtRA+WyPdDLMQeoSxWOQoM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774017005; c=relaxed/simple;
	bh=EGfyFxLI3A+bKbaDPHwphDiTP8wAns8W0VHk0ggtXes=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=GDWRyc2xj7PgwRDo5YsYL9vD0OeaBKoxClOkC9hUW/IfUw7+9HkYgywCGGjEuGiuEonMoK6qVeaOExxgTmvWuKkngMMaXwMXiKPBuhBneL+K1Rbr7eDg4eNxfDzQNI2jLRbHK5Fh4A0ivRKNAU6eTskbw4lQYYihVxmpEZfjbuU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BE4FB4C318AC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S9jxth+j
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260320143001737.CYZU.19957.HP-Z230@nifty.com>;
          Fri, 20 Mar 2026 23:30:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 2/6] Cygwin: pty: Add workaround for handling of backspace when pcon enabled
Date: Fri, 20 Mar 2026 23:28:51 +0900
Message-ID: <20260320142925.8779-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
References: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
 <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774017001;
 bh=a//W02x2mRMrpcconp3b0JBY6wupMtWolqcTX3oWcIA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S9jxth+jzBE+pjwMCJGKwZ1WKtQrdBcvvo5VpCTU0FqSLEsXKKZF4mKNlsbBfNVcRpEB+CA3
 6cV/ZUGKRnkMLe5r+M8bLNIo5aE6SjgGVwhAcedUNqw7jxmgTdY2Pb2MTA7tVnaPfPLZj5ubik
 vI/2kP1sRFSFTmM5ILNFtagj6ZPBSGeKTTlqkTRrkWcbP9sGGqHRUxAzRuRkbCDW93tFlkqIkM
 09X0Lfm5Bgw5bWk3IhJLfIY6Tj60HvMGY+VmcbAHl3trNbeG/RHkyC2po5rKu5vd2eLyWufeyN
 oip/FiF6fyZ9MTY00UgnqqfnUbvV3aPRCklyZL0nVli/vRIw==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/console.cc | 12 ++++++-
 winsup/cygwin/fhandler/pty.cc     | 57 ++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index cab461d38..7fd655d0e 100644
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
 	  /* Fixup repeat count */
 	  WORD r1 = ak->wRepeatCount;
 	  WORD r2 = bk->wRepeatCount;
@@ -326,7 +336,7 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 	  if (r2 == 0)
 	    r2 = 1;
 	  if (ak->bKeyDown != bk->bKeyDown
-	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
+	      || c1 != c2
 	      || r1 != r2)
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

