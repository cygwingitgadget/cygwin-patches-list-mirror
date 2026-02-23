Return-Path: <SRS0=vXQ3=A3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id A8A634BA23C0
	for <cygwin-patches@cygwin.com>; Mon, 23 Feb 2026 08:02:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A8A634BA23C0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A8A634BA23C0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771833744; cv=none;
	b=mjHTnEVqWMRN8Qy1fZ90j0KaXl85M0bPChxPgszG/mr+H+Wn4HMOX/6Vi80/32CDZHnm+WboygSRC+gFhPsZ3CvYffimrbkCgxv9xt2eAwmWvINK2VPMBUG3RMRSyei02VlbZZyb68SLdZJ+zGP0TEa5eylovsQYD0tSTxI5ih0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771833744; c=relaxed/simple;
	bh=7/lOGO/udq9KVQ1MrAiO1ODmsqnxb5c3BYPljM0uEv0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=UkI4N0G5nDZcKAMqXoak9Aj/tzZ7sHrZ8YNO+a0Wqt8YhJzvtaZMTIKXgE+RRspX4ekK3wt0MfV0KvDPD67PdWgigPih6aJjbR0DkbxhgZMW31rh8ZEqkKzXDphDxlwvarHE5es7HqIjD5+Uyag+Uioevd7BB6Mh36Ja6EPmWwc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A8A634BA23C0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=BBWcxANu
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20260223080216700.UFUG.48098.HP-Z230@nifty.com>;
          Mon, 23 Feb 2026 17:02:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 3/4] Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
Date: Mon, 23 Feb 2026 17:01:29 +0900
Message-ID: <20260223080141.340-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223080141.340-1-takashi.yano@nifty.ne.jp>
References: <20260223080141.340-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771833736;
 bh=aQn65266ykFPExdVqYKOwwWkIQDK30dYayk7IE34Uq0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BBWcxANuXFAZ0ZKMMCU42PBnoQ0yx/zjm8EfHpLff6Cqi1iPNWJpz+kBNJ1eakOX64bLhg6/
 1h39fhPq0S4SU8afb08yJfRgzkwWbIFzQh/ExUMP1QliOxfN+SEQLm15YcloJ5he9ZB1YPPYel
 eKnLMecopcuCLcBFheve4uKqz6Ni2I6Fe2D+AVNEeV2Ijc54tu47YHO9nbYSXfWiNOf5NVh21R
 BqonsrzU5pmqWBSQrVZUK30rd6DebIhcXloi2DRDZB9U4QNGPLuxgnMhZhx/MiZQTsyKHpcfDm
 MlmaEQOVF1LLMpiqCd2uwgPzv+MJ2efQMEH4wrWQ8QzwI/TQ==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index b9ca5658d..6b114c795 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2452,8 +2452,53 @@ fhandler_pty_master::write (const void *ptr, size_t len)
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

