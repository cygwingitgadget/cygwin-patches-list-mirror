Return-Path: <cygwin-patches-return-7750-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31134 invoked by alias); 24 Oct 2012 09:30:52 -0000
Received: (qmail 31124 invoked by uid 22791); 24 Oct 2012 09:30:52 -0000
X-SWARE-Spam-Status: No, hits=-5.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_DB,TW_FD,TW_XD,TW_YG
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f171.google.com (HELO mail-ie0-f171.google.com) (209.85.223.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 24 Oct 2012 09:30:46 +0000
Received: by mail-ie0-f171.google.com with SMTP id s9so355822iec.2        for <cygwin-patches@cygwin.com>; Wed, 24 Oct 2012 02:30:46 -0700 (PDT)
Received: by 10.50.41.132 with SMTP id f4mr1772850igl.39.1351071046096;        Wed, 24 Oct 2012 02:30:46 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id x5sm1488273igc.14.2012.10.24.02.30.44        (version=TLSv1/SSLv3 cipher=OTHER);        Wed, 24 Oct 2012 02:30:45 -0700 (PDT)
Message-ID: <1351071053.1244.89.camel@YAAKOV04>
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Wed, 24 Oct 2012 09:30:00 -0000
In-Reply-To: <20121022122344.GC2469@calimero.vinschen.de>
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>	 <20121017164440.GA12989@ednor.casa.cgf.cx>	 <20121017170514.GD10578@calimero.vinschen.de>	 <20121017193258.GA15271@ednor.casa.cgf.cx>	 <1350545597.3492.59.camel@YAAKOV04>	 <20121018083419.GC6221@calimero.vinschen.de>	 <1350580828.3492.73.camel@YAAKOV04>	 <20121019092135.GA22432@calimero.vinschen.de>	 <1350664438.3492.114.camel@YAAKOV04> <1350855543.1244.64.camel@YAAKOV04>	 <20121022122344.GC2469@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-xu4y/JwSBitI0t9k3QIM"
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
X-SW-Source: 2012-q4/txt/msg00027.txt.bz2


--=-xu4y/JwSBitI0t9k3QIM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 496

On Mon, 2012-10-22 at 14:23 +0200, Corinna Vinschen wrote:
> If the original patch with the aforementioned changes is ok with
> everybody, I'd apply it asap and remove lsaauth/cyglsa64.dll,
> lsaauth/make-64bit-version-with-mingw-w64.sh, and utils/mingw.

Revised patches for winsup/cygwin and winsup/utils attached; I'm going
to leave the AC_NO_EXECUTABLES part to you, as I'm not in a position to
test that.  Before I apply these, are there special procedures for the
toplevel patch?


Yaakov


--=-xu4y/JwSBitI0t9k3QIM
Content-Disposition: attachment; filename="utils-mingw64.patch"
Content-Type: text/x-patch; name="utils-mingw64.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 7567

2012-10-24  Kai Tietz  <ktietz70@...>
	    Yaakov Selkowitz  <yselkowitz@...>
	    Corinna Vinschen <corinna@...>

	* configure.in: Add check for MINGW_CXX.  Remove libiconv check.
	* configure: Regenerate.
	* Makefile.in: Remove references to mingw and w32api directories.
	Use MINGW_CXX instead of mingw script to build MINGW_BINS.
	Check for libiconv with $CC --print-file-name.
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
+++ Makefile.in	24 Oct 2012 09:20:16 -0000
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
@@ -83,21 +80,20 @@ strace.exe: MINGW_LDFLAGS += -lntdll
 ldd.exe: ALL_LDFLAGS += -lpsapi
 pldd.exe: ALL_LDFLAGS += -lpsapi
 
-ldh.exe: MINGW_LDLIBS :=
 ldh.exe: MINGW_LDFLAGS := -nostdlib -lkernel32
 
 # Check for dumper's requirements and enable it if found.
-LIBICONV := @libiconv@
+libiconv := ${shell $(CC) --print-file-name=libiconv.a}
 libbfd   := ${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=libbfd.a}
 libintl  := ${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=libintl.a}
 bfdlink	 := $(shell ${CC} -xc /dev/null -o /dev/null -c -B${bupdir2}/bfd/ -include bfd.h 2>&1)
-build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(LIBICONV)" -a -z "${bfdlink}" && echo 1}
+build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(libiconv)" -a -z "${bfdlink}" && echo 1}
 ifdef build_dumper
 CYGWIN_BINS += dumper.exe
 dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(bupdir2)/bfd -I$(updir1)/include
 dumper.o parse_pe.o: dumper.h
 dumper.exe: module_info.o parse_pe.o
-dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty -lz
+dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(libiconv) -liberty -lz
 else
 all: warn_dumper
 endif
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
+++ configure.in	24 Oct 2012 09:20:16 -0000
@@ -20,12 +20,12 @@ LIB_AC_PROG_CXX
 
 AC_ARG_PROGRAM
 
-AC_CHECK_LIB(iconv, libiconv, libiconv=-liconv)
-AC_SUBST(libiconv)
-
 INSTALL="/bin/sh "`cd $srcdir/../..; echo $(pwd)/install-sh -c`
 
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
+++ cygcheck.cc	24 Oct 2012 09:20:17 -0000
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
+++ path.cc	24 Oct 2012 09:20:17 -0000
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
+++ strace.cc	24 Oct 2012 09:20:17 -0000
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

--=-xu4y/JwSBitI0t9k3QIM
Content-Disposition: attachment; filename="cygwin-mingw64.patch"
Content-Type: text/x-patch; name="cygwin-mingw64.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1361

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
+++ Makefile.in	24 Oct 2012 09:15:01 -0000
@@ -130,7 +130,7 @@ EXTRA_OFILES:=
 
 MALLOC_OFILES:=@MALLOC_OFILES@
 
-DLL_IMPORTS:=$(w32api_lib)/libkernel32.a $(w32api_lib)/libntdll.a
+DLL_IMPORTS:=${shell $(CC) -print-file-name=w32api/libkernel32.a} ${shell $(CC) -print-file-name=w32api/libntdll.a}
 
 MT_SAFE_OBJECTS:=
 #
@@ -395,7 +395,7 @@ maintainer-clean realclean: clean
 
 
 # Rule to build cygwin.dll
-$(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(DLL_IMPORTS) $(LIBSERVER) $(LIBC) $(LIBM) $(API_VER) Makefile winver_stamp
+$(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(LIBSERVER) $(LIBC) $(LIBM) $(API_VER) Makefile winver_stamp
 	$(CXX) $(CXXFLAGS) -Wl,--gc-sections $(nostdlib) -Wl,-T$(firstword $^) -static \
 	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
 	-e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) version.o winver.o \

--=-xu4y/JwSBitI0t9k3QIM--
