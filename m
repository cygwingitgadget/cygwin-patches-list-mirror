Return-Path: <SRS0=C8bn=OI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 985DF386480F
	for <cygwin-patches@cygwin.com>; Mon,  8 Jul 2024 14:30:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 985DF386480F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 985DF386480F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1720449032; cv=none;
	b=FCaKBjvuXD29PXDw9l6AbePwcqNFZ1QfX+fUG6BPo20NZoAQixtYyKy1kA9A4UnoKTg9cHPvI6W1q8eG0G5HdUIPYchLtrb1/ZUqDseDEM2aPPJVwIx/CqS9KS/3nAnEvDrVxW4weqKgZdw6uSTj/jgsmcG8tq+fMuJTY3xg3ak=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1720449032; c=relaxed/simple;
	bh=p7PqdtrGXjaX3E3QUMVnNecOGeSk3utp2CTssTuEZIg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=q9hl+FZ3ZKIMFdLJmy0MToaUgS1vCmHNrjtTBQDcDBoCDWteYGI6RJE1g+Ue5g3JDetUm2LlQw6eOLizmMGYArkpApNVtBps8kZuXPaIuKj3RxJHvjoLA+G7LSd8m6UYj7r7mpwfdRNpUe4HedIPABCo4oNrJbLsSU5pvv0QQco=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20240708143026207.TCPV.41146.localhost.localdomain@nifty.com>;
          Mon, 8 Jul 2024 23:30:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix race issue on allocating console simultaneously.
Date: Mon,  8 Jul 2024 23:29:57 +0900
Message-ID: <20240708143011.1910-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1720449026;
 bh=aTfFt1GznRYSdQDgnaMzL7Dg1QoGQwRRDDRz8pSppiY=;
 h=From:To:Cc:Subject:Date;
 b=U94gdm7mJvWzkN98L7sM7N+YQUyloKq3gtEzJnzyN88iJ+G0q4H2bONaBJHZCVowyxpE/DBR
 WIuM0+moczRhYlg8YTOSyZX1fzQ5iedDH//EYD11FEEYBiTW9eOc3LzEEdFWH76xvigYX0NENQ
 M+ToucgGMDg9XsNWXzEZ1wHFhwO1Ubdcbw9XgnbUb2LKv/41pFnCFT5R5l6kpJI8zesLRGNBef
 +9z4DGdmUrHlsVEb5EqFDf++Z7InDg2nwT54GhxTMNuK83vj4mgqkC2lJYCGYCXPniN94fDHYs
 MMnzTrRFz/RuOCY0O+TXD6Q4S/0KERfpWjQhPZU6vbSfsB5A==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, if two or more processes request to allocate console at
the same time, the same device number could be accidentally allocated.
This patch fixes the issue.

This also makes minor device number unique and console devices being
visible even across sessions. This disallows duplicated device number
for different sessions, so the MAX_CONS_DEV has been increased from
64 to 128.

Additionally, the console allocation and scanning will be faster.

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from other terminals.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/devices.cc                   |  4 +-
 winsup/cygwin/devices.in                   |  4 +-
 winsup/cygwin/fhandler/console.cc          | 84 +++++++++++-----------
 winsup/cygwin/local_includes/fhandler.h    | 13 +---
 winsup/cygwin/local_includes/shared_info.h |  3 +-
 winsup/cygwin/local_includes/tty.h         |  5 ++
 6 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index d4c003bac..6eb6a41d1 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -83,8 +83,8 @@ exists_console (const device& dev)
     default:
       if (dev.get_minor () < MAX_CONS_DEV)
 	{
-	  unsigned long bitmask = fhandler_console::console_unit (CONS_LIST_USED);
-	  return !!(bitmask & (1UL << dev.get_minor ()));
+	  int n = fhandler_console::console_unit (dev.get_minor ());
+	  return (n == dev.get_minor ());
 	}
       return false;
     }
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index a86e5015f..ea9a70e1b 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -79,8 +79,8 @@ exists_console (const device& dev)
     default:
       if (dev.get_minor () < MAX_CONS_DEV)
 	{
-	  unsigned long bitmask = fhandler_console::console_unit (CONS_LIST_USED);
-	  return !!(bitmask & (1UL << dev.get_minor ()));
+	  int n = fhandler_console::console_unit (dev.get_minor ());
+	  return (n == dev.get_minor ());
 	}
       return false;
     }
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 6028559b2..8c08a8af8 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -69,13 +69,6 @@ static struct fhandler_base::rabuf_t con_ra;
    in xterm compatible mode */
 static wchar_t last_char;
 
