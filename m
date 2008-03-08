Return-Path: <cygwin-patches-return-6257-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30323 invoked by alias); 8 Mar 2008 21:27:44 -0000
Received: (qmail 30309 invoked by uid 22791); 8 Mar 2008 21:27:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 08 Mar 2008 21:27:20 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 66B566D2A3; Sat,  8 Mar 2008 16:27:18 -0500 (EST)
Date: Sat, 08 Mar 2008 21:27:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] utils/path.cc fixes and testsuite
Message-ID: <20080308212718.GB5863@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D2E28C.3FC392D3@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00031.txt.bz2

On Sat, Mar 08, 2008 at 11:01:32AM -0800, Brian Dessent wrote:
>
>The winsup/utils/path.cc file implements a primative POSIX->Win32 path
>conversion API that is independant of the real one in Cygwin.  This is
>used by cygcheck as well as strace (for opening the -o parameter). 
>Currently this code has bitrotted a bit, and its handling of relative
>paths seems to be a little awkward.  Examples of how it's broken:
>
>"strace -o foo.out cmd" will place foo.out file in / (or some other
>strange location, usually the root of whatever prefix of the mount table
>matched CWD) instead of the CWD.
>
>"cd /bin && cygcheck ls" reports "Error: could not find ls", but "cd
>/bin && cygcheck ./ls" does work.
>
>"cd / && cygcheck usr/bin/ls" reports "usr/bin/ls - Cannot open" but "cd
>/ && cygcheck bin/ls" works.
>
>"cp /bin/ls /tmp && cd / && cygcheck tmp/ls" reports "tmp/ls - Cannot
>open".
>
>Anyway, I took a look at fixing this so that the path.cc code is a
>little more robust.  But as I'm sure you're aware, messing with path
>conversion code is really annoying when you factor in all sorts of weird
>corner cases, so I decided to make a testsuite for this code so that it
>would be possible to both cure the bitrot as well as know if it has
>regressed again.  That attached patch does both.
>
>The harness that I came up with consists of simply a header
>(testsuite.h) which contains definitions for both a toy mount table as
>well as a series of {CWD,POSIX input,expected Win32 output} tuples that
>form the tests.  The driver is testsuite.c, and it works by recompiling
>path.cc with -DTESTSUITE to activate the hooks.  It's pretty simplistic,
>but it has allowed me to fix a number of corner cases in the code such
>that all of the above mentioned oddities are now gone.  In order to make
>the testsuite pass I also had to add a little bit of normalization code
>so that e.g. the Win32 output always uses backslashes and that it
>doesn't leave repeated slashes between parts, e.g. foo\\/bar.  For the
>sample mount table I tried to emulate what a real mount table is
>typically like, with a couple additional mounts.
>
>The Makefile changes to support this are pretty straightforward: nothing
>changes for the default "make all" case.  If you run "make check" it
>builds the required files and runs the testsuite.  I've attached a
>sample output.
>
>Brian
>2008-03-08  Brian Dessent  <brian@dessent.net>
>
>	* Makefile.in: Add a 'check' target that builds and runs
>	testsuite.exe from path-testsuite.o and testsuite.o.
>	* path.cc: Include testsuite.h.
>	(struct mnt): Change to a mnt_t typedef and don't define
>	mount_table when TESTSUITE is defined.
>	(find2): Don't include when TESTSUITE is defined to avoid warning.
>	(get_cygdrive0): Ditto.
>	(get_cygdrive): Ditto.
>	(read_mounts): Provide empty implementation when TESTSUITE is
>	defined.
>	(vconcat): Use the isslash macro.
>	(unconvert_slashes): New helper to convert to backslashses.
>	(rel_vconcat): Handle relative paths more gracefully.
>	(cygpath): Skip a leading "./" sequence.  Avoid double-slashes.
>	Normalize final output to backslashes and remove redundant path
>	sequences.
>	* testsuite.cc: New file implementing testsuite driver.
>	* testsuite.h: New header implementing harness mount table and
>	series of tests.
>
> Makefile.in  |   19 +++++++-
> path.cc      |   57 +++++++++++++++++++++----
> testsuite.cc |   89 ++++++++++++++++++++++++++++++++++++++++
> testsuite.h  |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 283 insertions(+), 12 deletions(-)
>
>Index: Makefile.in
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
>retrieving revision 1.69
>diff -u -p -r1.69 Makefile.in
>--- Makefile.in	8 Mar 2008 17:52:49 -0000	1.69
>+++ Makefile.in	8 Mar 2008 18:11:10 -0000
>@@ -99,10 +99,23 @@ else
> all: warn_cygcheck_zlib
> endif
> 
>-# the rest of this file contains generic rules
>-
> all: Makefile $(CYGWIN_BINS) $(MINGW_BINS)
> 
>+# test harness support (note: the "MINGW_BINS +=" should come after the
>+# "all:" above so that the testsuite is not run for "make" but only
>+# "make check".)
>+MINGW_BINS += testsuite.exe
>+MINGW_OBJS += path-testsuite.o testsuite.o
>+testsuite.exe: path-testsuite.o
>+path-testsuite.cc: path.cc ; ln -sf ${filter %.cc,$^} $@
>+path-testsuite.o: MINGW_CXXFLAGS += -DTESTSUITE
>+# this is necessary because this .c lives in the build dir instead of src
>+path-testsuite.o: MINGW_CXX := ${patsubst -I.,-I$(utils_source),$(MINGW_CXX)}
>+path-testsuite.cc path.cc testsuite.cc: testsuite.h
>+check: testsuite.exe ; $(<D)/$(<F)
>+
>+# the rest of this file contains generic rules
>+
> # how to compile a MinGW object
> $(MINGW_OBJS): %.o: %.cc
> ifdef VERBOSE
>@@ -137,7 +150,7 @@ $(MINGW_BINS): $(MINGW_DEP_LDLIBS)
> $(CYGWIN_BINS): $(ALL_DEP_LDLIBS)
> 
> clean:
>-	rm -f *.o $(CYGWIN_BINS) $(MINGW_BINS)
>+	rm -f *.o $(CYGWIN_BINS) $(MINGW_BINS) path-testsuite.cc testsuite.exe
> 
> realclean: clean
> 	rm -f Makefile config.cache
>Index: path.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/path.cc,v
>retrieving revision 1.12
>diff -u -p -r1.12 path.cc
>--- path.cc	4 Jun 2007 01:57:16 -0000	1.12
>+++ path.cc	8 Mar 2008 18:11:10 -0000
>@@ -1,6 +1,6 @@
> /* path.cc
> 
>-   Copyright 2001, 2002, 2003, 2005, 2006, 2007 Red Hat, Inc.
>+   Copyright 2001, 2002, 2003, 2005, 2006, 2007, 2008 Red Hat, Inc.
> 
> This file is part of Cygwin.
> 
>@@ -22,6 +22,7 @@ details. */
> #include "cygwin/include/cygwin/version.h"
> #include "cygwin/include/sys/mount.h"
> #include "cygwin/include/mntent.h"
>+#include "testsuite.h"
> 
> /* Used when treating / and \ as equivalent. */
> #define isslash(ch) \
>@@ -227,16 +228,27 @@ readlink (HANDLE fh, char *path, int max
>   return true;
> }
> 
>-static struct mnt
>+typedef struct mnt
>   {
>     const char *native;
>     char *posix;
>     unsigned flags;
>     int issys;
>-  } mount_table[255];
>+  } mnt_t;
>+
>+#ifndef TESTSUITE
>+static mnt_t mount_table[255];
>+#else
>+#  define TESTSUITE_MOUNT_TABLE
>+#  include "testsuite.h"
>+#  undef TESTSUITE_MOUNT_TABLE
>+#endif
> 
> struct mnt *root_here = NULL;
> 
>+/* These functions aren't called when defined(TESTSUITE) which results
>+   in a compiler warning.  */
>+#ifndef TESTSUITE
> static char *
> find2 (HKEY rkey, unsigned *flags, char *what)
> {
>@@ -288,10 +300,14 @@ get_cygdrive (HKEY key, mnt *m, int issy
>   m->issys = issystem;
>   return m + 1;
> }
>+#endif
> 
> static void
> read_mounts ()
> {
>+/* If TESTSUITE is defined, bypass this whole function as a harness
>+   mount table will be provided.  */
>+#ifndef TESTSUITE
>   DWORD posix_path_size;
>   int res;
>   struct mnt *m = mount_table;
>@@ -358,6 +374,7 @@ read_mounts ()
> 	}
>       RegCloseKey (key);
>     }
>+#endif /* !defined(TESTSUITE) */
> }
> 
> /* Return non-zero if PATH1 is a prefix of PATH2.
>@@ -439,7 +456,7 @@ vconcat (const char *s, va_list v)
> 	  *d++ = *++p;
> 	  *d++ = *++p;
> 	}
>-      else if (*p == '/' || *p == '\\')
>+      else if (isslash (*p))
> 	{
> 	  if (p == rv && unc)
> 	    *d++ = *p++;
>@@ -462,6 +479,13 @@ concat (const char *s, ...)
>   return vconcat (s, v);
> }
> 
>+static void
>+unconvert_slashes (char* name)
>+{
>+  while ((name = strchr (name, '/')) != NULL)
>+    *name++ = '\\';
>+}
>+
> static char *
> rel_vconcat (const char *s, va_list v)
> {
>@@ -487,13 +511,20 @@ rel_vconcat (const char *s, va_list v)
>       match = m;
>     }
> 
>+  char *temppath;
>   if (match)
>-    strcpy (path, match->posix);
>-
>-  if (!isslash (strchr (path, '\0')[-1]))
>-    strcat (path, "/");
>+    if (strcmp (match->posix, "/") == 0)
>+      if (*(path + max_len) == 0)
Isn't the above more clearly and consistently written as:

        if (path[maxlen] == '\0')

>+        temppath = concat ("/", s, NULL);
>+      else if (isslash (*(path + max_len)))
             Ditto.

>+        temppath = concat (path + max_len, "/", s, NULL);
>+      else
>+        temppath = concat ("/", path + max_len, "/", s, NULL);
>+    else
>+      temppath = concat (match->posix, path + max_len, "/", s, NULL);    
>+  else
>+    temppath = concat (path, "/", s, NULL);

Would it be possible to uncollapse this if block and make it a little
clearer?  The "else" nine lines away makes it a little hard to follow.
So, wouldn't just inverting the "if (match)" to "if (!match)" and
putting the else condition cause some unnesting?

 
>-  char *temppath = concat (path, s, NULL);
>   char *res = vconcat (temppath, v);
>   free (temppath);
>   return res;
>@@ -510,6 +541,9 @@ cygpath (const char *s, ...)
>     read_mounts ();
>   va_start (v, s);
>   char *path;
>+  if (s[0] == '.' && isslash (s[1]))
>+    s += 2;
>+  
>   if (s[0] == '/' || s[1] == ':')	/* FIXME: too crude? */
>     path = vconcat (s, v);
>   else
>@@ -538,10 +572,15 @@ cygpath (const char *s, ...)
>     native = strdup (path);
>   else if (max_len == (int) strlen (path))
>     native = strdup (match->native);
>+  else if (isslash (*(path + max_len)))
                       Ditto

Other than these nits, I applaud your efforts for taking this on.  I
thought I'd fixed the relative path problems when I looked at this nine
months ago but obviously I didn't.  The test suite will help a lot.

cgf
