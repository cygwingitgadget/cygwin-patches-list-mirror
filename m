Return-Path: <cygwin-patches-return-6259-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1121 invoked by alias); 9 Mar 2008 03:25:04 -0000
Received: (qmail 1097 invoked by uid 22791); 9 Mar 2008 03:25:02 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-250.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.250)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 03:24:39 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id C3CEE660000; Sat,  8 Mar 2008 22:24:37 -0500 (EST)
Date: Sun, 09 Mar 2008 03:25:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] utils/path.cc fixes and testsuite
Message-ID: <20080309032437.GB6777@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D3550B.76D34355@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00033.txt.bz2

On Sat, Mar 08, 2008 at 07:10:03PM -0800, Brian Dessent wrote:
>Christopher Faylor wrote:
>
>> Would it be possible to uncollapse this if block and make it a little
>> clearer?  The "else" nine lines away makes it a little hard to follow.
>> So, wouldn't just inverting the "if (match)" to "if (!match)" and
>> putting the else condition cause some unnesting?
>
>Here's a v2 patch.  Changes:
>
>- As suggested I used path[max_len] instead of *(path + max_len).  I had
>done it that way originally to try to make it clear that I was looking
>at what the first chararacter of the "path + max_len" argument to
>concat, but I now agree it's kind of unidiomatic C.
>
>- Rearranged the if/else block, and added a comment for the logic of
>each branch.
>
>- Added a test for UNC paths.
>
>- Minor tweak on the Makefile rule that symlinks the source file to
>another name to prevent it from running every time.  In general I'm not
>all that crazy with this idea of symlinking a file in order to compile
>it to a differently-named object, but doing it otherwise would require
>repeating the compile rule with all its ugly VERBOSE casing and I just
>went to the trouble to eliminate all such repetition in the Makefile.
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
> path.cc      |   71 +++++++++++++++++++++++++++----
> testsuite.cc |   89 ++++++++++++++++++++++++++++++++++++++++
> testsuite.h  |  131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 298 insertions(+), 12 deletions(-)
>
>Index: Makefile.in
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
>retrieving revision 1.69
>diff -u -p -r1.69 Makefile.in
>--- Makefile.in	8 Mar 2008 17:52:49 -0000	1.69
>+++ Makefile.in	9 Mar 2008 03:01:17 -0000
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
>+path-testsuite.cc: path.cc ; @test -L $@ || ln -sf ${filter %.cc,$^} $@
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
>+++ path.cc	9 Mar 2008 03:01:17 -0000
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
>@@ -487,13 +511,34 @@ rel_vconcat (const char *s, va_list v)
>       match = m;
>     }
> 
>-  if (match)
>-    strcpy (path, match->posix);
>+  char *temppath;
>+  if (!match)
> 
>-  if (!isslash (strchr (path, '\0')[-1]))
>-    strcat (path, "/");
>+    /* No prefix matched - make a best effort to return something
>+       meaningful anyway.  */
>+    temppath = concat (path, "/", s, NULL);
>+  else if (strcmp (match->posix, "/") == 0)
                                        !=
>+
>+    /* Matched on the prefix of the posix root.  This requires special
>+       casing to avoid returning a result with double-slashes.  */
>+    if (path[max_len] == '\0')
>+
>+      /* No more 'path' left after the match, so we are in the root.  */
>+      temppath = concat ("/", s, NULL);
>+    else
>+
>+      /* Only add a leading slash if the remaining part of 'path'
>+         doesn't already start with one.  */
>+      if (isslash (path[max_len]))
>+        temppath = concat (path + max_len, "/", s, NULL);
>+      else
>+        temppath = concat ("/", path + max_len, "/", s, NULL);
>+  else
>+
>+    /* Normal non-root case: copy the posix prefix that we matched, plus
>+       the remaining part of the non-matching 'path'.  */
>+    temppath = concat (match->posix, path + max_len, "/", s, NULL);

It looks like yo can still unindent this by  changing the == to !=, putting
the temppath under that and keeping all of the if's at the same level:

  if (!match)
    temppath = concat (path, "/", s, NULL);
  else if (strcmp (match->posix, "/") != 0)
    temppath = concat (match->posix, path + max_len, "/", s, NULL);
  else if (path[max_len] == '\0')
    temppath = concat ("/", s, NULL);
  else if (isslash (path[max_len]))
    temppath = concat (path + max_len, "/", s, NULL);
  else
    temppath = concat ("/", path + max_len, "/", s, NULL);

If the if block is that small, then I think I'd prefer just one comment
at the beginning which describes what it is doing.  Otherwise, I got
lost in what was happening while trying to see where the comments line
up.  I don't feel really strongly about that, though, so feel free to
ignore me.  I would prefer not having the nested if's though.

Otherwise, this looks good.  If you make the above suggestions, feel
free to check this in.

cgf
