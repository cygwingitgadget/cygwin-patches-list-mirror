Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 0C53E4B9DB5F
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:03:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0C53E4B9DB5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0C53E4B9DB5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269413; cv=none;
	b=mm3H3rx7MFsZhdve0S63eNJmjm9jrX2acGqsUtCMPjaNCN5sIc2YthTBe6ot8gO6pMcbx9Ho5i20dMvGNzk7ns0/KXHpJ8sv6mWcUCLK8fuwfrRkeTYb7Rq/KWjStzp7lYHziM0rmqQ+yzpXKYaowYmj2bthTePS8065CeNbmx0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269413; c=relaxed/simple;
	bh=+2URaMf2h7Oz7Q8L4fuCiNt640MsHzeGXLRaX8iYcrI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=NYJmSpwsTdFEv9rJHgrVCaNfpdw6cnhm6r+3lRnMo3l4dF92fWMp60FfTKyZW8iskMufxJwj2MvfjlHF5k1w3FUW+W23AkpNyhKjRh1OgGEKydXCxa0k534dcqOCpizK4n38Tt52q/OOTYFmjHalygoF9ON4e8ThtK4aEoFxDiY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0C53E4B9DB5F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JopZtEVD
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260228090331237.YDYX.127398.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:03:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 3/4] Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
Date: Sat, 28 Feb 2026 18:02:52 +0900
Message-ID: <20260228090304.2562-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
References: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269411;
 bh=kPEz4ZRCJcP3WQWry8SUEUD8eeD+Tg5UnJlJPQ15Xy0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JopZtEVDwsfebywkT+7/aHp0lDdt9v05QtVoxrTn7nz+saxOGdZlmDP1JP390uXp5WRv3Nu/
 Kf/VJ3n8RCZ6CrM5czbGDmg5+dBLN3j9eTGLGQsY1SdR4/J2f3khiADNBRpvsmaxgUor6JP/7W
 HwU0wY+28LrN1iF17+b/r2t+/n5C7pHGv5ePinM+qCUXahjgD4OKBK+bqiRR3i7BPEuKbNzCPg
 mkZ7VCCgNFTZxIMoXlQwpP6625TixzSgFFXPYERwG9zM6gF0HR8enfU4LeBS9zDjjhQYXi36EQ
 d8mRENhjOE2Eb9NZtJYpwgYm4cbR//IwSODQXT5AFGuF4Zdw==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 7366eea09..9a175e722 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2459,8 +2459,53 @@ fhandler_pty_master::write (const void *ptr, size_t len)
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

