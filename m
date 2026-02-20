Return-Path: <SRS0=/go4=AY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id E80FB4BA23F8
	for <cygwin-patches@cygwin.com>; Fri, 20 Feb 2026 17:03:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E80FB4BA23F8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E80FB4BA23F8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771607012; cv=none;
	b=DWWq4ZkjfKJbgPVfDB2s5wzyaoJUmwjmntxEXV6xBMqJHU0tjZPj52PkOnAwlRKO82/1qHxnDsQJdSxCmVTNPGdsrXj1i3mOHueGEd2fIRZew+wbNHlJkHvpo/cmxGeELhm+/ng5ZN0l8Sw37wWT8/4Ueicwn5ZWZHf9eudPTqg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771607012; c=relaxed/simple;
	bh=XM/ehHibhle2gqFHaUB/nlP2lQ0XkT5uwzMUlRqwRlg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=CkuYjmcsZrLLnXwSQ31pl9dWFIZHQwDe7Pw/mSfZlEtVJHrDFhk81OILIFsP4st+sihtBaPq2wCrIcj6aUQG3wffICaEncvFyBcEe9F+A+ksh7LJlq13hSmYYVpY6SrQFH3UH7CbgbeYtS5lVKpqwa9G/i7yKTKmu+ga69pUgxQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E80FB4BA23F8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ck6uMdYA
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260220170330151.KSWT.83778.HP-Z230@nifty.com>;
          Sat, 21 Feb 2026 02:03:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/4] Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
Date: Sat, 21 Feb 2026 02:02:42 +0900
Message-ID: <20260220170253.815-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170253.815-1-takashi.yano@nifty.ne.jp>
References: <20260220170253.815-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771607010;
 bh=nHP4vWG9VGFzU+psRZmpuPlO8/6IaQfZ8nRbiNdbeUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ck6uMdYAS+A3Kjmw5mzDM4fynJddUh4jUdpXupWrqrHajdX5T4/5QGoGuSJvzZITomemRirN
 8AQPgkYkDA4g+/9gd6T8Q0UJTMT8umXZ1+JQH6jY5Fx2/mit6i53Aeaj4KNwv8qUPIOHWTV/qx
 1SVLbLM4xx1YeJy8k4xS4Axrm54alhzDJLNCFa8Wnp03vKu6JbOdv7mUdPHghhVH653ID4rFh/
 CcUyoNSMts99P/zBG1gvibNxfMq0lny6LV+P9izeY1ZBCWLU+efH0Tw4zYRDLksjdQidDVrPWC
 ndoCEeiCGptpEothNxUM8chZ+R3pr7SF5J9Ps/twjseQ1nKg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

