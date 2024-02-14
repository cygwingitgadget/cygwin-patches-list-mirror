Return-Path: <SRS0=pSQy=JX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1006.nifty.com (mta-snd01003.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 242BC385C422
	for <cygwin-patches@cygwin.com>; Wed, 14 Feb 2024 14:27:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 242BC385C422
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 242BC385C422
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1707920833; cv=none;
	b=gt86nmWioE7WNmNnw5orgu8nAGwkpTXPTyzEWZ2USkIDWdvuuUohnsDYQnotgzgFSvbVu5QGSO+nPiYxfiH8lz6Dua9qdiGPLhTsvm3kPZ9dEnIcLI2WjrxR7P5ldRTZA9GM+2s1oQh6BvZ0AAFpsXdNWze3ipoDLc8TlckpynI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1707920833; c=relaxed/simple;
	bh=Z3YNwhUa0frZygGEodwqBhFMn0LO/ama68oZwj3WSvs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YcNdjdtn7FfHbgmT8aNJxmu9prsozaXop3NPPgeGcA40IAQRVUKNgx4uM3dG96Gx6iFphDTFo4WWwD4MnPFReq0mxOaTGwv7R+dxqxod6iuQTmxjI9ouDMba2toeyGxa6K6MzIo1ytjkZQyZkijEfcsA16GIyAMkjsXmf+HOmSo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1006.nifty.com with ESMTP
          id <20240214142709173.FUIZ.58378.localhost.localdomain@nifty.com>;
          Wed, 14 Feb 2024 23:27:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: console: Unify EnumWindows() callback functions.
Date: Wed, 14 Feb 2024 23:26:40 +0900
Message-ID: <20240214142651.1721-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, three similar callback fuctions were used in console
code. This patch unifies these functions to ease maintenance cost.

Fixes: 8aad3a7edeb2 ("Cygwin: console: Fix a problem that minor ID is incorrect in ConEmu.")
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/devices.cc                | 25 +-------
 winsup/cygwin/devices.in                | 25 +-------
 winsup/cygwin/fhandler/console.cc       | 84 +++++++------------------
 winsup/cygwin/local_includes/fhandler.h | 15 +++++
 4 files changed, 39 insertions(+), 110 deletions(-)

diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index ca1fdf3be..b14613bc7 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -69,28 +69,6 @@ exists_ntdev_silent (const device& dev)
   return exists_ntdev (dev) ? -1 : false;
 }
 
-static BOOL CALLBACK
-enum_cons_dev (HWND hw, LPARAM lp)
-{
-  unsigned long *bitmask = (unsigned long *) lp;
-  HANDLE h = NULL;
-  fhandler_console::console_state *cs;
-  if ((cs = fhandler_console::open_shared_console (hw, h)))
-    {
-      *bitmask |= (1UL << cs->tty_min_state.getntty ());
-      UnmapViewOfFile ((void *) cs);
-      CloseHandle (h);
-    }
-  else
-    { /* Only for ConEmu */
-      char class_hw[32];
-      if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
-	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
-	EnumChildWindows (hw, enum_cons_dev, lp);
-    }
-  return TRUE;
-}
-
 static int
 exists_console (const device& dev)
 {
@@ -105,8 +83,7 @@ exists_console (const device& dev)
     default:
       if (dev.get_minor () < MAX_CONS_DEV)
 	{
-	  unsigned long bitmask = 0;
-	  EnumWindows (enum_cons_dev, (LPARAM) &bitmask);
+	  unsigned long bitmask = fhandler_console::console_unit (-1);
 	  return bitmask & (1UL << dev.get_minor ());
 	}
       return false;
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index 842f09c18..e15a35f25 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -65,28 +65,6 @@ exists_ntdev_silent (const device& dev)
   return exists_ntdev (dev) ? -1 : false;
 }
 
-static BOOL CALLBACK
-enum_cons_dev (HWND hw, LPARAM lp)
-{
-  unsigned long *bitmask = (unsigned long *) lp;
-  HANDLE h = NULL;
-  fhandler_console::console_state *cs;
-  if ((cs = fhandler_console::open_shared_console (hw, h)))
-    {
-      *bitmask |= (1UL << cs->tty_min_state.getntty ());
-      UnmapViewOfFile ((void *) cs);
-      CloseHandle (h);
-    }
-  else
-    { /* Only for ConEmu */
-      char class_hw[32];
-      if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
-	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
-	EnumChildWindows (hw, enum_cons_dev, lp);
-    }
-  return TRUE;
-}
-
 static int
 exists_console (const device& dev)
 {
@@ -101,8 +79,7 @@ exists_console (const device& dev)
     default:
       if (dev.get_minor () < MAX_CONS_DEV)
 	{
-	  unsigned long bitmask = 0;
-	  EnumWindows (enum_cons_dev, (LPARAM) &bitmask);
+	  unsigned long bitmask = fhandler_console::console_unit (-1);
 	  return bitmask & (1UL << dev.get_minor ());
 	}
       return false;
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 70824e694..66b4905f4 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -224,49 +224,46 @@ fhandler_console::open_shared_console (HWND hw, HANDLE& h, bool& created)
   return res;
 }
 
