Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 275EC383D024
 for <cygwin-patches@cygwin.com>; Mon,  2 Aug 2021 06:52:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 275EC383D024
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 1726qg41061682;
 Sun, 1 Aug 2021 23:52:42 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdhBJtCI; Sun Aug  1 23:52:41 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: More profiler format + small issue fixes
Date: Sun,  1 Aug 2021 23:52:31 -0700
Message-Id: <20210802065231.1011-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 02 Aug 2021 06:52:46 -0000

Make sure to cast to ulong all DWORD values displayed with format "%lu".
More instances are fixed here than in either my earlier unused patch or
Corinna's patch. I decided to use typedef..ulong for more compact code.

Address jturney's reported small issues:
- Remove explicit external ref for cygwin_internal() as it is already
  provided by <sys/cygwin.h>.
- Leave intact ref for cygwin_dll_path[] as it is required by function(s)
  in path.cc that profiler uses. Added comment to that effect.
- Delete existing main() wrapper. Rename main2() to main(). This because
  profiler is now a Cygwin program and doesn't need to dynamically load
  cygwin1.dll.
- Documentation issues will be addressed in a separate xml patch.

(I would have linked message-ids of Corinna's and Jon's messages for
proper theading but I no longer have their original emails and the mail
archives don't show msgids any more.)

---
 winsup/utils/profiler.cc | 60 ++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/winsup/utils/profiler.cc b/winsup/utils/profiler.cc
index 354aefca8..2be7baf74 100644
--- a/winsup/utils/profiler.cc
+++ b/winsup/utils/profiler.cc
@@ -14,7 +14,6 @@
 #define WIN32_LEAN_AND_MEAN
 #include <winternl.h>
 
-#define cygwin_internal cygwin_internal_dontuse
 #include <errno.h>
 #include <fcntl.h>
 #include <getopt.h>
@@ -27,14 +26,13 @@
 #include <unistd.h>
 #include <sys/cygwin.h>
 #include "cygwin/version.h"
-#include "cygtls_padsize.h"
 #include "gcc_seh.h"
+typedef unsigned long ulong;
 typedef unsigned short ushort;
 typedef uint16_t u_int16_t; // Non-standard sized type needed by ancient gmon.h
 #define NO_GLOBALS_H
 #include "gmon.h"
 #include "path.h"
-#undef cygwin_internal
 
 /* Undo this #define from winsup.h. */
 #ifdef ExitThread
@@ -201,7 +199,7 @@ bump_bucket (child *c, size_t pc)
 {
   span_list *s = c->spans;
 
-//note ("%lu %p\n", c->pid, pc);
+//note ("%lu %p\n", (ulong) c->pid, pc);
   if (pc == 0ULL)
     return;
   while (s)
@@ -225,7 +223,7 @@ bump_bucket (child *c, size_t pc)
    *     profiling info on them will be confusing if their addresses overlap.
    */
   if (verbose)
-    note ("*** pc %p out of range for pid %lu\n", pc, c->pid);
+    note ("*** pc %p out of range for pid %lu\n", pc, (ulong) c->pid);
 }
 
 /* profiler runs on its own thread; each child has a separate profiler. */
@@ -258,7 +256,7 @@ start_profiler (child *c)
   DWORD  tid;
 
   if (verbose)
-    note ("*** start profiler thread on pid %lu\n", c->pid);
+    note ("*** start profiler thread on pid %lu\n", (ulong) c->pid);
   c->context = (CONTEXT *) calloc (1, sizeof (CONTEXT));
   if (!c->context)
     error (0, "unable to allocate CONTEXT buffer\n");
@@ -284,7 +282,7 @@ void
 stop_profiler (child *c)
 {
   if (verbose)
-    note ("*** stop profiler thread on pid %lu\n", c->pid);
+    note ("*** stop profiler thread on pid %lu\n", (ulong) c->pid);
   c->profiling = 0;
   SignalObjectAndWait (c->hquitevt, c->hprofthr, INFINITE, FALSE);
   CloseHandle (c->hquitevt);
@@ -312,11 +310,10 @@ dump_profile_data (child *c)
       if (s->name)
         {
           WCHAR *name = 1 + wcsrchr (s->name, L'\\');
-          sprintf (filename, "%s.%lu.%ls", prefix, (unsigned long) c->pid,
-					   name);
+          sprintf (filename, "%s.%lu.%ls", prefix, (ulong) c->pid, name);
         }
       else
-        sprintf (filename, "%s.%lu", prefix, (unsigned long) c->pid);
+        sprintf (filename, "%s.%lu", prefix, (ulong) c->pid);
 
       fd = open (filename, O_CREAT | O_TRUNC | O_WRONLY | O_BINARY);
       if (fd < 0)
@@ -390,7 +387,7 @@ add_child (DWORD pid, WCHAR *name, LPVOID base, HANDLE hproc)
       start_profiler (children.next);
       numprocesses++;
       if (verbose)
-        note ("*** Windows process %lu attached\n", pid);
+        note ("*** Windows process %lu attached\n", (ulong) pid);
     }
 }
 
