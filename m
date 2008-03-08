Return-Path: <cygwin-patches-return-6256-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18381 invoked by alias); 8 Mar 2008 19:06:03 -0000
Received: (qmail 18366 invoked by uid 22791); 8 Mar 2008 19:06:00 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 08 Mar 2008 19:05:29 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JY4MI-0001QG-Tq 	for cygwin-patches@cygwin.com; Sat, 08 Mar 2008 19:05:27 +0000
Message-ID: <47D2E28C.3FC392D3@dessent.net>
Date: Sat, 08 Mar 2008 19:06:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] utils/path.cc fixes and testsuite
Content-Type: multipart/mixed;  boundary="------------26A5CB108D89E492E70A09C4"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00030.txt.bz2

This is a multi-part message in MIME format.
--------------26A5CB108D89E492E70A09C4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 2253


The winsup/utils/path.cc file implements a primative POSIX->Win32 path
conversion API that is independant of the real one in Cygwin.  This is
used by cygcheck as well as strace (for opening the -o parameter). 
Currently this code has bitrotted a bit, and its handling of relative
paths seems to be a little awkward.  Examples of how it's broken:

"strace -o foo.out cmd" will place foo.out file in / (or some other
strange location, usually the root of whatever prefix of the mount table
matched CWD) instead of the CWD.

"cd /bin && cygcheck ls" reports "Error: could not find ls", but "cd
/bin && cygcheck ./ls" does work.

"cd / && cygcheck usr/bin/ls" reports "usr/bin/ls - Cannot open" but "cd
/ && cygcheck bin/ls" works.

"cp /bin/ls /tmp && cd / && cygcheck tmp/ls" reports "tmp/ls - Cannot
open".

Anyway, I took a look at fixing this so that the path.cc code is a
little more robust.  But as I'm sure you're aware, messing with path
conversion code is really annoying when you factor in all sorts of weird
corner cases, so I decided to make a testsuite for this code so that it
would be possible to both cure the bitrot as well as know if it has
regressed again.  That attached patch does both.

The harness that I came up with consists of simply a header
(testsuite.h) which contains definitions for both a toy mount table as
well as a series of {CWD,POSIX input,expected Win32 output} tuples that
form the tests.  The driver is testsuite.c, and it works by recompiling
path.cc with -DTESTSUITE to activate the hooks.  It's pretty simplistic,
but it has allowed me to fix a number of corner cases in the code such
that all of the above mentioned oddities are now gone.  In order to make
the testsuite pass I also had to add a little bit of normalization code
so that e.g. the Win32 output always uses backslashes and that it
doesn't leave repeated slashes between parts, e.g. foo\\/bar.  For the
sample mount table I tried to emulate what a real mount table is
typically like, with a couple additional mounts.

The Makefile changes to support this are pretty straightforward: nothing
changes for the default "make all" case.  If you run "make check" it
builds the required files and runs the testsuite.  I've attached a
sample output.

Brian
--------------26A5CB108D89E492E70A09C4
Content-Type: text/plain; charset=us-ascii;
 name="utils_path_bugfix_testsuite.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="utils_path_bugfix_testsuite.patch"
Content-length: 17684

2008-03-08  Brian Dessent  <brian@dessent.net>

	* Makefile.in: Add a 'check' target that builds and runs
	testsuite.exe from path-testsuite.o and testsuite.o.
	* path.cc: Include testsuite.h.
	(struct mnt): Change to a mnt_t typedef and don't define
	mount_table when TESTSUITE is defined.
	(find2): Don't include when TESTSUITE is defined to avoid warning.
	(get_cygdrive0): Ditto.
	(get_cygdrive): Ditto.
	(read_mounts): Provide empty implementation when TESTSUITE is
	defined.
	(vconcat): Use the isslash macro.
	(unconvert_slashes): New helper to convert to backslashses.
	(rel_vconcat): Handle relative paths more gracefully.
	(cygpath): Skip a leading "./" sequence.  Avoid double-slashes.
	Normalize final output to backslashes and remove redundant path
	sequences.
	* testsuite.cc: New file implementing testsuite driver.
	* testsuite.h: New header implementing harness mount table and
	series of tests.

 Makefile.in  |   19 +++++++-
 path.cc      |   57 +++++++++++++++++++++----
 testsuite.cc |   89 ++++++++++++++++++++++++++++++++++++++++
 testsuite.h  |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 283 insertions(+), 12 deletions(-)

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.69
diff -u -p -r1.69 Makefile.in
--- Makefile.in	8 Mar 2008 17:52:49 -0000	1.69
+++ Makefile.in	8 Mar 2008 18:11:10 -0000
@@ -99,10 +99,23 @@ else
 all: warn_cygcheck_zlib
 endif
 
