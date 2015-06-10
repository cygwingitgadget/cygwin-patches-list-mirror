Return-Path: <cygwin-patches-return-8150-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119877 invoked by alias); 10 Jun 2015 18:44:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119864 invoked by uid 89); 10 Jun 2015 18:44:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.3 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0505.bt.lon5.cpcloud.co.uk
Received: from rgout0505.bt.lon5.cpcloud.co.uk (HELO rgout0505.bt.lon5.cpcloud.co.uk) (65.20.0.226) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Jun 2015 18:44:37 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.55788593.001B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.7.94516:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __CP_NAME_BODY, __LINES_OF_YELLING, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5573E8B300982529; Wed, 10 Jun 2015 19:44:27 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Improve strace to log most Windows debug events
Date: Wed, 10 Jun 2015 18:44:00 -0000
Message-Id: <1433961862-6800-1-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1433937922-16492-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00051.txt.bz2

Not sure if this is wanted, but on a couple of occasions recently I have been
presented with strace output which contains an exception at an address in an
unknown module (i.e. not in the cygwin DLL or the main executable), so here is a
patch which adds some more information, including DLL load addresses, to help
interpret such straces.

v2:
Use NtQueryObject() for HANDLE -> filename conversion
Add new '-e' option to toggle this additional logging

2015-06-07  Jon Turney  <jon.turney@dronecode.org.uk>

	* strace.cc (proc_child): Log process and thread create and exit,
	and DLL load and unload.
	(GetFileNameFromHandle): New function.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/utils.xml   |  1 +
 winsup/utils/ChangeLog |  6 ++++
 winsup/utils/strace.cc | 75 ++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index adafc2b..673da3b 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -2002,6 +2002,7 @@ Trace system calls and signals
 
   -b, --buffer-size=SIZE       set size of output file buffer
   -d, --no-delta               don't display the delta-t microsecond timestamp
+  -e, --events                 log all Windows DEBUG_EVENTS (toggle - default true)
   -f, --trace-children         trace child processes (toggle - default true)
   -h, --help                   output usage information and exit
   -m, --mask=MASK              set message filter mask
diff --git a/winsup/utils/ChangeLog b/winsup/utils/ChangeLog
index f9a25b2..5a68a40 100644
--- a/winsup/utils/ChangeLog
+++ b/winsup/utils/ChangeLog
@@ -1,3 +1,9 @@
+2015-06-07  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* strace.cc (proc_child): Log process and thread create and exit,
+	and DLL load and unload.
+	(GetFileNameFromHandle): New function.
+
 2015-06-10  Corinna Vinschen  <corinna@vinschen.de>
 
 	* ps.cc (main): Widen UID field in long format to accommodate longer
diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
index 73096ab..4b0d669 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/strace.cc
@@ -40,6 +40,7 @@ static int forkdebug = 1;
 static int numerror = 1;
 static int show_usecs = 1;
 static int delta = 1;
+static int events = 1;
 static int hhmmss;
 static int bufsize;
 static int new_window;
@@ -54,6 +55,8 @@ static BOOL close_handle (HANDLE h, DWORD ok);
 
 #define CloseHandle(h) close_handle(h, 0)
 
+static void *drive_map;
+
 struct child_list
 {
   DWORD id;
@@ -637,6 +640,30 @@ handle_output_debug_string (DWORD id, LPVOID p, unsigned mask, FILE *ofile)
     fflush (ofile);
 }
 
