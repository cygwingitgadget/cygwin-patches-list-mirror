Return-Path: <cygwin-patches-return-7728-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30494 invoked by alias); 18 Oct 2012 07:33:27 -0000
Received: (qmail 30483 invoked by uid 22791); 18 Oct 2012 07:33:26 -0000
X-SWARE-Spam-Status: No, hits=-5.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_DB,TW_XD,TW_YG
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f171.google.com (HELO mail-ie0-f171.google.com) (209.85.223.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 18 Oct 2012 07:33:16 +0000
Received: by mail-ie0-f171.google.com with SMTP id s9so14099814iec.2        for <cygwin-patches@cygwin.com>; Thu, 18 Oct 2012 00:33:15 -0700 (PDT)
Received: by 10.43.7.132 with SMTP id oo4mr16490303icb.6.1350545595021;        Thu, 18 Oct 2012 00:33:15 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id eo7sm11381250igc.12.2012.10.18.00.33.13        (version=TLSv1/SSLv3 cipher=OTHER);        Thu, 18 Oct 2012 00:33:14 -0700 (PDT)
Message-ID: <1350545597.3492.59.camel@YAAKOV04>
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Thu, 18 Oct 2012 07:33:00 -0000
In-Reply-To: <20121017193258.GA15271@ednor.casa.cgf.cx>
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>	 <20121017164440.GA12989@ednor.casa.cgf.cx>	 <20121017170514.GD10578@calimero.vinschen.de>	 <20121017193258.GA15271@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="=-G/EA7s7N1O4ttU/HD316"
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00005.txt.bz2


--=-G/EA7s7N1O4ttU/HD316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1254

On Wed, 2012-10-17 at 15:32 -0400, Christopher Faylor wrote:
> But, anyway, nevermind.  This shouldn't be a requirement for getting
> these changes checked in.  I'm more concerned with just nuking the
> now-unneeded mingw script.

Draft patch attached, based partially on Kai's.  Yes, it needs a
ChangeLog entry, but it also needs more testing first.

On Cygwin, you need either mingw-gcc-g++ and mingw-zlib, or
mingw64-i686-gcc-g++ with Ports' mingw64-i686-zlib, available here:

ftp://ftp.cygwinports.org/pub/cygwinports/release-2/CrossDevel/mingw64-i686-zlib/

On Fedora, you need my cygwin-gcc-c++ plus mingw32-gcc-c++ and
mingw32-zlib-static.  Unfortunately F17's mingw32-headers isn't
(aren't?) new enough, so two files in winsup/utils wouldn't compile
until I manually upgraded to
mingw32-headers-2.0.999-0.13.trunk.20121016.fc19.noarch.rpm from
rawhide.  F16 (which uses the mingw.org toolchain) should also be okay.

Apply the patch, rm -r winsup/mingw/ winsup/w32api/ winsup/utils/mingw,
run autoconf in winsup/utils, then configure and build.  Tested so far
with CVS HEAD on Cygwin and Fedora 17 (with the aforementioned issue)
with our new w32api and the i686-w64-mingw32 toolchain; I have NOT yet
tested the resulting cygwin1.dll.


Yaakov


--=-G/EA7s7N1O4ttU/HD316
Content-Disposition: attachment; filename="cygwin-external-mingw.patch"
Content-Type: text/x-patch; name="cygwin-external-mingw.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 12718

Index: configure
===================================================================
RCS file: /cvs/src/src/configure,v
retrieving revision 1.430
diff -u -p -r1.430 configure
--- configure	29 Sep 2012 15:35:52 -0000	1.430
+++ configure	18 Oct 2012 05:50:52 -0000
@@ -7207,7 +7207,7 @@ case " $target_configdirs " in
   *" --with-newlib "*)
    case "$target" in
     *-cygwin*)
-      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include -isystem $$s/winsup/w32api/include'
+      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include'
       ;;
    esac
 