-# the rest of this file contains generic rules
-
 all: Makefile $(CYGWIN_BINS) $(MINGW_BINS)
 
+# test harness support (note: the "MINGW_BINS +=" should come after the
+# "all:" above so that the testsuite is not run for "make" but only
+# "make check".)
+MINGW_BINS += testsuite.exe
+MINGW_OBJS += path-testsuite.o testsuite.o
+testsuite.exe: path-testsuite.o
+path-testsuite.cc: path.cc ; ln -sf ${filter %.cc,$^} $@
+path-testsuite.o: MINGW_CXXFLAGS += -DTESTSUITE
+# this is necessary because this .c lives in the build dir instead of src
+path-testsuite.o: MINGW_CXX := ${patsubst -I.,-I$(utils_source),$(MINGW_CXX)}
+path-testsuite.cc path.cc testsuite.cc: testsuite.h
+check: testsuite.exe ; $(<D)/$(<F)
+
+# the rest of this file contains generic rules
+
 # how to compile a MinGW object
 $(MINGW_OBJS): %.o: %.cc
 ifdef VERBOSE
@@ -137,7 +150,7 @@ $(MINGW_BINS): $(MINGW_DEP_LDLIBS)
 $(CYGWIN_BINS): $(ALL_DEP_LDLIBS)
 
 clean:
-	rm -f *.o $(CYGWIN_BINS) $(MINGW_BINS)
+	rm -f *.o $(CYGWIN_BINS) $(MINGW_BINS) path-testsuite.cc testsuite.exe
 
 realclean: clean
 	rm -f Makefile config.cache
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/path.cc,v
retrieving revision 1.12
diff -u -p -r1.12 path.cc
--- path.cc	4 Jun 2007 01:57:16 -0000	1.12
+++ path.cc	8 Mar 2008 18:11:10 -0000
@@ -1,6 +1,6 @@
 /* path.cc
 
-   Copyright 2001, 2002, 2003, 2005, 2006, 2007 Red Hat, Inc.
+   Copyright 2001, 2002, 2003, 2005, 2006, 2007, 2008 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -22,6 +22,7 @@ details. */
 #include "cygwin/include/cygwin/version.h"
 #include "cygwin/include/sys/mount.h"
 #include "cygwin/include/mntent.h"
+#include "testsuite.h"
 
 /* Used when treating / and \ as equivalent. */
 #define isslash(ch) \
@@ -227,16 +228,27 @@ readlink (HANDLE fh, char *path, int max
   return true;
 }
 
-static struct mnt
+typedef struct mnt
   {
     const char *native;
     char *posix;
     unsigned flags;
     int issys;
-  } mount_table[255];
+  } mnt_t;
+
+#ifndef TESTSUITE
+static mnt_t mount_table[255];
+#else
+#  define TESTSUITE_MOUNT_TABLE
+#  include "testsuite.h"
+#  undef TESTSUITE_MOUNT_TABLE
+#endif
 
 struct mnt *root_here = NULL;
 
+/* These functions aren't called when defined(TESTSUITE) which results
+   in a compiler warning.  */
+#ifndef TESTSUITE
 static char *
 find2 (HKEY rkey, unsigned *flags, char *what)
 {
@@ -288,10 +300,14 @@ get_cygdrive (HKEY key, mnt *m, int issy
   m->issys = issystem;
   return m + 1;
 }
+#endif
 
 static void
 read_mounts ()
 {
+/* If TESTSUITE is defined, bypass this whole function as a harness
+   mount table will be provided.  */
+#ifndef TESTSUITE
   DWORD posix_path_size;
   int res;
   struct mnt *m = mount_table;
@@ -358,6 +374,7 @@ read_mounts ()
 	}
       RegCloseKey (key);
     }