-class console_unit
-{
-  int n;
-  unsigned long bitmask;
-  HWND me;
-
-public:
-  operator int () const {return n;}
-  console_unit (HWND);
-  friend BOOL CALLBACK enum_windows (HWND, LPARAM);
-};
-
 BOOL CALLBACK
-enum_windows (HWND hw, LPARAM lp)
+fhandler_console::enum_windows (HWND hw, LPARAM lp)
 {
   console_unit *this1 = (console_unit *) lp;
-  if (hw == this1->me)
-    return TRUE;
   HANDLE h = NULL;
   fhandler_console::console_state *cs;
   if ((cs = fhandler_console::open_shared_console (hw, h)))
     {
-      this1->bitmask ^= 1UL << cs->tty_min_state.getntty ();
-      UnmapViewOfFile ((void *) cs);
       CloseHandle (h);
+      if (major (cs->tty_min_state.getntty ()) == DEV_CONS_MAJOR)
+	this1->bitmask |= 1UL << minor (cs->tty_min_state.getntty ());
+      if (this1->n == minor (cs->tty_min_state.getntty ()))
+	{
+	  this1->shared_console_info = cs;
+	  return FALSE;
+	}
+      UnmapViewOfFile ((void *) cs);
     }
   else
     { /* Only for ConEmu */
       char class_hw[32];
       if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
 	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
-	EnumChildWindows (hw, enum_windows, lp);
+	EnumChildWindows (hw, fhandler_console::enum_windows, lp);
     }
   return TRUE;
 }
 
-console_unit::console_unit (HWND me0):
-  bitmask (~0UL), me (me0)
+fhandler_console::console_unit::console_unit (int n0):
+  n (n0), bitmask (0)
 {
-  EnumWindows (enum_windows, (LPARAM) this);
-  n = (_minor_t) ffs (bitmask) - 1;
+  EnumWindows (fhandler_console::enum_windows, (LPARAM) this);
+  if (n < 0)
+    n = (_minor_t) ffsl (~bitmask) - 1;
   if (n < 0)
-    api_fatal ("console device allocation failure - too many consoles in use, max consoles is 64");
+    api_fatal (sizeof (bitmask) == 8 ?
+	       "console device allocation failure - "
+	       "too many consoles in use, max consoles is 64" :
+	       "console device allocation failure - "
+	       "too many consoles in use, max consoles is 32");
 }
 
 static DWORD
@@ -640,39 +637,6 @@ skip_writeback:
   free (input_tmp);
 }
 
-struct scan_console_args_t
-{
-  _minor_t unit;
-  fhandler_console::console_state **shared_console_info;
-};
-
-BOOL CALLBACK
-scan_console (HWND hw, LPARAM lp)
-{
-  scan_console_args_t *p = (scan_console_args_t *) lp;
-  HANDLE h = NULL;
-  fhandler_console::console_state *cs;
-  if ((cs = fhandler_console::open_shared_console (hw, h)))
-    {
-     if (p->unit == minor (cs->tty_min_state.getntty ()))
-       {
-	 *p->shared_console_info = cs;
-	 CloseHandle (h);
-	 return FALSE;
-       }
-      UnmapViewOfFile ((void *) cs);
-      CloseHandle (h);
-    }
-  else
-    { /* Only for ConEmu */
-      char class_hw[32];
-      if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
-	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
-	EnumChildWindows (hw, scan_console, lp);
-    }
-  return TRUE;
-}
-
 bool
 fhandler_console::set_unit ()
 {
@@ -696,11 +660,7 @@ fhandler_console::set_unit ()
   else
     {
       if (!generic_console && (dev_t) myself->ctty != get_device ())
-	{
-	  /* Scan for existing shared console info */
-	  scan_console_args_t arg = { unit,  &shared_console_info[unit] };
-	  EnumWindows (scan_console, (LPARAM) &arg);
-	}
+	shared_console_info[unit] = console_unit (unit);
       if (generic_console || !shared_console_info[unit])
 	{
 	  me = GetConsoleWindow ();
@@ -714,7 +674,7 @@ fhandler_console::set_unit ()
 	      ProtectHandleINH (cygheap->console_h);
 	      if (created)
 		{
-		  unit = console_unit (me);
+		  unit = console_unit (-1);
 		  cs->tty_min_state.setntty (DEV_CONS_MAJOR, unit);
 		}
 	      else
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 8e3088447..a2017f618 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2259,6 +2259,8 @@ private:
   static void set_output_mode (tty::cons_mode m, const termios *t,
 			       const handle_set_t *p);
 
+  static BOOL CALLBACK enum_windows (HWND hw, LPARAM lp);
+
  public:
   pid_t tc_getpgid ()
   {
@@ -2380,6 +2382,19 @@ private:
   void wpbuf_send ();
   int fstat (struct stat *buf);
 
+  class console_unit
+  {
+    int n;
+    unsigned long bitmask;
+    console_state *shared_console_info;
+  public:
+    operator _minor_t () const {return n;}
+    operator console_state * () const {return shared_console_info;}
+    operator unsigned long () const {return bitmask;}
+    console_unit (int);
+    friend BOOL CALLBACK fhandler_console::enum_windows (HWND, LPARAM);
+  };
+
   friend tty_min * tty_list::get_cttyp ();
 };
 
-- 
2.43.0

