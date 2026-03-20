Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 8F64B4C515F7
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 16:02:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8F64B4C515F7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8F64B4C515F7
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774022526; cv=none;
	b=Ov/ShHkSlbJW2SLu9GK0ErGEWlcI7NLjGMVXrzLA0HcxauyKLbrwNKYrlTZK6Q4hyiZOaRMsDltZ4gD33lc5+5xRqgFdAYmp3HvUgNegm9C1XrelNPHR73KFdneqoTK3J+WCL1zFvGEPE3P2AyLyboNY3EnkOMfT0LqsI3Fr7TM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774022526; c=relaxed/simple;
	bh=zXQasUXZYald14ocPMC7lYDLMiP85Gi09MbTkqla9m0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=B039N3d9hW7ys4XlaaW8TlnXjip9zX/KFebbdpShMWi8/8BLuQWXPiFcWDeMKDLO45ROE3aNsqg1juDaWYpDZD0sAzZFy7t9crZqD9sxhDSb5tpWVCkQhtKksE1gaa1Ni/oK9C1ptd2f/qr9L12U2AlJp0dltqgT5DYewVnW3u4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8F64B4C515F7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=R1j/3wZ9
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260320160203692.HLRI.14880.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 01:02:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 2/6] Cygwin: pty: Add workaround for handling of backspace when pcon enabled
Date: Sat, 21 Mar 2026 01:01:06 +0900
Message-ID: <20260320160143.1548-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
References: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
 <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774022523;
 bh=JXc92iktZeasWEjxbUcGUeJ72qcbAOJaDjxyRnkT36E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=R1j/3wZ9oXe+XjfKTinvOlRIWOivbgOZKCEzH1MN0KJeTdEQ14l8F2V80TlIJpaFuN8YIUK1
 6ub39JCYUfDtYKSp4D4BRB6b8pQm/uBoXgVlXDSq3HVmo3Fay996cNfyitU9ciPIMMIsx+NYxq
 DbyUI5LYNryWHSKwhoUZfAC4Pwf37O6BH1/s0SPyd88yqrx886h0kF2Q2yYD+srHsha5/QMeWz
 WK7RxWcJe8j3am5889ML/FXlhJt7JE9BylwpM5i4Zrab3DAFy871QFxmx5zfKyPaf/aXUVvgfg
 kvu+GqI6eenUHid0CpLZ12LhfrhCNIuDw4Uo913bfRqJ8O5g==
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