+#endif /* !defined(TESTSUITE) */
 }
 
 /* Return non-zero if PATH1 is a prefix of PATH2.
@@ -439,7 +456,7 @@ vconcat (const char *s, va_list v)
 	  *d++ = *++p;
 	  *d++ = *++p;
 	}
-      else if (*p == '/' || *p == '\\')
+      else if (isslash (*p))
 	{
 	  if (p == rv && unc)
 	    *d++ = *p++;
@@ -462,6 +479,13 @@ concat (const char *s, ...)
   return vconcat (s, v);
 }
 
+static void
+unconvert_slashes (char* name)
+{
+  while ((name = strchr (name, '/')) != NULL)
+    *name++ = '\\';
+}
+
 static char *
 rel_vconcat (const char *s, va_list v)
 {
@@ -487,13 +511,20 @@ rel_vconcat (const char *s, va_list v)
       match = m;
     }
 
+  char *temppath;
   if (match)
-    strcpy (path, match->posix);
-
-  if (!isslash (strchr (path, '\0')[-1]))
-    strcat (path, "/");
+    if (strcmp (match->posix, "/") == 0)
+      if (*(path + max_len) == 0)
+        temppath = concat ("/", s, NULL);
+      else if (isslash (*(path + max_len)))
+        temppath = concat (path + max_len, "/", s, NULL);
+      else
+        temppath = concat ("/", path + max_len, "/", s, NULL);
+    else
+      temppath = concat (match->posix, path + max_len, "/", s, NULL);    
+  else
+    temppath = concat (path, "/", s, NULL);
 
-  char *temppath = concat (path, s, NULL);
   char *res = vconcat (temppath, v);
   free (temppath);
   return res;
@@ -510,6 +541,9 @@ cygpath (const char *s, ...)
     read_mounts ();
   va_start (v, s);
   char *path;
+  if (s[0] == '.' && isslash (s[1]))
+    s += 2;
+  
   if (s[0] == '/' || s[1] == ':')	/* FIXME: too crude? */
     path = vconcat (s, v);
   else
@@ -538,10 +572,15 @@ cygpath (const char *s, ...)
     native = strdup (path);
   else if (max_len == (int) strlen (path))
     native = strdup (match->native);
+  else if (isslash (*(path + max_len)))
+    native = concat (match->native, path + max_len, NULL);
   else
     native = concat (match->native, "\\", path + max_len, NULL);
   free (path);
 
+  unconvert_slashes (native);
+  for (char *s = strstr (native + 1, "\\.\\"); s && *s; s = strstr (s, "\\.\\"))
+    memmove (s + 1, s + 3, strlen (s + 3) + 1);
   return native;
 }
 
