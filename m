Return-Path: <cygwin-patches-return-7508-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17648 invoked by alias); 13 Sep 2011 12:05:34 -0000
Received: (qmail 17614 invoked by uid 22791); 13 Sep 2011 12:05:29 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Sep 2011 12:04:45 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.7]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 13 Sep 2011 13:04:43 +0100
Message-ID: <4E6F46E7.5080108@dronecode.org.uk>
Date: Tue, 13 Sep 2011 12:05:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0) Gecko/20110905 Thunderbird/7.0
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Fix strace tracing of forked processes when attaching to a process with --pid
References: <4E6E0710.4000909@dronecode.org.uk>
In-Reply-To: <4E6E0710.4000909@dronecode.org.uk>
X-Forwarded-Message-Id: <4E6E0710.4000909@dronecode.org.uk>
Content-Type: multipart/mixed; boundary="------------060407040308010205010409"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00084.txt.bz2

This is a multi-part message in MIME format.
--------------060407040308010205010409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1126


At the moment, --trace-children (enabled by default) only works when the 
straced process is started by using strace with a command line.

This patch uses the undocumented NtSetInformationProcess(ProcessDebugFlags) 
call to make --trace-children work when attaching to a process with --pid

This patch removes the explicit DebugActiveProcess() on each child process: In 
my testing this was not needed when the process was created using 
CreateProcess() with the DEBUG_PROCESS flag, and failed error 87 when a 
process had been attached to with DebugActiveProcess() and then had the 
DEBUG_ONLY_THIS_PROCESS flag cleared.

In the alternative, the man page should be fixed to mention that tracing
child  processes is only possible when using a command line and not with --pid.

2011-09-12  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* strace.cc (attach_process): Try to turn off DEBUG_ONLY_THIS_PROCESS
	if attaching to a process with the forkdebug flag set.
	(handle_output_debug_string): Apparently we don't need to explicitly
	attach for debugging when a child process starts
	* Makefile.in (strace.exe): Link with ntdll


--------------060407040308010205010409
Content-Type: text/plain;
 name="strace_follow_pid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="strace_follow_pid.patch"
Content-length: 2167

At the moment, --trace-children only works when using strace with a command line.
This makes --trace-children work when attaching to a process by --pid

Index: utils/strace.cc
===================================================================
--- utils/strace.cc.orig
+++ utils/strace.cc
@@ -27,6 +27,7 @@ details. */
 #include "path.h"
 #undef cygwin_internal
 #include "loadlib.h"
+#include "ddk/ntapi.h"
 
 /* we *know* we're being built with GCC */
 #define alloca __builtin_alloca
@@ -293,6 +294,9 @@ load_cygwin ()
   return 1;
 }
 
+#define DEBUG_PROCESS_DETACH_ON_EXIT    0x00000001
+#define DEBUG_PROCESS_ONLY_THIS_PROCESS 0x00000002
+
 static void
 attach_process (pid_t pid)
 {
@@ -303,6 +307,23 @@ attach_process (pid_t pid)
   if (!DebugActiveProcess (child_pid))
     error (0, "couldn't attach to pid %d for debugging", child_pid);
 
+  if (forkdebug)
+    {
+      HANDLE h = OpenProcess(PROCESS_ALL_ACCESS, FALSE, child_pid);
+
+      if (h)
+        {
+          /* Try to turn off DEBUG_ONLY_THIS_PROCESS so we can follow forks */
+          /* This is only supported on XP and later */
+          ULONG DebugFlags = DEBUG_PROCESS_DETACH_ON_EXIT;
+          NTSTATUS status = NtSetInformationProcess(h, ProcessDebugFlags, &DebugFlags, sizeof(DebugFlags));
+          if (status)
+            warn (0, "Could not clear DEBUG_ONLY_THIS_PROCESS (%x), will not trace child processes", status);
+
+          CloseHandle(h);
+        }
+    }
+
   return;
 }
 
@@ -467,9 +488,6 @@ handle_output_debug_string (DWORD id, LP
 
   if (special == _STRACE_CHILD_PID)
     {
-      if (!DebugActiveProcess (n))
-	error (0, "couldn't attach to subprocess %d for debugging, "
-	       "windows error %d", n, GetLastError ());
       return;
     }
 
Index: utils/Makefile.in
===================================================================
--- utils/Makefile.in.orig
+++ utils/Makefile.in
@@ -78,6 +78,7 @@ cygcheck.exe: MINGW_LDFLAGS += -lntdll
 cygpath.exe: ALL_LDFLAGS += -lcygwin -lntdll
 cygpath.exe: CXXFLAGS += -fno-threadsafe-statics
 ps.exe: ALL_LDFLAGS += -lcygwin -lntdll
+strace.exe: MINGW_LDFLAGS += -lntdll
 
 ldd.exe: ALL_LDFLAGS += -lpsapi
 


--------------060407040308010205010409--
