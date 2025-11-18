Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E8FB7385770B; Tue, 18 Nov 2025 12:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E8FB7385770B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763469637;
	bh=xNDgHHTtaoOGCWb6Onk2LJkvBIvWGs/FoziHoKNns6c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=a/kKvaleyX7jFVfcdVcRN2gSWwmClyg5xYlbaRTror4Z/7qlJgQTddQCNdDpkkNMx
	 DYr9ph2WxojaY5VwEcIHh+Ynp009EhdcaAmuCAbKEb8AUBmVtw8YJ84ecEHUvAKaNu
	 BFIXWoRDTvJk70jgkmgOIcIDpqtrQmcpu4QwOQyw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B2C8AA80DC2; Tue, 18 Nov 2025 13:40:34 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: console: (re-)introduce simple creation of invisible console
Date: Tue, 18 Nov 2025 13:40:34 +0100
Message-ID: <20251118124034.1097179-3-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118124034.1097179-1-corinna-cygwin@cygwin.com>
References: <20251118124034.1097179-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Reintroduce the once existing fhandler_console::create_invisible_console()
method originally used until Windows Vista.  Now call AllocConsoleWithOptions()
from here, creating an invisible console on systems supporting it.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/autoload.cc               |  1 +
 winsup/cygwin/fhandler/console.cc       | 21 ++++++++++++++++++---
 winsup/cygwin/local_includes/fhandler.h |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index d5d344d21dd4..a038997b3999 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -463,6 +463,7 @@ LoadDLLfunc (GetTcpTable, iphlpapi)
 LoadDLLfunc (GetTcp6Table, iphlpapi)
 LoadDLLfunc (GetUdpTable, iphlpapi)
 
+LoadDLLfunc (AllocConsoleWithOptions, kernel32)
 LoadDLLfuncEx2 (DiscardVirtualMemory, kernel32, 1, 127)
 LoadDLLfuncEx (ClosePseudoConsole, kernel32, 1)
 LoadDLLfuncEx (CreatePseudoConsole, kernel32, 1)
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 887e2ef722bf..9fd3ff5060be 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -4466,7 +4466,20 @@ hook_conemu_cygwin_connector()
   DO_HOOK (NULL, GetProcAddress);
 }
 
-/* Ugly workaround to create invisible console required since Windows 7.
+bool
+fhandler_console::create_invisible_console ()
+{
+  ALLOC_CONSOLE_OPTIONS options = { ALLOC_CONSOLE_MODE_NO_WINDOW, FALSE, 0 };
+  ALLOC_CONSOLE_RESULT res;
+
+  HRESULT ret = AllocConsoleWithOptions (&options, &res);
+  SetParent (GetConsoleWindow (), HWND_MESSAGE);
+  termios_printf ("%X = AllocConsoleWithOptions (), %u", ret, res);
+  invisible_console = (ret == S_OK);
+  return invisible_console;
+}
+
+/* Ugly workaround to create invisible console required prior to W11 24H2.
 
    First try to just attach to any console which may have started this
    app.  If that works use this as our "invisible console".
@@ -4611,12 +4624,14 @@ fhandler_console::need_invisible (bool force)
 	  || !GetUserObjectInformationW (h, UOI_FLAGS, &oi, sizeof (oi), &len)
 	  || !(oi.dwFlags & WSF_VISIBLE))
 	{
-	  b = true;
 	  debug_printf ("window station is not visible");
 	  AllocConsole ();
 	  invisible_console = true;
 	}
-      b = create_invisible_console_workaround (force);
+      if (wincap.has_alloc_console_with_options ())
+	b = create_invisible_console ();
+      else
+	b = create_invisible_console_workaround (force);
     }
 
   debug_printf ("invisible_console %d", invisible_console);
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index bdd87ebb7787..0de82163ef74 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2227,6 +2227,7 @@ private:
 /* Input calls */
   int igncr_enabled ();
   void set_cursor_maybe ();
+  static bool create_invisible_console ();
   static bool create_invisible_console_workaround (bool force);
   static console_state *open_shared_console (HWND, HANDLE&, bool&);
   static void fix_tab_position (HANDLE h, DWORD owner);
-- 
2.51.1