--- /dev/null	2006-11-30 16:00:00.000000000 -0800
+++ testsuite.cc	2008-03-08 09:35:35.546875000 -0800
@@ -0,0 +1,89 @@
+/* testsuite.cc
+
+   Copyright 2008 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+/* This file implements a driver for performing tests on the file/path
+   translation code in path.cc.  This file is meant to be generic, all
+   test harness data is in testsuite.h.  */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#define WIN32_LEAN_AND_MEAN
+#include <windows.h>
+#define TESTSUITE
+#include "testsuite.h"
+
+typedef struct
+  {
+    const char *cwd;    /* in win32 form, as if by GetCurrentDirectory */
+    const char *posix;  /* input */
+    const char *win32;  /* expected output */
+  } test_t;
+
+#define TESTSUITE_TESTS
+#include "testsuite.h"
+#undef TESTSUITE_TESTS
+
+static int curtest;
+
+/* A replacement for the w32api GetCurrentDirectory() that returns
+   the cwd that the current test specifies.  */
+DWORD
+testsuite_getcwd (DWORD nBufferLength, LPSTR lpBuffer)
+{
+  unsigned len = strlen (testsuite_tests[curtest].cwd) + 1;
+
+  /* If the test specified NO_CWD, then it means we should not have
+     needed the CWD for that test as the test was for an absolute path,
+     and so if we see that here return 0, simulating a
+     GetCurrentDirectory() error.  */
+  if (strcmp (testsuite_tests[curtest].cwd, NO_CWD) == 0)
+    return 0;
+
+  if (nBufferLength >= len)
+    {
+      strcpy (lpBuffer, testsuite_tests[curtest].cwd);
+      return len - 1;
+    }
+  return len;
+}
+
+extern char *cygpath (const char *s, ...);
+
+int
+main (int argc, char **argv)
+{
+  int numpass = 0;
+
+  for (test_t &t = testsuite_tests[curtest]; t.posix; t = testsuite_tests[++curtest])
+    {
+      char *result = cygpath (t.posix, NULL);
+      bool pass = (strcmp (result, t.win32) == 0);
+      
+      if (pass)
+        {
+          numpass++;
+          printf ("test %03d: PASS cwd=%-18s input=%-22s expected+actual=%s\n",
+                  curtest, t.cwd, t.posix, result);
+        }
+      else
+        {
+          printf ("test %03d: FAIL cwd=%-18s input=%-29s expected=%-25s actual=%s\n",
+                  curtest, t.cwd, t.posix, t.win32, result);
+        }
+    }
+  printf ("\n"
+          "total tests: %d\n"
+          "pass       : %d (%.1f%%)\n"
+          "fail       : %d (%.1f%%)\n",
+          curtest, numpass, ((float)numpass)/curtest * 100.0F, curtest - numpass,
+          ((float)curtest - numpass)/curtest * 100.0F);
+  return (numpass < curtest ? 1 : 0);
+}
--- /dev/null	2006-11-30 16:00:00.000000000 -0800
+++ testsuite.h	2008-03-08 10:13:25.406250000 -0800
@@ -0,0 +1,130 @@
+/* testsuite.h
+
+   Copyright 2008 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+/* This file implements a test harness for the MinGW implementation of
+   POSIX path translation in utils/path.cc.  This code is used by strace
+   and cygcheck which cannot depend on the Cygwin DLL.  The tests below
+   are a basic set of sanity checks for translating relative and
+   absolute paths from POSIX form to Win32 form based on the contents of
+   a mount table.  */
+
+/* Including this file should be a no-op if TESTSUITE is not defined.  */
+#ifdef TESTSUITE
+
+/* These definitions are common to both the testsuite mount table
+   as well as the testsuite definitions themselves, so define them
+   here so that they are only defined in one location.  */
+#define TESTSUITE_ROOT "X:\\xyzroot"
+#define TESTSUITE_CYGDRIVE "/testcygdrive"
+
+/* Define a mount table in the form that read_mounts() would populate.
+   This is used in place of actually reading the host mount
+   table from the registry for the duration of the testsuite.  This
+   table should match the battery of tests below.  */
+
+#if defined(TESTSUITE_MOUNT_TABLE)
+static mnt_t mount_table[] = {
+/* native                 posix               flags                        issys */
+ { TESTSUITE_ROOT,        (char*)"/",                MOUNT_BINARY | MOUNT_SYSTEM, 1 },
+ { "O:\\other",           (char*)"/otherdir",        MOUNT_BINARY | MOUNT_SYSTEM, 1 },
+ { "S:\\some\\dir",       (char*)"/somedir",         MOUNT_BINARY | MOUNT_SYSTEM, 1 },
+ { TESTSUITE_ROOT"\\bin", (char*)"/usr/bin",         MOUNT_BINARY | MOUNT_SYSTEM, 1 },
+ { TESTSUITE_ROOT"\\lib", (char*)"/usr/lib",         MOUNT_BINARY | MOUNT_SYSTEM, 1 },
+ { ".",                   (char*)TESTSUITE_CYGDRIVE, MOUNT_BINARY | MOUNT_SYSTEM | MOUNT_CYGDRIVE, 1 },
+ { NULL,                  (char*)NULL,               0,                           0 }
+};
+
+
+/* Define the main set of tests.  This is defined here instead of in
+   testsuite.cc so that all test harness data is in one place and not
+   spread over several files.  */
+
+#elif defined(TESTSUITE_TESTS)
+#define NO_CWD "N/A"
+static test_t testsuite_tests[] = {
+ { NO_CWD,                     "/file.ext",              TESTSUITE_ROOT"\\file.ext" },
+ { NO_CWD,                     "/dir/file.ext",          TESTSUITE_ROOT"\\dir\\file.ext" },
+ { NO_CWD,                     "/foo/dir/file.ext",      TESTSUITE_ROOT"\\foo\\dir\\file.ext" },
+ { NO_CWD,                     "/bin/file.ext",          TESTSUITE_ROOT"\\bin\\file.ext" },
+ { NO_CWD,                     "/bin/dir/file.ext",      TESTSUITE_ROOT"\\bin\\dir\\file.ext" },
+ { NO_CWD,                     "/lib/file.ext",          TESTSUITE_ROOT"\\lib\\file.ext" },
+ { NO_CWD,                     "/lib/dir/file.ext",      TESTSUITE_ROOT"\\lib\\dir\\file.ext" },
+ { NO_CWD,                     "/usr/bin/file.ext",      TESTSUITE_ROOT"\\bin\\file.ext" },
+ { NO_CWD,                     "/usr/bin/dir/file.ext",  TESTSUITE_ROOT"\\bin\\dir\\file.ext" },
+ { NO_CWD,                     "/usr/lib/file.ext",      TESTSUITE_ROOT"\\lib\\file.ext" },
+ { NO_CWD,                     "/usr/lib/dir/file.ext",  TESTSUITE_ROOT"\\lib\\dir\\file.ext" },
+ { NO_CWD,                     "/home/file.ext",         TESTSUITE_ROOT"\\home\\file.ext" }, 
+ { NO_CWD,                     "/home/foo/file.ext",     TESTSUITE_ROOT"\\home\\foo\\file.ext" }, 
+ { NO_CWD,                     "/home/foo/dir/file.ext", TESTSUITE_ROOT"\\home\\foo\\dir\\file.ext" }, 
+ { NO_CWD,                     "/usr/file.ext",          TESTSUITE_ROOT"\\usr\\file.ext" }, 
+ { NO_CWD,                     "/usr/share/file.ext",    TESTSUITE_ROOT"\\usr\\share\\file.ext" }, 
+ { TESTSUITE_ROOT,             "foo",                    TESTSUITE_ROOT"\\foo" },
+ { TESTSUITE_ROOT,             "./foo",                  TESTSUITE_ROOT"\\foo" },
+ { TESTSUITE_ROOT,             "foo/bar",                TESTSUITE_ROOT"\\foo\\bar" },
+ { TESTSUITE_ROOT,             "./foo/bar",              TESTSUITE_ROOT"\\foo\\bar" },
+ { TESTSUITE_ROOT,             "foo/./bar",              TESTSUITE_ROOT"\\foo\\bar" },
+ { TESTSUITE_ROOT,             "./foo/./bar",            TESTSUITE_ROOT"\\foo\\bar" },
+ { TESTSUITE_ROOT,             "bin/file.ext",           TESTSUITE_ROOT"\\bin\\file.ext" },
+ { TESTSUITE_ROOT,             "lib/file.ext",           TESTSUITE_ROOT"\\lib\\file.ext" },
+ { TESTSUITE_ROOT,             "usr/bin/file.ext",       TESTSUITE_ROOT"\\bin\\file.ext" },
+ { TESTSUITE_ROOT,             "usr/lib/file.ext",       TESTSUITE_ROOT"\\lib\\file.ext" },
+ { TESTSUITE_ROOT,             "etc/file.ext",           TESTSUITE_ROOT"\\etc\\file.ext" },
+ { TESTSUITE_ROOT,             "etc/foo/file.ext",       TESTSUITE_ROOT"\\etc\\foo\\file.ext" },
+ { TESTSUITE_ROOT"\\bin",      "foo",                    TESTSUITE_ROOT"\\bin\\foo" },
+ { TESTSUITE_ROOT"\\bin",      "./foo",                  TESTSUITE_ROOT"\\bin\\foo" },
+ { TESTSUITE_ROOT"\\bin",      "foo/bar",                TESTSUITE_ROOT"\\bin\\foo\\bar" },
+ { TESTSUITE_ROOT"\\bin",      "./foo/bar",              TESTSUITE_ROOT"\\bin\\foo\\bar" },
+ { TESTSUITE_ROOT"\\bin",      "foo/./bar",              TESTSUITE_ROOT"\\bin\\foo\\bar" },
+ { TESTSUITE_ROOT"\\bin",      "./foo/./bar",            TESTSUITE_ROOT"\\bin\\foo\\bar" },
+ { TESTSUITE_ROOT"\\bin\\foo", "bar",                    TESTSUITE_ROOT"\\bin\\foo\\bar" },
+ { TESTSUITE_ROOT"\\bin\\foo", "./bar",                  TESTSUITE_ROOT"\\bin\\foo\\bar" },
+ { TESTSUITE_ROOT"\\bin\\foo", "bar/baz",                TESTSUITE_ROOT"\\bin\\foo\\bar\\baz" },
+ { TESTSUITE_ROOT"\\bin\\foo", "./bar/baz",              TESTSUITE_ROOT"\\bin\\foo\\bar\\baz" },
+ { TESTSUITE_ROOT"\\bin\\foo", "bar/./baz",              TESTSUITE_ROOT"\\bin\\foo\\bar\\baz" },
+ { TESTSUITE_ROOT"\\bin\\foo", "./bar/./baz",            TESTSUITE_ROOT"\\bin\\foo\\bar\\baz" },
+ { TESTSUITE_ROOT"\\tmp",      "foo",                    TESTSUITE_ROOT"\\tmp\\foo" },
+ { TESTSUITE_ROOT"\\tmp",      "./foo",                  TESTSUITE_ROOT"\\tmp\\foo" },
+ { TESTSUITE_ROOT"\\tmp",      "foo/bar",                TESTSUITE_ROOT"\\tmp\\foo\\bar" },
+ { TESTSUITE_ROOT"\\tmp",      "./foo/bar",              TESTSUITE_ROOT"\\tmp\\foo\\bar" },
+ { NO_CWD,                     "/otherdir/file.ext",     "O:\\other\\file.ext" },
+ { NO_CWD,                     "/otherdir/./file.ext",   "O:\\other\\file.ext" },
+ { NO_CWD,                     "/otherdir/foo/file.ext", "O:\\other\\foo\\file.ext" },
+ { "O:\\other",                "file.ext",               "O:\\other\\file.ext" },
+ { "O:\\other",                "./file.ext",             "O:\\other\\file.ext" },
+ { "O:\\other",                "foo/file.ext",           "O:\\other\\foo\\file.ext" },
+ { "O:\\other\\foo",           "file.ext",               "O:\\other\\foo\\file.ext" },
+ { "O:\\other\\foo",           "./file.ext",             "O:\\other\\foo\\file.ext" },
+ { "O:\\other\\foo",           "bar/file.ext",           "O:\\other\\foo\\bar\\file.ext" },
+ { NO_CWD,                     "/somedir/file.ext",      "S:\\some\\dir\\file.ext" },
+ { NO_CWD,                     "/somedir/./file.ext",    "S:\\some\\dir\\file.ext" },
+ { NO_CWD,                     "/somedir/foo/file.ext",  "S:\\some\\dir\\foo\\file.ext" },
+ { "S:\\some\\dir",            "file.ext",               "S:\\some\\dir\\file.ext" },
+ { "S:\\some\\dir",            "./file.ext",             "S:\\some\\dir\\file.ext" },
+ { "S:\\some\\dir",            "foo/file.ext",           "S:\\some\\dir\\foo\\file.ext" },
+ { "S:\\some\\dir\\foo",       "file.ext",               "S:\\some\\dir\\foo\\file.ext" },
+ { "S:\\some\\dir\\foo",       "./file.ext",             "S:\\some\\dir\\foo\\file.ext" },
+ { "S:\\some\\dir\\foo",       "bar/file.ext",           "S:\\some\\dir\\foo\\bar\\file.ext" },
+ { NO_CWD,                     NULL,                     NULL }
+};
+
+#else
+
+/* Redirect calls to GetCurrentDirectory() to the testsuite instead.  */
+#ifdef GetCurrentDirectory
+#undef GetCurrentDirectory
+#endif
+#define GetCurrentDirectory testsuite_getcwd
+
+DWORD testsuite_getcwd (DWORD, LPSTR);
+
+#endif
+
+#endif /* TESTSUITE */
+


