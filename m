Return-Path: <cygwin-patches-return-7770-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13453 invoked by alias); 12 Nov 2012 20:02:54 -0000
Received: (qmail 13436 invoked by uid 22791); 12 Nov 2012 20:02:52 -0000
X-SWARE-Spam-Status: No, hits=-0.2 required=5.0	tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_DB,TW_FD,TW_FN,TW_MK,TW_XD,TW_YG
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 12 Nov 2012 20:02:25 +0000
Received: from pool-98-110-183-145.bstnma.fios.verizon.net ([98.110.183.145] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TY0D9-000EEO-RB	for cygwin-patches@cygwin.com; Mon, 12 Nov 2012 20:02:23 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 1212F13C0C7	for <cygwin-patches@cygwin.com>; Mon, 12 Nov 2012 15:02:23 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18XH7WwNq03J0Ia54lcGDtx
Date: Mon, 12 Nov 2012 20:02:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121112200223.GA16672@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00047.txt.bz2


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 4091

I decided over the weekend to port over configury changes that I made to
Cygwin's now-out-of-date GIT repository.

These changes basically just cleaned up some of the configure scripts
and made it easier to pinpoint where windows headers and libraries come
from by adding a --with-windows-headers and --with-windows-libs options.
However, some of the assumptions made for the git repository weren't
really valid for the CVS repository so there was a fair amount of work
involved.

I thought that I'd do this so I could easily get up-and-running with the
MinGW64 stuff but I ran into some problems building things with gentoo's
MinGW64 implementation.  So, I switched to using the files from the
Cygwin release.

As I mentioned in cygwin-developers, getting the most recent version of
mingw64 stuff working required making some changes to some Cygwin source
files.  Most of the changes just involved #undef'ing constants defined
in Windows headers.  Still, I was surprised that these hadn't already
been handled since I thought I was behind the times by still using the
Mingw32 stuff.

Anyway, is a summary of the changes I've made to files is below.  I'll
be doing appropriate ChangeLogs too, of course.  I've also attached the
patch.

This is a heads up in case this conflicted materially with any of the
w64 development.

cgf

--- winsup/Makefile.common

Gutted.  Revamped to just include common definitions and macros.

--- winsup/acinclude.m4

Gutted.  Now defines:

AC_WINDOWS_HEADERS
AC_WINDOWS_LIBS
AC_CYGWIN_INCLUDES

--- winsup/configure.cygwin

New file.  Does common stuff for cygwin configure files.

--- **/autogen.sh

New script.  Regenerates configure and aclocal.m4.

--- winsup/ccwrap

New script.  Used to run gcc/g++ using defined cygwin/newlib/windows
locations.

CCWRAP_VERBOSE=1 environment variable shows full expanded path to
compiler command line.

(I wish gcc had a way to say "Don't use this built-in header directory")

--- winsup/c++wrap

C++ front-end to ccwrap - because CVS doesn't like symlinks.

--- **/configure.in

Revamped to use new acinclude.m4 directives and to eliminate cruft.

--- **/Makefile.in

Add .E target to generate macro expanded version of source file.
Eliminate "VERBOSE=" option.  Always print everything.
Revamp to use new configure framework and c*wrap.
Regenerate Makefile if Makefile.in, config.status change.
Use WINDOWS_LIBDIR and WINDOWS_HEADERS to find windows stuff.
Remove unneeded SHELL:= setting.

--- cygwin/Makefile.in

Add the very important datarootdir setting!

Revamp (slightly) CFLAGS/CXXFLAGS settings.  These two things should
really be separate but I've gotten into the habit of saying:

make CFLAGS=-g

to cause things to not be built with optimization.  Handle that case
but otherwise decouple CFLAGS from CXXFLAGS.

Generate tlsoffsets.h in the build directory.

--- cygwin/mkvers.sh

Fix version.h and winver.rc generation to not assume in-tree windows
files.

--- cygwin/winlean.h

#define _WIN32

cygwin/winsup.h

#define _WIN32

--- cygwin/include/netdb.h

#undef a bunch of windows-defined constants.

--- cygwin/include/cygwin/if.h

Use #pragma once

--- cygwin/include/cygwin/in.h

Use #pragma once
Use _IN_PORT_DECLARED to guard against define of in_port_t.

--- cygwin/include/cygwin/in6.h

Use #pragma once
Use _IN_PORT_DECLARED to guard against define of in_port_t.

--- cygwin/include/cygwin/socket.h

#undef a bunch of windows-defined constants.

--- cygwin/include/sys/socket.h

#pragma once

--- cygwin/include/sys/termios.h

#undef FIONBIO before defining it.

--- cygwin/minires-os-if.c

#define __INSIDE_CYGWIN__
#include <sys/time.h>
Delete some #undef's that are now in header files.

--- cygwin/libc/minires.h

#pragma once
#undef some windows-defined constants.

--- utils/Makefile.in

Lots of changes.  Assume that we always have mingw libraries available for cygcheck.
Set CCWRAP variables to control where to find header files for various utilities.

--- utils/dump_setup.cc

Include zlib.h directly.

--- utils/path.cc

#define __CRT__NO_INLINE
to avoid an error from a windows header.

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p
Content-length: 47718

Index: Makefile.common
===================================================================
RCS file: /cvs/uberbaum/winsup/Makefile.common,v
retrieving revision 1.61
diff -u -p -r1.61 Makefile.common
--- Makefile.common	7 Nov 2012 16:32:07 -0000	1.61
+++ Makefile.common	12 Nov 2012 19:53:05 -0000
@@ -8,154 +8,23 @@
 # Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 # details.
 
-# This makefile requires GNU make.
+define justdir
+$(patsubst %/,%,$(dir $1))
+endef
 
-CFLAGS_COMMON:=-Wall -Wstrict-aliasing -Wwrite-strings -fno-common -pipe -fbuiltin -fmessage-length=0 -D_SDKDDKVER_H
-MALLOC_DEBUG:=#-DMALLOC_DEBUG -I/cygnus/src/uberbaum/winsup/cygwin/dlmalloc
-MALLOC_OBJ:=#/cygnus/src/uberbaum/winsup/cygwin/dlmalloc/malloc.o
-
-override srcdir:=${shell cd $(srcdir); pwd}
-ifneq (,${filter-out /%,$(srcdir)})
-    updir:=$(srcdir)/..
-    updir1:=$(updir)/..
-else
-    updir:=${patsubst %:::,%,${patsubst %/:::,%,$(dir $(srcdir)):::}}
-ifneq (,${findstring /,$(updir)})
-    updir1:=${patsubst %:::,%,${patsubst %/:::,%,$(dir $(updir)):::}}
-else
-    updir1:=$(updir)/..
-endif
-endif
-
-pwd:=${shell pwd}
-ifneq "${filter winsup%,${notdir $(pwd)}}" ""
-    here:=${pwd}/cygwin
-else
-    here:=${dir $(pwd)}cygwin
-endif
-bupdir:=${shell cd $(here)/..; pwd}
-ifneq (,${filter-out /%,$(bupdir)})
-    bupdir1:=../..
-    bupdir2:=../../..
-else
-ifneq (,${findstring /,$(bupdir)})
-    bupdir1:=${patsubst %:::,%,${patsubst %/:::,%,$(dir $(bupdir)):::}}
-else
-    bupdir1:=$(bupdir)/..
-endif
-ifneq (,${findstring /,$(bupdir1)})
-    bupdir2:=${patsubst %:::,%,${patsubst %/:::,%,$(dir $(bupdir1)):::}}
-else
-    bupdir2:=$(bupdir1)/..
-endif
-endif
-
-newlib_source:=$(updir1)/newlib
-newlib_build:=$(bupdir1)/newlib
-cygwin_build:=$(bupdir)/cygwin
-cygwin_source:=$(updir)/cygwin
-utils_build:=$(bupdir)/utils
-utils_source:=$(updir)/utils
-ifeq (,${findstring $(newlib_source)/libc/include,$(CFLAGS) $(CXXFLAGS) $(CXX) $(CC)})
-newlib_include:=-I$(newlib_source)/libc/include
-endif
-ifeq (,${findstring $(cygwin_source)/include,$(CFLAGS) $(CXXFLAGS) $(CXX) $(CC)})
-cygwin_include:=-I$(cygwin_source)/include
-endif
-
-nostdincxx:=-nostdinc++
-
-nostdlib:=-nostdlib
-
-ifeq (,${nostdlib})
-nostdinc:=
-endif
-
-INCLUDES:=-I. $(cygwin_include) -I$(cygwin_source) $(newlib_include)
-ifdef CONFIG_DIR
-INCLUDES+=-I$(CONFIG_DIR)
-endif
-
-MINGW_LDFLAGS:=-static
-MINGW_CFLAGS:=
-MINGW_CXXFLAGS:=
-
-GCC_DEFAULT_OPTIONS:=$(CFLAGS_COMMON) $(CFLAGS_CONFIG) $(INCLUDES)
-
-# Link in libc and libm from newlib
-
-LIBC:=$(newlib_build)/libc/libc.a
-LIBM:=$(newlib_build)/libm/libm.a
-CRT0:=$(cygwin_build)/crt0.o
-
-ALL_CFLAGS=$(DEFS) $(MALLOC_DEBUG) $(CFLAGS) $(GCC_DEFAULT_OPTIONS)
-ALL_CXXFLAGS=$(DEFS) $(MALLOC_DEBUG) $(CXXFLAGS) $(GCC_DEFAULT_OPTIONS)
-
-ifndef PREPROCESS
-c=-c
-o=.o
-else
-c=-E -dD
-o=.E
-endif
-
-libgcc:=${subst \,/,${shell $(CC_FOR_TARGET) -print-libgcc-file-name}}
-gcc_libdir:=${word 1,${dir $(libgcc)}}
-ifeq (,${findstring $(gcc_libdir),$(CFLAGS) $(CXXFLAGS) $(CXX) $(CC)})
-GCC_INCLUDE:=${subst //,/,-I$(gcc_libdir)/include}
-endif
-
-COMPILE_CXX=$(CXX) $c $(if $($(*F)_STDINCFLAGS),,$(nostdincxx) $(nostdinc)) \
-	     $(ALL_CXXFLAGS) $(GCC_INCLUDE) -fno-rtti -fno-exceptions
-COMPILE_CC=$(CC) $c $(if $($(*F)_STDINCFLAGS),,$(nostdinc)) $(ALL_CFLAGS) $(GCC_INCLUDE)
-
-vpath %.a	$(cygwin_build):$(newlib_build)/libc:$(newlib_build)/libm
-
-MAKEOVERRIDES_WORKAROUND=${wordlist 2,1,a b c}
-
-ifneq ($(MAKEOVERRIDES_WORKAROUND),)
-    override MAKE:=$(MAKE) $(MAKEOVERRIDES)
-    MAKEOVERRIDES:=
-    export MAKEOVERRIDES
-endif
-
-ifdef RPATH_ENVVAR
-VERBOSE=1
-endif
-
-ifneq "${findstring -B,$(COMPILE_CXX) $(COMPILE_CC)}" ""
-VERBOSE=1
-endif
-
-.PRECIOUS: %.o
-
-%.o: %.cc
-ifdef VERBOSE
-	$(COMPILE_CXX) -o $(@D)/$(*F)$o $<
-else
-	@echo $(CXX) $c $(CXXFLAGS) ... $(*F).cc
-	@$(COMPILE_CXX) -o $(@D)/$(*F)$o $<
-endif
-
-%.o: %.c
-ifdef VERBOSE
-	$(COMPILE_CC) -o $(@D)/$(*F)$o $<
-else
-	@echo $(CC) $c $(CFLAGS) ... $(*F).c
-	@$(COMPILE_CC) -o $(@D)/$(*F)$o $<
-endif
-
-$(bupdir1)/libiberty/%.o: $(updir1)/libiberty/%.c
-	@$(MAKE) -C $(@D) $(@F)
-
-all:
-
-# For auto-rebuilding the Makefile
+define libname
+$(realpath $(shell ${CC} --print-file-name=$1 $2))
+endef
 
-.PRECIOUS: Makefile
+export PATH:=${winsup_srcdir}:${PATH}
 
-Makefile: Makefile.in $(srcdir)/configure.in config.status
-	$(SHELL) config.status
+COMPILE.cc=c++wrap -c ${CXXFLAGS}
+COMPILE.c=ccwrap -c ${CFLAGS}
 
-config.status: configure
-	$(SHELL) config.status --recheck
+top_srcdir:=$(call justdir,${winsup_srcdir})
+top_builddir:=$(call justdir,${target_builddir})
+
+cygwin_build:=${target_builddir}/winsup/cygwin
+newlib_build:=${target_builddir}/newlib
+
+VPATH:=${srcdir}
Index: acinclude.m4
===================================================================
RCS file: /cvs/uberbaum/winsup/acinclude.m4,v
retrieving revision 1.1
diff -u -p -r1.1 acinclude.m4
--- acinclude.m4	24 May 2006 16:59:02 -0000	1.1
+++ acinclude.m4	12 Nov 2012 19:53:05 -0000
@@ -1,43 +1,83 @@
-dnl This provides configure definitions used by all the winsup
+dnl This provides configure definitions used by all the cygwin
 dnl configure.in files.
 
-# FIXME: We temporarily define our own version of AC_PROG_CC.  This is
-# copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
-# are probably using a cross compiler, which will not be able to fully
-# link an executable.  This should really be fixed in autoconf
-# itself.
-
-AC_DEFUN([LIB_AC_PROG_CC_GNU],
-[AC_CACHE_CHECK(whether we are using GNU C, ac_cv_prog_gcc,
-[dnl The semicolon is to pacify NeXT's syntax-checking cpp.
-cat > conftest.c <<EOF
-#ifdef __GNUC__
-  yes;
-#endif
-EOF
-if AC_TRY_COMMAND(${CC-cc} -E conftest.c) | egrep yes >/dev/null 2>&1; then
-  ac_cv_prog_gcc=yes
-else
-  ac_cv_prog_gcc=no
-fi])])
-
-AC_DEFUN([LIB_AC_PROG_CC],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CC, gcc, gcc)
-: ${CC:=gcc}
-AC_PROG_CC
-test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
+AC_DEFUN([AC_WINDOWS_HEADERS],[
+AC_ARG_WITH(
+    [windows-headers],
+    [AS_HELP_STRING([--with-windows-headers=DIR],
+		    [specify where the windows includes are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-windows-headers])]
+)
 ])
 
-AC_DEFUN([LIB_AC_PROG_CXX],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CXX, g++, g++)
-if test -z "$CXX"; then
-  AC_CHECK_TOOL(CXX, g++, c++, , , )
-  : ${CXX:=g++}
-  AC_PROG_CXX
-  test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
+AC_DEFUN([AC_WINDOWS_LIBS],[
+AC_ARG_WITH(
+    [windows-libs],
+    [AS_HELP_STRING([--with-windows-libs=DIR],
+		    [specify where the windows libraries are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-windows-libs])]
+)
+windows_libdir=$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=$(cd $(dirname $($ac_cv_prog_CC -print-file-name=libcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	AC_MSG_ERROR([cannot find windows library files])
+    fi
+fi
+AC_SUBST(windows_libdir)
+]
+)
+
+AC_DEFUN([AC_CYGWIN_INCLUDES], [
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=$CXX}
+: ${ac_cv_prog_CC:=$CC}
+
+cygwin_headers=$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    AC_MSG_ERROR([cannot find $winsup_srcdir/cygwin/include directory])
+fi
+
+newlib_headers=$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null && pwd)
+if test -z "$newlib_headers"; then
+    AC_MSG_ERROR([cannot find newlib source directory: $winsup_srcdir/../newlib/libc/include])
+fi
+newlib_headers="$target_builddir/newlib/targ-include $newlib_headers"
+
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers="$with_windows_headers"
+    else
+	AC_MSG_ERROR([cannot find windef.h in specified --with-windows-headers path: $saw_windows_headers]);
+    fi
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers="$winsup_srcdir/w32api/include"
+else
+    windows_headers=$(cd $($ac_cv_prog_CC -xc /dev/null -E -include windef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	AC_MSG_ERROR([cannot find windows header files])
+    fi
 fi
+CC=$ac_cv_prog_CC
+CXX=$ac_cv_prog_CXX
+export CC
+export CXX
+AC_SUBST(windows_headers)
+AC_SUBST(newlib_headers)
+AC_SUBST(cygwin_headers)
+])
 
-CXXFLAGS='$(CFLAGS)'
+AC_DEFUN([AC_CONFIGURE_ARGS], [
+configure_args=X
+for f in $ac_configure_args; do
+    case "$f" in
+	*--srcdir*) ;;
+	*) configure_args="$configure_args $f" ;;
+    esac
+done
+configure_args=$(/usr/bin/expr "$configure_args" : 'X \(.*\)')
+AC_SUBST(configure_args)
 ])
+
+AC_SUBST(target_builddir)
+AC_SUBST(winsup_srcdir)
Index: autogen.sh
===================================================================
RCS file: autogen.sh
diff -N autogen.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ autogen.sh	12 Nov 2012 19:53:05 -0000
@@ -0,0 +1,17 @@
+#!/bin/sh -e
+if ! /usr/bin/test -e config.guess; then
+    /usr/bin/wget -q -O config.guess 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
+    /bin/chmod a+x config.guess
+fi
+if ! /usr/bin/test -e config.sub; then
+    /usr/bin/wget -q -O config.sub 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
+    /bin/chmod a+x config.sub
+fi
+/usr/bin/aclocal --force
+/usr/bin/autoconf -f
+/bin/rm -rf autom4te.cache
+res=0
+for d in cygwin utils cygserver; do
+    (cd $d && exec ./autogen.sh) || res=1
+done
+exit $res
Index: c++wrap
===================================================================
RCS file: c++wrap
diff -N c++wrap
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ c++wrap	12 Nov 2012 19:53:05 -0000
@@ -0,0 +1,6 @@
+#!/usr/bin/perl
+use strict;
+use File::Basename;
+my $pgm = basename($0);
+(my $wrapper = $pgm) =~ s/\+\+/c/o;
+exec $wrapper, '++', @ARGV;
Index: ccwrap
===================================================================
RCS file: ccwrap
diff -N ccwrap
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ ccwrap	12 Nov 2012 19:53:05 -0000
@@ -0,0 +1,48 @@
+#!/usr/bin/perl
+use Cwd;
+use strict;
+my @compiler = ();
+my $cxx;
+if ($ARGV[0] ne '++') {
+    @compiler = ($ENV{CC} || 'i686-pc-cygwin-gcc');
+    $cxx = 0;
+} else {
+    @compiler = ($ENV{CXX} || 'i686-pc-cygwin-g++');
+    shift @ARGV;
+    $cxx = 1;
+}
+if ("@ARGV" !~ / -nostdinc/o) {
+    my $fd;
+    push @compiler, ($cxx ? '-xc++' : '-xc');
+    if (!open $fd, '-|') {
+	open STDERR, '>&', \*STDOUT;
+	exec @compiler, '/dev/null', '-v', '-E', '-o', '/dev/null' or die "*** error execing $compiler[0] - $!\n";
+    }
+    $compiler[1] =~ s/xc/nostdinc/o;
+    push @compiler, '-nostdinc' if $cxx;
+    push @compiler, '-I' . $_ for split ' ', $ENV{CCWRAP_HEADERS};
+    push @compiler, '-isystem', $_ for split ' ', $ENV{CCWRAP_SYSTEM_HEADERS};
+    push @compiler, '-idirafter', $_ for split ' ', $ENV{CCWRAP_DIRAFTER_HEADERS};
+    my $finding_paths = 0;
+    while (<$fd>) {
+	if (/^\*\*\*/o) {
+	    print;
+	} elsif ($_ eq "#include <...> search starts here:\n") {
+	    $finding_paths = 1;
+	} elsif (!$finding_paths) {
+	    next;
+	} elsif ($_ eq "End of search list.\n") {
+	    last;
+	} elsif (!/mingw|w32api/o) {
+	    chomp;
+	    s/^\s+//;
+	    push @compiler, '-isystem', Cwd::abs_path($_);
+	}
+    }
+    close $fd;
+}
+
+push @compiler, @ARGV;
+
+print join(' ', '+', @compiler), "\n" if $ENV{CCWRAP_VERBOSE};
+exec @compiler or die "$0: $compiler[0] failed to execute\n";
Index: configure.in
===================================================================
RCS file: /cvs/uberbaum/winsup/configure.in,v
retrieving revision 1.35
diff -u -p -r1.35 configure.in
--- configure.in	7 Nov 2012 16:32:07 -0000	1.35
+++ configure.in	12 Nov 2012 19:53:05 -0000
@@ -1,6 +1,6 @@
 dnl Autoconf configure script for Cygwin.
 dnl Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2006,
-dnl 2009 Red Hat, Inc.
+dnl 2009, 2010, 2011, 2012 Red Hat, Inc.
 dnl
 dnl This file is part of Cygwin.
 dnl
@@ -12,30 +12,26 @@ dnl Process this file with autoconf to p
 
 AC_PREREQ(2.59)dnl
 AC_INIT(Makefile.in)
+AC_CONFIG_AUX_DIR(..)
 
-INSTALL=`cd $srcdir/..; echo $(pwd)/install-sh -c`
+. ${srcdir}/configure.cygwin
+
+AC_WINDOWS_HEADERS
+AC_WINDOWS_LIBS
 
 AC_PROG_INSTALL
 AC_CANONICAL_SYSTEM
 
-GCC_NO_EXECUTABLES
-
-LIB_AC_PROG_CC
-LIB_AC_PROG_CXX
-
-AC_LANG_C
+AC_PROG_CC
+AC_PROG_CXX
+AC_PROG_CPP
+AC_LANG(C)
+AC_LANG(C++)
 
-INSTALL_LICENSE=
+AC_CYGWIN_INCLUDES
 
-case "$target" in
-  *cygwin*)
-    if ! test -d $srcdir/cygwin; then
-      AC_MSG_ERROR("No cygwin dir.  Can't build Cygwin.  Exiting...")
-    fi
-    AC_CONFIG_SUBDIRS(cygwin cygserver lsaauth utils doc)
-    INSTALL_LICENSE="install-license"
-    ;;
-esac
+AC_CONFIG_SUBDIRS(cygwin utils cygserver lsaauth doc)
+INSTALL_LICENSE="install-license"
 
 AC_SUBST(INSTALL_LICENSE)
 
Index: cygserver/Makefile.in
===================================================================
RCS file: /cvs/uberbaum/winsup/cygserver/Makefile.in,v
retrieving revision 1.24
diff -u -p -r1.24 Makefile.in
--- cygserver/Makefile.in	16 Nov 2009 08:50:07 -0000	1.24
+++ cygserver/Makefile.in	12 Nov 2012 19:53:05 -0000
@@ -7,10 +7,22 @@
 # Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 # details.
 
-SHELL:=@SHELL@
-
 srcdir:=@srcdir@
-VPATH:=@srcdir@
+target_builddir:=@target_builddir@
+winsup_srcdir:=@winsup_srcdir@
+configure_args=@configure_args@
+
+export CC:=@CC@
+export CXX:=@CXX@
+
+include ${srcdir}/../Makefile.common
+
+cygwin_build:=${target_builddir}/winsup/cygwin
+
+# environment variables used by ccwrap
+export CCWRAP_HEADERS:=$(dir ${srcdir})/cygwin ${cygwin_build}
+export CCWRAP_SYSTEM_HEADERS:=@cygwin_headers@ @newlib_headers@
+export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
 
 DESTDIR=
 prefix:=${DESTDIR}@prefix@
@@ -24,17 +36,13 @@ INSTALL:=@INSTALL@
 INSTALL_PROGRAM:=@INSTALL_PROGRAM@
 INSTALL_DATA:=@INSTALL_DATA@
 
-CC:=@CC@
-CC_FOR_TARGET:=$(CC)
-CXX:=@CXX@
-CXX_FOR_TARGET:=$(CXX)
 AR:=@AR@
 
-include $(srcdir)/../Makefile.common
-
 CFLAGS:=@CFLAGS@
 override CXXFLAGS=@CXXFLAGS@
 override CXXFLAGS+=-MMD -DHAVE_DECL_GETOPT=0 -D__OUTSIDE_CYGWIN__ -DSYSCONFDIR="\"$(sysconfdir)\""
+COMPILE.cc=c++wrap -c ${CXXFLAGS}
+COMPILE.c=ccwrap -c ${CFLAGS}
 
 .SUFFIXES: .c .cc .a .o .d
 
@@ -78,13 +86,26 @@ $(cygwin_build)/%.o: $(cygwin_source)/%.
 	@$(MAKE) -C $(@D) $(@F)
 
 Makefile: Makefile.in configure
+	./config.status
 
 lib%.o: %.cc
-	${filter-out -D__OUTSIDE_CYGWIN__, $(COMPILE_CXX)} -c -I$(updir)/cygwin -I$(bupdir)/cygwin -o $(@D)/${basename $(@F)}$o $<
+	${filter-out -D__OUTSIDE_CYGWIN__, $(COMPILE.cc)} -c -o $(@D)/${basename $(@F)}.o $<
 
 libcygserver.a: $(LIBOBJS)
 	$(AR) crus $@ $?
 
+%.o: %.cc
+	${COMPILE.cc} -c -o $@ $<
+
+%.o: %.c
+	${COMPILE.c} -c -o $@ $<
+
+%.E: %.cc
+	${COMPILE.cc} -E -dD -o $@ $<
+
+%.E: %.c
+	${COMPILE.c} -E -dD -o $@ $<
+
 deps:=${wildcard *.d}
 ifneq (,$(deps))
 include $(deps)
Index: cygserver/autogen.sh
===================================================================
RCS file: cygserver/autogen.sh
diff -N cygserver/autogen.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ cygserver/autogen.sh	12 Nov 2012 19:53:06 -0000
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+/usr/bin/aclocal --acdir=..
+/usr/bin/autoconf -f
+exec /bin/rm -rf autom4te.cache
Index: cygserver/configure.in
===================================================================
RCS file: /cvs/uberbaum/winsup/cygserver/configure.in,v
retrieving revision 1.5
diff -u -p -r1.5 configure.in
--- cygserver/configure.in	7 Feb 2011 16:22:02 -0000	1.5
+++ cygserver/configure.in	12 Nov 2012 19:53:06 -0000
@@ -11,16 +11,23 @@ dnl Process this file with autoconf to p
 
 AC_PREREQ(2.59)dnl
 AC_INIT(cygserver.cc)
+AC_CONFIG_AUX_DIR(..)
 
-AC_CONFIG_AUX_DIR(../..)
+. ${srcdir}/../configure.cygwin
 
-INSTALL=`cd $srcdir/../..; echo $(pwd)/install-sh -c`
+AC_WINDOWS_HEADERS
+AC_WINDOWS_LIBS
 
 AC_PROG_INSTALL
 AC_CANONICAL_SYSTEM
 
-LIB_AC_PROG_CC
-LIB_AC_PROG_CXX
+AC_PROG_CC
+AC_PROG_CXX
+AC_PROG_CPP
+AC_LANG(C)
+AC_LANG(C++)
+
+AC_CYGWIN_INCLUDES
 
 case "$with_cross_host" in
   ""|*cygwin*)
Index: cygwin/Makefile.in
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/Makefile.in,v
retrieving revision 1.258
diff -u -p -r1.258 Makefile.in
--- cygwin/Makefile.in	24 Oct 2012 10:12:45 -0000	1.258
+++ cygwin/Makefile.in	12 Nov 2012 19:53:06 -0000
@@ -1,28 +1,32 @@
 # Makefile.in for Cygwin.
 # Copyright 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
-# 2005, 2006, 2007, 2008, 2009, 2010, 2011 Red Hat, Inc.
+# 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012 Red Hat, Inc.
 #
 # This file is part of Cygwin.
 #
 # This software is a copyrighted work licensed under the terms of the
 # Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 # details.
+# configure_input: @configure_input@
 
 # This makefile requires GNU make.
-#
-# Include common definitions for winsup directory
-# The following assignments are "inputs" to Makefile.common
-#
-CC:=@CC@
-CC_FOR_TARGET:=$(CC)
+
 srcdir:=@srcdir@
-CONFIG_DIR:=$(srcdir)/config/@CONFIG_DIR@
+target_builddir:=@target_builddir@
+winsup_srcdir:=@winsup_srcdir@
+configure_args=@configure_args@
+
+export CC:=@CC@
+export CXX:=@CXX@
+
 include ${srcdir}/../Makefile.common
 
-SHELL:=@SHELL@
-objdir:=.
+# environment variables used by ccwrap
+export CCWRAP_HEADERS:=. ${srcdir}
+export CCWRAP_SYSTEM_HEADERS:=@cygwin_headers@ @newlib_headers@
+export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
 
-VPATH:=$(srcdir):$(CONFIG_DIR):$(srcdir)/regex:$(srcdir)/lib:$(srcdir)/libc
+VPATH+=$(CONFIG_DIR) $(srcdir)/regex $(srcdir)/lib $(srcdir)/libc
 
 target_alias:=@target_alias@
 build_alias:=@build_alias@
@@ -35,6 +39,7 @@ bindir:=@bindir@
 libdir:=@libdir@
 mandir:=@mandir@
 sysconfdir:=@sysconfdir@
+datarootdir:=@datarootdir@
 ifeq ($(target_alias),$(host_alias))
 ifeq ($(build_alias),$(host_alias))
 tooldir:=$(exec_prefix)
@@ -52,17 +57,29 @@ override INSTALL:=@INSTALL@
 override INSTALL_PROGRAM:=@INSTALL_PROGRAM@
 override INSTALL_DATA:=@INSTALL_DATA@
 
+WINDOWS_LIBDIR:=@windows_libdir@
+
+cygserver_blddir:=${target_builddir}/winsup/cygserver
+LIBSERVER:=${cygserver_blddir}/libcygserver.a
+
+LIBC:=$(newlib_build)/libc/libc.a
+LIBM:=$(newlib_build)/libm/libm.a
+CRT0:=$(cygwin_build)/crt0.o
+
 #
 # --enable options from configure
 #
 MT_SAFE:=@MT_SAFE@
 DEFS:=@DEFS@
-CCEXTRA:=
+CCEXTRA=
+COMMON_CFLAGS=-MMD ${$(*F)_CFLAGS} -Werror -fmerge-constants -ftracer $(CCEXTRA)
 CFLAGS?=@CFLAGS@
-override CFLAGS+=-MMD ${$(*F)_CFLAGS} -Werror -fmerge-constants -ftracer \
-  -mno-use-libstdc-wrappers $(CCEXTRA)
-CXX=@CXX@
-override CXXFLAGS=@CXXFLAGS@
+CXXFLAGS?=@CXXFLAGS@
+ifeq "$(filter -O%,${CFLAGS})" ""
+override CXXFLAGS:=$(filter-out -O%,${CXXFLAGS})
+endif
+COMPILE.cc+=${COMMON_CFLAGS} -mno-use-libstdc-wrappers
+COMPILE.c+=${COMMON_CFLAGS}
 
 AR:=@AR@
 AR_FLAGS:=qv
@@ -169,6 +186,13 @@ EXCLUDE_STATIC_OFILES:=$(addprefix --exc
 	spawn.o \
 )
 
+ifdef PREPROCESS
+override DLL_OFILES:=$(patsubst %.o,%_E,${DLL_OFILES})
+override EXCLUDE_STATIC_OFILES:=$(patsubst %.o,%_E,${EXCLUDE_STATIC_OFILES})
+override EXTRA_OFILES=$(patsubst %.o,%_E,${DLL_OFILES}))
+override MALLOC_OFILES:=$(patsubst %.o,%.E,${MALLOC_OFILES})
+endif #PREPROCESS
+
 GMON_OFILES:=gmon.o mcount.o profil.o
 
 NEW_FUNCTIONS:=$(addprefix --replace=,\
@@ -227,7 +251,6 @@ NEW_FUNCTIONS:=$(addprefix --replace=,\
 API_VER:=$(srcdir)/include/cygwin/version.h
 
 LIB_NAME:=libcygwin.a
-LIBSERVER:=@LIBSERVER@
 SUBLIBS:=libpthread.a libutil.a ${CURDIR}/libm.a ${CURDIR}/libc.a libdl.a libresolv.a librt.a
 EXTRALIBS:=libautomode.a libbinmode.a libtextmode.a libtextreadmode.a
 INSTOBJS:=automode.o binmode.o textmode.o textreadmode.o
@@ -300,7 +323,7 @@ cxx_STDINCFLAGS:=yes
 	install install-libs install-headers
 
 .SUFFIXES:
-.SUFFIXES: .c .cc .def .a .o .d .s
+.SUFFIXES: .c .cc .def .a .o .d .s .E
 
 all_host=@all_host@
 install_host=@install_host@
@@ -385,8 +408,8 @@ uninstall-man:
 	done
 
 clean:
-	-rm -f *.o *.dll *.dbg *.a *.exp junk *.base version.cc winver_stamp *.exe *.d *stamp* *_magic.h sigfe.s cygwin.def globals.h $(srcdir)/tlsoffsets.h $(srcdir)/devices.cc
-	-@$(MAKE) -C $(bupdir)/cygserver libclean
+	-rm -f *.o *.dll *.dbg *.a *.exp junk *.base version.cc winver_stamp *.exe *.d *stamp* *_magic.h sigfe.s cygwin.def globals.h tlsoffsets.h $(srcdir)/devices.cc
+	-@$(MAKE) -C ${cygserver_blddir} libclean
 
 maintainer-clean realclean: clean
 	@echo "This command is intended for maintainers to use;"
@@ -396,7 +419,7 @@ maintainer-clean realclean: clean
 
 # Rule to build cygwin.dll
 $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(LIBSERVER) $(LIBC) $(LIBM) $(API_VER) Makefile winver_stamp
-	$(CXX) $(CXXFLAGS) -Wl,--gc-sections $(nostdlib) -Wl,-T$(firstword $^) -static \
+	$(CXX) $(CXXFLAGS) -L${WINDOWS_LIBDIR} -Wl,--gc-sections $(nostdlib) -Wl,-T$(firstword $^) -static \
 	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
 	-e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) version.o winver.o \
 	$(MALLOC_OBJ) $(LIBSERVER) $(LIBM) $(LIBC) \
@@ -416,8 +439,12 @@ ${STATIC_LIB_NAME}: mkstatic ${TEST_DLL_
 $(TEST_LIB_NAME): $(LIB_NAME)
 	perl -p -e 'BEGIN{binmode(STDIN); binmode(STDOUT);}; s/cygwin1/cygwin0/g' < $? > $@
 
-$(LIBSERVER): $(bupdir)/cygserver/Makefile
-	$(MAKE) -C $(bupdir)/cygserver libcygserver.a
+$(LIBSERVER): ${cygserver_blddir}/Makefile
+	$(MAKE) -C ${cygserver_blddir} libcygserver.a
+
+${cygserver_blddir}/Makefile:
+	mkdir -p ${@D}
+	cd ${@D} && exec ${SHELL} $(dir ${srcdir})/cygserver/configure ${configure_args}
 
 dll_ofiles: $(DLL_OFILES)
 
@@ -436,10 +463,10 @@ globals.h: mkglobals_h globals.cc
 ${DLL_OFILES} ${LIBCOS}: globals.h
 
 shared_info_magic.h: cygmagic shared_info.h
-	/bin/sh $(word 1,$^) $@ "${COMPILE_CXX} -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
+	/bin/sh $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
 
 child_info_magic.h: cygmagic child_info.h
-	/bin/sh $(word 1,$^) $@ "${COMPILE_CXX} -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
+	/bin/sh $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
 
 dcrt0.o sigproc.o: child_info_magic.h
 
@@ -473,18 +500,19 @@ ${EXTRALIBS}: lib%.a: %.o
 	$(AR) cru $@ $?
 
 winver_stamp: mkvers.sh include/cygwin/version.h winver.rc $(DLL_OFILES)
-	@echo "Making version.o and winver.o";\
-	$(SHELL) ${word 1,$^} ${word 2,$^} ${word 3,$^} $(WINDRES) && \
-	$(COMPILE_CXX) -c -o version.o version.cc && \
+	echo "Making version.o and winver.o";\
+	$(SHELL) ${word 1,$^} ${word 2,$^} ${word 3,$^} $(WINDRES) ${CFLAGS} ${INCLUDES} && \
+	$(COMPILE.cc) -c -o version.o version.cc && \
 	touch $@
 
-Makefile: cygwin.din
+Makefile: cygwin.din ${srcdir}/Makefile.in
+	${SHELL} ./config.status
 
-$(DEF_FILE): gendef cygwin.din $(srcdir)/tlsoffsets.h
+$(DEF_FILE): gendef cygwin.din tlsoffsets.h
 	$^ $@ sigfe.s
 
-$(srcdir)/tlsoffsets.h: gentls_offsets cygtls.h
-	$^ $@ $(COMPILE_CXX) -c
+tlsoffsets.h: gentls_offsets cygtls.h
+	$^ $@ $(COMPILE.cc) -c
 
 sigfe.s: $(DEF_FILE)
 	@[ -s $@ ] || \
@@ -494,7 +522,17 @@ sigfe.s: $(DEF_FILE)
 sigfe.o: sigfe.s
 	$(CC) -c -o $@ $<
 
-winsup.h: config.h
+%.o: %.cc
+	${COMPILE.cc} -c -o $@ $<
+
+%.o: %.c
+	${COMPILE.c} -c -o $@ $<
+
+%.E: %.cc
+	${COMPILE.cc} -E -dD -o $@ $<
+
+%.E: %.c
+	${COMPILE.c} -E -dD -o $@ $<
 
 ctags: CTAGS
 tags:  CTAGS
Index: cygwin/autogen.sh
===================================================================
RCS file: cygwin/autogen.sh
diff -N cygwin/autogen.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ cygwin/autogen.sh	12 Nov 2012 19:53:06 -0000
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+/usr/bin/aclocal --acdir=..
+/usr/bin/autoconf -f
+exec /bin/rm -rf autom4te.cache
Index: cygwin/configure.in
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/configure.in,v
retrieving revision 1.38
diff -u -p -r1.38 configure.in
--- cygwin/configure.in	9 Jul 2012 09:00:56 -0000	1.38
+++ cygwin/configure.in	12 Nov 2012 19:53:06 -0000
@@ -1,25 +1,23 @@
-dnl Autoconf configure script for Cygwin.
-dnl Copyright 1996, 1997, 1998, 2000, 2001, 2002, 2003, 2004, 2005, 2006,
-dnl 2008, 2009, 2011 Red Hat, Inc.
-dnl
-dnl This file is part of Cygwin.
-dnl
-dnl This software is a copyrighted work licensed under the terms of the
-dnl Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
-dnl details.
-dnl
-dnl Process this file with autoconf to produce a configure script.
-
 AC_PREREQ(2.59)dnl
-AC_INIT(init.cc)
+AC_INIT(Makefile.in)
 AC_CONFIG_HEADER(config.h)
-AC_CONFIG_AUX_DIR(../..)
+AC_CONFIG_AUX_DIR(..)
+
+. ${srcdir}/../configure.cygwin
+
+AC_WINDOWS_HEADERS
+AC_WINDOWS_LIBS
 
 AC_PROG_INSTALL
 AC_CANONICAL_SYSTEM
 
-LIB_AC_PROG_CC
-LIB_AC_PROG_CXX
+AC_PROG_CC
+AC_PROG_CXX
+AC_PROG_CPP
+AC_LANG(C)
+AC_LANG(C++)
+
+AC_CYGWIN_INCLUDES
 
 case "$with_cross_host" in
   ""|*cygwin*)
@@ -32,8 +30,6 @@ case "$with_cross_host" in
     ;;
 esac
 
-LIBSERVER='$(bupdir)/cygserver/libcygserver.a'
-
 AC_SUBST(all_host)
 AC_SUBST(install_host)
 
@@ -83,6 +79,7 @@ case "$target_cpu" in
    *)		AC_MSG_ERROR(Invalid target processor \"$target_cpu\") ;;
 esac
 
+AC_CONFIGURE_ARGS
 AC_SUBST(MALLOC_OFILES)
 AC_SUBST(LIBSERVER)
 AC_SUBST(DLL_ENTRY)
Index: cygwin/mkvers.sh
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/mkvers.sh,v
retrieving revision 1.21
diff -u -p -r1.21 mkvers.sh
--- cygwin/mkvers.sh	9 Jul 2012 09:00:56 -0000	1.21
+++ cygwin/mkvers.sh	12 Nov 2012 19:53:06 -0000
@@ -1,7 +1,7 @@
 #!/bin/sh
 # mkvers.sh - Make version information for cygwin DLL
 #
-#   Copyright 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2010 Red Hat, Inc.
+#   Copyright 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2010, 2012 Red Hat, Inc.
 #
 # This file is part of Cygwin.
 #
@@ -14,9 +14,23 @@ exec 9> version.cc
 #
 # Arg 1 is the name of the version include file
 #
-incfile="$1"
-rcfile="$2"
-windres="$3"
+incfile="$1"; shift
+rcfile="$1"; shift
+windres="$1"; shift
+iflags=
+# Find header file locations
+while [ -n "$*" ]; do
+    case "$1" in
+	-I*)
+	    iflags="$iflags $1"
+	    ;;
+	-idirafter)
+	    shift
+	    iflags="$iflags -I$1"
+	    ;;
+    esac
+    shift
+done
 
 [ -r $incfile ] || {
     echo "**** Couldn't open file '$incfile'.  Aborting."
@@ -151,4 +165,4 @@ fi
 
 echo "Version $cygwin_ver"
 set -$- $builddate
-$windres --include-dir $dir/../w32api/include --include-dir $dir/include --define CYGWIN_BUILD_DATE="$1" --define CYGWIN_BUILD_TIME="$2" --define CYGWIN_VERSION='"'"$cygwin_ver"'"' $rcfile winver.o
+$windres $iflags --define CYGWIN_BUILD_DATE="$1" --define CYGWIN_BUILD_TIME="$2" --define CYGWIN_VERSION='"'"$cygwin_ver"'"' $rcfile winver.o
Index: cygwin/winlean.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/winlean.h,v
retrieving revision 1.10
diff -u -p -r1.10 winlean.h
--- cygwin/winlean.h	30 Jul 2012 04:43:22 -0000	1.10
+++ cygwin/winlean.h	12 Nov 2012 19:53:06 -0000
@@ -12,6 +12,10 @@ details. */
 #define _WINLEAN_H 1
 #define WIN32_LEAN_AND_MEAN 1
 
+#ifndef _WIN32
+#define _WIN32
+#endif /*_WIN32*/
+
 /* Mingw32 */
 #define _WINGDI_H
 #define _WINUSER_H
Index: cygwin/winsup.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/winsup.h,v
retrieving revision 1.247
diff -u -p -r1.247 winsup.h
--- cygwin/winsup.h	30 Jul 2012 04:26:05 -0000	1.247
+++ cygwin/winsup.h	12 Nov 2012 19:53:06 -0000
@@ -14,6 +14,9 @@ details. */
 #endif
 
 #define __INSIDE_CYGWIN__
+#ifndef _WIN32
+#define _WIN32
+#endif
 
 #define NO_COPY __attribute__((nocommon)) __attribute__((section(".data_cygwin_nocopy")))
 #define NO_COPY_INIT __attribute__((section(".data_cygwin_nocopy")))
Index: cygwin/include/netdb.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/include/netdb.h,v
retrieving revision 1.14
diff -u -p -r1.14 netdb.h
--- cygwin/include/netdb.h	6 Jul 2012 13:52:18 -0000	1.14
+++ cygwin/include/netdb.h	12 Nov 2012 19:53:06 -0000
@@ -67,7 +67,34 @@ extern "C" {
 #include <sys/socket.h>
 #ifndef __INSIDE_CYGWIN_NET__
 #include <netinet/in.h>
-#endif
+#else
+/* undef defines from Windows headers */
+
+#undef AI_ADDRCONFIG
+#undef AI_CANONNAME
+#undef AI_NUMERICHOST
+#undef AI_PASSIVE
+#undef EAI_AGAIN
+#undef EAI_BADFLAGS
+#undef EAI_FAIL
+#undef EAI_FAMILY
+#undef EAI_MEMORY
+#undef EAI_NODATA
+#undef EAI_NONAME
+#undef EAI_SERVICE
+#undef EAI_SOCKTYPE
+#undef HOST_NOT_FOUND
+#undef h_errno
+#undef NI_DGRAM
+#undef NI_NAMEREQD
+#undef NI_NOFQDN
+#undef NI_NUMERICHOST
+#undef NI_NUMERICSERV
+#undef NO_ADDRESS
+#undef NO_DATA
+#undef NO_RECOVERY
+#undef TRY_AGAIN
+#endif /*__INSIDE_CYGWIN_NET__*/
 
 /*
  * Structures returned by network data base library.  All addresses are
Index: cygwin/include/cygwin/if.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/include/cygwin/if.h,v
retrieving revision 1.10
diff -u -p -r1.10 if.h
--- cygwin/include/cygwin/if.h	6 Jul 2012 13:52:18 -0000	1.10
+++ cygwin/include/cygwin/if.h	12 Nov 2012 19:53:06 -0000
@@ -1,6 +1,6 @@
 /* cygwin/if.h
 
-   Copyright 1996, 2001, 2007 Red Hat, Inc.
+   Copyright 1996, 2001, 2007, 2012 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -8,8 +8,7 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
-#ifndef _CYGWIN_IF_H_
-#define _CYGWIN_IF_H_
+#pragma once
 
 #ifdef __cplusplus
 extern "C" {
@@ -121,5 +120,3 @@ extern void                 if_freenamei
 #ifdef __cplusplus
 };
 #endif /* __cplusplus */
-
-#endif /* _CYGWIN_IF_H_ */
Index: cygwin/include/cygwin/in.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/include/cygwin/in.h,v
retrieving revision 1.19
diff -u -p -r1.19 in.h
--- cygwin/include/cygwin/in.h	10 Oct 2012 08:36:33 -0000	1.19
+++ cygwin/include/cygwin/in.h	12 Nov 2012 19:53:06 -0000
@@ -15,12 +15,14 @@
  *		as published by the Free Software Foundation; either version
  *		2 of the License, or (at your option) any later version.
  */
-#ifndef _CYGWIN_IN_H
-#define _CYGWIN_IN_H
+#pragma once
 
-#include <cygwin/socket.h>
+#include <sys/socket.h>
 
+#ifndef _IN_PORT_DECLARED
+#define _IN_PORT_DECLARED
 typedef uint16_t in_port_t;
+#endif
 typedef uint32_t in_addr_t;
 
 #ifndef __INSIDE_CYGWIN_NET__
@@ -267,5 +269,3 @@ struct sockaddr_in
 #include <cygwin/in6.h>
 #endif
 #endif
-
-#endif	/* _CYGWIN_IN_H */
Index: cygwin/include/cygwin/in6.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/include/cygwin/in6.h,v
retrieving revision 1.6
diff -u -p -r1.6 in6.h
--- cygwin/include/cygwin/in6.h	18 Jan 2007 10:25:40 -0000	1.6
+++ cygwin/include/cygwin/in6.h	12 Nov 2012 19:53:06 -0000
@@ -1,6 +1,6 @@
 /* cygwin/in6.h
 
-   Copyright 2006, 2007 Red Hat, Inc.
+   Copyright 2006, 2007, 2012 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -10,8 +10,7 @@ details. */
 
 /* NOTE:  This file is NOT for direct inclusion.  Use netinet/in.h. */
 
-#ifndef _CYGWIN_IN6_H
-#define _CYGWIN_IN6_H
+#pragma once
 
 #define INET6_ADDRSTRLEN 46
 
@@ -97,7 +96,8 @@ struct in6_pktinfo
   uint32_t        ipi6_ifindex;
 };
 
-#if defined (__INSIDE_CYGWIN__) && !defined (_CYGWIN_IN_H)
+#ifndef _IN_PORT_DECLARED
+#define _IN_PORT_DECLARED
 typedef uint16_t in_port_t;
 #endif
 
@@ -115,5 +115,3 @@ struct sockaddr_in6
 
 extern const struct in6_addr in6addr_any;
 extern const struct in6_addr in6addr_loopback;
-
-#endif	/* _CYGWIN_IN6_H */
Index: cygwin/include/cygwin/socket.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/include/cygwin/socket.h,v
retrieving revision 1.31
diff -u -p -r1.31 socket.h
--- cygwin/include/cygwin/socket.h	1 Aug 2012 18:56:45 -0000	1.31
+++ cygwin/include/cygwin/socket.h	12 Nov 2012 19:53:06 -0000
@@ -8,8 +8,29 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
-#ifndef _CYGWIN_SOCKET_H
-#define _CYGWIN_SOCKET_H
+#pragma once
+
+#ifdef __INSIDE_CYGWIN__
+/* undef defines from Windows headers */
+#undef AF_MAX
+#undef CMSG_DATA
+#undef FIOASYNC
+#undef FIONBIO
+#undef FIONREAD
+#undef IFF_BROADCAST
+#undef IFF_LOOPBACK
+#undef IFF_MULTICAST
+#undef IFF_UP
+#undef SIOCATMARK
+#undef SIOCGHIWAT
+#undef SIOCGLOWAT
+#undef SIOCSHIWAT
+#undef SIOCSLOWAT
+#undef SO_DONTLINGER
+#undef _IO
+#undef _IOR
+#undef _IOW
+#endif /*__INSIDE_CYGWIN__*/
 
 #ifdef __cplusplus
 extern "C" {
@@ -309,5 +330,3 @@ struct OLD_msghdr
 #ifdef __cplusplus
 };
 #endif /* __cplusplus */
-
-#endif /* _CYGWIN_SOCKET_H */
Index: cygwin/include/sys/socket.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/include/sys/socket.h,v
retrieving revision 1.10
diff -u -p -r1.10 socket.h
--- cygwin/include/sys/socket.h	15 Jan 2010 15:40:05 -0000	1.10
+++ cygwin/include/sys/socket.h	12 Nov 2012 19:53:06 -0000
@@ -1,7 +1,7 @@
 /* sys/socket.h
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2005, 2006,
-   2009, 2010 Red Hat, Inc.
+   2009, 2010, 2012 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -9,8 +9,7 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
-#ifndef _SYS_SOCKET_H
-#define _SYS_SOCKET_H
+#pragma once
 
 #include <features.h>
 #include <cygwin/socket.h>
@@ -56,5 +55,3 @@ extern "C"
 #ifdef __cplusplus
 };
 #endif
-
-#endif /* _SYS_SOCKET_H */
Index: cygwin/include/sys/termios.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/include/sys/termios.h,v
retrieving revision 1.23
diff -u -p -r1.23 termios.h
--- cygwin/include/sys/termios.h	5 Nov 2012 03:19:28 -0000	1.23
+++ cygwin/include/sys/termios.h	12 Nov 2012 19:53:06 -0000
@@ -11,8 +11,7 @@ details. */
 
 /* sys/termios.h */
 
-#ifndef	_SYS_TERMIOS_H
-#define _SYS_TERMIOS_H
+#pragma once
 
 #include <sys/types.h>
 
@@ -71,6 +70,9 @@ POSIX commands */
 #define TIOCPKT_NOSTOP		16
 #define TIOCPKT_DOSTOP		32
 
+#ifdef __INSIDE_CYGWIN__
+#undef FIONBIO
+#endif /*__INSIDE_CYGWIN__*/
 #define FIONBIO 0x8004667e /* To be compatible with socket version */
 
 #define CTRL(ch)	((ch)&0x1F)
@@ -367,5 +369,3 @@ struct winsize
 #define TIOCLINUX  (('T' << 8) | 3)
 #define TIOCGPGRP  (('T' << 8) | 0xf)
 #define TIOCSPGRP  (('T' << 8) | 0x10)
-
-#endif	/* _SYS_TERMIOS_H */
Index: cygwin/libc/minires-os-if.c
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/libc/minires-os-if.c,v
retrieving revision 1.14
diff -u -p -r1.14 minires-os-if.c
--- cygwin/libc/minires-os-if.c	12 Jul 2012 11:27:28 -0000	1.14
+++ cygwin/libc/minires-os-if.c	12 Nov 2012 19:53:06 -0000
@@ -11,13 +11,14 @@ Cygwin license.  Please consult the file
 details. */
 
 #define  __INSIDE_CYGWIN_NET__
+#define  __INSIDE_CYGWIN__
 #define USE_SYS_TYPES_FD_SET
+#include <sys/time.h>
 #include <winsup.h>
 #include <ws2tcpip.h>
 #include <iphlpapi.h>
 #include <windns.h>
 #include "ntdll.h"
-#undef h_errno
 #include "minires.h"
 
 #ifdef __CYGWIN__
@@ -27,10 +28,6 @@ details. */
 
 ***********************************************************************/
 
-/* Conflict between Windows definitions and others */
-#undef ERROR
-#undef NOERROR
-#undef DELETE
 
 /***********************************************************************
  * write_record: Translates a Windows DNS record into a compressed record
Index: cygwin/libc/minires.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/libc/minires.h,v
retrieving revision 1.4
diff -u -p -r1.4 minires.h
--- cygwin/libc/minires.h	6 Jul 2012 13:56:37 -0000	1.4
+++ cygwin/libc/minires.h	12 Nov 2012 19:53:06 -0000
@@ -1,6 +1,6 @@
 /* minires.h.  Stub synchronous resolver for Cygwin.
 
-   Copyright 2006, 2012 Red Hat, Inc.
+   Copyright 2006, 2008, 2012 Red Hat, Inc.
 
    Written by Pierre A. Humblet <Pierre.Humblet@ieee.org>
 
@@ -10,6 +10,8 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
+#pragma once
+
 #include "winsup.h"
 #include <string.h>
 #include <malloc.h>
@@ -25,6 +27,9 @@ details. */
 #include <stdarg.h>
 #include <sys/unistd.h>
 #define  __INSIDE_CYGWIN_NET__
+#undef ERROR
+#undef NOERROR
+#undef DELETE
 #include <netdb.h>
 #include <arpa/nameser.h>
 #include <resolv.h>
Index: utils/Makefile.in
===================================================================
RCS file: /cvs/uberbaum/winsup/utils/Makefile.in,v
retrieving revision 1.104
diff -u -p -r1.104 Makefile.in
--- utils/Makefile.in	7 Nov 2012 16:32:08 -0000	1.104
+++ utils/Makefile.in	12 Nov 2012 19:53:06 -0000
@@ -8,10 +8,29 @@
 # Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 # details.
 
-SHELL:=@SHELL@
-
 srcdir:=@srcdir@
-VPATH:=@srcdir@
+target_builddir:=@target_builddir@
+winsup_srcdir:=@winsup_srcdir@
+configure_args=@configure_args@
+
+export CC:=@CC@
+export CXX:=@CXX@
+
+include ${srcdir}/../Makefile.common
+
+cygwin_build:=${target_builddir}/winsup/cygwin
+
+cygwin_headers:=@cygwin_headers@
+newlib_headers:=@newlib_headers@
+
+# environment variables used by ccwrap
+export CCWRAP_HEADERS:=. ${srcdir} $(call justdir,${cygwin_headers})
+export CCWRAP_SYSTEM_HEADERS:=${cygwin_headers} ${newlib_headers}
+export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
+export PATH:=$(subst %/,%,$(dir ${srcdir})):${PATH}
+
+WINDOWS_LIBDIR:=@windows_libdir@
+
 prefix:=@prefix@
 exec_prefix:=@exec_prefix@
 
@@ -25,26 +44,21 @@ override INSTALL_DATA:=@INSTALL_DATA@
 EXEEXT:=@EXEEXT@
 EXEEXT_FOR_BUILD:=@EXEEXT_FOR_BUILD@
 
-CC:=@CC@
-CC_FOR_TARGET:=$(CC)
-CXX:=@CXX@
-CXX_FOR_TARGET:=$(CXX)
-
 CFLAGS:=@CFLAGS@
 CXXFLAGS:=@CXXFLAGS@
 override CXXFLAGS+=-fno-exceptions -fno-rtti -DHAVE_DECL_GETOPT=0
-
-include $(srcdir)/../Makefile.common
+COMPILE.cc=c++wrap ${CXXFLAGS}
+COMPILE.c=ccwrap ${CFLAGS}
 
 .SUFFIXES:
 .NOEXPORT:
 .PHONY: all install clean realclean warn_dumper warn_cygcheck_zlib
 
-ALL_LDLIBS     := -lnetapi32 -ladvapi32 -lkernel32 -luser32
-ALL_LDFLAGS    := -static-libgcc -Wl,--enable-auto-import -B$(newlib_build)/libc $(LDFLAGS) $(ALL_LDLIBS)
-ALL_DEP_LDLIBS := $(cygwin_build)/libcygwin.a
+LDLIBS     := -lnetapi32 -ladvapi32 -lkernel32 -luser32
+LDFLAGS    := -static-libgcc -Wl,--enable-auto-import -L${WINDOWS_LIBDIR} $(LDLIBS)
+DEP_LDLIBS := $(cygwin_build)/libcygwin.a
 
-MINGW_CXX      := @MINGW_CXX@ $(CFLAGS)
+MINGW_CXX      := @MINGW_CXX@
 
 # List all binaries to be linked in Cygwin mode.  Each binary on this list
 # must have a corresponding .o of the same name.
@@ -59,6 +73,11 @@ MINGW_BINS := ${addsuffix .exe,cygcheck 
 # list will will be compiled in Cygwin mode implicitly, so there is no
 # need for a CYGWIN_OBJS.
 MINGW_OBJS := bloda.o cygcheck.o dump_setup.o ldh.o path.o strace.o
+MINGW_LDFLAGS:=-L${WINDOWS_LIBDIR}
+
+all:
+
+path.o: export CCWRAP_HEADERS+=${cygwin_headers} ${newlib_headers}
 
 # If a binary should link in any objects besides the .o with the same
 # name as the binary, then list those here.
@@ -66,49 +85,41 @@ strace.exe: path.o
 cygcheck.exe: bloda.o path.o dump_setup.o
 
 path-mount.o: path.cc
-	$(CXX) -c $(CXXFLAGS) -DFSTAB_ONLY -I$(updir) $< -o $@
+	${COMPILE.cc} -c -DFSTAB_ONLY -o $@ $<
 mount.exe: path-mount.o
 
 # Provide any necessary per-target variable overrides.
-cygcheck.exe: MINGW_CXXFLAGS += -idirafter $(cygwin_source)/include -idirafter $(newlib_source)/libc/include
-cygcheck.exe: MINGW_LDFLAGS += -lpsapi -lntdll
-cygpath.exe: ALL_LDFLAGS += -lcygwin -luserenv -lntdll
+# cygcheck.exe: MINGW_CXXFLAGS += -idirafter $(cygwin_source)/include -idirafter $(newlib_source)/libc/include
+cygcheck.exe: export CCWRAP_DIRAFTER_HEADERS+=${cygwin_headers} ${newlib_headers}
+cygcheck.exe: MINGW_LDFLAGS += -lpsapi -lntdll -lz
+cygpath.exe: LDFLAGS += -luserenv -lntdll
 cygpath.exe: CXXFLAGS += -fno-threadsafe-statics
-ps.exe: ALL_LDFLAGS += -lcygwin -lpsapi -lntdll
+ps.exe: LDFLAGS += -lpsapi -lntdll
 strace.exe: MINGW_LDFLAGS += -lntdll
 
-ldd.exe: ALL_LDFLAGS += -lpsapi
-pldd.exe: ALL_LDFLAGS += -lpsapi
+ldd.exe:LDFLAGS += -lpsapi
+pldd.exe: LDFLAGS += -lpsapi
 
-ldh.exe: MINGW_LDFLAGS := -nostdlib -lkernel32
+ldh.exe: MINGW_LDFLAGS += -nostdlib -lkernel32
 
 # Check for dumper's requirements and enable it if found.
-libiconv := ${shell $(CC) --print-file-name=libiconv.a}
-libbfd   := ${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=libbfd.a}
-libintl  := ${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=libintl.a}
-bfdlink	 := $(shell ${CC} -xc /dev/null -o /dev/null -c -B${bupdir2}/bfd/ -include bfd.h 2>&1)
-build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(libiconv)" -a -z "${bfdlink}" && echo 1}
+libiconv := $(call libname,libiconv.a)
+libbfd   := $(call libname,libbfd.a,-B$(target_builddir)/bfd/)
+libintl  := $(call libname,libintl.a,-B$(target_builddir)/intl/)
+bfdlink	 := $(realpath $(shell ${CC} -xc /dev/null -o /dev/null -c -B${target_builddir}/bfd/ -include bfd.h 2>&1))
+build_dumper := ${shell test -r "$(libbfd)" -a -r "$(libintl)" -a -r "$(libiconv)" -a -z "${bfdlink}" && echo 1}
+
+.PHONY: all
 ifdef build_dumper
 CYGWIN_BINS += dumper.exe
-dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(bupdir2)/bfd -I$(updir1)/include
+dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(target_builddir)/bfd -I$(top_srcdir)/include
 dumper.o parse_pe.o: dumper.h
 dumper.exe: module_info.o parse_pe.o
-dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(libiconv) -liberty -lz
+dumper.exe: LDFLAGS += -L${top_builddir}/libiberty ${libbfd} ${libintl} $(libiconv) -liberty -lz
 else
 all: warn_dumper
 endif
 
-# Check for availability of a MinGW libz and enable for cygcheck.
-libz:=${shell x=$$(${MINGW_CXX} --print-file-name=libz.a); cd $$(dirname $$x); dir=$$(pwd); case "$$dir" in *mingw*) echo $$dir/libz.a ;; esac}
-ifdef libz
-zlib_h  := -include ${patsubst %/lib/libz.a,%/include/zlib.h,$(libz)}
-zconf_h := ${patsubst %/zlib.h,%/zconf.h,$(zlib_h)}
-dump_setup.o: MINGW_CXXFLAGS += $(zconf_h) $(zlib_h)
-cygcheck.exe: MINGW_LDFLAGS += $(libz)
-else
-all: warn_cygcheck_zlib
-endif
-
 all: Makefile $(CYGWIN_BINS) $(MINGW_BINS)
 
 # test harness support (note: the "MINGW_BINS +=" should come after the
@@ -127,37 +138,24 @@ check: testsuite.exe ; $(<D)/$(<F)
 # the rest of this file contains generic rules
 
 # how to compile a MinGW object
+${MINGW_OBJS}: export CXX:=${MINGW_CXX}
+${MINGW_OBJS}: export CCWRAP_SYSTEM_HEADERS:=
 $(MINGW_OBJS): %.o: %.cc
-ifdef VERBOSE
-	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
-else
-	@echo $(MINGW_CXX) $c $(MINGW_CXXFLAGS) ... $(*F).cc;\
-	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
-endif
+	c++wrap -c -o $@ ${CXXFLAGS} $(MINGW_CXXFLAGS) $<
 
 # how to link a MinGW binary
 $(MINGW_BINS): %.exe: %.o
-ifdef VERBOSE
 	$(MINGW_CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} $(MINGW_LDFLAGS)
-else
-	@echo $(MINGW_CXX) -o $@ ${filter %.o,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)};\
-	$(MINGW_CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} $(MINGW_LDFLAGS)
-endif
 
 # how to link a Cygwin binary
 $(CYGWIN_BINS): %.exe: %.o
