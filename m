Return-Path: <cygwin-patches-return-7977-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13049 invoked by alias); 21 Apr 2014 17:02:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12976 invoked by uid 89); 21 Apr 2014 17:02:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: smtpout15.bt.lon5.cpcloud.co.uk
Received: from smtpout15.bt.lon5.cpcloud.co.uk (HELO smtpout15.bt.lon5.cpcloud.co.uk) (65.20.0.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Apr 2014 17:02:09 +0000
X-CTCH-RefID: str=0001.0A090209.53554F0E.001E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=8/97,refid=2.7.2:2014.4.17.150920:17:8.129,ip=,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __SUBJ_ALPHA_END, __CT, __CTYPE_HAS_BOUNDARY, __CTYPE_MULTIPART, __CTYPE_MULTIPART_MIXED, __BAT_BOUNDARY, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, MIME_TEXT_ONLY_MP_MIXED
X-CTCH-Spam: Unknown
Received: from [192.168.1.72] (86.164.67.104) by smtpout15.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 534BB3D0007BE781 for cygwin-patches@cygwin.com; Mon, 21 Apr 2014 18:02:05 +0100
Message-ID: <53554F1B.4060408@dronecode.org.uk>
Date: Mon, 21 Apr 2014 17:02:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [PATCH] minidumper patches
Content-Type: multipart/mixed; boundary="------------070601020507070407000307"
X-SW-Source: 2014-q2/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------070601020507070407000307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 792


Attached are a couple of patches for the minidumper utility which could
probably use some review.

The first one changes to direct linkage with dbghelp, rather than using
GetProcAddress().

(This seems to be the current style, I assume since the reasons for not
directly linking (no import libs or Windows versions which don't have the
.dll) are no longer relevant.)

As suggested, the second one changes the default dump type to something with
more information that just MiniDumpNormal, without getting too big.

(This is complicated by the fact that it appears to be an error to call
MiniDumpWriteDump() with an unknown dump flag, but the documentation for which
dump flags are supported by which dbhelp.dll version and how
ImagehlpApiVersionEx() is supposed to work is not totally clear)

--------------070601020507070407000307
Content-Type: text/plain; charset=windows-1252;
 name="minidumper_direct_link.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="minidumper_direct_link.patch"
Content-length: 3910

Link directly with dbghelp

2014-04-21  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* Makefile.in (minidumper.exe): Link directly with dbghelp.
	* minidumper.cc (minidump): Ditto.

---
 utils/Makefile.in   |    1 +
 utils/minidumper.cc |   47 ++++++++++-------------------------------------
 2 files changed, 11 insertions(+), 37 deletions(-)

Index: winsup/utils/Makefile.in
===================================================================
--- winsup.orig/utils/Makefile.in
+++ winsup/utils/Makefile.in
@@ -96,6 +96,7 @@ strace.exe: MINGW_LDFLAGS += -lntdll
 
 ldd.exe:CYGWIN_LDFLAGS += -lpsapi
 pldd.exe: CYGWIN_LDFLAGS += -lpsapi
+minidumper.exe: CYGWIN_LDFLAGS += -ldbghelp
 
 ldh.exe: MINGW_LDFLAGS += -nostdlib -lkernel32
 
Index: winsup/utils/minidumper.cc
===================================================================
--- winsup.orig/utils/minidumper.cc
+++ winsup/utils/minidumper.cc
@@ -26,42 +26,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <windows.h>
+#include <dbghelp.h>
 
 BOOL verbose = FALSE;
 BOOL nokill = FALSE;
 
-typedef DWORD MINIDUMP_TYPE;
-
-typedef BOOL (WINAPI *MiniDumpWriteDump_type)(
-                                              HANDLE hProcess,
-                                              DWORD dwPid,
-                                              HANDLE hFile,
-                                              MINIDUMP_TYPE DumpType,
-                                              CONST void *ExceptionParam,
-                                              CONST void *UserStreamParam,
-                                              CONST void *allbackParam);
-
 static void
 minidump(DWORD pid, MINIDUMP_TYPE dump_type, const char *minidump_file)
 {
   HANDLE dump_file;
   HANDLE process;
-  MiniDumpWriteDump_type MiniDumpWriteDump_fp;
-  HMODULE module;
-
-  module = LoadLibrary("dbghelp.dll");
-  if (!module)
-    {
-      fprintf (stderr, "error loading DbgHelp\n");
-      return;
-    }
-
-  MiniDumpWriteDump_fp = (MiniDumpWriteDump_type)GetProcAddress(module, "MiniDumpWriteDump");
-  if (!MiniDumpWriteDump_fp)
-    {
-      fprintf (stderr, "error getting the address of MiniDumpWriteDump\n");
-      return;
-    }
 
   dump_file = CreateFile(minidump_file,
                          GENERIC_READ | GENERIC_WRITE,
@@ -85,13 +59,13 @@ minidump(DWORD pid, MINIDUMP_TYPE dump_t
       return;
     }
 
-  BOOL success = (*MiniDumpWriteDump_fp)(process,
-                                         pid,
-                                         dump_file,
-                                         dump_type,
-                                         NULL,
-                                         NULL,
-                                         NULL);
+  BOOL success = MiniDumpWriteDump(process,
+                                   pid,
+                                   dump_file,
+                                   dump_type,
+                                   NULL,
+                                   NULL,
+                                   NULL);
   if (success)
     {
       if (verbose)
@@ -112,7 +86,6 @@ minidump(DWORD pid, MINIDUMP_TYPE dump_t
 
   CloseHandle(process);
   CloseHandle(dump_file);
-  FreeLibrary(module);
 }
 
 static void
@@ -164,7 +137,7 @@ main (int argc, char **argv)
   int opt;
   const char *p = "";
   DWORD pid;
-  MINIDUMP_TYPE dump_type = 0; // MINIDUMP_NORMAL
+  MINIDUMP_TYPE dump_type = MiniDumpNormal;
 
   while ((opt = getopt_long (argc, argv, opts, longopts, NULL) ) != EOF)
     switch (opt)
@@ -172,7 +145,7 @@ main (int argc, char **argv)
       case 't':
         {
           char *endptr;
-          dump_type = strtoul(optarg, &endptr, 0);
+          dump_type = (MINIDUMP_TYPE)strtoul(optarg, &endptr, 0);
           if (*endptr != '\0')
             {
               fprintf (stderr, "syntax error in minidump type \"%s\" near character #%d.\n", optarg, (int) (endptr - optarg));

--------------070601020507070407000307
Content-Type: text/plain; charset=windows-1252;
 name="minidumper_default_dump_type.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="minidumper_default_dump_type.patch"
Content-length: 4322

Change default dump type from MiniDumpNormal to something with more useful 
information without getting too big.

2014-04-21  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* minidumper.cc (filter_minidump_type): New function.
	(minidump): Change default dump type from MiniDumpNormal to
	something with more useful information without getting too
	big. Use filter_minidump_type() to filter out unsupported dump
	types.

---
 utils/minidumper.cc |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

Index: winsup/utils/minidumper.cc
===================================================================
--- winsup.orig/utils/minidumper.cc
+++ winsup/utils/minidumper.cc
@@ -28,9 +28,57 @@
 #include <windows.h>
 #include <dbghelp.h>
 
+DEFINE_ENUM_FLAG_OPERATORS(MINIDUMP_TYPE);
+
 BOOL verbose = FALSE;
 BOOL nokill = FALSE;
 
+/* Not yet in dbghelp.h */
+#define MiniDumpWithModuleHeaders (static_cast<MINIDUMP_TYPE>(0x00080000))
+#define MiniDumpFilterTriage      (static_cast<MINIDUMP_TYPE>(0x00100000))
+
+static MINIDUMP_TYPE
+filter_minidump_type(MINIDUMP_TYPE dump_type)
+{
+  API_VERSION build_version = { 6, 0, API_VERSION_NUMBER, 0 };
+  API_VERSION *v = ImagehlpApiVersionEx(&build_version);
+
+  if (verbose)
+    printf ("dbghelp version %d.%d.%d.%d\n", v->MajorVersion,
+            v->MinorVersion, v->Revision, v->Reserved);
+
+  MINIDUMP_TYPE supported_types = MiniDumpNormal | MiniDumpWithDataSegs
+    | MiniDumpWithFullMemory | MiniDumpWithHandleData | MiniDumpFilterMemory
+    | MiniDumpScanMemory;
+
+  /*
+    This mainly trial and error and guesswork, as the MSDN documentation only
+    says what version of "Debugging Tools for Windows" added these flags, but
+    doesn't actually tell us the dbghelp.dll version which was contained in that
+    (and seems to have errors as well)
+  */
+
+  if (v->MajorVersion >= 5)
+    supported_types |= MiniDumpWithUnloadedModules
+      | MiniDumpWithIndirectlyReferencedMemory | MiniDumpFilterModulePaths
+      | MiniDumpWithProcessThreadData | MiniDumpWithPrivateReadWriteMemory;
+
+  if (v->MajorVersion >= 6)
+    supported_types |= MiniDumpWithoutOptionalData | MiniDumpWithFullMemoryInfo
+      | MiniDumpWithThreadInfo | MiniDumpWithCodeSegs
+      | MiniDumpWithoutAuxiliaryState | MiniDumpWithFullAuxiliaryState // seems to be documentation error that these two aren't listed as 'Not supported prior to 6.1'
+      | MiniDumpWithPrivateWriteCopyMemory | MiniDumpIgnoreInaccessibleMemory
+      | MiniDumpWithTokenInformation;
+
+  if ((v->MajorVersion*10 + v->MinorVersion) >= 62)
+    supported_types |= MiniDumpWithModuleHeaders | MiniDumpFilterTriage; // seems to be documentation error that these two are listed as 'Not supported prior to 6.1'
+
+  if (verbose)
+    printf ("supported MINIDUMP_TYPE flags 0x%x\n", supported_types);
+
+  return (dump_type & supported_types);
+}
+
 static void
 minidump(DWORD pid, MINIDUMP_TYPE dump_type, const char *minidump_file)
 {
@@ -137,6 +185,7 @@ main (int argc, char **argv)
   int opt;
   const char *p = "";
   DWORD pid;
+  BOOL default_dump_type = TRUE;
   MINIDUMP_TYPE dump_type = MiniDumpNormal;
 
   while ((opt = getopt_long (argc, argv, opts, longopts, NULL) ) != EOF)
@@ -145,6 +194,7 @@ main (int argc, char **argv)
       case 't':
         {
           char *endptr;
+          default_dump_type = FALSE;
           dump_type = (MINIDUMP_TYPE)strtoul(optarg, &endptr, 0);
           if (*endptr != '\0')
             {
@@ -201,6 +251,21 @@ main (int argc, char **argv)
     }
   sprintf (minidump_file, "%s.dmp", p);
 
+  if (default_dump_type)
+    {
+      dump_type = MiniDumpWithHandleData | MiniDumpWithFullMemoryInfo
+        | MiniDumpWithThreadInfo | MiniDumpWithFullAuxiliaryState
+        | MiniDumpIgnoreInaccessibleMemory | MiniDumpWithTokenInformation
+        | MiniDumpWithIndirectlyReferencedMemory;
+
+      /*
+        Only filter out unsupported dump_type flags if we are using the default
+        dump type, so that future dump_type flags can be explicitly used even if
+        we don't know about them
+      */
+      dump_type = filter_minidump_type(dump_type);
+    }
+
   if (verbose)
     printf ("dumping process %u to %s using dump type flags 0x%x\n", (unsigned int)pid, minidump_file, (unsigned int)dump_type);
 

--------------070601020507070407000307--
