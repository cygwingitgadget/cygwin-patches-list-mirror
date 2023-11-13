Return-Path: <SRS0=1ukA=G2=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 000D63857343
	for <cygwin-patches@cygwin.com>; Mon, 13 Nov 2023 09:46:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 000D63857343
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 000D63857343
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699868804; cv=none;
	b=FmWJvSDJ9mt4B7QKEy4HvMawT875aKFTcZ4zg07dUOe9EgOPuZKZVZE1enz7SxKSH9O6Se2AYIv72HBoo9jcobsN/m7KQ4yP8gB99vNIUqmGJ8uU58PMhDqrQLSKscWIiu0kXekioqWhV6w28wkyNZXK14oxByvRcKNv7f4Vck8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699868804; c=relaxed/simple;
	bh=+TH0hCkWf8J7JhoTHAeygYW92P1zev5N5W/qpd+0dNI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dlHusFYEjFO1B2VqBb40+V6Vyj3pgf+MWxyKlen29Q0kuO8a0xT2m3IhVpDSYxYahcj9Z4gvlqdJujowk0llA0APMQLheypqjgRXiAiedeEsinHfFjpxqoHZg54YrQoQf2U8Kd8JQog4b5BaLY0hmBKhIATeqMpFdl+59or9vz8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3AD9k91W053522;
	Mon, 13 Nov 2023 01:46:09 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdUwVuCS; Mon Nov 13 01:46:00 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Fix profiler error() definition and usage
Date: Mon, 13 Nov 2023 01:46:13 -0800
Message-ID: <20231113094622.6710-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Minor updates to profiler and gmondump, which share some code:
- fix operation of error() so it actually works as intended
- resize 4K-size auto buffer reservations to BUFSIZ (==1K)
- remove trailing '\n' from 2nd arg on error() calls everywhere
- provide consistent annotation of Windows error number displays

Fixes: 9887fb27f6126 ("Cygwin: New tool: profiler")
Fixes: 087a3d76d7335 ("Cygwin: New tool: gmondump")
Signed-off-by: Mark Geisert <mark@maxrnd.com>

---
 winsup/utils/gmondump.c  |  8 ++++---
 winsup/utils/profiler.cc | 46 +++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/winsup/utils/gmondump.c b/winsup/utils/gmondump.c