-ifdef VERBOSE
-	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
-else
-	@echo $(CXX) -o $@ ${filter %.o,$^} ... ${filter-out -B%, $(ALL_LDFLAGS)};\
-	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
-endif
+	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(LDFLAGS)
 
 # note: how to compile a Cygwin object is covered by the pattern rule in Makefile.common
 
 # these dependencies ensure that the required in-tree libs are built first
-$(MINGW_BINS): $(ALL_DEP_LDLIBS)
-$(CYGWIN_BINS): $(ALL_DEP_LDLIBS)
+$(MINGW_BINS): $(DEP_LDLIBS)
+$(CYGWIN_BINS): $(DEP_LDLIBS)
 
 clean:
 	rm -f *.o $(CYGWIN_BINS) $(MINGW_BINS) path-testsuite.cc testsuite.exe
@@ -166,7 +164,7 @@ realclean: clean
 	rm -f Makefile config.cache
 
 install: all
-	$(SHELL) $(updir1)/mkinstalldirs $(DESTDIR)$(bindir)
+	/bin/mkdir -p ${DESTDIR}${bindir}
 	for i in $(CYGWIN_BINS) ${filter-out testsuite.exe,$(MINGW_BINS)} ; do \
 	  n=`echo $$i | sed '$(program_transform_name)'`; \
 	  $(INSTALL_PROGRAM) $$i $(DESTDIR)$(bindir)/$$n; \