+static BOOL
+GetFileNameFromHandle(HANDLE hFile, WCHAR pszFilename[MAX_PATH+1])
+{
+  BOOL result = FALSE;
+  ULONG len = 0;
+  OBJECT_NAME_INFORMATION *ntfn = (OBJECT_NAME_INFORMATION *) alloca (65536);
+  NTSTATUS status = NtQueryObject (hFile, ObjectNameInformation,
+				   ntfn, 65536, &len);
+  if (NT_SUCCESS (status))
+    {
+      PWCHAR win32path = ntfn->Name.Buffer;
+      win32path[ntfn->Name.Length / sizeof (WCHAR)] = L'\0';
+
+      /* NtQueryObject returns a native NT path.  (Try to) convert to Win32. */
+      if (drive_map)
+	win32path = (PWCHAR) cygwin_internal (CW_MAP_DRIVE_MAP, drive_map,
+					      win32path);
+      pszFilename[0] = L'\0';
+      wcsncat (pszFilename, win32path, MAX_PATH);
+      result = TRUE;
+    }
+  return result;
+}
+
 static DWORD
 proc_child (unsigned mask, FILE *ofile, pid_t pid)
 {
@@ -670,19 +697,42 @@ proc_child (unsigned mask, FILE *ofile, pid_t pid)
       switch (ev.dwDebugEventCode)
 	{
 	case CREATE_PROCESS_DEBUG_EVENT:
+	  if (events)
+	    fprintf (ofile, "--- Process %lu created\n", ev.dwProcessId);
 	  if (ev.u.CreateProcessInfo.hFile)
 	    CloseHandle (ev.u.CreateProcessInfo.hFile);
 	  add_child (ev.dwProcessId, ev.u.CreateProcessInfo.hProcess);
 	  break;
 
 	case CREATE_THREAD_DEBUG_EVENT:
+	  if (events)
+	    fprintf (ofile, "--- Process %lu thread %lu created\n",
+		     ev.dwProcessId, ev.dwThreadId);
 	  break;
 
 	case LOAD_DLL_DEBUG_EVENT:
+	  if (events)
+	    {
+	      // lpImageName is not always populated, so find the filename for
+	      // hFile instead
+	      WCHAR dllname[MAX_PATH+1];
+	      if (!GetFileNameFromHandle(ev.u.LoadDll.hFile, dllname))
+		wcscpy(dllname, L"(unknown)");
+
+	      fprintf (ofile, "--- Process %lu loaded %ls at %p\n",
+		       ev.dwProcessId, dllname, ev.u.LoadDll.lpBaseOfDll);
+	    }
+
 	  if (ev.u.LoadDll.hFile)
 	    CloseHandle (ev.u.LoadDll.hFile);
 	  break;
 
+	case UNLOAD_DLL_DEBUG_EVENT:
+	  if (events)
+	    fprintf (ofile, "--- Process %lu unloaded DLL at %p\n",
+		     ev.dwProcessId, ev.u.UnloadDll.lpBaseOfDll);
+	  break;
+
 	case OUTPUT_DEBUG_STRING_EVENT:
 	  handle_output_debug_string (ev.dwProcessId,
 				      ev.u.DebugString.lpDebugStringData,
@@ -690,9 +740,19 @@ proc_child (unsigned mask, FILE *ofile, pid_t pid)
 	  break;
 
 	case EXIT_PROCESS_DEBUG_EVENT:
+	  if (events)
+	    fprintf (ofile, "--- Process %lu exited with status 0x%lx\n",
+		     ev.dwProcessId, ev.u.ExitProcess.dwExitCode);
 	  res = ev.u.ExitProcess.dwExitCode;
 	  remove_child (ev.dwProcessId);
 	  break;
+
+	case EXIT_THREAD_DEBUG_EVENT:
+	  if (events)
+	    fprintf (ofile, "--- Process %lu thread %lu exited with status 0x%lx\n",
+		     ev.dwProcessId, ev.dwThreadId, ev.u.ExitThread.dwExitCode);
+	  break;
+
 	case EXCEPTION_DEBUG_EVENT:
 	  if (ev.u.Exception.ExceptionRecord.ExceptionCode
 	      != (DWORD) STATUS_BREAKPOINT)
@@ -873,6 +933,7 @@ Trace system calls and signals\n\
 \n\
   -b, --buffer-size=SIZE       set size of output file buffer\n\
   -d, --no-delta               don't display the delta-t microsecond timestamp\n\
+  -e, --events                 log all Windows DEBUG_EVENTS (toggle - default true)\n\
   -f, --trace-children         trace child processes (toggle - default true)\n\
   -h, --help                   output usage information and exit\n\
   -m, --mask=MASK              set message filter mask\n\
@@ -928,6 +989,7 @@ Trace system calls and signals\n\
 
 struct option longopts[] = {
   {"buffer-size", required_argument, NULL, 'b'},
+  {"events", no_argument, NULL, 'e'},
   {"help", no_argument, NULL, 'h'},
   {"flush-period", required_argument, NULL, 'S'},
   {"hex", no_argument, NULL, 'H'},
@@ -946,7 +1008,7 @@ struct option longopts[] = {
   {NULL, 0, NULL, 0}
 };
 
-static const char *const opts = "+b:dhHfm:no:p:qS:tTuVw";
+static const char *const opts = "+b:dehHfm:no:p:qS:tTuVw";
 
 static void
 print_version ()
@@ -994,6 +1056,9 @@ main (int argc, char **argv)
       case 'd':
 	delta ^= 1;
 	break;
+      case 'e':
+	events ^= 1;
+	break;
       case 'f':
 	forkdebug ^= 1;
 	break;
@@ -1090,7 +1155,13 @@ character #%d.\n", optarg, (int) (endptr - optarg), endptr);
   if (toggle)
     dotoggle (pid);
   else
-    ExitProcess (dostrace (mask, ofile, pid, argv + optind));
+    {
+      drive_map = (void *) cygwin_internal (CW_ALLOC_DRIVE_MAP);
+      DWORD ret = dostrace (mask, ofile, pid, argv + optind);
+      if (drive_map)
+	cygwin_internal (CW_FREE_DRIVE_MAP, drive_map);
+      ExitProcess (ret);
+    }
   return 0;
 }
 
-- 
2.1.4
