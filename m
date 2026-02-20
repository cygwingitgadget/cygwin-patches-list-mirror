Return-Path: <SRS0=/go4=AY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id D8E674BAD14D
	for <cygwin-patches@cygwin.com>; Fri, 20 Feb 2026 17:20:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D8E674BAD14D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D8E674BAD14D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771608015; cv=none;
	b=eD3CqArfK18lyzQX/Ojd8u3BT2e90QZ4C3w6vXqQqyn7OpPBXmtnUsItf+M3cQu5nOOTQcJqgWdnq4HWbgvrwzOyeDOf1LuYpfFNz9BPCHJIbYm6+27NTwM+xC7jcakESH3zULpdb33jaEfLZc+LEZ3S1IAynqWjQCKDFE7Ywqk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771608015; c=relaxed/simple;
	bh=XM/ehHibhle2gqFHaUB/nlP2lQ0XkT5uwzMUlRqwRlg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=RdQDqHZS/fF4r+MZMhjxQXBbqthlAhDCrN4trqLbLs03hz0Tst+3bDFFky+89Nz3KunqatZqVC22GWT/QzHREENX267dY6Oz7ZSN1KWw9QIpYDB4460UYePgLeVHTvdnyXB/13LVXcQE5kF+gPoPqameI71d1APrXnZ35J2lTkQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D8E674BAD14D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MDKnfHYM
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260220172012921.HPNL.50988.HP-Z230@nifty.com>;
          Sat, 21 Feb 2026 02:20:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 3/4] Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
Date: Sat, 21 Feb 2026 02:19:14 +0900
Message-ID: <20260220171937.1969-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
References: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771608012;
 bh=nHP4vWG9VGFzU+psRZmpuPlO8/6IaQfZ8nRbiNdbeUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MDKnfHYMf/HVKLdMqsoR5yDeQocEpfq3rGCT4BlVS4yKvQyb8PYr8ySCcfJ3yBKnmmbMYon6
 qSS6f0V0hNsUFC0ox2xA89NUKW8SB/ILmOnwPA9oy+cur52XNXqjYvvHRIB/jjfAYRjPCgkesV
 jdHotjyqLiNZGmmsq5Z/FzvaFn7G9HdeSXqr9n8ybF2duTcm4brQQRlIax5p72KtvdGumzjON6
 ReYxcL3XMOCmyTHIrvxwpgC5yTKe7BsiOp1oqSnoM60vOXU4vVzdpVe8lLJBzBvpFjJRQDcraX
 Abo3RKrijKWr+p3rV7QUh23DLYw4NTivp9UvZHEQ+L2fYK6Q==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

OpenConsole.exe has a bug(?) that the Ctrl-H is translated into
Ctrl-Backspace (not Backspace). This is a workaround for that issue
which pushes the Ctrl-H as a ConsoleInput event.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 47 ++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 8963b9424..1b818d2ff 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2456,8 +2456,53 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	}
 
+      /* OpenConsole.exe has a bug(?) that Ctrl-H is translated into
+	 Ctrl-Backspace (not Backspace). The following code is a
+	 workaround for that issue. */
+      char *bs_pos = (char *) memchr (buf, '\010' /* ^H */, nlen);
+      HANDLE pcon_owner = NULL;
+      HANDLE h_pcon_in = NULL;
+      DWORD resume_pid = 0;
+      if (bs_pos)
+	{
+	  pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				    get_ttyp ()->nat_pipe_owner_pid);
+	  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+			   GetCurrentProcess (), &h_pcon_in,
+			   0, FALSE, DUPLICATE_SAME_ACCESS);
+	  resume_pid =
+	    attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+	}
+
       DWORD n;
-      WriteFile (to_slave_nat, buf, nlen, &n, NULL);
+      while (bs_pos)
+	{
+	  if (bs_pos - buf > 0)
+	    WriteFile (to_slave_nat, buf, bs_pos - buf, &n, NULL);
+	  INPUT_RECORD r;
+	  r.EventType = KEY_EVENT;
+	  r.Event.KeyEvent.bKeyDown = 1;
+	  r.Event.KeyEvent.wRepeatCount = 0;
+	  r.Event.KeyEvent.wVirtualKeyCode = 0;
+	  r.Event.KeyEvent.wVirtualScanCode = 0;
+	  r.Event.KeyEvent.uChar.AsciiChar = '\010'; /* ^H */
+	  r.Event.KeyEvent.dwControlKeyState = LEFT_CTRL_PRESSED;
+	  WriteConsoleInput(h_pcon_in, &r, 1, &n);
+	  r.Event.KeyEvent.bKeyDown = 0;
+	  WriteConsoleInput(h_pcon_in, &r, 1, &n);
+	  nlen -= bs_pos - buf + 1;
+	  buf = bs_pos + 1;
+	  bs_pos = (char *) memchr (buf, '\010' /* ^H */, nlen);
+	}
+      if (nlen > 0)
+	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
+
+      if (resume_pid)
+	resume_from_temporarily_attach (resume_pid);
+      if (h_pcon_in)
+	CloseHandle(h_pcon_in);
+      if (pcon_owner)
+	CloseHandle(pcon_owner);
       ReleaseMutex (input_mutex);
 
       return len;
-- 
2.51.0

