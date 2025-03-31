Return-Path: <SRS0=QGr+=WS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 93B8D385735A
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 14:15:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 93B8D385735A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 93B8D385735A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743430524; cv=none;
	b=wcy9on7B0g6U75XoaTaOHLmyYLraj+6eN9Kpa9eo8+w6S+OitT8WTTfQPxnST4qlICpODVpJihb7UYAW4OARHWpxVLO9P4vuHqZDBfiQBCtwoOvGTX7onC5DTNc/6pjs7Ni3A/gNcJGTjOX3MoDVx9CVuVsGzJnRITvV9GQRaD4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743430524; c=relaxed/simple;
	bh=DwnCWOBrOJCFKDjL6ahGCc55UFIxQrET1f85gNJJHxI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=dLYb7gaYqhzjvGd10AcquHbgV0k1PC+v7BIfIp/mpyEn9SbHFUxsyzTcP2dYPHwUU1F6JLGqXyHEPfWLDglPe4VeHhwk5A08ix/kvbC1q+VAFxU5a/PlLB+4EflGrExqP97GkbKYOSBztddVDTAIHsqW8pc5XGUlAJKSWRrMRQ0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 93B8D385735A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=b7a8u2on
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20250331141521277.ZEZJ.88147.localhost.localdomain@nifty.com>;
          Mon, 31 Mar 2025 23:15:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <christian.franke@t-online.de>
Subject: [PATCH] Cygwin: pty: Return EMFILE when too meny ptmx are opened
Date: Mon, 31 Mar 2025 23:14:51 +0900
Message-ID: <20250331141459.1340-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743430521;
 bh=UhwChDqcUeuGvuiuvnworoxfCwOT6OGzkdQkTH7p6OE=;
 h=From:To:Cc:Subject:Date;
 b=b7a8u2ona62VaixiwvFYTx5uDSrO10WW0NQBPro1AQzw8RYeNbL4be4NaW7w1/4Dx76sSvWP
 ptnWE0XEuXTGc8jU+trwqM/RuPWbmzPptHF2KYYb0K0uEo304Uf4a9dHOcp1e3Mlx37FHPVJ0a
 pFd/fIgB9IsHIIOOcrW0HD0TCSz2azbP0iptBgRAmdnosQo5SZ+tzJu3Whu2zkYdyMg4M4NLH6
 HZB1LwA0IfZ1ZMLcj85uIsp7ol/Kd9/3yLYxUV9iolAHk99MGQ4SwIa6iSnIyn3eGKoVintMZg
 w8nX+GR2euOCL5iFyYab/mxIVmg2bMnbd9E+6XfLN+/EyZ5w==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, opening /dev/ptmx fails without setting errno when it
is opened too many times. With this patch, return EMFILE in that
situation.

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257786.html
Fixes: 09738c30627c ("Cygwin: pty: setup new pty on opening the master, not in constructor")
Reported-by: Christian Franke <christian.franke@t-online.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
(cherry picked from commit 7fc7d8b1d4e323a531ab2e71581263a0675072d8)
---
 winsup/cygwin/fhandler/pty.cc | 3 +++
 winsup/cygwin/release/3.6.1   | 3 +++
 winsup/cygwin/tty.cc          | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index e61a1c89b..3128b92da 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1933,7 +1933,10 @@ int
 fhandler_pty_master::open (int flags, mode_t)
 {
   if (!setup ())
+    {
+      set_errno (EMFILE);
       return 0;
+    }
   set_open_status ();
   dwProcessId = GetCurrentProcessId ();
   return 1;
diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
index 254cfdd9c..491d7dcb9 100644
--- a/winsup/cygwin/release/3.6.1
+++ b/winsup/cygwin/release/3.6.1
@@ -27,3 +27,6 @@ Fixes:
 - Accommodate a change in Windows exception handling affecting software
   generated exceptions.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257808.html
+
+- Return EMFILE when opening /dev/ptmx too many times.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257786.html
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 2cd4ae6ed..a4b716721 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -147,7 +147,7 @@ tty_list::allocate (HANDLE& r, HANDLE& w)
     termios_printf ("pty%d allocated", freetty);
   else
     {
-      system_printf ("No pty allocated");
+      termios_printf ("No pty allocated");
       r = w = NULL;
     }
 
-- 
2.45.1

