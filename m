Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 230CD4BBC0CD
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 12:25:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 230CD4BBC0CD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 230CD4BBC0CD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773750302; cv=none;
	b=ezMt21svIopBc1ABxIDh9j1tdni9CxcDpI8e394SJKakgh0KyAe7zOtxrzh0TPVvGX4Y9V3s8xE7uUd8TE00n8VV2aX8tTUKtaYHUovwwJYPvkSTs7aEOvkvqvI5W5ON09eyHRS0EUn9S8vYFqkQ/3ooOozmPjYwdNAqnVW/9dY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773750302; c=relaxed/simple;
	bh=ptmpT3i8GX9Xl/QJvOqJEd+7NYyBNbDSdaTMZ/+IeEc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=M6NOJE6d0KzPxHpbzhgBkLVuWIiSmenz2UThbAqa1HrUrV1qNZc1hQA1fZx5ZoT+h3QSUPIEId99CjbkIVFooxBGPqxBnW0/5lWk11okoHE1LEfyjeGrwdDtzMG8I4J9WB2e//3MXem3+cvgkrq4TYsckP6ZDzzx0+VVRNzH7/Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 230CD4BBC0CD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UCyXreWK
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260317122458338.NPQC.36235.HP-Z230@nifty.com>;
          Tue, 17 Mar 2026 21:24:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/6] Cygwin: pty: Add workaround for handling of backspace when pcon enabled
Date: Tue, 17 Mar 2026 21:23:06 +0900
Message-ID: <20260317122433.721-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
 <20260317122433.721-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773750298;
 bh=W2ThSGEeXOPPB29Jb+bMJNOD67AIWhPBcKLmaPq/EsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UCyXreWKzFz+dP6SFt+DmZeiMvD/DUFCVwaSLNDQsnQmIcKlfIvf/974eDlrrGsDpJCkeNX/
 NflWr5TtjOh6o8+ivFvqTOrIe8vINtO4ENADdQC0GGoLfiQNvATM8UT8dgAsdGOnjYvoMLoZ2/
 ty1fY/NV0drQEmmoq8ZFQhhy+DldllaSPvkHNT/N0gemogTlI1evShcg6JsP0p7A/48k6KCrEz
 P2xbgX491ISDpekBjvU3Ts/Zm9IJ1EKVRnT5wcQ9LZvGJiGPZ+9UnYFTfHpTR0tmMUYXf4rjCf
 iumYIdBJC5bFdJr1XpehizCyxVYH8LKZ7UCwm66v0DO/Ke0g==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, pseudo console has a weird behaviour that the Ctrl-H
is translated into Ctrl-Backspace (not Backspace). Similary, Backspace
(0x7f) is translated into Ctrl-H. Due to this behaviour, inrec_eq()
in cons_master_thread() fails to compare backspace/Ctrl-H events in
the input record sequence. This patch is a workaround for that issue
which pushes the Ctrl-H or Backspace as a ConsoleInput event instead
of sending char code to pseudo console.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 371e67103..bde88ab0e 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2290,9 +2290,73 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	}
 
+      /* In Windows 11, pseudo console has a weird behaviour that
+	 Ctrl-H is translated into Ctrl-Backspace (not Backspace).
+	 Similary, backspace (0x7f) is translated into Ctrl-H. The
+	 following code is a workaround for that issue. */
+      char *bs_pos1 = (char *) memchr (buf, '\010' /* ^H */, nlen);
+      char *bs_pos2 = (char *) memchr (buf, '\177' /* BS */, nlen);
+      HANDLE h_pcon_in = get_ttyp ()->h_pcon_in;
+      DWORD resume_pid = 0;
+      if ((bs_pos1 || bs_pos2)
+	  && !nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
+	{
+	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					   get_ttyp ()->nat_pipe_owner_pid);
+	  DuplicateHandle (pcon_owner, h_pcon_in,
+			   GetCurrentProcess (), &h_pcon_in,
+			   0, FALSE, DUPLICATE_SAME_ACCESS);
+	  CloseHandle(pcon_owner);
+	  resume_pid =
+	    attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+	}
+
       DWORD n;
+      while (bs_pos1)
+	{
+	  if (bs_pos1 - buf > 0)
+	    WriteFile (to_slave_nat, buf, bs_pos1 - buf, &n, NULL);
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
+	  nlen -= bs_pos1 - buf + 1;
+	  buf = bs_pos1 + 1;
+	  bs_pos1 = (char *) memchr (buf, '\010' /* ^H */, nlen);
+	}
+      while (bs_pos2)
+	{
+	  if (bs_pos2 - buf > 0)
+	    WriteFile (to_slave_nat, buf, bs_pos2 - buf, &n, NULL);
+	  INPUT_RECORD r;
+	  r.EventType = KEY_EVENT;
+	  r.Event.KeyEvent.bKeyDown = 1;
+	  r.Event.KeyEvent.wRepeatCount = 0;
+	  r.Event.KeyEvent.wVirtualKeyCode = 0;
+	  r.Event.KeyEvent.wVirtualScanCode = 0;
+	  r.Event.KeyEvent.uChar.AsciiChar = '\177'; /* BS */
+	  r.Event.KeyEvent.dwControlKeyState = 0;
+	  WriteConsoleInput(h_pcon_in, &r, 1, &n);
+	  r.Event.KeyEvent.bKeyDown = 0;
+	  WriteConsoleInput(h_pcon_in, &r, 1, &n);
+	  nlen -= bs_pos2 - buf + 1;
+	  buf = bs_pos2 + 1;
+	  bs_pos2 = (char *) memchr (buf, '\177' /* BS */, nlen);
+	}
       if (nlen)
 	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
+
+      if (resume_pid)
+	resume_from_temporarily_attach (resume_pid);
+      if (h_pcon_in)
+	CloseHandle(h_pcon_in);
       ReleaseMutex (input_mutex);
 
       return orig_len;
-- 
2.51.0