index 16b99594a..3472a147e 100644
--- a/winsup/utils/gmondump.c
+++ b/winsup/utils/gmondump.c
@@ -58,7 +58,7 @@ void
 note (const char *fmt, ...)
 {
   va_list args;
-  char    buf[4096];
+  char    buf[BUFSIZ];
 
   va_start (args, fmt);
   vsprintf (buf, fmt, args);
@@ -72,7 +72,7 @@ void
 warn (int geterrno, const char *fmt, ...)
 {
   va_list args;
-  char    buf[4096];
+  char    buf[BUFSIZ];
 
   va_start (args, fmt);
   sprintf (buf, "%s: ", pgm);
@@ -92,10 +92,12 @@ void __attribute__ ((noreturn))
 error (int geterrno, const char *fmt, ...)
 {
   va_list args;
+  char    buf[BUFSIZ];
 
   va_start (args, fmt);
-  warn (geterrno, fmt, args);
+  vsprintf (buf, fmt, args);
   va_end (args);
+  warn (geterrno, "%s", buf);
 
   exit (1);
 }
diff --git a/winsup/utils/profiler.cc b/winsup/utils/profiler.cc
index 520e29d12..b2e26d663 100644
--- a/winsup/utils/profiler.cc
+++ b/winsup/utils/profiler.cc
@@ -130,7 +130,7 @@ void
 note (const char *fmt, ...)
 {
   va_list args;
-  char    buf[4096];
+  char    buf[BUFSIZ];
 
   va_start (args, fmt);
   vsprintf (buf, fmt, args);
@@ -144,7 +144,7 @@ void
 warn (int geterrno, const char *fmt, ...)
 {
   va_list args;
-  char    buf[4096];
+  char    buf[BUFSIZ];
 
   va_start (args, fmt);
   sprintf (buf, "%s: ", pgm);
@@ -164,10 +164,12 @@ void __attribute__ ((noreturn))
 error (int geterrno, const char *fmt, ...)
 {
   va_list args;
+  char    buf[BUFSIZ];
 
   va_start (args, fmt);
-  warn (geterrno, fmt, args);
+  vsprintf (buf, fmt, args);
   va_end (args);
+  warn (geterrno, "%s", buf);
 
   exit (1);
 }
@@ -263,15 +265,15 @@ start_profiler (child *c)
     note ("*** start profiler thread on pid %lu\n", (ulong) c->pid);
   c->context = (CONTEXT *) calloc (1, sizeof (CONTEXT));
   if (!c->context)
-    error (0, "unable to allocate CONTEXT buffer\n");
+    error (0, "unable to allocate CONTEXT buffer");
   c->context->ContextFlags = CONTEXT_CONTROL;
   c->hquitevt = CreateEvent (NULL, TRUE, FALSE, NULL);
   if (!c->hquitevt)
-    error (0, "unable to create quit event\n");
+    error (0, "unable to create quit event");
   c->profiling = 1;
   c->hprofthr = CreateThread (NULL, 0, profiler, (void *) c, 0, &tid);
   if (!c->hprofthr)
-    error (0, "unable to create profiling thread\n");
+    error (0, "unable to create profiling thread");
 
   /* There is a temptation to raise the execution priority of the profiling
    * threads.  Don't do this, or at least don't do it this way.  Testing
@@ -321,7 +323,7 @@ dump_profile_data (child *c)
 
       fd = open (filename, O_CREAT | O_TRUNC | O_WRONLY | O_BINARY);
       if (fd < 0)
-        error (0, "dump_profile_data: unable to create %s\n", filename);
+        error (0, "dump_profile_data: unable to create %s", filename);
 
       memset (&hdr, 0, sizeof (hdr));
       hdr.lpc = s->textlo;
@@ -427,7 +429,7 @@ add_thread (DWORD pid, DWORD tid, HANDLE h, WCHAR *name)
   child *c = get_child (pid);
 
   if (!c)
-    error (0, "add_thread: pid %lu not found\n", (ulong) pid);
+    error (0, "add_thread: pid %lu not found", (ulong) pid);
 
   thread_list *t = (thread_list *) calloc (1, sizeof (thread_list));
   t->tid = tid;
@@ -444,7 +446,7 @@ remove_thread (DWORD pid, DWORD tid)
   child *c = get_child (pid);
 
   if (!c)
-    error (0, "remove_thread: pid %lu not found\n", (ulong) pid);
+    error (0, "remove_thread: pid %lu not found", (ulong) pid);
 
   thread_list *t = c->threads;
   while (t)
@@ -463,7 +465,7 @@ remove_thread (DWORD pid, DWORD tid)
       t = t->next;
     }
 
-  error (0, "remove_thread: pid %lu tid %lu not found\n",
+  error (0, "remove_thread: pid %lu tid %lu not found",
              (ulong) pid, (ulong) tid);
 }
 
@@ -475,9 +477,9 @@ read_child (void *buf, SIZE_T size, void *addr, HANDLE h)
   if (debugging)
     note ("read %d bytes at %p from handle %d\n", size, addr, h);
   if (0 == ReadProcessMemory (h, addr, buf, size, &len))
-    error (0, "read_child: failed\n");
+    error (0, "read_child: failed");
   if (len != size)
-    error (0, "read_child: asked for %d bytes but got %d\n", size, len);
+    error (0, "read_child: asked for %d bytes but got %d", size, len);
 }
 
 IMAGE_SECTION_HEADER *
@@ -497,7 +499,7 @@ find_text_section (LPVOID base, HANDLE h)
   IMAGE_NT_HEADERS *inth = (IMAGE_NT_HEADERS *) ptr;
   read_child ((void *) &ntsig, sizeof (ntsig), &inth->Signature, h);
   if (ntsig != IMAGE_NT_SIGNATURE)
-    error (0, "find_text_section: NT signature not found\n");
+    error (0, "find_text_section: NT signature not found");
 
   read_child ((void *) &machine, sizeof (machine),
               &inth->FileHeader.Machine, h);
@@ -506,7 +508,7 @@ find_text_section (LPVOID base, HANDLE h)
 #else
 #error unimplemented for this target
 #endif
-    error (0, "target program was built for different machine architecture\n");
+    error (0, "target program was built for different machine architecture");
 
   read_child ((void *) &nsects, sizeof (nsects),
               &inth->FileHeader.NumberOfSections, h);
@@ -521,7 +523,7 @@ find_text_section (LPVOID base, HANDLE h)
       ish++;
     }
 
-  error (0, ".text section not found\n");
+  error (0, ".text section not found");
 }
 
 //TODO Extend add_span to add all executable sections of this exe/dll
@@ -531,7 +533,7 @@ add_span (DWORD pid, WCHAR *name, LPVOID base, HANDLE h)
   child *c = get_child (pid);
 
   if (!c)
-    error (0, "add_span: pid %lu not found\n", (ulong) pid);
+    error (0, "add_span: pid %lu not found", (ulong) pid);
 
   IMAGE_SECTION_HEADER *sect = find_text_section (base, c->hproc);
   span_list *s = (span_list *) calloc (1, sizeof (span_list));
@@ -650,7 +652,7 @@ ctrl_c (DWORD)
   static int tic = 1;
 
   if ((tic ^= 1) && !GenerateConsoleCtrlEvent (CTRL_C_EVENT, 0))
-    error (0, "couldn't send CTRL-C to child, win32 error %d\n",
+    error (0, "couldn't send CTRL-C to child, Windows error %d",
            GetLastError ());
   return TRUE;
 }
@@ -734,7 +736,7 @@ create_child (char **argv)
                        NULL,    /* current directory */
                        &si, &pi);
   if (!ret)
-    error (0, "error creating process %s, (error %d)", *argv,
+    error (0, "error creating process %s, Windows error %d", *argv,
            GetLastError ());
 
   CloseHandle (pi.hThread);
@@ -750,15 +752,15 @@ handle_output_debug_string (DWORD pid, OUTPUT_DEBUG_STRING_INFO *ev)
   child *c = get_child (pid);
 
   if (!c)
-    error (0, "handle_output_debug_string: pid %lu not found\n", (ulong) pid);
+    error (0, "handle_output_debug_string: pid %lu not found", (ulong) pid);
 
   read_child (buf, ev->nDebugStringLength, ev->lpDebugStringData, c->hproc);
   if (strncmp (buf, "cYg", 3))
     { // string is not from Cygwin, it's from the target app; just display it
       if (ev->fUnicode)
-        note ("%ls", buf);
+        note ("%ls\n", buf);
       else
-        note ("%s", buf);
+        note ("%s\n", buf);
     }
   //else TODO Possibly decode and display Cygwin-internal debug string
 }
@@ -941,7 +943,7 @@ profile1 (FILE *ofile, pid_t pid)
         }
 
       if (!debug_event)
-        error (0, "couldn't continue debug event, windows error %d",
+        error (0, "couldn't continue debug event, Windows error %d",
                GetLastError ());
       if (!numprocesses)
         break;
-- 
2.42.1

