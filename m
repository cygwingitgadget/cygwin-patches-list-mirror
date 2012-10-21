Return-Path: <cygwin-patches-return-7741-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26989 invoked by alias); 21 Oct 2012 21:39:16 -0000
Received: (qmail 26979 invoked by uid 22791); 21 Oct 2012 21:39:15 -0000
X-SWARE-Spam-Status: No, hits=-5.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_DB,TW_XD,TW_YG
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f171.google.com (HELO mail-ie0-f171.google.com) (209.85.223.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 21 Oct 2012 21:39:04 +0000
Received: by mail-ie0-f171.google.com with SMTP id s9so2976266iec.2        for <cygwin-patches@cygwin.com>; Sun, 21 Oct 2012 14:39:03 -0700 (PDT)
Received: by 10.43.120.9 with SMTP id fw9mr6079914icc.46.1350855543680;        Sun, 21 Oct 2012 14:39:03 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id y10sm18156216igc.13.2012.10.21.14.39.01        (version=TLSv1/SSLv3 cipher=OTHER);        Sun, 21 Oct 2012 14:39:02 -0700 (PDT)
Message-ID: <1350855543.1244.64.camel@YAAKOV04>
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Sun, 21 Oct 2012 21:39:00 -0000
In-Reply-To: <1350664438.3492.114.camel@YAAKOV04>
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>		 <20121017164440.GA12989@ednor.casa.cgf.cx>		 <20121017170514.GD10578@calimero.vinschen.de>		 <20121017193258.GA15271@ednor.casa.cgf.cx>		 <1350545597.3492.59.camel@YAAKOV04>		 <20121018083419.GC6221@calimero.vinschen.de>		 <1350580828.3492.73.camel@YAAKOV04>		 <20121019092135.GA22432@calimero.vinschen.de>	 <1350664438.3492.114.camel@YAAKOV04>
Content-Type: multipart/mixed; boundary="=-NKKF+VHVmJv9WkzvsNW1"
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
X-SW-Source: 2012-q4/txt/msg00018.txt.bz2


--=-NKKF+VHVmJv9WkzvsNW1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 284

On Fri, 2012-10-19 at 11:33 -0500, Yaakov (Cygwin/X) wrote:
> I'll include those changes and post a new patch then.

Revised patches for toplevel, winsup, winsup/cygwin, winsup/lsaauth, and
winsup/utils attached.  Tested on Cygwin and F17 with mingw32-headers
from rawhide.


Yaakov


--=-NKKF+VHVmJv9WkzvsNW1
Content-Disposition: attachment; filename="cygwin-mingw64.patch"
Content-Type: text/x-patch; name="cygwin-mingw64.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1347

2012-10-21  Yaakov Selkowitz  <yselkowitz@...>

	* Makefile.in (DLL_IMPORTS): Use system import libraries for
	kernel32 and ntdll instead of from in-tree w32api.
	(cygwin0.dll): Remove rule dependency on DLL_IMPORTS, as they
	are no longer built in-tree.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.257
diff -u -p -r1.257 Makefile.in
--- Makefile.in	1 Aug 2012 08:46:49 -0000	1.257
+++ Makefile.in	21 Oct 2012 20:39:05 -0000
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

--=-NKKF+VHVmJv9WkzvsNW1
Content-Disposition: attachment; filename="lsaauth-mingw64.patch"
Content-Type: text/x-patch; name="lsaauth-mingw64.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 3846

2012-10-21  Kai Tietz  <ktietz70@...>
	    Yaakov Selkowitz  <yselkowitz@...>

	* configure.in: Check for MINGW32_CC and MINGW64_CC.
	* configure: Regenerated.
	* Makefile.in: Use MINGW32_CC and MINGW64_CC to build 32-bit and
	64-bit DLLs.  Remove references to mingw and w32api directories.
	* cyglsa64.dll: Remove from version control.
	* make-64bit-version-with-mingw-w64.sh: Remove.

Index: configure.in
===================================================================
RCS file: /cvs/src/src/winsup/lsaauth/configure.in,v
retrieving revision 1.2
diff -u -p -r1.2 configure.in
--- configure.in	12 Oct 2008 23:53:26 -0000	1.2
+++ configure.in	21 Oct 2012 21:31:09 -0000
@@ -24,21 +24,13 @@ AC_CANONICAL_SYSTEM
 
 LIB_AC_PROG_CC
 
-NO_CYGWIN="$(cd ${srcdir}/../utils; pwd)/mingw"
+AC_CHECK_PROGS(MINGW32_CC, i686-w64-mingw32-gcc)
+AC_CHECK_PROGS(MINGW64_CC, x86_64-w64-mingw32-gcc)
 
-AC_SUBST(NO_CYGWIN)
-AC_ARG_PROGRAM
+test -z "$MINGW32_CC" && AC_MSG_ERROR([no acceptable mingw32 cc found in \$PATH])
+test -z "$MINGW64_CC" && AC_MSG_ERROR([no acceptable mingw64 cc found in \$PATH])
 
-if test "x$cross_compiling" = "xyes"; then
-  if test "x$program_transform_name" = "xs,x,x,"; then
-    program_transform_name=""
-  fi
-  if test "x$program_transform_name" = "x"; then
-    program_transform_name="s,^,$host-,"
-  else
-    program_transform_name="$program_transform_name -e s,^,$host-,"
-  fi
-fi
+AC_ARG_PROGRAM
 
 AC_PROG_INSTALL
 
Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/lsaauth/Makefile.in,v
retrieving revision 1.6
diff -u -p -r1.6 Makefile.in
--- Makefile.in	29 May 2012 12:46:01 -0000	1.6
+++ Makefile.in	21 Oct 2012 21:31:09 -0000
@@ -29,17 +29,16 @@ INSTALL_DATA    := @INSTALL_DATA@
 CC              := @CC@
 CC_FOR_TARGET   := $(CC)
 
+MINGW32_CC	:= @MINGW32_CC@
+MINGW64_CC	:= @MINGW64_CC@
+
 CFLAGS          := @CFLAGS@
 
 include $(srcdir)/../Makefile.common
 
-WIN32_INCLUDES  := -I. -I$(srcdir) $(w32api_include) $(w32api_include)/ddk
-WIN32_CFLAGS    := $(CFLAGS) $(WIN32_COMMON) $(WIN32_INCLUDES)
-WIN32_LDFLAGS	:= $(CFLAGS) $(WIN32_COMMON) -nostdlib -Wl,-shared
-
-ifdef MINGW_CC
-override CC:=${MINGW_CC}
-endif
+WIN32_INCLUDES  := -I. -I$(srcdir)
+WIN32_CFLAGS    := $(CFLAGS) $(WIN32_INCLUDES)
+WIN32_LDFLAGS	:= $(CFLAGS) -nostdlib -Wl,-shared
 
 # Never again try to remove advapi32.  It does not matter if the DLL calls
 # advapi32 functions or the equivalent ntdll functions.
@@ -47,21 +46,33 @@ endif
 # not recognized by LSA.
 LIBS		:= -ladvapi32 -lkernel32 -lntdll
 
-DLL	:=	cyglsa.dll
-DEF_FILE:=	cyglsa.def
-
-OBJ	=	cyglsa.o
+DLL32	:=	cyglsa.dll
+DEF32	:=	cyglsa.def
+OBJ32	:=	cyglsa.o
+
+DLL64	:=	cyglsa64.dll
+DEF64	:=	cyglsa64.def
+OBJ64	:=	cyglsa64.o
 
 .SUFFIXES:
 .NOEXPORT:
 
-all: Makefile $(DLL)
+all: Makefile $(DLL32) $(DLL64)
 
-$(DEF_FILE): cyglsa.din config.status
+$(DEF32): cyglsa.din config.status
 	$(SHELL) config.status
 
-$(DLL): $(OBJ) $(DEF_FILE)
-	$(CC) -s $(WIN32_LDFLAGS) -o $@ $^ $(LIBS)
+$(DLL32): $(OBJ32) $(DEF32)
+	$(MINGW32_CC) -s $(WIN32_LDFLAGS) -o $@ $^ $(LIBS)
+
+$(OBJ32): cyglsa.c
+	$(MINGW32_CC) $(WIN32_CFLAGS) -c -o $@ $<
+
+$(DLL64): $(OBJ64) $(DEF64)
+	$(MINGW64_CC) -s $(WIN32_LDFLAGS) -o $@ $^ $(LIBS)
+
+$(OBJ64): cyglsa.c
+	$(MINGW64_CC) $(WIN32_CFLAGS) -c -o $@ $<
 
 .PHONY: all install clean realclean
 
@@ -73,9 +84,6 @@ clean:
 
 install: all
 	$(SHELL) $(updir1)/mkinstalldirs $(DESTDIR)$(bindir)
-	$(INSTALL_PROGRAM) $(DLL) $(DESTDIR)$(bindir)/$(DLL)
-	$(INSTALL_PROGRAM) $(srcdir)/cyglsa64.dll $(DESTDIR)$(bindir)/cyglsa64.dll
+	$(INSTALL_PROGRAM) $(DLL32) $(DESTDIR)$(bindir)/$(DLL32)
+	$(INSTALL_PROGRAM) $(DLL64) $(DESTDIR)$(bindir)/$(DLL64)
 	$(INSTALL_PROGRAM) $(srcdir)/cyglsa-config $(DESTDIR)$(bindir)/cyglsa-config
-
-%.o: %.c
-	$(CC) $(WIN32_CFLAGS) -c -o $@ $<

--=-NKKF+VHVmJv9WkzvsNW1
Content-Disposition: attachment; filename="toplevel-cygwin-mingw64.patch"
Content-Type: text/x-patch; name="toplevel-cygwin-mingw64.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1721

2012-10-21  Yaakov Selkowitz  <yselkowitz@...>

	* configure.ac [cygwin*] (FLAGS_FOR_TARGET): Remove references
	to w32api and obsolete directories.
	* configure: Regenerate.

Index: configure.ac
===================================================================
RCS file: /cvs/src/src/configure.ac,v
retrieving revision 1.174
diff -u -p -r1.174 configure.ac
--- configure.ac	29 Sep 2012 15:35:53 -0000	1.174
+++ configure.ac	21 Oct 2012 20:53:19 -0000
@@ -2801,7 +2801,7 @@ case " $target_configdirs " in
   *" --with-newlib "*)
    case "$target" in
     *-cygwin*)
