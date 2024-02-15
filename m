Return-Path: <SRS0=lcoE=JY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0009.nifty.com (mta-snd00013.nifty.com [106.153.226.45])
	by sourceware.org (Postfix) with ESMTPS id DCE86384B046
	for <cygwin-patches@cygwin.com>; Thu, 15 Feb 2024 19:07:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DCE86384B046
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DCE86384B046
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.45
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708024049; cv=none;
	b=PY6IGD25pXK/mM1q4xYkmZiBuEeSvglPR1W7Mz2BjQTFqHMerMus6+BFtIvFI7GrbOQa2rs7eoTeq3uFgDFHVwCT3u5Dnb6fWJVxlMGLn5RoaaYtXANkmTdmXd3k/TlH4h0TQ4a4kemFmKQIiqj7bne6oUhffKme0A6yau3tyNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708024049; c=relaxed/simple;
	bh=e45XTqaM4e+Qc4OThMnUG0bO/tpBWapnjFYAgU89ATw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mUN3eZyuFClH6arA4XeGxTBEVrWDnSBfAaNeqOsMcyUdC1YF/qNectmlQDYXBt2umB79w+NclZbo+OPimfdZLHWDuApHxRV9LsoNm8Zga2IyKxrXKXHAvoA22U3zpQopJ6YAtHj4v+W2RdWuvlcdpFs8sJe0pWvz5XdWLT/qvK4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0009.nifty.com with ESMTP
          id <20240215190722759.FPFT.90193.localhost.localdomain@nifty.com>;
          Fri, 16 Feb 2024 04:07:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix a bug that 64th console cannot be handled.
Date: Fri, 16 Feb 2024 04:06:55 +0900
Message-ID: <20240215190708.2609-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 930e553da8e9 ("Cygwin: console: Unify EnumWindows() callback functions.");
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/devices.cc                | 2 +-
 winsup/cygwin/devices.in                | 2 +-
 winsup/cygwin/fhandler/console.cc       | 8 +++-----
 winsup/cygwin/local_includes/fhandler.h | 5 +++--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index 5b67fd1da..d4c003bac 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -83,7 +83,7 @@ exists_console (const device& dev)
     default:
       if (dev.get_minor () < MAX_CONS_DEV)
 	{
-	  unsigned long bitmask = fhandler_console::console_unit (-1);
+	  unsigned long bitmask = fhandler_console::console_unit (CONS_LIST_USED);
 	  return !!(bitmask & (1UL << dev.get_minor ()));
 	}
       return false;
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index be54346fb..a86e5015f 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -79,7 +79,7 @@ exists_console (const device& dev)
     default:
       if (dev.get_minor () < MAX_CONS_DEV)
 	{
-	  unsigned long bitmask = fhandler_console::console_unit (-1);
+	  unsigned long bitmask = fhandler_console::console_unit (CONS_LIST_USED);
 	  return !!(bitmask & (1UL << dev.get_minor ()));
 	}
       return false;
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 66b4905f4..c16ca3962 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -253,12 +253,10 @@ fhandler_console::enum_windows (HWND hw, LPARAM lp)
 }
 
 fhandler_console::console_unit::console_unit (int n0):
-  n (n0), bitmask (0)
+  n (n0), bitmask (0), shared_console_info (NULL)
 {
   EnumWindows (fhandler_console::enum_windows, (LPARAM) this);
-  if (n < 0)
-    n = (_minor_t) ffsl (~bitmask) - 1;
-  if (n < 0)
+  if (n0 == CONS_SCAN_UNUSED && (n = ffsl (~bitmask) - 1) < 0)
     api_fatal (sizeof (bitmask) == 8 ?
 	       "console device allocation failure - "
 	       "too many consoles in use, max consoles is 64" :
@@ -674,7 +672,7 @@ fhandler_console::set_unit ()
 	      ProtectHandleINH (cygheap->console_h);
 	      if (created)
 		{
-		  unit = console_unit (-1);
+		  unit = console_unit (CONS_SCAN_UNUSED);
 		  cs->tty_min_state.setntty (DEV_CONS_MAJOR, unit);
 		}
 	      else
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index a2017f618..6ddf37370 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2192,6 +2192,8 @@ class dev_console
 };
 
 #define MAX_CONS_DEV (sizeof (unsigned long) * 8)
+#define CONS_SCAN_UNUSED (-1)
+#define CONS_LIST_USED (-2)
 
 /* This is a input and output console handle */
 class fhandler_console: public fhandler_termios
@@ -2388,9 +2390,8 @@ private:
     unsigned long bitmask;
     console_state *shared_console_info;
   public:
-    operator _minor_t () const {return n;}
     operator console_state * () const {return shared_console_info;}
-    operator unsigned long () const {return bitmask;}
+    operator unsigned long () const {return n == CONS_LIST_USED ? bitmask : n;}
     console_unit (int);
     friend BOOL CALLBACK fhandler_console::enum_windows (HWND, LPARAM);
   };
-- 
2.43.0

