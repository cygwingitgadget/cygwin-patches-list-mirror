Return-Path: <cygwin-patches-return-9570-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89696 invoked by alias); 15 Aug 2019 06:00:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89345 invoked by uid 89); 15 Aug 2019 06:00:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=H*Ad:U*mark, wcsncat, wcscmp, HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 06:00:02 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x7F5xxX7016051;	Wed, 14 Aug 2019 22:59:59 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdd5P5jh; Wed Aug 14 22:59:54 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: ldd: Try harder to get dll names
Date: Thu, 15 Aug 2019 06:00:00 -0000
Message-Id: <20190815055943.31661-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00090.txt.bz2

Borrow a trick from strace to lessen occurrences of "??? => ???" in ldd
output.  Specifically, if the module name isn't found in the usual place
in the mapped image, use the file handle we have to look up the name.

---
 winsup/utils/Makefile.in |  2 +-
 winsup/utils/ldd.cc      | 44 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index cebf39572..5bb62bc6f 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -101,7 +101,7 @@ cygpath.exe: CYGWIN_LDFLAGS += -lcygwin -luserenv -lntdll
 ps.exe: CYGWIN_LDFLAGS += -lcygwin -lpsapi -lntdll
 strace.exe: MINGW_LDFLAGS += -lntdll
 
-ldd.exe:CYGWIN_LDFLAGS += -lpsapi
+ldd.exe:CYGWIN_LDFLAGS += -lpsapi -lntdll
 pldd.exe: CYGWIN_LDFLAGS += -lpsapi
 minidumper.exe: CYGWIN_LDFLAGS += -ldbghelp
 
diff --git a/winsup/utils/ldd.cc b/winsup/utils/ldd.cc
index bbc62f12f..9bcc1df7f 100644
--- a/winsup/utils/ldd.cc
+++ b/winsup/utils/ldd.cc
@@ -39,6 +39,7 @@
 
 #define _WIN32_WINNT 0x0a00
 #include <windows.h>
+#include <winternl.h>
 #include <imagehlp.h>
 #include <psapi.h>
 
@@ -55,6 +56,7 @@ struct option longopts[] =
 const char *opts = "dhruvV";
 
 static int process_file (const wchar_t *);
+static void *drive_map;
 
 static int
 error (const char *fmt, ...)
@@ -152,6 +154,32 @@ get_module_filename (HANDLE hp, HMODULE hm)
   return buf;
 }
 
+static BOOL
+GetFileNameFromHandle(HANDLE hFile, WCHAR pszFilename[MAX_PATH+1])
+{
+  BOOL result = FALSE;
+  ULONG len = 0;
+  OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) alloca (65536);
+  NTSTATUS status = NtQueryObject (hFile, ObjectNameInformation,
+                                   ntfn, 65536, &len);
+  if (NT_SUCCESS (status))
+    {
+      PWCHAR win32path = ntfn->Name.Buffer;
+      win32path[ntfn->Name.Length / sizeof (WCHAR)] = L'\0';
+
+      /* NtQueryObject returns a native NT path.  (Try to) convert to Win32. */
+      if (!drive_map)
+	 drive_map = (void *) cygwin_internal (CW_ALLOC_DRIVE_MAP);
+      if (drive_map)
+        win32path = (PWCHAR) cygwin_internal (CW_MAP_DRIVE_MAP, drive_map,
+                                              win32path);
+      pszFilename[0] = L'\0';
+      wcsncat (pszFilename, win32path, MAX_PATH);
+      result = TRUE;
+    }
+  return result;
+}
+
 static wchar_t *
 load_dll (const wchar_t *fn)
 {
@@ -215,6 +243,7 @@ start_process (const wchar_t *fn, bool& isdll)
 struct dlls
   {
     LPVOID lpBaseOfDll;
+    HANDLE hFile;
     struct dlls *next;
   };
 
@@ -256,7 +285,17 @@ print_dlls (dlls *dll, const wchar_t *dllfn, const wchar_t *process_fn)
       char *fn;
       wchar_t *fullpath = get_module_filename (hProcess, (HMODULE) dll->lpBaseOfDll);
       if (!fullpath)
-	fn = strdup ("???");
+	{
+	  // if no path found yet, try getting it from an open handle to the DLL
+	  wchar_t dllname[MAX_PATH+1];
+	  if (GetFileNameFromHandle (dll->hFile, dllname))
+	    {
+	      fn = tocyg (dllname);
+	      saw_file (basename (fn));
+	    }
+	  else
+	    fn = strdup ("???");
+	}
       else if (dllfn && wcscmp (fullpath, dllfn) == 0)
 	{
 	  free (fullpath);
@@ -340,6 +379,7 @@ report (const char *in_fn, bool multiple)
 	case LOAD_DLL_DEBUG_EVENT:
 	  dll_last->next = (dlls *) malloc (sizeof (dlls));
 	  dll_last->next->lpBaseOfDll = ev.u.LoadDll.lpBaseOfDll;
+	  dll_last->next->hFile = ev.u.LoadDll.hFile;
 	  dll_last->next->next = NULL;
 	  dll_last = dll_last->next;
 	  break;
@@ -423,6 +463,8 @@ main (int argc, char **argv)
   while ((fn = *argv++))
     if (report (fn, multiple))
       ret = 1;
+  if (drive_map)
+    cygwin_internal (CW_FREE_DRIVE_MAP, drive_map);
   exit (ret);
 }
 
-- 
2.21.0