-      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include -isystem $$s/winsup/w32api/include'
+      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -isystem $$s/winsup/cygwin/include'
       ;;
    esac
 
Index: configure
===================================================================
RCS file: /cvs/src/src/configure,v
retrieving revision 1.430
diff -u -p -r1.430 configure
--- configure	29 Sep 2012 15:35:52 -0000	1.430
+++ configure	21 Oct 2012 20:53:21 -0000
@@ -7207,7 +7207,7 @@ case " $target_configdirs " in
   *" --with-newlib "*)
    case "$target" in
     *-cygwin*)
-      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -L$$r/$(TARGET_SUBDIR)/winsup/w32api/lib -isystem $$s/winsup/include -isystem $$s/winsup/cygwin/include -isystem $$s/winsup/w32api/include'
+      FLAGS_FOR_TARGET=$FLAGS_FOR_TARGET' -L$$r/$(TARGET_SUBDIR)/winsup/cygwin -isystem $$s/winsup/cygwin/include'
       ;;
    esac
 

--=-NKKF+VHVmJv9WkzvsNW1
Content-Disposition: attachment; filename="utils-mingw64.patch"
Content-Type: text/x-patch; name="utils-mingw64.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 6353

2012-10-21  Kai Tietz  <ktietz70@...>
	    Yaakov Selkowitz  <yselkowitz@...>

	* configure.in: Add check for MINGW_CXX.
	* configure: Regenerate.
	* Makefile.in: Remove references to mingw and w32api directories.
	Use MINGW_CXX instead of mingw script to build MINGW_BINS.
	* cygcheck.cc: Use relative include paths for Cygwin headers.
	* path.cc: Ditto.
	* strace.cc: Ditto
	* mingw: Remove.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.101
