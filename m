Return-Path: <SRS0=Yn/K=BV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 02CCD4BB5883
	for <cygwin-patches@cygwin.com>; Sat, 21 Mar 2026 11:36:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 02CCD4BB5883
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 02CCD4BB5883
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774092999; cv=none;
	b=IueQ6NrRc8304V9RhimASmVeMnQ+jNupUiFzcNhONRVb1h2zOjaP2Zz9fP1gEc5XM3X0kbjiLBOJ3q5COk8qtugf6kDEcR2Ag4XqKf2QmbHR5IrG3VIzJiQAFYe/vLqi1T6ZxnTD2AE/pb4/JyaD1QsFDyJsBy2cM3yMwPMdf2M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774092999; c=relaxed/simple;
	bh=zXQasUXZYald14ocPMC7lYDLMiP85Gi09MbTkqla9m0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=EU9Tuf7QZzH52SRMIFY0mvIEdNjljsc001SZfucfjwA7S1rsmWrY4DcsP08tCcnNxbMHpMX+Z38q8bT0x098Lu3RuhrvDMrrJspXTeuKtpSz4FvtA7t3WwlIx9MYwKrbBUyd1z1bYyuHr5VFDLxC+5FYlAvwYaRGgEVKfYFqaEg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 02CCD4BB5883
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OVUiRLb/
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260321113637040.VNSR.36235.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 20:36:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 2/6] Cygwin: pty: Add workaround for handling of backspace when pcon enabled
Date: Sat, 21 Mar 2026 20:35:27 +0900
Message-ID: <20260321113613.9443-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
References: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
 <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774092997;
 bh=JXc92iktZeasWEjxbUcGUeJ72qcbAOJaDjxyRnkT36E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OVUiRLb/UWb8A5baAck4mxgIRZEA3mT0IkGThygfvMFm0XWN2X9MiBYrZPjMp7/0U0n+ctU/
 huUrMDbgLXSmg18pW/k+Lv53llGIOf2pmO3capeUhIC90F745hZh8QE3GcQ2lBMKR5Xv2gUWYa
 EyiZ9dL1QSKJOXSBqBA40JQNQDdDBg/rdQA172NSL/vzZHRj4fp5czA1No9iBcZ6DzV9NEXa46
 sJm0isR69Z5FhUdkmaPfJ34gRXodu6U9uS7dHFN5gELXThSPwwfbNIUugedeuw+Id4Ps/pF8bQ
 YPeUL50H5WFLCJX+7raJ2FbYCHdokQ70178VPen91KzOXsNg==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 2f59f8f24..9678775d1 100644
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

