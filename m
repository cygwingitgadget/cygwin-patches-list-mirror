Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 0FED04BA79B4
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 05:23:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0FED04BA79B4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0FED04BA79B4
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782796993; cv=none;
	b=K+JjnAv0hXca/ZupcMUFAugLki2nOe9JFJpjcyHTFGfoD2SYm3oJWB8zRhFQw5jGCjtKQScOHa+5k/5Ekgf4AuzqR4r0ZHWzB4N9uj1l5i7GJ3IFHGIw24ttoUaKGpCp2GWirgcGNFJLiD6d6lfzQHxiiT3xTMeI8nFvXzymIBU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782796993; c=relaxed/simple;
	bh=gBDTPbU+/JpISfWXx/1jjuhED7InC7dADeXAO/253wE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Fj4rN1ThHVro9n0D6Ydnm8Qz1wTP5NJuqo/FLjyGCprNJ68M5sbJNz/IpU/jXjytR6bYfF3QDbus1hYJ/Emn3RUESpqgA5rSkUKQY2EkjsKjRvn+4ewJWOWDW0b9lvpnnU/iAUAr0Lll0dUAMNzg47BY4HeDMlW5Lo9XG1qkmy8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S4046roY
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0FED04BA79B4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S4046roY
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260630052308728.JBJC.18412.HP-Z230@nifty.com>;
          Tue, 30 Jun 2026 14:23:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Do not transfer input to nat-pipe while masked
Date: Tue, 30 Jun 2026 14:22:52 +0900
Message-ID: <20260630052300.955-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782796988;
 bh=MDAS55Ips+EZJECoGaYob5yjV4hW0y3AqxF8VNcEJsM=;
 h=From:To:Cc:Subject:Date;
 b=S4046roYaGMxrh6uVoXBjO5rWtkEmCIoGxIKCRTn6WsAlRs5qt2OzGmaHkV91rZcbORbLgJy
 Eo3tk46BpF6nl51jr5tmAHN2xwkcCh1DWOZE+Bnrt/RW/kGcJQJDlsasSQvYJ2K9nn2kFNUTox
 csETW03+x6NIfgwhVQFIa3SMiXjPctmHbTr6DDn25UpLx0gllYYnipyKLMrZ1/PUdp4bJcXGAy
 iBetnSPM5KJqKLf8gO06VoHLiv/RN/uXePx+XGTdTJ7ZABv/RDHicCAc/1hb4Yo9BbvTAnGYac
 GPUiB+OfEGnz6fsMb32Gw08dY1nc/aLubWgV1pUbMeZ7/EmA==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On the command "cat | non-cygwin-app", `cat` sometimes fails to read
key input. This happens when `cat` starts to read input before `non-
cygwin-app` configures pseudo console. This is because pipe state is
switched to nat-pipe when pseudo console is configured.

This patch prevent the pipe state from changing to nat-pipe state if
some cygwin process is reading input from the cyg-pipe.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 35e320507..b9e25519d 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -4401,6 +4401,18 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 				    HANDLE input_available_event,
 				    HANDLE input_transferred_to_cyg)
 {
+  if (dir == tty::to_nat)
+    {
+      char name[MAX_PATH];
+      shared_name (name, TTY_SLAVE_READING, ttyp->get_minor ());
+      HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
+      CloseHandle (masked);
+      if (masked)
+	/* Cygwin process is reading cyg-pipe.
+	   Do not transfer input to nat-pipe. */
+	return;
+    }
+
   HANDLE to;
   if (dir == tty::to_nat)
     to = ttyp->to_slave_nat ();
-- 
2.51.0

