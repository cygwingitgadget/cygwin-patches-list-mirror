Return-Path: <cygwin-patches-return-8145-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21387 invoked by alias); 10 Jun 2015 12:05:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21375 invoked by uid 89); 10 Jun 2015 12:05:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0303.bt.lon5.cpcloud.co.uk
Received: from rgout0303.bt.lon5.cpcloud.co.uk (HELO rgout0303.bt.lon5.cpcloud.co.uk) (65.20.0.209) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Jun 2015 12:05:35 +0000
X-OWM-Source-IP: 31.51.205.195(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090201.5578280D.00E1,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.8.193915:17:27.888,ip=31.51.205.195,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __LINES_OF_YELLING, BODY_SIZE_5000_5999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[195.205.51.31.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.195) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5575F730004147F5; Wed, 10 Jun 2015 13:05:33 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Improve strace to log most Windows debug events
Date: Wed, 10 Jun 2015 12:05:00 -0000
Message-Id: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00046.txt.bz2

Not sure if this is wanted, but on a couple of occasions recently I have been
presented with strace output which contains an exception at an address in an
unknown module (i.e. not in the cygwin DLL or the main executable), so here is a
patch which adds some more information, including DLL load addresses, to help
interpret such straces.

2015-06-07  Jon Turney  <jon.turney@dronecode.org.uk>

	* strace.cc (proc_child): Log process and thread create and exit,
	and DLL load and unload.
	(GetFileNameFromHandle): New function.
	* Makefile.in (strace.exe): Link against psapi.dll.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/utils/ChangeLog   |  7 ++++++
 winsup/utils/Makefile.in |  2 +-
 winsup/utils/strace.cc   | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/winsup/utils/ChangeLog b/winsup/utils/ChangeLog
index bfdb42a..7561a58 100644
--- a/winsup/utils/ChangeLog
+++ b/winsup/utils/ChangeLog
@@ -1,3 +1,10 @@
+2015-06-07  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* strace.cc (proc_child): Log process and thread create and exit,
+	and DLL load and unload.
+	(GetFileNameFromHandle): New function.
+	* Makefile.in (strace.exe): Link against psapi.dll.
+
 2015-04-21  Corinna Vinschen  <corinna@vinschen.de>
 
 	* tzmap-from-unicode.org: Convert Calcutta to Kolkata.
diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index fe81d87..4dfe349 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -101,7 +101,7 @@ cygcheck.exe: ${CYGCHECK_OBJS}
 cygpath.o: CXXFLAGS += -fno-threadsafe-statics
 cygpath.exe: CYGWIN_LDFLAGS += -lcygwin -luserenv -lntdll
 ps.exe: CYGWIN_LDFLAGS += -lcygwin -lpsapi -lntdll
-strace.exe: MINGW_LDFLAGS += -lntdll
+strace.exe: MINGW_LDFLAGS += -lntdll -lpsapi
 
 ldd.exe:CYGWIN_LDFLAGS += -lpsapi
 pldd.exe: CYGWIN_LDFLAGS += -lpsapi
diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
index 73096ab..f54cab5 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/strace.cc
@@ -12,6 +12,7 @@ Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
 #include <windows.h>
+#include <psapi.h>
 #include <winternl.h>
 #define cygwin_internal cygwin_internal_dontuse
 #include <stdio.h>
@@ -637,6 +638,36 @@ handle_output_debug_string (DWORD id, LPVOID p, unsigned mask, FILE *ofile)
     fflush (ofile);
 }
 
+// This is a pretty tragic way to convert HANDLE -> filename, but this is the
+// the way MSDN suggest to do it if you want to be portable to Windows versions
+// prior to 6.0, where GetFinalPathNameByHandle() isn't available.
+static BOOL
+GetFileNameFromHandle(HANDLE hFile, WCHAR pszFilename[MAX_PATH+1])
+{
+  HANDLE hFileMap;
+  BOOL result = FALSE;
+
+  // Create a file mapping object.
+  hFileMap = CreateFileMapping (hFile, NULL, PAGE_READONLY, 0, 1, NULL);
+  if (hFileMap)
+    {
+      // Create a file mapping to get the file name.
+      void* pMem = MapViewOfFile (hFileMap, FILE_MAP_READ, 0, 0, 1);
+      if (pMem)
+	{
+	  if (GetMappedFileNameW (GetCurrentProcess (), pMem, pszFilename,
+				  MAX_PATH))
+	    {
+	      result = TRUE;
+	    }
+	  UnmapViewOfFile(pMem);
+	}
+    CloseHandle(hFileMap);
+  }
+
+  return result;
+}
+
 static DWORD
 proc_child (unsigned mask, FILE *ofile, pid_t pid)
 {
@@ -670,19 +701,38 @@ proc_child (unsigned mask, FILE *ofile, pid_t pid)
       switch (ev.dwDebugEventCode)
 	{
 	case CREATE_PROCESS_DEBUG_EVENT:
+	  fprintf (ofile, "--- Process %lu created\n", ev.dwProcessId);
 	  if (ev.u.CreateProcessInfo.hFile)
 	    CloseHandle (ev.u.CreateProcessInfo.hFile);
 	  add_child (ev.dwProcessId, ev.u.CreateProcessInfo.hProcess);
 	  break;
 
 	case CREATE_THREAD_DEBUG_EVENT:
+	  fprintf (ofile, "--- Process %lu thread %lu created\n",
+		   ev.dwProcessId, ev.dwThreadId);
 	  break;
 
 	case LOAD_DLL_DEBUG_EVENT:
+	  {
+	    // lpImageName is not always populated, so find the filename for
+	    // hFile instead
+	    WCHAR dllname[MAX_PATH+1];
+	    if (!GetFileNameFromHandle(ev.u.LoadDll.hFile, dllname))
+		wcscpy(dllname, L"(unknown)");
+
+	    fprintf (ofile, "--- Process %lu loaded %ls at %p\n",
+		     ev.dwProcessId, dllname, ev.u.LoadDll.lpBaseOfDll);
+	  }
+
 	  if (ev.u.LoadDll.hFile)
 	    CloseHandle (ev.u.LoadDll.hFile);
 	  break;
 
+	case UNLOAD_DLL_DEBUG_EVENT:
+	  fprintf (ofile, "--- Process %lu unloaded DLL at %p\n",
+		   ev.dwProcessId, ev.u.UnloadDll.lpBaseOfDll);
+	  break;
+
 	case OUTPUT_DEBUG_STRING_EVENT:
 	  handle_output_debug_string (ev.dwProcessId,
 				      ev.u.DebugString.lpDebugStringData,
@@ -690,9 +740,17 @@ proc_child (unsigned mask, FILE *ofile, pid_t pid)
 	  break;
 
 	case EXIT_PROCESS_DEBUG_EVENT:
+	  fprintf (ofile, "--- Process %lu exited with status 0x%lx\n",
+		   ev.dwProcessId, ev.u.ExitProcess.dwExitCode);
 	  res = ev.u.ExitProcess.dwExitCode;
 	  remove_child (ev.dwProcessId);
 	  break;
+
+	case EXIT_THREAD_DEBUG_EVENT:
+	  fprintf (ofile, "--- Process %lu thread %lu exited with status 0x%lx\n",
+		   ev.dwProcessId, ev.dwThreadId, ev.u.ExitThread.dwExitCode);
+	  break;
+
 	case EXCEPTION_DEBUG_EVENT:
 	  if (ev.u.Exception.ExceptionRecord.ExceptionCode
 	      != (DWORD) STATUS_BREAKPOINT)
-- 
2.1.4