Index: configure.ac
===================================================================
RCS file: /cvs/src/src/configure.ac,v
retrieving revision 1.174
diff -u -p -r1.174 configure.ac
--- configure.ac	29 Sep 2012 15:35:53 -0000	1.174
+++ configure.ac	18 Oct 2012 05:50:52 -0000
@@ -2801,7 +2801,7 @@ case " $target_configdirs " in
   *" --with-newlib "*)
    case "$target" in
     *-cygwin*)
-      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include -isystem $$s/winsup/w32api/include'
+      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include'
       ;;
    esac
 
Index: winsup/Makefile.common
===================================================================
RCS file: /cvs/src/src/winsup/Makefile.common,v
retrieving revision 1.59
diff -u -p -r1.59 Makefile.common
--- winsup/Makefile.common	30 Jul 2012 04:43:21 -0000	1.59
+++ winsup/Makefile.common	18 Oct 2012 05:50:53 -0000
@@ -72,38 +72,20 @@ ifeq (,${findstring $(cygwin_source)/inc
 cygwin_include:=-I$(cygwin_source)/include
 endif
 
-# Try to determine what directories are available in winsup.
-# Attempt to properly detect missing mingw or w32api and adjust command
-# line parameters appropriately
-
-# nostdinc:=${shell [ -d "$(updir)/w32api" ] && echo "-nostdinc"}
-# ifneq (,$(nostdinc))
-nostdincxx:=-nostdinc++
-# ifeq (,${findstring $(w32api_source),$(CFLAGS) $(CXXFLAGS) $(CXX) $(CC)})
-w32api_include:=-I$(w32api_source)/include
-# endif
-# endif
-
-mingw_include:=${shell [ -d "$(mingw_source)/include" ] && echo "-I$(mingw_source)/include"}
-ifneq (,$(mingw_include))
 nostdlib:=-nostdlib
-else
-nostdlib:=
-endif
 
 ifeq (,${nostdlib})
 nostdinc:=
 endif
 
-INCLUDES:=-I. $(cygwin_include) -I$(cygwin_source) $(newlib_include) $(w32api_include)
+INCLUDES:=-I. $(cygwin_include) -I$(cygwin_source) $(newlib_include)
 ifdef CONFIG_DIR
 INCLUDES+=-I$(CONFIG_DIR)
 endif
 
-MINGW_INCLUDES:=${mingw_include} $(w32api_include)
-MINGW_CFLAGS:=-mno-cygwin $(MINGW_INCLUDES)
-MINGW_CXXFLAGS:=${filter-out $(newlib_source)/%,$(CXXFLAGS)} -mno-cygwin $(MINGW_INCLUDES)
-MINGW_LDFLAGS:=-L${mingw_build} -L${mingw_build}/mingwex
+MINGW_LDFLAGS:=-static
+MINGW_CFLAGS:=
+MINGW_CXXFLAGS:=
 
 GCC_DEFAULT_OPTIONS:=$(CFLAGS_COMMON) $(CFLAGS_CONFIG) $(INCLUDES)
 
@@ -134,7 +117,7 @@ COMPILE_CXX=$(CXX) $c $(if $($(*F)_STDIN
 	     $(ALL_CXXFLAGS) $(GCC_INCLUDE) -fno-rtti -fno-exceptions
 COMPILE_CC=$(CC) $c $(if $($(*F)_STDINCFLAGS),,$(nostdinc)) $(ALL_CFLAGS) $(GCC_INCLUDE)
 
-vpath %.a	$(cygwin_build):$(w32api_lib):$(newlib_build)/libc:$(newlib_build)/libm
+vpath %.a	$(cygwin_build):$(newlib_build)/libc:$(newlib_build)/libm
 
 MAKEOVERRIDES_WORKAROUND=${wordlist 2,1,a b c}
 
Index: winsup/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/Makefile.in,v
retrieving revision 1.33
diff -u -p -r1.33 Makefile.in
--- winsup/Makefile.in	24 Feb 2009 02:11:13 -0000	1.33
+++ winsup/Makefile.in	18 Oct 2012 05:50:53 -0000
@@ -121,20 +121,20 @@ check: cygwin
 	fi; \
 	$(MAKE) check
 
-utils: cygwin mingw
+utils: cygwin
 
 mingw: w32api
 
-cygwin: w32api
+cygwin:
 
 cygserver: cygwin
 
-install_utils: cygwin mingw
+install_utils: cygwin
 
 install_mingw: w32api
 
-install_cygwin: w32api
+install_cygwin:
 
 install_cygserver: cygwin
 
-lsaauth: mingw cygwin
+lsaauth: cygwin
Index: winsup/configure.in
===================================================================
RCS file: /cvs/src/src/winsup/configure.in,v
retrieving revision 1.33
diff -u -p -r1.33 configure.in
--- winsup/configure.in	29 Jan 2011 06:41:28 -0000	1.33
+++ winsup/configure.in	18 Oct 2012 05:50:53 -0000
@@ -45,7 +45,10 @@ esac
 if test -d $srcdir/mingw; then
   AC_CONFIG_SUBDIRS(mingw)
 fi
-AC_CONFIG_SUBDIRS(w32api cygserver)
+if test -d $srcdir/w32api; then
+  AC_CONFIG_SUBDIRS(w32api)
+fi
+AC_CONFIG_SUBDIRS(cygserver)
 
 case "$with_cross_host" in
   ""|*cygwin*)
Index: winsup/cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.257
diff -u -p -r1.257 Makefile.in
--- winsup/cygwin/Makefile.in	1 Aug 2012 08:46:49 -0000	1.257
+++ winsup/cygwin/Makefile.in	18 Oct 2012 05:50:53 -0000
@@ -130,7 +130,7 @@ EXTRA_OFILES:=
 
 MALLOC_OFILES:=@MALLOC_OFILES@
 
-DLL_IMPORTS:=$(w32api_lib)/libkernel32.a $(w32api_lib)/libntdll.a
+DLL_IMPORTS:=`$(CC) -print-file-name=w32api/libkernel32.a` `$(CC) -print-file-name=w32api/libntdll.a`
 
 MT_SAFE_OBJECTS:=
 #
@@ -395,7 +395,7 @@ maintainer-clean realclean: clean
 
 
 # Rule to build cygwin.dll
-$(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(DLL_IMPORTS) $(LIBSERVER) $(LIBC) $(LIBM) $(API_VER) Makefile winver_stamp
+$(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(LIBSERVER) $(LIBC) $(LIBM) $(API_VER) Makefile winver_stamp
 	$(CXX) $(CXXFLAGS) -Wl,--gc-sections $(nostdlib) -Wl,-T$(firstword $^) -static \
 	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
 	-e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) version.o winver.o \
Index: winsup/lsaauth/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/lsaauth/Makefile.in,v
retrieving revision 1.6
diff -u -p -r1.6 Makefile.in
--- winsup/lsaauth/Makefile.in	29 May 2012 12:46:01 -0000	1.6
+++ winsup/lsaauth/Makefile.in	18 Oct 2012 05:50:54 -0000
@@ -33,7 +33,7 @@ CFLAGS          := @CFLAGS@
 
 include $(srcdir)/../Makefile.common
 
-WIN32_INCLUDES  := -I. -I$(srcdir) $(w32api_include) $(w32api_include)/ddk
+WIN32_INCLUDES  := -I. -I$(srcdir)
 WIN32_CFLAGS    := $(CFLAGS) $(WIN32_COMMON) $(WIN32_INCLUDES)
 WIN32_LDFLAGS	:= $(CFLAGS) $(WIN32_COMMON) -nostdlib -Wl,-shared
 
Index: winsup/utils/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.100
diff -u -p -r1.100 Makefile.in
--- winsup/utils/Makefile.in	11 Jul 2012 16:41:51 -0000	1.100
+++ winsup/utils/Makefile.in	18 Oct 2012 05:50:54 -0000
@@ -40,15 +40,11 @@ include $(srcdir)/../Makefile.common
 .NOEXPORT:
 .PHONY: all install clean realclean warn_dumper warn_cygcheck_zlib
 
-ALL_LDLIBS     := -lnetapi32 -ladvapi32
-ALL_LDFLAGS    := -static-libgcc -Wl,--enable-auto-import -B$(newlib_build)/libc -B$(w32api_lib) $(LDFLAGS) $(ALL_LDLIBS)
-ALL_DEP_LDLIBS := $(cygwin_build)/libcygwin.a ${patsubst -l%,\
-                    $(w32api_lib)/lib%.a,$(ALL_LDLIBS) -lkernel32 -luser32}
-
-MINGW_LIB        := $(mingw_build)/libmingw32.a
-MINGW_LDLIBS     := $(ALL_LDLIBS) $(MINGW_LIB)
-MINGW_DEP_LDLIBS := $(ALL_DEP_LDLIBS) $(MINGW_LIB)
-MINGW_CXX        := ${srcdir}/mingw ${CXX} -I${updir}
+ALL_LDLIBS     := -lnetapi32 -ladvapi32 -lkernel32 -luser32
+ALL_LDFLAGS    := -static-libgcc -Wl,--enable-auto-import -B$(newlib_build)/libc $(LDFLAGS) $(ALL_LDLIBS)
+ALL_DEP_LDLIBS := $(cygwin_build)/libcygwin.a
+
+MINGW_CXX      := @MINGW_CXX@
 
 # List all binaries to be linked in Cygwin mode.  Each binary on this list
 # must have a corresponding .o of the same name.
@@ -74,6 +70,7 @@ path-mount.o: path.cc
 mount.exe: path-mount.o
 
 # Provide any necessary per-target variable overrides.
+cygcheck.exe: MINGW_CXXFLAGS += -idirafter $(cygwin_source)/include -idirafter $(newlib_source)/libc/include
 cygcheck.exe: MINGW_LDFLAGS += -lpsapi -lntdll
 cygpath.exe: ALL_LDFLAGS += -lcygwin -luserenv -lntdll
 cygpath.exe: CXXFLAGS += -fno-threadsafe-statics
@@ -83,7 +80,6 @@ strace.exe: MINGW_LDFLAGS += -lntdll
 ldd.exe: ALL_LDFLAGS += -lpsapi
 pldd.exe: ALL_LDFLAGS += -lpsapi
 
-ldh.exe: MINGW_LDLIBS :=
 ldh.exe: MINGW_LDFLAGS := -nostdlib -lkernel32
 
 # Check for dumper's requirements and enable it if found.
@@ -105,7 +101,7 @@ endif
 # Check for availability of a MinGW libz and enable for cygcheck.
 libz:=${shell x=$$(${MINGW_CXX} --print-file-name=libz.a); cd $$(dirname $$x); dir=$$(pwd); case "$$dir" in *mingw*) echo $$dir/libz.a ;; esac}
 ifdef libz
-zlib_h  := -include ${patsubst %/lib/mingw/libz.a,%/include/zlib.h,${patsubst %/lib/libz.a,%/include/zlib.h,$(libz)}}
+zlib_h  := -include ${patsubst %/lib/libz.a,%/include/zlib.h,$(libz)}
 zconf_h := ${patsubst %/zlib.h,%/zconf.h,$(zlib_h)}
 dump_setup.o: MINGW_CXXFLAGS += $(zconf_h) $(zlib_h)
 cygcheck.exe: MINGW_LDFLAGS += $(libz)
@@ -160,7 +156,7 @@ endif
 # note: how to compile a Cygwin object is covered by the pattern rule in Makefile.common
 
 # these dependencies ensure that the required in-tree libs are built first
-$(MINGW_BINS): $(MINGW_DEP_LDLIBS)
+$(MINGW_BINS): $(ALL_DEP_LDLIBS)
 $(CYGWIN_BINS): $(ALL_DEP_LDLIBS)
 
 clean:
@@ -179,9 +175,6 @@ install: all
 $(cygwin_build)/libcygwin.a: $(cygwin_build)/Makefile
 	@$(MAKE) -C $(@D) $(@F)
 
-$(MINGW_LIB): $(mingw_build)/Makefile
-	@$(MAKE) -C $(@D) $(@F)
-
 warn_dumper:
 	@echo '*** Not building dumper.exe since some required libraries or'
 	@echo '*** or headers are missing.  Potential candidates are:'
Index: winsup/utils/configure.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/configure.in,v
retrieving revision 1.9
diff -u -p -r1.9 configure.in
--- winsup/utils/configure.in	25 Jul 2008 15:03:25 -0000	1.9
+++ winsup/utils/configure.in	18 Oct 2012 05:50:55 -0000
@@ -27,5 +27,7 @@ INSTALL="/bin/sh "`cd $srcdir/../..; ech
 
 AC_PROG_INSTALL
 
+AC_CHECK_PROGS(MINGW_CXX, i686-w64-mingw32-g++ i686-pc-mingw32-g++)
+
 AC_EXEEXT
 AC_OUTPUT(Makefile)
Index: winsup/utils/cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.135
diff -u -p -r1.135 cygcheck.cc
--- winsup/utils/cygcheck.cc	9 Oct 2012 12:47:40 -0000	1.135
+++ winsup/utils/cygcheck.cc	18 Oct 2012 05:50:55 -0000
@@ -22,11 +22,10 @@
 #include "path.h"
 #include "wide_path.h"
 #include <getopt.h>
-#include "cygwin/include/cygwin/version.h"
-#include "cygwin/include/sys/cygwin.h"
-#include "cygwin/include/mntent.h"
-#include "cygwin/cygprops.h"
-#include "cygwin/version.h"
+#include "../cygwin/include/cygwin/version.h"
+#include "../cygwin/include/sys/cygwin.h"
+#include "../cygwin/include/mntent.h"
+#include "../cygwin/cygprops.h"
 #undef cygwin_internal
 #include "loadlib.h"
 
Index: winsup/utils/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/path.cc,v
retrieving revision 1.31
diff -u -p -r1.31 path.cc
--- winsup/utils/path.cc	17 Dec 2011 23:39:47 -0000	1.31
+++ winsup/utils/path.cc	18 Oct 2012 05:50:55 -0000
@@ -23,9 +23,9 @@ details. */
 #include <malloc.h>
 #include <wchar.h>
 #include "path.h"
-#include "cygwin/include/cygwin/version.h"
-#include "cygwin/include/sys/mount.h"
-#include "cygwin/include/mntent.h"
+#include "../cygwin/include/cygwin/version.h"
+#include "../cygwin/include/sys/mount.h"
+#include "../cygwin/include/mntent.h"
 #include "testsuite.h"
 #ifdef FSTAB_ONLY
 #include <sys/cygwin.h>
Index: winsup/utils/strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/strace.cc,v
retrieving revision 1.64
diff -u -p -r1.64 strace.cc
--- winsup/utils/strace.cc	11 Jul 2012 16:41:51 -0000	1.64
+++ winsup/utils/strace.cc	18 Oct 2012 05:50:55 -0000
@@ -27,9 +27,9 @@ details. */
 #include <time.h>
 #include <signal.h>
 #include <errno.h>
-#include "cygwin/include/sys/strace.h"
-#include "cygwin/include/sys/cygwin.h"
-#include "cygwin/include/cygwin/version.h"
+#include "../cygwin/include/sys/strace.h"
+#include "../cygwin/include/sys/cygwin.h"
+#include "../cygwin/include/cygwin/version.h"
 #include "path.h"
 #undef cygwin_internal
 #include "loadlib.h"

--=-G/EA7s7N1O4ttU/HD316--