@@ -183,5 +181,17 @@ warn_dumper:
 	@echo '*** sources from sourceware.org.  Then, configure and build these'
 	@echo '*** libraries.  Otherwise, you can safely ignore this warning.'
 
-warn_cygcheck_zlib:
-	@echo '*** Building cygcheck without package content checking due to missing mingw libz.a.'
+%.o: %.cc
+	${COMPILE.cc} -c -o $@ $<
+
+%.o: %.c
+	${COMPILE.c} -c -o $@ $<
+
+%.E: %.cc
+	${COMPILE.cc} -E -dD -o $@ $<
+
+%.E: %.c
+	${COMPILE.c} -E -dD -o $@ $<
+
+Makefile: Makefile.in config.status
+	./config.status
Index: utils/autogen.sh
===================================================================
RCS file: utils/autogen.sh
diff -N utils/autogen.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ utils/autogen.sh	12 Nov 2012 19:53:06 -0000
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+/usr/bin/aclocal --acdir=..
+/usr/bin/autoconf -f
+exec /bin/rm -rf autom4te.cache
Index: utils/configure.in
===================================================================
RCS file: /cvs/uberbaum/winsup/utils/configure.in,v
retrieving revision 1.11
diff -u -p -r1.11 configure.in
--- utils/configure.in	24 Oct 2012 12:45:09 -0000	1.11
+++ utils/configure.in	12 Nov 2012 19:53:06 -0000
@@ -14,19 +14,26 @@ AC_INIT(mount.cc)
 AC_CONFIG_AUX_DIR(../..)
 
 AC_NO_EXECUTABLES
