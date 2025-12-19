Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 0A01C4BA2E20
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 02:27:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0A01C4BA2E20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0A01C4BA2E20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766111242; cv=none;
	b=kgMRv8rpkwO9HxlTZuAgZhkhIxG7SMGzOiaXxEblUfDhthi4ikr18K0JZ4/qz6BsPIkrUe/Bj8MaSGed4FQAGMS/hSdCmfX1yTfpvGvn/mxFPMXElpqlyZaNpF2jqWrAxo8RJBIbjchHS6MYfo9xbVMicVRjmg/keNtvW1EJK/0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766111242; c=relaxed/simple;
	bh=r+kfEhE0T76ZpXA47T9zyFpUXG6RWt+IXZ5OqygY26o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=SBgeghq2omy0LqPpkkHXMgI5qXXAd1Ij4NIC4Zx/r67FH+1O4E4V9UpQxXj5ejqPm3hbeNYyHeVWxipfh9NJ3DGlreWugFnMHp1vA22yHgKIlHSwyrunK84PWVff5dfbMxv7cPf8DMXLFB52JcMOSCiIQ6ns+RyvjsmgFCwfYaU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0A01C4BA2E20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=o0wGGBaf
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251219022719913.VHTV.116672.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 11:27:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 3/6] Cygwin: is_console_app(): deal with the `.bat`/`.cmd` file extensions first
Date: Fri, 19 Dec 2025 11:26:36 +0900
Message-ID: <20251219022650.2239-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
References: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766111239;
 bh=7X5pkkGOo3WOWogS5Aaa1cCAx7H3JaQTQOEFpGsdU0E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=o0wGGBafIpY+Jejezt3j1tURhvMsjWGNdNF6CrTDQaGjeysaD7+V6XvIdxdRmVvLILQTT5mp
 K4i/7/Ex0bDzF1zT/zKFf4Ajd2XXJTBGRHZ5pm3FwHeYgLpw2SJgfQLSQs5udPBqWLGraHI5m+
 dirueCj9roDUNMyfgwiLU2C8wZWxtUXH2saICwqQ78KZnGJPpGQ55SFIhwqKE+CJF8czllRni+
 un1BBOaIKRTkFr+Y7Nqkn3vgC8XP/pktxy1WdQhPbvXmFdOJIXJC69yQuPA48b5tgfBbSG0k+z
 Gv8inq+8BXZD/koW+IefAn5EiCEZZsLZOWIvtoNb6rFUSgVQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Takashi Yano <takashi.yano@nifty.ne.jp>
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

