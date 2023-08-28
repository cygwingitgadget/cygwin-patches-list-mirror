Return-Path: <SRS0=JFVn=EN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0001.nifty.com (mta-snd00012.nifty.com [106.153.226.44])
	by sourceware.org (Postfix) with ESMTPS id 73A643857C71
	for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 09:21:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 73A643857C71
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0001.nifty.com with ESMTP
          id <20230828092143545.FIPK.102246.localhost.localdomain@nifty.com>;
          Mon, 28 Aug 2023 18:21:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: termios: Refactor the function is_console_app().
Date: Mon, 28 Aug 2023 18:21:29 +0900
Message-Id: <20230828092129.770-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 789ae0179..d106955dc 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -704,22 +704,20 @@ static bool
 is_console_app (const WCHAR *filename)
 {
   HANDLE h;
-  const int id_offset = 92;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
   char buf[1024];
   DWORD n;
   ReadFile (h, buf, sizeof (buf), &n, 0);
   CloseHandle (h);
-  char *p = (char *) memmem (buf, n, "PE\0\0", 4);
-  if (p && p + id_offset < buf + n)
-    return p[id_offset] == '\003'; /* 02: GUI, 03: console */
-  else
-    {
-      wchar_t *e = wcsrchr (filename, L'.');
-      if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
-	return true;
-    }
+  /* The offset of Subsystem is the same for both IMAGE_NT_HEADERS32 and
+     IMAGE_NT_HEADERS64, so only IMAGE_NT_HEADERS32 is used here. */
+  IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
+  if (p && (char *) &p->OptionalHeader.DllCharacteristics <= buf + n)
+    return p->OptionalHeader.Subsystem == IMAGE_SUBSYSTEM_WINDOWS_CUI;
+  wchar_t *e = wcsrchr (filename, L'.');
+  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
+    return true;
   return false;
 }
 
-- 
2.39.0

