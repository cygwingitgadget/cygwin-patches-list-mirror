Return-Path: <SRS0=ji6e=BM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 1F9874BBC0C6
	for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2026 11:40:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1F9874BBC0C6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1F9874BBC0C6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773315603; cv=none;
	b=uC8XlTP7OstrQAJSZPgYj6RmBvDszjaXM+bShLZ4qIpdbgAWln4z0okb9iE8oXewWhjoNnHXLVZd1hWQIXlX8wjTGDABU8+Rv8AeiCRa2J5Hg4K8Dhe4PRliJdzQz8UMb+w41HxTiCFYPzNQAuCrgJQq9cGM9TCTuwt/mQHe9iA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773315603; c=relaxed/simple;
	bh=Nlia3L4tb3mLYseKSitXzWKjUPrYxwqSXlZZbzNum5M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=cZjYP3x0raChuC3kbwp/8WDp9xbuwBd29uGWEkKiJ9ypDfKgqNnWyk983CmVxK24Yd2Mv7OMULyot2aMm8mqBUc1kg/mZhnjBNxVhc2td+v1A8Xebq9Te6P7JooaLBWzvIJoQxtmG+I42B53gaEf6B8ImtGNqITkJooYrOJic+8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F9874BBC0C6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Dbx7ZkWC
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260312114001350.XLZN.127398.HP-Z230@nifty.com>;
          Thu, 12 Mar 2026 20:40:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 3/3] Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
Date: Thu, 12 Mar 2026 20:38:57 +0900
Message-ID: <20260312113923.1528-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773315601;
 bh=Sl0nd6EwyfHbXYj7BswNOU1nj1d2VbXU3g939alrONY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Dbx7ZkWCA/oih2ZfgT8/ho/GVtWM8yrntCiJl09IrDEPJiAkQLRKpd+44XFDAJ+JEiefV+V2
 pUIeVa4WKa7Mo70sHDzSc+Bh5n+v6O+ExhNavrEbGivdbyjAflv818FONjHbjH/J8uh0l3cp1y
 A6iEDQBKr7+7907xJmcZK/xKdwobvRgP/VURBh+nMFwWq0ObvRl/xJEgtHZq1CPY1z2rlGsQra
 xRpTUI6WWNuKxSkc0ATpUgLNnteAm9zXNjFeSEAPygxVMz91+YLwMwhTsEa8QjquTNq7J05XY/
 FNOkN4Lj6l1dvCHk0ZmUTLljXlPj8UpTrET0sG5L3oYgb7Kw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

OpenConsole.exe has a bug(?) that the Ctrl-H is translated into
Ctrl-Backspace (not Backspace). This is a workaround for that issue
which pushes the Ctrl-H as a ConsoleInput event.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index bd5c24625..6b353c954 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2513,9 +2513,53 @@ fhandler_pty_master::write (const void *ptr, size_t len)
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
       if (nlen)
 	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
+
+      if (resume_pid)
+	resume_from_temporarily_attach (resume_pid);
+      if (h_pcon_in)
+	CloseHandle(h_pcon_in);
+      if (pcon_owner)
+	CloseHandle(pcon_owner);
       ReleaseMutex (input_mutex);
 
       return orig_len;
-- 
2.51.0