@@ -412,7 +409,7 @@ remove_child (DWORD pid)
         c1->hproc = 0;
         free (c1);
         if (verbose)
-          note ("*** Windows process %lu detached\n", pid);
+          note ("*** Windows process %lu detached\n", (ulong) pid);
         numprocesses--;
         return;
       }
@@ -426,7 +423,7 @@ add_thread (DWORD pid, DWORD tid, HANDLE h, WCHAR *name)
   child *c = get_child (pid);
 
   if (!c)
-    error (0, "add_thread: pid %lu not found\n", pid);
+    error (0, "add_thread: pid %lu not found\n", (ulong) pid);
 
   thread_list *t = (thread_list *) calloc (1, sizeof (thread_list));
   t->tid = tid;
@@ -443,7 +440,7 @@ remove_thread (DWORD pid, DWORD tid)
   child *c = get_child (pid);
 
   if (!c)
-    error (0, "remove_thread: pid %lu not found\n", pid);
+    error (0, "remove_thread: pid %lu not found\n", (ulong) pid);
 
   thread_list *t = c->threads;
   while (t)
@@ -462,7 +459,8 @@ remove_thread (DWORD pid, DWORD tid)
       t = t->next;
     }
 
-  error (0, "remove_thread: pid %lu tid %lu not found\n", pid, tid);
+  error (0, "remove_thread: pid %lu tid %lu not found\n",
+             (ulong) pid, (ulong) tid);
 }
 
 void
@@ -531,7 +529,7 @@ add_span (DWORD pid, WCHAR *name, LPVOID base, HANDLE h)
   child *c = get_child (pid);
 
   if (!c)
-    error (0, "add_span: pid %lu not found\n", pid);
+    error (0, "add_span: pid %lu not found\n", (ulong) pid);
 
   IMAGE_SECTION_HEADER *sect = find_text_section (base, c->hproc);
   span_list *s = (span_list *) calloc (1, sizeof (span_list));
@@ -655,11 +653,7 @@ ctrl_c (DWORD)
   return TRUE;
 }
 
-/* Set up interfaces to Cygwin internal funcs and path.cc helper funcs. */
-extern "C" {
-uintptr_t cygwin_internal (int, ...);
-WCHAR cygwin_dll_path[32768];
-}
+WCHAR cygwin_dll_path[32768]; // required by path.cc helper funcs used herein
 
 #define DEBUG_PROCESS_DETACH_ON_EXIT    0x00000001
 #define DEBUG_PROCESS_ONLY_THIS_PROCESS 0x00000002
@@ -754,7 +748,7 @@ handle_output_debug_string (DWORD pid, OUTPUT_DEBUG_STRING_INFO *ev)
   child *c = get_child (pid);
 
   if (!c)
-    error (0, "handle_output_debug_string: pid %lu not found\n", pid);
+    error (0, "handle_output_debug_string: pid %lu not found\n", (ulong) pid);
 
   read_child (buf, ev->nDebugStringLength, ev->lpDebugStringData, c->hproc);
   if (strncmp (buf, "cYg", 3))
@@ -805,10 +799,10 @@ cygwin_pid (DWORD winpid)
   cygpid = (DWORD) cygwin_internal (CW_WINPID_TO_CYGWIN_PID, winpid);
 
   if (cygpid >= max_cygpid)
-    snprintf (buf, sizeof buf, "%lu", (unsigned long) winpid);
+    snprintf (buf, sizeof (buf), "%lu", (ulong) winpid);
   else
-    snprintf (buf, sizeof buf, "%lu (pid: %lu)", (unsigned long) winpid,
-						 (unsigned long) cygpid);
+    snprintf (buf, sizeof (buf), "%lu (pid: %lu)",
+              (ulong) winpid, (ulong) cygpid);
   return buf;
 }
 
@@ -1002,7 +996,7 @@ print_version ()
 }
 
 int
-main2 (int argc, char **argv)
+main (int argc, char **argv)
 {
   int    opt;
   pid_t  pid = 0;
@@ -1095,17 +1089,3 @@ main2 (int argc, char **argv)
     fclose (ofile);
   return (ret);
 }
-
-int
-main (int argc, char **argv)
-{
-  /* Make sure to have room for the _cygtls area *and* to initialize it.
-   * This is required to make sure cygwin_internal calls into Cygwin work
-   * reliably.  This problem has been noticed under AllocationPreference
-   * registry setting to 0x100000 (TOP_DOWN).
-   */
-  char buf[CYGTLS_PADSIZE];
-
-  RtlSecureZeroMemory (buf, sizeof (buf));
-  exit (main2 (argc, argv));
-}
-- 
2.32.0