--------------26A5CB108D89E492E70A09C4
Content-Type: text/plain; charset=us-ascii;
 name="tests.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tests.txt"
Content-length: 6652

test 000: PASS cwd=N/A                input=/file.ext              expected+actual=X:\xyzroot\file.ext
test 001: PASS cwd=N/A                input=/dir/file.ext          expected+actual=X:\xyzroot\dir\file.ext
test 002: PASS cwd=N/A                input=/foo/dir/file.ext      expected+actual=X:\xyzroot\foo\dir\file.ext
test 003: PASS cwd=N/A                input=/bin/file.ext          expected+actual=X:\xyzroot\bin\file.ext
test 004: PASS cwd=N/A                input=/bin/dir/file.ext      expected+actual=X:\xyzroot\bin\dir\file.ext
test 005: PASS cwd=N/A                input=/lib/file.ext          expected+actual=X:\xyzroot\lib\file.ext
test 006: PASS cwd=N/A                input=/lib/dir/file.ext      expected+actual=X:\xyzroot\lib\dir\file.ext
test 007: PASS cwd=N/A                input=/usr/bin/file.ext      expected+actual=X:\xyzroot\bin\file.ext
test 008: PASS cwd=N/A                input=/usr/bin/dir/file.ext  expected+actual=X:\xyzroot\bin\dir\file.ext
test 009: PASS cwd=N/A                input=/usr/lib/file.ext      expected+actual=X:\xyzroot\lib\file.ext
test 010: PASS cwd=N/A                input=/usr/lib/dir/file.ext  expected+actual=X:\xyzroot\lib\dir\file.ext
test 011: PASS cwd=N/A                input=/home/file.ext         expected+actual=X:\xyzroot\home\file.ext
test 012: PASS cwd=N/A                input=/home/foo/file.ext     expected+actual=X:\xyzroot\home\foo\file.ext
test 013: PASS cwd=N/A                input=/home/foo/dir/file.ext expected+actual=X:\xyzroot\home\foo\dir\file.ext
test 014: PASS cwd=N/A                input=/usr/file.ext          expected+actual=X:\xyzroot\usr\file.ext
test 015: PASS cwd=N/A                input=/usr/share/file.ext    expected+actual=X:\xyzroot\usr\share\file.ext
test 016: PASS cwd=X:\xyzroot         input=foo                    expected+actual=X:\xyzroot\foo
test 017: PASS cwd=X:\xyzroot         input=./foo                  expected+actual=X:\xyzroot\foo
test 018: PASS cwd=X:\xyzroot         input=foo/bar                expected+actual=X:\xyzroot\foo\bar
test 019: PASS cwd=X:\xyzroot         input=./foo/bar              expected+actual=X:\xyzroot\foo\bar
test 020: PASS cwd=X:\xyzroot         input=foo/./bar              expected+actual=X:\xyzroot\foo\bar
test 021: PASS cwd=X:\xyzroot         input=./foo/./bar            expected+actual=X:\xyzroot\foo\bar
test 022: PASS cwd=X:\xyzroot         input=bin/file.ext           expected+actual=X:\xyzroot\bin\file.ext
test 023: PASS cwd=X:\xyzroot         input=lib/file.ext           expected+actual=X:\xyzroot\lib\file.ext
test 024: PASS cwd=X:\xyzroot         input=usr/bin/file.ext       expected+actual=X:\xyzroot\bin\file.ext
test 025: PASS cwd=X:\xyzroot         input=usr/lib/file.ext       expected+actual=X:\xyzroot\lib\file.ext
test 026: PASS cwd=X:\xyzroot         input=etc/file.ext           expected+actual=X:\xyzroot\etc\file.ext
test 027: PASS cwd=X:\xyzroot         input=etc/foo/file.ext       expected+actual=X:\xyzroot\etc\foo\file.ext
test 028: PASS cwd=X:\xyzroot\bin     input=foo                    expected+actual=X:\xyzroot\bin\foo
test 029: PASS cwd=X:\xyzroot\bin     input=./foo                  expected+actual=X:\xyzroot\bin\foo
test 030: PASS cwd=X:\xyzroot\bin     input=foo/bar                expected+actual=X:\xyzroot\bin\foo\bar
test 031: PASS cwd=X:\xyzroot\bin     input=./foo/bar              expected+actual=X:\xyzroot\bin\foo\bar
test 032: PASS cwd=X:\xyzroot\bin     input=foo/./bar              expected+actual=X:\xyzroot\bin\foo\bar
test 033: PASS cwd=X:\xyzroot\bin     input=./foo/./bar            expected+actual=X:\xyzroot\bin\foo\bar
test 034: PASS cwd=X:\xyzroot\bin\foo input=bar                    expected+actual=X:\xyzroot\bin\foo\bar
test 035: PASS cwd=X:\xyzroot\bin\foo input=./bar                  expected+actual=X:\xyzroot\bin\foo\bar
test 036: PASS cwd=X:\xyzroot\bin\foo input=bar/baz                expected+actual=X:\xyzroot\bin\foo\bar\baz
test 037: PASS cwd=X:\xyzroot\bin\foo input=./bar/baz              expected+actual=X:\xyzroot\bin\foo\bar\baz
test 038: PASS cwd=X:\xyzroot\bin\foo input=bar/./baz              expected+actual=X:\xyzroot\bin\foo\bar\baz
test 039: PASS cwd=X:\xyzroot\bin\foo input=./bar/./baz            expected+actual=X:\xyzroot\bin\foo\bar\baz
test 040: PASS cwd=X:\xyzroot\tmp     input=foo                    expected+actual=X:\xyzroot\tmp\foo
test 041: PASS cwd=X:\xyzroot\tmp     input=./foo                  expected+actual=X:\xyzroot\tmp\foo
test 042: PASS cwd=X:\xyzroot\tmp     input=foo/bar                expected+actual=X:\xyzroot\tmp\foo\bar
test 043: PASS cwd=X:\xyzroot\tmp     input=./foo/bar              expected+actual=X:\xyzroot\tmp\foo\bar
test 044: PASS cwd=N/A                input=/otherdir/file.ext     expected+actual=O:\other\file.ext
test 045: PASS cwd=N/A                input=/otherdir/./file.ext   expected+actual=O:\other\file.ext
test 046: PASS cwd=N/A                input=/otherdir/foo/file.ext expected+actual=O:\other\foo\file.ext
test 047: PASS cwd=O:\other           input=file.ext               expected+actual=O:\other\file.ext
test 048: PASS cwd=O:\other           input=./file.ext             expected+actual=O:\other\file.ext
test 049: PASS cwd=O:\other           input=foo/file.ext           expected+actual=O:\other\foo\file.ext
test 050: PASS cwd=O:\other\foo       input=file.ext               expected+actual=O:\other\foo\file.ext
test 051: PASS cwd=O:\other\foo       input=./file.ext             expected+actual=O:\other\foo\file.ext
test 052: PASS cwd=O:\other\foo       input=bar/file.ext           expected+actual=O:\other\foo\bar\file.ext
test 053: PASS cwd=N/A                input=/somedir/file.ext      expected+actual=S:\some\dir\file.ext
test 054: PASS cwd=N/A                input=/somedir/./file.ext    expected+actual=S:\some\dir\file.ext
test 055: PASS cwd=N/A                input=/somedir/foo/file.ext  expected+actual=S:\some\dir\foo\file.ext
test 056: PASS cwd=S:\some\dir        input=file.ext               expected+actual=S:\some\dir\file.ext
test 057: PASS cwd=S:\some\dir        input=./file.ext             expected+actual=S:\some\dir\file.ext
test 058: PASS cwd=S:\some\dir        input=foo/file.ext           expected+actual=S:\some\dir\foo\file.ext
test 059: PASS cwd=S:\some\dir\foo    input=file.ext               expected+actual=S:\some\dir\foo\file.ext
test 060: PASS cwd=S:\some\dir\foo    input=./file.ext             expected+actual=S:\some\dir\foo\file.ext
test 061: PASS cwd=S:\some\dir\foo    input=bar/file.ext           expected+actual=S:\some\dir\foo\bar\file.ext

total tests: 62
pass       : 62 (100.0%)
fail       : 0 (0.0%)

--------------26A5CB108D89E492E70A09C4--

