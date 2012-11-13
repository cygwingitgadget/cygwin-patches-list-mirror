Return-Path: <cygwin-patches-return-7777-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19618 invoked by alias); 13 Nov 2012 18:36:59 -0000
Received: (qmail 18707 invoked by uid 22791); 13 Nov 2012 18:36:51 -0000
X-SWARE-Spam-Status: No, hits=4.0 required=5.0	tests=AWL,BAYES_50,MPIX_STOCK,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SARE_OBFU_PART_INA,SARE_RAND_1,TW_BJ,TW_CN,TW_CX,TW_DB,TW_DJ,TW_DL,TW_DP,TW_EG,TW_FD,TW_FN,TW_GP,TW_GU,TW_IU,TW_JG,TW_KD,TW_MK,TW_NX,TW_PT,TW_PW,TW_QN,TW_SD,TW_TM,TW_XD,TW_XM,TW_XP,TW_XU,TW_YG,TW_ZV
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Nov 2012 18:34:19 +0000
Received: from pool-98-110-183-145.bstnma.fios.verizon.net ([98.110.183.145] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TYLJP-000DTf-2b	for cygwin-patches@cygwin.com; Tue, 13 Nov 2012 18:34:15 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 0EB0313C0C8	for <cygwin-patches@cygwin.com>; Tue, 13 Nov 2012 13:34:14 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/7381nTfGMd5fVG0rh8s5K
Date: Tue, 13 Nov 2012 18:36:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121113183414.GA12388@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de> <20121113173900.GA13846@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20121113173900.GA13846@ednor.casa.cgf.cx>
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
X-SW-Source: 2012-q4/txt/msg00054.txt.bz2

On Tue, Nov 13, 2012 at 12:39:00PM -0500, Christopher Faylor wrote:
>Maybe I can use -isystem with ccwraper.  I'd previously gotten things
>working without the wrapper, using idirafter so that's what I stuck
>with.  However, the wrapper may now allow just always including the
>windows headers last.

Yep.  Adding the windows headers directories dead last as -isystem means
that none of my header file changes are needed, *except* for the #define
_WIN32.  I wonder why you don't need those.  My (i.e., Yaakov's) cross
compiler doesn't define _WIN32.

% /cygwin/bin/i686-cygwin-gcc --version
i686-cygwin-gcc (GCC) 4.5.3 20110428 (Fedora Cygwin 4.5.3-4)
Copyright (C) 2010 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

% /cygwin/bin/i686-cygwin-gcc -dD -E -xc /dev/null | grep WIN
#define __WINT_TYPE__ unsigned int
#define __WINT_MAX__ 4294967295U
#define __WINT_MIN__ 0U
#define __SIZEOF_WINT_T__ 4
#define __CYGWIN32__ 1
#define __CYGWIN__ 1

So, except for that, mystery solved.

My new, smaller diff is attached.  Unless you have objections, I'll be
checking this in.

cgf
ChangeLog
2012-11-12  Christopher Faylor  <me.cygwin2012@cgf.cx>

	* Makefile.common: Revamp for new configury.  Add default compilation
	targets, include .E processing.
	* acinclude.m4: Delete old definitions.  Implement AC_WINDOWS_HEADERS,
	AC_WINDOWS_LIBS, AC_CYGWIN_INCLUDES, target_builddir, winsup_srcdir.
	* aclocal.m4: Regenerate.
	* autogen.sh: New file.
	* ccwrap: New script.
	* c++wrap: New script.
	* config.guess: New script.
	* config.sub: New script.
	* configure: Regenerate.
	* configure.in: Eliminate LIB_AC_PROG_* calls in favor of standard.
	Delete ancient target test.
	* install-sh: New script.

cygwin/ChangeLog
2012-11-12  Christopher Faylor  <me.cygwin2012@cgf.cx>

	* Makefile.in: Revamp for new configury.
	(datarootdir): Add variable setting.
	(winver_stamp): Accommodate changes to mkvers.sh setting.
	* configure.in: Revamp for new configury.
	* aclocal.m4: Regenerate.
	* configure: Ditto.
	* autogen.sh: New script.
	* mkvers.sh: Find include directives via CFLAGS and friends rather than
	assuming that w32api lives nearby.
	* tlsoffsets.h: Delete.
	* winlean.h: #define _WIN32 for mingw64.
	* winsup.h: Ditto.

cygserver/ChangeLog
2012-11-12  Christopher Faylor  <me.cygwin2012@cgf.cx>

	* Makefile.in: Revamp for new configury.
	* configure.in: Revamp for new configury.
	* aclocal.m4: Regenerate.
	* configure: Ditto.
	* autogen.sh: New script.

utils/ChangeLog
2012-11-12  Christopher Faylor  <me.cygwin2012@cgf.cx>

	* aclocal.m4: Regenerate.
	* configure: Ditto.
	* autogen.sh: New script.
	* configure.in: Revamp for new configury.
	* Makefile.in: Revamp for new configury.  Rename ALL_* to just *.
	Always use "VERBOSE" setting.
	(MINGW_CXX): Don't include CFLAGS in definition.
	(all): Define target first, before everything else so that it is the
	default.
	(ps.exe): Don't add useless -lcygwin.
	(ldh.exe): For consistency, add to existing MINGW_LDFLAGS rather than
	redefining them.
	(cygcheck.exe): Always include -lz for MINGW_LDFLAGS.  Don't try to
	figure out where to find it.
	(install): Just use /bin/mkdir to create directories.
	(Makefile): Regenerate when standard dependencies change.
	* dump_setup.cc: Always include zlib.h.  Remove accommodations for it
	possibly not existing.

Index: Makefile.common
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/Makefile.common,v
retrieving revision 1.61
diff -d -u -p -r1.61 Makefile.common
--- Makefile.common	7 Nov 2012 16:32:07 -0000	1.61
+++ Makefile.common	13 Nov 2012 18:15:20 -0000
@@ -8,154 +8,38 @@
 # Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 # details.
=20
-# This makefile requires GNU make.
-
-CFLAGS_COMMON:=3D-Wall -Wstrict-aliasing -Wwrite-strings -fno-common -pipe=
 -fbuiltin -fmessage-length=3D0 -D_SDKDDKVER_H
-MALLOC_DEBUG:=3D#-DMALLOC_DEBUG -I/cygnus/src/uberbaum/winsup/cygwin/dlmal=
loc
-MALLOC_OBJ:=3D#/cygnus/src/uberbaum/winsup/cygwin/dlmalloc/malloc.o
-
-override srcdir:=3D${shell cd $(srcdir); pwd}
-ifneq (,${filter-out /%,$(srcdir)})
-    updir:=3D$(srcdir)/..
-    updir1:=3D$(updir)/..
-else
-    updir:=3D${patsubst %:::,%,${patsubst %/:::,%,$(dir $(srcdir)):::}}
-ifneq (,${findstring /,$(updir)})
-    updir1:=3D${patsubst %:::,%,${patsubst %/:::,%,$(dir $(updir)):::}}
-else
-    updir1:=3D$(updir)/..
-endif
-endif
-
-pwd:=3D${shell pwd}
-ifneq "${filter winsup%,${notdir $(pwd)}}" ""
-    here:=3D${pwd}/cygwin
-else
-    here:=3D${dir $(pwd)}cygwin
-endif
-bupdir:=3D${shell cd $(here)/..; pwd}
-ifneq (,${filter-out /%,$(bupdir)})
-    bupdir1:=3D../..
-    bupdir2:=3D../../..
-else
-ifneq (,${findstring /,$(bupdir)})
-    bupdir1:=3D${patsubst %:::,%,${patsubst %/:::,%,$(dir $(bupdir)):::}}
-else
-    bupdir1:=3D$(bupdir)/..
-endif
-ifneq (,${findstring /,$(bupdir1)})
-    bupdir2:=3D${patsubst %:::,%,${patsubst %/:::,%,$(dir $(bupdir1)):::}}
-else
-    bupdir2:=3D$(bupdir1)/..
-endif
-endif
-
-newlib_source:=3D$(updir1)/newlib
-newlib_build:=3D$(bupdir1)/newlib
-cygwin_build:=3D$(bupdir)/cygwin
-cygwin_source:=3D$(updir)/cygwin
-utils_build:=3D$(bupdir)/utils
-utils_source:=3D$(updir)/utils
-ifeq (,${findstring $(newlib_source)/libc/include,$(CFLAGS) $(CXXFLAGS) $(=
CXX) $(CC)})
-newlib_include:=3D-I$(newlib_source)/libc/include
-endif
-ifeq (,${findstring $(cygwin_source)/include,$(CFLAGS) $(CXXFLAGS) $(CXX) =
$(CC)})
-cygwin_include:=3D-I$(cygwin_source)/include
-endif
-
-nostdincxx:=3D-nostdinc++
-
-nostdlib:=3D-nostdlib
-
-ifeq (,${nostdlib})
-nostdinc:=3D
-endif
-
-INCLUDES:=3D-I. $(cygwin_include) -I$(cygwin_source) $(newlib_include)
-ifdef CONFIG_DIR
-INCLUDES+=3D-I$(CONFIG_DIR)
-endif
-
-MINGW_LDFLAGS:=3D-static
-MINGW_CFLAGS:=3D
-MINGW_CXXFLAGS:=3D
-
-GCC_DEFAULT_OPTIONS:=3D$(CFLAGS_COMMON) $(CFLAGS_CONFIG) $(INCLUDES)
-
-# Link in libc and libm from newlib
-
-LIBC:=3D$(newlib_build)/libc/libc.a
-LIBM:=3D$(newlib_build)/libm/libm.a
-CRT0:=3D$(cygwin_build)/crt0.o
-
-ALL_CFLAGS=3D$(DEFS) $(MALLOC_DEBUG) $(CFLAGS) $(GCC_DEFAULT_OPTIONS)
-ALL_CXXFLAGS=3D$(DEFS) $(MALLOC_DEBUG) $(CXXFLAGS) $(GCC_DEFAULT_OPTIONS)
-
-ifndef PREPROCESS
-c=3D-c
-o=3D.o
-else
-c=3D-E -dD
-o=3D.E
-endif
-
-libgcc:=3D${subst \,/,${shell $(CC_FOR_TARGET) -print-libgcc-file-name}}
-gcc_libdir:=3D${word 1,${dir $(libgcc)}}
-ifeq (,${findstring $(gcc_libdir),$(CFLAGS) $(CXXFLAGS) $(CXX) $(CC)})
-GCC_INCLUDE:=3D${subst //,/,-I$(gcc_libdir)/include}
-endif
+define justdir
+$(patsubst %/,%,$(dir $1))
+endef
=20
-COMPILE_CXX=3D$(CXX) $c $(if $($(*F)_STDINCFLAGS),,$(nostdincxx) $(nostdin=
c)) \
-	     $(ALL_CXXFLAGS) $(GCC_INCLUDE) -fno-rtti -fno-exceptions
-COMPILE_CC=3D$(CC) $c $(if $($(*F)_STDINCFLAGS),,$(nostdinc)) $(ALL_CFLAGS=
) $(GCC_INCLUDE)
+define libname
+$(realpath $(shell ${CC} --print-file-name=3D$1 $2))
+endef
=20
-vpath %.a	$(cygwin_build):$(newlib_build)/libc:$(newlib_build)/libm
+export PATH:=3D${winsup_srcdir}:${PATH}
=20
-MAKEOVERRIDES_WORKAROUND=3D${wordlist 2,1,a b c}
+COMPILE.cc=3Dc++wrap ${CXXFLAGS}
+COMPILE.c=3Dccwrap ${CFLAGS}
=20
-ifneq ($(MAKEOVERRIDES_WORKAROUND),)
-    override MAKE:=3D$(MAKE) $(MAKEOVERRIDES)
-    MAKEOVERRIDES:=3D
-    export MAKEOVERRIDES
-endif
+top_srcdir:=3D$(call justdir,${winsup_srcdir})
+top_builddir:=3D$(call justdir,${target_builddir})
=20
-ifdef RPATH_ENVVAR
-VERBOSE=3D1
-endif
+cygwin_build:=3D${target_builddir}/winsup/cygwin
+newlib_build:=3D${target_builddir}/newlib
=20
-ifneq "${findstring -B,$(COMPILE_CXX) $(COMPILE_CC)}" ""
-VERBOSE=3D1
-endif
+VPATH:=3D${srcdir}
=20
-.PRECIOUS: %.o
+.SUFFIXES:
+.SUFFIXES: .c .cc .def .a .o .d .s .E
=20
 %.o: %.cc
-ifdef VERBOSE
-	$(COMPILE_CXX) -o $(@D)/$(*F)$o $<
-else
-	@echo $(CXX) $c $(CXXFLAGS) ... $(*F).cc
-	@$(COMPILE_CXX) -o $(@D)/$(*F)$o $<
-endif
+	${COMPILE.cc} -c -o $@ $<
=20
 %.o: %.c
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
-
-.PRECIOUS: Makefile
+	${COMPILE.c} -c -o $@ $<
=20
-Makefile: Makefile.in $(srcdir)/configure.in config.status
-	$(SHELL) config.status
+%.E: %.cc
+	${COMPILE.cc} -E -dD -o $@ $<
=20
-config.status: configure
-	$(SHELL) config.status --recheck
+%.E: %.c
+	${COMPILE.c} -E -dD -o $@ $<
Index: acinclude.m4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/acinclude.m4,v
retrieving revision 1.1
diff -d -u -p -r1.1 acinclude.m4
--- acinclude.m4	24 May 2006 16:59:02 -0000	1.1
+++ acinclude.m4	13 Nov 2012 18:15:20 -0000
@@ -1,43 +1,83 @@
-dnl This provides configure definitions used by all the winsup
+dnl This provides configure definitions used by all the cygwin
 dnl configure.in files.
=20
-# FIXME: We temporarily define our own version of AC_PROG_CC.  This is
-# copied from autoconf 2.12, but does not call AC_PROG_CC_WORKS.  We
-# are probably using a cross compiler, which will not be able to fully
-# link an executable.  This should really be fixed in autoconf
-# itself.
+AC_DEFUN([AC_WINDOWS_HEADERS],[
+AC_ARG_WITH(
+    [windows-headers],
+    [AS_HELP_STRING([--with-windows-headers=3DDIR],
+		    [specify where the windows includes are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-win=
dows-headers])]
+)
+])
=20
-AC_DEFUN([LIB_AC_PROG_CC_GNU],
-[AC_CACHE_CHECK(whether we are using GNU C, ac_cv_prog_gcc,
-[dnl The semicolon is to pacify NeXT's syntax-checking cpp.
-cat > conftest.c <<EOF
-#ifdef __GNUC__
-  yes;
-#endif
-EOF
-if AC_TRY_COMMAND(${CC-cc} -E conftest.c) | egrep yes >/dev/null 2>&1; then
-  ac_cv_prog_gcc=3Dyes
-else
-  ac_cv_prog_gcc=3Dno
-fi])])
+AC_DEFUN([AC_WINDOWS_LIBS],[
+AC_ARG_WITH(
+    [windows-libs],
+    [AS_HELP_STRING([--with-windows-libs=3DDIR],
+		    [specify where the windows libraries are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-win=
dows-libs])]
+)
+windows_libdir=3D$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=3D$(cd $(dirname $($ac_cv_prog_CC -print-file-name=3Dli=
bcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	AC_MSG_ERROR([cannot find windows library files])
+    fi
+fi
+AC_SUBST(windows_libdir)
+]
+)
=20
-AC_DEFUN([LIB_AC_PROG_CC],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CC, gcc, gcc)
-: ${CC:=3Dgcc}
-AC_PROG_CC
-test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
-])
+AC_DEFUN([AC_CYGWIN_INCLUDES], [
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=3D$CXX}
+: ${ac_cv_prog_CC:=3D$CC}
=20
-AC_DEFUN([LIB_AC_PROG_CXX],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CXX, g++, g++)
-if test -z "$CXX"; then
-  AC_CHECK_TOOL(CXX, g++, c++, , , )
-  : ${CXX:=3Dg++}
-  AC_PROG_CXX
-  test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
+cygwin_headers=3D$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    AC_MSG_ERROR([cannot find $winsup_srcdir/cygwin/include directory])
 fi
=20
-CXXFLAGS=3D'$(CFLAGS)'
+newlib_headers=3D$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null &&=
 pwd)
+if test -z "$newlib_headers"; then
+    AC_MSG_ERROR([cannot find newlib source directory: $winsup_srcdir/../n=
ewlib/libc/include])
+fi
+newlib_headers=3D"$target_builddir/newlib/targ-include $newlib_headers"
+
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers=3D"$with_windows_headers"
+    else
+	AC_MSG_ERROR([cannot find windef.h in specified --with-windows-headers pa=
th: $saw_windows_headers]);
+    fi
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers=3D"$winsup_srcdir/w32api/include"
+else
+    windows_headers=3D$(cd $($ac_cv_prog_CC -xc /dev/null -E -include wind=
ef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1=
) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	AC_MSG_ERROR([cannot find windows header files])
+    fi
+fi
+CC=3D$ac_cv_prog_CC
+CXX=3D$ac_cv_prog_CXX
+export CC
+export CXX
+AC_SUBST(windows_headers)
+AC_SUBST(newlib_headers)
+AC_SUBST(cygwin_headers)
 ])
+
+AC_DEFUN([AC_CONFIGURE_ARGS], [
+configure_args=3DX
+for f in $ac_configure_args; do
+    case "$f" in
+	*--srcdir*) ;;
+	*) configure_args=3D"$configure_args $f" ;;
+    esac
+done
+configure_args=3D$(/usr/bin/expr "$configure_args" : 'X \(.*\)')
+AC_SUBST(configure_args)
+])
+
+AC_SUBST(target_builddir)
+AC_SUBST(winsup_srcdir)
Index: aclocal.m4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/aclocal.m4,v
retrieving revision 1.2
diff -d -u -p -r1.2 aclocal.m4
--- aclocal.m4	30 Aug 2006 13:05:46 -0000	1.2
+++ aclocal.m4	13 Nov 2012 18:15:20 -0000
@@ -11,66 +11,4 @@
 # even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 # PARTICULAR PURPOSE.
=20
-# GCC_NO_EXECUTABLES
-# -----------------
-# FIXME: The GCC team has specific needs which the current Autoconf
-# framework cannot solve elegantly.  This macro implements a dirty
-# hack until Autoconf is able to provide the services its users
-# need.
-#
-# Several of the support libraries that are often built with GCC can't
-# assume the tool-chain is already capable of linking a program: the
-# compiler often expects to be able to link with some of such
-# libraries.
-#
-# In several of these libraries, workarounds have been introduced to
-# avoid the AC_PROG_CC_WORKS test, that would just abort their
-# configuration.  The introduction of AC_EXEEXT, enabled either by
-# libtool or by CVS autoconf, have just made matters worse.
-#
-# Unlike the previous AC_NO_EXECUTABLES, this test does not
-# disable link tests at autoconf time, but at configure time.
-# This allows AC_NO_EXECUTABLES to be invoked conditionally.
-AC_DEFUN_ONCE([GCC_NO_EXECUTABLES],
-[m4_divert_push([KILL])
-
-AC_BEFORE([$0], [_AC_COMPILER_EXEEXT])
-AC_BEFORE([$0], [AC_LINK_IFELSE])
-
-m4_define([_AC_COMPILER_EXEEXT],
-AC_LANG_CONFTEST([AC_LANG_PROGRAM()])
-# FIXME: Cleanup?
-AS_IF([AC_TRY_EVAL(ac_link)], [gcc_no_link=3Dno], [gcc_no_link=3Dyes])
-if test x$gcc_no_link =3D xyes; then
-  # Setting cross_compile will disable run tests; it will
-  # also disable AC_CHECK_FILE but that's generally
-  # correct if we can't link.
-  cross_compiling=3Dyes
-  EXEEXT=3D
-else
-  m4_defn([_AC_COMPILER_EXEEXT])dnl
-fi
-)
-
-m4_define([AC_LINK_IFELSE],
-if test x$gcc_no_link =3D xyes; then
-  AC_MSG_ERROR([Link tests are not allowed after [[$0]].])
-fi
-m4_defn([AC_LINK_IFELSE]))
-
-dnl This is a shame.  We have to provide a default for some link tests,
-dnl similar to the default for run tests.
-m4_define([AC_FUNC_MMAP],
-if test x$gcc_no_link =3D xyes; then
-  if test "x${ac_cv_func_mmap_fixed_mapped+set}" !=3D xset; then
-    ac_cv_func_mmap_fixed_mapped=3Dno
-  fi
-fi
-if test "x${ac_cv_func_mmap_fixed_mapped}" !=3D xno; then
-  m4_defn([AC_FUNC_MMAP])
-fi)
-
-m4_divert_pop()dnl
-])# GCC_NO_EXECUTABLES
-
 m4_include([acinclude.m4])
Index: autogen.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: autogen.sh
diff -N autogen.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ autogen.sh	13 Nov 2012 18:15:20 -0000
@@ -0,0 +1,17 @@
+#!/bin/sh -e
+if ! /usr/bin/test -e config.guess; then
+    /usr/bin/wget -q -O config.guess 'http://git.savannah.gnu.org/gitweb/?=
p=3Dconfig.git;a=3Dblob_plain;f=3Dconfig.guess;hb=3DHEAD'
+    /bin/chmod a+x config.guess
+fi
+if ! /usr/bin/test -e config.sub; then
+    /usr/bin/wget -q -O config.sub 'http://git.savannah.gnu.org/gitweb/?p=
=3Dconfig.git;a=3Dblob_plain;f=3Dconfig.sub;hb=3DHEAD'
+    /bin/chmod a+x config.sub
+fi
+/usr/bin/aclocal --force
+/usr/bin/autoconf -f
+/bin/rm -rf autom4te.cache
+res=3D0
+for d in cygwin utils cygserver; do
+    (cd $d && exec ./autogen.sh) || res=3D1
+done
+exit $res
Index: c++wrap
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: c++wrap
diff -N c++wrap
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ c++wrap	13 Nov 2012 18:15:20 -0000
@@ -0,0 +1,6 @@
+#!/usr/bin/perl
+use strict;
+use File::Basename;
+my $pgm =3D basename($0);
+(my $wrapper =3D $pgm) =3D~ s/\+\+/c/o;
+exec $wrapper, '++', @ARGV;
Index: ccwrap
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: ccwrap
diff -N ccwrap
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ ccwrap	13 Nov 2012 18:15:20 -0000
@@ -0,0 +1,48 @@
+#!/usr/bin/perl
+use Cwd;
+use strict;
+my @compiler =3D ();
+my $cxx;
+if ($ARGV[0] ne '++') {
+    @compiler =3D ($ENV{CC} || 'i686-pc-cygwin-gcc');
+    $cxx =3D 0;
+} else {
+    @compiler =3D ($ENV{CXX} || 'i686-pc-cygwin-g++');
+    shift @ARGV;
+    $cxx =3D 1;
+}
+if ("@ARGV" !~ / -nostdinc/o) {
+    my $fd;
+    push @compiler, ($cxx ? '-xc++' : '-xc');
+    if (!open $fd, '-|') {
+	open STDERR, '>&', \*STDOUT;
+	exec @compiler, '/dev/null', '-v', '-E', '-o', '/dev/null' or die "*** er=
ror execing $compiler[0] - $!\n";
+    }
+    $compiler[1] =3D~ s/xc/nostdinc/o;
+    push @compiler, '-nostdinc' if $cxx;
+    push @compiler, '-I' . $_ for split ' ', $ENV{CCWRAP_HEADERS};
+    push @compiler, '-isystem', $_ for split ' ', $ENV{CCWRAP_SYSTEM_HEADE=
RS};
+    my $finding_paths =3D 0;
+    while (<$fd>) {
+	if (/^\*\*\*/o) {
+	    print;
+	} elsif ($_ eq "#include <...> search starts here:\n") {
+	    $finding_paths =3D 1;
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
+    push @compiler, '-isystem', $_ for split ' ', $ENV{CCWRAP_DIRAFTER_HEA=
DERS};
+    close $fd;
+}
+
+push @compiler, @ARGV;
+
+print join(' ', '+', @compiler), "\n" if $ENV{CCWRAP_VERBOSE};
+exec @compiler or die "$0: $compiler[0] failed to execute\n";
Index: config.guess
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: config.guess
diff -N config.guess
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ config.guess	13 Nov 2012 18:15:20 -0000
@@ -0,0 +1,1537 @@
+#! /bin/sh
+# Attempt to guess a canonical system name.
+#   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
+#   2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,
+#   2011, 2012 Free Software Foundation, Inc.
+
+timestamp=3D'2012-09-25'
+
+# This file is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# As a special exception to the GNU General Public License, if you
+# distribute this file as part of a program that contains a
+# configuration script generated by Autoconf, you may include it under
+# the same distribution terms that you use for the rest of that program.
+
+
+# Originally written by Per Bothner.  Please send patches (context
+# diff format) to <config-patches@gnu.org> and include a ChangeLog
+# entry.
+#
+# This script attempts to guess a canonical system name similar to
+# config.sub.  If it succeeds, it prints the system name on stdout, and
+# exits with 0.  Otherwise, it exits with 1.
+#
+# You can get the latest version of this script from:
+# http://git.savannah.gnu.org/gitweb/?p=3Dconfig.git;a=3Dblob_plain;f=3Dco=
nfig.guess;hb=3DHEAD
+
+me=3D`echo "$0" | sed -e 's,.*/,,'`
+
+usage=3D"\
+Usage: $0 [OPTION]
+
+Output the configuration name of the system \`$me' is run on.
+
+Operation modes:
+  -h, --help         print this help, then exit
+  -t, --time-stamp   print date of last modification, then exit
+  -v, --version      print version number, then exit
+
+Report bugs and patches to <config-patches@gnu.org>."
+
+version=3D"\
+GNU config.guess ($timestamp)
+
+Originally written by Per Bothner.
+Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000,
+2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012
+Free Software Foundation, Inc.
+
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
."
+
+help=3D"
+Try \`$me --help' for more information."
+
+# Parse command line
+while test $# -gt 0 ; do
+  case $1 in
+    --time-stamp | --time* | -t )
+       echo "$timestamp" ; exit ;;
+    --version | -v )
+       echo "$version" ; exit ;;
+    --help | --h* | -h )
+       echo "$usage"; exit ;;
+    -- )     # Stop option processing
+       shift; break ;;
+    - )	# Use stdin as input.
+       break ;;
+    -* )
+       echo "$me: invalid option $1$help" >&2
+       exit 1 ;;
+    * )
+       break ;;
+  esac
+done
+
+if test $# !=3D 0; then
+  echo "$me: too many arguments$help" >&2
+  exit 1
+fi
+
+trap 'exit 1' 1 2 15
+
+# CC_FOR_BUILD -- compiler used by this script. Note that the use of a
+# compiler to aid in system detection is discouraged as it requires
+# temporary files to be created and, as you can see below, it is a
+# headache to deal with in a portable fashion.
+
+# Historically, `CC_FOR_BUILD' used to be named `HOST_CC'. We still
+# use `HOST_CC' if defined, but it is deprecated.
+
+# Portable tmp directory creation inspired by the Autoconf team.
+
+set_cc_for_build=3D'
+trap "exitcode=3D\$?; (rm -f \$tmpfiles 2>/dev/null; rmdir \$tmp 2>/dev/nu=
ll) && exit \$exitcode" 0 ;
+trap "rm -f \$tmpfiles 2>/dev/null; rmdir \$tmp 2>/dev/null; exit 1" 1 2 1=
3 15 ;
+: ${TMPDIR=3D/tmp} ;
+ { tmp=3D`(umask 077 && mktemp -d "$TMPDIR/cgXXXXXX") 2>/dev/null` && test=
 -n "$tmp" && test -d "$tmp" ; } ||
+ { test -n "$RANDOM" && tmp=3D$TMPDIR/cg$$-$RANDOM && (umask 077 && mkdir =
$tmp) ; } ||
+ { tmp=3D$TMPDIR/cg-$$ && (umask 077 && mkdir $tmp) && echo "Warning: crea=
ting insecure temp directory" >&2 ; } ||
+ { echo "$me: cannot create a temporary directory in $TMPDIR" >&2 ; exit 1=
 ; } ;
+dummy=3D$tmp/dummy ;
+tmpfiles=3D"$dummy.c $dummy.o $dummy.rel $dummy" ;
+case $CC_FOR_BUILD,$HOST_CC,$CC in
+ ,,)    echo "int x;" > $dummy.c ;
+	for c in cc gcc c89 c99 ; do
+	  if ($c -c -o $dummy.o $dummy.c) >/dev/null 2>&1 ; then
+	     CC_FOR_BUILD=3D"$c"; break ;
+	  fi ;
+	done ;
+	if test x"$CC_FOR_BUILD" =3D x ; then
+	  CC_FOR_BUILD=3Dno_compiler_found ;
+	fi
+	;;
+ ,,*)   CC_FOR_BUILD=3D$CC ;;
+ ,*,*)  CC_FOR_BUILD=3D$HOST_CC ;;
+esac ; set_cc_for_build=3D ;'
+
+# This is needed to find uname on a Pyramid OSx when run in the BSD univer=
se.
+# (ghazi@noc.rutgers.edu 1994-08-24)
+if (test -f /.attbin/uname) >/dev/null 2>&1 ; then
+	PATH=3D$PATH:/.attbin ; export PATH
+fi
+
+UNAME_MACHINE=3D`(uname -m) 2>/dev/null` || UNAME_MACHINE=3Dunknown
+UNAME_RELEASE=3D`(uname -r) 2>/dev/null` || UNAME_RELEASE=3Dunknown
+UNAME_SYSTEM=3D`(uname -s) 2>/dev/null`  || UNAME_SYSTEM=3Dunknown
+UNAME_VERSION=3D`(uname -v) 2>/dev/null` || UNAME_VERSION=3Dunknown
+
+# Note: order is significant - the case branches are not exclusive.
+
+case "${UNAME_MACHINE}:${UNAME_SYSTEM}:${UNAME_RELEASE}:${UNAME_VERSION}" =
in
+    *:NetBSD:*:*)
+	# NetBSD (nbsd) targets should (where applicable) match one or
+	# more of the tuples: *-*-netbsdelf*, *-*-netbsdaout*,
+	# *-*-netbsdecoff* and *-*-netbsd*.  For targets that recently
+	# switched to ELF, *-*-netbsd* would select the old
+	# object file format.  This provides both forward
+	# compatibility and a consistent mechanism for selecting the
+	# object file format.
+	#
+	# Note: NetBSD doesn't particularly care about the vendor
+	# portion of the name.  We always set it to "unknown".
+	sysctl=3D"sysctl -n hw.machine_arch"
+	UNAME_MACHINE_ARCH=3D`(/sbin/$sysctl 2>/dev/null || \
+	    /usr/sbin/$sysctl 2>/dev/null || echo unknown)`
+	case "${UNAME_MACHINE_ARCH}" in
+	    armeb) machine=3Darmeb-unknown ;;
+	    arm*) machine=3Darm-unknown ;;
+	    sh3el) machine=3Dshl-unknown ;;
+	    sh3eb) machine=3Dsh-unknown ;;
+	    sh5el) machine=3Dsh5le-unknown ;;
+	    *) machine=3D${UNAME_MACHINE_ARCH}-unknown ;;
+	esac
+	# The Operating System including object format, if it has switched
+	# to ELF recently, or will in the future.
+	case "${UNAME_MACHINE_ARCH}" in
+	    arm*|i386|m68k|ns32k|sh3*|sparc|vax)
+		eval $set_cc_for_build
+		if echo __ELF__ | $CC_FOR_BUILD -E - 2>/dev/null \
+			| grep -q __ELF__
+		then
+		    # Once all utilities can be ECOFF (netbsdecoff) or a.out (netbsdaout=
).
+		    # Return netbsd for either.  FIX?
+		    os=3Dnetbsd
+		else
+		    os=3Dnetbsdelf
+		fi
+		;;
+	    *)
+		os=3Dnetbsd
+		;;
+	esac
+	# The OS release
+	# Debian GNU/NetBSD machines have a different userland, and
+	# thus, need a distinct triplet. However, they do not need
+	# kernel version information, so it can be replaced with a
+	# suitable tag, in the style of linux-gnu.
+	case "${UNAME_VERSION}" in
+	    Debian*)
+		release=3D'-gnu'
+		;;
+	    *)
+		release=3D`echo ${UNAME_RELEASE}|sed -e 's/[-_].*/\./'`
+		;;
+	esac
+	# Since CPU_TYPE-MANUFACTURER-KERNEL-OPERATING_SYSTEM:
+	# contains redundant information, the shorter form:
+	# CPU_TYPE-MANUFACTURER-OPERATING_SYSTEM is used.
+	echo "${machine}-${os}${release}"
+	exit ;;
+    *:Bitrig:*:*)
+	UNAME_MACHINE_ARCH=3D`arch | sed 's/Bitrig.//'`
+	echo ${UNAME_MACHINE_ARCH}-unknown-bitrig${UNAME_RELEASE}
+	exit ;;
+    *:OpenBSD:*:*)
+	UNAME_MACHINE_ARCH=3D`arch | sed 's/OpenBSD.//'`
+	echo ${UNAME_MACHINE_ARCH}-unknown-openbsd${UNAME_RELEASE}
+	exit ;;
+    *:ekkoBSD:*:*)
+	echo ${UNAME_MACHINE}-unknown-ekkobsd${UNAME_RELEASE}
+	exit ;;
+    *:SolidBSD:*:*)
+	echo ${UNAME_MACHINE}-unknown-solidbsd${UNAME_RELEASE}
+	exit ;;
+    macppc:MirBSD:*:*)
+	echo powerpc-unknown-mirbsd${UNAME_RELEASE}
+	exit ;;
+    *:MirBSD:*:*)
+	echo ${UNAME_MACHINE}-unknown-mirbsd${UNAME_RELEASE}
+	exit ;;
+    alpha:OSF1:*:*)
+	case $UNAME_RELEASE in
+	*4.0)
+		UNAME_RELEASE=3D`/usr/sbin/sizer -v | awk '{print $3}'`
+		;;
+	*5.*)
+		UNAME_RELEASE=3D`/usr/sbin/sizer -v | awk '{print $4}'`
+		;;
+	esac
+	# According to Compaq, /usr/sbin/psrinfo has been available on
+	# OSF/1 and Tru64 systems produced since 1995.  I hope that
+	# covers most systems running today.  This code pipes the CPU
+	# types through head -n 1, so we only detect the type of CPU 0.
+	ALPHA_CPU_TYPE=3D`/usr/sbin/psrinfo -v | sed -n -e 's/^  The alpha \(.*\)=
 processor.*$/\1/p' | head -n 1`
+	case "$ALPHA_CPU_TYPE" in
+	    "EV4 (21064)")
+		UNAME_MACHINE=3D"alpha" ;;
+	    "EV4.5 (21064)")
+		UNAME_MACHINE=3D"alpha" ;;
+	    "LCA4 (21066/21068)")
+		UNAME_MACHINE=3D"alpha" ;;
+	    "EV5 (21164)")
+		UNAME_MACHINE=3D"alphaev5" ;;
+	    "EV5.6 (21164A)")
+		UNAME_MACHINE=3D"alphaev56" ;;
+	    "EV5.6 (21164PC)")
+		UNAME_MACHINE=3D"alphapca56" ;;
+	    "EV5.7 (21164PC)")
+		UNAME_MACHINE=3D"alphapca57" ;;
+	    "EV6 (21264)")
+		UNAME_MACHINE=3D"alphaev6" ;;
+	    "EV6.7 (21264A)")
+		UNAME_MACHINE=3D"alphaev67" ;;
+	    "EV6.8CB (21264C)")
+		UNAME_MACHINE=3D"alphaev68" ;;
+	    "EV6.8AL (21264B)")
+		UNAME_MACHINE=3D"alphaev68" ;;
+	    "EV6.8CX (21264D)")
+		UNAME_MACHINE=3D"alphaev68" ;;
+	    "EV6.9A (21264/EV69A)")
+		UNAME_MACHINE=3D"alphaev69" ;;
+	    "EV7 (21364)")
+		UNAME_MACHINE=3D"alphaev7" ;;
+	    "EV7.9 (21364A)")
+		UNAME_MACHINE=3D"alphaev79" ;;
+	esac
+	# A Pn.n version is a patched version.
+	# A Vn.n version is a released version.
+	# A Tn.n version is a released field test version.
+	# A Xn.n version is an unreleased experimental baselevel.
+	# 1.2 uses "1.2" for uname -r.
+	echo ${UNAME_MACHINE}-dec-osf`echo ${UNAME_RELEASE} | sed -e 's/^[PVTX]//=
' | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz'`
+	# Reset EXIT trap before exiting to avoid spurious non-zero exit code.
+	exitcode=3D$?
+	trap '' 0
+	exit $exitcode ;;
+    Alpha\ *:Windows_NT*:*)
+	# How do we know it's Interix rather than the generic POSIX subsystem?
+	# Should we change UNAME_MACHINE based on the output of uname instead
+	# of the specific Alpha model?
+	echo alpha-pc-interix
+	exit ;;
+    21064:Windows_NT:50:3)
+	echo alpha-dec-winnt3.5
+	exit ;;
+    Amiga*:UNIX_System_V:4.0:*)
+	echo m68k-unknown-sysv4
+	exit ;;
+    *:[Aa]miga[Oo][Ss]:*:*)
+	echo ${UNAME_MACHINE}-unknown-amigaos
+	exit ;;
+    *:[Mm]orph[Oo][Ss]:*:*)
+	echo ${UNAME_MACHINE}-unknown-morphos
+	exit ;;
+    *:OS/390:*:*)
+	echo i370-ibm-openedition
+	exit ;;
+    *:z/VM:*:*)
+	echo s390-ibm-zvmoe
+	exit ;;
+    *:OS400:*:*)
+	echo powerpc-ibm-os400
+	exit ;;
+    arm:RISC*:1.[012]*:*|arm:riscix:1.[012]*:*)
+	echo arm-acorn-riscix${UNAME_RELEASE}
+	exit ;;
+    arm*:riscos:*:*|arm*:RISCOS:*:*)
+	echo arm-unknown-riscos
+	exit ;;
+    SR2?01:HI-UX/MPP:*:* | SR8000:HI-UX/MPP:*:*)
+	echo hppa1.1-hitachi-hiuxmpp
+	exit ;;
+    Pyramid*:OSx*:*:* | MIS*:OSx*:*:* | MIS*:SMP_DC-OSx*:*:*)
+	# akee@wpdis03.wpafb.af.mil (Earle F. Ake) contributed MIS and NILE.
+	if test "`(/bin/universe) 2>/dev/null`" =3D att ; then
+		echo pyramid-pyramid-sysv3
+	else
+		echo pyramid-pyramid-bsd
+	fi
+	exit ;;
+    NILE*:*:*:dcosx)
+	echo pyramid-pyramid-svr4
+	exit ;;
+    DRS?6000:unix:4.0:6*)
+	echo sparc-icl-nx6
+	exit ;;
+    DRS?6000:UNIX_SV:4.2*:7* | DRS?6000:isis:4.2*:7*)
+	case `/usr/bin/uname -p` in
+	    sparc) echo sparc-icl-nx7; exit ;;
+	esac ;;
+    s390x:SunOS:*:*)
+	echo ${UNAME_MACHINE}-ibm-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*/=
/'`
+	exit ;;
+    sun4H:SunOS:5.*:*)
+	echo sparc-hal-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit ;;
+    sun4*:SunOS:5.*:* | tadpole*:SunOS:5.*:*)
+	echo sparc-sun-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit ;;
+    i86pc:AuroraUX:5.*:* | i86xen:AuroraUX:5.*:*)
+	echo i386-pc-auroraux${UNAME_RELEASE}
+	exit ;;
+    i86pc:SunOS:5.*:* | i86xen:SunOS:5.*:*)
+	eval $set_cc_for_build
+	SUN_ARCH=3D"i386"
+	# If there is a compiler, see if it is configured for 64-bit objects.
+	# Note that the Sun cc does not turn __LP64__ into 1 like gcc does.
+	# This test works for both compilers.
+	if [ "$CC_FOR_BUILD" !=3D 'no_compiler_found' ]; then
+	    if (echo '#ifdef __amd64'; echo IS_64BIT_ARCH; echo '#endif') | \
+		(CCOPTS=3D $CC_FOR_BUILD -E - 2>/dev/null) | \
+		grep IS_64BIT_ARCH >/dev/null
+	    then
+		SUN_ARCH=3D"x86_64"
+	    fi
+	fi
+	echo ${SUN_ARCH}-pc-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit ;;
+    sun4*:SunOS:6*:*)
+	# According to config.sub, this is the proper way to canonicalize
+	# SunOS6.  Hard to guess exactly what SunOS6 will be like, but
+	# it's likely to be more like Solaris than SunOS4.
+	echo sparc-sun-solaris3`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit ;;
+    sun4*:SunOS:*:*)
+	case "`/usr/bin/arch -k`" in
+	    Series*|S4*)
+		UNAME_RELEASE=3D`uname -v`
+		;;
+	esac
+	# Japanese Language versions have a version number like `4.1.3-JL'.
+	echo sparc-sun-sunos`echo ${UNAME_RELEASE}|sed -e 's/-/_/'`
+	exit ;;
+    sun3*:SunOS:*:*)
+	echo m68k-sun-sunos${UNAME_RELEASE}
+	exit ;;
+    sun*:*:4.2BSD:*)
+	UNAME_RELEASE=3D`(sed 1q /etc/motd | awk '{print substr($5,1,3)}') 2>/dev=
/null`
+	test "x${UNAME_RELEASE}" =3D "x" && UNAME_RELEASE=3D3
+	case "`/bin/arch`" in
+	    sun3)
+		echo m68k-sun-sunos${UNAME_RELEASE}
+		;;
+	    sun4)
+		echo sparc-sun-sunos${UNAME_RELEASE}
+		;;
+	esac
+	exit ;;
+    aushp:SunOS:*:*)
+	echo sparc-auspex-sunos${UNAME_RELEASE}
+	exit ;;
+    # The situation for MiNT is a little confusing.  The machine name
+    # can be virtually everything (everything which is not
+    # "atarist" or "atariste" at least should have a processor
+    # > m68000).  The system name ranges from "MiNT" over "FreeMiNT"
+    # to the lowercase version "mint" (or "freemint").  Finally
+    # the system name "TOS" denotes a system which is actually not
+    # MiNT.  But MiNT is downward compatible to TOS, so this should
+    # be no problem.
+    atarist[e]:*MiNT:*:* | atarist[e]:*mint:*:* | atarist[e]:*TOS:*:*)
+	echo m68k-atari-mint${UNAME_RELEASE}
+	exit ;;
+    atari*:*MiNT:*:* | atari*:*mint:*:* | atarist[e]:*TOS:*:*)
+	echo m68k-atari-mint${UNAME_RELEASE}
+	exit ;;
+    *falcon*:*MiNT:*:* | *falcon*:*mint:*:* | *falcon*:*TOS:*:*)
+	echo m68k-atari-mint${UNAME_RELEASE}
+	exit ;;
+    milan*:*MiNT:*:* | milan*:*mint:*:* | *milan*:*TOS:*:*)
+	echo m68k-milan-mint${UNAME_RELEASE}
+	exit ;;
+    hades*:*MiNT:*:* | hades*:*mint:*:* | *hades*:*TOS:*:*)
+	echo m68k-hades-mint${UNAME_RELEASE}
+	exit ;;
+    *:*MiNT:*:* | *:*mint:*:* | *:*TOS:*:*)
+	echo m68k-unknown-mint${UNAME_RELEASE}
+	exit ;;
+    m68k:machten:*:*)
+	echo m68k-apple-machten${UNAME_RELEASE}
+	exit ;;
+    powerpc:machten:*:*)
+	echo powerpc-apple-machten${UNAME_RELEASE}
+	exit ;;
+    RISC*:Mach:*:*)
+	echo mips-dec-mach_bsd4.3
+	exit ;;
+    RISC*:ULTRIX:*:*)
+	echo mips-dec-ultrix${UNAME_RELEASE}
+	exit ;;
+    VAX*:ULTRIX*:*:*)
+	echo vax-dec-ultrix${UNAME_RELEASE}
+	exit ;;
+    2020:CLIX:*:* | 2430:CLIX:*:*)
+	echo clipper-intergraph-clix${UNAME_RELEASE}
+	exit ;;
+    mips:*:*:UMIPS | mips:*:*:RISCos)
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+#ifdef __cplusplus
+#include <stdio.h>  /* for printf() prototype */
+	int main (int argc, char *argv[]) {
+#else
+	int main (argc, argv) int argc; char *argv[]; {
+#endif
+	#if defined (host_mips) && defined (MIPSEB)
+	#if defined (SYSTYPE_SYSV)
+	  printf ("mips-mips-riscos%ssysv\n", argv[1]); exit (0);
+	#endif
+	#if defined (SYSTYPE_SVR4)
+	  printf ("mips-mips-riscos%ssvr4\n", argv[1]); exit (0);
+	#endif
+	#if defined (SYSTYPE_BSD43) || defined(SYSTYPE_BSD)
+	  printf ("mips-mips-riscos%sbsd\n", argv[1]); exit (0);
+	#endif
+	#endif
+	  exit (-1);
+	}
+EOF
+	$CC_FOR_BUILD -o $dummy $dummy.c &&
+	  dummyarg=3D`echo "${UNAME_RELEASE}" | sed -n 's/\([0-9]*\).*/\1/p'` &&
+	  SYSTEM_NAME=3D`$dummy $dummyarg` &&
+	    { echo "$SYSTEM_NAME"; exit; }
+	echo mips-mips-riscos${UNAME_RELEASE}
+	exit ;;
+    Motorola:PowerMAX_OS:*:*)
+	echo powerpc-motorola-powermax
+	exit ;;
+    Motorola:*:4.3:PL8-*)
+	echo powerpc-harris-powermax
+	exit ;;
+    Night_Hawk:*:*:PowerMAX_OS | Synergy:PowerMAX_OS:*:*)
+	echo powerpc-harris-powermax
+	exit ;;
+    Night_Hawk:Power_UNIX:*:*)
+	echo powerpc-harris-powerunix
+	exit ;;
+    m88k:CX/UX:7*:*)
+	echo m88k-harris-cxux7
+	exit ;;
+    m88k:*:4*:R4*)
+	echo m88k-motorola-sysv4
+	exit ;;
+    m88k:*:3*:R3*)
+	echo m88k-motorola-sysv3
+	exit ;;
+    AViiON:dgux:*:*)
+	# DG/UX returns AViiON for all architectures
+	UNAME_PROCESSOR=3D`/usr/bin/uname -p`
+	if [ $UNAME_PROCESSOR =3D mc88100 ] || [ $UNAME_PROCESSOR =3D mc88110 ]
+	then
+	    if [ ${TARGET_BINARY_INTERFACE}x =3D m88kdguxelfx ] || \
+	       [ ${TARGET_BINARY_INTERFACE}x =3D x ]
+	    then
+		echo m88k-dg-dgux${UNAME_RELEASE}
+	    else
+		echo m88k-dg-dguxbcs${UNAME_RELEASE}
+	    fi
+	else
+	    echo i586-dg-dgux${UNAME_RELEASE}
+	fi
+	exit ;;
+    M88*:DolphinOS:*:*)	# DolphinOS (SVR3)
+	echo m88k-dolphin-sysv3
+	exit ;;
+    M88*:*:R3*:*)
+	# Delta 88k system running SVR3
+	echo m88k-motorola-sysv3
+	exit ;;
+    XD88*:*:*:*) # Tektronix XD88 system running UTekV (SVR3)
+	echo m88k-tektronix-sysv3
+	exit ;;
+    Tek43[0-9][0-9]:UTek:*:*) # Tektronix 4300 system running UTek (BSD)
+	echo m68k-tektronix-bsd
+	exit ;;
+    *:IRIX*:*:*)
+	echo mips-sgi-irix`echo ${UNAME_RELEASE}|sed -e 's/-/_/g'`
+	exit ;;
+    ????????:AIX?:[12].1:2)   # AIX 2.2.1 or AIX 2.1.1 is RT/PC AIX.
+	echo romp-ibm-aix     # uname -m gives an 8 hex-code CPU id
+	exit ;;               # Note that: echo "'`uname -s`'" gives 'AIX '
+    i*86:AIX:*:*)
+	echo i386-ibm-aix
+	exit ;;
+    ia64:AIX:*:*)
+	if [ -x /usr/bin/oslevel ] ; then
+		IBM_REV=3D`/usr/bin/oslevel`
+	else
+		IBM_REV=3D${UNAME_VERSION}.${UNAME_RELEASE}
+	fi
+	echo ${UNAME_MACHINE}-ibm-aix${IBM_REV}
+	exit ;;
+    *:AIX:2:3)
+	if grep bos325 /usr/include/stdio.h >/dev/null 2>&1; then
+		eval $set_cc_for_build
+		sed 's/^		//' << EOF >$dummy.c
+		#include <sys/systemcfg.h>
+
+		main()
+			{
+			if (!__power_pc())
+				exit(1);
+			puts("powerpc-ibm-aix3.2.5");
+			exit(0);
+			}
+EOF
+		if $CC_FOR_BUILD -o $dummy $dummy.c && SYSTEM_NAME=3D`$dummy`
+		then
+			echo "$SYSTEM_NAME"
+		else
+			echo rs6000-ibm-aix3.2.5
+		fi
+	elif grep bos324 /usr/include/stdio.h >/dev/null 2>&1; then
+		echo rs6000-ibm-aix3.2.4
+	else
+		echo rs6000-ibm-aix3.2
+	fi
+	exit ;;
+    *:AIX:*:[4567])
+	IBM_CPU_ID=3D`/usr/sbin/lsdev -C -c processor -S available | sed 1q | awk=
 '{ print $1 }'`
+	if /usr/sbin/lsattr -El ${IBM_CPU_ID} | grep ' POWER' >/dev/null 2>&1; th=
en
+		IBM_ARCH=3Drs6000
+	else
+		IBM_ARCH=3Dpowerpc
+	fi
+	if [ -x /usr/bin/oslevel ] ; then
+		IBM_REV=3D`/usr/bin/oslevel`
+	else
+		IBM_REV=3D${UNAME_VERSION}.${UNAME_RELEASE}
+	fi
+	echo ${IBM_ARCH}-ibm-aix${IBM_REV}
+	exit ;;
+    *:AIX:*:*)
+	echo rs6000-ibm-aix
+	exit ;;
+    ibmrt:4.4BSD:*|romp-ibm:BSD:*)
+	echo romp-ibm-bsd4.4
+	exit ;;
+    ibmrt:*BSD:*|romp-ibm:BSD:*)            # covers RT/PC BSD and
+	echo romp-ibm-bsd${UNAME_RELEASE}   # 4.3 with uname added to
+	exit ;;                             # report: romp-ibm BSD 4.3
+    *:BOSX:*:*)
+	echo rs6000-bull-bosx
+	exit ;;
+    DPX/2?00:B.O.S.:*:*)
+	echo m68k-bull-sysv3
+	exit ;;
+    9000/[34]??:4.3bsd:1.*:*)
+	echo m68k-hp-bsd
+	exit ;;
+    hp300:4.4BSD:*:* | 9000/[34]??:4.3bsd:2.*:*)
+	echo m68k-hp-bsd4.4
+	exit ;;
+    9000/[34678]??:HP-UX:*:*)
+	HPUX_REV=3D`echo ${UNAME_RELEASE}|sed -e 's/[^.]*.[0B]*//'`
+	case "${UNAME_MACHINE}" in
+	    9000/31? )            HP_ARCH=3Dm68000 ;;
+	    9000/[34]?? )         HP_ARCH=3Dm68k ;;
+	    9000/[678][0-9][0-9])
+		if [ -x /usr/bin/getconf ]; then
+		    sc_cpu_version=3D`/usr/bin/getconf SC_CPU_VERSION 2>/dev/null`
+		    sc_kernel_bits=3D`/usr/bin/getconf SC_KERNEL_BITS 2>/dev/null`
+		    case "${sc_cpu_version}" in
+		      523) HP_ARCH=3D"hppa1.0" ;; # CPU_PA_RISC1_0
+		      528) HP_ARCH=3D"hppa1.1" ;; # CPU_PA_RISC1_1
+		      532)                      # CPU_PA_RISC2_0
+			case "${sc_kernel_bits}" in
+			  32) HP_ARCH=3D"hppa2.0n" ;;
+			  64) HP_ARCH=3D"hppa2.0w" ;;
+			  '') HP_ARCH=3D"hppa2.0" ;;   # HP-UX 10.20
+			esac ;;
+		    esac
+		fi
+		if [ "${HP_ARCH}" =3D "" ]; then
+		    eval $set_cc_for_build
+		    sed 's/^		//' << EOF >$dummy.c
+
+		#define _HPUX_SOURCE
+		#include <stdlib.h>
+		#include <unistd.h>
+
+		int main ()
+		{
+		#if defined(_SC_KERNEL_BITS)
+		    long bits =3D sysconf(_SC_KERNEL_BITS);
+		#endif
+		    long cpu  =3D sysconf (_SC_CPU_VERSION);
+
+		    switch (cpu)
+			{
+			case CPU_PA_RISC1_0: puts ("hppa1.0"); break;
+			case CPU_PA_RISC1_1: puts ("hppa1.1"); break;
+			case CPU_PA_RISC2_0:
+		#if defined(_SC_KERNEL_BITS)
+			    switch (bits)
+				{
+				case 64: puts ("hppa2.0w"); break;
+				case 32: puts ("hppa2.0n"); break;
+				default: puts ("hppa2.0"); break;
+				} break;
+		#else  /* !defined(_SC_KERNEL_BITS) */
+			    puts ("hppa2.0"); break;
+		#endif
+			default: puts ("hppa1.0"); break;
+			}
+		    exit (0);
+		}
+EOF
+		    (CCOPTS=3D $CC_FOR_BUILD -o $dummy $dummy.c 2>/dev/null) && HP_ARCH=
=3D`$dummy`
+		    test -z "$HP_ARCH" && HP_ARCH=3Dhppa
+		fi ;;
+	esac
+	if [ ${HP_ARCH} =3D "hppa2.0w" ]
+	then
+	    eval $set_cc_for_build
+
+	    # hppa2.0w-hp-hpux* has a 64-bit kernel and a compiler generating
+	    # 32-bit code.  hppa64-hp-hpux* has the same kernel and a compiler
+	    # generating 64-bit code.  GNU and HP use different nomenclature:
+	    #
+	    # $ CC_FOR_BUILD=3Dcc ./config.guess
+	    # =3D> hppa2.0w-hp-hpux11.23
+	    # $ CC_FOR_BUILD=3D"cc +DA2.0w" ./config.guess
+	    # =3D> hppa64-hp-hpux11.23
+
+	    if echo __LP64__ | (CCOPTS=3D $CC_FOR_BUILD -E - 2>/dev/null) |
+		grep -q __LP64__
+	    then
+		HP_ARCH=3D"hppa2.0w"
+	    else
+		HP_ARCH=3D"hppa64"
+	    fi
+	fi
+	echo ${HP_ARCH}-hp-hpux${HPUX_REV}
+	exit ;;
+    ia64:HP-UX:*:*)
+	HPUX_REV=3D`echo ${UNAME_RELEASE}|sed -e 's/[^.]*.[0B]*//'`
+	echo ia64-hp-hpux${HPUX_REV}
+	exit ;;
+    3050*:HI-UX:*:*)
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+	#include <unistd.h>
+	int
+	main ()
+	{
+	  long cpu =3D sysconf (_SC_CPU_VERSION);
+	  /* The order matters, because CPU_IS_HP_MC68K erroneously returns
+	     true for CPU_PA_RISC1_0.  CPU_IS_PA_RISC returns correct
+	     results, however.  */
+	  if (CPU_IS_PA_RISC (cpu))
+	    {
+	      switch (cpu)
+		{
+		  case CPU_PA_RISC1_0: puts ("hppa1.0-hitachi-hiuxwe2"); break;
+		  case CPU_PA_RISC1_1: puts ("hppa1.1-hitachi-hiuxwe2"); break;
+		  case CPU_PA_RISC2_0: puts ("hppa2.0-hitachi-hiuxwe2"); break;
+		  default: puts ("hppa-hitachi-hiuxwe2"); break;
+		}
+	    }
+	  else if (CPU_IS_HP_MC68K (cpu))
+	    puts ("m68k-hitachi-hiuxwe2");
+	  else puts ("unknown-hitachi-hiuxwe2");
+	  exit (0);
+	}
+EOF
+	$CC_FOR_BUILD -o $dummy $dummy.c && SYSTEM_NAME=3D`$dummy` &&
+		{ echo "$SYSTEM_NAME"; exit; }
+	echo unknown-hitachi-hiuxwe2
+	exit ;;
+    9000/7??:4.3bsd:*:* | 9000/8?[79]:4.3bsd:*:* )
+	echo hppa1.1-hp-bsd
+	exit ;;
+    9000/8??:4.3bsd:*:*)
+	echo hppa1.0-hp-bsd
+	exit ;;
+    *9??*:MPE/iX:*:* | *3000*:MPE/iX:*:*)
+	echo hppa1.0-hp-mpeix
+	exit ;;
+    hp7??:OSF1:*:* | hp8?[79]:OSF1:*:* )
+	echo hppa1.1-hp-osf
+	exit ;;
+    hp8??:OSF1:*:*)
+	echo hppa1.0-hp-osf
+	exit ;;
+    i*86:OSF1:*:*)
+	if [ -x /usr/sbin/sysversion ] ; then
+	    echo ${UNAME_MACHINE}-unknown-osf1mk
+	else
+	    echo ${UNAME_MACHINE}-unknown-osf1
+	fi
+	exit ;;
+    parisc*:Lites*:*:*)
+	echo hppa1.1-hp-lites
+	exit ;;
+    C1*:ConvexOS:*:* | convex:ConvexOS:C1*:*)
+	echo c1-convex-bsd
+	exit ;;
+    C2*:ConvexOS:*:* | convex:ConvexOS:C2*:*)
+	if getsysinfo -f scalar_acc
+	then echo c32-convex-bsd
+	else echo c2-convex-bsd
+	fi
+	exit ;;
+    C34*:ConvexOS:*:* | convex:ConvexOS:C34*:*)
+	echo c34-convex-bsd
+	exit ;;
+    C38*:ConvexOS:*:* | convex:ConvexOS:C38*:*)
+	echo c38-convex-bsd
+	exit ;;
+    C4*:ConvexOS:*:* | convex:ConvexOS:C4*:*)
+	echo c4-convex-bsd
+	exit ;;
+    CRAY*Y-MP:*:*:*)
+	echo ymp-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit ;;
+    CRAY*[A-Z]90:*:*:*)
+	echo ${UNAME_MACHINE}-cray-unicos${UNAME_RELEASE} \
+	| sed -e 's/CRAY.*\([A-Z]90\)/\1/' \
+	      -e y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/ \
+	      -e 's/\.[^.]*$/.X/'
+	exit ;;
+    CRAY*TS:*:*:*)
+	echo t90-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit ;;
+    CRAY*T3E:*:*:*)
+	echo alphaev5-cray-unicosmk${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit ;;
+    CRAY*SV1:*:*:*)
+	echo sv1-cray-unicos${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit ;;
+    *:UNICOS/mp:*:*)
+	echo craynv-cray-unicosmp${UNAME_RELEASE} | sed -e 's/\.[^.]*$/.X/'
+	exit ;;
+    F30[01]:UNIX_System_V:*:* | F700:UNIX_System_V:*:*)
+	FUJITSU_PROC=3D`uname -m | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklm=
nopqrstuvwxyz'`
+	FUJITSU_SYS=3D`uname -p | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmn=
opqrstuvwxyz' | sed -e 's/\///'`
+	FUJITSU_REL=3D`echo ${UNAME_RELEASE} | sed -e 's/ /_/'`
+	echo "${FUJITSU_PROC}-fujitsu-${FUJITSU_SYS}${FUJITSU_REL}"
+	exit ;;
+    5000:UNIX_System_V:4.*:*)
+	FUJITSU_SYS=3D`uname -p | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmn=
opqrstuvwxyz' | sed -e 's/\///'`
+	FUJITSU_REL=3D`echo ${UNAME_RELEASE} | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'a=
bcdefghijklmnopqrstuvwxyz' | sed -e 's/ /_/'`
+	echo "sparc-fujitsu-${FUJITSU_SYS}${FUJITSU_REL}"
+	exit ;;
+    i*86:BSD/386:*:* | i*86:BSD/OS:*:* | *:Ascend\ Embedded/OS:*:*)
+	echo ${UNAME_MACHINE}-pc-bsdi${UNAME_RELEASE}
+	exit ;;
+    sparc*:BSD/OS:*:*)
+	echo sparc-unknown-bsdi${UNAME_RELEASE}
+	exit ;;
+    *:BSD/OS:*:*)
+	echo ${UNAME_MACHINE}-unknown-bsdi${UNAME_RELEASE}
+	exit ;;
+    *:FreeBSD:*:*)
+	UNAME_PROCESSOR=3D`/usr/bin/uname -p`
+	case ${UNAME_PROCESSOR} in
+	    amd64)
+		echo x86_64-unknown-freebsd`echo ${UNAME_RELEASE}|sed -e 's/[-(].*//'` ;;
+	    *)
+		echo ${UNAME_PROCESSOR}-unknown-freebsd`echo ${UNAME_RELEASE}|sed -e 's/=
[-(].*//'` ;;
+	esac
+	exit ;;
+    i*:CYGWIN*:*)
+	echo ${UNAME_MACHINE}-pc-cygwin
+	exit ;;
+    *:MINGW64*:*)
+	echo ${UNAME_MACHINE}-pc-mingw64
+	exit ;;
+    *:MINGW*:*)
+	echo ${UNAME_MACHINE}-pc-mingw32
+	exit ;;
+    i*:MSYS*:*)
+	echo ${UNAME_MACHINE}-pc-msys
+	exit ;;
+    i*:windows32*:*)
+	# uname -m includes "-pc" on this system.
+	echo ${UNAME_MACHINE}-mingw32
+	exit ;;
+    i*:PW*:*)
+	echo ${UNAME_MACHINE}-pc-pw32
+	exit ;;
+    *:Interix*:*)
+	case ${UNAME_MACHINE} in
+	    x86)
+		echo i586-pc-interix${UNAME_RELEASE}
+		exit ;;
+	    authenticamd | genuineintel | EM64T)
+		echo x86_64-unknown-interix${UNAME_RELEASE}
+		exit ;;
+	    IA64)
+		echo ia64-unknown-interix${UNAME_RELEASE}
+		exit ;;
+	esac ;;
+    [345]86:Windows_95:* | [345]86:Windows_98:* | [345]86:Windows_NT:*)
+	echo i${UNAME_MACHINE}-pc-mks
+	exit ;;
+    8664:Windows_NT:*)
+	echo x86_64-pc-mks
+	exit ;;
+    i*:Windows_NT*:* | Pentium*:Windows_NT*:*)
+	# How do we know it's Interix rather than the generic POSIX subsystem?
+	# It also conflicts with pre-2.0 versions of AT&T UWIN. Should we
+	# UNAME_MACHINE based on the output of uname instead of i386?
+	echo i586-pc-interix
+	exit ;;
+    i*:UWIN*:*)
+	echo ${UNAME_MACHINE}-pc-uwin
+	exit ;;
+    amd64:CYGWIN*:*:* | x86_64:CYGWIN*:*:*)
+	echo x86_64-unknown-cygwin
+	exit ;;
+    p*:CYGWIN*:*)
+	echo powerpcle-unknown-cygwin
+	exit ;;
+    prep*:SunOS:5.*:*)
+	echo powerpcle-unknown-solaris2`echo ${UNAME_RELEASE}|sed -e 's/[^.]*//'`
+	exit ;;
+    *:GNU:*:*)
+	# the GNU system
+	echo `echo ${UNAME_MACHINE}|sed -e 's,[-/].*$,,'`-unknown-gnu`echo ${UNAM=
E_RELEASE}|sed -e 's,/.*$,,'`
+	exit ;;
+    *:GNU/*:*:*)
+	# other systems with GNU libc and userland
+	echo ${UNAME_MACHINE}-unknown-`echo ${UNAME_SYSTEM} | sed 's,^[^/]*/,,' |=
 tr '[A-Z]' '[a-z]'``echo ${UNAME_RELEASE}|sed -e 's/[-(].*//'`-gnu
+	exit ;;
+    i*86:Minix:*:*)
+	echo ${UNAME_MACHINE}-pc-minix
+	exit ;;
+    aarch64:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    aarch64_be:Linux:*:*)
+	UNAME_MACHINE=3Daarch64_be
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    alpha:Linux:*:*)
+	case `sed -n '/^cpu model/s/^.*: \(.*\)/\1/p' < /proc/cpuinfo` in
+	  EV5)   UNAME_MACHINE=3Dalphaev5 ;;
+	  EV56)  UNAME_MACHINE=3Dalphaev56 ;;
+	  PCA56) UNAME_MACHINE=3Dalphapca56 ;;
+	  PCA57) UNAME_MACHINE=3Dalphapca56 ;;
+	  EV6)   UNAME_MACHINE=3Dalphaev6 ;;
+	  EV67)  UNAME_MACHINE=3Dalphaev67 ;;
+	  EV68*) UNAME_MACHINE=3Dalphaev68 ;;
+	esac
+	objdump --private-headers /bin/sh | grep -q ld.so.1
+	if test "$?" =3D 0 ; then LIBC=3D"libc1" ; else LIBC=3D"" ; fi
+	echo ${UNAME_MACHINE}-unknown-linux-gnu${LIBC}
+	exit ;;
+    arm*:Linux:*:*)
+	eval $set_cc_for_build
+	if echo __ARM_EABI__ | $CC_FOR_BUILD -E - 2>/dev/null \
+	    | grep -q __ARM_EABI__
+	then
+	    echo ${UNAME_MACHINE}-unknown-linux-gnu
+	else
+	    if echo __ARM_PCS_VFP | $CC_FOR_BUILD -E - 2>/dev/null \
+		| grep -q __ARM_PCS_VFP
+	    then
+		echo ${UNAME_MACHINE}-unknown-linux-gnueabi
+	    else
+		echo ${UNAME_MACHINE}-unknown-linux-gnueabihf
+	    fi
+	fi
+	exit ;;
+    avr32*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    cris:Linux:*:*)
+	echo ${UNAME_MACHINE}-axis-linux-gnu
+	exit ;;
+    crisv32:Linux:*:*)
+	echo ${UNAME_MACHINE}-axis-linux-gnu
+	exit ;;
+    frv:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    hexagon:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    i*86:Linux:*:*)
+	LIBC=3Dgnu
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+	#ifdef __dietlibc__
+	LIBC=3Ddietlibc
+	#endif
+EOF
+	eval `$CC_FOR_BUILD -E $dummy.c 2>/dev/null | grep '^LIBC'`
+	echo "${UNAME_MACHINE}-pc-linux-${LIBC}"
+	exit ;;
+    ia64:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    m32r*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    m68*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    mips:Linux:*:* | mips64:Linux:*:*)
+	eval $set_cc_for_build
+	sed 's/^	//' << EOF >$dummy.c
+	#undef CPU
+	#undef ${UNAME_MACHINE}
+	#undef ${UNAME_MACHINE}el
+	#if defined(__MIPSEL__) || defined(__MIPSEL) || defined(_MIPSEL) || defin=
ed(MIPSEL)
+	CPU=3D${UNAME_MACHINE}el
+	#else
+	#if defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || defin=
ed(MIPSEB)
+	CPU=3D${UNAME_MACHINE}
+	#else
+	CPU=3D
+	#endif
+	#endif
+EOF
+	eval `$CC_FOR_BUILD -E $dummy.c 2>/dev/null | grep '^CPU'`
+	test x"${CPU}" !=3D x && { echo "${CPU}-unknown-linux-gnu"; exit; }
+	;;
+    or32:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    padre:Linux:*:*)
+	echo sparc-unknown-linux-gnu
+	exit ;;
+    parisc64:Linux:*:* | hppa64:Linux:*:*)
+	echo hppa64-unknown-linux-gnu
+	exit ;;
+    parisc:Linux:*:* | hppa:Linux:*:*)
+	# Look for CPU level
+	case `grep '^cpu[^a-z]*:' /proc/cpuinfo 2>/dev/null | cut -d' ' -f2` in
+	  PA7*) echo hppa1.1-unknown-linux-gnu ;;
+	  PA8*) echo hppa2.0-unknown-linux-gnu ;;
+	  *)    echo hppa-unknown-linux-gnu ;;
+	esac
+	exit ;;
+    ppc64:Linux:*:*)
+	echo powerpc64-unknown-linux-gnu
+	exit ;;
+    ppc:Linux:*:*)
+	echo powerpc-unknown-linux-gnu
+	exit ;;
+    s390:Linux:*:* | s390x:Linux:*:*)
+	echo ${UNAME_MACHINE}-ibm-linux
+	exit ;;
+    sh64*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    sh*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    sparc:Linux:*:* | sparc64:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    tile*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    vax:Linux:*:*)
+	echo ${UNAME_MACHINE}-dec-linux-gnu
+	exit ;;
+    x86_64:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    xtensa*:Linux:*:*)
+	echo ${UNAME_MACHINE}-unknown-linux-gnu
+	exit ;;
+    i*86:DYNIX/ptx:4*:*)
+	# ptx 4.0 does uname -s correctly, with DYNIX/ptx in there.
+	# earlier versions are messed up and put the nodename in both
+	# sysname and nodename.
+	echo i386-sequent-sysv4
+	exit ;;
+    i*86:UNIX_SV:4.2MP:2.*)
+	# Unixware is an offshoot of SVR4, but it has its own version
+	# number series starting with 2...
+	# I am not positive that other SVR4 systems won't match this,
+	# I just have to hope.  -- rms.
+	# Use sysv4.2uw... so that sysv4* matches it.
+	echo ${UNAME_MACHINE}-pc-sysv4.2uw${UNAME_VERSION}
+	exit ;;
+    i*86:OS/2:*:*)
+	# If we were able to find `uname', then EMX Unix compatibility
+	# is probably installed.
+	echo ${UNAME_MACHINE}-pc-os2-emx
+	exit ;;
+    i*86:XTS-300:*:STOP)
+	echo ${UNAME_MACHINE}-unknown-stop
+	exit ;;
+    i*86:atheos:*:*)
+	echo ${UNAME_MACHINE}-unknown-atheos
+	exit ;;
+    i*86:syllable:*:*)
+	echo ${UNAME_MACHINE}-pc-syllable
+	exit ;;
+    i*86:LynxOS:2.*:* | i*86:LynxOS:3.[01]*:* | i*86:LynxOS:4.[02]*:*)
+	echo i386-unknown-lynxos${UNAME_RELEASE}
+	exit ;;
+    i*86:*DOS:*:*)
+	echo ${UNAME_MACHINE}-pc-msdosdjgpp
+	exit ;;
+    i*86:*:4.*:* | i*86:SYSTEM_V:4.*:*)
+	UNAME_REL=3D`echo ${UNAME_RELEASE} | sed 's/\/MP$//'`
+	if grep Novell /usr/include/link.h >/dev/null 2>/dev/null; then
+		echo ${UNAME_MACHINE}-univel-sysv${UNAME_REL}
+	else
+		echo ${UNAME_MACHINE}-pc-sysv${UNAME_REL}
+	fi
+	exit ;;
+    i*86:*:5:[678]*)
+	# UnixWare 7.x, OpenUNIX and OpenServer 6.
+	case `/bin/uname -X | grep "^Machine"` in
+	    *486*)	     UNAME_MACHINE=3Di486 ;;
+	    *Pentium)	     UNAME_MACHINE=3Di586 ;;
+	    *Pent*|*Celeron) UNAME_MACHINE=3Di686 ;;
+	esac
+	echo ${UNAME_MACHINE}-unknown-sysv${UNAME_RELEASE}${UNAME_SYSTEM}${UNAME_=
VERSION}
+	exit ;;
+    i*86:*:3.2:*)
+	if test -f /usr/options/cb.name; then
+		UNAME_REL=3D`sed -n 's/.*Version //p' </usr/options/cb.name`
+		echo ${UNAME_MACHINE}-pc-isc$UNAME_REL
+	elif /bin/uname -X 2>/dev/null >/dev/null ; then
+		UNAME_REL=3D`(/bin/uname -X|grep Release|sed -e 's/.*=3D //')`
+		(/bin/uname -X|grep i80486 >/dev/null) && UNAME_MACHINE=3Di486
+		(/bin/uname -X|grep '^Machine.*Pentium' >/dev/null) \
+			&& UNAME_MACHINE=3Di586
+		(/bin/uname -X|grep '^Machine.*Pent *II' >/dev/null) \
+			&& UNAME_MACHINE=3Di686
+		(/bin/uname -X|grep '^Machine.*Pentium Pro' >/dev/null) \
+			&& UNAME_MACHINE=3Di686
+		echo ${UNAME_MACHINE}-pc-sco$UNAME_REL
+	else
+		echo ${UNAME_MACHINE}-pc-sysv32
+	fi
+	exit ;;
+    pc:*:*:*)
+	# Left here for compatibility:
+	# uname -m prints for DJGPP always 'pc', but it prints nothing about
+	# the processor, so we play safe by assuming i586.
+	# Note: whatever this is, it MUST be the same as what config.sub
+	# prints for the "djgpp" host, or else GDB configury will decide that
+	# this is a cross-build.
+	echo i586-pc-msdosdjgpp
+	exit ;;
+    Intel:Mach:3*:*)
+	echo i386-pc-mach3
+	exit ;;
+    paragon:*:*:*)
+	echo i860-intel-osf1
+	exit ;;
+    i860:*:4.*:*) # i860-SVR4
+	if grep Stardent /usr/include/sys/uadmin.h >/dev/null 2>&1 ; then
+	  echo i860-stardent-sysv${UNAME_RELEASE} # Stardent Vistra i860-SVR4
+	else # Add other i860-SVR4 vendors below as they are discovered.
+	  echo i860-unknown-sysv${UNAME_RELEASE}  # Unknown i860-SVR4
+	fi
+	exit ;;
+    mini*:CTIX:SYS*5:*)
+	# "miniframe"
+	echo m68010-convergent-sysv
+	exit ;;
+    mc68k:UNIX:SYSTEM5:3.51m)
+	echo m68k-convergent-sysv
+	exit ;;
+    M680?0:D-NIX:5.3:*)
+	echo m68k-diab-dnix
+	exit ;;
+    M68*:*:R3V[5678]*:*)
+	test -r /sysV68 && { echo 'm68k-motorola-sysv'; exit; } ;;
+    3[345]??:*:4.0:3.0 | 3[34]??A:*:4.0:3.0 | 3[34]??,*:*:4.0:3.0 | 3[34]?=
?/*:*:4.0:3.0 | 4400:*:4.0:3.0 | 4850:*:4.0:3.0 | SKA40:*:4.0:3.0 | SDS2:*:=
4.0:3.0 | SHG2:*:4.0:3.0 | S7501*:*:4.0:3.0)
+	OS_REL=3D''
+	test -r /etc/.relid \
+	&& OS_REL=3D.`sed -n 's/[^ ]* [^ ]* \([0-9][0-9]\).*/\1/p' < /etc/.relid`
+	/bin/uname -p 2>/dev/null | grep 86 >/dev/null \
+	  && { echo i486-ncr-sysv4.3${OS_REL}; exit; }
+	/bin/uname -p 2>/dev/null | /bin/grep entium >/dev/null \
+	  && { echo i586-ncr-sysv4.3${OS_REL}; exit; } ;;
+    3[34]??:*:4.0:* | 3[34]??,*:*:4.0:*)
+	/bin/uname -p 2>/dev/null | grep 86 >/dev/null \
+	  && { echo i486-ncr-sysv4; exit; } ;;
+    NCR*:*:4.2:* | MPRAS*:*:4.2:*)
+	OS_REL=3D'.3'
+	test -r /etc/.relid \
+	    && OS_REL=3D.`sed -n 's/[^ ]* [^ ]* \([0-9][0-9]\).*/\1/p' < /etc/.re=
lid`
+	/bin/uname -p 2>/dev/null | grep 86 >/dev/null \
+	    && { echo i486-ncr-sysv4.3${OS_REL}; exit; }
+	/bin/uname -p 2>/dev/null | /bin/grep entium >/dev/null \
+	    && { echo i586-ncr-sysv4.3${OS_REL}; exit; }
+	/bin/uname -p 2>/dev/null | /bin/grep pteron >/dev/null \
+	    && { echo i586-ncr-sysv4.3${OS_REL}; exit; } ;;
+    m68*:LynxOS:2.*:* | m68*:LynxOS:3.0*:*)
+	echo m68k-unknown-lynxos${UNAME_RELEASE}
+	exit ;;
+    mc68030:UNIX_System_V:4.*:*)
+	echo m68k-atari-sysv4
+	exit ;;
+    TSUNAMI:LynxOS:2.*:*)
+	echo sparc-unknown-lynxos${UNAME_RELEASE}
+	exit ;;
+    rs6000:LynxOS:2.*:*)
+	echo rs6000-unknown-lynxos${UNAME_RELEASE}
+	exit ;;
+    PowerPC:LynxOS:2.*:* | PowerPC:LynxOS:3.[01]*:* | PowerPC:LynxOS:4.[02=
]*:*)
+	echo powerpc-unknown-lynxos${UNAME_RELEASE}
+	exit ;;
+    SM[BE]S:UNIX_SV:*:*)
+	echo mips-dde-sysv${UNAME_RELEASE}
+	exit ;;
+    RM*:ReliantUNIX-*:*:*)
+	echo mips-sni-sysv4
+	exit ;;
+    RM*:SINIX-*:*:*)
+	echo mips-sni-sysv4
+	exit ;;
+    *:SINIX-*:*:*)
+	if uname -p 2>/dev/null >/dev/null ; then
+		UNAME_MACHINE=3D`(uname -p) 2>/dev/null`
+		echo ${UNAME_MACHINE}-sni-sysv4
+	else
+		echo ns32k-sni-sysv
+	fi
+	exit ;;
+    PENTIUM:*:4.0*:*)	# Unisys `ClearPath HMP IX 4000' SVR4/MP effort
+			# says <Richard.M.Bartel@ccMail.Census.GOV>
+	echo i586-unisys-sysv4
+	exit ;;
+    *:UNIX_System_V:4*:FTX*)
+	# From Gerald Hewes <hewes@openmarket.com>.
+	# How about differentiating between stratus architectures? -djm
+	echo hppa1.1-stratus-sysv4
+	exit ;;
+    *:*:*:FTX*)
+	# From seanf@swdc.stratus.com.
+	echo i860-stratus-sysv4
+	exit ;;
+    i*86:VOS:*:*)
+	# From Paul.Green@stratus.com.
+	echo ${UNAME_MACHINE}-stratus-vos
+	exit ;;
+    *:VOS:*:*)
+	# From Paul.Green@stratus.com.
+	echo hppa1.1-stratus-vos
+	exit ;;
+    mc68*:A/UX:*:*)
+	echo m68k-apple-aux${UNAME_RELEASE}
+	exit ;;
+    news*:NEWS-OS:6*:*)
+	echo mips-sony-newsos6
+	exit ;;
+    R[34]000:*System_V*:*:* | R4000:UNIX_SYSV:*:* | R*000:UNIX_SV:*:*)
+	if [ -d /usr/nec ]; then
+		echo mips-nec-sysv${UNAME_RELEASE}
+	else
+		echo mips-unknown-sysv${UNAME_RELEASE}
+	fi
+	exit ;;
+    BeBox:BeOS:*:*)	# BeOS running on hardware made by Be, PPC only.
+	echo powerpc-be-beos
+	exit ;;
+    BeMac:BeOS:*:*)	# BeOS running on Mac or Mac clone, PPC only.
+	echo powerpc-apple-beos
+	exit ;;
+    BePC:BeOS:*:*)	# BeOS running on Intel PC compatible.
+	echo i586-pc-beos
+	exit ;;
+    BePC:Haiku:*:*)	# Haiku running on Intel PC compatible.
+	echo i586-pc-haiku
+	exit ;;
+    x86_64:Haiku:*:*)
+	echo x86_64-unknown-haiku
+	exit ;;
+    SX-4:SUPER-UX:*:*)
+	echo sx4-nec-superux${UNAME_RELEASE}
+	exit ;;
+    SX-5:SUPER-UX:*:*)
+	echo sx5-nec-superux${UNAME_RELEASE}
+	exit ;;
+    SX-6:SUPER-UX:*:*)
+	echo sx6-nec-superux${UNAME_RELEASE}
+	exit ;;
+    SX-7:SUPER-UX:*:*)
+	echo sx7-nec-superux${UNAME_RELEASE}
+	exit ;;
+    SX-8:SUPER-UX:*:*)
+	echo sx8-nec-superux${UNAME_RELEASE}
+	exit ;;
+    SX-8R:SUPER-UX:*:*)
+	echo sx8r-nec-superux${UNAME_RELEASE}
+	exit ;;
+    Power*:Rhapsody:*:*)
+	echo powerpc-apple-rhapsody${UNAME_RELEASE}
+	exit ;;
+    *:Rhapsody:*:*)
+	echo ${UNAME_MACHINE}-apple-rhapsody${UNAME_RELEASE}
+	exit ;;
+    *:Darwin:*:*)
+	UNAME_PROCESSOR=3D`uname -p` || UNAME_PROCESSOR=3Dunknown
+	case $UNAME_PROCESSOR in
+	    i386)
+		eval $set_cc_for_build
+		if [ "$CC_FOR_BUILD" !=3D 'no_compiler_found' ]; then
+		  if (echo '#ifdef __LP64__'; echo IS_64BIT_ARCH; echo '#endif') | \
+		      (CCOPTS=3D $CC_FOR_BUILD -E - 2>/dev/null) | \
+		      grep IS_64BIT_ARCH >/dev/null
+		  then
+		      UNAME_PROCESSOR=3D"x86_64"
+		  fi
+		fi ;;
+	    unknown) UNAME_PROCESSOR=3Dpowerpc ;;
+	esac
+	echo ${UNAME_PROCESSOR}-apple-darwin${UNAME_RELEASE}
+	exit ;;
+    *:procnto*:*:* | *:QNX:[0123456789]*:*)
+	UNAME_PROCESSOR=3D`uname -p`
+	if test "$UNAME_PROCESSOR" =3D "x86"; then
+		UNAME_PROCESSOR=3Di386
+		UNAME_MACHINE=3Dpc
+	fi
+	echo ${UNAME_PROCESSOR}-${UNAME_MACHINE}-nto-qnx${UNAME_RELEASE}
+	exit ;;
+    *:QNX:*:4*)
+	echo i386-pc-qnx
+	exit ;;
+    NEO-?:NONSTOP_KERNEL:*:*)
+	echo neo-tandem-nsk${UNAME_RELEASE}
+	exit ;;
+    NSE-*:NONSTOP_KERNEL:*:*)
+	echo nse-tandem-nsk${UNAME_RELEASE}
+	exit ;;
+    NSR-?:NONSTOP_KERNEL:*:*)
+	echo nsr-tandem-nsk${UNAME_RELEASE}
+	exit ;;
+    *:NonStop-UX:*:*)
+	echo mips-compaq-nonstopux
+	exit ;;
+    BS2000:POSIX*:*:*)
+	echo bs2000-siemens-sysv
+	exit ;;
+    DS/*:UNIX_System_V:*:*)
+	echo ${UNAME_MACHINE}-${UNAME_SYSTEM}-${UNAME_RELEASE}
+	exit ;;
+    *:Plan9:*:*)
+	# "uname -m" is not consistent, so use $cputype instead. 386
+	# is converted to i386 for consistency with other x86
+	# operating systems.
+	if test "$cputype" =3D "386"; then
+	    UNAME_MACHINE=3Di386
+	else
+	    UNAME_MACHINE=3D"$cputype"
+	fi
+	echo ${UNAME_MACHINE}-unknown-plan9
+	exit ;;
+    *:TOPS-10:*:*)
+	echo pdp10-unknown-tops10
+	exit ;;
+    *:TENEX:*:*)
+	echo pdp10-unknown-tenex
+	exit ;;
+    KS10:TOPS-20:*:* | KL10:TOPS-20:*:* | TYPE4:TOPS-20:*:*)
+	echo pdp10-dec-tops20
+	exit ;;
+    XKL-1:TOPS-20:*:* | TYPE5:TOPS-20:*:*)
+	echo pdp10-xkl-tops20
+	exit ;;
+    *:TOPS-20:*:*)
+	echo pdp10-unknown-tops20
+	exit ;;
+    *:ITS:*:*)
+	echo pdp10-unknown-its
+	exit ;;
+    SEI:*:*:SEIUX)
+	echo mips-sei-seiux${UNAME_RELEASE}
+	exit ;;
+    *:DragonFly:*:*)
+	echo ${UNAME_MACHINE}-unknown-dragonfly`echo ${UNAME_RELEASE}|sed -e 's/[=
-(].*//'`
+	exit ;;
+    *:*VMS:*:*)
+	UNAME_MACHINE=3D`(uname -p) 2>/dev/null`
+	case "${UNAME_MACHINE}" in
+	    A*) echo alpha-dec-vms ; exit ;;
+	    I*) echo ia64-dec-vms ; exit ;;
+	    V*) echo vax-dec-vms ; exit ;;
+	esac ;;
+    *:XENIX:*:SysV)
+	echo i386-pc-xenix
+	exit ;;
+    i*86:skyos:*:*)
+	echo ${UNAME_MACHINE}-pc-skyos`echo ${UNAME_RELEASE}` | sed -e 's/ .*$//'
+	exit ;;
+    i*86:rdos:*:*)
+	echo ${UNAME_MACHINE}-pc-rdos
+	exit ;;
+    i*86:AROS:*:*)
+	echo ${UNAME_MACHINE}-pc-aros
+	exit ;;
+    x86_64:VMkernel:*:*)
+	echo ${UNAME_MACHINE}-unknown-esx
+	exit ;;
+esac
+
+eval $set_cc_for_build
+cat >$dummy.c <<EOF
+#ifdef _SEQUENT_
+# include <sys/types.h>
+# include <sys/utsname.h>
+#endif
+main ()
+{
+#if defined (sony)
+#if defined (MIPSEB)
+  /* BFD wants "bsd" instead of "newsos".  Perhaps BFD should be changed,
+     I don't know....  */
+  printf ("mips-sony-bsd\n"); exit (0);
+#else
+#include <sys/param.h>
+  printf ("m68k-sony-newsos%s\n",
+#ifdef NEWSOS4
+	"4"
+#else
+	""
+#endif
+	); exit (0);
+#endif
+#endif
+
+#if defined (__arm) && defined (__acorn) && defined (__unix)
+  printf ("arm-acorn-riscix\n"); exit (0);
+#endif
+
+#if defined (hp300) && !defined (hpux)
+  printf ("m68k-hp-bsd\n"); exit (0);
+#endif
+
+#if defined (NeXT)
+#if !defined (__ARCHITECTURE__)
+#define __ARCHITECTURE__ "m68k"
+#endif
+  int version;
+  version=3D`(hostinfo | sed -n 's/.*NeXT Mach \([0-9]*\).*/\1/p') 2>/dev/=
null`;
+  if (version < 4)
+    printf ("%s-next-nextstep%d\n", __ARCHITECTURE__, version);
+  else
+    printf ("%s-next-openstep%d\n", __ARCHITECTURE__, version);
+  exit (0);
+#endif
+
+#if defined (MULTIMAX) || defined (n16)
+#if defined (UMAXV)
+  printf ("ns32k-encore-sysv\n"); exit (0);
+#else
+#if defined (CMU)
+  printf ("ns32k-encore-mach\n"); exit (0);
+#else
+  printf ("ns32k-encore-bsd\n"); exit (0);
+#endif
+#endif
+#endif
+
+#if defined (__386BSD__)
+  printf ("i386-pc-bsd\n"); exit (0);
+#endif
+
+#if defined (sequent)
+#if defined (i386)
+  printf ("i386-sequent-dynix\n"); exit (0);
+#endif
+#if defined (ns32000)
+  printf ("ns32k-sequent-dynix\n"); exit (0);
+#endif
+#endif
+
+#if defined (_SEQUENT_)
+    struct utsname un;
+
+    uname(&un);
+
+    if (strncmp(un.version, "V2", 2) =3D=3D 0) {
+	printf ("i386-sequent-ptx2\n"); exit (0);
+    }
+    if (strncmp(un.version, "V1", 2) =3D=3D 0) { /* XXX is V1 correct? */
+	printf ("i386-sequent-ptx1\n"); exit (0);
+    }
+    printf ("i386-sequent-ptx\n"); exit (0);
+
+#endif
+
+#if defined (vax)
+# if !defined (ultrix)
+#  include <sys/param.h>
+#  if defined (BSD)
+#   if BSD =3D=3D 43
+      printf ("vax-dec-bsd4.3\n"); exit (0);
+#   else
+#    if BSD =3D=3D 199006
+      printf ("vax-dec-bsd4.3reno\n"); exit (0);
+#    else
+      printf ("vax-dec-bsd\n"); exit (0);
+#    endif
+#   endif
+#  else
+    printf ("vax-dec-bsd\n"); exit (0);
+#  endif
+# else
+    printf ("vax-dec-ultrix\n"); exit (0);
+# endif
+#endif
+
+#if defined (alliant) && defined (i860)
+  printf ("i860-alliant-bsd\n"); exit (0);
+#endif
+
+  exit (1);
+}
+EOF
+
+$CC_FOR_BUILD -o $dummy $dummy.c 2>/dev/null && SYSTEM_NAME=3D`$dummy` &&
+	{ echo "$SYSTEM_NAME"; exit; }
+
+# Apollos put the system type in the environment.
+
+test -d /usr/apollo && { echo ${ISP}-apollo-${SYSTYPE}; exit; }
+
+# Convex versions that predate uname can use getsysinfo(1)
+
+if [ -x /usr/convex/getsysinfo ]
+then
+    case `getsysinfo -f cpu_type` in
+    c1*)
+	echo c1-convex-bsd
+	exit ;;
+    c2*)
+	if getsysinfo -f scalar_acc
+	then echo c32-convex-bsd
+	else echo c2-convex-bsd
+	fi
+	exit ;;
+    c34*)
+	echo c34-convex-bsd
+	exit ;;
+    c38*)
+	echo c38-convex-bsd
+	exit ;;
+    c4*)
+	echo c4-convex-bsd
+	exit ;;
+    esac
+fi
+
+cat >&2 <<EOF
+$0: unable to guess system type
+
+This script, last modified $timestamp, has failed to recognize
+the operating system you are using. It is advised that you
+download the most up to date version of the config scripts from
+
+  http://git.savannah.gnu.org/gitweb/?p=3Dconfig.git;a=3Dblob_plain;f=3Dco=
nfig.guess;hb=3DHEAD
+and
+  http://git.savannah.gnu.org/gitweb/?p=3Dconfig.git;a=3Dblob_plain;f=3Dco=
nfig.sub;hb=3DHEAD
+
+If the version you run ($0) is already up to date, please
+send the following data and any information you think might be
+pertinent to <config-patches@gnu.org> in order to provide the needed
+information to handle your system.
+
+config.guess timestamp =3D $timestamp
+
+uname -m =3D `(uname -m) 2>/dev/null || echo unknown`
+uname -r =3D `(uname -r) 2>/dev/null || echo unknown`
+uname -s =3D `(uname -s) 2>/dev/null || echo unknown`
+uname -v =3D `(uname -v) 2>/dev/null || echo unknown`
+
+/usr/bin/uname -p =3D `(/usr/bin/uname -p) 2>/dev/null`
+/bin/uname -X     =3D `(/bin/uname -X) 2>/dev/null`
+
+hostinfo               =3D `(hostinfo) 2>/dev/null`
+/bin/universe          =3D `(/bin/universe) 2>/dev/null`
+/usr/bin/arch -k       =3D `(/usr/bin/arch -k) 2>/dev/null`
+/bin/arch              =3D `(/bin/arch) 2>/dev/null`
+/usr/bin/oslevel       =3D `(/usr/bin/oslevel) 2>/dev/null`
+/usr/convex/getsysinfo =3D `(/usr/convex/getsysinfo) 2>/dev/null`
+
+UNAME_MACHINE =3D ${UNAME_MACHINE}
+UNAME_RELEASE =3D ${UNAME_RELEASE}
+UNAME_SYSTEM  =3D ${UNAME_SYSTEM}
+UNAME_VERSION =3D ${UNAME_VERSION}
+EOF
+
+exit 1
+
+# Local variables:
+# eval: (add-hook 'write-file-hooks 'time-stamp)
+# time-stamp-start: "timestamp=3D'"
+# time-stamp-format: "%:y-%02m-%02d"
+# time-stamp-end: "'"
+# End:
Index: config.sub
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: config.sub
diff -N config.sub
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ config.sub	13 Nov 2012 18:15:20 -0000
@@ -0,0 +1,1789 @@
+#! /bin/sh
+# Configuration validation subroutine script.
+#   Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
+#   2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,
+#   2011, 2012 Free Software Foundation, Inc.
+
+timestamp=3D'2012-10-10'
+
+# This file is (in principle) common to ALL GNU software.
+# The presence of a machine in this file suggests that SOME GNU software
+# can handle that machine.  It does not imply ALL GNU software can.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# As a special exception to the GNU General Public License, if you
+# distribute this file as part of a program that contains a
+# configuration script generated by Autoconf, you may include it under
+# the same distribution terms that you use for the rest of that program.
+
+
+# Please send patches to <config-patches@gnu.org>.  Submit a context
+# diff and a properly formatted GNU ChangeLog entry.
+#
+# Configuration subroutine to validate and canonicalize a configuration ty=
pe.
+# Supply the specified configuration type as an argument.
+# If it is invalid, we print an error message on stderr and exit with code=
 1.
+# Otherwise, we print the canonical config type on stdout and succeed.
+
+# You can get the latest version of this script from:
+# http://git.savannah.gnu.org/gitweb/?p=3Dconfig.git;a=3Dblob_plain;f=3Dco=
nfig.sub;hb=3DHEAD
+
+# This file is supposed to be the same for all GNU packages
+# and recognize all the CPU types, system types and aliases
+# that are meaningful with *any* GNU software.
+# Each package is responsible for reporting which valid configurations
+# it does not support.  The user should be able to distinguish
+# a failure to support a valid configuration from a meaningless
+# configuration.
+
+# The goal of this file is to map all the various variations of a given
+# machine specification into a single specification in the form:
+#	CPU_TYPE-MANUFACTURER-OPERATING_SYSTEM
+# or in some cases, the newer four-part form:
+#	CPU_TYPE-MANUFACTURER-KERNEL-OPERATING_SYSTEM
+# It is wrong to echo any other type of specification.
+
+me=3D`echo "$0" | sed -e 's,.*/,,'`
+
+usage=3D"\
+Usage: $0 [OPTION] CPU-MFR-OPSYS
+       $0 [OPTION] ALIAS
+
+Canonicalize a configuration name.
+
+Operation modes:
+  -h, --help         print this help, then exit
+  -t, --time-stamp   print date of last modification, then exit
+  -v, --version      print version number, then exit
+
+Report bugs and patches to <config-patches@gnu.org>."
+
+version=3D"\
+GNU config.sub ($timestamp)
+
+Copyright (C) 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000,
+2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012
+Free Software Foundation, Inc.
+
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
."
+
+help=3D"
+Try \`$me --help' for more information."
+
+# Parse command line
+while test $# -gt 0 ; do
+  case $1 in
+    --time-stamp | --time* | -t )
+       echo "$timestamp" ; exit ;;
+    --version | -v )
+       echo "$version" ; exit ;;
+    --help | --h* | -h )
+       echo "$usage"; exit ;;
+    -- )     # Stop option processing
+       shift; break ;;
+    - )	# Use stdin as input.
+       break ;;
+    -* )
+       echo "$me: invalid option $1$help"
+       exit 1 ;;
+
+    *local*)
+       # First pass through any local machine types.
+       echo $1
+       exit ;;
+
+    * )
+       break ;;
+  esac
+done
+
+case $# in
+ 0) echo "$me: missing argument$help" >&2
+    exit 1;;
+ 1) ;;
+ *) echo "$me: too many arguments$help" >&2
+    exit 1;;
+esac
+
+# Separate what the user gave into CPU-COMPANY and OS or KERNEL-OS (if any=
).
+# Here we must recognize all the valid KERNEL-OS combinations.
+maybe_os=3D`echo $1 | sed 's/^\(.*\)-\([^-]*-[^-]*\)$/\2/'`
+case $maybe_os in
+  nto-qnx* | linux-gnu* | linux-android* | linux-dietlibc | linux-newlib* =
| \
+  linux-musl* | linux-uclibc* | uclinux-uclibc* | uclinux-gnu* | kfreebsd*=
-gnu* | \
+  knetbsd*-gnu* | netbsd*-gnu* | \
+  kopensolaris*-gnu* | \
+  storm-chaos* | os2-emx* | rtmk-nova*)
+    os=3D-$maybe_os
+    basic_machine=3D`echo $1 | sed 's/^\(.*\)-\([^-]*-[^-]*\)$/\1/'`
+    ;;
+  android-linux)
+    os=3D-linux-android
+    basic_machine=3D`echo $1 | sed 's/^\(.*\)-\([^-]*-[^-]*\)$/\1/'`-unkno=
wn
+    ;;
+  *)
+    basic_machine=3D`echo $1 | sed 's/-[^-]*$//'`
+    if [ $basic_machine !=3D $1 ]
+    then os=3D`echo $1 | sed 's/.*-/-/'`
+    else os=3D; fi
+    ;;
+esac
+
+### Let's recognize common machines as not being operating systems so
+### that things like config.sub decstation-3100 work.  We also
+### recognize some manufacturers as not being operating systems, so we
+### can provide default operating systems below.
+case $os in
+	-sun*os*)
+		# Prevent following clause from handling this invalid input.
+		;;
+	-dec* | -mips* | -sequent* | -encore* | -pc532* | -sgi* | -sony* | \
+	-att* | -7300* | -3300* | -delta* | -motorola* | -sun[234]* | \
+	-unicom* | -ibm* | -next | -hp | -isi* | -apollo | -altos* | \
+	-convergent* | -ncr* | -news | -32* | -3600* | -3100* | -hitachi* |\
+	-c[123]* | -convex* | -sun | -crds | -omron* | -dg | -ultra | -tti* | \
+	-harris | -dolphin | -highlevel | -gould | -cbm | -ns | -masscomp | \
+	-apple | -axis | -knuth | -cray | -microblaze*)
+		os=3D
+		basic_machine=3D$1
+		;;
+	-bluegene*)
+		os=3D-cnk
+		;;
+	-sim | -cisco | -oki | -wec | -winbond)
+		os=3D
+		basic_machine=3D$1
+		;;
+	-scout)
+		;;
+	-wrs)
+		os=3D-vxworks
+		basic_machine=3D$1
+		;;
+	-chorusos*)
+		os=3D-chorusos
+		basic_machine=3D$1
+		;;
+	-chorusrdb)
+		os=3D-chorusrdb
+		basic_machine=3D$1
+		;;
+	-hiux*)
+		os=3D-hiuxwe2
+		;;
+	-sco6)
+		os=3D-sco5v6
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco5)
+		os=3D-sco3.2v5
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco4)
+		os=3D-sco3.2v4
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco3.2.[4-9]*)
+		os=3D`echo $os | sed -e 's/sco3.2./sco3.2v/'`
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco3.2v[4-9]*)
+		# Don't forget version if it is 3.2v4 or newer.
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco5v6*)
+		# Don't forget version if it is 3.2v4 or newer.
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-sco*)
+		os=3D-sco3.2v2
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-udk*)
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-isc)
+		os=3D-isc2.2
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-clix*)
+		basic_machine=3Dclipper-intergraph
+		;;
+	-isc*)
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-pc/'`
+		;;
+	-lynx*178)
+		os=3D-lynxos178
+		;;
+	-lynx*5)
+		os=3D-lynxos5
+		;;
+	-lynx*)
+		os=3D-lynxos
+		;;
+	-ptx*)
+		basic_machine=3D`echo $1 | sed -e 's/86-.*/86-sequent/'`
+		;;
+	-windowsnt*)
+		os=3D`echo $os | sed -e 's/windowsnt/winnt/'`
+		;;
+	-psos*)
+		os=3D-psos
+		;;
+	-mint | -mint[0-9]*)
+		basic_machine=3Dm68k-atari
+		os=3D-mint
+		;;
+esac
+
+# Decode aliases for certain CPU-COMPANY combinations.
+case $basic_machine in
+	# Recognize the basic CPU types without company name.
+	# Some are omitted here because they have special meanings below.
+	1750a | 580 \
+	| a29k \
+	| aarch64 | aarch64_be \
+	| alpha | alphaev[4-8] | alphaev56 | alphaev6[78] | alphapca5[67] \
+	| alpha64 | alpha64ev[4-8] | alpha64ev56 | alpha64ev6[78] | alpha64pca5[6=
7] \
+	| am33_2.0 \
+	| arc \
+	| arm | arm[bl]e | arme[lb] | armv[2-8] | armv[3-8][lb] | armv7[arm] \
+	| avr | avr32 \
+	| be32 | be64 \
+	| bfin \
+	| c4x | clipper \
+	| d10v | d30v | dlx | dsp16xx \
+	| epiphany \
+	| fido | fr30 | frv \
+	| h8300 | h8500 | hppa | hppa1.[01] | hppa2.0 | hppa2.0[nw] | hppa64 \
+	| hexagon \
+	| i370 | i860 | i960 | ia64 \
+	| ip2k | iq2000 \
+	| le32 | le64 \
+	| lm32 \
+	| m32c | m32r | m32rle | m68000 | m68k | m88k \
+	| maxq | mb | microblaze | microblazeel | mcore | mep | metag \
+	| mips | mipsbe | mipseb | mipsel | mipsle \
+	| mips16 \
+	| mips64 | mips64el \
+	| mips64octeon | mips64octeonel \
+	| mips64orion | mips64orionel \
+	| mips64r5900 | mips64r5900el \
+	| mips64vr | mips64vrel \
+	| mips64vr4100 | mips64vr4100el \
+	| mips64vr4300 | mips64vr4300el \
+	| mips64vr5000 | mips64vr5000el \
+	| mips64vr5900 | mips64vr5900el \
+	| mipsisa32 | mipsisa32el \
+	| mipsisa32r2 | mipsisa32r2el \
+	| mipsisa64 | mipsisa64el \
+	| mipsisa64r2 | mipsisa64r2el \
+	| mipsisa64sb1 | mipsisa64sb1el \
+	| mipsisa64sr71k | mipsisa64sr71kel \
+	| mipstx39 | mipstx39el \
+	| mn10200 | mn10300 \
+	| moxie \
+	| mt \
+	| msp430 \
+	| nds32 | nds32le | nds32be \
+	| nios | nios2 \
+	| ns16k | ns32k \
+	| open8 \
+	| or32 \
+	| pdp10 | pdp11 | pj | pjl \
+	| powerpc | powerpc64 | powerpc64le | powerpcle \
+	| pyramid \
+	| rl78 | rx \
+	| score \
+	| sh | sh[1234] | sh[24]a | sh[24]aeb | sh[23]e | sh[34]eb | sheb | shbe =
| shle | sh[1234]le | sh3ele \
+	| sh64 | sh64le \
+	| sparc | sparc64 | sparc64b | sparc64v | sparc86x | sparclet | sparclite=
 \
+	| sparcv8 | sparcv9 | sparcv9b | sparcv9v \
+	| spu \
+	| tahoe | tic4x | tic54x | tic55x | tic6x | tic80 | tron \
+	| ubicom32 \
+	| v850 | v850e | v850e1 | v850e2 | v850es | v850e2v3 \
+	| we32k \
+	| x86 | xc16x | xstormy16 | xtensa \
+	| z8k | z80)
+		basic_machine=3D$basic_machine-unknown
+		;;
+	c54x)
+		basic_machine=3Dtic54x-unknown
+		;;
+	c55x)
+		basic_machine=3Dtic55x-unknown
+		;;
+	c6x)
+		basic_machine=3Dtic6x-unknown
+		;;
+	m6811 | m68hc11 | m6812 | m68hc12 | m68hcs12x | picochip)
+		basic_machine=3D$basic_machine-unknown
+		os=3D-none
+		;;
+	m88110 | m680[12346]0 | m683?2 | m68360 | m5200 | v70 | w65 | z8k)
+		;;
+	ms1)
+		basic_machine=3Dmt-unknown
+		;;
+
+	strongarm | thumb | xscale)
+		basic_machine=3Darm-unknown
+		;;
+	xgate)
+		basic_machine=3D$basic_machine-unknown
+		os=3D-none
+		;;
+	xscaleeb)
+		basic_machine=3Darmeb-unknown
+		;;
+
+	xscaleel)
+		basic_machine=3Darmel-unknown
+		;;
+
+	# We use `pc' rather than `unknown'
+	# because (1) that's what they normally are, and
+	# (2) the word "unknown" tends to confuse beginning users.
+	i*86 | x86_64)
+	  basic_machine=3D$basic_machine-pc
+	  ;;
+	# Object if more than one company name word.
+	*-*-*)
+		echo Invalid configuration \`$1\': machine \`$basic_machine\' not recogn=
ized 1>&2
+		exit 1
+		;;
+	# Recognize the basic CPU types with company name.
+	580-* \
+	| a29k-* \
+	| aarch64-* | aarch64_be-* \
+	| alpha-* | alphaev[4-8]-* | alphaev56-* | alphaev6[78]-* \
+	| alpha64-* | alpha64ev[4-8]-* | alpha64ev56-* | alpha64ev6[78]-* \
+	| alphapca5[67]-* | alpha64pca5[67]-* | arc-* \
+	| arm-*  | armbe-* | armle-* | armeb-* | armv*-* \
+	| avr-* | avr32-* \
+	| be32-* | be64-* \
+	| bfin-* | bs2000-* \
+	| c[123]* | c30-* | [cjt]90-* | c4x-* \
+	| clipper-* | craynv-* | cydra-* \
+	| d10v-* | d30v-* | dlx-* \
+	| elxsi-* \
+	| f30[01]-* | f700-* | fido-* | fr30-* | frv-* | fx80-* \
+	| h8300-* | h8500-* \
+	| hppa-* | hppa1.[01]-* | hppa2.0-* | hppa2.0[nw]-* | hppa64-* \
+	| hexagon-* \
+	| i*86-* | i860-* | i960-* | ia64-* \
+	| ip2k-* | iq2000-* \
+	| le32-* | le64-* \
+	| lm32-* \
+	| m32c-* | m32r-* | m32rle-* \
+	| m68000-* | m680[012346]0-* | m68360-* | m683?2-* | m68k-* \
+	| m88110-* | m88k-* | maxq-* | mcore-* | metag-* \
+	| microblaze-* | microblazeel-* \
+	| mips-* | mipsbe-* | mipseb-* | mipsel-* | mipsle-* \
+	| mips16-* \
+	| mips64-* | mips64el-* \
+	| mips64octeon-* | mips64octeonel-* \
+	| mips64orion-* | mips64orionel-* \
+	| mips64r5900-* | mips64r5900el-* \
+	| mips64vr-* | mips64vrel-* \
+	| mips64vr4100-* | mips64vr4100el-* \
+	| mips64vr4300-* | mips64vr4300el-* \
+	| mips64vr5000-* | mips64vr5000el-* \
+	| mips64vr5900-* | mips64vr5900el-* \
+	| mipsisa32-* | mipsisa32el-* \
+	| mipsisa32r2-* | mipsisa32r2el-* \
+	| mipsisa64-* | mipsisa64el-* \
+	| mipsisa64r2-* | mipsisa64r2el-* \
+	| mipsisa64sb1-* | mipsisa64sb1el-* \
+	| mipsisa64sr71k-* | mipsisa64sr71kel-* \
+	| mipstx39-* | mipstx39el-* \
+	| mmix-* \
+	| mt-* \
+	| msp430-* \
+	| nds32-* | nds32le-* | nds32be-* \
+	| nios-* | nios2-* \
+	| none-* | np1-* | ns16k-* | ns32k-* \
+	| open8-* \
+	| orion-* \
+	| pdp10-* | pdp11-* | pj-* | pjl-* | pn-* | power-* \
+	| powerpc-* | powerpc64-* | powerpc64le-* | powerpcle-* \
+	| pyramid-* \
+	| rl78-* | romp-* | rs6000-* | rx-* \
+	| sh-* | sh[1234]-* | sh[24]a-* | sh[24]aeb-* | sh[23]e-* | sh[34]eb-* | =
sheb-* | shbe-* \
+	| shle-* | sh[1234]le-* | sh3ele-* | sh64-* | sh64le-* \
+	| sparc-* | sparc64-* | sparc64b-* | sparc64v-* | sparc86x-* | sparclet-*=
 \
+	| sparclite-* \
+	| sparcv8-* | sparcv9-* | sparcv9b-* | sparcv9v-* | sv1-* | sx?-* \
+	| tahoe-* \
+	| tic30-* | tic4x-* | tic54x-* | tic55x-* | tic6x-* | tic80-* \
+	| tile*-* \
+	| tron-* \
+	| ubicom32-* \
+	| v850-* | v850e-* | v850e1-* | v850es-* | v850e2-* | v850e2v3-* \
+	| vax-* \
+	| we32k-* \
+	| x86-* | x86_64-* | xc16x-* | xps100-* \
+	| xstormy16-* | xtensa*-* \
+	| ymp-* \
+	| z8k-* | z80-*)
+		;;
+	# Recognize the basic CPU types without company name, with glob match.
+	xtensa*)
+		basic_machine=3D$basic_machine-unknown
+		;;
+	# Recognize the various machine names and aliases which stand
+	# for a CPU type and a company and sometimes even an OS.
+	386bsd)
+		basic_machine=3Di386-unknown
+		os=3D-bsd
+		;;
+	3b1 | 7300 | 7300-att | att-7300 | pc7300 | safari | unixpc)
+		basic_machine=3Dm68000-att
+		;;
+	3b*)
+		basic_machine=3Dwe32k-att
+		;;
+	a29khif)
+		basic_machine=3Da29k-amd
+		os=3D-udi
+		;;
+	abacus)
+		basic_machine=3Dabacus-unknown
+		;;
+	adobe68k)
+		basic_machine=3Dm68010-adobe
+		os=3D-scout
+		;;
+	alliant | fx80)
+		basic_machine=3Dfx80-alliant
+		;;
+	altos | altos3068)
+		basic_machine=3Dm68k-altos
+		;;
+	am29k)
+		basic_machine=3Da29k-none
+		os=3D-bsd
+		;;
+	amd64)
+		basic_machine=3Dx86_64-pc
+		;;
+	amd64-*)
+		basic_machine=3Dx86_64-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	amdahl)
+		basic_machine=3D580-amdahl
+		os=3D-sysv
+		;;
+	amiga | amiga-*)
+		basic_machine=3Dm68k-unknown
+		;;
+	amigaos | amigados)
+		basic_machine=3Dm68k-unknown
+		os=3D-amigaos
+		;;
+	amigaunix | amix)
+		basic_machine=3Dm68k-unknown
+		os=3D-sysv4
+		;;
+	apollo68)
+		basic_machine=3Dm68k-apollo
+		os=3D-sysv
+		;;
+	apollo68bsd)
+		basic_machine=3Dm68k-apollo
+		os=3D-bsd
+		;;
+	aros)
+		basic_machine=3Di386-pc
+		os=3D-aros
+		;;
+	aux)
+		basic_machine=3Dm68k-apple
+		os=3D-aux
+		;;
+	balance)
+		basic_machine=3Dns32k-sequent
+		os=3D-dynix
+		;;
+	blackfin)
+		basic_machine=3Dbfin-unknown
+		os=3D-linux
+		;;
+	blackfin-*)
+		basic_machine=3Dbfin-`echo $basic_machine | sed 's/^[^-]*-//'`
+		os=3D-linux
+		;;
+	bluegene*)
+		basic_machine=3Dpowerpc-ibm
+		os=3D-cnk
+		;;
+	c54x-*)
+		basic_machine=3Dtic54x-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	c55x-*)
+		basic_machine=3Dtic55x-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	c6x-*)
+		basic_machine=3Dtic6x-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	c90)
+		basic_machine=3Dc90-cray
+		os=3D-unicos
+		;;
+	cegcc)
+		basic_machine=3Darm-unknown
+		os=3D-cegcc
+		;;
+	convex-c1)
+		basic_machine=3Dc1-convex
+		os=3D-bsd
+		;;
+	convex-c2)
+		basic_machine=3Dc2-convex
+		os=3D-bsd
+		;;
+	convex-c32)
+		basic_machine=3Dc32-convex
+		os=3D-bsd
+		;;
+	convex-c34)
+		basic_machine=3Dc34-convex
+		os=3D-bsd
+		;;
+	convex-c38)
+		basic_machine=3Dc38-convex
+		os=3D-bsd
+		;;
+	cray | j90)
+		basic_machine=3Dj90-cray
+		os=3D-unicos
+		;;
+	craynv)
+		basic_machine=3Dcraynv-cray
+		os=3D-unicosmp
+		;;
+	cr16 | cr16-*)
+		basic_machine=3Dcr16-unknown
+		os=3D-elf
+		;;
+	crds | unos)
+		basic_machine=3Dm68k-crds
+		;;
+	crisv32 | crisv32-* | etraxfs*)
+		basic_machine=3Dcrisv32-axis
+		;;
+	cris | cris-* | etrax*)
+		basic_machine=3Dcris-axis
+		;;
+	crx)
+		basic_machine=3Dcrx-unknown
+		os=3D-elf
+		;;
+	da30 | da30-*)
+		basic_machine=3Dm68k-da30
+		;;
+	decstation | decstation-3100 | pmax | pmax-* | pmin | dec3100 | decstatn)
+		basic_machine=3Dmips-dec
+		;;
+	decsystem10* | dec10*)
+		basic_machine=3Dpdp10-dec
+		os=3D-tops10
+		;;
+	decsystem20* | dec20*)
+		basic_machine=3Dpdp10-dec
+		os=3D-tops20
+		;;
+	delta | 3300 | motorola-3300 | motorola-delta \
+	      | 3300-motorola | delta-motorola)
+		basic_machine=3Dm68k-motorola
+		;;
+	delta88)
+		basic_machine=3Dm88k-motorola
+		os=3D-sysv3
+		;;
+	dicos)
+		basic_machine=3Di686-pc
+		os=3D-dicos
+		;;
+	djgpp)
+		basic_machine=3Di586-pc
+		os=3D-msdosdjgpp
+		;;
+	dpx20 | dpx20-*)
+		basic_machine=3Drs6000-bull
+		os=3D-bosx
+		;;
+	dpx2* | dpx2*-bull)
+		basic_machine=3Dm68k-bull
+		os=3D-sysv3
+		;;
+	ebmon29k)
+		basic_machine=3Da29k-amd
+		os=3D-ebmon
+		;;
+	elxsi)
+		basic_machine=3Delxsi-elxsi
+		os=3D-bsd
+		;;
+	encore | umax | mmax)
+		basic_machine=3Dns32k-encore
+		;;
+	es1800 | OSE68k | ose68k | ose | OSE)
+		basic_machine=3Dm68k-ericsson
+		os=3D-ose
+		;;
+	fx2800)
+		basic_machine=3Di860-alliant
+		;;
+	genix)
+		basic_machine=3Dns32k-ns
+		;;
+	gmicro)
+		basic_machine=3Dtron-gmicro
+		os=3D-sysv
+		;;
+	go32)
+		basic_machine=3Di386-pc
+		os=3D-go32
+		;;
+	h3050r* | hiux*)
+		basic_machine=3Dhppa1.1-hitachi
+		os=3D-hiuxwe2
+		;;
+	h8300hms)
+		basic_machine=3Dh8300-hitachi
+		os=3D-hms
+		;;
+	h8300xray)
+		basic_machine=3Dh8300-hitachi
+		os=3D-xray
+		;;
+	h8500hms)
+		basic_machine=3Dh8500-hitachi
+		os=3D-hms
+		;;
+	harris)
+		basic_machine=3Dm88k-harris
+		os=3D-sysv3
+		;;
+	hp300-*)
+		basic_machine=3Dm68k-hp
+		;;
+	hp300bsd)
+		basic_machine=3Dm68k-hp
+		os=3D-bsd
+		;;
+	hp300hpux)
+		basic_machine=3Dm68k-hp
+		os=3D-hpux
+		;;
+	hp3k9[0-9][0-9] | hp9[0-9][0-9])
+		basic_machine=3Dhppa1.0-hp
+		;;
+	hp9k2[0-9][0-9] | hp9k31[0-9])
+		basic_machine=3Dm68000-hp
+		;;
+	hp9k3[2-9][0-9])
+		basic_machine=3Dm68k-hp
+		;;
+	hp9k6[0-9][0-9] | hp6[0-9][0-9])
+		basic_machine=3Dhppa1.0-hp
+		;;
+	hp9k7[0-79][0-9] | hp7[0-79][0-9])
+		basic_machine=3Dhppa1.1-hp
+		;;
+	hp9k78[0-9] | hp78[0-9])
+		# FIXME: really hppa2.0-hp
+		basic_machine=3Dhppa1.1-hp
+		;;
+	hp9k8[67]1 | hp8[67]1 | hp9k80[24] | hp80[24] | hp9k8[78]9 | hp8[78]9 | h=
p9k893 | hp893)
+		# FIXME: really hppa2.0-hp
+		basic_machine=3Dhppa1.1-hp
+		;;
+	hp9k8[0-9][13679] | hp8[0-9][13679])
+		basic_machine=3Dhppa1.1-hp
+		;;
+	hp9k8[0-9][0-9] | hp8[0-9][0-9])
+		basic_machine=3Dhppa1.0-hp
+		;;
+	hppa-next)
+		os=3D-nextstep3
+		;;
+	hppaosf)
+		basic_machine=3Dhppa1.1-hp
+		os=3D-osf
+		;;
+	hppro)
+		basic_machine=3Dhppa1.1-hp
+		os=3D-proelf
+		;;
+	i370-ibm* | ibm*)
+		basic_machine=3Di370-ibm
+		;;
+	i*86v32)
+		basic_machine=3D`echo $1 | sed -e 's/86.*/86-pc/'`
+		os=3D-sysv32
+		;;
+	i*86v4*)
+		basic_machine=3D`echo $1 | sed -e 's/86.*/86-pc/'`
+		os=3D-sysv4
+		;;
+	i*86v)
+		basic_machine=3D`echo $1 | sed -e 's/86.*/86-pc/'`
+		os=3D-sysv
+		;;
+	i*86sol2)
+		basic_machine=3D`echo $1 | sed -e 's/86.*/86-pc/'`
+		os=3D-solaris2
+		;;
+	i386mach)
+		basic_machine=3Di386-mach
+		os=3D-mach
+		;;
+	i386-vsta | vsta)
+		basic_machine=3Di386-unknown
+		os=3D-vsta
+		;;
+	iris | iris4d)
+		basic_machine=3Dmips-sgi
+		case $os in
+		    -irix*)
+			;;
+		    *)
+			os=3D-irix4
+			;;
+		esac
+		;;
+	isi68 | isi)
+		basic_machine=3Dm68k-isi
+		os=3D-sysv
+		;;
+	m68knommu)
+		basic_machine=3Dm68k-unknown
+		os=3D-linux
+		;;
+	m68knommu-*)
+		basic_machine=3Dm68k-`echo $basic_machine | sed 's/^[^-]*-//'`
+		os=3D-linux
+		;;
+	m88k-omron*)
+		basic_machine=3Dm88k-omron
+		;;
+	magnum | m3230)
+		basic_machine=3Dmips-mips
+		os=3D-sysv
+		;;
+	merlin)
+		basic_machine=3Dns32k-utek
+		os=3D-sysv
+		;;
+	microblaze*)
+		basic_machine=3Dmicroblaze-xilinx
+		;;
+	mingw64)
+		basic_machine=3Dx86_64-pc
+		os=3D-mingw64
+		;;
+	mingw32)
+		basic_machine=3Di386-pc
+		os=3D-mingw32
+		;;
+	mingw32ce)
+		basic_machine=3Darm-unknown
+		os=3D-mingw32ce
+		;;
+	miniframe)
+		basic_machine=3Dm68000-convergent
+		;;
+	*mint | -mint[0-9]* | *MiNT | *MiNT[0-9]*)
+		basic_machine=3Dm68k-atari
+		os=3D-mint
+		;;
+	mips3*-*)
+		basic_machine=3D`echo $basic_machine | sed -e 's/mips3/mips64/'`
+		;;
+	mips3*)
+		basic_machine=3D`echo $basic_machine | sed -e 's/mips3/mips64/'`-unknown
+		;;
+	monitor)
+		basic_machine=3Dm68k-rom68k
+		os=3D-coff
+		;;
+	morphos)
+		basic_machine=3Dpowerpc-unknown
+		os=3D-morphos
+		;;
+	msdos)
+		basic_machine=3Di386-pc
+		os=3D-msdos
+		;;
+	ms1-*)
+		basic_machine=3D`echo $basic_machine | sed -e 's/ms1-/mt-/'`
+		;;
+	msys)
+		basic_machine=3Di386-pc
+		os=3D-msys
+		;;
+	mvs)
+		basic_machine=3Di370-ibm
+		os=3D-mvs
+		;;
+	nacl)
+		basic_machine=3Dle32-unknown
+		os=3D-nacl
+		;;
+	ncr3000)
+		basic_machine=3Di486-ncr
+		os=3D-sysv4
+		;;
+	netbsd386)
+		basic_machine=3Di386-unknown
+		os=3D-netbsd
+		;;
+	netwinder)
+		basic_machine=3Darmv4l-rebel
+		os=3D-linux
+		;;
+	news | news700 | news800 | news900)
+		basic_machine=3Dm68k-sony
+		os=3D-newsos
+		;;
+	news1000)
+		basic_machine=3Dm68030-sony
+		os=3D-newsos
+		;;
+	news-3600 | risc-news)
+		basic_machine=3Dmips-sony
+		os=3D-newsos
+		;;
+	necv70)
+		basic_machine=3Dv70-nec
+		os=3D-sysv
+		;;
+	next | m*-next )
+		basic_machine=3Dm68k-next
+		case $os in
+		    -nextstep* )
+			;;
+		    -ns2*)
+		      os=3D-nextstep2
+			;;
+		    *)
+		      os=3D-nextstep3
+			;;
+		esac
+		;;
+	nh3000)
+		basic_machine=3Dm68k-harris
+		os=3D-cxux
+		;;
+	nh[45]000)
+		basic_machine=3Dm88k-harris
+		os=3D-cxux
+		;;
+	nindy960)
+		basic_machine=3Di960-intel
+		os=3D-nindy
+		;;
+	mon960)
+		basic_machine=3Di960-intel
+		os=3D-mon960
+		;;
+	nonstopux)
+		basic_machine=3Dmips-compaq
+		os=3D-nonstopux
+		;;
+	np1)
+		basic_machine=3Dnp1-gould
+		;;
+	neo-tandem)
+		basic_machine=3Dneo-tandem
+		;;
+	nse-tandem)
+		basic_machine=3Dnse-tandem
+		;;
+	nsr-tandem)
+		basic_machine=3Dnsr-tandem
+		;;
+	op50n-* | op60c-*)
+		basic_machine=3Dhppa1.1-oki
+		os=3D-proelf
+		;;
+	openrisc | openrisc-*)
+		basic_machine=3Dor32-unknown
+		;;
+	os400)
+		basic_machine=3Dpowerpc-ibm
+		os=3D-os400
+		;;
+	OSE68000 | ose68000)
+		basic_machine=3Dm68000-ericsson
+		os=3D-ose
+		;;
+	os68k)
+		basic_machine=3Dm68k-none
+		os=3D-os68k
+		;;
+	pa-hitachi)
+		basic_machine=3Dhppa1.1-hitachi
+		os=3D-hiuxwe2
+		;;
+	paragon)
+		basic_machine=3Di860-intel
+		os=3D-osf
+		;;
+	parisc)
+		basic_machine=3Dhppa-unknown
+		os=3D-linux
+		;;
+	parisc-*)
+		basic_machine=3Dhppa-`echo $basic_machine | sed 's/^[^-]*-//'`
+		os=3D-linux
+		;;
+	pbd)
+		basic_machine=3Dsparc-tti
+		;;
+	pbb)
+		basic_machine=3Dm68k-tti
+		;;
+	pc532 | pc532-*)
+		basic_machine=3Dns32k-pc532
+		;;
+	pc98)
+		basic_machine=3Di386-pc
+		;;
+	pc98-*)
+		basic_machine=3Di386-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pentium | p5 | k5 | k6 | nexgen | viac3)
+		basic_machine=3Di586-pc
+		;;
+	pentiumpro | p6 | 6x86 | athlon | athlon_*)
+		basic_machine=3Di686-pc
+		;;
+	pentiumii | pentium2 | pentiumiii | pentium3)
+		basic_machine=3Di686-pc
+		;;
+	pentium4)
+		basic_machine=3Di786-pc
+		;;
+	pentium-* | p5-* | k5-* | k6-* | nexgen-* | viac3-*)
+		basic_machine=3Di586-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pentiumpro-* | p6-* | 6x86-* | athlon-*)
+		basic_machine=3Di686-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pentiumii-* | pentium2-* | pentiumiii-* | pentium3-*)
+		basic_machine=3Di686-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pentium4-*)
+		basic_machine=3Di786-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	pn)
+		basic_machine=3Dpn-gould
+		;;
+	power)	basic_machine=3Dpower-ibm
+		;;
+	ppc | ppcbe)	basic_machine=3Dpowerpc-unknown
+		;;
+	ppc-* | ppcbe-*)
+		basic_machine=3Dpowerpc-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	ppcle | powerpclittle | ppc-le | powerpc-little)
+		basic_machine=3Dpowerpcle-unknown
+		;;
+	ppcle-* | powerpclittle-*)
+		basic_machine=3Dpowerpcle-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	ppc64)	basic_machine=3Dpowerpc64-unknown
+		;;
+	ppc64-*) basic_machine=3Dpowerpc64-`echo $basic_machine | sed 's/^[^-]*-/=
/'`
+		;;
+	ppc64le | powerpc64little | ppc64-le | powerpc64-little)
+		basic_machine=3Dpowerpc64le-unknown
+		;;
+	ppc64le-* | powerpc64little-*)
+		basic_machine=3Dpowerpc64le-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	ps2)
+		basic_machine=3Di386-ibm
+		;;
+	pw32)
+		basic_machine=3Di586-unknown
+		os=3D-pw32
+		;;
+	rdos)
+		basic_machine=3Di386-pc
+		os=3D-rdos
+		;;
+	rom68k)
+		basic_machine=3Dm68k-rom68k
+		os=3D-coff
+		;;
+	rm[46]00)
+		basic_machine=3Dmips-siemens
+		;;
+	rtpc | rtpc-*)
+		basic_machine=3Dromp-ibm
+		;;
+	s390 | s390-*)
+		basic_machine=3Ds390-ibm
+		;;
+	s390x | s390x-*)
+		basic_machine=3Ds390x-ibm
+		;;
+	sa29200)
+		basic_machine=3Da29k-amd
+		os=3D-udi
+		;;
+	sb1)
+		basic_machine=3Dmipsisa64sb1-unknown
+		;;
+	sb1el)
+		basic_machine=3Dmipsisa64sb1el-unknown
+		;;
+	sde)
+		basic_machine=3Dmipsisa32-sde
+		os=3D-elf
+		;;
+	sei)
+		basic_machine=3Dmips-sei
+		os=3D-seiux
+		;;
+	sequent)
+		basic_machine=3Di386-sequent
+		;;
+	sh)
+		basic_machine=3Dsh-hitachi
+		os=3D-hms
+		;;
+	sh5el)
+		basic_machine=3Dsh5le-unknown
+		;;
+	sh64)
+		basic_machine=3Dsh64-unknown
+		;;
+	sparclite-wrs | simso-wrs)
+		basic_machine=3Dsparclite-wrs
+		os=3D-vxworks
+		;;
+	sps7)
+		basic_machine=3Dm68k-bull
+		os=3D-sysv2
+		;;
+	spur)
+		basic_machine=3Dspur-unknown
+		;;
+	st2000)
+		basic_machine=3Dm68k-tandem
+		;;
+	stratus)
+		basic_machine=3Di860-stratus
+		os=3D-sysv4
+		;;
+	strongarm-* | thumb-*)
+		basic_machine=3Darm-`echo $basic_machine | sed 's/^[^-]*-//'`
+		;;
+	sun2)
+		basic_machine=3Dm68000-sun
+		;;
+	sun2os3)
+		basic_machine=3Dm68000-sun
+		os=3D-sunos3
+		;;
+	sun2os4)
+		basic_machine=3Dm68000-sun
+		os=3D-sunos4
+		;;
+	sun3os3)
+		basic_machine=3Dm68k-sun
+		os=3D-sunos3
+		;;
+	sun3os4)
+		basic_machine=3Dm68k-sun
+		os=3D-sunos4
+		;;
+	sun4os3)
+		basic_machine=3Dsparc-sun
+		os=3D-sunos3
+		;;
+	sun4os4)
+		basic_machine=3Dsparc-sun
+		os=3D-sunos4
+		;;
+	sun4sol2)
+		basic_machine=3Dsparc-sun
+		os=3D-solaris2
+		;;
+	sun3 | sun3-*)
+		basic_machine=3Dm68k-sun
+		;;
+	sun4)
+		basic_machine=3Dsparc-sun
+		;;
+	sun386 | sun386i | roadrunner)
+		basic_machine=3Di386-sun
+		;;
+	sv1)
+		basic_machine=3Dsv1-cray
+		os=3D-unicos
+		;;
+	symmetry)
+		basic_machine=3Di386-sequent
+		os=3D-dynix
+		;;
+	t3e)
+		basic_machine=3Dalphaev5-cray
+		os=3D-unicos
+		;;
+	t90)
+		basic_machine=3Dt90-cray
+		os=3D-unicos
+		;;
+	tile*)
+		basic_machine=3D$basic_machine-unknown
+		os=3D-linux-gnu
+		;;
+	tx39)
+		basic_machine=3Dmipstx39-unknown
+		;;
+	tx39el)
+		basic_machine=3Dmipstx39el-unknown
+		;;
+	toad1)
+		basic_machine=3Dpdp10-xkl
+		os=3D-tops20
+		;;
+	tower | tower-32)
+		basic_machine=3Dm68k-ncr
+		;;
+	tpf)
+		basic_machine=3Ds390x-ibm
+		os=3D-tpf
+		;;
+	udi29k)
+		basic_machine=3Da29k-amd
+		os=3D-udi
+		;;
+	ultra3)
+		basic_machine=3Da29k-nyu
+		os=3D-sym1
+		;;
+	v810 | necv810)
+		basic_machine=3Dv810-nec
+		os=3D-none
+		;;
+	vaxv)
+		basic_machine=3Dvax-dec
+		os=3D-sysv
+		;;
+	vms)
+		basic_machine=3Dvax-dec
+		os=3D-vms
+		;;
+	vpp*|vx|vx-*)
+		basic_machine=3Df301-fujitsu
+		;;
+	vxworks960)
+		basic_machine=3Di960-wrs
+		os=3D-vxworks
+		;;
+	vxworks68)
+		basic_machine=3Dm68k-wrs
+		os=3D-vxworks
+		;;
+	vxworks29k)
+		basic_machine=3Da29k-wrs
+		os=3D-vxworks
+		;;
+	w65*)
+		basic_machine=3Dw65-wdc
+		os=3D-none
+		;;
+	w89k-*)
+		basic_machine=3Dhppa1.1-winbond
+		os=3D-proelf
+		;;
+	xbox)
+		basic_machine=3Di686-pc
+		os=3D-mingw32
+		;;
+	xps | xps100)
+		basic_machine=3Dxps100-honeywell
+		;;
+	xscale-* | xscalee[bl]-*)
+		basic_machine=3D`echo $basic_machine | sed 's/^xscale/arm/'`
+		;;
+	ymp)
+		basic_machine=3Dymp-cray
+		os=3D-unicos
+		;;
+	z8k-*-coff)
+		basic_machine=3Dz8k-unknown
+		os=3D-sim
+		;;
+	z80-*-coff)
+		basic_machine=3Dz80-unknown
+		os=3D-sim
+		;;
+	none)
+		basic_machine=3Dnone-none
+		os=3D-none
+		;;
+
+# Here we handle the default manufacturer of certain CPU types.  It is in
+# some cases the only manufacturer, in others, it is the most popular.
+	w89k)
+		basic_machine=3Dhppa1.1-winbond
+		;;
+	op50n)
+		basic_machine=3Dhppa1.1-oki
+		;;
+	op60c)
+		basic_machine=3Dhppa1.1-oki
+		;;
+	romp)
+		basic_machine=3Dromp-ibm
+		;;
+	mmix)
+		basic_machine=3Dmmix-knuth
+		;;
+	rs6000)
+		basic_machine=3Drs6000-ibm
+		;;
+	vax)
+		basic_machine=3Dvax-dec
+		;;
+	pdp10)
+		# there are many clones, so DEC is not a safe bet
+		basic_machine=3Dpdp10-unknown
+		;;
+	pdp11)
+		basic_machine=3Dpdp11-dec
+		;;
+	we32k)
+		basic_machine=3Dwe32k-att
+		;;
+	sh[1234] | sh[24]a | sh[24]aeb | sh[34]eb | sh[1234]le | sh[23]ele)
+		basic_machine=3Dsh-unknown
+		;;
+	sparc | sparcv8 | sparcv9 | sparcv9b | sparcv9v)
+		basic_machine=3Dsparc-sun
+		;;
+	cydra)
+		basic_machine=3Dcydra-cydrome
+		;;
+	orion)
+		basic_machine=3Dorion-highlevel
+		;;
+	orion105)
+		basic_machine=3Dclipper-highlevel
+		;;
+	mac | mpw | mac-mpw)
+		basic_machine=3Dm68k-apple
+		;;
+	pmac | pmac-mpw)
+		basic_machine=3Dpowerpc-apple
+		;;
+	*-unknown)
+		# Make sure to match an already-canonicalized machine name.
+		;;
+	*)
+		echo Invalid configuration \`$1\': machine \`$basic_machine\' not recogn=
ized 1>&2
+		exit 1
+		;;
+esac
+
+# Here we canonicalize certain aliases for manufacturers.
+case $basic_machine in
+	*-digital*)
+		basic_machine=3D`echo $basic_machine | sed 's/digital.*/dec/'`
+		;;
+	*-commodore*)
+		basic_machine=3D`echo $basic_machine | sed 's/commodore.*/cbm/'`
+		;;
+	*)
+		;;
+esac
+
+# Decode manufacturer-specific aliases for certain operating systems.
+
+if [ x"$os" !=3D x"" ]
+then
+case $os in
+	# First match some system type aliases
+	# that might get confused with valid system types.
+	# -solaris* is a basic system type, with this one exception.
+	-auroraux)
+		os=3D-auroraux
+		;;
+	-solaris1 | -solaris1.*)
+		os=3D`echo $os | sed -e 's|solaris1|sunos4|'`
+		;;
+	-solaris)
+		os=3D-solaris2
+		;;
+	-svr4*)
+		os=3D-sysv4
+		;;
+	-unixware*)
+		os=3D-sysv4.2uw
+		;;
+	-gnu/linux*)
+		os=3D`echo $os | sed -e 's|gnu/linux|linux-gnu|'`
+		;;
+	# First accept the basic system types.
+	# The portable systems comes first.
+	# Each alternative MUST END IN A *, to match a version number.
+	# -sysv* is not here because it comes later, after sysvr4.
+	-gnu* | -bsd* | -mach* | -minix* | -genix* | -ultrix* | -irix* \
+	      | -*vms* | -sco* | -esix* | -isc* | -aix* | -cnk* | -sunos | -sunos=
[34]*\
+	      | -hpux* | -unos* | -osf* | -luna* | -dgux* | -auroraux* | -solaris=
* \
+	      | -sym* | -kopensolaris* \
+	      | -amigaos* | -amigados* | -msdos* | -newsos* | -unicos* | -aof* \
+	      | -aos* | -aros* \
+	      | -nindy* | -vxsim* | -vxworks* | -ebmon* | -hms* | -mvs* \
+	      | -clix* | -riscos* | -uniplus* | -iris* | -rtu* | -xenix* \
+	      | -hiux* | -386bsd* | -knetbsd* | -mirbsd* | -netbsd* \
+	      | -bitrig* | -openbsd* | -solidbsd* \
+	      | -ekkobsd* | -kfreebsd* | -freebsd* | -riscix* | -lynxos* \
+	      | -bosx* | -nextstep* | -cxux* | -aout* | -elf* | -oabi* \
+	      | -ptx* | -coff* | -ecoff* | -winnt* | -domain* | -vsta* \
+	      | -udi* | -eabi* | -lites* | -ieee* | -go32* | -aux* \
+	      | -chorusos* | -chorusrdb* | -cegcc* \
+	      | -cygwin* | -msys* | -pe* | -psos* | -moss* | -proelf* | -rtems* \
+	      | -mingw32* | -mingw64* | -linux-gnu* | -linux-android* \
+	      | -linux-newlib* | -linux-musl* | -linux-uclibc* \
+	      | -uxpv* | -beos* | -mpeix* | -udk* \
+	      | -interix* | -uwin* | -mks* | -rhapsody* | -darwin* | -opened* \
+	      | -openstep* | -oskit* | -conix* | -pw32* | -nonstopux* \
+	      | -storm-chaos* | -tops10* | -tenex* | -tops20* | -its* \
+	      | -os2* | -vos* | -palmos* | -uclinux* | -nucleus* \
+	      | -morphos* | -superux* | -rtmk* | -rtmk-nova* | -windiss* \
+	      | -powermax* | -dnix* | -nx6 | -nx7 | -sei* | -dragonfly* \
+	      | -skyos* | -haiku* | -rdos* | -toppers* | -drops* | -es*)
+	# Remember, each alternative MUST END IN *, to match a version number.
+		;;
+	-qnx*)
+		case $basic_machine in
+		    x86-* | i*86-*)
+			;;
+		    *)
+			os=3D-nto$os
+			;;
+		esac
+		;;
+	-nto-qnx*)
+		;;
+	-nto*)
+		os=3D`echo $os | sed -e 's|nto|nto-qnx|'`
+		;;
+	-sim | -es1800* | -hms* | -xray | -os68k* | -none* | -v88r* \
+	      | -windows* | -osx | -abug | -netware* | -os9* | -beos* | -haiku* \
+	      | -macos* | -mpw* | -magic* | -mmixware* | -mon960* | -lnews*)
+		;;
+	-mac*)
+		os=3D`echo $os | sed -e 's|mac|macos|'`
+		;;
+	-linux-dietlibc)
+		os=3D-linux-dietlibc
+		;;
+	-linux*)
+		os=3D`echo $os | sed -e 's|linux|linux-gnu|'`
+		;;
+	-sunos5*)
+		os=3D`echo $os | sed -e 's|sunos5|solaris2|'`
+		;;
+	-sunos6*)
+		os=3D`echo $os | sed -e 's|sunos6|solaris3|'`
+		;;
+	-opened*)
+		os=3D-openedition
+		;;
+	-os400*)
+		os=3D-os400
+		;;
+	-wince*)
+		os=3D-wince
+		;;
+	-osfrose*)
+		os=3D-osfrose
+		;;
+	-osf*)
+		os=3D-osf
+		;;
+	-utek*)
+		os=3D-bsd
+		;;
+	-dynix*)
+		os=3D-bsd
+		;;
+	-acis*)
+		os=3D-aos
+		;;
+	-atheos*)
+		os=3D-atheos
+		;;
+	-syllable*)
+		os=3D-syllable
+		;;
+	-386bsd)
+		os=3D-bsd
+		;;
+	-ctix* | -uts*)
+		os=3D-sysv
+		;;
+	-nova*)
+		os=3D-rtmk-nova
+		;;
+	-ns2 )
+		os=3D-nextstep2
+		;;
+	-nsk*)
+		os=3D-nsk
+		;;
+	# Preserve the version number of sinix5.
+	-sinix5.*)
+		os=3D`echo $os | sed -e 's|sinix|sysv|'`
+		;;
+	-sinix*)
+		os=3D-sysv4
+		;;
+	-tpf*)
+		os=3D-tpf
+		;;
+	-triton*)
+		os=3D-sysv3
+		;;
+	-oss*)
+		os=3D-sysv3
+		;;
+	-svr4)
+		os=3D-sysv4
+		;;
+	-svr3)
+		os=3D-sysv3
+		;;
+	-sysvr4)
+		os=3D-sysv4
+		;;
+	# This must come after -sysvr4.
+	-sysv*)
+		;;
+	-ose*)
+		os=3D-ose
+		;;
+	-es1800*)
+		os=3D-ose
+		;;
+	-xenix)
+		os=3D-xenix
+		;;
+	-*mint | -mint[0-9]* | -*MiNT | -MiNT[0-9]*)
+		os=3D-mint
+		;;
+	-aros*)
+		os=3D-aros
+		;;
+	-kaos*)
+		os=3D-kaos
+		;;
+	-zvmoe)
+		os=3D-zvmoe
+		;;
+	-dicos*)
+		os=3D-dicos
+		;;
+	-nacl*)
+		;;
+	-none)
+		;;
+	*)
+		# Get rid of the `-' at the beginning of $os.
+		os=3D`echo $os | sed 's/[^-]*-//'`
+		echo Invalid configuration \`$1\': system \`$os\' not recognized 1>&2
+		exit 1
+		;;
+esac
+else
+
+# Here we handle the default operating systems that come with various mach=
ines.
+# The value should be what the vendor currently ships out the door with th=
eir
+# machine or put another way, the most popular os provided with the machin=
e.
+
+# Note that if you're going to try to match "-MANUFACTURER" here (say,
+# "-sun"), then you have to tell the case statement up towards the top
+# that MANUFACTURER isn't an operating system.  Otherwise, code above
+# will signal an error saying that MANUFACTURER isn't an operating
+# system, and we'll never get to this point.
+
+case $basic_machine in
+	score-*)
+		os=3D-elf
+		;;
+	spu-*)
+		os=3D-elf
+		;;
+	*-acorn)
+		os=3D-riscix1.2
+		;;
+	arm*-rebel)
+		os=3D-linux
+		;;
+	arm*-semi)
+		os=3D-aout
+		;;
+	c4x-* | tic4x-*)
+		os=3D-coff
+		;;
+	hexagon-*)
+		os=3D-elf
+		;;
+	tic54x-*)
+		os=3D-coff
+		;;
+	tic55x-*)
+		os=3D-coff
+		;;
+	tic6x-*)
+		os=3D-coff
+		;;
+	# This must come before the *-dec entry.
+	pdp10-*)
+		os=3D-tops20
+		;;
+	pdp11-*)
+		os=3D-none
+		;;
+	*-dec | vax-*)
+		os=3D-ultrix4.2
+		;;
+	m68*-apollo)
+		os=3D-domain
+		;;
+	i386-sun)
+		os=3D-sunos4.0.2
+		;;
+	m68000-sun)
+		os=3D-sunos3
+		;;
+	m68*-cisco)
+		os=3D-aout
+		;;
+	mep-*)
+		os=3D-elf
+		;;
+	mips*-cisco)
+		os=3D-elf
+		;;
+	mips*-*)
+		os=3D-elf
+		;;
+	or32-*)
+		os=3D-coff
+		;;
+	*-tti)	# must be before sparc entry or we get the wrong os.
+		os=3D-sysv3
+		;;
+	sparc-* | *-sun)
+		os=3D-sunos4.1.1
+		;;
+	*-be)
+		os=3D-beos
+		;;
+	*-haiku)
+		os=3D-haiku
+		;;
+	*-ibm)
+		os=3D-aix
+		;;
+	*-knuth)
+		os=3D-mmixware
+		;;
+	*-wec)
+		os=3D-proelf
+		;;
+	*-winbond)
+		os=3D-proelf
+		;;
+	*-oki)
+		os=3D-proelf
+		;;
+	*-hp)
+		os=3D-hpux
+		;;
+	*-hitachi)
+		os=3D-hiux
+		;;
+	i860-* | *-att | *-ncr | *-altos | *-motorola | *-convergent)
+		os=3D-sysv
+		;;
+	*-cbm)
+		os=3D-amigaos
+		;;
+	*-dg)
+		os=3D-dgux
+		;;
+	*-dolphin)
+		os=3D-sysv3
+		;;
+	m68k-ccur)
+		os=3D-rtu
+		;;
+	m88k-omron*)
+		os=3D-luna
+		;;
+	*-next )
+		os=3D-nextstep
+		;;
+	*-sequent)
+		os=3D-ptx
+		;;
+	*-crds)
+		os=3D-unos
+		;;
+	*-ns)
+		os=3D-genix
+		;;
+	i370-*)
+		os=3D-mvs
+		;;
+	*-next)
+		os=3D-nextstep3
+		;;
+	*-gould)
+		os=3D-sysv
+		;;
+	*-highlevel)
+		os=3D-bsd
+		;;
+	*-encore)
+		os=3D-bsd
+		;;
+	*-sgi)
+		os=3D-irix
+		;;
+	*-siemens)
+		os=3D-sysv4
+		;;
+	*-masscomp)
+		os=3D-rtu
+		;;
+	f30[01]-fujitsu | f700-fujitsu)
+		os=3D-uxpv
+		;;
+	*-rom68k)
+		os=3D-coff
+		;;
+	*-*bug)
+		os=3D-coff
+		;;
+	*-apple)
+		os=3D-macos
+		;;
+	*-atari*)
+		os=3D-mint
+		;;
+	*)
+		os=3D-none
+		;;
+esac
+fi
+
+# Here we handle the case where we know the os, and the CPU type, but not =
the
+# manufacturer.  We pick the logical manufacturer.
+vendor=3Dunknown
+case $basic_machine in
+	*-unknown)
+		case $os in
+			-riscix*)
+				vendor=3Dacorn
+				;;
+			-sunos*)
+				vendor=3Dsun
+				;;
+			-cnk*|-aix*)
+				vendor=3Dibm
+				;;
+			-beos*)
+				vendor=3Dbe
+				;;
+			-hpux*)
+				vendor=3Dhp
+				;;
+			-mpeix*)
+				vendor=3Dhp
+				;;
+			-hiux*)
+				vendor=3Dhitachi
+				;;
+			-unos*)
+				vendor=3Dcrds
+				;;
+			-dgux*)
+				vendor=3Ddg
+				;;
+			-luna*)
+				vendor=3Domron
+				;;
+			-genix*)
+				vendor=3Dns
+				;;
+			-mvs* | -opened*)
+				vendor=3Dibm
+				;;
+			-os400*)
+				vendor=3Dibm
+				;;
+			-ptx*)
+				vendor=3Dsequent
+				;;
+			-tpf*)
+				vendor=3Dibm
+				;;
+			-vxsim* | -vxworks* | -windiss*)
+				vendor=3Dwrs
+				;;
+			-aux*)
+				vendor=3Dapple
+				;;
+			-hms*)
+				vendor=3Dhitachi
+				;;
+			-mpw* | -macos*)
+				vendor=3Dapple
+				;;
+			-*mint | -mint[0-9]* | -*MiNT | -MiNT[0-9]*)
+				vendor=3Datari
+				;;
+			-vos*)
+				vendor=3Dstratus
+				;;
+		esac
+		basic_machine=3D`echo $basic_machine | sed "s/unknown/$vendor/"`
+		;;
+esac
+
+echo $basic_machine$os
+exit
+
+# Local variables:
+# eval: (add-hook 'write-file-hooks 'time-stamp)
+# time-stamp-start: "timestamp=3D'"
+# time-stamp-format: "%:y-%02m-%02d"
+# time-stamp-end: "'"
+# End:
Index: configure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/configure,v
retrieving revision 1.37
diff -d -u -p -r1.37 configure
--- configure	7 Nov 2012 16:32:07 -0000	1.37
+++ configure	13 Nov 2012 18:15:20 -0000
@@ -1,11 +1,9 @@
 #! /bin/sh
 # Guess values for system-dependent variables and create Makefiles.
-# Generated by GNU Autoconf 2.68.
+# Generated by GNU Autoconf 2.69.
 #
 #
-# Copyright (C) 1992, 1993, 1994, 1995, 1996, 1998, 1999, 2000, 2001,
-# 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010 Free Software
-# Foundation, Inc.
+# Copyright (C) 1992-1996, 1998-2012 Free Software Foundation, Inc.
 #
 #
 # This configure script is free software; the Free Software Foundation
@@ -134,6 +132,31 @@ export LANGUAGE
 # CDPATH.
 (unset CDPATH) >/dev/null 2>&1 && unset CDPATH
=20
+# Use a proper internal environment variable to ensure we don't fall
+  # into an infinite loop, continuously re-executing ourselves.
+  if test x"${_as_can_reexec}" !=3D xno && test "x$CONFIG_SHELL" !=3D x; t=
hen
+    _as_can_reexec=3Dno; export _as_can_reexec;
+    # We cannot yet assume a decent shell, so we have to provide a
+# neutralization value for shells without unset; and this also
+# works around shells that cannot unset nonexistent variables.
+# Preserve -v and -x to the replacement shell.
+BASH_ENV=3D/dev/null
+ENV=3D/dev/null
+(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
+case $- in # ((((
+  *v*x* | *x*v* ) as_opts=3D-vx ;;
+  *v* ) as_opts=3D-v ;;
+  *x* ) as_opts=3D-x ;;
+  * ) as_opts=3D ;;
+esac
+exec $CONFIG_SHELL $as_opts "$as_myself" ${1+"$@"}
+# Admittedly, this is quite paranoid, since all the known shells bail
+# out after a failed `exec'.
+$as_echo "$0: could not re-execute with $CONFIG_SHELL" >&2
+as_fn_exit 255
+  fi
+  # We don't want this to propagate to other subprocesses.
+          { _as_can_reexec=3D; unset _as_can_reexec;}
 if test "x$CONFIG_SHELL" =3D x; then
   as_bourne_compatible=3D"if test -n \"\${ZSH_VERSION+set}\" && (emulate s=
h) >/dev/null 2>&1; then :
   emulate sh
@@ -167,7 +190,8 @@ if ( set x; as_fn_ret_success y && test=20
 else
   exitcode=3D1; echo positional parameters were not saved.
 fi
-test x\$exitcode =3D x0 || exit 1"
+test x\$exitcode =3D x0 || exit 1
+test -x / || exit 1"
   as_suggested=3D"  as_lineno_1=3D";as_suggested=3D$as_suggested$LINENO;as=
_suggested=3D$as_suggested" as_lineno_1a=3D\$LINENO
   as_lineno_2=3D";as_suggested=3D$as_suggested$LINENO;as_suggested=3D$as_s=
uggested" as_lineno_2a=3D\$LINENO
   eval 'test \"x\$as_lineno_1'\$as_run'\" !=3D \"x\$as_lineno_2'\$as_run'\=
" &&
@@ -211,21 +235,25 @@ IFS=3D$as_save_IFS
=20
=20
       if test "x$CONFIG_SHELL" !=3D x; then :
-  # We cannot yet assume a decent shell, so we have to provide a
-	# neutralization value for shells without unset; and this also
-	# works around shells that cannot unset nonexistent variables.
-	# Preserve -v and -x to the replacement shell.
-	BASH_ENV=3D/dev/null
-	ENV=3D/dev/null
-	(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
-	export CONFIG_SHELL
-	case $- in # ((((
-	  *v*x* | *x*v* ) as_opts=3D-vx ;;
-	  *v* ) as_opts=3D-v ;;
-	  *x* ) as_opts=3D-x ;;
-	  * ) as_opts=3D ;;
-	esac
-	exec "$CONFIG_SHELL" $as_opts "$as_myself" ${1+"$@"}
+  export CONFIG_SHELL
+             # We cannot yet assume a decent shell, so we have to provide a
+# neutralization value for shells without unset; and this also
+# works around shells that cannot unset nonexistent variables.
+# Preserve -v and -x to the replacement shell.
+BASH_ENV=3D/dev/null
+ENV=3D/dev/null
+(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
+case $- in # ((((
+  *v*x* | *x*v* ) as_opts=3D-vx ;;
+  *v* ) as_opts=3D-v ;;
+  *x* ) as_opts=3D-x ;;
+  * ) as_opts=3D ;;
+esac
+exec $CONFIG_SHELL $as_opts "$as_myself" ${1+"$@"}
+# Admittedly, this is quite paranoid, since all the known shells bail
+# out after a failed `exec'.
+$as_echo "$0: could not re-execute with $CONFIG_SHELL" >&2
+exit 255
 fi
=20
     if test x$as_have_required =3D xno; then :
@@ -327,6 +355,14 @@ $as_echo X"$as_dir" |
=20
=20
 } # as_fn_mkdir_p
+
+# as_fn_executable_p FILE
+# -----------------------
+# Test if FILE is an executable regular file.
+as_fn_executable_p ()
+{
+  test -f "$1" && test -x "$1"
+} # as_fn_executable_p
 # as_fn_append VAR VALUE
 # ----------------------
 # Append the text in VALUE to the end of the definition contained in VAR. =
Take
@@ -448,6 +484,10 @@ as_cr_alnum=3D$as_cr_Letters$as_cr_digits
   chmod +x "$as_me.lineno" ||
     { $as_echo "$as_me: error: cannot create $as_me.lineno; rerun with a P=
OSIX shell" >&2; as_fn_exit 1; }
=20
+  # If we had to re-execute with $CONFIG_SHELL, we're ensured to have
+  # already done that, so ensure we don't try to do so again and fall
+  # in an infinite loop.  This has already happened in practice.
+  _as_can_reexec=3Dno; export _as_can_reexec
   # Don't try to exec as it changes $[0], causing all sort of problems
   # (the dirname of $[0] is not the place where we might find the
   # original and so on.  Autoconf is especially sensitive to this).
@@ -482,16 +522,16 @@ if (echo >conf$$.file) 2>/dev/null; then
     # ... but there are two gotchas:
     # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
     # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executabl=
e.
-    # In both cases, we have to default to `cp -p'.
+    # In both cases, we have to default to `cp -pR'.
     ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
-      as_ln_s=3D'cp -p'
+      as_ln_s=3D'cp -pR'
   elif ln conf$$.file conf$$ 2>/dev/null; then
     as_ln_s=3Dln
   else
-    as_ln_s=3D'cp -p'
+    as_ln_s=3D'cp -pR'
   fi
 else
-  as_ln_s=3D'cp -p'
+  as_ln_s=3D'cp -pR'
 fi
 rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
 rmdir conf$$.dir 2>/dev/null
@@ -503,28 +543,8 @@ else
   as_mkdir_p=3Dfalse
 fi
=20
-if test -x / >/dev/null 2>&1; then
-  as_test_x=3D'test -x'
-else
-  if ls -dL / >/dev/null 2>&1; then
-    as_ls_L_option=3DL
-  else
-    as_ls_L_option=3D
-  fi
-  as_test_x=3D'
-    eval sh -c '\''
-      if test -d "$1"; then
-	test -d "$1/.";
-      else
-	case $1 in #(
-	-*)set "./$1";;
-	esac;
-	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
-	???[sx]*):;;*)false;;esac;fi
-    '\'' sh
-  '
-fi
-as_executable_p=3D$as_test_x
+as_test_x=3D'test -x'
+as_executable_p=3Das_fn_executable_p
=20
 # Sed expression to map a string onto a valid CPP name.
 as_tr_cpp=3D"eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnu=
m]%_%g'"
@@ -568,6 +588,10 @@ LIBOBJS
 SET_MAKE
 INSTALL_LICENSE
 subdirs
+cygwin_headers
+newlib_headers
+windows_headers
+CPP
 ac_ct_CXX
 CXXFLAGS
 CXX
@@ -593,6 +617,7 @@ build
 INSTALL_DATA
 INSTALL_SCRIPT
 INSTALL_PROGRAM
+windows_libdir
 target_alias
 host_alias
 build_alias
@@ -630,10 +655,14 @@ PACKAGE_VERSION
 PACKAGE_TARNAME
 PACKAGE_NAME
 PATH_SEPARATOR
-SHELL'
+SHELL
+winsup_srcdir
+target_builddir'
 ac_subst_files=3D''
 ac_user_opts=3D'
 enable_option_checking
+with_windows_headers
+with_windows_libs
 '
       ac_precious_vars=3D'build_alias
 host_alias
@@ -645,8 +674,9 @@ LIBS
 CPPFLAGS
 CXX
 CXXFLAGS
-CCC'
-ac_subdirs_all=3D'cygwin cygserver lsaauth utils doc'
+CCC
+CPP'
+ac_subdirs_all=3D'cygwin utils cygserver lsaauth doc'
=20
 # Initialize some variables set by options.
 ac_init_help=3D
@@ -1101,8 +1131,6 @@ target=3D$target_alias
 if test "x$host_alias" !=3D x; then
   if test "x$build_alias" =3D x; then
     cross_compiling=3Dmaybe
-    $as_echo "$as_me: WARNING: if you wanted to set the --build type, don'=
t use --host.
-    If a cross compiler is detected then cross compile mode will be used" =
>&2
   elif test "x$build_alias" !=3D "x$host_alias"; then
     cross_compiling=3Dyes
   fi
@@ -1256,6 +1284,13 @@ if test -n "$ac_init_help"; then
=20
   cat <<\_ACEOF
=20
+Optional Packages:
+  --with-PACKAGE[=3DARG]    use PACKAGE [ARG=3Dyes]
+  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=3Dno)
+  --with-windows-headers=3DDIR
+                          specify where the windows includes are located
+  --with-windows-libs=3DDIR specify where the windows libraries are located
+
 Some influential environment variables:
   CC          C compiler command
   CFLAGS      C compiler flags
@@ -1266,6 +1301,7 @@ Some influential environment variables:
               you have headers in a nonstandard directory <include dir>
   CXX         C++ compiler command
   CXXFLAGS    C++ compiler flags
+  CPP         C preprocessor
=20
 Use these variables to override the choices made by `configure' or to help
 it to find libraries and programs with nonstandard names/locations.
@@ -1334,9 +1370,9 @@ test -n "$ac_init_help" && exit $ac_stat
 if $ac_init_version; then
   cat <<\_ACEOF
 configure
-generated by GNU Autoconf 2.68
+generated by GNU Autoconf 2.69
=20
-Copyright (C) 2010 Free Software Foundation, Inc.
+Copyright (C) 2012 Free Software Foundation, Inc.
 This configure script is free software; the Free Software Foundation
 gives unlimited permission to copy, distribute and modify it.
 _ACEOF
@@ -1422,12 +1458,49 @@ fi
   as_fn_set_status $ac_retval
=20
 } # ac_fn_cxx_try_compile
+
+# ac_fn_c_try_cpp LINENO
+# ----------------------
+# Try to preprocess conftest.$ac_ext, and return whether this succeeded.
+ac_fn_c_try_cpp ()
+{
+  as_lineno=3D${as_lineno-"$1"} as_lineno_stack=3Das_lineno_stack=3D$as_li=
neno_stack
+  if { { ac_try=3D"$ac_cpp conftest.$ac_ext"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=3D\$ac_try;;
+  *) ac_try_echo=3D$ac_try;;
+esac
+eval ac_try_echo=3D"\"\$as_me:${as_lineno-$LINENO}: $ac_try_echo\""
+$as_echo "$ac_try_echo"; } >&5
+  (eval "$ac_cpp conftest.$ac_ext") 2>conftest.err
+  ac_status=3D$?
+  if test -s conftest.err; then
+    grep -v '^ *+' conftest.err >conftest.er1
+    cat conftest.er1 >&5
+    mv -f conftest.er1 conftest.err
+  fi
+  $as_echo "$as_me:${as_lineno-$LINENO}: \$? =3D $ac_status" >&5
+  test $ac_status =3D 0; } > conftest.i && {
+	 test -z "$ac_c_preproc_warn_flag$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       }; then :
+  ac_retval=3D0
+else
+  $as_echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+    ac_retval=3D1
+fi
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
+  as_fn_set_status $ac_retval
+
+} # ac_fn_c_try_cpp
 cat >config.log <<_ACEOF
 This file contains any messages produced by compilers while
 running configure, to aid debugging if configure makes a mistake.
=20
 It was created by $as_me, which was
-generated by GNU Autoconf 2.68.  Invocation command line was
+generated by GNU Autoconf 2.69.  Invocation command line was
=20
   $ $0 $@
=20
@@ -1774,11 +1847,8 @@ ac_link=3D'$CC -o conftest$ac_exeext $CFLA
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
=20
-
-INSTALL=3D`cd $srcdir/..; echo $(pwd)/install-sh -c`
-
 ac_aux_dir=3D
-for ac_dir in "$srcdir" "$srcdir/.." "$srcdir/../.."; do
+for ac_dir in .. "$srcdir"/..; do
   if test -f "$ac_dir/install-sh"; then
     ac_aux_dir=3D$ac_dir
     ac_install_sh=3D"$ac_aux_dir/install-sh -c"
@@ -1794,7 +1864,7 @@ for ac_dir in "$srcdir" "$srcdir/.." "$s
   fi
 done
 if test -z "$ac_aux_dir"; then
-  as_fn_error $? "cannot find install-sh, install.sh, or shtool in \"$srcd=
ir\" \"$srcdir/..\" \"$srcdir/../..\"" "$LINENO" 5
+  as_fn_error $? "cannot find install-sh, install.sh, or shtool in .. \"$s=
rcdir\"/.." "$LINENO" 5
 fi
=20
 # These three variables are undocumented and unsupported,
@@ -1806,6 +1876,37 @@ ac_config_sub=3D"$SHELL $ac_aux_dir/config
 ac_configure=3D"$SHELL $ac_aux_dir/configure"  # Please don't use this var.
=20
=20
+
+. ${srcdir}/configure.cygwin
+
+
+
+# Check whether --with-windows-headers was given.
+if test "${with_windows_headers+set}" =3D set; then :
+  withval=3D$with_windows_headers; test -z "$withval" && as_fn_error $? "m=
ust specify value for --with-windows-headers" "$LINENO" 5
+
+fi
+
+
+
+
+# Check whether --with-windows-libs was given.
+if test "${with_windows_libs+set}" =3D set; then :
+  withval=3D$with_windows_libs; test -z "$withval" && as_fn_error $? "must=
 specify value for --with-windows-libs" "$LINENO" 5
+
+fi
+
+windows_libdir=3D$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=3D$(cd $(dirname $($ac_cv_prog_CC -print-file-name=3Dli=
bcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	as_fn_error $? "cannot find windows library files" "$LINENO" 5
+    fi
+fi
+
+
+
+
 # Find a good install program.  We prefer a C program (faster),
 # so one script is as good as another.  But avoid the broken or
 # incompatible versions:
@@ -1843,7 +1944,7 @@ case $as_dir/ in #((
     # by default.
     for ac_prog in ginstall scoinst install; do
       for ac_exec_ext in '' $ac_executable_extensions; do
-	if { test -f "$as_dir/$ac_prog$ac_exec_ext" && $as_test_x "$as_dir/$ac_pr=
og$ac_exec_ext"; }; then
+	if as_fn_executable_p "$as_dir/$ac_prog$ac_exec_ext"; then
 	  if test $ac_prog =3D install &&
 	    grep dspmsg "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
 	    # AIX install.  It has an incompatible calling convention.
@@ -2011,101 +2112,6 @@ test -n "$target_alias" &&
   program_prefix=3D${target_alias}-
=20
=20
-
-
-if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}gcc", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}gcc; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_CC+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CC"; then
-  ac_cv_prog_CC=3D"$CC" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CC=3D"${ac_tool_prefix}gcc"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CC=3D$ac_cv_prog_CC
-if test -n "$CC"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CC" >&5
-$as_echo "$CC" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CC"; then
-  ac_ct_CC=3D$CC
-  # Extract the first word of "gcc", so it can be a program name with args.
-set dummy gcc; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_ac_ct_CC+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CC"; then
-  ac_cv_prog_ac_ct_CC=3D"$ac_ct_CC" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CC=3D"gcc"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CC=3D$ac_cv_prog_ac_ct_CC
-if test -n "$ac_ct_CC"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CC" >&5
-$as_echo "$ac_ct_CC" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CC" =3D x; then
-    CC=3D"gcc"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CC=3D$ac_ct_CC
-  fi
-else
-  CC=3D"$ac_cv_prog_CC"
-fi
-
-: ${CC:=3Dgcc}
 ac_ext=3Dc
 ac_cpp=3D'$CPP $CPPFLAGS'
 ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -2128,7 +2134,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"${ac_tool_prefix}gcc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2168,7 +2174,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CC=3D"gcc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2221,7 +2227,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"${ac_tool_prefix}cc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2262,7 +2268,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     if test "$as_dir/$ac_word$ac_exec_ext" =3D "/usr/ucb/cc"; then
        ac_prog_rejected=3Dyes
        continue
@@ -2320,7 +2326,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"$ac_tool_prefix$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2364,7 +2370,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CC=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2445,34 +2451,6 @@ main ()
   return 0;
 }
 _ACEOF
-# FIXME: Cleanup?
-if { { eval echo "\"\$as_me\":${as_lineno-$LINENO}: \"$ac_link\""; } >&5
-  (eval $ac_link) 2>&5
-  ac_status=3D$?
-  $as_echo "$as_me:${as_lineno-$LINENO}: \$? =3D $ac_status" >&5
-  test $ac_status =3D 0; }; then :
-  gcc_no_link=3Dno
-else
-  gcc_no_link=3Dyes
-fi
-if test x$gcc_no_link =3D xyes; then
-  # Setting cross_compile will disable run tests; it will
-  # also disable AC_CHECK_FILE but that's generally
-  # correct if we can't link.
-  cross_compiling=3Dyes
-  EXEEXT=3D
-else
-  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-int
-main ()
-{
-
-  ;
-  return 0;
-}
-_ACEOF
 ac_clean_files_save=3D$ac_clean_files
 ac_clean_files=3D"$ac_clean_files a.out a.out.dSYM a.exe b.out"
 # Try to create an executable without -o first, disregard a.out.
@@ -2661,7 +2639,6 @@ $as_echo "$cross_compiling" >&6; }
=20
 rm -f conftest.$ac_ext conftest$ac_cv_exeext conftest.out
 ac_clean_files=3D$ac_clean_files_save
-fi
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for suffix of object fil=
es" >&5
 $as_echo_n "checking for suffix of object files... " >&6; }
 if ${ac_cv_objext+:} false; then :
@@ -2839,8 +2816,7 @@ cat confdefs.h - <<_ACEOF >conftest.$ac_
 /* end confdefs.h.  */
 #include <stdarg.h>
 #include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+struct stat;
 /* Most of the following tests are stolen from RCS 5.7's src/conf.sh.  */
 struct buf { int x; };
 FILE * (*rcsopen) (struct buf *, struct stat *, int);
@@ -2925,195 +2901,7 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-test -z "$CC" && as_fn_error $? "no acceptable cc found in \$PATH" "$LINEN=
O" 5
-
-if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}g++", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_CXX+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CXX"; then
-  ac_cv_prog_CXX=3D"$CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CXX=3D"${ac_tool_prefix}g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CXX=3D$ac_cv_prog_CXX
-if test -n "$CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CXX" >&5
-$as_echo "$CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CXX"; then
-  ac_ct_CXX=3D$CXX
-  # Extract the first word of "g++", so it can be a program name with args.
-set dummy g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_ac_ct_CXX+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CXX"; then
-  ac_cv_prog_ac_ct_CXX=3D"$ac_ct_CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CXX=3D"g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CXX=3D$ac_cv_prog_ac_ct_CXX
-if test -n "$ac_ct_CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CXX" >&5
-$as_echo "$ac_ct_CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CXX" =3D x; then
-    CXX=3D"g++"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CXX=3D$ac_ct_CXX
-  fi
-else
-  CXX=3D"$ac_cv_prog_CXX"
-fi
-
-if test -z "$CXX"; then
-  if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}g++", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_CXX+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CXX"; then
-  ac_cv_prog_CXX=3D"$CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CXX=3D"${ac_tool_prefix}g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CXX=3D$ac_cv_prog_CXX
-if test -n "$CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CXX" >&5
-$as_echo "$CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CXX"; then
-  ac_ct_CXX=3D$CXX
-  # Extract the first word of "g++", so it can be a program name with args.
-set dummy g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_ac_ct_CXX+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CXX"; then
-  ac_cv_prog_ac_ct_CXX=3D"$ac_ct_CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CXX=3D"g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CXX=3D$ac_cv_prog_ac_ct_CXX
-if test -n "$ac_ct_CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CXX" >&5
-$as_echo "$ac_ct_CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CXX" =3D x; then
-    CXX=3D"c++"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CXX=3D$ac_ct_CXX
-  fi
-else
-  CXX=3D"$ac_cv_prog_CXX"
-fi
-
-  : ${CXX:=3Dg++}
-  ac_ext=3Dcpp
+ac_ext=3Dcpp
 ac_cpp=3D'$CXXCPP $CPPFLAGS'
 ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
 ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conftes=
t.$ac_ext $LIBS >&5'
@@ -3141,7 +2929,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CXX=3D"$ac_tool_prefix$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3185,7 +2973,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CXX=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3370,11 +3158,136 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-  test -z "$CC" && as_fn_error $? "no acceptable cc found in \$PATH" "$LIN=
ENO" 5
+ac_ext=3Dc
+ac_cpp=3D'$CPP $CPPFLAGS'
+ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking how to run the C preproc=
essor" >&5
+$as_echo_n "checking how to run the C preprocessor... " >&6; }
+# On Suns, sometimes $CPP names a directory.
+if test -n "$CPP" && test -d "$CPP"; then
+  CPP=3D
 fi
+if test -z "$CPP"; then
+  if ${ac_cv_prog_CPP+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+      # Double quotes because CPP needs to be expanded
+    for CPP in "$CC -E" "$CC -E -traditional-cpp" "/lib/cpp"
+    do
+      ac_preproc_ok=3Dfalse
+for ac_c_preproc_warn_flag in '' yes
+do
+  # Use a header file that comes with gcc, so configuring glibc
+  # with a fresh cross-compiler works.
+  # Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+  # <limits.h> exists even on freestanding compilers.
+  # On the NeXT, cc -E runs the code through the compiler's parser,
+  # not just through cpp. "Syntax error" is here to catch this case.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+		     Syntax error
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
=20
-CXXFLAGS=3D'$(CFLAGS)'
+else
+  # Broken: fails on valid input.
+continue
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+  # OK, works on sane cases.  Now check whether nonexistent headers
+  # can be detected and how.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#include <ac_nonexistent.h>
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+  # Broken: success on invalid input.
+continue
+else
+  # Passes both tests.
+ac_preproc_ok=3D:
+break
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+done
+# Because of `break', _AC_PREPROC_IFELSE's cleaning code was skipped.
+rm -f conftest.i conftest.err conftest.$ac_ext
+if $ac_preproc_ok; then :
+  break
+fi
=20
+    done
+    ac_cv_prog_CPP=3D$CPP
+
+fi
+  CPP=3D$ac_cv_prog_CPP
+else
+  ac_cv_prog_CPP=3D$CPP
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $CPP" >&5
+$as_echo "$CPP" >&6; }
+ac_preproc_ok=3Dfalse
+for ac_c_preproc_warn_flag in '' yes
+do
+  # Use a header file that comes with gcc, so configuring glibc
+  # with a fresh cross-compiler works.
+  # Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+  # <limits.h> exists even on freestanding compilers.
+  # On the NeXT, cc -E runs the code through the compiler's parser,
+  # not just through cpp. "Syntax error" is here to catch this case.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+		     Syntax error
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+
+else
+  # Broken: fails on valid input.
+continue
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+  # OK, works on sane cases.  Now check whether nonexistent headers
+  # can be detected and how.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#include <ac_nonexistent.h>
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+  # Broken: success on invalid input.
+continue
+else
+  # Passes both tests.
+ac_preproc_ok=3D:
+break
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+done
+# Because of `break', _AC_PREPROC_IFELSE's cleaning code was skipped.
+rm -f conftest.i conftest.err conftest.$ac_ext
+if $ac_preproc_ok; then :
+
+else
+  { { $as_echo "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+$as_echo "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error $? "C preprocessor \"$CPP\" fails sanity check
+See \`config.log' for more details" "$LINENO" 5; }
+fi
=20
 ac_ext=3Dc
 ac_cpp=3D'$CPP $CPPFLAGS'
@@ -3382,21 +3295,63 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
+ac_ext=3Dc
+ac_cpp=3D'$CPP $CPPFLAGS'
+ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-INSTALL_LICENSE=3D
+ac_ext=3Dcpp
+ac_cpp=3D'$CXXCPP $CPPFLAGS'
+ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conftes=
t.$ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_cxx_compiler_gnu
=20
-case "$target" in
-  *cygwin*)
-    if ! test -d $srcdir/cygwin; then
-      as_fn_error $? "\"No cygwin dir.  Can't build Cygwin.  Exiting...\""=
 "$LINENO" 5
+
+
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=3D$CXX}
+: ${ac_cv_prog_CC:=3D$CC}
+
+cygwin_headers=3D$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    as_fn_error $? "cannot find $winsup_srcdir/cygwin/include directory" "=
$LINENO" 5
+fi
+
+newlib_headers=3D$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null &&=
 pwd)
+if test -z "$newlib_headers"; then
+    as_fn_error $? "cannot find newlib source directory: $winsup_srcdir/..=
/newlib/libc/include" "$LINENO" 5
+fi
+newlib_headers=3D"$target_builddir/newlib/targ-include $newlib_headers"
+
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers=3D"$with_windows_headers"
+    else
+	as_fn_error $? "cannot find windef.h in specified --with-windows-headers =
path: $saw_windows_headers" "$LINENO" 5;
+    fi
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers=3D"$winsup_srcdir/w32api/include"
+else
+    windows_headers=3D$(cd $($ac_cv_prog_CC -xc /dev/null -E -include wind=
ef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1=
) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	as_fn_error $? "cannot find windows header files" "$LINENO" 5
     fi
+fi
+CC=3D$ac_cv_prog_CC
+CXX=3D$ac_cv_prog_CXX
+export CC
+export CXX
=20
=20
-subdirs=3D"$subdirs cygwin cygserver lsaauth utils doc"
=20
-    INSTALL_LICENSE=3D"install-license"
-    ;;
-esac
+
+
+
+
+subdirs=3D"$subdirs cygwin utils cygserver lsaauth doc"
+
+INSTALL_LICENSE=3D"install-license"
=20
=20
=20
@@ -3877,16 +3832,16 @@ if (echo >conf$$.file) 2>/dev/null; then
     # ... but there are two gotchas:
     # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
     # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executabl=
e.
-    # In both cases, we have to default to `cp -p'.
+    # In both cases, we have to default to `cp -pR'.
     ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
-      as_ln_s=3D'cp -p'
+      as_ln_s=3D'cp -pR'
   elif ln conf$$.file conf$$ 2>/dev/null; then
     as_ln_s=3Dln
   else
-    as_ln_s=3D'cp -p'
+    as_ln_s=3D'cp -pR'
   fi
 else
-  as_ln_s=3D'cp -p'
+  as_ln_s=3D'cp -pR'
 fi
 rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
 rmdir conf$$.dir 2>/dev/null
@@ -3946,28 +3901,16 @@ else
   as_mkdir_p=3Dfalse
 fi
=20
-if test -x / >/dev/null 2>&1; then
-  as_test_x=3D'test -x'
-else
-  if ls -dL / >/dev/null 2>&1; then
-    as_ls_L_option=3DL
-  else
-    as_ls_L_option=3D
-  fi
-  as_test_x=3D'
-    eval sh -c '\''
-      if test -d "$1"; then
-	test -d "$1/.";
-      else
-	case $1 in #(
-	-*)set "./$1";;
-	esac;
-	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
-	???[sx]*):;;*)false;;esac;fi
-    '\'' sh
-  '
-fi
-as_executable_p=3D$as_test_x
+
+# as_fn_executable_p FILE
+# -----------------------
+# Test if FILE is an executable regular file.
+as_fn_executable_p ()
+{
+  test -f "$1" && test -x "$1"
+} # as_fn_executable_p
+as_test_x=3D'test -x'
+as_executable_p=3Das_fn_executable_p
=20
 # Sed expression to map a string onto a valid CPP name.
 as_tr_cpp=3D"eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnu=
m]%_%g'"
@@ -3989,7 +3932,7 @@ cat >>$CONFIG_STATUS <<\_ACEOF || ac_wri
 # values after options handling.
 ac_log=3D"
 This file was extended by $as_me, which was
-generated by GNU Autoconf 2.68.  Invocation command line was
+generated by GNU Autoconf 2.69.  Invocation command line was
=20
   CONFIG_FILES    =3D $CONFIG_FILES
   CONFIG_HEADERS  =3D $CONFIG_HEADERS
@@ -4042,10 +3985,10 @@ cat >>$CONFIG_STATUS <<_ACEOF || ac_writ
 ac_cs_config=3D"`$as_echo "$ac_configure_args" | sed 's/^ //; s/[\\""\`\$]=
/\\\\&/g'`"
 ac_cs_version=3D"\\
 config.status
-configured by $0, generated by GNU Autoconf 2.68,
+configured by $0, generated by GNU Autoconf 2.69,
   with options \\"\$ac_cs_config\\"
=20
-Copyright (C) 2010 Free Software Foundation, Inc.
+Copyright (C) 2012 Free Software Foundation, Inc.
 This config.status script is free software; the Free Software Foundation
 gives unlimited permission to copy, distribute and modify it."
=20
@@ -4123,7 +4066,7 @@ fi
 _ACEOF
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=3D1
 if \$ac_cs_recheck; then
-  set X '$SHELL' '$0' $ac_configure_args \$ac_configure_extra_args --no-cr=
eate --no-recursion
+  set X $SHELL '$0' $ac_configure_args \$ac_configure_extra_args --no-crea=
te --no-recursion
   shift
   \$as_echo "running CONFIG_SHELL=3D$SHELL \$*" >&6
   CONFIG_SHELL=3D'$SHELL'
Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/configure.in,v
retrieving revision 1.35
diff -d -u -p -r1.35 configure.in
--- configure.in	7 Nov 2012 16:32:07 -0000	1.35
+++ configure.in	13 Nov 2012 18:15:20 -0000
@@ -1,6 +1,6 @@
 dnl Autoconf configure script for Cygwin.
 dnl Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2006,
-dnl 2009 Red Hat, Inc.
+dnl 2009, 2010, 2011, 2012 Red Hat, Inc.
 dnl
 dnl This file is part of Cygwin.
 dnl
@@ -12,30 +12,26 @@ dnl Process this file with autoconf to p
=20
 AC_PREREQ(2.59)dnl
 AC_INIT(Makefile.in)
+AC_CONFIG_AUX_DIR(..)
=20
-INSTALL=3D`cd $srcdir/..; echo $(pwd)/install-sh -c`
+. ${srcdir}/configure.cygwin
+
+AC_WINDOWS_HEADERS
+AC_WINDOWS_LIBS
=20
 AC_PROG_INSTALL
 AC_CANONICAL_SYSTEM
=20
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
=20
-INSTALL_LICENSE=3D
+AC_CYGWIN_INCLUDES
=20
-case "$target" in
-  *cygwin*)
-    if ! test -d $srcdir/cygwin; then
-      AC_MSG_ERROR("No cygwin dir.  Can't build Cygwin.  Exiting...")
-    fi
-    AC_CONFIG_SUBDIRS(cygwin cygserver lsaauth utils doc)
-    INSTALL_LICENSE=3D"install-license"
-    ;;
-esac
+AC_CONFIG_SUBDIRS(cygwin utils cygserver lsaauth doc)
+INSTALL_LICENSE=3D"install-license"
=20
 AC_SUBST(INSTALL_LICENSE)
=20
Index: install-sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: install-sh
diff -N install-sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ install-sh	13 Nov 2012 18:15:21 -0000
@@ -0,0 +1,520 @@
+#!/bin/sh
+# install - install a program, script, or datafile
+
+scriptversion=3D2009-04-28.21; # UTC
+
+# This originates from X11R5 (mit/util/scripts/install.sh), which was
+# later released in X11R6 (xc/config/util/install.sh) with the
+# following copyright and license.
+#
+# Copyright (C) 1994 X Consortium
+#
+# Permission is hereby granted, free of charge, to any person obtaining a =
copy
+# of this software and associated documentation files (the "Software"), to
+# deal in the Software without restriction, including without limitation t=
he
+# rights to use, copy, modify, merge, publish, distribute, sublicense, and=
/or
+# sell copies of the Software, and to permit persons to whom the Software =
is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included =
in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL=
 THE
+# X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHE=
R IN
+# AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON=
NEC-
+# TION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+#
+# Except as contained in this notice, the name of the X Consortium shall n=
ot
+# be used in advertising or otherwise to promote the sale, use or other de=
al-
+# ings in this Software without prior written authorization from the X Con=
sor-
+# tium.
+#
+#
+# FSF changes to this file are in the public domain.
+#
+# Calling this script install-sh is preferred over install.sh, to prevent
+# `make' implicit rules from creating a file called install from it
+# when there is no Makefile.
+#
+# This script is compatible with the BSD install script, but was written
+# from scratch.
+
+nl=3D'
+'
+IFS=3D" ""	$nl"
+
+# set DOITPROG to echo to test this script
+
+# Don't use :- since 4.3BSD and earlier shells don't like it.
+doit=3D${DOITPROG-}
+if test -z "$doit"; then
+  doit_exec=3Dexec
+else
+  doit_exec=3D$doit
+fi
+
+# Put in absolute file names if you don't have them in your path;
+# or use environment vars.
+
+chgrpprog=3D${CHGRPPROG-chgrp}
+chmodprog=3D${CHMODPROG-chmod}
+chownprog=3D${CHOWNPROG-chown}
+cmpprog=3D${CMPPROG-cmp}
+cpprog=3D${CPPROG-cp}
+mkdirprog=3D${MKDIRPROG-mkdir}
+mvprog=3D${MVPROG-mv}
+rmprog=3D${RMPROG-rm}
+stripprog=3D${STRIPPROG-strip}
+
+posix_glob=3D'?'
+initialize_posix_glob=3D'
+  test "$posix_glob" !=3D "?" || {
+    if (set -f) 2>/dev/null; then
+      posix_glob=3D
+    else
+      posix_glob=3D:
+    fi
+  }
+'
+
+posix_mkdir=3D
+
+# Desired mode of installed file.
+mode=3D0755
+
+chgrpcmd=3D
+chmodcmd=3D$chmodprog
+chowncmd=3D
+mvcmd=3D$mvprog
+rmcmd=3D"$rmprog -f"
+stripcmd=3D
+
+src=3D
+dst=3D
+dir_arg=3D
+dst_arg=3D
+
+copy_on_change=3Dfalse
+no_target_directory=3D
+
+usage=3D"\
+Usage: $0 [OPTION]... [-T] SRCFILE DSTFILE
+   or: $0 [OPTION]... SRCFILES... DIRECTORY
+   or: $0 [OPTION]... -t DIRECTORY SRCFILES...
+   or: $0 [OPTION]... -d DIRECTORIES...
+
+In the 1st form, copy SRCFILE to DSTFILE.
+In the 2nd and 3rd, copy all SRCFILES to DIRECTORY.
+In the 4th, create DIRECTORIES.
+
+Options:
+     --help     display this help and exit.
+     --version  display version info and exit.
+
+  -c            (ignored)
+  -C            install only if different (preserve the last data modifica=
tion time)
+  -d            create directories instead of installing files.
+  -g GROUP      $chgrpprog installed files to GROUP.
+  -m MODE       $chmodprog installed files to MODE.
+  -o USER       $chownprog installed files to USER.
+  -s            $stripprog installed files.
+  -t DIRECTORY  install into DIRECTORY.
+  -T            report an error if DSTFILE is a directory.
+
+Environment variables override the default commands:
+  CHGRPPROG CHMODPROG CHOWNPROG CMPPROG CPPROG MKDIRPROG MVPROG
+  RMPROG STRIPPROG
+"
+
+while test $# -ne 0; do
+  case $1 in
+    -c) ;;
+
+    -C) copy_on_change=3Dtrue;;
+
+    -d) dir_arg=3Dtrue;;
+
+    -g) chgrpcmd=3D"$chgrpprog $2"
+	shift;;
+
+    --help) echo "$usage"; exit $?;;
+
+    -m) mode=3D$2
+	case $mode in
+	  *' '* | *'	'* | *'
+'*	  | *'*'* | *'?'* | *'['*)
+	    echo "$0: invalid mode: $mode" >&2
+	    exit 1;;
+	esac
+	shift;;
+
+    -o) chowncmd=3D"$chownprog $2"
+	shift;;
+
+    -s) stripcmd=3D$stripprog;;
+
+    -t) dst_arg=3D$2
+	shift;;
+
+    -T) no_target_directory=3Dtrue;;
+
+    --version) echo "$0 $scriptversion"; exit $?;;
+
+    --)	shift
+	break;;
+
+    -*)	echo "$0: invalid option: $1" >&2
+	exit 1;;
+
+    *)  break;;
+  esac
+  shift
+done
+
+if test $# -ne 0 && test -z "$dir_arg$dst_arg"; then
+  # When -d is used, all remaining arguments are directories to create.
+  # When -t is used, the destination is already specified.
+  # Otherwise, the last argument is the destination.  Remove it from $@.
+  for arg
+  do
+    if test -n "$dst_arg"; then
+      # $@ is not empty: it contains at least $arg.
+      set fnord "$@" "$dst_arg"
+      shift # fnord
+    fi
+    shift # arg
+    dst_arg=3D$arg
+  done
+fi
+
+if test $# -eq 0; then
+  if test -z "$dir_arg"; then
+    echo "$0: no input file specified." >&2
+    exit 1
+  fi
+  # It's OK to call `install-sh -d' without argument.
+  # This can happen when creating conditional directories.
+  exit 0
+fi
+
+if test -z "$dir_arg"; then
+  trap '(exit $?); exit' 1 2 13 15
+
+  # Set umask so as not to create temps with too-generous modes.
+  # However, 'strip' requires both read and write access to temps.
+  case $mode in
+    # Optimize common cases.
+    *644) cp_umask=3D133;;
+    *755) cp_umask=3D22;;
+
+    *[0-7])
+      if test -z "$stripcmd"; then
+	u_plus_rw=3D
+      else
+	u_plus_rw=3D'% 200'
+      fi
+      cp_umask=3D`expr '(' 777 - $mode % 1000 ')' $u_plus_rw`;;
+    *)
+      if test -z "$stripcmd"; then
+	u_plus_rw=3D
+      else
+	u_plus_rw=3D,u+rw
+      fi
+      cp_umask=3D$mode$u_plus_rw;;
+  esac
+fi
+
+for src
+do
+  # Protect names starting with `-'.
+  case $src in
+    -*) src=3D./$src;;
+  esac
+
+  if test -n "$dir_arg"; then
+    dst=3D$src
+    dstdir=3D$dst
+    test -d "$dstdir"
+    dstdir_status=3D$?
+  else
+
+    # Waiting for this to be detected by the "$cpprog $src $dsttmp" command
+    # might cause directories to be created, which would be especially bad
+    # if $src (and thus $dsttmp) contains '*'.
+    if test ! -f "$src" && test ! -d "$src"; then
+      echo "$0: $src does not exist." >&2
+      exit 1
+    fi
+
+    if test -z "$dst_arg"; then
+      echo "$0: no destination specified." >&2
+      exit 1
+    fi
+
+    dst=3D$dst_arg
+    # Protect names starting with `-'.
+    case $dst in
+      -*) dst=3D./$dst;;
+    esac
+
+    # If destination is a directory, append the input filename; won't work
+    # if double slashes aren't ignored.
+    if test -d "$dst"; then
+      if test -n "$no_target_directory"; then
+	echo "$0: $dst_arg: Is a directory" >&2
+	exit 1
+      fi
+      dstdir=3D$dst
+      dst=3D$dstdir/`basename "$src"`
+      dstdir_status=3D0
+    else
+      # Prefer dirname, but fall back on a substitute if dirname fails.
+      dstdir=3D`
+	(dirname "$dst") 2>/dev/null ||
+	expr X"$dst" : 'X\(.*[^/]\)//*[^/][^/]*/*$' \| \
+	     X"$dst" : 'X\(//\)[^/]' \| \
+	     X"$dst" : 'X\(//\)$' \| \
+	     X"$dst" : 'X\(/\)' \| . 2>/dev/null ||
+	echo X"$dst" |
+	    sed '/^X\(.*[^/]\)\/\/*[^/][^/]*\/*$/{
+		   s//\1/
+		   q
+		 }
+		 /^X\(\/\/\)[^/].*/{
+		   s//\1/
+		   q
+		 }
+		 /^X\(\/\/\)$/{
+		   s//\1/
+		   q
+		 }
+		 /^X\(\/\).*/{
+		   s//\1/
+		   q
+		 }
+		 s/.*/./; q'
+      `
+
+      test -d "$dstdir"
+      dstdir_status=3D$?
+    fi
+  fi
+
+  obsolete_mkdir_used=3Dfalse
+
+  if test $dstdir_status !=3D 0; then
+    case $posix_mkdir in
+      '')
+	# Create intermediate dirs using mode 755 as modified by the umask.
+	# This is like FreeBSD 'install' as of 1997-10-28.
+	umask=3D`umask`
+	case $stripcmd.$umask in
+	  # Optimize common cases.
+	  *[2367][2367]) mkdir_umask=3D$umask;;
+	  .*0[02][02] | .[02][02] | .[02]) mkdir_umask=3D22;;
+
+	  *[0-7])
+	    mkdir_umask=3D`expr $umask + 22 \
+	      - $umask % 100 % 40 + $umask % 20 \
+	      - $umask % 10 % 4 + $umask % 2
+	    `;;
+	  *) mkdir_umask=3D$umask,go-w;;
+	esac
+
+	# With -d, create the new directory with the user-specified mode.
+	# Otherwise, rely on $mkdir_umask.
+	if test -n "$dir_arg"; then
+	  mkdir_mode=3D-m$mode
+	else
+	  mkdir_mode=3D
+	fi
+
+	posix_mkdir=3Dfalse
+	case $umask in
+	  *[123567][0-7][0-7])
+	    # POSIX mkdir -p sets u+wx bits regardless of umask, which
+	    # is incompatible with FreeBSD 'install' when (umask & 300) !=3D 0.
+	    ;;
+	  *)
+	    tmpdir=3D${TMPDIR-/tmp}/ins$RANDOM-$$
+	    trap 'ret=3D$?; rmdir "$tmpdir/d" "$tmpdir" 2>/dev/null; exit $ret' 0
+
+	    if (umask $mkdir_umask &&
+		exec $mkdirprog $mkdir_mode -p -- "$tmpdir/d") >/dev/null 2>&1
+	    then
+	      if test -z "$dir_arg" || {
+		   # Check for POSIX incompatibilities with -m.
+		   # HP-UX 11.23 and IRIX 6.5 mkdir -m -p sets group- or
+		   # other-writeable bit of parent directory when it shouldn't.
+		   # FreeBSD 6.1 mkdir -m -p sets mode of existing directory.
+		   ls_ld_tmpdir=3D`ls -ld "$tmpdir"`
+		   case $ls_ld_tmpdir in
+		     d????-?r-*) different_mode=3D700;;
+		     d????-?--*) different_mode=3D755;;
+		     *) false;;
+		   esac &&
+		   $mkdirprog -m$different_mode -p -- "$tmpdir" && {
+		     ls_ld_tmpdir_1=3D`ls -ld "$tmpdir"`
+		     test "$ls_ld_tmpdir" =3D "$ls_ld_tmpdir_1"
+		   }
+		 }
+	      then posix_mkdir=3D:
+	      fi
+	      rmdir "$tmpdir/d" "$tmpdir"
+	    else
+	      # Remove any dirs left behind by ancient mkdir implementations.
+	      rmdir ./$mkdir_mode ./-p ./-- 2>/dev/null
+	    fi
+	    trap '' 0;;
+	esac;;
+    esac
+
+    if
+      $posix_mkdir && (
+	umask $mkdir_umask &&
+	$doit_exec $mkdirprog $mkdir_mode -p -- "$dstdir"
+      )
+    then :
+    else
+
+      # The umask is ridiculous, or mkdir does not conform to POSIX,
+      # or it failed possibly due to a race condition.  Create the
+      # directory the slow way, step by step, checking for races as we go.
+
+      case $dstdir in
+	/*) prefix=3D'/';;
+	-*) prefix=3D'./';;
+	*)  prefix=3D'';;
+      esac
+
+      eval "$initialize_posix_glob"
+
+      oIFS=3D$IFS
+      IFS=3D/
+      $posix_glob set -f
+      set fnord $dstdir
+      shift
+      $posix_glob set +f
+      IFS=3D$oIFS
+
+      prefixes=3D
+
+      for d
+      do
+	test -z "$d" && continue
+
+	prefix=3D$prefix$d
+	if test -d "$prefix"; then
+	  prefixes=3D
+	else
+	  if $posix_mkdir; then
+	    (umask=3D$mkdir_umask &&
+	     $doit_exec $mkdirprog $mkdir_mode -p -- "$dstdir") && break
+	    # Don't fail if two instances are running concurrently.
+	    test -d "$prefix" || exit 1
+	  else
+	    case $prefix in
+	      *\'*) qprefix=3D`echo "$prefix" | sed "s/'/'\\\\\\\\''/g"`;;
+	      *) qprefix=3D$prefix;;
+	    esac
+	    prefixes=3D"$prefixes '$qprefix'"
+	  fi
+	fi
+	prefix=3D$prefix/
+      done
+
+      if test -n "$prefixes"; then
+	# Don't fail if two instances are running concurrently.
+	(umask $mkdir_umask &&
+	 eval "\$doit_exec \$mkdirprog $prefixes") ||
+	  test -d "$dstdir" || exit 1
+	obsolete_mkdir_used=3Dtrue
+      fi
+    fi
+  fi
+
+  if test -n "$dir_arg"; then
+    { test -z "$chowncmd" || $doit $chowncmd "$dst"; } &&
+    { test -z "$chgrpcmd" || $doit $chgrpcmd "$dst"; } &&
+    { test "$obsolete_mkdir_used$chowncmd$chgrpcmd" =3D false ||
+      test -z "$chmodcmd" || $doit $chmodcmd $mode "$dst"; } || exit 1
+  else
+
+    # Make a couple of temp file names in the proper directory.
+    dsttmp=3D$dstdir/_inst.$$_
+    rmtmp=3D$dstdir/_rm.$$_
+
+    # Trap to clean up those temp files at exit.
+    trap 'ret=3D$?; rm -f "$dsttmp" "$rmtmp" && exit $ret' 0
+
+    # Copy the file name to the temp name.
+    (umask $cp_umask && $doit_exec $cpprog "$src" "$dsttmp") &&
+
+    # and set any options; do chmod last to preserve setuid bits.
+    #
+    # If any of these fail, we abort the whole thing.  If we want to
+    # ignore errors from any of these, just make sure not to ignore
+    # errors from the above "$doit $cpprog $src $dsttmp" command.
+    #
+    { test -z "$chowncmd" || $doit $chowncmd "$dsttmp"; } &&
+    { test -z "$chgrpcmd" || $doit $chgrpcmd "$dsttmp"; } &&
+    { test -z "$stripcmd" || $doit $stripcmd "$dsttmp"; } &&
+    { test -z "$chmodcmd" || $doit $chmodcmd $mode "$dsttmp"; } &&
+
+    # If -C, don't bother to copy if it wouldn't change the file.
+    if $copy_on_change &&
+       old=3D`LC_ALL=3DC ls -dlL "$dst"	2>/dev/null` &&
+       new=3D`LC_ALL=3DC ls -dlL "$dsttmp"	2>/dev/null` &&
+
+       eval "$initialize_posix_glob" &&
+       $posix_glob set -f &&
+       set X $old && old=3D:$2:$4:$5:$6 &&
+       set X $new && new=3D:$2:$4:$5:$6 &&
+       $posix_glob set +f &&
+
+       test "$old" =3D "$new" &&
+       $cmpprog "$dst" "$dsttmp" >/dev/null 2>&1
+    then
+      rm -f "$dsttmp"
+    else
+      # Rename the file to the real destination.
+      $doit $mvcmd -f "$dsttmp" "$dst" 2>/dev/null ||
+
+      # The rename failed, perhaps because mv can't rename something else
+      # to itself, or perhaps because mv is so ancient that it does not
+      # support -f.
+      {
+	# Now remove or move aside any old file at destination location.
+	# We try this two ways since rm can't unlink itself on some
+	# systems and the destination file might be busy for other
+	# reasons.  In this case, the final cleanup might fail but the new
+	# file should still install successfully.
+	{
+	  test ! -f "$dst" ||
+	  $doit $rmcmd -f "$dst" 2>/dev/null ||
+	  { $doit $mvcmd -f "$dst" "$rmtmp" 2>/dev/null &&
+	    { $doit $rmcmd -f "$rmtmp" 2>/dev/null; :; }
+	  } ||
+	  { echo "$0: cannot unlink or rename $dst" >&2
+	    (exit 1); exit 1
+	  }
+	} &&
+
+	# Now rename the file to the real destination.
+	$doit $mvcmd "$dsttmp" "$dst"
+      }
+    fi || exit 1
+
+    trap '' 0
+  fi
+done
+
+# Local variables:
+# eval: (add-hook 'write-file-hooks 'time-stamp)
+# time-stamp-start: "scriptversion=3D"
+# time-stamp-format: "%:y-%02m-%02d.%02H"
+# time-stamp-time-zone: "UTC"
+# time-stamp-end: "; # UTC"
+# End:
Index: cygserver/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygserver/Makefile.in,v
retrieving revision 1.24
diff -d -u -p -r1.24 Makefile.in
--- cygserver/Makefile.in	16 Nov 2009 08:50:07 -0000	1.24
+++ cygserver/Makefile.in	13 Nov 2012 18:15:21 -0000
@@ -7,10 +7,22 @@
 # Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 # details.
=20
-SHELL:=3D@SHELL@
-
 srcdir:=3D@srcdir@
-VPATH:=3D@srcdir@
+target_builddir:=3D@target_builddir@
+winsup_srcdir:=3D@winsup_srcdir@
+configure_args=3D@configure_args@
+
+export CC:=3D@CC@
+export CXX:=3D@CXX@
+
+include ${srcdir}/../Makefile.common
+
+cygwin_build:=3D${target_builddir}/winsup/cygwin
+
+# environment variables used by ccwrap
+export CCWRAP_HEADERS:=3D$(dir ${srcdir})/cygwin ${cygwin_build}
+export CCWRAP_SYSTEM_HEADERS:=3D@cygwin_headers@ @newlib_headers@
+export CCWRAP_DIRAFTER_HEADERS:=3D@windows_headers@
=20
 DESTDIR=3D
 prefix:=3D${DESTDIR}@prefix@
@@ -24,20 +36,12 @@ INSTALL:=3D@INSTALL@
 INSTALL_PROGRAM:=3D@INSTALL_PROGRAM@
 INSTALL_DATA:=3D@INSTALL_DATA@
=20
-CC:=3D@CC@
-CC_FOR_TARGET:=3D$(CC)
-CXX:=3D@CXX@
-CXX_FOR_TARGET:=3D$(CXX)
 AR:=3D@AR@
=20
-include $(srcdir)/../Makefile.common
-
 CFLAGS:=3D@CFLAGS@
 override CXXFLAGS=3D@CXXFLAGS@
 override CXXFLAGS+=3D-MMD -DHAVE_DECL_GETOPT=3D0 -D__OUTSIDE_CYGWIN__ -DSY=
SCONFDIR=3D"\"$(sysconfdir)\""
=20
-.SUFFIXES: .c .cc .a .o .d
-
 OBJS:=3D	cygserver.o client.o process.o msg.o sem.o shm.o threaded_queue.o=
 \
 	transport.o transport_pipes.o \
 	bsd_helper.o bsd_log.o bsd_mutex.o \
@@ -78,9 +82,10 @@ $(cygwin_build)/%.o: $(cygwin_source)/%.
 	@$(MAKE) -C $(@D) $(@F)
=20
 Makefile: Makefile.in configure
+	./config.status
=20
 lib%.o: %.cc
-	${filter-out -D__OUTSIDE_CYGWIN__, $(COMPILE_CXX)} -c -I$(updir)/cygwin -=
I$(bupdir)/cygwin -o $(@D)/${basename $(@F)}$o $<
+	${filter-out -D__OUTSIDE_CYGWIN__, $(COMPILE.cc)} -c -o $(@D)/${basename =
$(@F)}.o $<
=20
 libcygserver.a: $(LIBOBJS)
 	$(AR) crus $@ $?
Index: cygserver/aclocal.m4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygserver/aclocal.m4,v
retrieving revision 1.1
diff -d -u -p -r1.1 aclocal.m4
--- cygserver/aclocal.m4	24 May 2006 16:59:02 -0000	1.1
+++ cygserver/aclocal.m4	13 Nov 2012 18:15:21 -0000
@@ -1,875 +1,97 @@
-dnl aclocal.m4 generated automatically by aclocal 1.4-p6
-
-dnl Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY, to the extent permitted by law; without
-dnl even the implied warranty of MERCHANTABILITY or FITNESS FOR A
-dnl PARTICULAR PURPOSE.
-
-# lib-prefix.m4 serial 4 (gettext-0.14.2)
-dnl Copyright (C) 2001-2005 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl From Bruno Haible.
-
-dnl AC_LIB_ARG_WITH is synonymous to AC_ARG_WITH in autoconf-2.13, and
-dnl similar to AC_ARG_WITH in autoconf 2.52...2.57 except that is doesn't
-dnl require excessive bracketing.
-ifdef([AC_HELP_STRING],
-[AC_DEFUN([AC_LIB_ARG_WITH], [AC_ARG_WITH([$1],[[$2]],[$3],[$4])])],
-[AC_DEFUN([AC_][LIB_ARG_WITH], [AC_ARG_WITH([$1],[$2],[$3],[$4])])])
-
-dnl AC_LIB_PREFIX adds to the CPPFLAGS and LDFLAGS the flags that are need=
ed
-dnl to access previously installed libraries. The basic assumption is that
-dnl a user will want packages to use other packages he previously installed
-dnl with the same --prefix option.
-dnl This macro is not needed if only AC_LIB_LINKFLAGS is used to locate
-dnl libraries, but is otherwise very convenient.
-AC_DEFUN([AC_LIB_PREFIX],
-[
-  AC_BEFORE([$0], [AC_LIB_LINKFLAGS])
-  AC_REQUIRE([AC_PROG_CC])
-  AC_REQUIRE([AC_CANONICAL_HOST])
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  dnl By default, look in $includedir and $libdir.
-  use_additional=3Dyes
-  AC_LIB_WITH_FINAL_PREFIX([
-    eval additional_includedir=3D\"$includedir\"
-    eval additional_libdir=3D\"$libdir\"
-  ])
-  AC_LIB_ARG_WITH([lib-prefix],
-[  --with-lib-prefix[=3DDIR] search for libraries in DIR/include and DIR/l=
ib
-  --without-lib-prefix    don't search for libraries in includedir and lib=
dir],
-[
-    if test "X$withval" =3D "Xno"; then
-      use_additional=3Dno
-    else
-      if test "X$withval" =3D "X"; then
-        AC_LIB_WITH_FINAL_PREFIX([
-          eval additional_includedir=3D\"$includedir\"
-          eval additional_libdir=3D\"$libdir\"
-        ])
-      else
-        additional_includedir=3D"$withval/include"
-        additional_libdir=3D"$withval/lib"
-      fi
-    fi
-])
-  if test $use_additional =3D yes; then
-    dnl Potentially add $additional_includedir to $CPPFLAGS.
-    dnl But don't add it
-    dnl   1. if it's the standard /usr/include,
-    dnl   2. if it's already present in $CPPFLAGS,
-    dnl   3. if it's /usr/local/include and we are using GCC on Linux,
-    dnl   4. if it doesn't exist as a directory.
-    if test "X$additional_includedir" !=3D "X/usr/include"; then
-      haveit=3D
-      for x in $CPPFLAGS; do
-        AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-        if test "X$x" =3D "X-I$additional_includedir"; then
-          haveit=3Dyes
-          break
-        fi
-      done
-      if test -z "$haveit"; then
-        if test "X$additional_includedir" =3D "X/usr/local/include"; then
-          if test -n "$GCC"; then
-            case $host_os in
-              linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-            esac
-          fi
-        fi
-        if test -z "$haveit"; then
-          if test -d "$additional_includedir"; then
-            dnl Really add $additional_includedir to $CPPFLAGS.
-            CPPFLAGS=3D"${CPPFLAGS}${CPPFLAGS:+ }-I$additional_includedir"
-          fi
-        fi
-      fi
-    fi
-    dnl Potentially add $additional_libdir to $LDFLAGS.
-    dnl But don't add it
-    dnl   1. if it's the standard /usr/lib,
-    dnl   2. if it's already present in $LDFLAGS,
-    dnl   3. if it's /usr/local/lib and we are using GCC on Linux,
-    dnl   4. if it doesn't exist as a directory.
-    if test "X$additional_libdir" !=3D "X/usr/lib"; then
-      haveit=3D
-      for x in $LDFLAGS; do
-        AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-        if test "X$x" =3D "X-L$additional_libdir"; then
-          haveit=3Dyes
-          break
-        fi
-      done
-      if test -z "$haveit"; then
-        if test "X$additional_libdir" =3D "X/usr/local/lib"; then
-          if test -n "$GCC"; then
-            case $host_os in
-              linux*) haveit=3Dyes;;
-            esac
-          fi
-        fi
-        if test -z "$haveit"; then
-          if test -d "$additional_libdir"; then
-            dnl Really add $additional_libdir to $LDFLAGS.
-            LDFLAGS=3D"${LDFLAGS}${LDFLAGS:+ }-L$additional_libdir"
-          fi
-        fi
-      fi
-    fi
-  fi
-])
-
-dnl AC_LIB_PREPARE_PREFIX creates variables acl_final_prefix,
-dnl acl_final_exec_prefix, containing the values to which $prefix and
-dnl $exec_prefix will expand at the end of the configure script.
-AC_DEFUN([AC_LIB_PREPARE_PREFIX],
-[
-  dnl Unfortunately, prefix and exec_prefix get only finally determined
-  dnl at the end of configure.
-  if test "X$prefix" =3D "XNONE"; then
-    acl_final_prefix=3D"$ac_default_prefix"
-  else
-    acl_final_prefix=3D"$prefix"
-  fi
-  if test "X$exec_prefix" =3D "XNONE"; then
-    acl_final_exec_prefix=3D'${prefix}'
-  else
-    acl_final_exec_prefix=3D"$exec_prefix"
-  fi
-  acl_save_prefix=3D"$prefix"
-  prefix=3D"$acl_final_prefix"
-  eval acl_final_exec_prefix=3D\"$acl_final_exec_prefix\"
-  prefix=3D"$acl_save_prefix"
-])
+# generated automatically by aclocal 1.12.1 -*- Autoconf -*-
=20
-dnl AC_LIB_WITH_FINAL_PREFIX([statement]) evaluates statement, with the
-dnl variables prefix and exec_prefix bound to the values they will have
-dnl at the end of the configure script.
-AC_DEFUN([AC_LIB_WITH_FINAL_PREFIX],
-[
-  acl_save_prefix=3D"$prefix"
-  prefix=3D"$acl_final_prefix"
-  acl_save_exec_prefix=3D"$exec_prefix"
-  exec_prefix=3D"$acl_final_exec_prefix"
-  $1
-  exec_prefix=3D"$acl_save_exec_prefix"
-  prefix=3D"$acl_save_prefix"
-])
+# Copyright (C) 1996-2012 Free Software Foundation, Inc.
=20
-# lib-link.m4 serial 6 (gettext-0.14.3)
-dnl Copyright (C) 2001-2005 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
=20
-dnl From Bruno Haible.
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
+# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
+# PARTICULAR PURPOSE.
=20
-AC_PREREQ(2.50)
+dnl This provides configure definitions used by all the cygwin
+dnl configure.in files.
=20
-dnl AC_LIB_LINKFLAGS(name [, dependencies]) searches for libname and
-dnl the libraries corresponding to explicit and implicit dependencies.
-dnl Sets and AC_SUBSTs the LIB${NAME} and LTLIB${NAME} variables and
-dnl augments the CPPFLAGS variable.
-AC_DEFUN([AC_LIB_LINKFLAGS],
-[
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  AC_REQUIRE([AC_LIB_RPATH])
-  define([Name],[translit([$1],[./-], [___])])
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-  AC_CACHE_CHECK([how to link with lib[]$1], [ac_cv_lib[]Name[]_libs], [
-    AC_LIB_LINKFLAGS_BODY([$1], [$2])
-    ac_cv_lib[]Name[]_libs=3D"$LIB[]NAME"
-    ac_cv_lib[]Name[]_ltlibs=3D"$LTLIB[]NAME"
-    ac_cv_lib[]Name[]_cppflags=3D"$INC[]NAME"
-  ])
-  LIB[]NAME=3D"$ac_cv_lib[]Name[]_libs"
-  LTLIB[]NAME=3D"$ac_cv_lib[]Name[]_ltlibs"
-  INC[]NAME=3D"$ac_cv_lib[]Name[]_cppflags"
-  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INC]NAME)
-  AC_SUBST([LIB]NAME)
-  AC_SUBST([LTLIB]NAME)
-  dnl Also set HAVE_LIB[]NAME so that AC_LIB_HAVE_LINKFLAGS can reuse the
-  dnl results of this search when this library appears as a dependency.
-  HAVE_LIB[]NAME=3Dyes
-  undefine([Name])
-  undefine([NAME])
+AC_DEFUN([AC_WINDOWS_HEADERS],[
+AC_ARG_WITH(
+    [windows-headers],
+    [AS_HELP_STRING([--with-windows-headers=3DDIR],
+		    [specify where the windows includes are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-win=
dows-headers])]
+)
 ])
=20
-dnl AC_LIB_HAVE_LINKFLAGS(name, dependencies, includes, testcode)
-dnl searches for libname and the libraries corresponding to explicit and
-dnl implicit dependencies, together with the specified include files and
-dnl the ability to compile and link the specified testcode. If found, it
-dnl sets and AC_SUBSTs HAVE_LIB${NAME}=3Dyes and the LIB${NAME} and
-dnl LTLIB${NAME} variables and augments the CPPFLAGS variable, and
-dnl #defines HAVE_LIB${NAME} to 1. Otherwise, it sets and AC_SUBSTs
-dnl HAVE_LIB${NAME}=3Dno and LIB${NAME} and LTLIB${NAME} to empty.
-AC_DEFUN([AC_LIB_HAVE_LINKFLAGS],
-[
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  AC_REQUIRE([AC_LIB_RPATH])
-  define([Name],[translit([$1],[./-], [___])])
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-
-  dnl Search for lib[]Name and define LIB[]NAME, LTLIB[]NAME and INC[]NAME
-  dnl accordingly.
-  AC_LIB_LINKFLAGS_BODY([$1], [$2])
+AC_DEFUN([AC_WINDOWS_LIBS],[
+AC_ARG_WITH(
+    [windows-libs],
+    [AS_HELP_STRING([--with-windows-libs=3DDIR],
+		    [specify where the windows libraries are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-win=
dows-libs])]
+)
+windows_libdir=3D$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=3D$(cd $(dirname $($ac_cv_prog_CC -print-file-name=3Dli=
bcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	AC_MSG_ERROR([cannot find windows library files])
+    fi
+fi
+AC_SUBST(windows_libdir)
+]
+)
=20
-  dnl Add $INC[]NAME to CPPFLAGS before performing the following checks,
-  dnl because if the user has installed lib[]Name and not disabled its use
-  dnl via --without-lib[]Name-prefix, he wants to use it.
-  ac_save_CPPFLAGS=3D"$CPPFLAGS"
-  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INC]NAME)
+AC_DEFUN([AC_CYGWIN_INCLUDES], [
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=3D$CXX}
+: ${ac_cv_prog_CC:=3D$CC}
=20
-  AC_CACHE_CHECK([for lib[]$1], [ac_cv_lib[]Name], [
-    ac_save_LIBS=3D"$LIBS"
-    LIBS=3D"$LIBS $LIB[]NAME"
-    AC_TRY_LINK([$3], [$4], [ac_cv_lib[]Name=3Dyes], [ac_cv_lib[]Name=3Dno=
])
-    LIBS=3D"$ac_save_LIBS"
-  ])
-  if test "$ac_cv_lib[]Name" =3D yes; then
-    HAVE_LIB[]NAME=3Dyes
-    AC_DEFINE([HAVE_LIB]NAME, 1, [Define if you have the $1 library.])
-    AC_MSG_CHECKING([how to link with lib[]$1])
-    AC_MSG_RESULT([$LIB[]NAME])
-  else
-    HAVE_LIB[]NAME=3Dno
-    dnl If $LIB[]NAME didn't lead to a usable library, we don't need
-    dnl $INC[]NAME either.
-    CPPFLAGS=3D"$ac_save_CPPFLAGS"
-    LIB[]NAME=3D
-    LTLIB[]NAME=3D
-  fi
-  AC_SUBST([HAVE_LIB]NAME)
-  AC_SUBST([LIB]NAME)
-  AC_SUBST([LTLIB]NAME)
-  undefine([Name])
-  undefine([NAME])
-])
+cygwin_headers=3D$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    AC_MSG_ERROR([cannot find $winsup_srcdir/cygwin/include directory])
+fi
=20
-dnl Determine the platform dependent parameters needed to use rpath:
-dnl libext, shlibext, hardcode_libdir_flag_spec, hardcode_libdir_separator,
-dnl hardcode_direct, hardcode_minus_L.
-AC_DEFUN([AC_LIB_RPATH],
-[
-  dnl Tell automake >=3D 1.10 to complain if config.rpath is missing.
-  m4_ifdef([AC_REQUIRE_AUX_FILE], [AC_REQUIRE_AUX_FILE([config.rpath])])
-  AC_REQUIRE([AC_PROG_CC])                dnl we use $CC, $GCC, $LDFLAGS
-  AC_REQUIRE([AC_LIB_PROG_LD])            dnl we use $LD, $with_gnu_ld
-  AC_REQUIRE([AC_CANONICAL_HOST])         dnl we use $host
-  AC_REQUIRE([AC_CONFIG_AUX_DIR_DEFAULT]) dnl we use $ac_aux_dir
-  AC_CACHE_CHECK([for shared library run path origin], acl_cv_rpath, [
-    CC=3D"$CC" GCC=3D"$GCC" LDFLAGS=3D"$LDFLAGS" LD=3D"$LD" with_gnu_ld=3D=
"$with_gnu_ld" \
-    ${CONFIG_SHELL-/bin/sh} "$ac_aux_dir/config.rpath" "$host" > conftest.=
sh
-    . ./conftest.sh
-    rm -f ./conftest.sh
-    acl_cv_rpath=3Ddone
-  ])
-  wl=3D"$acl_cv_wl"
-  libext=3D"$acl_cv_libext"
-  shlibext=3D"$acl_cv_shlibext"
-  hardcode_libdir_flag_spec=3D"$acl_cv_hardcode_libdir_flag_spec"
-  hardcode_libdir_separator=3D"$acl_cv_hardcode_libdir_separator"
-  hardcode_direct=3D"$acl_cv_hardcode_direct"
-  hardcode_minus_L=3D"$acl_cv_hardcode_minus_L"
-  dnl Determine whether the user wants rpath handling at all.
-  AC_ARG_ENABLE(rpath,
-    [  --disable-rpath         do not hardcode runtime library paths],
-    :, enable_rpath=3Dyes)
-])
+newlib_headers=3D$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null &&=
 pwd)
+if test -z "$newlib_headers"; then
+    AC_MSG_ERROR([cannot find newlib source directory: $winsup_srcdir/../n=
ewlib/libc/include])
+fi
+newlib_headers=3D"$target_builddir/newlib/targ-include $newlib_headers"
=20
-dnl AC_LIB_LINKFLAGS_BODY(name [, dependencies]) searches for libname and
-dnl the libraries corresponding to explicit and implicit dependencies.
-dnl Sets the LIB${NAME}, LTLIB${NAME} and INC${NAME} variables.
-AC_DEFUN([AC_LIB_LINKFLAGS_BODY],
-[
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-  dnl By default, look in $includedir and $libdir.
-  use_additional=3Dyes
-  AC_LIB_WITH_FINAL_PREFIX([
-    eval additional_includedir=3D\"$includedir\"
-    eval additional_libdir=3D\"$libdir\"
-  ])
-  AC_LIB_ARG_WITH([lib$1-prefix],
-[  --with-lib$1-prefix[=3DDIR]  search for lib$1 in DIR/include and DIR/lib
-  --without-lib$1-prefix     don't search for lib$1 in includedir and libd=
ir],
-[
-    if test "X$withval" =3D "Xno"; then
-      use_additional=3Dno
-    else
-      if test "X$withval" =3D "X"; then
-        AC_LIB_WITH_FINAL_PREFIX([
-          eval additional_includedir=3D\"$includedir\"
-          eval additional_libdir=3D\"$libdir\"
-        ])
-      else
-        additional_includedir=3D"$withval/include"
-        additional_libdir=3D"$withval/lib"
-      fi
-    fi
-])
-  dnl Search the library and its dependencies in $additional_libdir and
-  dnl $LDFLAGS. Using breadth-first-seach.
-  LIB[]NAME=3D
-  LTLIB[]NAME=3D
-  INC[]NAME=3D
-  rpathdirs=3D
-  ltrpathdirs=3D
-  names_already_handled=3D
-  names_next_round=3D'$1 $2'
-  while test -n "$names_next_round"; do
-    names_this_round=3D"$names_next_round"
-    names_next_round=3D
-    for name in $names_this_round; do
-      already_handled=3D
-      for n in $names_already_handled; do
-        if test "$n" =3D "$name"; then
-          already_handled=3Dyes
-          break
-        fi
-      done
-      if test -z "$already_handled"; then
-        names_already_handled=3D"$names_already_handled $name"
-        dnl See if it was already located by an earlier AC_LIB_LINKFLAGS
-        dnl or AC_LIB_HAVE_LINKFLAGS call.
-        uppername=3D`echo "$name" | sed -e 'y|abcdefghijklmnopqrstuvwxyz./=
-|ABCDEFGHIJKLMNOPQRSTUVWXYZ___|'`
-        eval value=3D\"\$HAVE_LIB$uppername\"
-        if test -n "$value"; then
-          if test "$value" =3D yes; then
-            eval value=3D\"\$LIB$uppername\"
-            test -z "$value" || LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$v=
alue"
-            eval value=3D\"\$LTLIB$uppername\"
-            test -z "$value" || LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME=
:+ }$value"
-          else
-            dnl An earlier call to AC_LIB_HAVE_LINKFLAGS has determined
-            dnl that this library doesn't exist. So just drop it.
-            :
-          fi
-        else
-          dnl Search the library lib$name in $additional_libdir and $LDFLA=
GS
-          dnl and the already constructed $LIBNAME/$LTLIBNAME.
-          found_dir=3D
-          found_la=3D
-          found_so=3D
-          found_a=3D
-          if test $use_additional =3D yes; then
-            if test -n "$shlibext" && test -f "$additional_libdir/lib$name=
.$shlibext"; then
-              found_dir=3D"$additional_libdir"
-              found_so=3D"$additional_libdir/lib$name.$shlibext"
-              if test -f "$additional_libdir/lib$name.la"; then
-                found_la=3D"$additional_libdir/lib$name.la"
-              fi
-            else
-              if test -f "$additional_libdir/lib$name.$libext"; then
-                found_dir=3D"$additional_libdir"
-                found_a=3D"$additional_libdir/lib$name.$libext"
-                if test -f "$additional_libdir/lib$name.la"; then
-                  found_la=3D"$additional_libdir/lib$name.la"
-                fi
-              fi
-            fi
-          fi
-          if test "X$found_dir" =3D "X"; then
-            for x in $LDFLAGS $LTLIB[]NAME; do
-              AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-              case "$x" in
-                -L*)
-                  dir=3D`echo "X$x" | sed -e 's/^X-L//'`
-                  if test -n "$shlibext" && test -f "$dir/lib$name.$shlibe=
xt"; then
-                    found_dir=3D"$dir"
-                    found_so=3D"$dir/lib$name.$shlibext"
-                    if test -f "$dir/lib$name.la"; then
-                      found_la=3D"$dir/lib$name.la"
-                    fi
-                  else
-                    if test -f "$dir/lib$name.$libext"; then
-                      found_dir=3D"$dir"
-                      found_a=3D"$dir/lib$name.$libext"
-                      if test -f "$dir/lib$name.la"; then
-                        found_la=3D"$dir/lib$name.la"
-                      fi
-                    fi
-                  fi
-                  ;;
-              esac
-              if test "X$found_dir" !=3D "X"; then
-                break
-              fi
-            done
-          fi
-          if test "X$found_dir" !=3D "X"; then
-            dnl Found the library.
-            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-L$found_dir -l$=
name"
-            if test "X$found_so" !=3D "X"; then
-              dnl Linking with a shared library. We attempt to hardcode its
-              dnl directory into the executable's runpath, unless it's the
-              dnl standard /usr/lib.
-              if test "$enable_rpath" =3D no || test "X$found_dir" =3D "X/=
usr/lib"; then
-                dnl No hardcoding is needed.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-              else
-                dnl Use an explicit option to hardcode DIR into the result=
ing
-                dnl binary.
-                dnl Potentially add DIR to ltrpathdirs.
-                dnl The ltrpathdirs will be appended to $LTLIBNAME at the =
end.
-                haveit=3D
-                for x in $ltrpathdirs; do
-                  if test "X$x" =3D "X$found_dir"; then
-                    haveit=3Dyes
-                    break
-                  fi
-                done
-                if test -z "$haveit"; then
-                  ltrpathdirs=3D"$ltrpathdirs $found_dir"
-                fi
-                dnl The hardcoding into $LIBNAME is system dependent.
-                if test "$hardcode_direct" =3D yes; then
-                  dnl Using DIR/libNAME.so during linking hardcodes DIR in=
to the
-                  dnl resulting binary.
-                  LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                else
-                  if test -n "$hardcode_libdir_flag_spec" && test "$hardco=
de_minus_L" =3D no; then
-                    dnl Use an explicit option to hardcode DIR into the re=
sulting
-                    dnl binary.
-                    LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                    dnl Potentially add DIR to rpathdirs.
-                    dnl The rpathdirs will be appended to $LIBNAME at the =
end.
-                    haveit=3D
-                    for x in $rpathdirs; do
-                      if test "X$x" =3D "X$found_dir"; then
-                        haveit=3Dyes
-                        break
-                      fi
-                    done
-                    if test -z "$haveit"; then
-                      rpathdirs=3D"$rpathdirs $found_dir"
-                    fi
-                  else
-                    dnl Rely on "-L$found_dir".
-                    dnl But don't add it if it's already contained in the =
LDFLAGS
-                    dnl or the already constructed $LIBNAME
-                    haveit=3D
-                    for x in $LDFLAGS $LIB[]NAME; do
-                      AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                      if test "X$x" =3D "X-L$found_dir"; then
-                        haveit=3Dyes
-                        break
-                      fi
-                    done
-                    if test -z "$haveit"; then
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$found_dir"
-                    fi
-                    if test "$hardcode_minus_L" !=3D no; then
-                      dnl FIXME: Not sure whether we should use
-                      dnl "-L$found_dir -l$name" or "-L$found_dir $found_s=
o"
-                      dnl here.
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                    else
-                      dnl We cannot use $hardcode_runpath_var and LD_RUN_P=
ATH
-                      dnl here, because this doesn't fit in flags passed t=
o the
-                      dnl compiler. So give up. No hardcoding. This affect=
s only
-                      dnl very old systems.
-                      dnl FIXME: Not sure whether we should use
-                      dnl "-L$found_dir -l$name" or "-L$found_dir $found_s=
o"
-                      dnl here.
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-l$name"
-                    fi
-                  fi
-                fi
-              fi
-            else
-              if test "X$found_a" !=3D "X"; then
-                dnl Linking with a static library.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_a"
-              else
-                dnl We shouldn't come here, but anyway it's good to have a
-                dnl fallback.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$found_dir -l$na=
me"
-              fi
-            fi
-            dnl Assume the include files are nearby.
-            additional_includedir=3D
-            case "$found_dir" in
-              */lib | */lib/)
-                basedir=3D`echo "X$found_dir" | sed -e 's,^X,,' -e 's,/lib=
/*$,,'`
-                additional_includedir=3D"$basedir/include"
-                ;;
-            esac
-            if test "X$additional_includedir" !=3D "X"; then
-              dnl Potentially add $additional_includedir to $INCNAME.
-              dnl But don't add it
-              dnl   1. if it's the standard /usr/include,
-              dnl   2. if it's /usr/local/include and we are using GCC on =
Linux,
-              dnl   3. if it's already present in $CPPFLAGS or the already
-              dnl      constructed $INCNAME,
-              dnl   4. if it doesn't exist as a directory.
-              if test "X$additional_includedir" !=3D "X/usr/include"; then
-                haveit=3D
-                if test "X$additional_includedir" =3D "X/usr/local/include=
"; then
-                  if test -n "$GCC"; then
-                    case $host_os in
-                      linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-                    esac
-                  fi
-                fi
-                if test -z "$haveit"; then
-                  for x in $CPPFLAGS $INC[]NAME; do
-                    AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                    if test "X$x" =3D "X-I$additional_includedir"; then
-                      haveit=3Dyes
-                      break
-                    fi
-                  done
-                  if test -z "$haveit"; then
-                    if test -d "$additional_includedir"; then
-                      dnl Really add $additional_includedir to $INCNAME.
-                      INC[]NAME=3D"${INC[]NAME}${INC[]NAME:+ }-I$additiona=
l_includedir"
-                    fi
-                  fi
-                fi
-              fi
-            fi
-            dnl Look for dependencies.
-            if test -n "$found_la"; then
-              dnl Read the .la file. It defines the variables
-              dnl dlname, library_names, old_library, dependency_libs, cur=
rent,
-              dnl age, revision, installed, dlopen, dlpreopen, libdir.
-              save_libdir=3D"$libdir"
-              case "$found_la" in
-                */* | *\\*) . "$found_la" ;;
-                *) . "./$found_la" ;;
-              esac
-              libdir=3D"$save_libdir"
-              dnl We use only dependency_libs.
-              for dep in $dependency_libs; do
-                case "$dep" in
-                  -L*)
-                    additional_libdir=3D`echo "X$dep" | sed -e 's/^X-L//'`
-                    dnl Potentially add $additional_libdir to $LIBNAME and=
 $LTLIBNAME.
-                    dnl But don't add it
-                    dnl   1. if it's the standard /usr/lib,
-                    dnl   2. if it's /usr/local/lib and we are using GCC o=
n Linux,
-                    dnl   3. if it's already present in $LDFLAGS or the al=
ready
-                    dnl      constructed $LIBNAME,
-                    dnl   4. if it doesn't exist as a directory.
-                    if test "X$additional_libdir" !=3D "X/usr/lib"; then
-                      haveit=3D
-                      if test "X$additional_libdir" =3D "X/usr/local/lib";=
 then
-                        if test -n "$GCC"; then
-                          case $host_os in
-                            linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-                          esac
-                        fi
-                      fi
-                      if test -z "$haveit"; then
-                        haveit=3D
-                        for x in $LDFLAGS $LIB[]NAME; do
-                          AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                          if test "X$x" =3D "X-L$additional_libdir"; then
-                            haveit=3Dyes
-                            break
-                          fi
-                        done
-                        if test -z "$haveit"; then
-                          if test -d "$additional_libdir"; then
-                            dnl Really add $additional_libdir to $LIBNAME.
-                            LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$add=
itional_libdir"
-                          fi
-                        fi
-                        haveit=3D
-                        for x in $LDFLAGS $LTLIB[]NAME; do
-                          AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                          if test "X$x" =3D "X-L$additional_libdir"; then
-                            haveit=3Dyes
-                            break
-                          fi
-                        done
-                        if test -z "$haveit"; then
-                          if test -d "$additional_libdir"; then
-                            dnl Really add $additional_libdir to $LTLIBNAM=
E.
-                            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }=
-L$additional_libdir"
-                          fi
-                        fi
-                      fi
-                    fi
-                    ;;
-                  -R*)
-                    dir=3D`echo "X$dep" | sed -e 's/^X-R//'`
-                    if test "$enable_rpath" !=3D no; then
-                      dnl Potentially add DIR to rpathdirs.
-                      dnl The rpathdirs will be appended to $LIBNAME at th=
e end.
-                      haveit=3D
-                      for x in $rpathdirs; do
-                        if test "X$x" =3D "X$dir"; then
-                          haveit=3Dyes
-                          break
-                        fi
-                      done
-                      if test -z "$haveit"; then
-                        rpathdirs=3D"$rpathdirs $dir"
-                      fi
-                      dnl Potentially add DIR to ltrpathdirs.
-                      dnl The ltrpathdirs will be appended to $LTLIBNAME a=
t the end.
-                      haveit=3D
-                      for x in $ltrpathdirs; do
-                        if test "X$x" =3D "X$dir"; then
-                          haveit=3Dyes
-                          break
-                        fi
-                      done
-                      if test -z "$haveit"; then
-                        ltrpathdirs=3D"$ltrpathdirs $dir"
-                      fi
-                    fi
-                    ;;
-                  -l*)
-                    dnl Handle this in the next round.
-                    names_next_round=3D"$names_next_round "`echo "X$dep" |=
 sed -e 's/^X-l//'`
-                    ;;
-                  *.la)
-                    dnl Handle this in the next round. Throw away the .la's
-                    dnl directory; it is already contained in a preceding =
-L
-                    dnl option.
-                    names_next_round=3D"$names_next_round "`echo "X$dep" |=
 sed -e 's,^X.*/,,' -e 's,^lib,,' -e 's,\.la$,,'`
-                    ;;
-                  *)
-                    dnl Most likely an immediate library name.
-                    LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$dep"
-                    LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }$dep"
-                    ;;
-                esac
-              done
-            fi
-          else
-            dnl Didn't find the library; assume it is in the system direct=
ories
-            dnl known to the linker and runtime loader. (All the system
-            dnl directories known to the linker should also be known to the
-            dnl runtime loader, otherwise the system is severely misconfig=
ured.)
-            LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-l$name"
-            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-l$name"
-          fi
-        fi
-      fi
-    done
-  done
-  if test "X$rpathdirs" !=3D "X"; then
-    if test -n "$hardcode_libdir_separator"; then
-      dnl Weird platform: only the last -rpath option counts, the user must
-      dnl pass all path elements in one option. We can arrange that for a
-      dnl single library, but not when more than one $LIBNAMEs are used.
-      alldirs=3D
-      for found_dir in $rpathdirs; do
-        alldirs=3D"${alldirs}${alldirs:+$hardcode_libdir_separator}$found_=
dir"
-      done
-      dnl Note: hardcode_libdir_flag_spec uses $libdir and $wl.
-      acl_save_libdir=3D"$libdir"
-      libdir=3D"$alldirs"
-      eval flag=3D\"$hardcode_libdir_flag_spec\"
-      libdir=3D"$acl_save_libdir"
-      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$flag"
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers=3D"$with_windows_headers"
     else
-      dnl The -rpath options are cumulative.
-      for found_dir in $rpathdirs; do
-        acl_save_libdir=3D"$libdir"
-        libdir=3D"$found_dir"
-        eval flag=3D\"$hardcode_libdir_flag_spec\"
-        libdir=3D"$acl_save_libdir"
-        LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$flag"
-      done
-    fi
-  fi
-  if test "X$ltrpathdirs" !=3D "X"; then
-    dnl When using libtool, the option that works for both libraries and
-    dnl executables is -R. The -R options are cumulative.
-    for found_dir in $ltrpathdirs; do
-      LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-R$found_dir"
-    done
-  fi
-])
-
-dnl AC_LIB_APPENDTOVAR(VAR, CONTENTS) appends the elements of CONTENTS to =
VAR,
-dnl unless already present in VAR.
-dnl Works only for CPPFLAGS, not for LIB* variables because that sometimes
-dnl contains two or three consecutive elements that belong together.
-AC_DEFUN([AC_LIB_APPENDTOVAR],
-[
-  for element in [$2]; do
-    haveit=3D
-    for x in $[$1]; do
-      AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-      if test "X$x" =3D "X$element"; then
-        haveit=3Dyes
-        break
-      fi
-    done
-    if test -z "$haveit"; then
-      [$1]=3D"${[$1]}${[$1]:+ }$element"
+	AC_MSG_ERROR([cannot find windef.h in specified --with-windows-headers pa=
th: $saw_windows_headers]);
     fi
-  done
-])
-
-# lib-ld.m4 serial 3 (gettext-0.13)
-dnl Copyright (C) 1996-2003 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl Subroutines of libtool.m4,
-dnl with replacements s/AC_/AC_LIB/ and s/lt_cv/acl_cv/ to avoid collision
-dnl with libtool.m4.
-
-dnl From libtool-1.4. Sets the variable with_gnu_ld to yes or no.
-AC_DEFUN([AC_LIB_PROG_LD_GNU],
-[AC_CACHE_CHECK([if the linker ($LD) is GNU ld], acl_cv_prog_gnu_ld,
-[# I'd rather use --version here, but apparently some GNU ld's only accept=
 -v.
-case `$LD -v 2>&1 </dev/null` in
-*GNU* | *'with BFD'*)
-  acl_cv_prog_gnu_ld=3Dyes ;;
-*)
-  acl_cv_prog_gnu_ld=3Dno ;;
-esac])
-with_gnu_ld=3D$acl_cv_prog_gnu_ld
-])
-
-dnl From libtool-1.4. Sets the variable LD.
-AC_DEFUN([AC_LIB_PROG_LD],
-[AC_ARG_WITH(gnu-ld,
-[  --with-gnu-ld           assume the C compiler uses GNU ld [default=3Dno=
]],
-test "$withval" =3D no || with_gnu_ld=3Dyes, with_gnu_ld=3Dno)
-AC_REQUIRE([AC_PROG_CC])dnl
-AC_REQUIRE([AC_CANONICAL_HOST])dnl
-# Prepare PATH_SEPARATOR.
-# The user is always right.
-if test "${PATH_SEPARATOR+set}" !=3D set; then
-  echo "#! /bin/sh" >conf$$.sh
-  echo  "exit 0"   >>conf$$.sh
-  chmod +x conf$$.sh
-  if (PATH=3D"/nonexistent;."; conf$$.sh) >/dev/null 2>&1; then
-    PATH_SEPARATOR=3D';'
-  else
-    PATH_SEPARATOR=3D:
-  fi
-  rm -f conf$$.sh
-fi
-ac_prog=3Dld
-if test "$GCC" =3D yes; then
-  # Check if gcc -print-prog-name=3Dld gives a path.
-  AC_MSG_CHECKING([for ld used by GCC])
-  case $host in
-  *-*-mingw*)
-    # gcc leaves a trailing carriage return which upsets mingw
-    ac_prog=3D`($CC -print-prog-name=3Dld) 2>&5 | tr -d '\015'` ;;
-  *)
-    ac_prog=3D`($CC -print-prog-name=3Dld) 2>&5` ;;
-  esac
-  case $ac_prog in
-    # Accept absolute paths.
-    [[\\/]* | [A-Za-z]:[\\/]*)]
-      [re_direlt=3D'/[^/][^/]*/\.\./']
-      # Canonicalize the path of ld
-      ac_prog=3D`echo $ac_prog| sed 's%\\\\%/%g'`
-      while echo $ac_prog | grep "$re_direlt" > /dev/null 2>&1; do
-	ac_prog=3D`echo $ac_prog| sed "s%$re_direlt%/%"`
-      done
-      test -z "$LD" && LD=3D"$ac_prog"
-      ;;
-  "")
-    # If it fails, then pretend we aren't using GCC.
-    ac_prog=3Dld
-    ;;
-  *)
-    # If it is relative, then search for the first ld in PATH.
-    with_gnu_ld=3Dunknown
-    ;;
-  esac
-elif test "$with_gnu_ld" =3D yes; then
-  AC_MSG_CHECKING([for GNU ld])
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers=3D"$winsup_srcdir/w32api/include"
 else
-  AC_MSG_CHECKING([for non-GNU ld])
-fi
-AC_CACHE_VAL(acl_cv_path_LD,
-[if test -z "$LD"; then
-  IFS=3D"${IFS=3D 	}"; ac_save_ifs=3D"$IFS"; IFS=3D"${IFS}${PATH_SEPARATOR=
-:}"
-  for ac_dir in $PATH; do
-    test -z "$ac_dir" && ac_dir=3D.
-    if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext";=
 then
-      acl_cv_path_LD=3D"$ac_dir/$ac_prog"
-      # Check to see if the program is GNU ld.  I'd rather use --version,
-      # but apparently some GNU ld's only accept -v.
-      # Break only if it was the GNU/non-GNU ld that we prefer.
-      case `"$acl_cv_path_LD" -v 2>&1 < /dev/null` in
-      *GNU* | *'with BFD'*)
-	test "$with_gnu_ld" !=3D no && break ;;
-      *)
-	test "$with_gnu_ld" !=3D yes && break ;;
-      esac
+    windows_headers=3D$(cd $($ac_cv_prog_CC -xc /dev/null -E -include wind=
ef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1=
) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	AC_MSG_ERROR([cannot find windows header files])
     fi
-  done
-  IFS=3D"$ac_save_ifs"
-else
-  acl_cv_path_LD=3D"$LD" # Let the user override the test with a path.
-fi])
-LD=3D"$acl_cv_path_LD"
-if test -n "$LD"; then
-  AC_MSG_RESULT($LD)
-else
-  AC_MSG_RESULT(no)
 fi
-test -z "$LD" && AC_MSG_ERROR([no acceptable ld found in \$PATH])
-AC_LIB_PROG_LD_GNU
+CC=3D$ac_cv_prog_CC
+CXX=3D$ac_cv_prog_CXX
+export CC
+export CXX
+AC_SUBST(windows_headers)
+AC_SUBST(newlib_headers)
+AC_SUBST(cygwin_headers)
 ])
=20
-dnl This provides configure definitions used by all the winsup
-dnl configure.in files.
-
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
-  ac_cv_prog_gcc=3Dyes
-else
-  ac_cv_prog_gcc=3Dno
-fi])])
-
-AC_DEFUN([LIB_AC_PROG_CC],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CC, gcc, gcc)
-: ${CC:=3Dgcc}
-AC_PROG_CC
-test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
+AC_DEFUN([AC_CONFIGURE_ARGS], [
+configure_args=3DX
+for f in $ac_configure_args; do
+    case "$f" in
+	*--srcdir*) ;;
+	*) configure_args=3D"$configure_args $f" ;;
+    esac
+done
+configure_args=3D$(/usr/bin/expr "$configure_args" : 'X \(.*\)')
+AC_SUBST(configure_args)
 ])
=20
-AC_DEFUN([LIB_AC_PROG_CXX],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CXX, g++, g++)
-if test -z "$CXX"; then
-  AC_CHECK_TOOL(CXX, g++, c++, , , )
-  : ${CXX:=3Dg++}
-  AC_PROG_CXX
-  test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
-fi
-
-CXXFLAGS=3D'$(CFLAGS)'
-])
+AC_SUBST(target_builddir)
+AC_SUBST(winsup_srcdir)
=20
Index: cygserver/autogen.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: cygserver/autogen.sh
diff -N cygserver/autogen.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ cygserver/autogen.sh	13 Nov 2012 18:15:21 -0000
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+/usr/bin/aclocal --acdir=3D..
+/usr/bin/autoconf -f
+exec /bin/rm -rf autom4te.cache
Index: cygserver/configure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygserver/configure,v
retrieving revision 1.5
diff -d -u -p -r1.5 configure
--- cygserver/configure	7 Feb 2011 16:22:02 -0000	1.5
+++ cygserver/configure	13 Nov 2012 18:15:21 -0000
@@ -1,11 +1,9 @@
 #! /bin/sh
 # Guess values for system-dependent variables and create Makefiles.
-# Generated by GNU Autoconf 2.66.
+# Generated by GNU Autoconf 2.69.
 #
 #
-# Copyright (C) 1992, 1993, 1994, 1995, 1996, 1998, 1999, 2000, 2001,
-# 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010 Free Software
-# Foundation, Inc.
+# Copyright (C) 1992-1996, 1998-2012 Free Software Foundation, Inc.
 #
 #
 # This configure script is free software; the Free Software Foundation
@@ -89,6 +87,7 @@ fi
 IFS=3D" ""	$as_nl"
=20
 # Find who we are.  Look in the path if we contain no directory separator.
+as_myself=3D
 case $0 in #((
   *[\\/]* ) as_myself=3D$0 ;;
   *) as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
@@ -133,6 +132,31 @@ export LANGUAGE
 # CDPATH.
 (unset CDPATH) >/dev/null 2>&1 && unset CDPATH
=20
+# Use a proper internal environment variable to ensure we don't fall
+  # into an infinite loop, continuously re-executing ourselves.
+  if test x"${_as_can_reexec}" !=3D xno && test "x$CONFIG_SHELL" !=3D x; t=
hen
+    _as_can_reexec=3Dno; export _as_can_reexec;
+    # We cannot yet assume a decent shell, so we have to provide a
+# neutralization value for shells without unset; and this also
+# works around shells that cannot unset nonexistent variables.
+# Preserve -v and -x to the replacement shell.
+BASH_ENV=3D/dev/null
+ENV=3D/dev/null
+(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
+case $- in # ((((
+  *v*x* | *x*v* ) as_opts=3D-vx ;;
+  *v* ) as_opts=3D-v ;;
+  *x* ) as_opts=3D-x ;;
+  * ) as_opts=3D ;;
+esac
+exec $CONFIG_SHELL $as_opts "$as_myself" ${1+"$@"}
+# Admittedly, this is quite paranoid, since all the known shells bail
+# out after a failed `exec'.
+$as_echo "$0: could not re-execute with $CONFIG_SHELL" >&2
+as_fn_exit 255
+  fi
+  # We don't want this to propagate to other subprocesses.
+          { _as_can_reexec=3D; unset _as_can_reexec;}
 if test "x$CONFIG_SHELL" =3D x; then
   as_bourne_compatible=3D"if test -n \"\${ZSH_VERSION+set}\" && (emulate s=
h) >/dev/null 2>&1; then :
   emulate sh
@@ -166,7 +190,8 @@ if ( set x; as_fn_ret_success y && test=20
 else
   exitcode=3D1; echo positional parameters were not saved.
 fi
-test x\$exitcode =3D x0 || exit 1"
+test x\$exitcode =3D x0 || exit 1
+test -x / || exit 1"
   as_suggested=3D"  as_lineno_1=3D";as_suggested=3D$as_suggested$LINENO;as=
_suggested=3D$as_suggested" as_lineno_1a=3D\$LINENO
   as_lineno_2=3D";as_suggested=3D$as_suggested$LINENO;as_suggested=3D$as_s=
uggested" as_lineno_2a=3D\$LINENO
   eval 'test \"x\$as_lineno_1'\$as_run'\" !=3D \"x\$as_lineno_2'\$as_run'\=
" &&
@@ -210,14 +235,25 @@ IFS=3D$as_save_IFS
=20
=20
       if test "x$CONFIG_SHELL" !=3D x; then :
-  # We cannot yet assume a decent shell, so we have to provide a
-	# neutralization value for shells without unset; and this also
-	# works around shells that cannot unset nonexistent variables.
-	BASH_ENV=3D/dev/null
-	ENV=3D/dev/null
-	(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
-	export CONFIG_SHELL
-	exec "$CONFIG_SHELL" "$as_myself" ${1+"$@"}
+  export CONFIG_SHELL
+             # We cannot yet assume a decent shell, so we have to provide a
+# neutralization value for shells without unset; and this also
+# works around shells that cannot unset nonexistent variables.
+# Preserve -v and -x to the replacement shell.
+BASH_ENV=3D/dev/null
+ENV=3D/dev/null
+(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
+case $- in # ((((
+  *v*x* | *x*v* ) as_opts=3D-vx ;;
+  *v* ) as_opts=3D-v ;;
+  *x* ) as_opts=3D-x ;;
+  * ) as_opts=3D ;;
+esac
+exec $CONFIG_SHELL $as_opts "$as_myself" ${1+"$@"}
+# Admittedly, this is quite paranoid, since all the known shells bail
+# out after a failed `exec'.
+$as_echo "$0: could not re-execute with $CONFIG_SHELL" >&2
+exit 255
 fi
=20
     if test x$as_have_required =3D xno; then :
@@ -319,6 +355,14 @@ $as_echo X"$as_dir" |
=20
=20
 } # as_fn_mkdir_p
+
+# as_fn_executable_p FILE
+# -----------------------
+# Test if FILE is an executable regular file.
+as_fn_executable_p ()
+{
+  test -f "$1" && test -x "$1"
+} # as_fn_executable_p
 # as_fn_append VAR VALUE
 # ----------------------
 # Append the text in VALUE to the end of the definition contained in VAR. =
Take
@@ -440,6 +484,10 @@ as_cr_alnum=3D$as_cr_Letters$as_cr_digits
   chmod +x "$as_me.lineno" ||
     { $as_echo "$as_me: error: cannot create $as_me.lineno; rerun with a P=
OSIX shell" >&2; as_fn_exit 1; }
=20
+  # If we had to re-execute with $CONFIG_SHELL, we're ensured to have
+  # already done that, so ensure we don't try to do so again and fall
+  # in an infinite loop.  This has already happened in practice.
+  _as_can_reexec=3Dno; export _as_can_reexec
   # Don't try to exec as it changes $[0], causing all sort of problems
   # (the dirname of $[0] is not the place where we might find the
   # original and so on.  Autoconf is especially sensitive to this).
@@ -474,16 +522,16 @@ if (echo >conf$$.file) 2>/dev/null; then
     # ... but there are two gotchas:
     # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
     # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executabl=
e.
-    # In both cases, we have to default to `cp -p'.
+    # In both cases, we have to default to `cp -pR'.
     ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
-      as_ln_s=3D'cp -p'
+      as_ln_s=3D'cp -pR'
   elif ln conf$$.file conf$$ 2>/dev/null; then
     as_ln_s=3Dln
   else
-    as_ln_s=3D'cp -p'
+    as_ln_s=3D'cp -pR'
   fi
 else
-  as_ln_s=3D'cp -p'
+  as_ln_s=3D'cp -pR'
 fi
 rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
 rmdir conf$$.dir 2>/dev/null
@@ -495,28 +543,8 @@ else
   as_mkdir_p=3Dfalse
 fi
=20
-if test -x / >/dev/null 2>&1; then
-  as_test_x=3D'test -x'
-else
-  if ls -dL / >/dev/null 2>&1; then
-    as_ls_L_option=3DL
-  else
-    as_ls_L_option=3D
-  fi
-  as_test_x=3D'
-    eval sh -c '\''
-      if test -d "$1"; then
-	test -d "$1/.";
-      else
-	case $1 in #(
-	-*)set "./$1";;
-	esac;
-	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
-	???[sx]*):;;*)false;;esac;fi
-    '\'' sh
-  '
-fi
-as_executable_p=3D$as_test_x
+as_test_x=3D'test -x'
+as_executable_p=3Das_fn_executable_p
=20
 # Sed expression to map a string onto a valid CPP name.
 as_tr_cpp=3D"eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnu=
m]%_%g'"
@@ -566,6 +594,10 @@ AS
 AR
 install_host
 all_host
+cygwin_headers
+newlib_headers
+windows_headers
+CPP
 ac_ct_CXX
 CXXFLAGS
 CXX
@@ -591,6 +623,7 @@ build
 INSTALL_DATA
 INSTALL_SCRIPT
 INSTALL_PROGRAM
+windows_libdir
 target_alias
 host_alias
 build_alias
@@ -628,10 +661,14 @@ PACKAGE_VERSION
 PACKAGE_TARNAME
 PACKAGE_NAME
 PATH_SEPARATOR
-SHELL'
+SHELL
+winsup_srcdir
+target_builddir'
 ac_subst_files=3D''
 ac_user_opts=3D'
 enable_option_checking
+with_windows_headers
+with_windows_libs
 enable_debugging
 '
       ac_precious_vars=3D'build_alias
@@ -644,7 +681,8 @@ LIBS
 CPPFLAGS
 CXX
 CXXFLAGS
-CCC'
+CCC
+CPP'
=20
=20
 # Initialize some variables set by options.
@@ -707,8 +745,9 @@ do
   fi
=20
   case $ac_option in
-  *=3D*)	ac_optarg=3D`expr "X$ac_option" : '[^=3D]*=3D\(.*\)'` ;;
-  *)	ac_optarg=3Dyes ;;
+  *=3D?*) ac_optarg=3D`expr "X$ac_option" : '[^=3D]*=3D\(.*\)'` ;;
+  *=3D)   ac_optarg=3D ;;
+  *)    ac_optarg=3Dyes ;;
   esac
=20
   # Accept the important Cygnus configure options, so we can diagnose typo=
s.
@@ -1048,7 +1087,7 @@ Try \`$0 --help' for more information"
     $as_echo "$as_me: WARNING: you should use --build, --host, --target" >=
&2
     expr "x$ac_option" : ".*[^-._$as_cr_alnum]" >/dev/null &&
       $as_echo "$as_me: WARNING: invalid host type: $ac_option" >&2
-    : ${build_alias=3D$ac_option} ${host_alias=3D$ac_option} ${target_alia=
s=3D$ac_option}
+    : "${build_alias=3D$ac_option} ${host_alias=3D$ac_option} ${target_ali=
as=3D$ac_option}"
     ;;
=20
   esac
@@ -1099,8 +1138,6 @@ target=3D$target_alias
 if test "x$host_alias" !=3D x; then
   if test "x$build_alias" =3D x; then
     cross_compiling=3Dmaybe
-    $as_echo "$as_me: WARNING: if you wanted to set the --build type, don'=
t use --host.
-    If a cross compiler is detected then cross compile mode will be used" =
>&2
   elif test "x$build_alias" !=3D "x$host_alias"; then
     cross_compiling=3Dyes
   fi
@@ -1260,6 +1297,13 @@ Optional Features:
   --enable-FEATURE[=3DARG]  include FEATURE [ARG=3Dyes]
  --enable-debugging		Build a cygwin DLL which has more consistency checkin=
g for debugging
=20
+Optional Packages:
+  --with-PACKAGE[=3DARG]    use PACKAGE [ARG=3Dyes]
+  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=3Dno)
+  --with-windows-headers=3DDIR
+                          specify where the windows includes are located
+  --with-windows-libs=3DDIR specify where the windows libraries are located
+
 Some influential environment variables:
   CC          C compiler command
   CFLAGS      C compiler flags
@@ -1270,6 +1314,7 @@ Some influential environment variables:
               you have headers in a nonstandard directory <include dir>
   CXX         C++ compiler command
   CXXFLAGS    C++ compiler flags
+  CPP         C preprocessor
=20
 Use these variables to override the choices made by `configure' or to help
 it to find libraries and programs with nonstandard names/locations.
@@ -1338,9 +1383,9 @@ test -n "$ac_init_help" && exit $ac_stat
 if $ac_init_version; then
   cat <<\_ACEOF
 configure
-generated by GNU Autoconf 2.66
+generated by GNU Autoconf 2.69
=20
-Copyright (C) 2010 Free Software Foundation, Inc.
+Copyright (C) 2012 Free Software Foundation, Inc.
 This configure script is free software; the Free Software Foundation
 gives unlimited permission to copy, distribute and modify it.
 _ACEOF
@@ -1384,7 +1429,7 @@ sed 's/^/| /' conftest.$ac_ext >&5
=20
 	ac_retval=3D1
 fi
-  eval $as_lineno_stack; test "x$as_lineno_stack" =3D x && { as_lineno=3D;=
 unset as_lineno;}
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
   as_fn_set_status $ac_retval
=20
 } # ac_fn_c_try_compile
@@ -1422,16 +1467,53 @@ sed 's/^/| /' conftest.$ac_ext >&5
=20
 	ac_retval=3D1
 fi
-  eval $as_lineno_stack; test "x$as_lineno_stack" =3D x && { as_lineno=3D;=
 unset as_lineno;}
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
   as_fn_set_status $ac_retval
=20
 } # ac_fn_cxx_try_compile
+
+# ac_fn_c_try_cpp LINENO
+# ----------------------
+# Try to preprocess conftest.$ac_ext, and return whether this succeeded.
+ac_fn_c_try_cpp ()
+{
+  as_lineno=3D${as_lineno-"$1"} as_lineno_stack=3Das_lineno_stack=3D$as_li=
neno_stack
+  if { { ac_try=3D"$ac_cpp conftest.$ac_ext"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=3D\$ac_try;;
+  *) ac_try_echo=3D$ac_try;;
+esac
+eval ac_try_echo=3D"\"\$as_me:${as_lineno-$LINENO}: $ac_try_echo\""
+$as_echo "$ac_try_echo"; } >&5
+  (eval "$ac_cpp conftest.$ac_ext") 2>conftest.err
+  ac_status=3D$?
+  if test -s conftest.err; then
+    grep -v '^ *+' conftest.err >conftest.er1
+    cat conftest.er1 >&5
+    mv -f conftest.er1 conftest.err
+  fi
+  $as_echo "$as_me:${as_lineno-$LINENO}: \$? =3D $ac_status" >&5
+  test $ac_status =3D 0; } > conftest.i && {
+	 test -z "$ac_c_preproc_warn_flag$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       }; then :
+  ac_retval=3D0
+else
+  $as_echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+    ac_retval=3D1
+fi
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
+  as_fn_set_status $ac_retval
+
+} # ac_fn_c_try_cpp
 cat >config.log <<_ACEOF
 This file contains any messages produced by compilers while
 running configure, to aid debugging if configure makes a mistake.
=20
 It was created by $as_me, which was
-generated by GNU Autoconf 2.66.  Invocation command line was
+generated by GNU Autoconf 2.69.  Invocation command line was
=20
   $ $0 $@
=20
@@ -1778,9 +1860,8 @@ ac_link=3D'$CC -o conftest$ac_exeext $CFLA
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
=20
-
 ac_aux_dir=3D
-for ac_dir in ../.. "$srcdir"/../..; do
+for ac_dir in .. "$srcdir"/..; do
   if test -f "$ac_dir/install-sh"; then
     ac_aux_dir=3D$ac_dir
     ac_install_sh=3D"$ac_aux_dir/install-sh -c"
@@ -1796,7 +1877,7 @@ for ac_dir in ../.. "$srcdir"/../..; do
   fi
 done
 if test -z "$ac_aux_dir"; then
-  as_fn_error $? "cannot find install-sh, install.sh, or shtool in ../.. \=
"$srcdir\"/../.." "$LINENO" 5
+  as_fn_error $? "cannot find install-sh, install.sh, or shtool in .. \"$s=
rcdir\"/.." "$LINENO" 5
 fi
=20
 # These three variables are undocumented and unsupported,
@@ -1809,7 +1890,35 @@ ac_configure=3D"$SHELL $ac_aux_dir/configu
=20
=20
=20
-INSTALL=3D`cd $srcdir/../..; echo $(pwd)/install-sh -c`
+. ${srcdir}/../configure.cygwin
+
+
+
+# Check whether --with-windows-headers was given.
+if test "${with_windows_headers+set}" =3D set; then :
+  withval=3D$with_windows_headers; test -z "$withval" && as_fn_error $? "m=
ust specify value for --with-windows-headers" "$LINENO" 5
+
+fi
+
+
+
+
+# Check whether --with-windows-libs was given.
+if test "${with_windows_libs+set}" =3D set; then :
+  withval=3D$with_windows_libs; test -z "$withval" && as_fn_error $? "must=
 specify value for --with-windows-libs" "$LINENO" 5
+
+fi
+
+windows_libdir=3D$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=3D$(cd $(dirname $($ac_cv_prog_CC -print-file-name=3Dli=
bcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	as_fn_error $? "cannot find windows library files" "$LINENO" 5
+    fi
+fi
+
+
+
=20
 # Find a good install program.  We prefer a C program (faster),
 # so one script is as good as another.  But avoid the broken or
@@ -1828,7 +1937,7 @@ INSTALL=3D`cd $srcdir/../..; echo $(pwd)/i
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for a BSD-compatible ins=
tall" >&5
 $as_echo_n "checking for a BSD-compatible install... " >&6; }
 if test -z "$INSTALL"; then
-if test "${ac_cv_path_install+set}" =3D set; then :
+if ${ac_cv_path_install+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
@@ -1848,7 +1957,7 @@ case $as_dir/ in #((
     # by default.
     for ac_prog in ginstall scoinst install; do
       for ac_exec_ext in '' $ac_executable_extensions; do
-	if { test -f "$as_dir/$ac_prog$ac_exec_ext" && $as_test_x "$as_dir/$ac_pr=
og$ac_exec_ext"; }; then
+	if as_fn_executable_p "$as_dir/$ac_prog$ac_exec_ext"; then
 	  if test $ac_prog =3D install &&
 	    grep dspmsg "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
 	    # AIX install.  It has an incompatible calling convention.
@@ -1910,7 +2019,7 @@ $SHELL "$ac_aux_dir/config.sub" sun4 >/d
=20
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking build system type" >&5
 $as_echo_n "checking build system type... " >&6; }
-if test "${ac_cv_build+set}" =3D set; then :
+if ${ac_cv_build+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   ac_build_alias=3D$build_alias
@@ -1944,7 +2053,7 @@ case $build_os in *\ *) build_os=3D`echo "
=20
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking host system type" >&5
 $as_echo_n "checking host system type... " >&6; }
-if test "${ac_cv_host+set}" =3D set; then :
+if ${ac_cv_host+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test "x$host_alias" =3D x; then
@@ -1977,7 +2086,7 @@ case $host_os in *\ *) host_os=3D`echo "$h
=20
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking target system type" >&5
 $as_echo_n "checking target system type... " >&6; }
-if test "${ac_cv_target+set}" =3D set; then :
+if ${ac_cv_target+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test "x$target_alias" =3D x; then
@@ -2016,99 +2125,6 @@ test -n "$target_alias" &&
   program_prefix=3D${target_alias}-
=20
=20
-if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}gcc", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}gcc; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CC"; then
-  ac_cv_prog_CC=3D"$CC" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CC=3D"${ac_tool_prefix}gcc"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CC=3D$ac_cv_prog_CC
-if test -n "$CC"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CC" >&5
-$as_echo "$CC" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CC"; then
-  ac_ct_CC=3D$CC
-  # Extract the first word of "gcc", so it can be a program name with args.
-set dummy gcc; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CC+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CC"; then
-  ac_cv_prog_ac_ct_CC=3D"$ac_ct_CC" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CC=3D"gcc"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CC=3D$ac_cv_prog_ac_ct_CC
-if test -n "$ac_ct_CC"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CC" >&5
-$as_echo "$ac_ct_CC" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CC" =3D x; then
-    CC=3D"gcc"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CC=3D$ac_ct_CC
-  fi
-else
-  CC=3D"$ac_cv_prog_CC"
-fi
-
-: ${CC:=3Dgcc}
 ac_ext=3Dc
 ac_cpp=3D'$CPP $CPPFLAGS'
 ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -2119,7 +2135,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}gcc; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
+if ${ac_cv_prog_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CC"; then
@@ -2131,7 +2147,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"${ac_tool_prefix}gcc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2159,7 +2175,7 @@ if test -z "$ac_cv_prog_CC"; then
 set dummy gcc; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CC+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_CC"; then
@@ -2171,7 +2187,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CC=3D"gcc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2212,7 +2228,7 @@ if test -z "$CC"; then
 set dummy ${ac_tool_prefix}cc; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
+if ${ac_cv_prog_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CC"; then
@@ -2224,7 +2240,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"${ac_tool_prefix}cc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2252,7 +2268,7 @@ if test -z "$CC"; then
 set dummy cc; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
+if ${ac_cv_prog_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CC"; then
@@ -2265,7 +2281,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     if test "$as_dir/$ac_word$ac_exec_ext" =3D "/usr/ucb/cc"; then
        ac_prog_rejected=3Dyes
        continue
@@ -2311,7 +2327,7 @@ if test -z "$CC"; then
 set dummy $ac_tool_prefix$ac_prog; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
+if ${ac_cv_prog_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CC"; then
@@ -2323,7 +2339,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"$ac_tool_prefix$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2355,7 +2371,7 @@ do
 set dummy $ac_prog; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CC+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_CC"; then
@@ -2367,7 +2383,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CC=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2638,7 +2654,7 @@ rm -f conftest.$ac_ext conftest$ac_cv_ex
 ac_clean_files=3D$ac_clean_files_save
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for suffix of object fil=
es" >&5
 $as_echo_n "checking for suffix of object files... " >&6; }
-if test "${ac_cv_objext+set}" =3D set; then :
+if ${ac_cv_objext+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
@@ -2689,7 +2705,7 @@ OBJEXT=3D$ac_cv_objext
 ac_objext=3D$OBJEXT
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether we are using the=
 GNU C compiler" >&5
 $as_echo_n "checking whether we are using the GNU C compiler... " >&6; }
-if test "${ac_cv_c_compiler_gnu+set}" =3D set; then :
+if ${ac_cv_c_compiler_gnu+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
@@ -2726,7 +2742,7 @@ ac_test_CFLAGS=3D${CFLAGS+set}
 ac_save_CFLAGS=3D$CFLAGS
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether $CC accepts -g" =
>&5
 $as_echo_n "checking whether $CC accepts -g... " >&6; }
-if test "${ac_cv_prog_cc_g+set}" =3D set; then :
+if ${ac_cv_prog_cc_g+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   ac_save_c_werror_flag=3D$ac_c_werror_flag
@@ -2804,7 +2820,7 @@ else
 fi
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $CC option to accept=
 ISO C89" >&5
 $as_echo_n "checking for $CC option to accept ISO C89... " >&6; }
-if test "${ac_cv_prog_cc_c89+set}" =3D set; then :
+if ${ac_cv_prog_cc_c89+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   ac_cv_prog_cc_c89=3Dno
@@ -2813,8 +2829,7 @@ cat confdefs.h - <<_ACEOF >conftest.$ac_
 /* end confdefs.h.  */
 #include <stdarg.h>
 #include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+struct stat;
 /* Most of the following tests are stolen from RCS 5.7's src/conf.sh.  */
 struct buf { int x; };
 FILE * (*rcsopen) (struct buf *, struct stat *, int);
@@ -2899,195 +2914,7 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-test -z "$CC" && as_fn_error $? "no acceptable cc found in \$PATH" "$LINEN=
O" 5
-
-if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}g++", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CXX+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CXX"; then
-  ac_cv_prog_CXX=3D"$CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CXX=3D"${ac_tool_prefix}g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CXX=3D$ac_cv_prog_CXX
-if test -n "$CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CXX" >&5
-$as_echo "$CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CXX"; then
-  ac_ct_CXX=3D$CXX
-  # Extract the first word of "g++", so it can be a program name with args.
-set dummy g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CXX+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CXX"; then
-  ac_cv_prog_ac_ct_CXX=3D"$ac_ct_CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CXX=3D"g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CXX=3D$ac_cv_prog_ac_ct_CXX
-if test -n "$ac_ct_CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CXX" >&5
-$as_echo "$ac_ct_CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CXX" =3D x; then
-    CXX=3D"g++"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CXX=3D$ac_ct_CXX
-  fi
-else
-  CXX=3D"$ac_cv_prog_CXX"
-fi
-
-if test -z "$CXX"; then
-  if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}g++", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CXX+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CXX"; then
-  ac_cv_prog_CXX=3D"$CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CXX=3D"${ac_tool_prefix}g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CXX=3D$ac_cv_prog_CXX
-if test -n "$CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CXX" >&5
-$as_echo "$CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CXX"; then
-  ac_ct_CXX=3D$CXX
-  # Extract the first word of "g++", so it can be a program name with args.
-set dummy g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CXX+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CXX"; then
-  ac_cv_prog_ac_ct_CXX=3D"$ac_ct_CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CXX=3D"g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CXX=3D$ac_cv_prog_ac_ct_CXX
-if test -n "$ac_ct_CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CXX" >&5
-$as_echo "$ac_ct_CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CXX" =3D x; then
-    CXX=3D"c++"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CXX=3D$ac_ct_CXX
-  fi
-else
-  CXX=3D"$ac_cv_prog_CXX"
-fi
-
-  : ${CXX:=3Dg++}
-  ac_ext=3Dcpp
+ac_ext=3Dcpp
 ac_cpp=3D'$CXXCPP $CPPFLAGS'
 ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
 ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conftes=
t.$ac_ext $LIBS >&5'
@@ -3103,7 +2930,7 @@ if test -z "$CXX"; then
 set dummy $ac_tool_prefix$ac_prog; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CXX+set}" =3D set; then :
+if ${ac_cv_prog_CXX+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CXX"; then
@@ -3115,7 +2942,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CXX=3D"$ac_tool_prefix$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3147,7 +2974,7 @@ do
 set dummy $ac_prog; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CXX+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_CXX+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_CXX"; then
@@ -3159,7 +2986,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CXX=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3225,7 +3052,7 @@ done
=20
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether we are using the=
 GNU C++ compiler" >&5
 $as_echo_n "checking whether we are using the GNU C++ compiler... " >&6; }
-if test "${ac_cv_cxx_compiler_gnu+set}" =3D set; then :
+if ${ac_cv_cxx_compiler_gnu+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
@@ -3262,7 +3089,7 @@ ac_test_CXXFLAGS=3D${CXXFLAGS+set}
 ac_save_CXXFLAGS=3D$CXXFLAGS
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether $CXX accepts -g"=
 >&5
 $as_echo_n "checking whether $CXX accepts -g... " >&6; }
-if test "${ac_cv_prog_cxx_g+set}" =3D set; then :
+if ${ac_cv_prog_cxx_g+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   ac_save_cxx_werror_flag=3D$ac_cxx_werror_flag
@@ -3344,10 +3171,193 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-  test -z "$CC" && as_fn_error $? "no acceptable cc found in \$PATH" "$LIN=
ENO" 5
+ac_ext=3Dc
+ac_cpp=3D'$CPP $CPPFLAGS'
+ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking how to run the C preproc=
essor" >&5
+$as_echo_n "checking how to run the C preprocessor... " >&6; }
+# On Suns, sometimes $CPP names a directory.
+if test -n "$CPP" && test -d "$CPP"; then
+  CPP=3D
+fi
+if test -z "$CPP"; then
+  if ${ac_cv_prog_CPP+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+      # Double quotes because CPP needs to be expanded
+    for CPP in "$CC -E" "$CC -E -traditional-cpp" "/lib/cpp"
+    do
+      ac_preproc_ok=3Dfalse
+for ac_c_preproc_warn_flag in '' yes
+do
+  # Use a header file that comes with gcc, so configuring glibc
+  # with a fresh cross-compiler works.
+  # Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+  # <limits.h> exists even on freestanding compilers.
+  # On the NeXT, cc -E runs the code through the compiler's parser,
+  # not just through cpp. "Syntax error" is here to catch this case.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+		     Syntax error
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+
+else
+  # Broken: fails on valid input.
+continue
 fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+  # OK, works on sane cases.  Now check whether nonexistent headers
+  # can be detected and how.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#include <ac_nonexistent.h>
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+  # Broken: success on invalid input.
+continue
+else
+  # Passes both tests.
+ac_preproc_ok=3D:
+break
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+done
+# Because of `break', _AC_PREPROC_IFELSE's cleaning code was skipped.
+rm -f conftest.i conftest.err conftest.$ac_ext
+if $ac_preproc_ok; then :
+  break
+fi
+
+    done
+    ac_cv_prog_CPP=3D$CPP
+
+fi
+  CPP=3D$ac_cv_prog_CPP
+else
+  ac_cv_prog_CPP=3D$CPP
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $CPP" >&5
+$as_echo "$CPP" >&6; }
+ac_preproc_ok=3Dfalse
+for ac_c_preproc_warn_flag in '' yes
+do
+  # Use a header file that comes with gcc, so configuring glibc
+  # with a fresh cross-compiler works.
+  # Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+  # <limits.h> exists even on freestanding compilers.
+  # On the NeXT, cc -E runs the code through the compiler's parser,
+  # not just through cpp. "Syntax error" is here to catch this case.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+		     Syntax error
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+
+else
+  # Broken: fails on valid input.
+continue
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+  # OK, works on sane cases.  Now check whether nonexistent headers
+  # can be detected and how.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#include <ac_nonexistent.h>
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+  # Broken: success on invalid input.
+continue
+else
+  # Passes both tests.
+ac_preproc_ok=3D:
+break
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+done
+# Because of `break', _AC_PREPROC_IFELSE's cleaning code was skipped.
+rm -f conftest.i conftest.err conftest.$ac_ext
+if $ac_preproc_ok; then :
+
+else
+  { { $as_echo "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+$as_echo "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error $? "C preprocessor \"$CPP\" fails sanity check
+See \`config.log' for more details" "$LINENO" 5; }
+fi
+
+ac_ext=3Dc
+ac_cpp=3D'$CPP $CPPFLAGS'
+ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
+
+ac_ext=3Dc
+ac_cpp=3D'$CPP $CPPFLAGS'
+ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
+
+ac_ext=3Dcpp
+ac_cpp=3D'$CXXCPP $CPPFLAGS'
+ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conftes=
t.$ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_cxx_compiler_gnu
+
+
+
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=3D$CXX}
+: ${ac_cv_prog_CC:=3D$CC}
+
+cygwin_headers=3D$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    as_fn_error $? "cannot find $winsup_srcdir/cygwin/include directory" "=
$LINENO" 5
+fi
+
+newlib_headers=3D$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null &&=
 pwd)
+if test -z "$newlib_headers"; then
+    as_fn_error $? "cannot find newlib source directory: $winsup_srcdir/..=
/newlib/libc/include" "$LINENO" 5
+fi
+newlib_headers=3D"$target_builddir/newlib/targ-include $newlib_headers"
+
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers=3D"$with_windows_headers"
+    else
+	as_fn_error $? "cannot find windef.h in specified --with-windows-headers =
path: $saw_windows_headers" "$LINENO" 5;
+    fi
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers=3D"$winsup_srcdir/w32api/include"
+else
+    windows_headers=3D$(cd $($ac_cv_prog_CC -xc /dev/null -E -include wind=
ef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1=
) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	as_fn_error $? "cannot find windows header files" "$LINENO" 5
+    fi
+fi
+CC=3D$ac_cv_prog_CC
+CXX=3D$ac_cv_prog_CXX
+export CC
+export CXX
+
+
=20
-CXXFLAGS=3D'$(CFLAGS)'
=20
=20
 case "$with_cross_host" in
@@ -3369,7 +3379,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}ar; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_AR+set}" =3D set; then :
+if ${ac_cv_prog_AR+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$AR"; then
@@ -3381,7 +3391,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_AR=3D"${ac_tool_prefix}ar"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3409,7 +3419,7 @@ if test -z "$ac_cv_prog_AR"; then
 set dummy ar; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_AR+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_AR+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_AR"; then
@@ -3421,7 +3431,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_AR=3D"ar"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3461,7 +3471,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}as; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_AS+set}" =3D set; then :
+if ${ac_cv_prog_AS+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$AS"; then
@@ -3473,7 +3483,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_AS=3D"${ac_tool_prefix}as"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3501,7 +3511,7 @@ if test -z "$ac_cv_prog_AS"; then
 set dummy as; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_AS+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_AS+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_AS"; then
@@ -3513,7 +3523,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_AS=3D"as"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3553,7 +3563,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}ranlib; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_RANLIB+set}" =3D set; then :
+if ${ac_cv_prog_RANLIB+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$RANLIB"; then
@@ -3565,7 +3575,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_RANLIB=3D"${ac_tool_prefix}ranlib"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3593,7 +3603,7 @@ if test -z "$ac_cv_prog_RANLIB"; then
 set dummy ranlib; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_RANLIB+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_RANLIB+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_RANLIB"; then
@@ -3605,7 +3615,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_RANLIB=3D"ranlib"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3645,7 +3655,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}ld; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_LD+set}" =3D set; then :
+if ${ac_cv_prog_LD+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$LD"; then
@@ -3657,7 +3667,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_LD=3D"${ac_tool_prefix}ld"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3685,7 +3695,7 @@ if test -z "$ac_cv_prog_LD"; then
 set dummy ld; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_LD+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_LD+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_LD"; then
@@ -3697,7 +3707,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_LD=3D"ld"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3737,7 +3747,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}nm; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_NM+set}" =3D set; then :
+if ${ac_cv_prog_NM+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$NM"; then
@@ -3749,7 +3759,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_NM=3D"${ac_tool_prefix}nm"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3777,7 +3787,7 @@ if test -z "$ac_cv_prog_NM"; then
 set dummy nm; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_NM+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_NM+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_NM"; then
@@ -3789,7 +3799,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_NM=3D"nm"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3829,7 +3839,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}dlltool; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_DLLTOOL+set}" =3D set; then :
+if ${ac_cv_prog_DLLTOOL+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$DLLTOOL"; then
@@ -3841,7 +3851,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_DLLTOOL=3D"${ac_tool_prefix}dlltool"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3869,7 +3879,7 @@ if test -z "$ac_cv_prog_DLLTOOL"; then
 set dummy dlltool; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_DLLTOOL+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_DLLTOOL+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_DLLTOOL"; then
@@ -3881,7 +3891,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_DLLTOOL=3D"dlltool"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3921,7 +3931,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}windres; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_WINDRES+set}" =3D set; then :
+if ${ac_cv_prog_WINDRES+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$WINDRES"; then
@@ -3933,7 +3943,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_WINDRES=3D"${ac_tool_prefix}windres"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3961,7 +3971,7 @@ if test -z "$ac_cv_prog_WINDRES"; then
 set dummy windres; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_WINDRES+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_WINDRES+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_WINDRES"; then
@@ -3973,7 +3983,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_WINDRES=3D"windres"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -4013,7 +4023,7 @@ fi
 $as_echo_n "checking whether ${MAKE-make} sets \$(MAKE)... " >&6; }
 set x ${MAKE-make}
 ac_make=3D`$as_echo "$2" | sed 's/+/p/g; s/[^a-zA-Z0-9_]/_/g'`
-if eval "test \"\${ac_cv_prog_make_${ac_make}_set+set}\"" =3D set; then :
+if eval \${ac_cv_prog_make_${ac_make}_set+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   cat >conftest.make <<\_ACEOF
@@ -4118,10 +4128,21 @@ $as_echo "$as_me: WARNING: cache variabl
      :end' >>confcache
 if diff "$cache_file" confcache >/dev/null 2>&1; then :; else
   if test -w "$cache_file"; then
-    test "x$cache_file" !=3D "x/dev/null" &&
+    if test "x$cache_file" !=3D "x/dev/null"; then
       { $as_echo "$as_me:${as_lineno-$LINENO}: updating cache $cache_file"=
 >&5
 $as_echo "$as_me: updating cache $cache_file" >&6;}
-    cat confcache >$cache_file
+      if test ! -f "$cache_file" || test -h "$cache_file"; then
+	cat confcache >"$cache_file"
+      else
+        case $cache_file in #(
+        */* | ?:*)
+	  mv -f confcache "$cache_file"$$ &&
+	  mv -f "$cache_file"$$ "$cache_file" ;; #(
+        *)
+	  mv -f confcache "$cache_file" ;;
+	esac
+      fi
+    fi
   else
     { $as_echo "$as_me:${as_lineno-$LINENO}: not updating unwritable cache=
 $cache_file" >&5
 $as_echo "$as_me: not updating unwritable cache $cache_file" >&6;}
@@ -4189,7 +4210,7 @@ LTLIBOBJS=3D$ac_ltlibobjs
=20
=20
=20
-: ${CONFIG_STATUS=3D./config.status}
+: "${CONFIG_STATUS=3D./config.status}"
 ac_write_fail=3D0
 ac_clean_files_save=3D$ac_clean_files
 ac_clean_files=3D"$ac_clean_files $CONFIG_STATUS"
@@ -4290,6 +4311,7 @@ fi
 IFS=3D" ""	$as_nl"
=20
 # Find who we are.  Look in the path if we contain no directory separator.
+as_myself=3D
 case $0 in #((
   *[\\/]* ) as_myself=3D$0 ;;
   *) as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
@@ -4485,16 +4507,16 @@ if (echo >conf$$.file) 2>/dev/null; then
     # ... but there are two gotchas:
     # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
     # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executabl=
e.
-    # In both cases, we have to default to `cp -p'.
+    # In both cases, we have to default to `cp -pR'.
     ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
-      as_ln_s=3D'cp -p'
+      as_ln_s=3D'cp -pR'
   elif ln conf$$.file conf$$ 2>/dev/null; then
     as_ln_s=3Dln
   else
-    as_ln_s=3D'cp -p'
+    as_ln_s=3D'cp -pR'
   fi
 else
-  as_ln_s=3D'cp -p'
+  as_ln_s=3D'cp -pR'
 fi
 rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
 rmdir conf$$.dir 2>/dev/null
@@ -4554,28 +4576,16 @@ else
   as_mkdir_p=3Dfalse
 fi
=20
-if test -x / >/dev/null 2>&1; then
-  as_test_x=3D'test -x'
-else
-  if ls -dL / >/dev/null 2>&1; then
-    as_ls_L_option=3DL
-  else
-    as_ls_L_option=3D
-  fi
-  as_test_x=3D'
-    eval sh -c '\''
-      if test -d "$1"; then
-	test -d "$1/.";
-      else
-	case $1 in #(
-	-*)set "./$1";;
-	esac;
-	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
-	???[sx]*):;;*)false;;esac;fi
-    '\'' sh
-  '
-fi
-as_executable_p=3D$as_test_x
+
+# as_fn_executable_p FILE
+# -----------------------
+# Test if FILE is an executable regular file.
+as_fn_executable_p ()
+{
+  test -f "$1" && test -x "$1"
+} # as_fn_executable_p
+as_test_x=3D'test -x'
+as_executable_p=3Das_fn_executable_p
=20
 # Sed expression to map a string onto a valid CPP name.
 as_tr_cpp=3D"eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnu=
m]%_%g'"
@@ -4597,7 +4607,7 @@ cat >>$CONFIG_STATUS <<\_ACEOF || ac_wri
 # values after options handling.
 ac_log=3D"
 This file was extended by $as_me, which was
-generated by GNU Autoconf 2.66.  Invocation command line was
+generated by GNU Autoconf 2.69.  Invocation command line was
=20
   CONFIG_FILES    =3D $CONFIG_FILES
   CONFIG_HEADERS  =3D $CONFIG_HEADERS
@@ -4650,10 +4660,10 @@ cat >>$CONFIG_STATUS <<_ACEOF || ac_writ
 ac_cs_config=3D"`$as_echo "$ac_configure_args" | sed 's/^ //; s/[\\""\`\$]=
/\\\\&/g'`"
 ac_cs_version=3D"\\
 config.status
-configured by $0, generated by GNU Autoconf 2.66,
+configured by $0, generated by GNU Autoconf 2.69,
   with options \\"\$ac_cs_config\\"
=20
-Copyright (C) 2010 Free Software Foundation, Inc.
+Copyright (C) 2012 Free Software Foundation, Inc.
 This config.status script is free software; the Free Software Foundation
 gives unlimited permission to copy, distribute and modify it."
=20
@@ -4669,11 +4679,16 @@ ac_need_defaults=3D:
 while test $# !=3D 0
 do
   case $1 in
-  --*=3D*)
+  --*=3D?*)
     ac_option=3D`expr "X$1" : 'X\([^=3D]*\)=3D'`
     ac_optarg=3D`expr "X$1" : 'X[^=3D]*=3D\(.*\)'`
     ac_shift=3D:
     ;;
+  --*=3D)
+    ac_option=3D`expr "X$1" : 'X\([^=3D]*\)=3D'`
+    ac_optarg=3D
+    ac_shift=3D:
+    ;;
   *)
     ac_option=3D$1
     ac_optarg=3D$2
@@ -4695,6 +4710,7 @@ do
     $ac_shift
     case $ac_optarg in
     *\'*) ac_optarg=3D`$as_echo "$ac_optarg" | sed "s/'/'\\\\\\\\''/g"` ;;
+    '') as_fn_error $? "missing file argument" ;;
     esac
     as_fn_append CONFIG_FILES " '$ac_optarg'"
     ac_need_defaults=3Dfalse;;
@@ -4725,7 +4741,7 @@ fi
 _ACEOF
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=3D1
 if \$ac_cs_recheck; then
-  set X '$SHELL' '$0' $ac_configure_args \$ac_configure_extra_args --no-cr=
eate --no-recursion
+  set X $SHELL '$0' $ac_configure_args \$ac_configure_extra_args --no-crea=
te --no-recursion
   shift
   \$as_echo "running CONFIG_SHELL=3D$SHELL \$*" >&6
   CONFIG_SHELL=3D'$SHELL'
@@ -4777,9 +4793,10 @@ fi
 # after its creation but before its name has been assigned to `$tmp'.
 $debug ||
 {
-  tmp=3D
+  tmp=3D ac_tmp=3D
   trap 'exit_status=3D$?
-  { test -z "$tmp" || test ! -d "$tmp" || rm -fr "$tmp"; } && exit $exit_s=
tatus
+  : "${ac_tmp:=3D$tmp}"
+  { test ! -d "$ac_tmp" || rm -fr "$ac_tmp"; } && exit $exit_status
 ' 0
   trap 'as_fn_exit 1' 1 2 13 15
 }
@@ -4787,12 +4804,13 @@ $debug ||
=20
 {
   tmp=3D`(umask 077 && mktemp -d "./confXXXXXX") 2>/dev/null` &&
-  test -n "$tmp" && test -d "$tmp"
+  test -d "$tmp"
 }  ||
 {
   tmp=3D./conf$$-$RANDOM
   (umask 077 && mkdir "$tmp")
 } || as_fn_error $? "cannot create a temporary directory in ." "$LINENO" 5
+ac_tmp=3D$tmp
=20
 # Set up the scripts for CONFIG_FILES section.
 # No need to generate them if there are no CONFIG_FILES.
@@ -4814,7 +4832,7 @@ else
   ac_cs_awk_cr=3D$ac_cr
 fi
=20
-echo 'BEGIN {' >"$tmp/subs1.awk" &&
+echo 'BEGIN {' >"$ac_tmp/subs1.awk" &&
 _ACEOF
=20
=20
@@ -4842,7 +4860,7 @@ done
 rm -f conf$$subs.sh
=20
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=3D1
-cat >>"\$tmp/subs1.awk" <<\\_ACAWK &&
+cat >>"\$ac_tmp/subs1.awk" <<\\_ACAWK &&
 _ACEOF
 sed -n '
 h
@@ -4890,7 +4908,7 @@ t delim
 rm -f conf$$subs.awk
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=3D1
 _ACAWK
-cat >>"\$tmp/subs1.awk" <<_ACAWK &&
+cat >>"\$ac_tmp/subs1.awk" <<_ACAWK &&
   for (key in S) S_is_set[key] =3D 1
   FS =3D "=07"
=20
@@ -4922,7 +4940,7 @@ if sed "s/$ac_cr//" < /dev/null > /dev/n
   sed "s/$ac_cr\$//; s/$ac_cr/$ac_cs_awk_cr/g"
 else
   cat
-fi < "$tmp/subs1.awk" > "$tmp/subs.awk" \
+fi < "$ac_tmp/subs1.awk" > "$ac_tmp/subs.awk" \
   || as_fn_error $? "could not setup config files machinery" "$LINENO" 5
 _ACEOF
=20
@@ -4981,7 +4999,7 @@ do
     for ac_f
     do
       case $ac_f in
-      -) ac_f=3D"$tmp/stdin";;
+      -) ac_f=3D"$ac_tmp/stdin";;
       *) # Look for the file first in the build tree, then in the source t=
ree
 	 # (if the path is not absolute).  The absolute path cannot be DOS-style,
 	 # because $ac_f cannot contain `:'.
@@ -5016,7 +5034,7 @@ $as_echo "$as_me: creating $ac_file" >&6
     esac
=20
     case $ac_tag in
-    *:-:* | *:-) cat >"$tmp/stdin" \
+    *:-:* | *:-) cat >"$ac_tmp/stdin" \
       || as_fn_error $? "could not create $ac_file" "$LINENO" 5 ;;
     esac
     ;;
@@ -5147,21 +5165,22 @@ s&@abs_top_builddir@&$ac_abs_top_builddi
 s&@INSTALL@&$ac_INSTALL&;t t
 $ac_datarootdir_hack
 "
-eval sed \"\$ac_sed_extra\" "$ac_file_inputs" | $AWK -f "$tmp/subs.awk" >$=
tmp/out \
-  || as_fn_error $? "could not create $ac_file" "$LINENO" 5
+eval sed \"\$ac_sed_extra\" "$ac_file_inputs" | $AWK -f "$ac_tmp/subs.awk"=
 \
+  >$ac_tmp/out || as_fn_error $? "could not create $ac_file" "$LINENO" 5
=20
 test -z "$ac_datarootdir_hack$ac_datarootdir_seen" &&
-  { ac_out=3D`sed -n '/\${datarootdir}/p' "$tmp/out"`; test -n "$ac_out"; =
} &&
-  { ac_out=3D`sed -n '/^[	 ]*datarootdir[	 ]*:*=3D/p' "$tmp/out"`; test -z=
 "$ac_out"; } &&
+  { ac_out=3D`sed -n '/\${datarootdir}/p' "$ac_tmp/out"`; test -n "$ac_out=
"; } &&
+  { ac_out=3D`sed -n '/^[	 ]*datarootdir[	 ]*:*=3D/p' \
+      "$ac_tmp/out"`; test -z "$ac_out"; } &&
   { $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: $ac_file contains a re=
ference to the variable \`datarootdir'
 which seems to be undefined.  Please make sure it is defined" >&5
 $as_echo "$as_me: WARNING: $ac_file contains a reference to the variable \=
`datarootdir'
 which seems to be undefined.  Please make sure it is defined" >&2;}
=20
-  rm -f "$tmp/stdin"
+  rm -f "$ac_tmp/stdin"
   case $ac_file in
-  -) cat "$tmp/out" && rm -f "$tmp/out";;
-  *) rm -f "$ac_file" && mv "$tmp/out" "$ac_file";;
+  -) cat "$ac_tmp/out" && rm -f "$ac_tmp/out";;
+  *) rm -f "$ac_file" && mv "$ac_tmp/out" "$ac_file";;
   esac \
   || as_fn_error $? "could not create $ac_file" "$LINENO" 5
  ;;
Index: cygserver/configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygserver/configure.in,v
retrieving revision 1.5
diff -d -u -p -r1.5 configure.in
--- cygserver/configure.in	7 Feb 2011 16:22:02 -0000	1.5
+++ cygserver/configure.in	13 Nov 2012 18:15:21 -0000
@@ -11,16 +11,23 @@ dnl Process this file with autoconf to p
=20
 AC_PREREQ(2.59)dnl
 AC_INIT(cygserver.cc)
+AC_CONFIG_AUX_DIR(..)
=20
-AC_CONFIG_AUX_DIR(../..)
+. ${srcdir}/../configure.cygwin
=20
-INSTALL=3D`cd $srcdir/../..; echo $(pwd)/install-sh -c`
+AC_WINDOWS_HEADERS
+AC_WINDOWS_LIBS
=20
 AC_PROG_INSTALL
 AC_CANONICAL_SYSTEM
=20
-LIB_AC_PROG_CC
-LIB_AC_PROG_CXX
+AC_PROG_CC
+AC_PROG_CXX
+AC_PROG_CPP
+AC_LANG(C)
+AC_LANG(C++)
+
+AC_CYGWIN_INCLUDES
=20
 case "$with_cross_host" in
   ""|*cygwin*)
Index: cygwin/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygwin/Makefile.in,v
retrieving revision 1.258
diff -d -u -p -r1.258 Makefile.in
--- cygwin/Makefile.in	24 Oct 2012 10:12:45 -0000	1.258
+++ cygwin/Makefile.in	13 Nov 2012 18:15:21 -0000
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
=20
 # This makefile requires GNU make.
-#
-# Include common definitions for winsup directory
-# The following assignments are "inputs" to Makefile.common
-#
-CC:=3D@CC@
-CC_FOR_TARGET:=3D$(CC)
+
 srcdir:=3D@srcdir@
-CONFIG_DIR:=3D$(srcdir)/config/@CONFIG_DIR@
+target_builddir:=3D@target_builddir@
+winsup_srcdir:=3D@winsup_srcdir@
+configure_args=3D@configure_args@
+
+export CC:=3D@CC@
+export CXX:=3D@CXX@
+
 include ${srcdir}/../Makefile.common
=20
-SHELL:=3D@SHELL@
-objdir:=3D.
+# environment variables used by ccwrap
+export CCWRAP_HEADERS:=3D. ${srcdir}
+export CCWRAP_SYSTEM_HEADERS:=3D@cygwin_headers@ @newlib_headers@
+export CCWRAP_DIRAFTER_HEADERS:=3D@windows_headers@
=20
-VPATH:=3D$(srcdir):$(CONFIG_DIR):$(srcdir)/regex:$(srcdir)/lib:$(srcdir)/l=
ibc
+VPATH+=3D$(CONFIG_DIR) $(srcdir)/regex $(srcdir)/lib $(srcdir)/libc
=20
 target_alias:=3D@target_alias@
 build_alias:=3D@build_alias@
@@ -35,6 +39,7 @@ bindir:=3D@bindir@
 libdir:=3D@libdir@
 mandir:=3D@mandir@
 sysconfdir:=3D@sysconfdir@
+datarootdir:=3D@datarootdir@
 ifeq ($(target_alias),$(host_alias))
 ifeq ($(build_alias),$(host_alias))
 tooldir:=3D$(exec_prefix)
@@ -52,17 +57,29 @@ override INSTALL:=3D@INSTALL@
 override INSTALL_PROGRAM:=3D@INSTALL_PROGRAM@
 override INSTALL_DATA:=3D@INSTALL_DATA@
=20
+WINDOWS_LIBDIR:=3D@windows_libdir@
+
+cygserver_blddir:=3D${target_builddir}/winsup/cygserver
+LIBSERVER:=3D${cygserver_blddir}/libcygserver.a
+
+LIBC:=3D$(newlib_build)/libc/libc.a
+LIBM:=3D$(newlib_build)/libm/libm.a
+CRT0:=3D$(cygwin_build)/crt0.o
+
 #
 # --enable options from configure
 #
 MT_SAFE:=3D@MT_SAFE@
 DEFS:=3D@DEFS@
-CCEXTRA:=3D
+CCEXTRA=3D
+COMMON_CFLAGS=3D-MMD ${$(*F)_CFLAGS} -Werror -fmerge-constants -ftracer $(=
CCEXTRA)
 CFLAGS?=3D@CFLAGS@
-override CFLAGS+=3D-MMD ${$(*F)_CFLAGS} -Werror -fmerge-constants -ftracer=
 \
-  -mno-use-libstdc-wrappers $(CCEXTRA)
-CXX=3D@CXX@
-override CXXFLAGS=3D@CXXFLAGS@
+CXXFLAGS?=3D@CXXFLAGS@
+ifeq "$(filter -O%,${CFLAGS})" ""
+override CXXFLAGS:=3D$(filter-out -O%,${CXXFLAGS})
+endif
+COMPILE.cc+=3D${COMMON_CFLAGS} -mno-use-libstdc-wrappers
+COMPILE.c+=3D${COMMON_CFLAGS}
=20
 AR:=3D@AR@
 AR_FLAGS:=3Dqv
@@ -169,6 +186,13 @@ EXCLUDE_STATIC_OFILES:=3D$(addprefix --exc
 	spawn.o \
 )
=20
+ifdef PREPROCESS
+override DLL_OFILES:=3D$(patsubst %.o,%_E,${DLL_OFILES})
+override EXCLUDE_STATIC_OFILES:=3D$(patsubst %.o,%_E,${EXCLUDE_STATIC_OFIL=
ES})
+override EXTRA_OFILES=3D$(patsubst %.o,%_E,${DLL_OFILES}))
+override MALLOC_OFILES:=3D$(patsubst %.o,%.E,${MALLOC_OFILES})
+endif #PREPROCESS
+
 GMON_OFILES:=3Dgmon.o mcount.o profil.o
=20
 NEW_FUNCTIONS:=3D$(addprefix --replace=3D,\
@@ -227,7 +251,6 @@ NEW_FUNCTIONS:=3D$(addprefix --replace=3D,\
 API_VER:=3D$(srcdir)/include/cygwin/version.h
=20
 LIB_NAME:=3Dlibcygwin.a
-LIBSERVER:=3D@LIBSERVER@
 SUBLIBS:=3Dlibpthread.a libutil.a ${CURDIR}/libm.a ${CURDIR}/libc.a libdl.=
a libresolv.a librt.a
 EXTRALIBS:=3Dlibautomode.a libbinmode.a libtextmode.a libtextreadmode.a
 INSTOBJS:=3Dautomode.o binmode.o textmode.o textreadmode.o
@@ -299,9 +322,6 @@ cxx_STDINCFLAGS:=3Dyes
 .PHONY: all force dll_ofiles install all_target install_target all_host in=
stall_host \
 	install install-libs install-headers
=20
-.SUFFIXES:
-.SUFFIXES: .c .cc .def .a .o .d .s
-
 all_host=3D@all_host@
 install_host=3D@install_host@
=20
@@ -385,8 +405,8 @@ uninstall-man:
 	done
=20
 clean:
-	-rm -f *.o *.dll *.dbg *.a *.exp junk *.base version.cc winver_stamp *.ex=
e *.d *stamp* *_magic.h sigfe.s cygwin.def globals.h $(srcdir)/tlsoffsets.h=
 $(srcdir)/devices.cc
-	-@$(MAKE) -C $(bupdir)/cygserver libclean
+	-rm -f *.o *.dll *.dbg *.a *.exp junk *.base version.cc winver_stamp *.ex=
e *.d *stamp* *_magic.h sigfe.s cygwin.def globals.h tlsoffsets.h $(srcdir)=
/devices.cc
+	-@$(MAKE) -C ${cygserver_blddir} libclean
=20
 maintainer-clean realclean: clean
 	@echo "This command is intended for maintainers to use;"
@@ -396,7 +416,7 @@ maintainer-clean realclean: clean
=20
 # Rule to build cygwin.dll
 $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(LIBSERVER) $(LIBC)=
 $(LIBM) $(API_VER) Makefile winver_stamp
-	$(CXX) $(CXXFLAGS) -Wl,--gc-sections $(nostdlib) -Wl,-T$(firstword $^) -s=
tatic \
+	$(CXX) $(CXXFLAGS) -L${WINDOWS_LIBDIR} -Wl,--gc-sections $(nostdlib) -Wl,=
-T$(firstword $^) -static \
 	-Wl,--heap=3D0 -Wl,--out-implib,cygdll.a -shared -o $@ \
 	-e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) version.o winver.o \
 	$(MALLOC_OBJ) $(LIBSERVER) $(LIBM) $(LIBC) \
@@ -416,8 +436,12 @@ ${STATIC_LIB_NAME}: mkstatic ${TEST_DLL_
 $(TEST_LIB_NAME): $(LIB_NAME)
 	perl -p -e 'BEGIN{binmode(STDIN); binmode(STDOUT);}; s/cygwin1/cygwin0/g'=
 < $? > $@
=20
-$(LIBSERVER): $(bupdir)/cygserver/Makefile
-	$(MAKE) -C $(bupdir)/cygserver libcygserver.a
+$(LIBSERVER): ${cygserver_blddir}/Makefile
+	$(MAKE) -C ${cygserver_blddir} libcygserver.a
+
+${cygserver_blddir}/Makefile:
+	mkdir -p ${@D}
+	cd ${@D} && exec /bin/sh $(dir ${srcdir})/cygserver/configure ${configure=
_args}
=20
 dll_ofiles: $(DLL_OFILES)
=20
@@ -436,10 +460,10 @@ globals.h: mkglobals_h globals.cc
 ${DLL_OFILES} ${LIBCOS}: globals.h
=20
 shared_info_magic.h: cygmagic shared_info.h
-	/bin/sh $(word 1,$^) $@ "${COMPILE_CXX} -E -x c++" $(word 2,$^) SHARED_MA=
GIC 'class shared_info' USER_MAGIC 'class user_info'
+	/bin/sh $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) SHARED_MAG=
IC 'class shared_info' USER_MAGIC 'class user_info'
=20
 child_info_magic.h: cygmagic child_info.h
-	/bin/sh $(word 1,$^) $@ "${COMPILE_CXX} -E -x c++" $(word 2,$^) CHILD_INF=
O_MAGIC 'class child_info'
+	/bin/sh $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) CHILD_INFO=
_MAGIC 'class child_info'
=20
 dcrt0.o sigproc.o: child_info_magic.h
=20
@@ -473,18 +497,19 @@ ${EXTRALIBS}: lib%.a: %.o
 	$(AR) cru $@ $?
=20
 winver_stamp: mkvers.sh include/cygwin/version.h winver.rc $(DLL_OFILES)
-	@echo "Making version.o and winver.o";\
-	$(SHELL) ${word 1,$^} ${word 2,$^} ${word 3,$^} $(WINDRES) && \
-	$(COMPILE_CXX) -c -o version.o version.cc && \
+	echo "Making version.o and winver.o";\
+	/bin/sh ${word 1,$^} ${word 2,$^} ${word 3,$^} $(WINDRES) ${CFLAGS} ${INC=
LUDES} && \
+	$(COMPILE.cc) -c -o version.o version.cc && \
 	touch $@
=20
-Makefile: cygwin.din
+Makefile: cygwin.din ${srcdir}/Makefile.in
+	/bin/sh ./config.status
=20
-$(DEF_FILE): gendef cygwin.din $(srcdir)/tlsoffsets.h
+$(DEF_FILE): gendef cygwin.din tlsoffsets.h
 	$^ $@ sigfe.s
=20
-$(srcdir)/tlsoffsets.h: gentls_offsets cygtls.h
-	$^ $@ $(COMPILE_CXX) -c
+tlsoffsets.h: gentls_offsets cygtls.h
+	$^ $@ $(COMPILE.cc) -c
=20
 sigfe.s: $(DEF_FILE)
 	@[ -s $@ ] || \
@@ -494,8 +519,6 @@ sigfe.s: $(DEF_FILE)
 sigfe.o: sigfe.s
 	$(CC) -c -o $@ $<
=20
-winsup.h: config.h
-
 ctags: CTAGS
 tags:  CTAGS
 CTAGS:
Index: cygwin/aclocal.m4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygwin/aclocal.m4,v
retrieving revision 1.1
diff -d -u -p -r1.1 aclocal.m4
--- cygwin/aclocal.m4	24 May 2006 16:59:02 -0000	1.1
+++ cygwin/aclocal.m4	13 Nov 2012 18:15:21 -0000
@@ -1,875 +1,97 @@
-dnl aclocal.m4 generated automatically by aclocal 1.4-p6
-
-dnl Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY, to the extent permitted by law; without
-dnl even the implied warranty of MERCHANTABILITY or FITNESS FOR A
-dnl PARTICULAR PURPOSE.
-
-# lib-prefix.m4 serial 4 (gettext-0.14.2)
-dnl Copyright (C) 2001-2005 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl From Bruno Haible.
-
-dnl AC_LIB_ARG_WITH is synonymous to AC_ARG_WITH in autoconf-2.13, and
-dnl similar to AC_ARG_WITH in autoconf 2.52...2.57 except that is doesn't
-dnl require excessive bracketing.
-ifdef([AC_HELP_STRING],
-[AC_DEFUN([AC_LIB_ARG_WITH], [AC_ARG_WITH([$1],[[$2]],[$3],[$4])])],
-[AC_DEFUN([AC_][LIB_ARG_WITH], [AC_ARG_WITH([$1],[$2],[$3],[$4])])])
-
-dnl AC_LIB_PREFIX adds to the CPPFLAGS and LDFLAGS the flags that are need=
ed
-dnl to access previously installed libraries. The basic assumption is that
-dnl a user will want packages to use other packages he previously installed
-dnl with the same --prefix option.
-dnl This macro is not needed if only AC_LIB_LINKFLAGS is used to locate
-dnl libraries, but is otherwise very convenient.
-AC_DEFUN([AC_LIB_PREFIX],
-[
-  AC_BEFORE([$0], [AC_LIB_LINKFLAGS])
-  AC_REQUIRE([AC_PROG_CC])
-  AC_REQUIRE([AC_CANONICAL_HOST])
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  dnl By default, look in $includedir and $libdir.
-  use_additional=3Dyes
-  AC_LIB_WITH_FINAL_PREFIX([
-    eval additional_includedir=3D\"$includedir\"
-    eval additional_libdir=3D\"$libdir\"
-  ])
-  AC_LIB_ARG_WITH([lib-prefix],
-[  --with-lib-prefix[=3DDIR] search for libraries in DIR/include and DIR/l=
ib
-  --without-lib-prefix    don't search for libraries in includedir and lib=
dir],
-[
-    if test "X$withval" =3D "Xno"; then
-      use_additional=3Dno
-    else
-      if test "X$withval" =3D "X"; then
-        AC_LIB_WITH_FINAL_PREFIX([
-          eval additional_includedir=3D\"$includedir\"
-          eval additional_libdir=3D\"$libdir\"
-        ])
-      else
-        additional_includedir=3D"$withval/include"
-        additional_libdir=3D"$withval/lib"
-      fi
-    fi
-])
-  if test $use_additional =3D yes; then
-    dnl Potentially add $additional_includedir to $CPPFLAGS.
-    dnl But don't add it
-    dnl   1. if it's the standard /usr/include,
-    dnl   2. if it's already present in $CPPFLAGS,
-    dnl   3. if it's /usr/local/include and we are using GCC on Linux,
-    dnl   4. if it doesn't exist as a directory.
-    if test "X$additional_includedir" !=3D "X/usr/include"; then
-      haveit=3D
-      for x in $CPPFLAGS; do
-        AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-        if test "X$x" =3D "X-I$additional_includedir"; then
-          haveit=3Dyes
-          break
-        fi
-      done
-      if test -z "$haveit"; then
-        if test "X$additional_includedir" =3D "X/usr/local/include"; then
-          if test -n "$GCC"; then
-            case $host_os in
-              linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-            esac
-          fi
-        fi
-        if test -z "$haveit"; then
-          if test -d "$additional_includedir"; then
-            dnl Really add $additional_includedir to $CPPFLAGS.
-            CPPFLAGS=3D"${CPPFLAGS}${CPPFLAGS:+ }-I$additional_includedir"
-          fi
-        fi
-      fi
-    fi
-    dnl Potentially add $additional_libdir to $LDFLAGS.
-    dnl But don't add it
-    dnl   1. if it's the standard /usr/lib,
-    dnl   2. if it's already present in $LDFLAGS,
-    dnl   3. if it's /usr/local/lib and we are using GCC on Linux,
-    dnl   4. if it doesn't exist as a directory.
-    if test "X$additional_libdir" !=3D "X/usr/lib"; then
-      haveit=3D
-      for x in $LDFLAGS; do
-        AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-        if test "X$x" =3D "X-L$additional_libdir"; then
-          haveit=3Dyes
-          break
-        fi
-      done
-      if test -z "$haveit"; then
-        if test "X$additional_libdir" =3D "X/usr/local/lib"; then
-          if test -n "$GCC"; then
-            case $host_os in
-              linux*) haveit=3Dyes;;
-            esac
-          fi
-        fi
-        if test -z "$haveit"; then
-          if test -d "$additional_libdir"; then
-            dnl Really add $additional_libdir to $LDFLAGS.
-            LDFLAGS=3D"${LDFLAGS}${LDFLAGS:+ }-L$additional_libdir"
-          fi
-        fi
-      fi
-    fi
-  fi
-])
-
-dnl AC_LIB_PREPARE_PREFIX creates variables acl_final_prefix,
-dnl acl_final_exec_prefix, containing the values to which $prefix and
-dnl $exec_prefix will expand at the end of the configure script.
-AC_DEFUN([AC_LIB_PREPARE_PREFIX],
-[
-  dnl Unfortunately, prefix and exec_prefix get only finally determined
-  dnl at the end of configure.
-  if test "X$prefix" =3D "XNONE"; then
-    acl_final_prefix=3D"$ac_default_prefix"
-  else
-    acl_final_prefix=3D"$prefix"
-  fi
-  if test "X$exec_prefix" =3D "XNONE"; then
-    acl_final_exec_prefix=3D'${prefix}'
-  else
-    acl_final_exec_prefix=3D"$exec_prefix"
-  fi
-  acl_save_prefix=3D"$prefix"
-  prefix=3D"$acl_final_prefix"
-  eval acl_final_exec_prefix=3D\"$acl_final_exec_prefix\"
-  prefix=3D"$acl_save_prefix"
-])
+# generated automatically by aclocal 1.12.1 -*- Autoconf -*-
=20
-dnl AC_LIB_WITH_FINAL_PREFIX([statement]) evaluates statement, with the
-dnl variables prefix and exec_prefix bound to the values they will have
-dnl at the end of the configure script.
-AC_DEFUN([AC_LIB_WITH_FINAL_PREFIX],
-[
-  acl_save_prefix=3D"$prefix"
-  prefix=3D"$acl_final_prefix"
-  acl_save_exec_prefix=3D"$exec_prefix"
-  exec_prefix=3D"$acl_final_exec_prefix"
-  $1
-  exec_prefix=3D"$acl_save_exec_prefix"
-  prefix=3D"$acl_save_prefix"
-])
+# Copyright (C) 1996-2012 Free Software Foundation, Inc.
=20
-# lib-link.m4 serial 6 (gettext-0.14.3)
-dnl Copyright (C) 2001-2005 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
=20
-dnl From Bruno Haible.
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
+# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
+# PARTICULAR PURPOSE.
=20
-AC_PREREQ(2.50)
+dnl This provides configure definitions used by all the cygwin
+dnl configure.in files.
=20
-dnl AC_LIB_LINKFLAGS(name [, dependencies]) searches for libname and
-dnl the libraries corresponding to explicit and implicit dependencies.
-dnl Sets and AC_SUBSTs the LIB${NAME} and LTLIB${NAME} variables and
-dnl augments the CPPFLAGS variable.
-AC_DEFUN([AC_LIB_LINKFLAGS],
-[
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  AC_REQUIRE([AC_LIB_RPATH])
-  define([Name],[translit([$1],[./-], [___])])
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-  AC_CACHE_CHECK([how to link with lib[]$1], [ac_cv_lib[]Name[]_libs], [
-    AC_LIB_LINKFLAGS_BODY([$1], [$2])
-    ac_cv_lib[]Name[]_libs=3D"$LIB[]NAME"
-    ac_cv_lib[]Name[]_ltlibs=3D"$LTLIB[]NAME"
-    ac_cv_lib[]Name[]_cppflags=3D"$INC[]NAME"
-  ])
-  LIB[]NAME=3D"$ac_cv_lib[]Name[]_libs"
-  LTLIB[]NAME=3D"$ac_cv_lib[]Name[]_ltlibs"
-  INC[]NAME=3D"$ac_cv_lib[]Name[]_cppflags"
-  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INC]NAME)
-  AC_SUBST([LIB]NAME)
-  AC_SUBST([LTLIB]NAME)
-  dnl Also set HAVE_LIB[]NAME so that AC_LIB_HAVE_LINKFLAGS can reuse the
-  dnl results of this search when this library appears as a dependency.
-  HAVE_LIB[]NAME=3Dyes
-  undefine([Name])
-  undefine([NAME])
+AC_DEFUN([AC_WINDOWS_HEADERS],[
+AC_ARG_WITH(
+    [windows-headers],
+    [AS_HELP_STRING([--with-windows-headers=3DDIR],
+		    [specify where the windows includes are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-win=
dows-headers])]
+)
 ])
=20
-dnl AC_LIB_HAVE_LINKFLAGS(name, dependencies, includes, testcode)
-dnl searches for libname and the libraries corresponding to explicit and
-dnl implicit dependencies, together with the specified include files and
-dnl the ability to compile and link the specified testcode. If found, it
-dnl sets and AC_SUBSTs HAVE_LIB${NAME}=3Dyes and the LIB${NAME} and
-dnl LTLIB${NAME} variables and augments the CPPFLAGS variable, and
-dnl #defines HAVE_LIB${NAME} to 1. Otherwise, it sets and AC_SUBSTs
-dnl HAVE_LIB${NAME}=3Dno and LIB${NAME} and LTLIB${NAME} to empty.
-AC_DEFUN([AC_LIB_HAVE_LINKFLAGS],
-[
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  AC_REQUIRE([AC_LIB_RPATH])
-  define([Name],[translit([$1],[./-], [___])])
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-
-  dnl Search for lib[]Name and define LIB[]NAME, LTLIB[]NAME and INC[]NAME
-  dnl accordingly.
-  AC_LIB_LINKFLAGS_BODY([$1], [$2])
+AC_DEFUN([AC_WINDOWS_LIBS],[
+AC_ARG_WITH(
+    [windows-libs],
+    [AS_HELP_STRING([--with-windows-libs=3DDIR],
+		    [specify where the windows libraries are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-win=
dows-libs])]
+)
+windows_libdir=3D$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=3D$(cd $(dirname $($ac_cv_prog_CC -print-file-name=3Dli=
bcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	AC_MSG_ERROR([cannot find windows library files])
+    fi
+fi
+AC_SUBST(windows_libdir)
+]
+)
=20
-  dnl Add $INC[]NAME to CPPFLAGS before performing the following checks,
-  dnl because if the user has installed lib[]Name and not disabled its use
-  dnl via --without-lib[]Name-prefix, he wants to use it.
-  ac_save_CPPFLAGS=3D"$CPPFLAGS"
-  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INC]NAME)
+AC_DEFUN([AC_CYGWIN_INCLUDES], [
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=3D$CXX}
+: ${ac_cv_prog_CC:=3D$CC}
=20
-  AC_CACHE_CHECK([for lib[]$1], [ac_cv_lib[]Name], [
-    ac_save_LIBS=3D"$LIBS"
-    LIBS=3D"$LIBS $LIB[]NAME"
-    AC_TRY_LINK([$3], [$4], [ac_cv_lib[]Name=3Dyes], [ac_cv_lib[]Name=3Dno=
])
-    LIBS=3D"$ac_save_LIBS"
-  ])
-  if test "$ac_cv_lib[]Name" =3D yes; then
-    HAVE_LIB[]NAME=3Dyes
-    AC_DEFINE([HAVE_LIB]NAME, 1, [Define if you have the $1 library.])
-    AC_MSG_CHECKING([how to link with lib[]$1])
-    AC_MSG_RESULT([$LIB[]NAME])
-  else
-    HAVE_LIB[]NAME=3Dno
-    dnl If $LIB[]NAME didn't lead to a usable library, we don't need
-    dnl $INC[]NAME either.
-    CPPFLAGS=3D"$ac_save_CPPFLAGS"
-    LIB[]NAME=3D
-    LTLIB[]NAME=3D
-  fi
-  AC_SUBST([HAVE_LIB]NAME)
-  AC_SUBST([LIB]NAME)
-  AC_SUBST([LTLIB]NAME)
-  undefine([Name])
-  undefine([NAME])
-])
+cygwin_headers=3D$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    AC_MSG_ERROR([cannot find $winsup_srcdir/cygwin/include directory])
+fi
=20
-dnl Determine the platform dependent parameters needed to use rpath:
-dnl libext, shlibext, hardcode_libdir_flag_spec, hardcode_libdir_separator,
-dnl hardcode_direct, hardcode_minus_L.
-AC_DEFUN([AC_LIB_RPATH],
-[
-  dnl Tell automake >=3D 1.10 to complain if config.rpath is missing.
-  m4_ifdef([AC_REQUIRE_AUX_FILE], [AC_REQUIRE_AUX_FILE([config.rpath])])
-  AC_REQUIRE([AC_PROG_CC])                dnl we use $CC, $GCC, $LDFLAGS
-  AC_REQUIRE([AC_LIB_PROG_LD])            dnl we use $LD, $with_gnu_ld
-  AC_REQUIRE([AC_CANONICAL_HOST])         dnl we use $host
-  AC_REQUIRE([AC_CONFIG_AUX_DIR_DEFAULT]) dnl we use $ac_aux_dir
-  AC_CACHE_CHECK([for shared library run path origin], acl_cv_rpath, [
-    CC=3D"$CC" GCC=3D"$GCC" LDFLAGS=3D"$LDFLAGS" LD=3D"$LD" with_gnu_ld=3D=
"$with_gnu_ld" \
-    ${CONFIG_SHELL-/bin/sh} "$ac_aux_dir/config.rpath" "$host" > conftest.=
sh
-    . ./conftest.sh
-    rm -f ./conftest.sh
-    acl_cv_rpath=3Ddone
-  ])
-  wl=3D"$acl_cv_wl"
-  libext=3D"$acl_cv_libext"
-  shlibext=3D"$acl_cv_shlibext"
-  hardcode_libdir_flag_spec=3D"$acl_cv_hardcode_libdir_flag_spec"
-  hardcode_libdir_separator=3D"$acl_cv_hardcode_libdir_separator"
-  hardcode_direct=3D"$acl_cv_hardcode_direct"
-  hardcode_minus_L=3D"$acl_cv_hardcode_minus_L"
-  dnl Determine whether the user wants rpath handling at all.
-  AC_ARG_ENABLE(rpath,
-    [  --disable-rpath         do not hardcode runtime library paths],
-    :, enable_rpath=3Dyes)
-])
+newlib_headers=3D$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null &&=
 pwd)
+if test -z "$newlib_headers"; then
+    AC_MSG_ERROR([cannot find newlib source directory: $winsup_srcdir/../n=
ewlib/libc/include])
+fi
+newlib_headers=3D"$target_builddir/newlib/targ-include $newlib_headers"
=20
-dnl AC_LIB_LINKFLAGS_BODY(name [, dependencies]) searches for libname and
-dnl the libraries corresponding to explicit and implicit dependencies.
-dnl Sets the LIB${NAME}, LTLIB${NAME} and INC${NAME} variables.
-AC_DEFUN([AC_LIB_LINKFLAGS_BODY],
-[
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-  dnl By default, look in $includedir and $libdir.
-  use_additional=3Dyes
-  AC_LIB_WITH_FINAL_PREFIX([
-    eval additional_includedir=3D\"$includedir\"
-    eval additional_libdir=3D\"$libdir\"
-  ])
-  AC_LIB_ARG_WITH([lib$1-prefix],
-[  --with-lib$1-prefix[=3DDIR]  search for lib$1 in DIR/include and DIR/lib
-  --without-lib$1-prefix     don't search for lib$1 in includedir and libd=
ir],
-[
-    if test "X$withval" =3D "Xno"; then
-      use_additional=3Dno
-    else
-      if test "X$withval" =3D "X"; then
-        AC_LIB_WITH_FINAL_PREFIX([
-          eval additional_includedir=3D\"$includedir\"
-          eval additional_libdir=3D\"$libdir\"
-        ])
-      else
-        additional_includedir=3D"$withval/include"
-        additional_libdir=3D"$withval/lib"
-      fi
-    fi
-])
-  dnl Search the library and its dependencies in $additional_libdir and
-  dnl $LDFLAGS. Using breadth-first-seach.
-  LIB[]NAME=3D
-  LTLIB[]NAME=3D
-  INC[]NAME=3D
-  rpathdirs=3D
-  ltrpathdirs=3D
-  names_already_handled=3D
-  names_next_round=3D'$1 $2'
-  while test -n "$names_next_round"; do
-    names_this_round=3D"$names_next_round"
-    names_next_round=3D
-    for name in $names_this_round; do
-      already_handled=3D
-      for n in $names_already_handled; do
-        if test "$n" =3D "$name"; then
-          already_handled=3Dyes
-          break
-        fi
-      done
-      if test -z "$already_handled"; then
-        names_already_handled=3D"$names_already_handled $name"
-        dnl See if it was already located by an earlier AC_LIB_LINKFLAGS
-        dnl or AC_LIB_HAVE_LINKFLAGS call.
-        uppername=3D`echo "$name" | sed -e 'y|abcdefghijklmnopqrstuvwxyz./=
-|ABCDEFGHIJKLMNOPQRSTUVWXYZ___|'`
-        eval value=3D\"\$HAVE_LIB$uppername\"
-        if test -n "$value"; then
-          if test "$value" =3D yes; then
-            eval value=3D\"\$LIB$uppername\"
-            test -z "$value" || LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$v=
alue"
-            eval value=3D\"\$LTLIB$uppername\"
-            test -z "$value" || LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME=
:+ }$value"
-          else
-            dnl An earlier call to AC_LIB_HAVE_LINKFLAGS has determined
-            dnl that this library doesn't exist. So just drop it.
-            :
-          fi
-        else
-          dnl Search the library lib$name in $additional_libdir and $LDFLA=
GS
-          dnl and the already constructed $LIBNAME/$LTLIBNAME.
-          found_dir=3D
-          found_la=3D
-          found_so=3D
-          found_a=3D
-          if test $use_additional =3D yes; then
-            if test -n "$shlibext" && test -f "$additional_libdir/lib$name=
.$shlibext"; then
-              found_dir=3D"$additional_libdir"
-              found_so=3D"$additional_libdir/lib$name.$shlibext"
-              if test -f "$additional_libdir/lib$name.la"; then
-                found_la=3D"$additional_libdir/lib$name.la"
-              fi
-            else
-              if test -f "$additional_libdir/lib$name.$libext"; then
-                found_dir=3D"$additional_libdir"
-                found_a=3D"$additional_libdir/lib$name.$libext"
-                if test -f "$additional_libdir/lib$name.la"; then
-                  found_la=3D"$additional_libdir/lib$name.la"
-                fi
-              fi
-            fi
-          fi
-          if test "X$found_dir" =3D "X"; then
-            for x in $LDFLAGS $LTLIB[]NAME; do
-              AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-              case "$x" in
-                -L*)
-                  dir=3D`echo "X$x" | sed -e 's/^X-L//'`
-                  if test -n "$shlibext" && test -f "$dir/lib$name.$shlibe=
xt"; then
-                    found_dir=3D"$dir"
-                    found_so=3D"$dir/lib$name.$shlibext"
-                    if test -f "$dir/lib$name.la"; then
-                      found_la=3D"$dir/lib$name.la"
-                    fi
-                  else
-                    if test -f "$dir/lib$name.$libext"; then
-                      found_dir=3D"$dir"
-                      found_a=3D"$dir/lib$name.$libext"
-                      if test -f "$dir/lib$name.la"; then
-                        found_la=3D"$dir/lib$name.la"
-                      fi
-                    fi
-                  fi
-                  ;;
-              esac
-              if test "X$found_dir" !=3D "X"; then
-                break
-              fi
-            done
-          fi
-          if test "X$found_dir" !=3D "X"; then
-            dnl Found the library.
-            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-L$found_dir -l$=
name"
-            if test "X$found_so" !=3D "X"; then
-              dnl Linking with a shared library. We attempt to hardcode its
-              dnl directory into the executable's runpath, unless it's the
-              dnl standard /usr/lib.
-              if test "$enable_rpath" =3D no || test "X$found_dir" =3D "X/=
usr/lib"; then
-                dnl No hardcoding is needed.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-              else
-                dnl Use an explicit option to hardcode DIR into the result=
ing
-                dnl binary.
-                dnl Potentially add DIR to ltrpathdirs.
-                dnl The ltrpathdirs will be appended to $LTLIBNAME at the =
end.
-                haveit=3D
-                for x in $ltrpathdirs; do
-                  if test "X$x" =3D "X$found_dir"; then
-                    haveit=3Dyes
-                    break
-                  fi
-                done
-                if test -z "$haveit"; then
-                  ltrpathdirs=3D"$ltrpathdirs $found_dir"
-                fi
-                dnl The hardcoding into $LIBNAME is system dependent.
-                if test "$hardcode_direct" =3D yes; then
-                  dnl Using DIR/libNAME.so during linking hardcodes DIR in=
to the
-                  dnl resulting binary.
-                  LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                else
-                  if test -n "$hardcode_libdir_flag_spec" && test "$hardco=
de_minus_L" =3D no; then
-                    dnl Use an explicit option to hardcode DIR into the re=
sulting
-                    dnl binary.
-                    LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                    dnl Potentially add DIR to rpathdirs.
-                    dnl The rpathdirs will be appended to $LIBNAME at the =
end.
-                    haveit=3D
-                    for x in $rpathdirs; do
-                      if test "X$x" =3D "X$found_dir"; then
-                        haveit=3Dyes
-                        break
-                      fi
-                    done
-                    if test -z "$haveit"; then
-                      rpathdirs=3D"$rpathdirs $found_dir"
-                    fi
-                  else
-                    dnl Rely on "-L$found_dir".
-                    dnl But don't add it if it's already contained in the =
LDFLAGS
-                    dnl or the already constructed $LIBNAME
-                    haveit=3D
-                    for x in $LDFLAGS $LIB[]NAME; do
-                      AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                      if test "X$x" =3D "X-L$found_dir"; then
-                        haveit=3Dyes
-                        break
-                      fi
-                    done
-                    if test -z "$haveit"; then
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$found_dir"
-                    fi
-                    if test "$hardcode_minus_L" !=3D no; then
-                      dnl FIXME: Not sure whether we should use
-                      dnl "-L$found_dir -l$name" or "-L$found_dir $found_s=
o"
-                      dnl here.
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                    else
-                      dnl We cannot use $hardcode_runpath_var and LD_RUN_P=
ATH
-                      dnl here, because this doesn't fit in flags passed t=
o the
-                      dnl compiler. So give up. No hardcoding. This affect=
s only
-                      dnl very old systems.
-                      dnl FIXME: Not sure whether we should use
-                      dnl "-L$found_dir -l$name" or "-L$found_dir $found_s=
o"
-                      dnl here.
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-l$name"
-                    fi
-                  fi
-                fi
-              fi
-            else
-              if test "X$found_a" !=3D "X"; then
-                dnl Linking with a static library.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_a"
-              else
-                dnl We shouldn't come here, but anyway it's good to have a
-                dnl fallback.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$found_dir -l$na=
me"
-              fi
-            fi
-            dnl Assume the include files are nearby.
-            additional_includedir=3D
-            case "$found_dir" in
-              */lib | */lib/)
-                basedir=3D`echo "X$found_dir" | sed -e 's,^X,,' -e 's,/lib=
/*$,,'`
-                additional_includedir=3D"$basedir/include"
-                ;;
-            esac
-            if test "X$additional_includedir" !=3D "X"; then
-              dnl Potentially add $additional_includedir to $INCNAME.
-              dnl But don't add it
-              dnl   1. if it's the standard /usr/include,
-              dnl   2. if it's /usr/local/include and we are using GCC on =
Linux,
-              dnl   3. if it's already present in $CPPFLAGS or the already
-              dnl      constructed $INCNAME,
-              dnl   4. if it doesn't exist as a directory.
-              if test "X$additional_includedir" !=3D "X/usr/include"; then
-                haveit=3D
-                if test "X$additional_includedir" =3D "X/usr/local/include=
"; then
-                  if test -n "$GCC"; then
-                    case $host_os in
-                      linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-                    esac
-                  fi
-                fi
-                if test -z "$haveit"; then
-                  for x in $CPPFLAGS $INC[]NAME; do
-                    AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                    if test "X$x" =3D "X-I$additional_includedir"; then
-                      haveit=3Dyes
-                      break
-                    fi
-                  done
-                  if test -z "$haveit"; then
-                    if test -d "$additional_includedir"; then
-                      dnl Really add $additional_includedir to $INCNAME.
-                      INC[]NAME=3D"${INC[]NAME}${INC[]NAME:+ }-I$additiona=
l_includedir"
-                    fi
-                  fi
-                fi
-              fi
-            fi
-            dnl Look for dependencies.
-            if test -n "$found_la"; then
-              dnl Read the .la file. It defines the variables
-              dnl dlname, library_names, old_library, dependency_libs, cur=
rent,
-              dnl age, revision, installed, dlopen, dlpreopen, libdir.
-              save_libdir=3D"$libdir"
-              case "$found_la" in
-                */* | *\\*) . "$found_la" ;;
-                *) . "./$found_la" ;;
-              esac
-              libdir=3D"$save_libdir"
-              dnl We use only dependency_libs.
-              for dep in $dependency_libs; do
-                case "$dep" in
-                  -L*)
-                    additional_libdir=3D`echo "X$dep" | sed -e 's/^X-L//'`
-                    dnl Potentially add $additional_libdir to $LIBNAME and=
 $LTLIBNAME.
-                    dnl But don't add it
-                    dnl   1. if it's the standard /usr/lib,
-                    dnl   2. if it's /usr/local/lib and we are using GCC o=
n Linux,
-                    dnl   3. if it's already present in $LDFLAGS or the al=
ready
-                    dnl      constructed $LIBNAME,
-                    dnl   4. if it doesn't exist as a directory.
-                    if test "X$additional_libdir" !=3D "X/usr/lib"; then
-                      haveit=3D
-                      if test "X$additional_libdir" =3D "X/usr/local/lib";=
 then
-                        if test -n "$GCC"; then
-                          case $host_os in
-                            linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-                          esac
-                        fi
-                      fi
-                      if test -z "$haveit"; then
-                        haveit=3D
-                        for x in $LDFLAGS $LIB[]NAME; do
-                          AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                          if test "X$x" =3D "X-L$additional_libdir"; then
-                            haveit=3Dyes
-                            break
-                          fi
-                        done
-                        if test -z "$haveit"; then
-                          if test -d "$additional_libdir"; then
-                            dnl Really add $additional_libdir to $LIBNAME.
-                            LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$add=
itional_libdir"
-                          fi
-                        fi
-                        haveit=3D
-                        for x in $LDFLAGS $LTLIB[]NAME; do
-                          AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                          if test "X$x" =3D "X-L$additional_libdir"; then
-                            haveit=3Dyes
-                            break
-                          fi
-                        done
-                        if test -z "$haveit"; then
-                          if test -d "$additional_libdir"; then
-                            dnl Really add $additional_libdir to $LTLIBNAM=
E.
-                            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }=
-L$additional_libdir"
-                          fi
-                        fi
-                      fi
-                    fi
-                    ;;
-                  -R*)
-                    dir=3D`echo "X$dep" | sed -e 's/^X-R//'`
-                    if test "$enable_rpath" !=3D no; then
-                      dnl Potentially add DIR to rpathdirs.
-                      dnl The rpathdirs will be appended to $LIBNAME at th=
e end.
-                      haveit=3D
-                      for x in $rpathdirs; do
-                        if test "X$x" =3D "X$dir"; then
-                          haveit=3Dyes
-                          break
-                        fi
-                      done
-                      if test -z "$haveit"; then
-                        rpathdirs=3D"$rpathdirs $dir"
-                      fi
-                      dnl Potentially add DIR to ltrpathdirs.
-                      dnl The ltrpathdirs will be appended to $LTLIBNAME a=
t the end.
-                      haveit=3D
-                      for x in $ltrpathdirs; do
-                        if test "X$x" =3D "X$dir"; then
-                          haveit=3Dyes
-                          break
-                        fi
-                      done
-                      if test -z "$haveit"; then
-                        ltrpathdirs=3D"$ltrpathdirs $dir"
-                      fi
-                    fi
-                    ;;
-                  -l*)
-                    dnl Handle this in the next round.
-                    names_next_round=3D"$names_next_round "`echo "X$dep" |=
 sed -e 's/^X-l//'`
-                    ;;
-                  *.la)
-                    dnl Handle this in the next round. Throw away the .la's
-                    dnl directory; it is already contained in a preceding =
-L
-                    dnl option.
-                    names_next_round=3D"$names_next_round "`echo "X$dep" |=
 sed -e 's,^X.*/,,' -e 's,^lib,,' -e 's,\.la$,,'`
-                    ;;
-                  *)
-                    dnl Most likely an immediate library name.
-                    LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$dep"
-                    LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }$dep"
-                    ;;
-                esac
-              done
-            fi
-          else
-            dnl Didn't find the library; assume it is in the system direct=
ories
-            dnl known to the linker and runtime loader. (All the system
-            dnl directories known to the linker should also be known to the
-            dnl runtime loader, otherwise the system is severely misconfig=
ured.)
-            LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-l$name"
-            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-l$name"
-          fi
-        fi
-      fi
-    done
-  done
-  if test "X$rpathdirs" !=3D "X"; then
-    if test -n "$hardcode_libdir_separator"; then
-      dnl Weird platform: only the last -rpath option counts, the user must
-      dnl pass all path elements in one option. We can arrange that for a
-      dnl single library, but not when more than one $LIBNAMEs are used.
-      alldirs=3D
-      for found_dir in $rpathdirs; do
-        alldirs=3D"${alldirs}${alldirs:+$hardcode_libdir_separator}$found_=
dir"
-      done
-      dnl Note: hardcode_libdir_flag_spec uses $libdir and $wl.
-      acl_save_libdir=3D"$libdir"
-      libdir=3D"$alldirs"
-      eval flag=3D\"$hardcode_libdir_flag_spec\"
-      libdir=3D"$acl_save_libdir"
-      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$flag"
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers=3D"$with_windows_headers"
     else
-      dnl The -rpath options are cumulative.
-      for found_dir in $rpathdirs; do
-        acl_save_libdir=3D"$libdir"
-        libdir=3D"$found_dir"
-        eval flag=3D\"$hardcode_libdir_flag_spec\"
-        libdir=3D"$acl_save_libdir"
-        LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$flag"
-      done
-    fi
-  fi
-  if test "X$ltrpathdirs" !=3D "X"; then
-    dnl When using libtool, the option that works for both libraries and
-    dnl executables is -R. The -R options are cumulative.
-    for found_dir in $ltrpathdirs; do
-      LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-R$found_dir"
-    done
-  fi
-])
-
-dnl AC_LIB_APPENDTOVAR(VAR, CONTENTS) appends the elements of CONTENTS to =
VAR,
-dnl unless already present in VAR.
-dnl Works only for CPPFLAGS, not for LIB* variables because that sometimes
-dnl contains two or three consecutive elements that belong together.
-AC_DEFUN([AC_LIB_APPENDTOVAR],
-[
-  for element in [$2]; do
-    haveit=3D
-    for x in $[$1]; do
-      AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-      if test "X$x" =3D "X$element"; then
-        haveit=3Dyes
-        break
-      fi
-    done
-    if test -z "$haveit"; then
-      [$1]=3D"${[$1]}${[$1]:+ }$element"
+	AC_MSG_ERROR([cannot find windef.h in specified --with-windows-headers pa=
th: $saw_windows_headers]);
     fi
-  done
-])
-
-# lib-ld.m4 serial 3 (gettext-0.13)
-dnl Copyright (C) 1996-2003 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl Subroutines of libtool.m4,
-dnl with replacements s/AC_/AC_LIB/ and s/lt_cv/acl_cv/ to avoid collision
-dnl with libtool.m4.
-
-dnl From libtool-1.4. Sets the variable with_gnu_ld to yes or no.
-AC_DEFUN([AC_LIB_PROG_LD_GNU],
-[AC_CACHE_CHECK([if the linker ($LD) is GNU ld], acl_cv_prog_gnu_ld,
-[# I'd rather use --version here, but apparently some GNU ld's only accept=
 -v.
-case `$LD -v 2>&1 </dev/null` in
-*GNU* | *'with BFD'*)
-  acl_cv_prog_gnu_ld=3Dyes ;;
-*)
-  acl_cv_prog_gnu_ld=3Dno ;;
-esac])
-with_gnu_ld=3D$acl_cv_prog_gnu_ld
-])
-
-dnl From libtool-1.4. Sets the variable LD.
-AC_DEFUN([AC_LIB_PROG_LD],
-[AC_ARG_WITH(gnu-ld,
-[  --with-gnu-ld           assume the C compiler uses GNU ld [default=3Dno=
]],
-test "$withval" =3D no || with_gnu_ld=3Dyes, with_gnu_ld=3Dno)
-AC_REQUIRE([AC_PROG_CC])dnl
-AC_REQUIRE([AC_CANONICAL_HOST])dnl
-# Prepare PATH_SEPARATOR.
-# The user is always right.
-if test "${PATH_SEPARATOR+set}" !=3D set; then
-  echo "#! /bin/sh" >conf$$.sh
-  echo  "exit 0"   >>conf$$.sh
-  chmod +x conf$$.sh
-  if (PATH=3D"/nonexistent;."; conf$$.sh) >/dev/null 2>&1; then
-    PATH_SEPARATOR=3D';'
-  else
-    PATH_SEPARATOR=3D:
-  fi
-  rm -f conf$$.sh
-fi
-ac_prog=3Dld
-if test "$GCC" =3D yes; then
-  # Check if gcc -print-prog-name=3Dld gives a path.
-  AC_MSG_CHECKING([for ld used by GCC])
-  case $host in
-  *-*-mingw*)
-    # gcc leaves a trailing carriage return which upsets mingw
-    ac_prog=3D`($CC -print-prog-name=3Dld) 2>&5 | tr -d '\015'` ;;
-  *)
-    ac_prog=3D`($CC -print-prog-name=3Dld) 2>&5` ;;
-  esac
-  case $ac_prog in
-    # Accept absolute paths.
-    [[\\/]* | [A-Za-z]:[\\/]*)]
-      [re_direlt=3D'/[^/][^/]*/\.\./']
-      # Canonicalize the path of ld
-      ac_prog=3D`echo $ac_prog| sed 's%\\\\%/%g'`
-      while echo $ac_prog | grep "$re_direlt" > /dev/null 2>&1; do
-	ac_prog=3D`echo $ac_prog| sed "s%$re_direlt%/%"`
-      done
-      test -z "$LD" && LD=3D"$ac_prog"
-      ;;
-  "")
-    # If it fails, then pretend we aren't using GCC.
-    ac_prog=3Dld
-    ;;
-  *)
-    # If it is relative, then search for the first ld in PATH.
-    with_gnu_ld=3Dunknown
-    ;;
-  esac
-elif test "$with_gnu_ld" =3D yes; then
-  AC_MSG_CHECKING([for GNU ld])
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers=3D"$winsup_srcdir/w32api/include"
 else
-  AC_MSG_CHECKING([for non-GNU ld])
-fi
-AC_CACHE_VAL(acl_cv_path_LD,
-[if test -z "$LD"; then
-  IFS=3D"${IFS=3D 	}"; ac_save_ifs=3D"$IFS"; IFS=3D"${IFS}${PATH_SEPARATOR=
-:}"
-  for ac_dir in $PATH; do
-    test -z "$ac_dir" && ac_dir=3D.
-    if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext";=
 then
-      acl_cv_path_LD=3D"$ac_dir/$ac_prog"
-      # Check to see if the program is GNU ld.  I'd rather use --version,
-      # but apparently some GNU ld's only accept -v.
-      # Break only if it was the GNU/non-GNU ld that we prefer.
-      case `"$acl_cv_path_LD" -v 2>&1 < /dev/null` in
-      *GNU* | *'with BFD'*)
-	test "$with_gnu_ld" !=3D no && break ;;
-      *)
-	test "$with_gnu_ld" !=3D yes && break ;;
-      esac
+    windows_headers=3D$(cd $($ac_cv_prog_CC -xc /dev/null -E -include wind=
ef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1=
) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	AC_MSG_ERROR([cannot find windows header files])
     fi
-  done
-  IFS=3D"$ac_save_ifs"
-else
-  acl_cv_path_LD=3D"$LD" # Let the user override the test with a path.
-fi])
-LD=3D"$acl_cv_path_LD"
-if test -n "$LD"; then
-  AC_MSG_RESULT($LD)
-else
-  AC_MSG_RESULT(no)
 fi
-test -z "$LD" && AC_MSG_ERROR([no acceptable ld found in \$PATH])
-AC_LIB_PROG_LD_GNU
+CC=3D$ac_cv_prog_CC
+CXX=3D$ac_cv_prog_CXX
+export CC
+export CXX
+AC_SUBST(windows_headers)
+AC_SUBST(newlib_headers)
+AC_SUBST(cygwin_headers)
 ])
=20
-dnl This provides configure definitions used by all the winsup
-dnl configure.in files.
-
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
-  ac_cv_prog_gcc=3Dyes
-else
-  ac_cv_prog_gcc=3Dno
-fi])])
-
-AC_DEFUN([LIB_AC_PROG_CC],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CC, gcc, gcc)
-: ${CC:=3Dgcc}
-AC_PROG_CC
-test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
+AC_DEFUN([AC_CONFIGURE_ARGS], [
+configure_args=3DX
+for f in $ac_configure_args; do
+    case "$f" in
+	*--srcdir*) ;;
+	*) configure_args=3D"$configure_args $f" ;;
+    esac
+done
+configure_args=3D$(/usr/bin/expr "$configure_args" : 'X \(.*\)')
+AC_SUBST(configure_args)
 ])
=20
-AC_DEFUN([LIB_AC_PROG_CXX],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CXX, g++, g++)
-if test -z "$CXX"; then
-  AC_CHECK_TOOL(CXX, g++, c++, , , )
-  : ${CXX:=3Dg++}
-  AC_PROG_CXX
-  test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
-fi
-
-CXXFLAGS=3D'$(CFLAGS)'
-])
+AC_SUBST(target_builddir)
+AC_SUBST(winsup_srcdir)
=20
Index: cygwin/autogen.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: cygwin/autogen.sh
diff -N cygwin/autogen.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ cygwin/autogen.sh	13 Nov 2012 18:15:21 -0000
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+/usr/bin/aclocal --acdir=3D..
+/usr/bin/autoconf -f
+exec /bin/rm -rf autom4te.cache
Index: cygwin/configure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygwin/configure,v
retrieving revision 1.35
diff -d -u -p -r1.35 configure
--- cygwin/configure	15 Feb 2011 15:56:23 -0000	1.35
+++ cygwin/configure	13 Nov 2012 18:15:21 -0000
@@ -1,11 +1,9 @@
 #! /bin/sh
 # Guess values for system-dependent variables and create Makefiles.
-# Generated by GNU Autoconf 2.66.
+# Generated by GNU Autoconf 2.69.
 #
 #
-# Copyright (C) 1992, 1993, 1994, 1995, 1996, 1998, 1999, 2000, 2001,
-# 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010 Free Software
-# Foundation, Inc.
+# Copyright (C) 1992-1996, 1998-2012 Free Software Foundation, Inc.
 #
 #
 # This configure script is free software; the Free Software Foundation
@@ -89,6 +87,7 @@ fi
 IFS=3D" ""	$as_nl"
=20
 # Find who we are.  Look in the path if we contain no directory separator.
+as_myself=3D
 case $0 in #((
   *[\\/]* ) as_myself=3D$0 ;;
   *) as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
@@ -133,6 +132,31 @@ export LANGUAGE
 # CDPATH.
 (unset CDPATH) >/dev/null 2>&1 && unset CDPATH
=20
+# Use a proper internal environment variable to ensure we don't fall
+  # into an infinite loop, continuously re-executing ourselves.
+  if test x"${_as_can_reexec}" !=3D xno && test "x$CONFIG_SHELL" !=3D x; t=
hen
+    _as_can_reexec=3Dno; export _as_can_reexec;
+    # We cannot yet assume a decent shell, so we have to provide a
+# neutralization value for shells without unset; and this also
+# works around shells that cannot unset nonexistent variables.
+# Preserve -v and -x to the replacement shell.
+BASH_ENV=3D/dev/null
+ENV=3D/dev/null
+(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
+case $- in # ((((
+  *v*x* | *x*v* ) as_opts=3D-vx ;;
+  *v* ) as_opts=3D-v ;;
+  *x* ) as_opts=3D-x ;;
+  * ) as_opts=3D ;;
+esac
+exec $CONFIG_SHELL $as_opts "$as_myself" ${1+"$@"}
+# Admittedly, this is quite paranoid, since all the known shells bail
+# out after a failed `exec'.
+$as_echo "$0: could not re-execute with $CONFIG_SHELL" >&2
+as_fn_exit 255
+  fi
+  # We don't want this to propagate to other subprocesses.
+          { _as_can_reexec=3D; unset _as_can_reexec;}
 if test "x$CONFIG_SHELL" =3D x; then
   as_bourne_compatible=3D"if test -n \"\${ZSH_VERSION+set}\" && (emulate s=
h) >/dev/null 2>&1; then :
   emulate sh
@@ -166,7 +190,8 @@ if ( set x; as_fn_ret_success y && test=20
 else
   exitcode=3D1; echo positional parameters were not saved.
 fi
-test x\$exitcode =3D x0 || exit 1"
+test x\$exitcode =3D x0 || exit 1
+test -x / || exit 1"
   as_suggested=3D"  as_lineno_1=3D";as_suggested=3D$as_suggested$LINENO;as=
_suggested=3D$as_suggested" as_lineno_1a=3D\$LINENO
   as_lineno_2=3D";as_suggested=3D$as_suggested$LINENO;as_suggested=3D$as_s=
uggested" as_lineno_2a=3D\$LINENO
   eval 'test \"x\$as_lineno_1'\$as_run'\" !=3D \"x\$as_lineno_2'\$as_run'\=
" &&
@@ -210,14 +235,25 @@ IFS=3D$as_save_IFS
=20
=20
       if test "x$CONFIG_SHELL" !=3D x; then :
-  # We cannot yet assume a decent shell, so we have to provide a
-	# neutralization value for shells without unset; and this also
-	# works around shells that cannot unset nonexistent variables.
-	BASH_ENV=3D/dev/null
-	ENV=3D/dev/null
-	(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
-	export CONFIG_SHELL
-	exec "$CONFIG_SHELL" "$as_myself" ${1+"$@"}
+  export CONFIG_SHELL
+             # We cannot yet assume a decent shell, so we have to provide a
+# neutralization value for shells without unset; and this also
+# works around shells that cannot unset nonexistent variables.
+# Preserve -v and -x to the replacement shell.
+BASH_ENV=3D/dev/null
+ENV=3D/dev/null
+(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
+case $- in # ((((
+  *v*x* | *x*v* ) as_opts=3D-vx ;;
+  *v* ) as_opts=3D-v ;;
+  *x* ) as_opts=3D-x ;;
+  * ) as_opts=3D ;;
+esac
+exec $CONFIG_SHELL $as_opts "$as_myself" ${1+"$@"}
+# Admittedly, this is quite paranoid, since all the known shells bail
+# out after a failed `exec'.
+$as_echo "$0: could not re-execute with $CONFIG_SHELL" >&2
+exit 255
 fi
=20
     if test x$as_have_required =3D xno; then :
@@ -319,6 +355,14 @@ $as_echo X"$as_dir" |
=20
=20
 } # as_fn_mkdir_p
+
+# as_fn_executable_p FILE
+# -----------------------
+# Test if FILE is an executable regular file.
+as_fn_executable_p ()
+{
+  test -f "$1" && test -x "$1"
+} # as_fn_executable_p
 # as_fn_append VAR VALUE
 # ----------------------
 # Append the text in VALUE to the end of the definition contained in VAR. =
Take
@@ -440,6 +484,10 @@ as_cr_alnum=3D$as_cr_Letters$as_cr_digits
   chmod +x "$as_me.lineno" ||
     { $as_echo "$as_me: error: cannot create $as_me.lineno; rerun with a P=
OSIX shell" >&2; as_fn_exit 1; }
=20
+  # If we had to re-execute with $CONFIG_SHELL, we're ensured to have
+  # already done that, so ensure we don't try to do so again and fall
+  # in an infinite loop.  This has already happened in practice.
+  _as_can_reexec=3Dno; export _as_can_reexec
   # Don't try to exec as it changes $[0], causing all sort of problems
   # (the dirname of $[0] is not the place where we might find the
   # original and so on.  Autoconf is especially sensitive to this).
@@ -474,16 +522,16 @@ if (echo >conf$$.file) 2>/dev/null; then
     # ... but there are two gotchas:
     # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
     # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executabl=
e.
-    # In both cases, we have to default to `cp -p'.
+    # In both cases, we have to default to `cp -pR'.
     ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
-      as_ln_s=3D'cp -p'
+      as_ln_s=3D'cp -pR'
   elif ln conf$$.file conf$$ 2>/dev/null; then
     as_ln_s=3Dln
   else
-    as_ln_s=3D'cp -p'
+    as_ln_s=3D'cp -pR'
   fi
 else
-  as_ln_s=3D'cp -p'
+  as_ln_s=3D'cp -pR'
 fi
 rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
 rmdir conf$$.dir 2>/dev/null
@@ -495,28 +543,8 @@ else
   as_mkdir_p=3Dfalse
 fi
=20
-if test -x / >/dev/null 2>&1; then
-  as_test_x=3D'test -x'
-else
-  if ls -dL / >/dev/null 2>&1; then
-    as_ls_L_option=3DL
-  else
-    as_ls_L_option=3D
-  fi
-  as_test_x=3D'
-    eval sh -c '\''
-      if test -d "$1"; then
-	test -d "$1/.";
-      else
-	case $1 in #(
-	-*)set "./$1";;
-	esac;
-	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
-	???[sx]*):;;*)false;;esac;fi
-    '\'' sh
-  '
-fi
-as_executable_p=3D$as_test_x
+as_test_x=3D'test -x'
+as_executable_p=3Das_fn_executable_p
=20
 # Sed expression to map a string onto a valid CPP name.
 as_tr_cpp=3D"eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnu=
m]%_%g'"
@@ -553,7 +581,7 @@ PACKAGE_STRING=3D
 PACKAGE_BUGREPORT=3D
 PACKAGE_URL=3D
=20
-ac_unique_file=3D"init.cc"
+ac_unique_file=3D"Makefile.in"
 ac_subst_vars=3D'LTLIBOBJS
 LIBOBJS
 CONFIG_DIR
@@ -562,6 +590,7 @@ DEF_DLL_ENTRY
 DLL_ENTRY
 LIBSERVER
 MALLOC_OFILES
+configure_args
 SET_MAKE
 WINDRES
 STRIP
@@ -575,6 +604,10 @@ AS
 AR
 install_host
 all_host
+cygwin_headers
+newlib_headers
+windows_headers
+CPP
 ac_ct_CXX
 CXXFLAGS
 CXX
@@ -600,6 +633,7 @@ build
 INSTALL_DATA
 INSTALL_SCRIPT
 INSTALL_PROGRAM
+windows_libdir
 target_alias
 host_alias
 build_alias
@@ -637,10 +671,14 @@ PACKAGE_VERSION
 PACKAGE_TARNAME
 PACKAGE_NAME
 PATH_SEPARATOR
-SHELL'
+SHELL
+winsup_srcdir
+target_builddir'
 ac_subst_files=3D''
 ac_user_opts=3D'
 enable_option_checking
+with_windows_headers
+with_windows_libs
 enable_debugging
 '
       ac_precious_vars=3D'build_alias
@@ -653,7 +691,8 @@ LIBS
 CPPFLAGS
 CXX
 CXXFLAGS
-CCC'
+CCC
+CPP'
=20
=20
 # Initialize some variables set by options.
@@ -716,8 +755,9 @@ do
   fi
=20
   case $ac_option in
-  *=3D*)	ac_optarg=3D`expr "X$ac_option" : '[^=3D]*=3D\(.*\)'` ;;
-  *)	ac_optarg=3Dyes ;;
+  *=3D?*) ac_optarg=3D`expr "X$ac_option" : '[^=3D]*=3D\(.*\)'` ;;
+  *=3D)   ac_optarg=3D ;;
+  *)    ac_optarg=3Dyes ;;
   esac
=20
   # Accept the important Cygnus configure options, so we can diagnose typo=
s.
@@ -1057,7 +1097,7 @@ Try \`$0 --help' for more information"
     $as_echo "$as_me: WARNING: you should use --build, --host, --target" >=
&2
     expr "x$ac_option" : ".*[^-._$as_cr_alnum]" >/dev/null &&
       $as_echo "$as_me: WARNING: invalid host type: $ac_option" >&2
-    : ${build_alias=3D$ac_option} ${host_alias=3D$ac_option} ${target_alia=
s=3D$ac_option}
+    : "${build_alias=3D$ac_option} ${host_alias=3D$ac_option} ${target_ali=
as=3D$ac_option}"
     ;;
=20
   esac
@@ -1108,8 +1148,6 @@ target=3D$target_alias
 if test "x$host_alias" !=3D x; then
   if test "x$build_alias" =3D x; then
     cross_compiling=3Dmaybe
-    $as_echo "$as_me: WARNING: if you wanted to set the --build type, don'=
t use --host.
-    If a cross compiler is detected then cross compile mode will be used" =
>&2
   elif test "x$build_alias" !=3D "x$host_alias"; then
     cross_compiling=3Dyes
   fi
@@ -1269,6 +1307,13 @@ Optional Features:
   --enable-FEATURE[=3DARG]  include FEATURE [ARG=3Dyes]
  --enable-debugging		Build a cygwin DLL which has more consistency checkin=
g for debugging
=20
+Optional Packages:
+  --with-PACKAGE[=3DARG]    use PACKAGE [ARG=3Dyes]
+  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=3Dno)
+  --with-windows-headers=3DDIR
+                          specify where the windows includes are located
+  --with-windows-libs=3DDIR specify where the windows libraries are located
+
 Some influential environment variables:
   CC          C compiler command
   CFLAGS      C compiler flags
@@ -1279,6 +1324,7 @@ Some influential environment variables:
               you have headers in a nonstandard directory <include dir>
   CXX         C++ compiler command
   CXXFLAGS    C++ compiler flags
+  CPP         C preprocessor
=20
 Use these variables to override the choices made by `configure' or to help
 it to find libraries and programs with nonstandard names/locations.
@@ -1347,9 +1393,9 @@ test -n "$ac_init_help" && exit $ac_stat
 if $ac_init_version; then
   cat <<\_ACEOF
 configure
-generated by GNU Autoconf 2.66
+generated by GNU Autoconf 2.69
=20
-Copyright (C) 2010 Free Software Foundation, Inc.
+Copyright (C) 2012 Free Software Foundation, Inc.
 This configure script is free software; the Free Software Foundation
 gives unlimited permission to copy, distribute and modify it.
 _ACEOF
@@ -1393,7 +1439,7 @@ sed 's/^/| /' conftest.$ac_ext >&5
=20
 	ac_retval=3D1
 fi
-  eval $as_lineno_stack; test "x$as_lineno_stack" =3D x && { as_lineno=3D;=
 unset as_lineno;}
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
   as_fn_set_status $ac_retval
=20
 } # ac_fn_c_try_compile
@@ -1431,16 +1477,53 @@ sed 's/^/| /' conftest.$ac_ext >&5
=20
 	ac_retval=3D1
 fi
-  eval $as_lineno_stack; test "x$as_lineno_stack" =3D x && { as_lineno=3D;=
 unset as_lineno;}
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
   as_fn_set_status $ac_retval
=20
 } # ac_fn_cxx_try_compile
+
+# ac_fn_c_try_cpp LINENO
+# ----------------------
+# Try to preprocess conftest.$ac_ext, and return whether this succeeded.
+ac_fn_c_try_cpp ()
+{
+  as_lineno=3D${as_lineno-"$1"} as_lineno_stack=3Das_lineno_stack=3D$as_li=
neno_stack
+  if { { ac_try=3D"$ac_cpp conftest.$ac_ext"
+case "(($ac_try" in
+  *\"* | *\`* | *\\*) ac_try_echo=3D\$ac_try;;
+  *) ac_try_echo=3D$ac_try;;
+esac
+eval ac_try_echo=3D"\"\$as_me:${as_lineno-$LINENO}: $ac_try_echo\""
+$as_echo "$ac_try_echo"; } >&5
+  (eval "$ac_cpp conftest.$ac_ext") 2>conftest.err
+  ac_status=3D$?
+  if test -s conftest.err; then
+    grep -v '^ *+' conftest.err >conftest.er1
+    cat conftest.er1 >&5
+    mv -f conftest.er1 conftest.err
+  fi
+  $as_echo "$as_me:${as_lineno-$LINENO}: \$? =3D $ac_status" >&5
+  test $ac_status =3D 0; } > conftest.i && {
+	 test -z "$ac_c_preproc_warn_flag$ac_c_werror_flag" ||
+	 test ! -s conftest.err
+       }; then :
+  ac_retval=3D0
+else
+  $as_echo "$as_me: failed program was:" >&5
+sed 's/^/| /' conftest.$ac_ext >&5
+
+    ac_retval=3D1
+fi
+  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
+  as_fn_set_status $ac_retval
+
+} # ac_fn_c_try_cpp
 cat >config.log <<_ACEOF
 This file contains any messages produced by compilers while
 running configure, to aid debugging if configure makes a mistake.
=20
 It was created by $as_me, which was
-generated by GNU Autoconf 2.66.  Invocation command line was
+generated by GNU Autoconf 2.69.  Invocation command line was
=20
   $ $0 $@
=20
@@ -1790,7 +1873,7 @@ ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
 ac_config_headers=3D"$ac_config_headers config.h"
=20
 ac_aux_dir=3D
-for ac_dir in ../.. "$srcdir"/../..; do
+for ac_dir in .. "$srcdir"/..; do
   if test -f "$ac_dir/install-sh"; then
     ac_aux_dir=3D$ac_dir
     ac_install_sh=3D"$ac_aux_dir/install-sh -c"
@@ -1806,7 +1889,7 @@ for ac_dir in ../.. "$srcdir"/../..; do
   fi
 done
 if test -z "$ac_aux_dir"; then
-  as_fn_error $? "cannot find install-sh, install.sh, or shtool in ../.. \=
"$srcdir\"/../.." "$LINENO" 5
+  as_fn_error $? "cannot find install-sh, install.sh, or shtool in .. \"$s=
rcdir\"/.." "$LINENO" 5
 fi
=20
 # These three variables are undocumented and unsupported,
@@ -1819,6 +1902,36 @@ ac_configure=3D"$SHELL $ac_aux_dir/configu
=20
=20
=20
+. ${srcdir}/../configure.cygwin
+
+
+
+# Check whether --with-windows-headers was given.
+if test "${with_windows_headers+set}" =3D set; then :
+  withval=3D$with_windows_headers; test -z "$withval" && as_fn_error $? "m=
ust specify value for --with-windows-headers" "$LINENO" 5
+
+fi
+
+
+
+
+# Check whether --with-windows-libs was given.
+if test "${with_windows_libs+set}" =3D set; then :
+  withval=3D$with_windows_libs; test -z "$withval" && as_fn_error $? "must=
 specify value for --with-windows-libs" "$LINENO" 5
+
+fi
+
+windows_libdir=3D$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=3D$(cd $(dirname $($ac_cv_prog_CC -print-file-name=3Dli=
bcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	as_fn_error $? "cannot find windows library files" "$LINENO" 5
+    fi
+fi
+
+
+
+
 # Find a good install program.  We prefer a C program (faster),
 # so one script is as good as another.  But avoid the broken or
 # incompatible versions:
@@ -1836,7 +1949,7 @@ ac_configure=3D"$SHELL $ac_aux_dir/configu
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for a BSD-compatible ins=
tall" >&5
 $as_echo_n "checking for a BSD-compatible install... " >&6; }
 if test -z "$INSTALL"; then
-if test "${ac_cv_path_install+set}" =3D set; then :
+if ${ac_cv_path_install+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
@@ -1856,7 +1969,7 @@ case $as_dir/ in #((
     # by default.
     for ac_prog in ginstall scoinst install; do
       for ac_exec_ext in '' $ac_executable_extensions; do
-	if { test -f "$as_dir/$ac_prog$ac_exec_ext" && $as_test_x "$as_dir/$ac_pr=
og$ac_exec_ext"; }; then
+	if as_fn_executable_p "$as_dir/$ac_prog$ac_exec_ext"; then
 	  if test $ac_prog =3D install &&
 	    grep dspmsg "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
 	    # AIX install.  It has an incompatible calling convention.
@@ -1918,7 +2031,7 @@ $SHELL "$ac_aux_dir/config.sub" sun4 >/d
=20
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking build system type" >&5
 $as_echo_n "checking build system type... " >&6; }
-if test "${ac_cv_build+set}" =3D set; then :
+if ${ac_cv_build+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   ac_build_alias=3D$build_alias
@@ -1952,7 +2065,7 @@ case $build_os in *\ *) build_os=3D`echo "
=20
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking host system type" >&5
 $as_echo_n "checking host system type... " >&6; }
-if test "${ac_cv_host+set}" =3D set; then :
+if ${ac_cv_host+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test "x$host_alias" =3D x; then
@@ -1985,7 +2098,7 @@ case $host_os in *\ *) host_os=3D`echo "$h
=20
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking target system type" >&5
 $as_echo_n "checking target system type... " >&6; }
-if test "${ac_cv_target+set}" =3D set; then :
+if ${ac_cv_target+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test "x$target_alias" =3D x; then
@@ -2024,99 +2137,6 @@ test -n "$target_alias" &&
   program_prefix=3D${target_alias}-
=20
=20
-if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}gcc", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}gcc; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CC"; then
-  ac_cv_prog_CC=3D"$CC" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CC=3D"${ac_tool_prefix}gcc"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CC=3D$ac_cv_prog_CC
-if test -n "$CC"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CC" >&5
-$as_echo "$CC" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CC"; then
-  ac_ct_CC=3D$CC
-  # Extract the first word of "gcc", so it can be a program name with args.
-set dummy gcc; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CC+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CC"; then
-  ac_cv_prog_ac_ct_CC=3D"$ac_ct_CC" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CC=3D"gcc"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CC=3D$ac_cv_prog_ac_ct_CC
-if test -n "$ac_ct_CC"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CC" >&5
-$as_echo "$ac_ct_CC" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CC" =3D x; then
-    CC=3D"gcc"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CC=3D$ac_ct_CC
-  fi
-else
-  CC=3D"$ac_cv_prog_CC"
-fi
-
-: ${CC:=3Dgcc}
 ac_ext=3Dc
 ac_cpp=3D'$CPP $CPPFLAGS'
 ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -2127,7 +2147,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}gcc; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
+if ${ac_cv_prog_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CC"; then
@@ -2139,7 +2159,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"${ac_tool_prefix}gcc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2167,7 +2187,7 @@ if test -z "$ac_cv_prog_CC"; then
 set dummy gcc; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CC+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_CC"; then
@@ -2179,7 +2199,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CC=3D"gcc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2220,7 +2240,7 @@ if test -z "$CC"; then
 set dummy ${ac_tool_prefix}cc; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
+if ${ac_cv_prog_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CC"; then
@@ -2232,7 +2252,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"${ac_tool_prefix}cc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2260,7 +2280,7 @@ if test -z "$CC"; then
 set dummy cc; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
+if ${ac_cv_prog_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CC"; then
@@ -2273,7 +2293,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     if test "$as_dir/$ac_word$ac_exec_ext" =3D "/usr/ucb/cc"; then
        ac_prog_rejected=3Dyes
        continue
@@ -2319,7 +2339,7 @@ if test -z "$CC"; then
 set dummy $ac_tool_prefix$ac_prog; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CC+set}" =3D set; then :
+if ${ac_cv_prog_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CC"; then
@@ -2331,7 +2351,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"$ac_tool_prefix$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2363,7 +2383,7 @@ do
 set dummy $ac_prog; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CC+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_CC+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_CC"; then
@@ -2375,7 +2395,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CC=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2646,7 +2666,7 @@ rm -f conftest.$ac_ext conftest$ac_cv_ex
 ac_clean_files=3D$ac_clean_files_save
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for suffix of object fil=
es" >&5
 $as_echo_n "checking for suffix of object files... " >&6; }
-if test "${ac_cv_objext+set}" =3D set; then :
+if ${ac_cv_objext+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
@@ -2697,7 +2717,7 @@ OBJEXT=3D$ac_cv_objext
 ac_objext=3D$OBJEXT
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether we are using the=
 GNU C compiler" >&5
 $as_echo_n "checking whether we are using the GNU C compiler... " >&6; }
-if test "${ac_cv_c_compiler_gnu+set}" =3D set; then :
+if ${ac_cv_c_compiler_gnu+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
@@ -2734,7 +2754,7 @@ ac_test_CFLAGS=3D${CFLAGS+set}
 ac_save_CFLAGS=3D$CFLAGS
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether $CC accepts -g" =
>&5
 $as_echo_n "checking whether $CC accepts -g... " >&6; }
-if test "${ac_cv_prog_cc_g+set}" =3D set; then :
+if ${ac_cv_prog_cc_g+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   ac_save_c_werror_flag=3D$ac_c_werror_flag
@@ -2812,7 +2832,7 @@ else
 fi
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $CC option to accept=
 ISO C89" >&5
 $as_echo_n "checking for $CC option to accept ISO C89... " >&6; }
-if test "${ac_cv_prog_cc_c89+set}" =3D set; then :
+if ${ac_cv_prog_cc_c89+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   ac_cv_prog_cc_c89=3Dno
@@ -2821,8 +2841,7 @@ cat confdefs.h - <<_ACEOF >conftest.$ac_
 /* end confdefs.h.  */
 #include <stdarg.h>
 #include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+struct stat;
 /* Most of the following tests are stolen from RCS 5.7's src/conf.sh.  */
 struct buf { int x; };
 FILE * (*rcsopen) (struct buf *, struct stat *, int);
@@ -2907,195 +2926,7 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-test -z "$CC" && as_fn_error $? "no acceptable cc found in \$PATH" "$LINEN=
O" 5
-
-if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}g++", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CXX+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CXX"; then
-  ac_cv_prog_CXX=3D"$CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CXX=3D"${ac_tool_prefix}g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CXX=3D$ac_cv_prog_CXX
-if test -n "$CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CXX" >&5
-$as_echo "$CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CXX"; then
-  ac_ct_CXX=3D$CXX
-  # Extract the first word of "g++", so it can be a program name with args.
-set dummy g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CXX+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CXX"; then
-  ac_cv_prog_ac_ct_CXX=3D"$ac_ct_CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CXX=3D"g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CXX=3D$ac_cv_prog_ac_ct_CXX
-if test -n "$ac_ct_CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CXX" >&5
-$as_echo "$ac_ct_CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CXX" =3D x; then
-    CXX=3D"g++"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CXX=3D$ac_ct_CXX
-  fi
-else
-  CXX=3D"$ac_cv_prog_CXX"
-fi
-
-if test -z "$CXX"; then
-  if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}g++", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CXX+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CXX"; then
-  ac_cv_prog_CXX=3D"$CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CXX=3D"${ac_tool_prefix}g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CXX=3D$ac_cv_prog_CXX
-if test -n "$CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CXX" >&5
-$as_echo "$CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CXX"; then
-  ac_ct_CXX=3D$CXX
-  # Extract the first word of "g++", so it can be a program name with args.
-set dummy g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CXX+set}" =3D set; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CXX"; then
-  ac_cv_prog_ac_ct_CXX=3D"$ac_ct_CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CXX=3D"g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CXX=3D$ac_cv_prog_ac_ct_CXX
-if test -n "$ac_ct_CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CXX" >&5
-$as_echo "$ac_ct_CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CXX" =3D x; then
-    CXX=3D"c++"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CXX=3D$ac_ct_CXX
-  fi
-else
-  CXX=3D"$ac_cv_prog_CXX"
-fi
-
-  : ${CXX:=3Dg++}
-  ac_ext=3Dcpp
+ac_ext=3Dcpp
 ac_cpp=3D'$CXXCPP $CPPFLAGS'
 ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
 ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conftes=
t.$ac_ext $LIBS >&5'
@@ -3111,7 +2942,7 @@ if test -z "$CXX"; then
 set dummy $ac_tool_prefix$ac_prog; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_CXX+set}" =3D set; then :
+if ${ac_cv_prog_CXX+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$CXX"; then
@@ -3123,7 +2954,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CXX=3D"$ac_tool_prefix$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3155,7 +2986,7 @@ do
 set dummy $ac_prog; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_CXX+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_CXX+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_CXX"; then
@@ -3167,7 +2998,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CXX=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3233,7 +3064,7 @@ done
=20
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether we are using the=
 GNU C++ compiler" >&5
 $as_echo_n "checking whether we are using the GNU C++ compiler... " >&6; }
-if test "${ac_cv_cxx_compiler_gnu+set}" =3D set; then :
+if ${ac_cv_cxx_compiler_gnu+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
@@ -3270,7 +3101,7 @@ ac_test_CXXFLAGS=3D${CXXFLAGS+set}
 ac_save_CXXFLAGS=3D$CXXFLAGS
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking whether $CXX accepts -g"=
 >&5
 $as_echo_n "checking whether $CXX accepts -g... " >&6; }
-if test "${ac_cv_prog_cxx_g+set}" =3D set; then :
+if ${ac_cv_prog_cxx_g+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   ac_save_cxx_werror_flag=3D$ac_cxx_werror_flag
@@ -3352,10 +3183,193 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-  test -z "$CC" && as_fn_error $? "no acceptable cc found in \$PATH" "$LIN=
ENO" 5
+ac_ext=3Dc
+ac_cpp=3D'$CPP $CPPFLAGS'
+ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking how to run the C preproc=
essor" >&5
+$as_echo_n "checking how to run the C preprocessor... " >&6; }
+# On Suns, sometimes $CPP names a directory.
+if test -n "$CPP" && test -d "$CPP"; then
+  CPP=3D
+fi
+if test -z "$CPP"; then
+  if ${ac_cv_prog_CPP+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+      # Double quotes because CPP needs to be expanded
+    for CPP in "$CC -E" "$CC -E -traditional-cpp" "/lib/cpp"
+    do
+      ac_preproc_ok=3Dfalse
+for ac_c_preproc_warn_flag in '' yes
+do
+  # Use a header file that comes with gcc, so configuring glibc
+  # with a fresh cross-compiler works.
+  # Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+  # <limits.h> exists even on freestanding compilers.
+  # On the NeXT, cc -E runs the code through the compiler's parser,
+  # not just through cpp. "Syntax error" is here to catch this case.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+		     Syntax error
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+
+else
+  # Broken: fails on valid input.
+continue
 fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+  # OK, works on sane cases.  Now check whether nonexistent headers
+  # can be detected and how.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#include <ac_nonexistent.h>
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+  # Broken: success on invalid input.
+continue
+else
+  # Passes both tests.
+ac_preproc_ok=3D:
+break
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+done
+# Because of `break', _AC_PREPROC_IFELSE's cleaning code was skipped.
+rm -f conftest.i conftest.err conftest.$ac_ext
+if $ac_preproc_ok; then :
+  break
+fi
+
+    done
+    ac_cv_prog_CPP=3D$CPP
+
+fi
+  CPP=3D$ac_cv_prog_CPP
+else
+  ac_cv_prog_CPP=3D$CPP
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $CPP" >&5
+$as_echo "$CPP" >&6; }
+ac_preproc_ok=3Dfalse
+for ac_c_preproc_warn_flag in '' yes
+do
+  # Use a header file that comes with gcc, so configuring glibc
+  # with a fresh cross-compiler works.
+  # Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
+  # <limits.h> exists even on freestanding compilers.
+  # On the NeXT, cc -E runs the code through the compiler's parser,
+  # not just through cpp. "Syntax error" is here to catch this case.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#ifdef __STDC__
+# include <limits.h>
+#else
+# include <assert.h>
+#endif
+		     Syntax error
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+
+else
+  # Broken: fails on valid input.
+continue
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+  # OK, works on sane cases.  Now check whether nonexistent headers
+  # can be detected and how.
+  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#include <ac_nonexistent.h>
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"; then :
+  # Broken: success on invalid input.
+continue
+else
+  # Passes both tests.
+ac_preproc_ok=3D:
+break
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+done
+# Because of `break', _AC_PREPROC_IFELSE's cleaning code was skipped.
+rm -f conftest.i conftest.err conftest.$ac_ext
+if $ac_preproc_ok; then :
+
+else
+  { { $as_echo "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+$as_echo "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error $? "C preprocessor \"$CPP\" fails sanity check
+See \`config.log' for more details" "$LINENO" 5; }
+fi
+
+ac_ext=3Dc
+ac_cpp=3D'$CPP $CPPFLAGS'
+ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
+
+ac_ext=3Dc
+ac_cpp=3D'$CPP $CPPFLAGS'
+ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
+
+ac_ext=3Dcpp
+ac_cpp=3D'$CXXCPP $CPPFLAGS'
+ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
+ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conftes=
t.$ac_ext $LIBS >&5'
+ac_compiler_gnu=3D$ac_cv_cxx_compiler_gnu
+
+
+
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=3D$CXX}
+: ${ac_cv_prog_CC:=3D$CC}
+
+cygwin_headers=3D$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    as_fn_error $? "cannot find $winsup_srcdir/cygwin/include directory" "=
$LINENO" 5
+fi
+
+newlib_headers=3D$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null &&=
 pwd)
+if test -z "$newlib_headers"; then
+    as_fn_error $? "cannot find newlib source directory: $winsup_srcdir/..=
/newlib/libc/include" "$LINENO" 5
+fi
+newlib_headers=3D"$target_builddir/newlib/targ-include $newlib_headers"
+
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers=3D"$with_windows_headers"
+    else
+	as_fn_error $? "cannot find windef.h in specified --with-windows-headers =
path: $saw_windows_headers" "$LINENO" 5;
+    fi
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers=3D"$winsup_srcdir/w32api/include"
+else
+    windows_headers=3D$(cd $($ac_cv_prog_CC -xc /dev/null -E -include wind=
ef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1=
) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	as_fn_error $? "cannot find windows header files" "$LINENO" 5
+    fi
+fi
+CC=3D$ac_cv_prog_CC
+CXX=3D$ac_cv_prog_CXX
+export CC
+export CXX
+
+
=20
-CXXFLAGS=3D'$(CFLAGS)'
=20
=20
 case "$with_cross_host" in
@@ -3369,8 +3383,6 @@ case "$with_cross_host" in
     ;;
 esac
=20
-LIBSERVER=3D'$(bupdir)/cygserver/libcygserver.a'
-
=20
=20
=20
@@ -3379,7 +3391,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}ar; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_AR+set}" =3D set; then :
+if ${ac_cv_prog_AR+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$AR"; then
@@ -3391,7 +3403,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_AR=3D"${ac_tool_prefix}ar"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3419,7 +3431,7 @@ if test -z "$ac_cv_prog_AR"; then
 set dummy ar; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_AR+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_AR+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_AR"; then
@@ -3431,7 +3443,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_AR=3D"ar"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3471,7 +3483,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}as; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_AS+set}" =3D set; then :
+if ${ac_cv_prog_AS+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$AS"; then
@@ -3483,7 +3495,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_AS=3D"${ac_tool_prefix}as"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3511,7 +3523,7 @@ if test -z "$ac_cv_prog_AS"; then
 set dummy as; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_AS+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_AS+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_AS"; then
@@ -3523,7 +3535,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_AS=3D"as"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3563,7 +3575,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}dlltool; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_DLLTOOL+set}" =3D set; then :
+if ${ac_cv_prog_DLLTOOL+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$DLLTOOL"; then
@@ -3575,7 +3587,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_DLLTOOL=3D"${ac_tool_prefix}dlltool"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3603,7 +3615,7 @@ if test -z "$ac_cv_prog_DLLTOOL"; then
 set dummy dlltool; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_DLLTOOL+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_DLLTOOL+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_DLLTOOL"; then
@@ -3615,7 +3627,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_DLLTOOL=3D"dlltool"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3655,7 +3667,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}ld; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_LD+set}" =3D set; then :
+if ${ac_cv_prog_LD+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$LD"; then
@@ -3667,7 +3679,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_LD=3D"${ac_tool_prefix}ld"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3695,7 +3707,7 @@ if test -z "$ac_cv_prog_LD"; then
 set dummy ld; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_LD+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_LD+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_LD"; then
@@ -3707,7 +3719,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_LD=3D"ld"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3747,7 +3759,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}nm; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_NM+set}" =3D set; then :
+if ${ac_cv_prog_NM+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$NM"; then
@@ -3759,7 +3771,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_NM=3D"${ac_tool_prefix}nm"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3787,7 +3799,7 @@ if test -z "$ac_cv_prog_NM"; then
 set dummy nm; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_NM+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_NM+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_NM"; then
@@ -3799,7 +3811,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_NM=3D"nm"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3839,7 +3851,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}objcopy; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_OBJCOPY+set}" =3D set; then :
+if ${ac_cv_prog_OBJCOPY+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$OBJCOPY"; then
@@ -3851,7 +3863,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_OBJCOPY=3D"${ac_tool_prefix}objcopy"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3879,7 +3891,7 @@ if test -z "$ac_cv_prog_OBJCOPY"; then
 set dummy objcopy; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_OBJCOPY+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_OBJCOPY+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_OBJCOPY"; then
@@ -3891,7 +3903,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_OBJCOPY=3D"objcopy"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3931,7 +3943,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}objdump; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_OBJDUMP+set}" =3D set; then :
+if ${ac_cv_prog_OBJDUMP+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$OBJDUMP"; then
@@ -3943,7 +3955,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_OBJDUMP=3D"${ac_tool_prefix}objdump"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3971,7 +3983,7 @@ if test -z "$ac_cv_prog_OBJDUMP"; then
 set dummy objdump; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_OBJDUMP+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_OBJDUMP+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_OBJDUMP"; then
@@ -3983,7 +3995,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_OBJDUMP=3D"objdump"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -4023,7 +4035,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}ranlib; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_RANLIB+set}" =3D set; then :
+if ${ac_cv_prog_RANLIB+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$RANLIB"; then
@@ -4035,7 +4047,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_RANLIB=3D"${ac_tool_prefix}ranlib"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -4063,7 +4075,7 @@ if test -z "$ac_cv_prog_RANLIB"; then
 set dummy ranlib; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_RANLIB+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_RANLIB+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_RANLIB"; then
@@ -4075,7 +4087,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_RANLIB=3D"ranlib"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -4115,7 +4127,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}strip; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_STRIP+set}" =3D set; then :
+if ${ac_cv_prog_STRIP+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$STRIP"; then
@@ -4127,7 +4139,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_STRIP=3D"${ac_tool_prefix}strip"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -4155,7 +4167,7 @@ if test -z "$ac_cv_prog_STRIP"; then
 set dummy strip; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_STRIP+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_STRIP+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_STRIP"; then
@@ -4167,7 +4179,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_STRIP=3D"strip"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -4207,7 +4219,7 @@ if test -n "$ac_tool_prefix"; then
 set dummy ${ac_tool_prefix}windres; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_WINDRES+set}" =3D set; then :
+if ${ac_cv_prog_WINDRES+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$WINDRES"; then
@@ -4219,7 +4231,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_WINDRES=3D"${ac_tool_prefix}windres"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -4247,7 +4259,7 @@ if test -z "$ac_cv_prog_WINDRES"; then
 set dummy windres; ac_word=3D$2
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
 $as_echo_n "checking for $ac_word... " >&6; }
-if test "${ac_cv_prog_ac_ct_WINDRES+set}" =3D set; then :
+if ${ac_cv_prog_ac_ct_WINDRES+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   if test -n "$ac_ct_WINDRES"; then
@@ -4259,7 +4271,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_WINDRES=3D"windres"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -4299,7 +4311,7 @@ fi
 $as_echo_n "checking whether ${MAKE-make} sets \$(MAKE)... " >&6; }
 set x ${MAKE-make}
 ac_make=3D`$as_echo "$2" | sed 's/+/p/g; s/[^a-zA-Z0-9_]/_/g'`
-if eval "test \"\${ac_cv_prog_make_${ac_make}_set+set}\"" =3D set; then :
+if eval \${ac_cv_prog_make_${ac_make}_set+:} false; then :
   $as_echo_n "(cached) " >&6
 else
   cat >conftest.make <<\_ACEOF
@@ -4351,6 +4363,17 @@ case "$target_cpu" in
 esac
=20
=20
+configure_args=3DX
+for f in $ac_configure_args; do
+    case "$f" in
+	*--srcdir*) ;;
+	*) configure_args=3D"$configure_args $f" ;;
+    esac
+done
+configure_args=3D$(/usr/bin/expr "$configure_args" : 'X \(.*\)')
+
+
+
=20
=20
=20
@@ -4422,10 +4445,21 @@ $as_echo "$as_me: WARNING: cache variabl
      :end' >>confcache
 if diff "$cache_file" confcache >/dev/null 2>&1; then :; else
   if test -w "$cache_file"; then
-    test "x$cache_file" !=3D "x/dev/null" &&
+    if test "x$cache_file" !=3D "x/dev/null"; then
       { $as_echo "$as_me:${as_lineno-$LINENO}: updating cache $cache_file"=
 >&5
 $as_echo "$as_me: updating cache $cache_file" >&6;}
-    cat confcache >$cache_file
+      if test ! -f "$cache_file" || test -h "$cache_file"; then
+	cat confcache >"$cache_file"
+      else
+        case $cache_file in #(
+        */* | ?:*)
+	  mv -f confcache "$cache_file"$$ &&
+	  mv -f "$cache_file"$$ "$cache_file" ;; #(
+        *)
+	  mv -f confcache "$cache_file" ;;
+	esac
+      fi
+    fi
   else
     { $as_echo "$as_me:${as_lineno-$LINENO}: not updating unwritable cache=
 $cache_file" >&5
 $as_echo "$as_me: not updating unwritable cache $cache_file" >&6;}
@@ -4457,7 +4491,7 @@ LTLIBOBJS=3D$ac_ltlibobjs
=20
=20
=20
-: ${CONFIG_STATUS=3D./config.status}
+: "${CONFIG_STATUS=3D./config.status}"
 ac_write_fail=3D0
 ac_clean_files_save=3D$ac_clean_files
 ac_clean_files=3D"$ac_clean_files $CONFIG_STATUS"
@@ -4558,6 +4592,7 @@ fi
 IFS=3D" ""	$as_nl"
=20
 # Find who we are.  Look in the path if we contain no directory separator.
+as_myself=3D
 case $0 in #((
   *[\\/]* ) as_myself=3D$0 ;;
   *) as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
@@ -4753,16 +4788,16 @@ if (echo >conf$$.file) 2>/dev/null; then
     # ... but there are two gotchas:
     # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
     # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executabl=
e.
-    # In both cases, we have to default to `cp -p'.
+    # In both cases, we have to default to `cp -pR'.
     ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
-      as_ln_s=3D'cp -p'
+      as_ln_s=3D'cp -pR'
   elif ln conf$$.file conf$$ 2>/dev/null; then
     as_ln_s=3Dln
   else
-    as_ln_s=3D'cp -p'
+    as_ln_s=3D'cp -pR'
   fi
 else
-  as_ln_s=3D'cp -p'
+  as_ln_s=3D'cp -pR'
 fi
 rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
 rmdir conf$$.dir 2>/dev/null
@@ -4822,28 +4857,16 @@ else
   as_mkdir_p=3Dfalse
 fi
=20
-if test -x / >/dev/null 2>&1; then
-  as_test_x=3D'test -x'
-else
-  if ls -dL / >/dev/null 2>&1; then
-    as_ls_L_option=3DL
-  else
-    as_ls_L_option=3D
-  fi
-  as_test_x=3D'
-    eval sh -c '\''
-      if test -d "$1"; then
-	test -d "$1/.";
-      else
-	case $1 in #(
-	-*)set "./$1";;
-	esac;
-	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
-	???[sx]*):;;*)false;;esac;fi
-    '\'' sh
-  '
-fi
-as_executable_p=3D$as_test_x
+
+# as_fn_executable_p FILE
+# -----------------------
+# Test if FILE is an executable regular file.
+as_fn_executable_p ()
+{
+  test -f "$1" && test -x "$1"
+} # as_fn_executable_p
+as_test_x=3D'test -x'
+as_executable_p=3Das_fn_executable_p
=20
 # Sed expression to map a string onto a valid CPP name.
 as_tr_cpp=3D"eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnu=
m]%_%g'"
@@ -4865,7 +4888,7 @@ cat >>$CONFIG_STATUS <<\_ACEOF || ac_wri
 # values after options handling.
 ac_log=3D"
 This file was extended by $as_me, which was
-generated by GNU Autoconf 2.66.  Invocation command line was
+generated by GNU Autoconf 2.69.  Invocation command line was
=20
   CONFIG_FILES    =3D $CONFIG_FILES
   CONFIG_HEADERS  =3D $CONFIG_HEADERS
@@ -4927,10 +4950,10 @@ cat >>$CONFIG_STATUS <<_ACEOF || ac_writ
 ac_cs_config=3D"`$as_echo "$ac_configure_args" | sed 's/^ //; s/[\\""\`\$]=
/\\\\&/g'`"
 ac_cs_version=3D"\\
 config.status
-configured by $0, generated by GNU Autoconf 2.66,
+configured by $0, generated by GNU Autoconf 2.69,
   with options \\"\$ac_cs_config\\"
=20
-Copyright (C) 2010 Free Software Foundation, Inc.
+Copyright (C) 2012 Free Software Foundation, Inc.
 This config.status script is free software; the Free Software Foundation
 gives unlimited permission to copy, distribute and modify it."
=20
@@ -4946,11 +4969,16 @@ ac_need_defaults=3D:
 while test $# !=3D 0
 do
   case $1 in
-  --*=3D*)
+  --*=3D?*)
     ac_option=3D`expr "X$1" : 'X\([^=3D]*\)=3D'`
     ac_optarg=3D`expr "X$1" : 'X[^=3D]*=3D\(.*\)'`
     ac_shift=3D:
     ;;
+  --*=3D)
+    ac_option=3D`expr "X$1" : 'X\([^=3D]*\)=3D'`
+    ac_optarg=3D
+    ac_shift=3D:
+    ;;
   *)
     ac_option=3D$1
     ac_optarg=3D$2
@@ -4972,6 +5000,7 @@ do
     $ac_shift
     case $ac_optarg in
     *\'*) ac_optarg=3D`$as_echo "$ac_optarg" | sed "s/'/'\\\\\\\\''/g"` ;;
+    '') as_fn_error $? "missing file argument" ;;
     esac
     as_fn_append CONFIG_FILES " '$ac_optarg'"
     ac_need_defaults=3Dfalse;;
@@ -5013,7 +5042,7 @@ fi
 _ACEOF
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=3D1
 if \$ac_cs_recheck; then
-  set X '$SHELL' '$0' $ac_configure_args \$ac_configure_extra_args --no-cr=
eate --no-recursion
+  set X $SHELL '$0' $ac_configure_args \$ac_configure_extra_args --no-crea=
te --no-recursion
   shift
   \$as_echo "running CONFIG_SHELL=3D$SHELL \$*" >&6
   CONFIG_SHELL=3D'$SHELL'
@@ -5067,9 +5096,10 @@ fi
 # after its creation but before its name has been assigned to `$tmp'.
 $debug ||
 {
-  tmp=3D
+  tmp=3D ac_tmp=3D
   trap 'exit_status=3D$?
-  { test -z "$tmp" || test ! -d "$tmp" || rm -fr "$tmp"; } && exit $exit_s=
tatus
+  : "${ac_tmp:=3D$tmp}"
+  { test ! -d "$ac_tmp" || rm -fr "$ac_tmp"; } && exit $exit_status
 ' 0
   trap 'as_fn_exit 1' 1 2 13 15
 }
@@ -5077,12 +5107,13 @@ $debug ||
=20
 {
   tmp=3D`(umask 077 && mktemp -d "./confXXXXXX") 2>/dev/null` &&
-  test -n "$tmp" && test -d "$tmp"
+  test -d "$tmp"
 }  ||
 {
   tmp=3D./conf$$-$RANDOM
   (umask 077 && mkdir "$tmp")
 } || as_fn_error $? "cannot create a temporary directory in ." "$LINENO" 5
+ac_tmp=3D$tmp
=20
 # Set up the scripts for CONFIG_FILES section.
 # No need to generate them if there are no CONFIG_FILES.
@@ -5104,7 +5135,7 @@ else
   ac_cs_awk_cr=3D$ac_cr
 fi
=20
-echo 'BEGIN {' >"$tmp/subs1.awk" &&
+echo 'BEGIN {' >"$ac_tmp/subs1.awk" &&
 _ACEOF
=20
=20
@@ -5132,7 +5163,7 @@ done
 rm -f conf$$subs.sh
=20
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=3D1
-cat >>"\$tmp/subs1.awk" <<\\_ACAWK &&
+cat >>"\$ac_tmp/subs1.awk" <<\\_ACAWK &&
 _ACEOF
 sed -n '
 h
@@ -5180,7 +5211,7 @@ t delim
 rm -f conf$$subs.awk
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=3D1
 _ACAWK
-cat >>"\$tmp/subs1.awk" <<_ACAWK &&
+cat >>"\$ac_tmp/subs1.awk" <<_ACAWK &&
   for (key in S) S_is_set[key] =3D 1
   FS =3D "=07"
=20
@@ -5212,7 +5243,7 @@ if sed "s/$ac_cr//" < /dev/null > /dev/n
   sed "s/$ac_cr\$//; s/$ac_cr/$ac_cs_awk_cr/g"
 else
   cat
-fi < "$tmp/subs1.awk" > "$tmp/subs.awk" \
+fi < "$ac_tmp/subs1.awk" > "$ac_tmp/subs.awk" \
   || as_fn_error $? "could not setup config files machinery" "$LINENO" 5
 _ACEOF
=20
@@ -5246,7 +5277,7 @@ fi # test -n "$CONFIG_FILES"
 # No need to generate them if there are no CONFIG_HEADERS.
 # This happens for instance with `./config.status Makefile'.
 if test -n "$CONFIG_HEADERS"; then
-cat >"$tmp/defines.awk" <<\_ACAWK ||
+cat >"$ac_tmp/defines.awk" <<\_ACAWK ||
 BEGIN {
 _ACEOF
=20
@@ -5258,8 +5289,8 @@ _ACEOF
 # handling of long lines.
 ac_delim=3D'%!_!# '
 for ac_last_try in false false :; do
-  ac_t=3D`sed -n "/$ac_delim/p" confdefs.h`
-  if test -z "$ac_t"; then
+  ac_tt=3D`sed -n "/$ac_delim/p" confdefs.h`
+  if test -z "$ac_tt"; then
     break
   elif $ac_last_try; then
     as_fn_error $? "could not make $CONFIG_HEADERS" "$LINENO" 5
@@ -5379,7 +5410,7 @@ do
     for ac_f
     do
       case $ac_f in
-      -) ac_f=3D"$tmp/stdin";;
+      -) ac_f=3D"$ac_tmp/stdin";;
       *) # Look for the file first in the build tree, then in the source t=
ree
 	 # (if the path is not absolute).  The absolute path cannot be DOS-style,
 	 # because $ac_f cannot contain `:'.
@@ -5414,7 +5445,7 @@ $as_echo "$as_me: creating $ac_file" >&6
     esac
=20
     case $ac_tag in
-    *:-:* | *:-) cat >"$tmp/stdin" \
+    *:-:* | *:-) cat >"$ac_tmp/stdin" \
       || as_fn_error $? "could not create $ac_file" "$LINENO" 5 ;;
     esac
     ;;
@@ -5545,21 +5576,22 @@ s&@abs_top_builddir@&$ac_abs_top_builddi
 s&@INSTALL@&$ac_INSTALL&;t t
 $ac_datarootdir_hack
 "
-eval sed \"\$ac_sed_extra\" "$ac_file_inputs" | $AWK -f "$tmp/subs.awk" >$=
tmp/out \
-  || as_fn_error $? "could not create $ac_file" "$LINENO" 5
+eval sed \"\$ac_sed_extra\" "$ac_file_inputs" | $AWK -f "$ac_tmp/subs.awk"=
 \
+  >$ac_tmp/out || as_fn_error $? "could not create $ac_file" "$LINENO" 5
=20
 test -z "$ac_datarootdir_hack$ac_datarootdir_seen" &&
-  { ac_out=3D`sed -n '/\${datarootdir}/p' "$tmp/out"`; test -n "$ac_out"; =
} &&
-  { ac_out=3D`sed -n '/^[	 ]*datarootdir[	 ]*:*=3D/p' "$tmp/out"`; test -z=
 "$ac_out"; } &&
+  { ac_out=3D`sed -n '/\${datarootdir}/p' "$ac_tmp/out"`; test -n "$ac_out=
"; } &&
+  { ac_out=3D`sed -n '/^[	 ]*datarootdir[	 ]*:*=3D/p' \
+      "$ac_tmp/out"`; test -z "$ac_out"; } &&
   { $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: $ac_file contains a re=
ference to the variable \`datarootdir'
 which seems to be undefined.  Please make sure it is defined" >&5
 $as_echo "$as_me: WARNING: $ac_file contains a reference to the variable \=
`datarootdir'
 which seems to be undefined.  Please make sure it is defined" >&2;}
=20
-  rm -f "$tmp/stdin"
+  rm -f "$ac_tmp/stdin"
   case $ac_file in
-  -) cat "$tmp/out" && rm -f "$tmp/out";;
-  *) rm -f "$ac_file" && mv "$tmp/out" "$ac_file";;
+  -) cat "$ac_tmp/out" && rm -f "$ac_tmp/out";;
+  *) rm -f "$ac_file" && mv "$ac_tmp/out" "$ac_file";;
   esac \
   || as_fn_error $? "could not create $ac_file" "$LINENO" 5
  ;;
@@ -5570,20 +5602,20 @@ which seems to be undefined.  Please mak
   if test x"$ac_file" !=3D x-; then
     {
       $as_echo "/* $configure_input  */" \
-      && eval '$AWK -f "$tmp/defines.awk"' "$ac_file_inputs"
-    } >"$tmp/config.h" \
+      && eval '$AWK -f "$ac_tmp/defines.awk"' "$ac_file_inputs"
+    } >"$ac_tmp/config.h" \
       || as_fn_error $? "could not create $ac_file" "$LINENO" 5
-    if diff "$ac_file" "$tmp/config.h" >/dev/null 2>&1; then
+    if diff "$ac_file" "$ac_tmp/config.h" >/dev/null 2>&1; then
       { $as_echo "$as_me:${as_lineno-$LINENO}: $ac_file is unchanged" >&5
 $as_echo "$as_me: $ac_file is unchanged" >&6;}
     else
       rm -f "$ac_file"
-      mv "$tmp/config.h" "$ac_file" \
+      mv "$ac_tmp/config.h" "$ac_file" \
 	|| as_fn_error $? "could not create $ac_file" "$LINENO" 5
     fi
   else
     $as_echo "/* $configure_input  */" \
-      && eval '$AWK -f "$tmp/defines.awk"' "$ac_file_inputs" \
+      && eval '$AWK -f "$ac_tmp/defines.awk"' "$ac_file_inputs" \
       || as_fn_error $? "could not create -" "$LINENO" 5
   fi
  ;;
Index: cygwin/configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygwin/configure.in,v
retrieving revision 1.38
diff -d -u -p -r1.38 configure.in
--- cygwin/configure.in	9 Jul 2012 09:00:56 -0000	1.38
+++ cygwin/configure.in	13 Nov 2012 18:15:21 -0000
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
=20
 AC_PROG_INSTALL
 AC_CANONICAL_SYSTEM
=20
-LIB_AC_PROG_CC
-LIB_AC_PROG_CXX
+AC_PROG_CC
+AC_PROG_CXX
+AC_PROG_CPP
+AC_LANG(C)
+AC_LANG(C++)
+
+AC_CYGWIN_INCLUDES
=20
 case "$with_cross_host" in
   ""|*cygwin*)
@@ -32,8 +30,6 @@ case "$with_cross_host" in
     ;;
 esac
=20
-LIBSERVER=3D'$(bupdir)/cygserver/libcygserver.a'
-
 AC_SUBST(all_host)
 AC_SUBST(install_host)
=20
@@ -83,6 +79,7 @@ case "$target_cpu" in
    *)		AC_MSG_ERROR(Invalid target processor \"$target_cpu\") ;;
 esac
=20
+AC_CONFIGURE_ARGS
 AC_SUBST(MALLOC_OFILES)
 AC_SUBST(LIBSERVER)
 AC_SUBST(DLL_ENTRY)
Index: cygwin/mkvers.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygwin/mkvers.sh,v
retrieving revision 1.21
diff -d -u -p -r1.21 mkvers.sh
--- cygwin/mkvers.sh	9 Jul 2012 09:00:56 -0000	1.21
+++ cygwin/mkvers.sh	13 Nov 2012 18:15:23 -0000
@@ -1,7 +1,7 @@
 #!/bin/sh
 # mkvers.sh - Make version information for cygwin DLL
 #
-#   Copyright 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2010 Red Hat, Inc.
+#   Copyright 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2010, 2012 Red Hat=
, Inc.
 #
 # This file is part of Cygwin.
 #
@@ -14,9 +14,23 @@ exec 9> version.cc
 #
 # Arg 1 is the name of the version include file
 #
-incfile=3D"$1"
-rcfile=3D"$2"
-windres=3D"$3"
+incfile=3D"$1"; shift
+rcfile=3D"$1"; shift
+windres=3D"$1"; shift
+iflags=3D
+# Find header file locations
+while [ -n "$*" ]; do
+    case "$1" in
+	-I*)
+	    iflags=3D"$iflags $1"
+	    ;;
+	-idirafter)
+	    shift
+	    iflags=3D"$iflags -I$1"
+	    ;;
+    esac
+    shift
+done
=20
 [ -r $incfile ] || {
     echo "**** Couldn't open file '$incfile'.  Aborting."
@@ -151,4 +165,4 @@ fi
=20
 echo "Version $cygwin_ver"
 set -$- $builddate
-$windres --include-dir $dir/../w32api/include --include-dir $dir/include -=
-define CYGWIN_BUILD_DATE=3D"$1" --define CYGWIN_BUILD_TIME=3D"$2" --define=
 CYGWIN_VERSION=3D'"'"$cygwin_ver"'"' $rcfile winver.o
+$windres $iflags --define CYGWIN_BUILD_DATE=3D"$1" --define CYGWIN_BUILD_T=
IME=3D"$2" --define CYGWIN_VERSION=3D'"'"$cygwin_ver"'"' $rcfile winver.o
Index: cygwin/tlsoffsets.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: cygwin/tlsoffsets.h
diff -N cygwin/tlsoffsets.h
--- cygwin/tlsoffsets.h	29 Jul 2012 21:43:29 -0000	1.51
+++ /dev/null	1 Jan 1970 00:00:00 -0000
@@ -1,117 +0,0 @@
-//;# autogenerated:  Do not edit.
-
-//; $tls::start_offset =3D -12700;
-//; $tls::locals =3D -12700;
-//; $tls::plocals =3D 0;
-//; $tls::local_clib =3D -11236;
-//; $tls::plocal_clib =3D 1464;
-//; $tls::__dontuse =3D -11236;
-//; $tls::p__dontuse =3D 1464;
-//; $tls::func =3D -10148;
-//; $tls::pfunc =3D 2552;
-//; $tls::saved_errno =3D -10144;
-//; $tls::psaved_errno =3D 2556;
-//; $tls::sa_flags =3D -10140;
-//; $tls::psa_flags =3D 2560;
-//; $tls::oldmask =3D -10136;
-//; $tls::poldmask =3D 2564;
-//; $tls::deltamask =3D -10132;
-//; $tls::pdeltamask =3D 2568;
-//; $tls::errno_addr =3D -10128;
-//; $tls::perrno_addr =3D 2572;
-//; $tls::sigmask =3D -10124;
-//; $tls::psigmask =3D 2576;
-//; $tls::sigwait_mask =3D -10120;
-//; $tls::psigwait_mask =3D 2580;
-//; $tls::sigwait_info =3D -10116;
-//; $tls::psigwait_info =3D 2584;
-//; $tls::signal_arrived =3D -10112;
-//; $tls::psignal_arrived =3D 2588;
-//; $tls::signal_waiting =3D -10108;
-//; $tls::psignal_waiting =3D 2592;
-//; $tls::thread_context =3D -10104;
-//; $tls::pthread_context =3D 2596;
-//; $tls::thread_id =3D -9892;
-//; $tls::pthread_id =3D 2808;
-//; $tls::infodata =3D -9888;
-//; $tls::pinfodata =3D 2812;
-//; $tls::tid =3D -9740;
-//; $tls::ptid =3D 2960;
-//; $tls::_ctinfo =3D -9736;
-//; $tls::p_ctinfo =3D 2964;
-//; $tls::andreas =3D -9732;
-//; $tls::pandreas =3D 2968;
-//; $tls::wq =3D -9728;
-//; $tls::pwq =3D 2972;
-//; $tls::sig =3D -9700;
-//; $tls::psig =3D 3000;
-//; $tls::incyg =3D -9696;
-//; $tls::pincyg =3D 3004;
-//; $tls::spinning =3D -9692;
-//; $tls::pspinning =3D 3008;
-//; $tls::stacklock =3D -9688;
-//; $tls::pstacklock =3D 3012;
-//; $tls::stackptr =3D -9684;
-//; $tls::pstackptr =3D 3016;
-//; $tls::stack =3D -9680;
-//; $tls::pstack =3D 3020;
-//; $tls::initialized =3D -8656;
-//; $tls::pinitialized =3D 4044;
-//; __DATA__
-
-#define tls_locals (-12700)
-#define tls_plocals (0)
-#define tls_local_clib (-11236)
-#define tls_plocal_clib (1464)
-#define tls___dontuse (-11236)
-#define tls_p__dontuse (1464)
-#define tls_func (-10148)
-#define tls_pfunc (2552)
-#define tls_saved_errno (-10144)
-#define tls_psaved_errno (2556)
-#define tls_sa_flags (-10140)
-#define tls_psa_flags (2560)
-#define tls_oldmask (-10136)
-#define tls_poldmask (2564)
-#define tls_deltamask (-10132)
-#define tls_pdeltamask (2568)
-#define tls_errno_addr (-10128)
-#define tls_perrno_addr (2572)
-#define tls_sigmask (-10124)
-#define tls_psigmask (2576)
-#define tls_sigwait_mask (-10120)
-#define tls_psigwait_mask (2580)
-#define tls_sigwait_info (-10116)
-#define tls_psigwait_info (2584)
-#define tls_signal_arrived (-10112)
-#define tls_psignal_arrived (2588)
-#define tls_signal_waiting (-10108)
-#define tls_psignal_waiting (2592)
-#define tls_thread_context (-10104)
-#define tls_pthread_context (2596)
-#define tls_thread_id (-9892)
-#define tls_pthread_id (2808)
-#define tls_infodata (-9888)
-#define tls_pinfodata (2812)
-#define tls_tid (-9740)
-#define tls_ptid (2960)
-#define tls__ctinfo (-9736)
-#define tls_p_ctinfo (2964)
-#define tls_andreas (-9732)
-#define tls_pandreas (2968)
-#define tls_wq (-9728)
-#define tls_pwq (2972)
-#define tls_sig (-9700)
-#define tls_psig (3000)
-#define tls_incyg (-9696)
-#define tls_pincyg (3004)
-#define tls_spinning (-9692)
-#define tls_pspinning (3008)
-#define tls_stacklock (-9688)
-#define tls_pstacklock (3012)
-#define tls_stackptr (-9684)
-#define tls_pstackptr (3016)
-#define tls_stack (-9680)
-#define tls_pstack (3020)
-#define tls_initialized (-8656)
-#define tls_pinitialized (4044)
Index: cygwin/winlean.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygwin/winlean.h,v
retrieving revision 1.10
diff -d -u -p -r1.10 winlean.h
--- cygwin/winlean.h	30 Jul 2012 04:43:22 -0000	1.10
+++ cygwin/winlean.h	13 Nov 2012 18:15:23 -0000
@@ -12,6 +12,10 @@ details. */
 #define _WINLEAN_H 1
 #define WIN32_LEAN_AND_MEAN 1
=20
+#ifndef _WIN32
+#define _WIN32
+#endif /*_WIN32*/
+
 /* Mingw32 */
 #define _WINGDI_H
 #define _WINUSER_H
Index: cygwin/winsup.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/cygwin/winsup.h,v
retrieving revision 1.247
diff -d -u -p -r1.247 winsup.h
--- cygwin/winsup.h	30 Jul 2012 04:26:05 -0000	1.247
+++ cygwin/winsup.h	13 Nov 2012 18:15:23 -0000
@@ -14,6 +14,9 @@ details. */
 #endif
=20
 #define __INSIDE_CYGWIN__
+#ifndef _WIN32
+#define _WIN32
+#endif
=20
 #define NO_COPY __attribute__((nocommon)) __attribute__((section(".data_cy=
gwin_nocopy")))
 #define NO_COPY_INIT __attribute__((section(".data_cygwin_nocopy")))
Index: utils/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/utils/Makefile.in,v
retrieving revision 1.104
diff -d -u -p -r1.104 Makefile.in
--- utils/Makefile.in	7 Nov 2012 16:32:08 -0000	1.104
+++ utils/Makefile.in	13 Nov 2012 18:15:23 -0000
@@ -8,10 +8,28 @@
 # Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 # details.
=20
-SHELL:=3D@SHELL@
-
 srcdir:=3D@srcdir@
-VPATH:=3D@srcdir@
+target_builddir:=3D@target_builddir@
+winsup_srcdir:=3D@winsup_srcdir@
+configure_args=3D@configure_args@
+
+export CC:=3D@CC@
+export CXX:=3D@CXX@
+
+include ${srcdir}/../Makefile.common
+
+cygwin_build:=3D${target_builddir}/winsup/cygwin
+
+cygwin_headers:=3D@cygwin_headers@
+newlib_headers:=3D@newlib_headers@
+
+# environment variables used by ccwrap
+export CCWRAP_HEADERS:=3D. ${srcdir} $(call justdir,${cygwin_headers})
+export CCWRAP_SYSTEM_HEADERS:=3D${cygwin_headers} ${newlib_headers}
+export CCWRAP_DIRAFTER_HEADERS:=3D@windows_headers@
+
+WINDOWS_LIBDIR:=3D@windows_libdir@
+
 prefix:=3D@prefix@
 exec_prefix:=3D@exec_prefix@
=20
@@ -25,26 +43,17 @@ override INSTALL_DATA:=3D@INSTALL_DATA@
 EXEEXT:=3D@EXEEXT@
 EXEEXT_FOR_BUILD:=3D@EXEEXT_FOR_BUILD@
=20
-CC:=3D@CC@
-CC_FOR_TARGET:=3D$(CC)
-CXX:=3D@CXX@
-CXX_FOR_TARGET:=3D$(CXX)
-
 CFLAGS:=3D@CFLAGS@
 CXXFLAGS:=3D@CXXFLAGS@
 override CXXFLAGS+=3D-fno-exceptions -fno-rtti -DHAVE_DECL_GETOPT=3D0
=20
-include $(srcdir)/../Makefile.common
-
-.SUFFIXES:
-.NOEXPORT:
 .PHONY: all install clean realclean warn_dumper warn_cygcheck_zlib
=20
-ALL_LDLIBS     :=3D -lnetapi32 -ladvapi32 -lkernel32 -luser32
-ALL_LDFLAGS    :=3D -static-libgcc -Wl,--enable-auto-import -B$(newlib_bui=
ld)/libc $(LDFLAGS) $(ALL_LDLIBS)
-ALL_DEP_LDLIBS :=3D $(cygwin_build)/libcygwin.a
+LDLIBS     :=3D -lnetapi32 -ladvapi32 -lkernel32 -luser32
+LDFLAGS    :=3D -static-libgcc -Wl,--enable-auto-import -L${WINDOWS_LIBDIR=
} $(LDLIBS)
+DEP_LDLIBS :=3D $(cygwin_build)/libcygwin.a
=20
-MINGW_CXX      :=3D @MINGW_CXX@ $(CFLAGS)
+MINGW_CXX      :=3D @MINGW_CXX@
=20
 # List all binaries to be linked in Cygwin mode.  Each binary on this list
 # must have a corresponding .o of the same name.
@@ -59,6 +68,12 @@ MINGW_BINS :=3D ${addsuffix .exe,cygcheck=20
 # list will will be compiled in Cygwin mode implicitly, so there is no
 # need for a CYGWIN_OBJS.
 MINGW_OBJS :=3D bloda.o cygcheck.o dump_setup.o ldh.o path.o strace.o
+MINGW_LDFLAGS:=3D-L${WINDOWS_LIBDIR}
+
+.PHONY: all
+all:
+
+path.o: export CCWRAP_HEADERS+=3D${cygwin_headers} ${newlib_headers}
=20
 # If a binary should link in any objects besides the .o with the same
 # name as the binary, then list those here.
@@ -66,49 +81,40 @@ strace.exe: path.o
 cygcheck.exe: bloda.o path.o dump_setup.o
=20
 path-mount.o: path.cc
-	$(CXX) -c $(CXXFLAGS) -DFSTAB_ONLY -I$(updir) $< -o $@
+	${COMPILE.cc} -c -DFSTAB_ONLY -o $@ $<
 mount.exe: path-mount.o
=20
 # Provide any necessary per-target variable overrides.
-cygcheck.exe: MINGW_CXXFLAGS +=3D -idirafter $(cygwin_source)/include -idi=
rafter $(newlib_source)/libc/include
-cygcheck.exe: MINGW_LDFLAGS +=3D -lpsapi -lntdll
-cygpath.exe: ALL_LDFLAGS +=3D -lcygwin -luserenv -lntdll
+# cygcheck.exe: MINGW_CXXFLAGS +=3D -idirafter $(cygwin_source)/include -i=
dirafter $(newlib_source)/libc/include
+cygcheck.exe: export CCWRAP_DIRAFTER_HEADERS+=3D${cygwin_headers} ${newlib=
_headers}
+cygcheck.exe: MINGW_LDFLAGS +=3D -lpsapi -lntdll -lz
+cygpath.exe: LDFLAGS +=3D -luserenv -lntdll
 cygpath.exe: CXXFLAGS +=3D -fno-threadsafe-statics
-ps.exe: ALL_LDFLAGS +=3D -lcygwin -lpsapi -lntdll
+ps.exe: LDFLAGS +=3D -lpsapi -lntdll
 strace.exe: MINGW_LDFLAGS +=3D -lntdll
=20
-ldd.exe: ALL_LDFLAGS +=3D -lpsapi
-pldd.exe: ALL_LDFLAGS +=3D -lpsapi
+ldd.exe:LDFLAGS +=3D -lpsapi
+pldd.exe: LDFLAGS +=3D -lpsapi
=20
-ldh.exe: MINGW_LDFLAGS :=3D -nostdlib -lkernel32
+ldh.exe: MINGW_LDFLAGS +=3D -nostdlib -lkernel32
=20
 # Check for dumper's requirements and enable it if found.
-libiconv :=3D ${shell $(CC) --print-file-name=3Dlibiconv.a}
-libbfd   :=3D ${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=3Dlibbfd.a}
-libintl  :=3D ${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=3Dlibintl=
.a}
-bfdlink	 :=3D $(shell ${CC} -xc /dev/null -o /dev/null -c -B${bupdir2}/bfd=
/ -include bfd.h 2>&1)
-build_dumper :=3D ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(libi=
conv)" -a -z "${bfdlink}" && echo 1}
+libiconv :=3D $(call libname,libiconv.a)
+libbfd   :=3D $(call libname,libbfd.a,-B$(target_builddir)/bfd/)
+libintl  :=3D $(call libname,libintl.a,-B$(target_builddir)/intl/)
+bfdlink	 :=3D $(realpath $(shell ${CC} -xc /dev/null -o /dev/null -c -B${t=
arget_builddir}/bfd/ -include bfd.h 2>&1))
+build_dumper :=3D ${shell test -r "$(libbfd)" -a -r "$(libintl)" -a -r "$(=
libiconv)" -a -z "${bfdlink}" && echo 1}
+
 ifdef build_dumper
 CYGWIN_BINS +=3D dumper.exe
-dumper.o module_info.o parse_pe.o: CXXFLAGS +=3D -I$(bupdir2)/bfd -I$(updi=
r1)/include
+dumper.o module_info.o parse_pe.o: CXXFLAGS +=3D -I$(target_builddir)/bfd =
-I$(top_srcdir)/include
 dumper.o parse_pe.o: dumper.h
 dumper.exe: module_info.o parse_pe.o
-dumper.exe: ALL_LDFLAGS +=3D ${libbfd} ${libintl} -L$(bupdir1)/libiberty $=
(libiconv) -liberty -lz
+dumper.exe: LDFLAGS +=3D -L${top_builddir}/libiberty ${libbfd} ${libintl} =
$(libiconv) -liberty -lz
 else
 all: warn_dumper
 endif
=20
-# Check for availability of a MinGW libz and enable for cygcheck.
-libz:=3D${shell x=3D$$(${MINGW_CXX} --print-file-name=3Dlibz.a); cd $$(dir=
name $$x); dir=3D$$(pwd); case "$$dir" in *mingw*) echo $$dir/libz.a ;; esa=
c}
-ifdef libz
-zlib_h  :=3D -include ${patsubst %/lib/libz.a,%/include/zlib.h,$(libz)}
-zconf_h :=3D ${patsubst %/zlib.h,%/zconf.h,$(zlib_h)}
-dump_setup.o: MINGW_CXXFLAGS +=3D $(zconf_h) $(zlib_h)
-cygcheck.exe: MINGW_LDFLAGS +=3D $(libz)
-else
-all: warn_cygcheck_zlib
-endif
-
 all: Makefile $(CYGWIN_BINS) $(MINGW_BINS)
=20
 # test harness support (note: the "MINGW_BINS +=3D" should come after the
@@ -127,46 +133,36 @@ check: testsuite.exe ; $(<D)/$(<F)
 # the rest of this file contains generic rules
=20
 # how to compile a MinGW object
+${MINGW_OBJS}: export CXX:=3D${MINGW_CXX}
+${MINGW_OBJS}: export CCWRAP_SYSTEM_HEADERS:=3D
 $(MINGW_OBJS): %.o: %.cc
-ifdef VERBOSE
-	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
-else
-	@echo $(MINGW_CXX) $c $(MINGW_CXXFLAGS) ... $(*F).cc;\
-	$(MINGW_CXX) $c -o $(@D)/$(basename $@)$o $(MINGW_CXXFLAGS) $<
-endif
+	c++wrap -c -o $@ ${CXXFLAGS} $(MINGW_CXXFLAGS) $<
=20
 # how to link a MinGW binary
 $(MINGW_BINS): %.exe: %.o
-ifdef VERBOSE
-	$(MINGW_CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} $(MINGW_LDFLAGS)
-else
-	@echo $(MINGW_CXX) -o $@ ${filter %.o,$^} ${filter-out -B%, $(MINGW_CXXFL=
AGS) $(MINGW_LDFLAGS)};\
 	$(MINGW_CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} $(MINGW_LDFLAGS)
-endif
=20
 # how to link a Cygwin binary
 $(CYGWIN_BINS): %.exe: %.o
-ifdef VERBOSE
-	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
-else
-	@echo $(CXX) -o $@ ${filter %.o,$^} ... ${filter-out -B%, $(ALL_LDFLAGS)}=
;\
-	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(ALL_LDFLAGS)
-endif
+	$(CXX) -o $@ ${filter %.o,$^} -B$(cygwin_build)/ $(LDFLAGS)
=20
 # note: how to compile a Cygwin object is covered by the pattern rule in M=
akefile.common
=20
 # these dependencies ensure that the required in-tree libs are built first
-$(MINGW_BINS): $(ALL_DEP_LDLIBS)
-$(CYGWIN_BINS): $(ALL_DEP_LDLIBS)
+$(MINGW_BINS): $(DEP_LDLIBS)
+$(CYGWIN_BINS): $(DEP_LDLIBS)
=20
+.PHONY: clean
 clean:
 	rm -f *.o $(CYGWIN_BINS) $(MINGW_BINS) path-testsuite.cc testsuite.exe
=20
+.PHONY: realclean
 realclean: clean
 	rm -f Makefile config.cache
=20
+.PHONY: install
 install: all
-	$(SHELL) $(updir1)/mkinstalldirs $(DESTDIR)$(bindir)
+	/bin/mkdir -p ${DESTDIR}${bindir}
 	for i in $(CYGWIN_BINS) ${filter-out testsuite.exe,$(MINGW_BINS)} ; do \
 	  n=3D`echo $$i | sed '$(program_transform_name)'`; \
 	  $(INSTALL_PROGRAM) $$i $(DESTDIR)$(bindir)/$$n; \
@@ -175,6 +171,7 @@ install: all
 $(cygwin_build)/libcygwin.a: $(cygwin_build)/Makefile
 	@$(MAKE) -C $(@D) $(@F)
=20
+.PHONY: warn_dumper
 warn_dumper:
 	@echo '*** Not building dumper.exe since some required libraries or'
 	@echo '*** or headers are missing.  Potential candidates are:'
@@ -183,5 +180,5 @@ warn_dumper:
 	@echo '*** sources from sourceware.org.  Then, configure and build these'
 	@echo '*** libraries.  Otherwise, you can safely ignore this warning.'
=20
-warn_cygcheck_zlib:
-	@echo '*** Building cygcheck without package content checking due to miss=
ing mingw libz.a.'
+Makefile: Makefile.in config.status
+	/bin/sh ./config.status
Index: utils/aclocal.m4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/utils/aclocal.m4,v
retrieving revision 1.2
diff -d -u -p -r1.2 aclocal.m4
--- utils/aclocal.m4	24 May 2006 16:59:03 -0000	1.2
+++ utils/aclocal.m4	13 Nov 2012 18:15:23 -0000
@@ -1,875 +1,97 @@
-dnl aclocal.m4 generated automatically by aclocal 1.4-p6
-
-dnl Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY, to the extent permitted by law; without
-dnl even the implied warranty of MERCHANTABILITY or FITNESS FOR A
-dnl PARTICULAR PURPOSE.
-
-# lib-prefix.m4 serial 4 (gettext-0.14.2)
-dnl Copyright (C) 2001-2005 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl From Bruno Haible.
-
-dnl AC_LIB_ARG_WITH is synonymous to AC_ARG_WITH in autoconf-2.13, and
-dnl similar to AC_ARG_WITH in autoconf 2.52...2.57 except that is doesn't
-dnl require excessive bracketing.
-ifdef([AC_HELP_STRING],
-[AC_DEFUN([AC_LIB_ARG_WITH], [AC_ARG_WITH([$1],[[$2]],[$3],[$4])])],
-[AC_DEFUN([AC_][LIB_ARG_WITH], [AC_ARG_WITH([$1],[$2],[$3],[$4])])])
-
-dnl AC_LIB_PREFIX adds to the CPPFLAGS and LDFLAGS the flags that are need=
ed
-dnl to access previously installed libraries. The basic assumption is that
-dnl a user will want packages to use other packages he previously installed
-dnl with the same --prefix option.
-dnl This macro is not needed if only AC_LIB_LINKFLAGS is used to locate
-dnl libraries, but is otherwise very convenient.
-AC_DEFUN([AC_LIB_PREFIX],
-[
-  AC_BEFORE([$0], [AC_LIB_LINKFLAGS])
-  AC_REQUIRE([AC_PROG_CC])
-  AC_REQUIRE([AC_CANONICAL_HOST])
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  dnl By default, look in $includedir and $libdir.
-  use_additional=3Dyes
-  AC_LIB_WITH_FINAL_PREFIX([
-    eval additional_includedir=3D\"$includedir\"
-    eval additional_libdir=3D\"$libdir\"
-  ])
-  AC_LIB_ARG_WITH([lib-prefix],
-[  --with-lib-prefix[=3DDIR] search for libraries in DIR/include and DIR/l=
ib
-  --without-lib-prefix    don't search for libraries in includedir and lib=
dir],
-[
-    if test "X$withval" =3D "Xno"; then
-      use_additional=3Dno
-    else
-      if test "X$withval" =3D "X"; then
-        AC_LIB_WITH_FINAL_PREFIX([
-          eval additional_includedir=3D\"$includedir\"
-          eval additional_libdir=3D\"$libdir\"
-        ])
-      else
-        additional_includedir=3D"$withval/include"
-        additional_libdir=3D"$withval/lib"
-      fi
-    fi
-])
-  if test $use_additional =3D yes; then
-    dnl Potentially add $additional_includedir to $CPPFLAGS.
-    dnl But don't add it
-    dnl   1. if it's the standard /usr/include,
-    dnl   2. if it's already present in $CPPFLAGS,
-    dnl   3. if it's /usr/local/include and we are using GCC on Linux,
-    dnl   4. if it doesn't exist as a directory.
-    if test "X$additional_includedir" !=3D "X/usr/include"; then
-      haveit=3D
-      for x in $CPPFLAGS; do
-        AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-        if test "X$x" =3D "X-I$additional_includedir"; then
-          haveit=3Dyes
-          break
-        fi
-      done
-      if test -z "$haveit"; then
-        if test "X$additional_includedir" =3D "X/usr/local/include"; then
-          if test -n "$GCC"; then
-            case $host_os in
-              linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-            esac
-          fi
-        fi
-        if test -z "$haveit"; then
-          if test -d "$additional_includedir"; then
-            dnl Really add $additional_includedir to $CPPFLAGS.
-            CPPFLAGS=3D"${CPPFLAGS}${CPPFLAGS:+ }-I$additional_includedir"
-          fi
-        fi
-      fi
-    fi
-    dnl Potentially add $additional_libdir to $LDFLAGS.
-    dnl But don't add it
-    dnl   1. if it's the standard /usr/lib,
-    dnl   2. if it's already present in $LDFLAGS,
-    dnl   3. if it's /usr/local/lib and we are using GCC on Linux,
-    dnl   4. if it doesn't exist as a directory.
-    if test "X$additional_libdir" !=3D "X/usr/lib"; then
-      haveit=3D
-      for x in $LDFLAGS; do
-        AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-        if test "X$x" =3D "X-L$additional_libdir"; then
-          haveit=3Dyes
-          break
-        fi
-      done
-      if test -z "$haveit"; then
-        if test "X$additional_libdir" =3D "X/usr/local/lib"; then
-          if test -n "$GCC"; then
-            case $host_os in
-              linux*) haveit=3Dyes;;
-            esac
-          fi
-        fi
-        if test -z "$haveit"; then
-          if test -d "$additional_libdir"; then
-            dnl Really add $additional_libdir to $LDFLAGS.
-            LDFLAGS=3D"${LDFLAGS}${LDFLAGS:+ }-L$additional_libdir"
-          fi
-        fi
-      fi
-    fi
-  fi
-])
-
-dnl AC_LIB_PREPARE_PREFIX creates variables acl_final_prefix,
-dnl acl_final_exec_prefix, containing the values to which $prefix and
-dnl $exec_prefix will expand at the end of the configure script.
-AC_DEFUN([AC_LIB_PREPARE_PREFIX],
-[
-  dnl Unfortunately, prefix and exec_prefix get only finally determined
-  dnl at the end of configure.
-  if test "X$prefix" =3D "XNONE"; then
-    acl_final_prefix=3D"$ac_default_prefix"
-  else
-    acl_final_prefix=3D"$prefix"
-  fi
-  if test "X$exec_prefix" =3D "XNONE"; then
-    acl_final_exec_prefix=3D'${prefix}'
-  else
-    acl_final_exec_prefix=3D"$exec_prefix"
-  fi
-  acl_save_prefix=3D"$prefix"
-  prefix=3D"$acl_final_prefix"
-  eval acl_final_exec_prefix=3D\"$acl_final_exec_prefix\"
-  prefix=3D"$acl_save_prefix"
-])
+# generated automatically by aclocal 1.12.1 -*- Autoconf -*-
=20
-dnl AC_LIB_WITH_FINAL_PREFIX([statement]) evaluates statement, with the
-dnl variables prefix and exec_prefix bound to the values they will have
-dnl at the end of the configure script.
-AC_DEFUN([AC_LIB_WITH_FINAL_PREFIX],
-[
-  acl_save_prefix=3D"$prefix"
-  prefix=3D"$acl_final_prefix"
-  acl_save_exec_prefix=3D"$exec_prefix"
-  exec_prefix=3D"$acl_final_exec_prefix"
-  $1
-  exec_prefix=3D"$acl_save_exec_prefix"
-  prefix=3D"$acl_save_prefix"
-])
+# Copyright (C) 1996-2012 Free Software Foundation, Inc.
=20
-# lib-link.m4 serial 6 (gettext-0.14.3)
-dnl Copyright (C) 2001-2005 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
+# This file is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
=20
-dnl From Bruno Haible.
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
+# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
+# PARTICULAR PURPOSE.
=20
-AC_PREREQ(2.50)
+dnl This provides configure definitions used by all the cygwin
+dnl configure.in files.
=20
-dnl AC_LIB_LINKFLAGS(name [, dependencies]) searches for libname and
-dnl the libraries corresponding to explicit and implicit dependencies.
-dnl Sets and AC_SUBSTs the LIB${NAME} and LTLIB${NAME} variables and
-dnl augments the CPPFLAGS variable.
-AC_DEFUN([AC_LIB_LINKFLAGS],
-[
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  AC_REQUIRE([AC_LIB_RPATH])
-  define([Name],[translit([$1],[./-], [___])])
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-  AC_CACHE_CHECK([how to link with lib[]$1], [ac_cv_lib[]Name[]_libs], [
-    AC_LIB_LINKFLAGS_BODY([$1], [$2])
-    ac_cv_lib[]Name[]_libs=3D"$LIB[]NAME"
-    ac_cv_lib[]Name[]_ltlibs=3D"$LTLIB[]NAME"
-    ac_cv_lib[]Name[]_cppflags=3D"$INC[]NAME"
-  ])
-  LIB[]NAME=3D"$ac_cv_lib[]Name[]_libs"
-  LTLIB[]NAME=3D"$ac_cv_lib[]Name[]_ltlibs"
-  INC[]NAME=3D"$ac_cv_lib[]Name[]_cppflags"
-  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INC]NAME)
-  AC_SUBST([LIB]NAME)
-  AC_SUBST([LTLIB]NAME)
-  dnl Also set HAVE_LIB[]NAME so that AC_LIB_HAVE_LINKFLAGS can reuse the
-  dnl results of this search when this library appears as a dependency.
-  HAVE_LIB[]NAME=3Dyes
-  undefine([Name])
-  undefine([NAME])
+AC_DEFUN([AC_WINDOWS_HEADERS],[
+AC_ARG_WITH(
+    [windows-headers],
+    [AS_HELP_STRING([--with-windows-headers=3DDIR],
+		    [specify where the windows includes are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-win=
dows-headers])]
+)
 ])
=20
-dnl AC_LIB_HAVE_LINKFLAGS(name, dependencies, includes, testcode)
-dnl searches for libname and the libraries corresponding to explicit and
-dnl implicit dependencies, together with the specified include files and
-dnl the ability to compile and link the specified testcode. If found, it
-dnl sets and AC_SUBSTs HAVE_LIB${NAME}=3Dyes and the LIB${NAME} and
-dnl LTLIB${NAME} variables and augments the CPPFLAGS variable, and
-dnl #defines HAVE_LIB${NAME} to 1. Otherwise, it sets and AC_SUBSTs
-dnl HAVE_LIB${NAME}=3Dno and LIB${NAME} and LTLIB${NAME} to empty.
-AC_DEFUN([AC_LIB_HAVE_LINKFLAGS],
-[
-  AC_REQUIRE([AC_LIB_PREPARE_PREFIX])
-  AC_REQUIRE([AC_LIB_RPATH])
-  define([Name],[translit([$1],[./-], [___])])
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-
-  dnl Search for lib[]Name and define LIB[]NAME, LTLIB[]NAME and INC[]NAME
-  dnl accordingly.
-  AC_LIB_LINKFLAGS_BODY([$1], [$2])
+AC_DEFUN([AC_WINDOWS_LIBS],[
+AC_ARG_WITH(
+    [windows-libs],
+    [AS_HELP_STRING([--with-windows-libs=3DDIR],
+		    [specify where the windows libraries are located])],
+    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-win=
dows-libs])]
+)
+windows_libdir=3D$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=3D$(cd $(dirname $($ac_cv_prog_CC -print-file-name=3Dli=
bcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	AC_MSG_ERROR([cannot find windows library files])
+    fi
+fi
+AC_SUBST(windows_libdir)
+]
+)
=20
-  dnl Add $INC[]NAME to CPPFLAGS before performing the following checks,
-  dnl because if the user has installed lib[]Name and not disabled its use
-  dnl via --without-lib[]Name-prefix, he wants to use it.
-  ac_save_CPPFLAGS=3D"$CPPFLAGS"
-  AC_LIB_APPENDTOVAR([CPPFLAGS], [$INC]NAME)
+AC_DEFUN([AC_CYGWIN_INCLUDES], [
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=3D$CXX}
+: ${ac_cv_prog_CC:=3D$CC}
=20
-  AC_CACHE_CHECK([for lib[]$1], [ac_cv_lib[]Name], [
-    ac_save_LIBS=3D"$LIBS"
-    LIBS=3D"$LIBS $LIB[]NAME"
-    AC_TRY_LINK([$3], [$4], [ac_cv_lib[]Name=3Dyes], [ac_cv_lib[]Name=3Dno=
])
-    LIBS=3D"$ac_save_LIBS"
-  ])
-  if test "$ac_cv_lib[]Name" =3D yes; then
-    HAVE_LIB[]NAME=3Dyes
-    AC_DEFINE([HAVE_LIB]NAME, 1, [Define if you have the $1 library.])
-    AC_MSG_CHECKING([how to link with lib[]$1])
-    AC_MSG_RESULT([$LIB[]NAME])
-  else
-    HAVE_LIB[]NAME=3Dno
-    dnl If $LIB[]NAME didn't lead to a usable library, we don't need
-    dnl $INC[]NAME either.
-    CPPFLAGS=3D"$ac_save_CPPFLAGS"
-    LIB[]NAME=3D
-    LTLIB[]NAME=3D
-  fi
-  AC_SUBST([HAVE_LIB]NAME)
-  AC_SUBST([LIB]NAME)
-  AC_SUBST([LTLIB]NAME)
-  undefine([Name])
-  undefine([NAME])
-])
+cygwin_headers=3D$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    AC_MSG_ERROR([cannot find $winsup_srcdir/cygwin/include directory])
+fi
=20
-dnl Determine the platform dependent parameters needed to use rpath:
-dnl libext, shlibext, hardcode_libdir_flag_spec, hardcode_libdir_separator,
-dnl hardcode_direct, hardcode_minus_L.
-AC_DEFUN([AC_LIB_RPATH],
-[
-  dnl Tell automake >=3D 1.10 to complain if config.rpath is missing.
-  m4_ifdef([AC_REQUIRE_AUX_FILE], [AC_REQUIRE_AUX_FILE([config.rpath])])
-  AC_REQUIRE([AC_PROG_CC])                dnl we use $CC, $GCC, $LDFLAGS
-  AC_REQUIRE([AC_LIB_PROG_LD])            dnl we use $LD, $with_gnu_ld
-  AC_REQUIRE([AC_CANONICAL_HOST])         dnl we use $host
-  AC_REQUIRE([AC_CONFIG_AUX_DIR_DEFAULT]) dnl we use $ac_aux_dir
-  AC_CACHE_CHECK([for shared library run path origin], acl_cv_rpath, [
-    CC=3D"$CC" GCC=3D"$GCC" LDFLAGS=3D"$LDFLAGS" LD=3D"$LD" with_gnu_ld=3D=
"$with_gnu_ld" \
-    ${CONFIG_SHELL-/bin/sh} "$ac_aux_dir/config.rpath" "$host" > conftest.=
sh
-    . ./conftest.sh
-    rm -f ./conftest.sh
-    acl_cv_rpath=3Ddone
-  ])
-  wl=3D"$acl_cv_wl"
-  libext=3D"$acl_cv_libext"
-  shlibext=3D"$acl_cv_shlibext"
-  hardcode_libdir_flag_spec=3D"$acl_cv_hardcode_libdir_flag_spec"
-  hardcode_libdir_separator=3D"$acl_cv_hardcode_libdir_separator"
-  hardcode_direct=3D"$acl_cv_hardcode_direct"
-  hardcode_minus_L=3D"$acl_cv_hardcode_minus_L"
-  dnl Determine whether the user wants rpath handling at all.
-  AC_ARG_ENABLE(rpath,
-    [  --disable-rpath         do not hardcode runtime library paths],
-    :, enable_rpath=3Dyes)
-])
+newlib_headers=3D$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null &&=
 pwd)
+if test -z "$newlib_headers"; then
+    AC_MSG_ERROR([cannot find newlib source directory: $winsup_srcdir/../n=
ewlib/libc/include])
+fi
+newlib_headers=3D"$target_builddir/newlib/targ-include $newlib_headers"
=20
-dnl AC_LIB_LINKFLAGS_BODY(name [, dependencies]) searches for libname and
-dnl the libraries corresponding to explicit and implicit dependencies.
-dnl Sets the LIB${NAME}, LTLIB${NAME} and INC${NAME} variables.
-AC_DEFUN([AC_LIB_LINKFLAGS_BODY],
-[
-  define([NAME],[translit([$1],[abcdefghijklmnopqrstuvwxyz./-],
-                               [ABCDEFGHIJKLMNOPQRSTUVWXYZ___])])
-  dnl By default, look in $includedir and $libdir.
-  use_additional=3Dyes
-  AC_LIB_WITH_FINAL_PREFIX([
-    eval additional_includedir=3D\"$includedir\"
-    eval additional_libdir=3D\"$libdir\"
-  ])
-  AC_LIB_ARG_WITH([lib$1-prefix],
-[  --with-lib$1-prefix[=3DDIR]  search for lib$1 in DIR/include and DIR/lib
-  --without-lib$1-prefix     don't search for lib$1 in includedir and libd=
ir],
-[
-    if test "X$withval" =3D "Xno"; then
-      use_additional=3Dno
-    else
-      if test "X$withval" =3D "X"; then
-        AC_LIB_WITH_FINAL_PREFIX([
-          eval additional_includedir=3D\"$includedir\"
-          eval additional_libdir=3D\"$libdir\"
-        ])
-      else
-        additional_includedir=3D"$withval/include"
-        additional_libdir=3D"$withval/lib"
-      fi
-    fi
-])
-  dnl Search the library and its dependencies in $additional_libdir and
-  dnl $LDFLAGS. Using breadth-first-seach.
-  LIB[]NAME=3D
-  LTLIB[]NAME=3D
-  INC[]NAME=3D
-  rpathdirs=3D
-  ltrpathdirs=3D
-  names_already_handled=3D
-  names_next_round=3D'$1 $2'
-  while test -n "$names_next_round"; do
-    names_this_round=3D"$names_next_round"
-    names_next_round=3D
-    for name in $names_this_round; do
-      already_handled=3D
-      for n in $names_already_handled; do
-        if test "$n" =3D "$name"; then
-          already_handled=3Dyes
-          break
-        fi
-      done
-      if test -z "$already_handled"; then
-        names_already_handled=3D"$names_already_handled $name"
-        dnl See if it was already located by an earlier AC_LIB_LINKFLAGS
-        dnl or AC_LIB_HAVE_LINKFLAGS call.
-        uppername=3D`echo "$name" | sed -e 'y|abcdefghijklmnopqrstuvwxyz./=
-|ABCDEFGHIJKLMNOPQRSTUVWXYZ___|'`
-        eval value=3D\"\$HAVE_LIB$uppername\"
-        if test -n "$value"; then
-          if test "$value" =3D yes; then
-            eval value=3D\"\$LIB$uppername\"
-            test -z "$value" || LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$v=
alue"
-            eval value=3D\"\$LTLIB$uppername\"
-            test -z "$value" || LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME=
:+ }$value"
-          else
-            dnl An earlier call to AC_LIB_HAVE_LINKFLAGS has determined
-            dnl that this library doesn't exist. So just drop it.
-            :
-          fi
-        else
-          dnl Search the library lib$name in $additional_libdir and $LDFLA=
GS
-          dnl and the already constructed $LIBNAME/$LTLIBNAME.
-          found_dir=3D
-          found_la=3D
-          found_so=3D
-          found_a=3D
-          if test $use_additional =3D yes; then
-            if test -n "$shlibext" && test -f "$additional_libdir/lib$name=
.$shlibext"; then
-              found_dir=3D"$additional_libdir"
-              found_so=3D"$additional_libdir/lib$name.$shlibext"
-              if test -f "$additional_libdir/lib$name.la"; then
-                found_la=3D"$additional_libdir/lib$name.la"
-              fi
-            else
-              if test -f "$additional_libdir/lib$name.$libext"; then
-                found_dir=3D"$additional_libdir"
-                found_a=3D"$additional_libdir/lib$name.$libext"
-                if test -f "$additional_libdir/lib$name.la"; then
-                  found_la=3D"$additional_libdir/lib$name.la"
-                fi
-              fi
-            fi
-          fi
-          if test "X$found_dir" =3D "X"; then
-            for x in $LDFLAGS $LTLIB[]NAME; do
-              AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-              case "$x" in
-                -L*)
-                  dir=3D`echo "X$x" | sed -e 's/^X-L//'`
-                  if test -n "$shlibext" && test -f "$dir/lib$name.$shlibe=
xt"; then
-                    found_dir=3D"$dir"
-                    found_so=3D"$dir/lib$name.$shlibext"
-                    if test -f "$dir/lib$name.la"; then
-                      found_la=3D"$dir/lib$name.la"
-                    fi
-                  else
-                    if test -f "$dir/lib$name.$libext"; then
-                      found_dir=3D"$dir"
-                      found_a=3D"$dir/lib$name.$libext"
-                      if test -f "$dir/lib$name.la"; then
-                        found_la=3D"$dir/lib$name.la"
-                      fi
-                    fi
-                  fi
-                  ;;
-              esac
-              if test "X$found_dir" !=3D "X"; then
-                break
-              fi
-            done
-          fi
-          if test "X$found_dir" !=3D "X"; then
-            dnl Found the library.
-            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-L$found_dir -l$=
name"
-            if test "X$found_so" !=3D "X"; then
-              dnl Linking with a shared library. We attempt to hardcode its
-              dnl directory into the executable's runpath, unless it's the
-              dnl standard /usr/lib.
-              if test "$enable_rpath" =3D no || test "X$found_dir" =3D "X/=
usr/lib"; then
-                dnl No hardcoding is needed.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-              else
-                dnl Use an explicit option to hardcode DIR into the result=
ing
-                dnl binary.
-                dnl Potentially add DIR to ltrpathdirs.
-                dnl The ltrpathdirs will be appended to $LTLIBNAME at the =
end.
-                haveit=3D
-                for x in $ltrpathdirs; do
-                  if test "X$x" =3D "X$found_dir"; then
-                    haveit=3Dyes
-                    break
-                  fi
-                done
-                if test -z "$haveit"; then
-                  ltrpathdirs=3D"$ltrpathdirs $found_dir"
-                fi
-                dnl The hardcoding into $LIBNAME is system dependent.
-                if test "$hardcode_direct" =3D yes; then
-                  dnl Using DIR/libNAME.so during linking hardcodes DIR in=
to the
-                  dnl resulting binary.
-                  LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                else
-                  if test -n "$hardcode_libdir_flag_spec" && test "$hardco=
de_minus_L" =3D no; then
-                    dnl Use an explicit option to hardcode DIR into the re=
sulting
-                    dnl binary.
-                    LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                    dnl Potentially add DIR to rpathdirs.
-                    dnl The rpathdirs will be appended to $LIBNAME at the =
end.
-                    haveit=3D
-                    for x in $rpathdirs; do
-                      if test "X$x" =3D "X$found_dir"; then
-                        haveit=3Dyes
-                        break
-                      fi
-                    done
-                    if test -z "$haveit"; then
-                      rpathdirs=3D"$rpathdirs $found_dir"
-                    fi
-                  else
-                    dnl Rely on "-L$found_dir".
-                    dnl But don't add it if it's already contained in the =
LDFLAGS
-                    dnl or the already constructed $LIBNAME
-                    haveit=3D
-                    for x in $LDFLAGS $LIB[]NAME; do
-                      AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                      if test "X$x" =3D "X-L$found_dir"; then
-                        haveit=3Dyes
-                        break
-                      fi
-                    done
-                    if test -z "$haveit"; then
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$found_dir"
-                    fi
-                    if test "$hardcode_minus_L" !=3D no; then
-                      dnl FIXME: Not sure whether we should use
-                      dnl "-L$found_dir -l$name" or "-L$found_dir $found_s=
o"
-                      dnl here.
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_so"
-                    else
-                      dnl We cannot use $hardcode_runpath_var and LD_RUN_P=
ATH
-                      dnl here, because this doesn't fit in flags passed t=
o the
-                      dnl compiler. So give up. No hardcoding. This affect=
s only
-                      dnl very old systems.
-                      dnl FIXME: Not sure whether we should use
-                      dnl "-L$found_dir -l$name" or "-L$found_dir $found_s=
o"
-                      dnl here.
-                      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-l$name"
-                    fi
-                  fi
-                fi
-              fi
-            else
-              if test "X$found_a" !=3D "X"; then
-                dnl Linking with a static library.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$found_a"
-              else
-                dnl We shouldn't come here, but anyway it's good to have a
-                dnl fallback.
-                LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$found_dir -l$na=
me"
-              fi
-            fi
-            dnl Assume the include files are nearby.
-            additional_includedir=3D
-            case "$found_dir" in
-              */lib | */lib/)
-                basedir=3D`echo "X$found_dir" | sed -e 's,^X,,' -e 's,/lib=
/*$,,'`
-                additional_includedir=3D"$basedir/include"
-                ;;
-            esac
-            if test "X$additional_includedir" !=3D "X"; then
-              dnl Potentially add $additional_includedir to $INCNAME.
-              dnl But don't add it
-              dnl   1. if it's the standard /usr/include,
-              dnl   2. if it's /usr/local/include and we are using GCC on =
Linux,
-              dnl   3. if it's already present in $CPPFLAGS or the already
-              dnl      constructed $INCNAME,
-              dnl   4. if it doesn't exist as a directory.
-              if test "X$additional_includedir" !=3D "X/usr/include"; then
-                haveit=3D
-                if test "X$additional_includedir" =3D "X/usr/local/include=
"; then
-                  if test -n "$GCC"; then
-                    case $host_os in
-                      linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-                    esac
-                  fi
-                fi
-                if test -z "$haveit"; then
-                  for x in $CPPFLAGS $INC[]NAME; do
-                    AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                    if test "X$x" =3D "X-I$additional_includedir"; then
-                      haveit=3Dyes
-                      break
-                    fi
-                  done
-                  if test -z "$haveit"; then
-                    if test -d "$additional_includedir"; then
-                      dnl Really add $additional_includedir to $INCNAME.
-                      INC[]NAME=3D"${INC[]NAME}${INC[]NAME:+ }-I$additiona=
l_includedir"
-                    fi
-                  fi
-                fi
-              fi
-            fi
-            dnl Look for dependencies.
-            if test -n "$found_la"; then
-              dnl Read the .la file. It defines the variables
-              dnl dlname, library_names, old_library, dependency_libs, cur=
rent,
-              dnl age, revision, installed, dlopen, dlpreopen, libdir.
-              save_libdir=3D"$libdir"
-              case "$found_la" in
-                */* | *\\*) . "$found_la" ;;
-                *) . "./$found_la" ;;
-              esac
-              libdir=3D"$save_libdir"
-              dnl We use only dependency_libs.
-              for dep in $dependency_libs; do
-                case "$dep" in
-                  -L*)
-                    additional_libdir=3D`echo "X$dep" | sed -e 's/^X-L//'`
-                    dnl Potentially add $additional_libdir to $LIBNAME and=
 $LTLIBNAME.
-                    dnl But don't add it
-                    dnl   1. if it's the standard /usr/lib,
-                    dnl   2. if it's /usr/local/lib and we are using GCC o=
n Linux,
-                    dnl   3. if it's already present in $LDFLAGS or the al=
ready
-                    dnl      constructed $LIBNAME,
-                    dnl   4. if it doesn't exist as a directory.
-                    if test "X$additional_libdir" !=3D "X/usr/lib"; then
-                      haveit=3D
-                      if test "X$additional_libdir" =3D "X/usr/local/lib";=
 then
-                        if test -n "$GCC"; then
-                          case $host_os in
-                            linux* | gnu* | k*bsd*-gnu) haveit=3Dyes;;
-                          esac
-                        fi
-                      fi
-                      if test -z "$haveit"; then
-                        haveit=3D
-                        for x in $LDFLAGS $LIB[]NAME; do
-                          AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                          if test "X$x" =3D "X-L$additional_libdir"; then
-                            haveit=3Dyes
-                            break
-                          fi
-                        done
-                        if test -z "$haveit"; then
-                          if test -d "$additional_libdir"; then
-                            dnl Really add $additional_libdir to $LIBNAME.
-                            LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-L$add=
itional_libdir"
-                          fi
-                        fi
-                        haveit=3D
-                        for x in $LDFLAGS $LTLIB[]NAME; do
-                          AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-                          if test "X$x" =3D "X-L$additional_libdir"; then
-                            haveit=3Dyes
-                            break
-                          fi
-                        done
-                        if test -z "$haveit"; then
-                          if test -d "$additional_libdir"; then
-                            dnl Really add $additional_libdir to $LTLIBNAM=
E.
-                            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }=
-L$additional_libdir"
-                          fi
-                        fi
-                      fi
-                    fi
-                    ;;
-                  -R*)
-                    dir=3D`echo "X$dep" | sed -e 's/^X-R//'`
-                    if test "$enable_rpath" !=3D no; then
-                      dnl Potentially add DIR to rpathdirs.
-                      dnl The rpathdirs will be appended to $LIBNAME at th=
e end.
-                      haveit=3D
-                      for x in $rpathdirs; do
-                        if test "X$x" =3D "X$dir"; then
-                          haveit=3Dyes
-                          break
-                        fi
-                      done
-                      if test -z "$haveit"; then
-                        rpathdirs=3D"$rpathdirs $dir"
-                      fi
-                      dnl Potentially add DIR to ltrpathdirs.
-                      dnl The ltrpathdirs will be appended to $LTLIBNAME a=
t the end.
-                      haveit=3D
-                      for x in $ltrpathdirs; do
-                        if test "X$x" =3D "X$dir"; then
-                          haveit=3Dyes
-                          break
-                        fi
-                      done
-                      if test -z "$haveit"; then
-                        ltrpathdirs=3D"$ltrpathdirs $dir"
-                      fi
-                    fi
-                    ;;
-                  -l*)
-                    dnl Handle this in the next round.
-                    names_next_round=3D"$names_next_round "`echo "X$dep" |=
 sed -e 's/^X-l//'`
-                    ;;
-                  *.la)
-                    dnl Handle this in the next round. Throw away the .la's
-                    dnl directory; it is already contained in a preceding =
-L
-                    dnl option.
-                    names_next_round=3D"$names_next_round "`echo "X$dep" |=
 sed -e 's,^X.*/,,' -e 's,^lib,,' -e 's,\.la$,,'`
-                    ;;
-                  *)
-                    dnl Most likely an immediate library name.
-                    LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$dep"
-                    LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }$dep"
-                    ;;
-                esac
-              done
-            fi
-          else
-            dnl Didn't find the library; assume it is in the system direct=
ories
-            dnl known to the linker and runtime loader. (All the system
-            dnl directories known to the linker should also be known to the
-            dnl runtime loader, otherwise the system is severely misconfig=
ured.)
-            LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }-l$name"
-            LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-l$name"
-          fi
-        fi
-      fi
-    done
-  done
-  if test "X$rpathdirs" !=3D "X"; then
-    if test -n "$hardcode_libdir_separator"; then
-      dnl Weird platform: only the last -rpath option counts, the user must
-      dnl pass all path elements in one option. We can arrange that for a
-      dnl single library, but not when more than one $LIBNAMEs are used.
-      alldirs=3D
-      for found_dir in $rpathdirs; do
-        alldirs=3D"${alldirs}${alldirs:+$hardcode_libdir_separator}$found_=
dir"
-      done
-      dnl Note: hardcode_libdir_flag_spec uses $libdir and $wl.
-      acl_save_libdir=3D"$libdir"
-      libdir=3D"$alldirs"
-      eval flag=3D\"$hardcode_libdir_flag_spec\"
-      libdir=3D"$acl_save_libdir"
-      LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$flag"
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers=3D"$with_windows_headers"
     else
-      dnl The -rpath options are cumulative.
-      for found_dir in $rpathdirs; do
-        acl_save_libdir=3D"$libdir"
-        libdir=3D"$found_dir"
-        eval flag=3D\"$hardcode_libdir_flag_spec\"
-        libdir=3D"$acl_save_libdir"
-        LIB[]NAME=3D"${LIB[]NAME}${LIB[]NAME:+ }$flag"
-      done
-    fi
-  fi
-  if test "X$ltrpathdirs" !=3D "X"; then
-    dnl When using libtool, the option that works for both libraries and
-    dnl executables is -R. The -R options are cumulative.
-    for found_dir in $ltrpathdirs; do
-      LTLIB[]NAME=3D"${LTLIB[]NAME}${LTLIB[]NAME:+ }-R$found_dir"
-    done
-  fi
-])
-
-dnl AC_LIB_APPENDTOVAR(VAR, CONTENTS) appends the elements of CONTENTS to =
VAR,
-dnl unless already present in VAR.
-dnl Works only for CPPFLAGS, not for LIB* variables because that sometimes
-dnl contains two or three consecutive elements that belong together.
-AC_DEFUN([AC_LIB_APPENDTOVAR],
-[
-  for element in [$2]; do
-    haveit=3D
-    for x in $[$1]; do
-      AC_LIB_WITH_FINAL_PREFIX([eval x=3D\"$x\"])
-      if test "X$x" =3D "X$element"; then
-        haveit=3Dyes
-        break
-      fi
-    done
-    if test -z "$haveit"; then
-      [$1]=3D"${[$1]}${[$1]:+ }$element"
+	AC_MSG_ERROR([cannot find windef.h in specified --with-windows-headers pa=
th: $saw_windows_headers]);
     fi
-  done
-])
-
-# lib-ld.m4 serial 3 (gettext-0.13)
-dnl Copyright (C) 1996-2003 Free Software Foundation, Inc.
-dnl This file is free software; the Free Software Foundation
-dnl gives unlimited permission to copy and/or distribute it,
-dnl with or without modifications, as long as this notice is preserved.
-
-dnl Subroutines of libtool.m4,
-dnl with replacements s/AC_/AC_LIB/ and s/lt_cv/acl_cv/ to avoid collision
-dnl with libtool.m4.
-
-dnl From libtool-1.4. Sets the variable with_gnu_ld to yes or no.
-AC_DEFUN([AC_LIB_PROG_LD_GNU],
-[AC_CACHE_CHECK([if the linker ($LD) is GNU ld], acl_cv_prog_gnu_ld,
-[# I'd rather use --version here, but apparently some GNU ld's only accept=
 -v.
-case `$LD -v 2>&1 </dev/null` in
-*GNU* | *'with BFD'*)
-  acl_cv_prog_gnu_ld=3Dyes ;;
-*)
-  acl_cv_prog_gnu_ld=3Dno ;;
-esac])
-with_gnu_ld=3D$acl_cv_prog_gnu_ld
-])
-
-dnl From libtool-1.4. Sets the variable LD.
-AC_DEFUN([AC_LIB_PROG_LD],
-[AC_ARG_WITH(gnu-ld,
-[  --with-gnu-ld           assume the C compiler uses GNU ld [default=3Dno=
]],
-test "$withval" =3D no || with_gnu_ld=3Dyes, with_gnu_ld=3Dno)
-AC_REQUIRE([AC_PROG_CC])dnl
-AC_REQUIRE([AC_CANONICAL_HOST])dnl
-# Prepare PATH_SEPARATOR.
-# The user is always right.
-if test "${PATH_SEPARATOR+set}" !=3D set; then
-  echo "#! /bin/sh" >conf$$.sh
-  echo  "exit 0"   >>conf$$.sh
-  chmod +x conf$$.sh
-  if (PATH=3D"/nonexistent;."; conf$$.sh) >/dev/null 2>&1; then
-    PATH_SEPARATOR=3D';'
-  else
-    PATH_SEPARATOR=3D:
-  fi
-  rm -f conf$$.sh
-fi
-ac_prog=3Dld
-if test "$GCC" =3D yes; then
-  # Check if gcc -print-prog-name=3Dld gives a path.
-  AC_MSG_CHECKING([for ld used by GCC])
-  case $host in
-  *-*-mingw*)
-    # gcc leaves a trailing carriage return which upsets mingw
-    ac_prog=3D`($CC -print-prog-name=3Dld) 2>&5 | tr -d '\015'` ;;
-  *)
-    ac_prog=3D`($CC -print-prog-name=3Dld) 2>&5` ;;
-  esac
-  case $ac_prog in
-    # Accept absolute paths.
-    [[\\/]* | [A-Za-z]:[\\/]*)]
-      [re_direlt=3D'/[^/][^/]*/\.\./']
-      # Canonicalize the path of ld
-      ac_prog=3D`echo $ac_prog| sed 's%\\\\%/%g'`
-      while echo $ac_prog | grep "$re_direlt" > /dev/null 2>&1; do
-	ac_prog=3D`echo $ac_prog| sed "s%$re_direlt%/%"`
-      done
-      test -z "$LD" && LD=3D"$ac_prog"
-      ;;
-  "")
-    # If it fails, then pretend we aren't using GCC.
-    ac_prog=3Dld
-    ;;
-  *)
-    # If it is relative, then search for the first ld in PATH.
-    with_gnu_ld=3Dunknown
-    ;;
-  esac
-elif test "$with_gnu_ld" =3D yes; then
-  AC_MSG_CHECKING([for GNU ld])
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers=3D"$winsup_srcdir/w32api/include"
 else
-  AC_MSG_CHECKING([for non-GNU ld])
-fi
-AC_CACHE_VAL(acl_cv_path_LD,
-[if test -z "$LD"; then
-  IFS=3D"${IFS=3D 	}"; ac_save_ifs=3D"$IFS"; IFS=3D"${IFS}${PATH_SEPARATOR=
-:}"
-  for ac_dir in $PATH; do
-    test -z "$ac_dir" && ac_dir=3D.
-    if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext";=
 then
-      acl_cv_path_LD=3D"$ac_dir/$ac_prog"
-      # Check to see if the program is GNU ld.  I'd rather use --version,
-      # but apparently some GNU ld's only accept -v.
-      # Break only if it was the GNU/non-GNU ld that we prefer.
-      case `"$acl_cv_path_LD" -v 2>&1 < /dev/null` in
-      *GNU* | *'with BFD'*)
-	test "$with_gnu_ld" !=3D no && break ;;
-      *)
-	test "$with_gnu_ld" !=3D yes && break ;;
-      esac
+    windows_headers=3D$(cd $($ac_cv_prog_CC -xc /dev/null -E -include wind=
ef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1=
) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	AC_MSG_ERROR([cannot find windows header files])
     fi
-  done
-  IFS=3D"$ac_save_ifs"
-else
-  acl_cv_path_LD=3D"$LD" # Let the user override the test with a path.
-fi])
-LD=3D"$acl_cv_path_LD"
-if test -n "$LD"; then
-  AC_MSG_RESULT($LD)
-else
-  AC_MSG_RESULT(no)
 fi
-test -z "$LD" && AC_MSG_ERROR([no acceptable ld found in \$PATH])
-AC_LIB_PROG_LD_GNU
+CC=3D$ac_cv_prog_CC
+CXX=3D$ac_cv_prog_CXX
+export CC
+export CXX
+AC_SUBST(windows_headers)
+AC_SUBST(newlib_headers)
+AC_SUBST(cygwin_headers)
 ])
=20
-dnl This provides configure definitions used by all the winsup
-dnl configure.in files.
-
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
-  ac_cv_prog_gcc=3Dyes
-else
-  ac_cv_prog_gcc=3Dno
-fi])])
-
-AC_DEFUN([LIB_AC_PROG_CC],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CC, gcc, gcc)
-: ${CC:=3Dgcc}
-AC_PROG_CC
-test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
+AC_DEFUN([AC_CONFIGURE_ARGS], [
+configure_args=3DX
+for f in $ac_configure_args; do
+    case "$f" in
+	*--srcdir*) ;;
+	*) configure_args=3D"$configure_args $f" ;;
+    esac
+done
+configure_args=3D$(/usr/bin/expr "$configure_args" : 'X \(.*\)')
+AC_SUBST(configure_args)
 ])
=20
-AC_DEFUN([LIB_AC_PROG_CXX],
-[AC_BEFORE([$0], [AC_PROG_CPP])dnl
-AC_CHECK_TOOL(CXX, g++, g++)
-if test -z "$CXX"; then
-  AC_CHECK_TOOL(CXX, g++, c++, , , )
-  : ${CXX:=3Dg++}
-  AC_PROG_CXX
-  test -z "$CC" && AC_MSG_ERROR([no acceptable cc found in \$PATH])
-fi
-
-CXXFLAGS=3D'$(CFLAGS)'
-])
+AC_SUBST(target_builddir)
+AC_SUBST(winsup_srcdir)
=20
Index: utils/autogen.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: utils/autogen.sh
diff -N utils/autogen.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ utils/autogen.sh	13 Nov 2012 18:15:23 -0000
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+/usr/bin/aclocal --acdir=3D..
+/usr/bin/autoconf -f
+exec /bin/rm -rf autom4te.cache
Index: utils/configure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/utils/configure,v
retrieving revision 1.10
diff -d -u -p -r1.10 configure
--- utils/configure	24 Oct 2012 12:45:09 -0000	1.10
+++ utils/configure	13 Nov 2012 18:15:24 -0000
@@ -1,11 +1,9 @@
 #! /bin/sh
 # Guess values for system-dependent variables and create Makefiles.
-# Generated by GNU Autoconf 2.68.
+# Generated by GNU Autoconf 2.69.
 #
 #
-# Copyright (C) 1992, 1993, 1994, 1995, 1996, 1998, 1999, 2000, 2001,
-# 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010 Free Software
-# Foundation, Inc.
+# Copyright (C) 1992-1996, 1998-2012 Free Software Foundation, Inc.
 #
 #
 # This configure script is free software; the Free Software Foundation
@@ -134,6 +132,31 @@ export LANGUAGE
 # CDPATH.
 (unset CDPATH) >/dev/null 2>&1 && unset CDPATH
=20
+# Use a proper internal environment variable to ensure we don't fall
+  # into an infinite loop, continuously re-executing ourselves.
+  if test x"${_as_can_reexec}" !=3D xno && test "x$CONFIG_SHELL" !=3D x; t=
hen
+    _as_can_reexec=3Dno; export _as_can_reexec;
+    # We cannot yet assume a decent shell, so we have to provide a
+# neutralization value for shells without unset; and this also
+# works around shells that cannot unset nonexistent variables.
+# Preserve -v and -x to the replacement shell.
+BASH_ENV=3D/dev/null
+ENV=3D/dev/null
+(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
+case $- in # ((((
+  *v*x* | *x*v* ) as_opts=3D-vx ;;
+  *v* ) as_opts=3D-v ;;
+  *x* ) as_opts=3D-x ;;
+  * ) as_opts=3D ;;
+esac
+exec $CONFIG_SHELL $as_opts "$as_myself" ${1+"$@"}
+# Admittedly, this is quite paranoid, since all the known shells bail
+# out after a failed `exec'.
+$as_echo "$0: could not re-execute with $CONFIG_SHELL" >&2
+as_fn_exit 255
+  fi
+  # We don't want this to propagate to other subprocesses.
+          { _as_can_reexec=3D; unset _as_can_reexec;}
 if test "x$CONFIG_SHELL" =3D x; then
   as_bourne_compatible=3D"if test -n \"\${ZSH_VERSION+set}\" && (emulate s=
h) >/dev/null 2>&1; then :
   emulate sh
@@ -167,7 +190,8 @@ if ( set x; as_fn_ret_success y && test=20
 else
   exitcode=3D1; echo positional parameters were not saved.
 fi
-test x\$exitcode =3D x0 || exit 1"
+test x\$exitcode =3D x0 || exit 1
+test -x / || exit 1"
   as_suggested=3D"  as_lineno_1=3D";as_suggested=3D$as_suggested$LINENO;as=
_suggested=3D$as_suggested" as_lineno_1a=3D\$LINENO
   as_lineno_2=3D";as_suggested=3D$as_suggested$LINENO;as_suggested=3D$as_s=
uggested" as_lineno_2a=3D\$LINENO
   eval 'test \"x\$as_lineno_1'\$as_run'\" !=3D \"x\$as_lineno_2'\$as_run'\=
" &&
@@ -211,21 +235,25 @@ IFS=3D$as_save_IFS
=20
=20
       if test "x$CONFIG_SHELL" !=3D x; then :
-  # We cannot yet assume a decent shell, so we have to provide a
-	# neutralization value for shells without unset; and this also
-	# works around shells that cannot unset nonexistent variables.
-	# Preserve -v and -x to the replacement shell.
-	BASH_ENV=3D/dev/null
-	ENV=3D/dev/null
-	(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
-	export CONFIG_SHELL
-	case $- in # ((((
-	  *v*x* | *x*v* ) as_opts=3D-vx ;;
-	  *v* ) as_opts=3D-v ;;
-	  *x* ) as_opts=3D-x ;;
-	  * ) as_opts=3D ;;
-	esac
-	exec "$CONFIG_SHELL" $as_opts "$as_myself" ${1+"$@"}
+  export CONFIG_SHELL
+             # We cannot yet assume a decent shell, so we have to provide a
+# neutralization value for shells without unset; and this also
+# works around shells that cannot unset nonexistent variables.
+# Preserve -v and -x to the replacement shell.
+BASH_ENV=3D/dev/null
+ENV=3D/dev/null
+(unset BASH_ENV) >/dev/null 2>&1 && unset BASH_ENV ENV
+case $- in # ((((
+  *v*x* | *x*v* ) as_opts=3D-vx ;;
+  *v* ) as_opts=3D-v ;;
+  *x* ) as_opts=3D-x ;;
+  * ) as_opts=3D ;;
+esac
+exec $CONFIG_SHELL $as_opts "$as_myself" ${1+"$@"}
+# Admittedly, this is quite paranoid, since all the known shells bail
+# out after a failed `exec'.
+$as_echo "$0: could not re-execute with $CONFIG_SHELL" >&2
+exit 255
 fi
=20
     if test x$as_have_required =3D xno; then :
@@ -327,6 +355,14 @@ $as_echo X"$as_dir" |
=20
=20
 } # as_fn_mkdir_p
+
+# as_fn_executable_p FILE
+# -----------------------
+# Test if FILE is an executable regular file.
+as_fn_executable_p ()
+{
+  test -f "$1" && test -x "$1"
+} # as_fn_executable_p
 # as_fn_append VAR VALUE
 # ----------------------
 # Append the text in VALUE to the end of the definition contained in VAR. =
Take
@@ -448,6 +484,10 @@ as_cr_alnum=3D$as_cr_Letters$as_cr_digits
   chmod +x "$as_me.lineno" ||
     { $as_echo "$as_me: error: cannot create $as_me.lineno; rerun with a P=
OSIX shell" >&2; as_fn_exit 1; }
=20
+  # If we had to re-execute with $CONFIG_SHELL, we're ensured to have
+  # already done that, so ensure we don't try to do so again and fall
+  # in an infinite loop.  This has already happened in practice.
+  _as_can_reexec=3Dno; export _as_can_reexec
   # Don't try to exec as it changes $[0], causing all sort of problems
   # (the dirname of $[0] is not the place where we might find the
   # original and so on.  Autoconf is especially sensitive to this).
@@ -482,16 +522,16 @@ if (echo >conf$$.file) 2>/dev/null; then
     # ... but there are two gotchas:
     # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
     # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executabl=
e.
-    # In both cases, we have to default to `cp -p'.
+    # In both cases, we have to default to `cp -pR'.
     ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
-      as_ln_s=3D'cp -p'
+      as_ln_s=3D'cp -pR'
   elif ln conf$$.file conf$$ 2>/dev/null; then
     as_ln_s=3Dln
   else
-    as_ln_s=3D'cp -p'
+    as_ln_s=3D'cp -pR'
   fi
 else
-  as_ln_s=3D'cp -p'
+  as_ln_s=3D'cp -pR'
 fi
 rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
 rmdir conf$$.dir 2>/dev/null
@@ -503,28 +543,8 @@ else
   as_mkdir_p=3Dfalse
 fi
=20
-if test -x / >/dev/null 2>&1; then
-  as_test_x=3D'test -x'
-else
-  if ls -dL / >/dev/null 2>&1; then
-    as_ls_L_option=3DL
-  else
-    as_ls_L_option=3D
-  fi
-  as_test_x=3D'
-    eval sh -c '\''
-      if test -d "$1"; then
-	test -d "$1/.";
-      else
-	case $1 in #(
-	-*)set "./$1";;
-	esac;
-	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
-	???[sx]*):;;*)false;;esac;fi
-    '\'' sh
-  '
-fi
-as_executable_p=3D$as_test_x
+as_test_x=3D'test -x'
+as_executable_p=3Das_fn_executable_p
=20
 # Sed expression to map a string onto a valid CPP name.
 as_tr_cpp=3D"eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnu=
m]%_%g'"
@@ -565,10 +585,14 @@ ac_unique_file=3D"mount.cc"
 ac_no_link=3Dno
 ac_subst_vars=3D'LTLIBOBJS
 LIBOBJS
+configure_args
 MINGW_CXX
 INSTALL_DATA
 INSTALL_SCRIPT
 INSTALL_PROGRAM
+cygwin_headers
+newlib_headers
+windows_headers
 ac_ct_CXX
 CXXFLAGS
 CXX
@@ -591,6 +615,7 @@ build_os
 build_vendor
 build_cpu
 build
+windows_libdir
 target_alias
 host_alias
 build_alias
@@ -628,10 +653,14 @@ PACKAGE_VERSION
 PACKAGE_TARNAME
 PACKAGE_NAME
 PATH_SEPARATOR
-SHELL'
+SHELL
+winsup_srcdir
+target_builddir'
 ac_subst_files=3D''
 ac_user_opts=3D'
 enable_option_checking
+with_windows_headers
+with_windows_libs
 '
       ac_precious_vars=3D'build_alias
 host_alias
@@ -1099,8 +1128,6 @@ target=3D$target_alias
 if test "x$host_alias" !=3D x; then
   if test "x$build_alias" =3D x; then
     cross_compiling=3Dmaybe
-    $as_echo "$as_me: WARNING: if you wanted to set the --build type, don'=
t use --host.
-    If a cross compiler is detected then cross compile mode will be used" =
>&2
   elif test "x$build_alias" !=3D "x$host_alias"; then
     cross_compiling=3Dyes
   fi
@@ -1259,6 +1286,13 @@ if test -n "$ac_init_help"; then
=20
   cat <<\_ACEOF
=20
+Optional Packages:
+  --with-PACKAGE[=3DARG]    use PACKAGE [ARG=3Dyes]
+  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=3Dno)
+  --with-windows-headers=3DDIR
+                          specify where the windows includes are located
+  --with-windows-libs=3DDIR specify where the windows libraries are located
+
 Some influential environment variables:
   CC          C compiler command
   CFLAGS      C compiler flags
@@ -1337,9 +1371,9 @@ test -n "$ac_init_help" && exit $ac_stat
 if $ac_init_version; then
   cat <<\_ACEOF
 configure
-generated by GNU Autoconf 2.68
+generated by GNU Autoconf 2.69
=20
-Copyright (C) 2010 Free Software Foundation, Inc.
+Copyright (C) 2012 Free Software Foundation, Inc.
 This configure script is free software; the Free Software Foundation
 gives unlimited permission to copy, distribute and modify it.
 _ACEOF
@@ -1430,7 +1464,7 @@ This file contains any messages produced
 running configure, to aid debugging if configure makes a mistake.
=20
 It was created by $as_me, which was
-generated by GNU Autoconf 2.68.  Invocation command line was
+generated by GNU Autoconf 2.69.  Invocation command line was
=20
   $ $0 $@
=20
@@ -1808,6 +1842,37 @@ ac_configure=3D"$SHELL $ac_aux_dir/configu
=20
=20
=20
+
+. ${srcdir}/../configure.cygwin
+
+
+
+# Check whether --with-windows-headers was given.
+if test "${with_windows_headers+set}" =3D set; then :
+  withval=3D$with_windows_headers; test -z "$withval" && as_fn_error $? "m=
ust specify value for --with-windows-headers" "$LINENO" 5
+
+fi
+
+
+
+
+# Check whether --with-windows-libs was given.
+if test "${with_windows_libs+set}" =3D set; then :
+  withval=3D$with_windows_libs; test -z "$withval" && as_fn_error $? "must=
 specify value for --with-windows-libs" "$LINENO" 5
+
+fi
+
+windows_libdir=3D$(cd "$with_windows_libs" 2>/dev/null && pwd)
+if test -z "$windows_libdir"; then
+    windows_libdir=3D$(cd $(dirname $($ac_cv_prog_CC -print-file-name=3Dli=
bcygwin.a))/w32api 2>&1 && pwd)
+    if ! test -z "$windows_libdir"; then
+	as_fn_error $? "cannot find windows library files" "$LINENO" 5
+    fi
+fi
+
+
+
+
 # Make sure we can run config.sub.
 $SHELL "$ac_aux_dir/config.sub" sun4 >/dev/null 2>&1 ||
   as_fn_error $? "cannot run $SHELL $ac_aux_dir/config.sub" "$LINENO" 5
@@ -1920,99 +1985,6 @@ test -n "$target_alias" &&
   program_prefix=3D${target_alias}-
=20
=20
-if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}gcc", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}gcc; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_CC+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CC"; then
-  ac_cv_prog_CC=3D"$CC" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CC=3D"${ac_tool_prefix}gcc"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CC=3D$ac_cv_prog_CC
-if test -n "$CC"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CC" >&5
-$as_echo "$CC" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CC"; then
-  ac_ct_CC=3D$CC
-  # Extract the first word of "gcc", so it can be a program name with args.
-set dummy gcc; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_ac_ct_CC+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CC"; then
-  ac_cv_prog_ac_ct_CC=3D"$ac_ct_CC" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CC=3D"gcc"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CC=3D$ac_cv_prog_ac_ct_CC
-if test -n "$ac_ct_CC"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CC" >&5
-$as_echo "$ac_ct_CC" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CC" =3D x; then
-    CC=3D"gcc"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CC=3D$ac_ct_CC
-  fi
-else
-  CC=3D"$ac_cv_prog_CC"
-fi
-
-: ${CC:=3Dgcc}
 ac_ext=3Dc
 ac_cpp=3D'$CPP $CPPFLAGS'
 ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -2035,7 +2007,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"${ac_tool_prefix}gcc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2075,7 +2047,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CC=3D"gcc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2128,7 +2100,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"${ac_tool_prefix}cc"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2169,7 +2141,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     if test "$as_dir/$ac_word$ac_exec_ext" =3D "/usr/ucb/cc"; then
        ac_prog_rejected=3Dyes
        continue
@@ -2227,7 +2199,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CC=3D"$ac_tool_prefix$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2271,7 +2243,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CC=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -2793,8 +2765,7 @@ cat confdefs.h - <<_ACEOF >conftest.$ac_
 /* end confdefs.h.  */
 #include <stdarg.h>
 #include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
+struct stat;
 /* Most of the following tests are stolen from RCS 5.7's src/conf.sh.  */
 struct buf { int x; };
 FILE * (*rcsopen) (struct buf *, struct stat *, int);
@@ -2879,195 +2850,7 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-test -z "$CC" && as_fn_error $? "no acceptable cc found in \$PATH" "$LINEN=
O" 5
-
-if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}g++", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_CXX+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CXX"; then
-  ac_cv_prog_CXX=3D"$CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CXX=3D"${ac_tool_prefix}g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CXX=3D$ac_cv_prog_CXX
-if test -n "$CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CXX" >&5
-$as_echo "$CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CXX"; then
-  ac_ct_CXX=3D$CXX
-  # Extract the first word of "g++", so it can be a program name with args.
-set dummy g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_ac_ct_CXX+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CXX"; then
-  ac_cv_prog_ac_ct_CXX=3D"$ac_ct_CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CXX=3D"g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CXX=3D$ac_cv_prog_ac_ct_CXX
-if test -n "$ac_ct_CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CXX" >&5
-$as_echo "$ac_ct_CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CXX" =3D x; then
-    CXX=3D"g++"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CXX=3D$ac_ct_CXX
-  fi
-else
-  CXX=3D"$ac_cv_prog_CXX"
-fi
-
-if test -z "$CXX"; then
-  if test -n "$ac_tool_prefix"; then
-  # Extract the first word of "${ac_tool_prefix}g++", so it can be a progr=
am name with args.
-set dummy ${ac_tool_prefix}g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_CXX+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$CXX"; then
-  ac_cv_prog_CXX=3D"$CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_CXX=3D"${ac_tool_prefix}g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-CXX=3D$ac_cv_prog_CXX
-if test -n "$CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $CXX" >&5
-$as_echo "$CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-
-fi
-if test -z "$ac_cv_prog_CXX"; then
-  ac_ct_CXX=3D$CXX
-  # Extract the first word of "g++", so it can be a program name with args.
-set dummy g++; ac_word=3D$2
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
-$as_echo_n "checking for $ac_word... " >&6; }
-if ${ac_cv_prog_ac_ct_CXX+:} false; then :
-  $as_echo_n "(cached) " >&6
-else
-  if test -n "$ac_ct_CXX"; then
-  ac_cv_prog_ac_ct_CXX=3D"$ac_ct_CXX" # Let the user override the test.
-else
-as_save_IFS=3D$IFS; IFS=3D$PATH_SEPARATOR
-for as_dir in $PATH
-do
-  IFS=3D$as_save_IFS
-  test -z "$as_dir" && as_dir=3D.
-    for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
-    ac_cv_prog_ac_ct_CXX=3D"g++"
-    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
-    break 2
-  fi
-done
-  done
-IFS=3D$as_save_IFS
-
-fi
-fi
-ac_ct_CXX=3D$ac_cv_prog_ac_ct_CXX
-if test -n "$ac_ct_CXX"; then
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_ct_CXX" >&5
-$as_echo "$ac_ct_CXX" >&6; }
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-
-  if test "x$ac_ct_CXX" =3D x; then
-    CXX=3D"c++"
-  else
-    case $cross_compiling:$ac_tool_warned in
-yes:)
-{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not pr=
efixed with host triplet" >&5
-$as_echo "$as_me: WARNING: using cross tools not prefixed with host triple=
t" >&2;}
-ac_tool_warned=3Dyes ;;
-esac
-    CXX=3D$ac_ct_CXX
-  fi
-else
-  CXX=3D"$ac_cv_prog_CXX"
-fi
-
-  : ${CXX:=3Dg++}
-  ac_ext=3Dcpp
+ac_ext=3Dcpp
 ac_cpp=3D'$CXXCPP $CPPFLAGS'
 ac_compile=3D'$CXX -c $CXXFLAGS $CPPFLAGS conftest.$ac_ext >&5'
 ac_link=3D'$CXX -o conftest$ac_exeext $CXXFLAGS $CPPFLAGS $LDFLAGS conftes=
t.$ac_ext $LIBS >&5'
@@ -3095,7 +2878,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_CXX=3D"$ac_tool_prefix$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3139,7 +2922,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_ac_ct_CXX=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3324,10 +3107,44 @@ ac_compile=3D'$CC -c $CFLAGS $CPPFLAGS con
 ac_link=3D'$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$=
ac_ext $LIBS >&5'
 ac_compiler_gnu=3D$ac_cv_c_compiler_gnu
=20
-  test -z "$CC" && as_fn_error $? "no acceptable cc found in \$PATH" "$LIN=
ENO" 5
+
+
+addto_CPPFLAGS -nostdinc
+: ${ac_cv_prog_CXX:=3D$CXX}
+: ${ac_cv_prog_CC:=3D$CC}
+
+cygwin_headers=3D$(cd "$winsup_srcdir/cygwin/include" 2>/dev/null && pwd)
+if test -z "$cygwin_headers"; then
+    as_fn_error $? "cannot find $winsup_srcdir/cygwin/include directory" "=
$LINENO" 5
 fi
=20
-CXXFLAGS=3D'$(CFLAGS)'
+newlib_headers=3D$(cd $winsup_srcdir/../newlib/libc/include 2>/dev/null &&=
 pwd)
+if test -z "$newlib_headers"; then
+    as_fn_error $? "cannot find newlib source directory: $winsup_srcdir/..=
/newlib/libc/include" "$LINENO" 5
+fi
+newlib_headers=3D"$target_builddir/newlib/targ-include $newlib_headers"
+
+if test -n "$with_windows_headers"; then
+    if test -e "$with_windows_headers/windef.h"; then
+	windows_headers=3D"$with_windows_headers"
+    else
+	as_fn_error $? "cannot find windef.h in specified --with-windows-headers =
path: $saw_windows_headers" "$LINENO" 5;
+    fi
+elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
+    windows_headers=3D"$winsup_srcdir/w32api/include"
+else
+    windows_headers=3D$(cd $($ac_cv_prog_CC -xc /dev/null -E -include wind=
ef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1=
) 2>/dev/null && pwd)
+    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
+	as_fn_error $? "cannot find windows header files" "$LINENO" 5
+    fi
+fi
+CC=3D$ac_cv_prog_CC
+CXX=3D$ac_cv_prog_CXX
+export CC
+export CXX
+
+
+
=20
=20
 test "$program_prefix" !=3D NONE &&
@@ -3341,8 +3158,6 @@ ac_script=3D's/[\\$]/&&/g;s/;s,x,x,$//'
 program_transform_name=3D`$as_echo "$program_transform_name" | sed "$ac_sc=
ript"`
=20
=20
-INSTALL=3D"/bin/sh "`cd $srcdir/../..; echo $(pwd)/install-sh -c`
-
 # Find a good install program.  We prefer a C program (faster),
 # so one script is as good as another.  But avoid the broken or
 # incompatible versions:
@@ -3380,7 +3195,7 @@ case $as_dir/ in #((
     # by default.
     for ac_prog in ginstall scoinst install; do
       for ac_exec_ext in '' $ac_executable_extensions; do
-	if { test -f "$as_dir/$ac_prog$ac_exec_ext" && $as_test_x "$as_dir/$ac_pr=
og$ac_exec_ext"; }; then
+	if as_fn_executable_p "$as_dir/$ac_prog$ac_exec_ext"; then
 	  if test $ac_prog =3D install &&
 	    grep dspmsg "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
 	    # AIX install.  It has an incompatible calling convention.
@@ -3455,7 +3270,7 @@ do
   IFS=3D$as_save_IFS
   test -z "$as_dir" && as_dir=3D.
     for ac_exec_ext in '' $ac_executable_extensions; do
-  if { test -f "$as_dir/$ac_word$ac_exec_ext" && $as_test_x "$as_dir/$ac_w=
ord$ac_exec_ext"; }; then
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
     ac_cv_prog_MINGW_CXX=3D"$ac_prog"
     $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_=
ext" >&5
     break 2
@@ -3479,7 +3294,18 @@ fi
   test -n "$MINGW_CXX" && break
 done
=20
-test -z "$MINGW_CXX" && as_fn_error $? "no acceptable mingw g++ found in \=
$PATH" "$LINENO" 5
+test -n "$MINGW_CXX" || as_fn_error $? "no acceptable mingw g++ found in \=
$PATH" "$LINENO" 5
+
+
+
+configure_args=3DX
+for f in $ac_configure_args; do
+    case "$f" in
+	*--srcdir*) ;;
+	*) configure_args=3D"$configure_args $f" ;;
+    esac
+done
+configure_args=3D$(/usr/bin/expr "$configure_args" : 'X \(.*\)')
=20
=20
 ac_config_files=3D"$ac_config_files Makefile"
@@ -3927,16 +3753,16 @@ if (echo >conf$$.file) 2>/dev/null; then
     # ... but there are two gotchas:
     # 1) On MSYS, both `ln -s file dir' and `ln file dir' fail.
     # 2) DJGPP < 2.04 has no symlinks; `ln -s' creates a wrapper executabl=
e.
-    # In both cases, we have to default to `cp -p'.
+    # In both cases, we have to default to `cp -pR'.
     ln -s conf$$.file conf$$.dir 2>/dev/null && test ! -f conf$$.exe ||
-      as_ln_s=3D'cp -p'
+      as_ln_s=3D'cp -pR'
   elif ln conf$$.file conf$$ 2>/dev/null; then
     as_ln_s=3Dln
   else
-    as_ln_s=3D'cp -p'
+    as_ln_s=3D'cp -pR'
   fi
 else
-  as_ln_s=3D'cp -p'
+  as_ln_s=3D'cp -pR'
 fi
 rm -f conf$$ conf$$.exe conf$$.dir/conf$$.file conf$$.file
 rmdir conf$$.dir 2>/dev/null
@@ -3996,28 +3822,16 @@ else
   as_mkdir_p=3Dfalse
 fi
=20
-if test -x / >/dev/null 2>&1; then
-  as_test_x=3D'test -x'
-else
-  if ls -dL / >/dev/null 2>&1; then
-    as_ls_L_option=3DL
-  else
-    as_ls_L_option=3D
-  fi
-  as_test_x=3D'
-    eval sh -c '\''
-      if test -d "$1"; then
-	test -d "$1/.";
-      else
-	case $1 in #(
-	-*)set "./$1";;
-	esac;
-	case `ls -ld'$as_ls_L_option' "$1" 2>/dev/null` in #((
-	???[sx]*):;;*)false;;esac;fi
-    '\'' sh
-  '
-fi
-as_executable_p=3D$as_test_x
+
+# as_fn_executable_p FILE
+# -----------------------
+# Test if FILE is an executable regular file.
+as_fn_executable_p ()
+{
+  test -f "$1" && test -x "$1"
+} # as_fn_executable_p
+as_test_x=3D'test -x'
+as_executable_p=3Das_fn_executable_p
=20
 # Sed expression to map a string onto a valid CPP name.
 as_tr_cpp=3D"eval sed 'y%*$as_cr_letters%P$as_cr_LETTERS%;s%[^_$as_cr_alnu=
m]%_%g'"
@@ -4039,7 +3853,7 @@ cat >>$CONFIG_STATUS <<\_ACEOF || ac_wri
 # values after options handling.
 ac_log=3D"
 This file was extended by $as_me, which was
-generated by GNU Autoconf 2.68.  Invocation command line was
+generated by GNU Autoconf 2.69.  Invocation command line was
=20
   CONFIG_FILES    =3D $CONFIG_FILES
   CONFIG_HEADERS  =3D $CONFIG_HEADERS
@@ -4092,10 +3906,10 @@ cat >>$CONFIG_STATUS <<_ACEOF || ac_writ
 ac_cs_config=3D"`$as_echo "$ac_configure_args" | sed 's/^ //; s/[\\""\`\$]=
/\\\\&/g'`"
 ac_cs_version=3D"\\
 config.status
-configured by $0, generated by GNU Autoconf 2.68,
+configured by $0, generated by GNU Autoconf 2.69,
   with options \\"\$ac_cs_config\\"
=20
-Copyright (C) 2010 Free Software Foundation, Inc.
+Copyright (C) 2012 Free Software Foundation, Inc.
 This config.status script is free software; the Free Software Foundation
 gives unlimited permission to copy, distribute and modify it."
=20
@@ -4173,7 +3987,7 @@ fi
 _ACEOF
 cat >>$CONFIG_STATUS <<_ACEOF || ac_write_fail=3D1
 if \$ac_cs_recheck; then
-  set X '$SHELL' '$0' $ac_configure_args \$ac_configure_extra_args --no-cr=
eate --no-recursion
+  set X $SHELL '$0' $ac_configure_args \$ac_configure_extra_args --no-crea=
te --no-recursion
   shift
   \$as_echo "running CONFIG_SHELL=3D$SHELL \$*" >&6
   CONFIG_SHELL=3D'$SHELL'
Index: utils/configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/utils/configure.in,v
retrieving revision 1.11
diff -d -u -p -r1.11 configure.in
--- utils/configure.in	24 Oct 2012 12:45:09 -0000	1.11
+++ utils/configure.in	13 Nov 2012 18:15:24 -0000
@@ -14,19 +14,26 @@ AC_INIT(mount.cc)
 AC_CONFIG_AUX_DIR(../..)
=20
 AC_NO_EXECUTABLES
+
+. ${srcdir}/../configure.cygwin
+
+AC_WINDOWS_HEADERS
+AC_WINDOWS_LIBS
+
 AC_CANONICAL_SYSTEM
=20
-LIB_AC_PROG_CC
-LIB_AC_PROG_CXX
+AC_PROG_CC
+AC_PROG_CXX
=20
-AC_ARG_PROGRAM
+AC_CYGWIN_INCLUDES
=20
-INSTALL=3D"/bin/sh "`cd $srcdir/../..; echo $(pwd)/install-sh -c`
+AC_ARG_PROGRAM
=20
 AC_PROG_INSTALL
=20
 AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)
-test -z "$MINGW_CXX" && AC_MSG_ERROR([no acceptable mingw g++ found in \$P=
ATH])
+test -n "$MINGW_CXX" || AC_MSG_ERROR([no acceptable mingw g++ found in \$P=
ATH])
=20
 AC_EXEEXT
+AC_CONFIGURE_ARGS
 AC_OUTPUT(Makefile)
Index: utils/dump_setup.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/uberbaum/winsup/utils/dump_setup.cc,v
retrieving revision 1.24
diff -d -u -p -r1.24 dump_setup.cc
--- utils/dump_setup.cc	11 Jul 2012 16:41:51 -0000	1.24
+++ utils/dump_setup.cc	13 Nov 2012 18:15:24 -0000
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
=20
 static int package_len =3D 20;
 static unsigned int version_len =3D 10;