+
+. ${srcdir}/../configure.cygwin
+
+AC_WINDOWS_HEADERS
+AC_WINDOWS_LIBS
+
 AC_CANONICAL_SYSTEM
 
-LIB_AC_PROG_CC
-LIB_AC_PROG_CXX
+AC_PROG_CC
+AC_PROG_CXX
 
-AC_ARG_PROGRAM
+AC_CYGWIN_INCLUDES
 
-INSTALL="/bin/sh "`cd $srcdir/../..; echo $(pwd)/install-sh -c`
+AC_ARG_PROGRAM
 
 AC_PROG_INSTALL
 
 AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)
-test -z "$MINGW_CXX" && AC_MSG_ERROR([no acceptable mingw g++ found in \$PATH])
+test -n "$MINGW_CXX" || AC_MSG_ERROR([no acceptable mingw g++ found in \$PATH])
 
 AC_EXEEXT
+AC_CONFIGURE_ARGS
 AC_OUTPUT(Makefile)
Index: utils/dump_setup.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/utils/dump_setup.cc,v
retrieving revision 1.24
diff -u -p -r1.24 dump_setup.cc
--- utils/dump_setup.cc	11 Jul 2012 16:41:51 -0000	1.24
+++ utils/dump_setup.cc	12 Nov 2012 19:53:06 -0000
@@ -28,15 +28,7 @@ details. */
 # include <ntstatus.h>
 #endif
 #include "path.h"
-#if 0
-#include "zlib.h"
-#endif
-
-#ifndef ZLIB_VERSION
-typedef void * gzFile;
-#define gzgets(fp, buf, size) ({0;})
-#define gzclose(fp) ({0;})
-#endif
+#include <zlib.h>
 
 static int package_len = 20;
 static unsigned int version_len = 10;
Index: utils/path.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/utils/path.cc,v
retrieving revision 1.33
diff -u -p -r1.33 path.cc
--- utils/path.cc	9 Nov 2012 08:53:01 -0000	1.33
+++ utils/path.cc	12 Nov 2012 19:53:06 -0000
@@ -16,6 +16,7 @@ details. */
 
 #define str(a) #a
 #define scat(a,b) str(a##b)
+#define __CRT__NO_INLINE
 #include <windows.h>
 #include <lmcons.h>
 #include <stdio.h>

--pf9I7BMVVzbSWLtt--
