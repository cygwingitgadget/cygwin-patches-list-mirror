Return-Path: <SRS0=edmR=JW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1011.nifty.com (mta-snd01007.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 0DB643858C50
	for <cygwin-patches@cygwin.com>; Tue, 13 Feb 2024 14:33:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0DB643858C50
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0DB643858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1707834809; cv=none;
	b=ntHJiqLdr2XuBgboXrgvroXwpXCXDO1T7Gtqt/1/2KyT4SpO9PBbSvGKD0Jp7gPXpFQrVmld006hZcPmWbzKhcpsoHXPnrS4GAuZgyuLhfbvgcGw38EXDgTD6t4druolgjT1pRV7EpL17oHq9fh8wrt/3A6VaOOCo6JzS3eQ318=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1707834809; c=relaxed/simple;
	bh=sCwNdPxNcyfVejs125nFQXEr1yrEIw+ruWMK2wKZCI4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jStt2mQaVHF1LhFsucFVik8+YGNMGwoM/faAS9VTJ51Gtpsc+R2ShlG2yffUSU9CBUufdURgPPJ2E7ovr+y3NEh2GPoxbzNymQGS50i8F1MVGluGuuVM9nr5iocfIs0yNbCQjlWoXP85QGP6lTgiXqboJsDJreP9z//Vlmff410=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1011.nifty.com with ESMTP
          id <20240213143325085.DGZU.3070.localhost.localdomain@nifty.com>;
          Tue, 13 Feb 2024 23:33:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix a problem that minor ID is incorrect in ConEmu.
Date: Tue, 13 Feb 2024 23:32:59 +0900
Message-ID: <20240213143310.1921-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, minor device number of console was not assigned correctly
in ConEmu environment. This is because console window of ConEmu is
not enumerated by EnumWindows(). This patch fixes the issue.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/autoload.cc         |  2 ++
 winsup/cygwin/devices.cc          |  7 +++++++
 winsup/cygwin/devices.in          |  7 +++++++
 winsup/cygwin/fhandler/console.cc | 14 ++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index 7e610bdd0..65e906e8b 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -548,7 +548,9 @@ LoadDLLfunc (DefWindowProcW, user32)
 LoadDLLfunc (DestroyWindow, user32)
 LoadDLLfunc (DispatchMessageW, user32)
 LoadDLLfunc (EmptyClipboard, user32)
+LoadDLLfunc (EnumChildWindows, user32)
 LoadDLLfunc (EnumWindows, user32)
+LoadDLLfunc (GetClassNameA, user32)
 LoadDLLfunc (GetClipboardData, user32)
 LoadDLLfunc (GetDC, user32)
 LoadDLLfunc (GetForegroundWindow, user32)
diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index 167b0e4b4..ca1fdf3be 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -81,6 +81,13 @@ enum_cons_dev (HWND hw, LPARAM lp)
       UnmapViewOfFile ((void *) cs);
       CloseHandle (h);
     }
+  else
+    { /* Only for ConEmu */
+      char class_hw[32];
+      if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
+	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
+	EnumChildWindows (hw, enum_cons_dev, lp);
+    }
   return TRUE;
 }
 
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index 48d3843fe..842f09c18 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -77,6 +77,13 @@ enum_cons_dev (HWND hw, LPARAM lp)
       UnmapViewOfFile ((void *) cs);
       CloseHandle (h);
     }
+  else
+    { /* Only for ConEmu */
+      char class_hw[32];
+      if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
+	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
+	EnumChildWindows (hw, enum_cons_dev, lp);
+    }
   return TRUE;
 }
 
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index b0907eb31..70824e694 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -250,6 +250,13 @@ enum_windows (HWND hw, LPARAM lp)
       UnmapViewOfFile ((void *) cs);
       CloseHandle (h);
     }
+  else
+    { /* Only for ConEmu */
+      char class_hw[32];
+      if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
+	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
+	EnumChildWindows (hw, enum_windows, lp);
+    }
   return TRUE;
 }
 
@@ -656,6 +663,13 @@ scan_console (HWND hw, LPARAM lp)
       UnmapViewOfFile ((void *) cs);
       CloseHandle (h);
     }
+  else
+    { /* Only for ConEmu */
+      char class_hw[32];
+      if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
+	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
+	EnumChildWindows (hw, scan_console, lp);
+    }
   return TRUE;
 }
 
-- 
2.43.0

