Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 24AD94BA2E34
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:28:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 24AD94BA2E34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 24AD94BA2E34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042928; cv=none;
	b=GlzvJxEy9hlpgTmEkxt6dHCFroxFsfrzXGkUa3WAw3S3n1Ls/JMbcKUCT6hWMYVfRvDKXqyBDiD4jzKAKIms7HMHNOqcP0TxEvAjvk12HLlenTZ19G5CJ97dMq12DTTS8FN8B3N4+u9rgT/g6tsQvuv/ALc2+5tWPiA6aoeuvs8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042928; c=relaxed/simple;
	bh=rmImwLiaTOBfEl+ppFQ3bDYVu4WPS7GMUmvGG4To4g4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=tLakCYeS2EkzXutaPWwCJhctUvrY1lVmJZmQzCicVtV6yj9FYCLA/dWAhF72xNMhTfsInJGjA0fz4QmxjfEgie9eJku2VbKnVMBJNppMD0V9RztM7+/la0eC1M8l3XTtn5DJjYCq9mF/Ln79LuxpgNoGMysQcirl/PiO1+7gxdM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 24AD94BA2E34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZT3fm2YB
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251218072841376.LNXI.36235.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:28:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 3/5] Cygwin: is_console_app(): deal with the `.bat`/`.cmd` file extensions first
Date: Thu, 18 Dec 2025 16:27:57 +0900
Message-ID: <20251218072813.1644-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042921;
 bh=77po+Md8g0/i66jH6ltoq3Et0RPSDWW3NDTHogmYs4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZT3fm2YBO4p0j4lWEoy/k/WxSpzr5+V2rOYn6rodJQ7ACoEFzqCiprPT/MtNij/WAX31Ypv+
 nEdwX9p+84KW9pjbDRo4+hOeKjBiJlPCFIJb+h/7gHnKewL7Qmek8Ox/hn2NUeUxzcM4fy/WBt
 HSD/l7sTlQDb3lTeeR+Z+yHva8RYC97oA5DYUDX6b6+/05pG6rx8p+TY4Sm8nU95fRrU9QaCW0
 OVkrVD7SR36hUi4rmuH+Evg3siNXx242k/RhQ/TGTjY3zNgd4RgfBlz//pR5UoY7RsU74/KnhX
 LPKWLpzQ+LZnvkWTxkvuIxXR3Acuc2RDL6IB53p+gma3pLAw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function contains special handling of these file extensions,
treating them as console applications always, even if the first 1024
bytes do not contain a PE header with the console bits set.

However, Batch and Command files are never expected to have such a
header, therefore opening them and reading their first bytes is a waste
of time.

Let's honor the best practice to deal with easy conditions that allow
early returns first.

Fixes: bb4285206207 (Cygwin: pty: Implement new pseudo console suppot., 2020-08-19)
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/termios.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 54f3bb5dc..f99ae6c80 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -704,6 +704,9 @@ fhandler_termios::fstat (struct stat *buf)
 static bool
 is_console_app (const WCHAR *filename)
 {
+  wchar_t *e = wcsrchr (filename, L'.');
+  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
+    return true;
   HANDLE h;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
@@ -720,9 +723,6 @@ is_console_app (const WCHAR *filename)
   IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
   if (p && (char *) &p->OptionalHeader.DllCharacteristics <= buf + n)
     return p->OptionalHeader.Subsystem == IMAGE_SUBSYSTEM_WINDOWS_CUI;
-  wchar_t *e = wcsrchr (filename, L'.');
-  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
-    return true;
   /* Return true for unknown to avoid standard handles from being unset.
      Setting-up standard handles for GUI apps is pointless, but not unsafe. */
   return true;
-- 
2.51.0