-static char *
-cons_shared_name (char *ret_buf, const char *str, HWND hw)
-{
-  __small_sprintf (ret_buf, "%s.%p", str, hw);
-  return ret_buf;
-}
-
 DWORD
 fhandler_console::attach_console (pid_t owner, bool *err)
 {
@@ -234,44 +227,52 @@ fhandler_console::open_shared_console (HWND hw, HANDLE& h, bool& created)
   return res;
 }
 
-BOOL CALLBACK
-fhandler_console::enum_windows (HWND hw, LPARAM lp)
+fhandler_console::console_unit::console_unit (int n0, HANDLE *input_mutex) :
+  n (-1)
 {
-  console_unit *this1 = (console_unit *) lp;
-  HANDLE h = NULL;
-  fhandler_console::console_state *cs;
-  if ((cs = fhandler_console::open_shared_console (hw, h)))
+  char buf[MAX_PATH];
+  for (int i = max(0, n0); i < MAX_CONS_DEV; i++)
     {
-      CloseHandle (h);
-      if (major (cs->tty_min_state.getntty ()) == DEV_CONS_MAJOR)
-	this1->bitmask |= 1UL << minor (cs->tty_min_state.getntty ());
-      if (this1->n == minor (cs->tty_min_state.getntty ()))
+      shared_name (buf, "cygcons.input.mutex", i);
+      SetLastError (ERROR_SUCCESS);
+      HANDLE input_mutex0 = CreateMutex (&sec_none, FALSE, buf);
+      DWORD err = GetLastError ();
+      if (err == ERROR_ALREADY_EXISTS || err == ERROR_ACCESS_DENIED)
 	{
-	  this1->shared_console_info = cs;
-	  return FALSE;
+	  if (n0 >= 0)
+	    n = i;
 	}
-      UnmapViewOfFile ((void *) cs);
+      else if (n0 == CONS_SCAN_UNUSED)
+	{
+	  n = i;
+	  if (input_mutex)
+	    *input_mutex = input_mutex0;
+	  break;
+	}
+      if (input_mutex0)
+	CloseHandle (input_mutex0);
+      if (n0 >= 0)
+	break;
     }
-  else
-    { /* Only for ConEmu */
-      char class_hw[32];
-      if (19 == GetClassName (hw, class_hw, sizeof (class_hw))
-	  && 0 == strcmp (class_hw, "VirtualConsoleClass"))
-	EnumChildWindows (hw, fhandler_console::enum_windows, lp);
+  if (n0 == CONS_SCAN_UNUSED && n < 0)
+    {
+      __small_sprintf (buf, "console device allocation failure - "
+		       "too many consoles in use, max consoles is %d",
+		       MAX_CONS_DEV);
+      api_fatal (buf);
     }
-  return TRUE;
 }
 
-fhandler_console::console_unit::console_unit (int n0):
-  n (n0), bitmask (0), shared_console_info (NULL)
+fhandler_console::console_unit::operator console_state * () const
 {
-  EnumWindows (fhandler_console::enum_windows, (LPARAM) this);
-  if (n0 == CONS_SCAN_UNUSED && (n = ffsl (~bitmask) - 1) < 0)
-    api_fatal (sizeof (bitmask) == 8 ?
-	       "console device allocation failure - "
-	       "too many consoles in use, max consoles is 64" :
-	       "console device allocation failure - "
-	       "too many consoles in use, max consoles is 32");
+  if (n < 0 || n >= MAX_CONS_DEV)
+    return NULL;
+  HANDLE h = NULL;
+  fhandler_console::console_state *cs;
+  HWND hw = cygwin_shared->cons_hwnd[n];
+  if ((cs = fhandler_console::open_shared_console (hw, h)))
+    CloseHandle (h);
+  return cs;
 }
 
 static DWORD
@@ -699,7 +700,8 @@ fhandler_console::set_unit ()
 	      ProtectHandleINH (cygheap->console_h);
 	      if (created)
 		{
-		  unit = console_unit (CONS_SCAN_UNUSED);
+		  unit = console_unit (CONS_SCAN_UNUSED, &input_mutex);
+		  cygwin_shared->cons_hwnd[unit] = me;
 		  cs->tty_min_state.setntty (DEV_CONS_MAJOR, unit);
 		}
 	      else
@@ -943,7 +945,7 @@ fhandler_console::setup_io_mutex (void)
   res = WAIT_FAILED;
   if (!input_mutex || WAIT_FAILED == (res = acquire_input_mutex (0)))
     {
-      cons_shared_name (buf, "cygcons.input.mutex", GetConsoleWindow ());
+      shared_name (buf, "cygcons.input.mutex", get_minor ());
       input_mutex = OpenMutex (MAXIMUM_ALLOWED, TRUE, buf);
       if (!input_mutex)
 	input_mutex = CreateMutex (&sec_none, FALSE, buf);
@@ -959,7 +961,7 @@ fhandler_console::setup_io_mutex (void)
   res = WAIT_FAILED;
   if (!output_mutex || WAIT_FAILED == (res = acquire_output_mutex (0)))
     {
-      cons_shared_name (buf, "cygcons.output.mutex", GetConsoleWindow ());
+      shared_name (buf, "cygcons.output.mutex", get_minor ());
       output_mutex = OpenMutex (MAXIMUM_ALLOWED, TRUE, buf);
       if (!output_mutex)
 	output_mutex = CreateMutex (&sec_none, FALSE, buf);
@@ -1874,7 +1876,7 @@ fhandler_console::open (int flags, mode_t)
       if (GetModuleHandle ("ConEmuHk64.dll"))
 	hook_conemu_cygwin_connector ();
       char name[MAX_PATH];
-      cons_shared_name (name, CONS_THREAD_SYNC, GetConsoleWindow ());
+      shared_name (name, CONS_THREAD_SYNC, get_minor ());
       thread_sync_event = CreateEvent(NULL, FALSE, FALSE, name);
       if (thread_sync_event)
 	{
@@ -1943,7 +1945,7 @@ fhandler_console::close ()
       if (master_thread_started)
 	{
 	  char name[MAX_PATH];
-	  cons_shared_name (name, CONS_THREAD_SYNC, GetConsoleWindow ());
+	  shared_name (name, CONS_THREAD_SYNC, get_minor ());
 	  thread_sync_event = OpenEvent (MAXIMUM_ALLOWED, FALSE, name);
 	  if (thread_sync_event)
 	    {
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index fa6159565..8b02a2b1b 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2191,10 +2191,6 @@ class dev_console
   friend class fhandler_console;
 };
 
-#define MAX_CONS_DEV (sizeof (unsigned long) * 8)
-#define CONS_SCAN_UNUSED (-1)
-#define CONS_LIST_USED (-2)
-
 /* This is a input and output console handle */
 class fhandler_console: public fhandler_termios
 {
@@ -2387,13 +2383,10 @@ private:
   class console_unit
   {
     int n;
-    unsigned long bitmask;
-    console_state *shared_console_info;
   public:
-    operator console_state * () const {return shared_console_info;}
-    operator unsigned long () const {return n == CONS_LIST_USED ? bitmask : n;}
-    console_unit (int);
-    friend BOOL CALLBACK fhandler_console::enum_windows (HWND, LPARAM);
+    operator console_state * () const;
+    operator int () const { return n; }
+    console_unit (int, HANDLE *input_mutex = NULL);
   };
 
   friend tty_min * tty_list::get_cttyp ();
diff --git a/winsup/cygwin/local_includes/shared_info.h b/winsup/cygwin/local_includes/shared_info.h
index cbe55a278..4316717a9 100644
--- a/winsup/cygwin/local_includes/shared_info.h
+++ b/winsup/cygwin/local_includes/shared_info.h
@@ -33,7 +33,7 @@ public:
 /* Data accessible to all tasks */
 
 
-#define CURR_SHARED_MAGIC 0x9f33cc5dU
+#define CURR_SHARED_MAGIC 0x205f4579U
 
 #define USER_VERSION   1
 
@@ -46,6 +46,7 @@ class shared_info
   DWORD cb;
  public:
   tty_list tty;
+  HWND cons_hwnd[MAX_CONS_DEV];
   LONG last_used_bindresvport;
   DWORD obcaseinsensitive;
   mtinfo mt;
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index df3bf60bf..53fa26b44 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -211,4 +211,9 @@ public:
 };
 
 extern "C" int ttyslot (void);
+
+/* Console stuff */
+#define MAX_CONS_DEV 128
+#define CONS_SCAN_UNUSED (-1)
+
 #endif /*_TTY_H*/
-- 
2.45.1

