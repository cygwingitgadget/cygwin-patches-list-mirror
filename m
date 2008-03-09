Return-Path: <cygwin-patches-return-6258-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31041 invoked by alias); 9 Mar 2008 03:10:37 -0000
Received: (qmail 31027 invoked by uid 22791); 9 Mar 2008 03:10:34 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 03:10:04 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JYBvG-0003EK-1N 	for cygwin-patches@cygwin.com; Sun, 09 Mar 2008 03:10:02 +0000
Message-ID: <47D3550B.76D34355@dessent.net>
Date: Sun, 09 Mar 2008 03:10:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] utils/path.cc fixes and testsuite
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------90BD5B8FFED2A62A24560A6C"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00032.txt.bz2

This is a multi-part message in MIME format.
--------------90BD5B8FFED2A62A24560A6C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1128

Christopher Faylor wrote:

> Would it be possible to uncollapse this if block and make it a little
> clearer?  The "else" nine lines away makes it a little hard to follow.
> So, wouldn't just inverting the "if (match)" to "if (!match)" and
> putting the else condition cause some unnesting?

Here's a v2 patch.  Changes:

- As suggested I used path[max_len] instead of *(path + max_len).  I had
done it that way originally to try to make it clear that I was looking
at what the first chararacter of the "path + max_len" argument to
concat, but I now agree it's kind of unidiomatic C.

- Rearranged the if/else block, and added a comment for the logic of
each branch.

- Added a test for UNC paths.

- Minor tweak on the Makefile rule that symlinks the source file to
another name to prevent it from running every time.  In general I'm not
all that crazy with this idea of symlinking a file in order to compile
it to a differently-named object, but doing it otherwise would require
repeating the compile rule with all its ugly VERBOSE casing and I just
went to the trouble to eliminate all such repetition in the Makefile.

Brian
--------------90BD5B8FFED2A62A24560A6C
Content-Type: text/plain; charset=us-ascii;
 name="utils_path_bugfix_testsuite_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="utils_path_bugfix_testsuite_2.patch"
Content-length: 18574

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
 path.cc      |   71 +++++++++++++++++++++++++++----
 testsuite.cc |   89 ++++++++++++++++++++++++++++++++++++++++
 testsuite.h  |  131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 298 insertions(+), 12 deletions(-)

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.69
diff -u -p -r1.69 Makefile.in
--- Makefile.in	8 Mar 2008 17:52:49 -0000	1.69
+++ Makefile.in	9 Mar 2008 03:01:17 -0000
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
+path-testsuite.cc: path.cc ; @test -L $@ || ln -sf ${filter %.cc,$^} $@
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
+++ path.cc	9 Mar 2008 03:01:17 -0000
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
@@ -487,13 +511,34 @@ rel_vconcat (const char *s, va_list v)
       match = m;
     }
 
-  if (match)
-    strcpy (path, match->posix);
+  char *temppath;
+  if (!match)
 
-  if (!isslash (strchr (path, '\0')[-1]))
-    strcat (path, "/");
+    /* No prefix matched - make a best effort to return something
+       meaningful anyway.  */
+    temppath = concat (path, "/", s, NULL);
+  else if (strcmp (match->posix, "/") == 0)
+
+    /* Matched on the prefix of the posix root.  This requires special
+       casing to avoid returning a result with double-slashes.  */
+    if (path[max_len] == '\0')
+
+      /* No more 'path' left after the match, so we are in the root.  */
+      temppath = concat ("/", s, NULL);
+    else
+
+      /* Only add a leading slash if the remaining part of 'path'
+         doesn't already start with one.  */
+      if (isslash (path[max_len]))
+        temppath = concat (path + max_len, "/", s, NULL);
+      else
+        temppath = concat ("/", path + max_len, "/", s, NULL);
+  else
+
+    /* Normal non-root case: copy the posix prefix that we matched, plus
+       the remaining part of the non-matching 'path'.  */
+    temppath = concat (match->posix, path + max_len, "/", s, NULL);
 
-  char *temppath = concat (path, s, NULL);
   char *res = vconcat (temppath, v);
   free (temppath);
   return res;
@@ -510,6 +555,9 @@ cygpath (const char *s, ...)
     read_mounts ();
   va_start (v, s);
   char *path;
+  if (s[0] == '.' && isslash (s[1]))
+    s += 2;
+
   if (s[0] == '/' || s[1] == ':')	/* FIXME: too crude? */
     path = vconcat (s, v);
   else
@@ -538,10 +586,15 @@ cygpath (const char *s, ...)
     native = strdup (path);
   else if (max_len == (int) strlen (path))
     native = strdup (match->native);
+  else if (isslash (path[max_len]))
+    native = concat (match->native, path + max_len, NULL);
   else
     native = concat (match->native, "\\", path + max_len, NULL);
   free (path);
 
+  unconvert_slashes (native);
+  for (char *s = strstr (native + 1, "\\.\\"); s && *s; s = strstr (s, "\\.\\"))
+    memmove (s + 1, s + 3, strlen (s + 3) + 1);
   return native;
 }
 
Index: testsuite.cc
===================================================================
RCS file: testsuite.cc
diff -N testsuite.cc
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ testsuite.cc	9 Mar 2008 03:01:17 -0000
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
Index: testsuite.h
===================================================================
RCS file: testsuite.h
diff -N testsuite.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ testsuite.h	9 Mar 2008 03:01:17 -0000
@@ -0,0 +1,131 @@
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
+ { NO_CWD,                     "//server/share/foo/bar", "\\\\server\\share\\foo\\bar" },
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

--------------90BD5B8FFED2A62A24560A6C--