diff -u -p -r1.101 Makefile.in
--- Makefile.in	19 Oct 2012 11:58:48 -0000	1.101
+++ Makefile.in	21 Oct 2012 19:50:10 -0000
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
@@ -74,7 +70,8 @@ path-mount.o: path.cc
 mount.exe: path-mount.o
 
 # Provide any necessary per-target variable overrides.
-cygcheck.exe: MINGW_LDFLAGS +=  -B{w32api_lib} -lpsapi -lntdll -lmsvcrt
+cygcheck.exe: MINGW_CXXFLAGS += -idirafter $(cygwin_source)/include -idirafter $(newlib_source)/libc/include
+cygcheck.exe: MINGW_LDFLAGS += -lpsapi -lntdll
 cygpath.exe: ALL_LDFLAGS += -lcygwin -luserenv -lntdll
 cygpath.exe: CXXFLAGS += -fno-threadsafe-statics
 ps.exe: ALL_LDFLAGS += -lcygwin -lpsapi -lntdll
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
Index: configure.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/configure.in,v
retrieving revision 1.9
diff -u -p -r1.9 configure.in
--- configure.in	25 Jul 2008 15:03:25 -0000	1.9
+++ configure.in	21 Oct 2012 19:50:11 -0000
@@ -27,5 +27,8 @@ INSTALL="/bin/sh "`cd $srcdir/../..; ech
 
 AC_PROG_INSTALL
 
+AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)
+test -z "$MINGW_CXX" && AC_MSG_ERROR([no acceptable mingw g++ found in \$PATH])
+
 AC_EXEEXT
 AC_OUTPUT(Makefile)
Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.135
diff -u -p -r1.135 cygcheck.cc
--- cygcheck.cc	9 Oct 2012 12:47:40 -0000	1.135
+++ cygcheck.cc	21 Oct 2012 19:50:11 -0000
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
 
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/path.cc,v
retrieving revision 1.31
diff -u -p -r1.31 path.cc
--- path.cc	17 Dec 2011 23:39:47 -0000	1.31
+++ path.cc	21 Oct 2012 19:50:11 -0000
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
Index: strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/strace.cc,v
retrieving revision 1.64
diff -u -p -r1.64 strace.cc
--- strace.cc	11 Jul 2012 16:41:51 -0000	1.64
+++ strace.cc	21 Oct 2012 19:50:11 -0000
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

--=-NKKF+VHVmJv9WkzvsNW1
Content-Disposition: attachment; filename="winsup-mingw64.patch"
Content-Type: text/x-patch; name="winsup-mingw64.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 4487

2012-10-21  Kai Tietz  <ktietz70@...>
	    Yaakov Selkowitz  <yselkowitz@...>
	    Corinna Vinschen  <corinna@...>

	* configure.in [cygwin*]: Always build cygserver, lsaauth,
	utils, and doc.  Do not build mingw or w32api.
	[mingw*]: Build w32api if present.
	* configure: Regenerate.
	* Makefile.common: Remove references to mingw and w32api
	directories.
	(MINGW_LDFLAGS): Redefine as -static to force static linking
	with libgcc and libstdc++.
	* Makefile.in: Remove references to mingw and w32api directories
	from Cygwin targets.

Index: configure.in
===================================================================
RCS file: /cvs/src/src/winsup/configure.in,v
retrieving revision 1.33
diff -u -p -r1.33 configure.in
--- configure.in	29 Jan 2011 06:41:28 -0000	1.33
+++ configure.in	21 Oct 2012 20:45:07 -0000
@@ -32,33 +32,17 @@ case "$target" in
     if ! test -d $srcdir/cygwin; then
       AC_MSG_ERROR("No cygwin dir.  Can't build Cygwin.  Exiting...")
     fi
-    AC_CONFIG_SUBDIRS(cygwin)
+    AC_CONFIG_SUBDIRS(cygwin cygserver lsaauth utils doc)
     INSTALL_LICENSE="install-license"
     ;;
   *mingw*)
     if ! test -d $srcdir/mingw; then
       AC_MSG_ERROR("No mingw dir.  Can't build Mingw.  Exiting...")
     fi
-    ;;
-esac
-
-if test -d $srcdir/mingw; then
-  AC_CONFIG_SUBDIRS(mingw)
-fi
-AC_CONFIG_SUBDIRS(w32api cygserver)
-
-case "$with_cross_host" in
-  ""|*cygwin*)
-    # if test -d $srcdir/bz2lib; then
-    #  AC_CONFIG_SUBDIRS(bz2lib)
-    # fi
-    # if test -d $srcdir/zlib; then
-    #   AC_CONFIG_SUBDIRS(zlib)
-    # fi
-    if test -d $srcdir/lsaauth; then
-      AC_CONFIG_SUBDIRS(lsaauth)
+    AC_CONFIG_SUBDIRS(mingw)
+    if test -d $srcdir/w32api; then
+      AC_CONFIG_SUBDIRS(w32api)
     fi
-    AC_CONFIG_SUBDIRS(utils doc)
     ;;
 esac
 
Index: Makefile.common
===================================================================
RCS file: /cvs/src/src/winsup/Makefile.common,v
retrieving revision 1.59
diff -u -p -r1.59 Makefile.common
--- Makefile.common	30 Jul 2012 04:43:21 -0000	1.59
+++ Makefile.common	21 Oct 2012 20:45:07 -0000
@@ -72,38 +72,22 @@ ifeq (,${findstring $(cygwin_source)/inc
 cygwin_include:=-I$(cygwin_source)/include
 endif
 
-# Try to determine what directories are available in winsup.
-# Attempt to properly detect missing mingw or w32api and adjust command
-# line parameters appropriately
-
-# nostdinc:=${shell [ -d "$(updir)/w32api" ] && echo "-nostdinc"}
-# ifneq (,$(nostdinc))
 nostdincxx:=-nostdinc++
-# ifeq (,${findstring $(w32api_source),$(CFLAGS) $(CXXFLAGS) $(CXX) $(CC)})
-w32api_include:=-I$(w32api_source)/include
-# endif
-# endif
 
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
 
@@ -134,7 +118,7 @@ COMPILE_CXX=$(CXX) $c $(if $($(*F)_STDIN
 	     $(ALL_CXXFLAGS) $(GCC_INCLUDE) -fno-rtti -fno-exceptions
 COMPILE_CC=$(CC) $c $(if $($(*F)_STDINCFLAGS),,$(nostdinc)) $(ALL_CFLAGS) $(GCC_INCLUDE)
 
-vpath %.a	$(cygwin_build):$(w32api_lib):$(newlib_build)/libc:$(newlib_build)/libm
+vpath %.a	$(cygwin_build):$(newlib_build)/libc:$(newlib_build)/libm
 
 MAKEOVERRIDES_WORKAROUND=${wordlist 2,1,a b c}
 
Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/Makefile.in,v
retrieving revision 1.33
diff -u -p -r1.33 Makefile.in
--- Makefile.in	24 Feb 2009 02:11:13 -0000	1.33
+++ Makefile.in	21 Oct 2012 20:45:07 -0000
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

--=-NKKF+VHVmJv9WkzvsNW1--
