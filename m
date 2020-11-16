Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta27-sa.btinternet.com
 [213.120.69.33])
 by sourceware.org (Postfix) with ESMTPS id 508EA385EC57
 for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020 13:54:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 508EA385EC57
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20201116135425.TKDV28150.sa-prd-fep-046.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 16 Nov 2020 13:54:25 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9AA6E1AB285B5
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefhgfelhfdviefhveejheevjefhteevheehhedviedujeevgefhffevfeeitdefudenucffohhmrghinheptgihghifihhnrdgtohhmpdgthihgfihinhdqughotgdrshhhpdhtiihmrghpqdhfrhhomhdquhhnihgtohguvgdrohhrghenucfkphepkeeirddufeelrdduheekrddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddugedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E1AB285B5; Mon, 16 Nov 2020 13:54:25 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Use automake
Date: Mon, 16 Nov 2020 13:53:50 +0000
Message-Id: <20201116135350.27289-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116135350.27289-1-jon.turney@dronecode.org.uk>
References: <20201116135350.27289-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE, TXREP, URIBL_SBL, URIBL_SBL_A,
 URI_NOVOWEL autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 16 Nov 2020 13:54:32 -0000

---
 winsup/Makefile.am                     |  19 +
 winsup/Makefile.am.common              |  15 +
 winsup/Makefile.common                 |  51 --
 winsup/autogen.sh                      |   1 +
 winsup/configure.ac                    |  21 +-
 winsup/cygserver/Makefile.am           |  58 ++
 winsup/cygwin/Makefile.am              | 764 +++++++++++++++++++++++++
 winsup/cygwin/config.h.in              |   2 +-
 winsup/doc/Makefile.am                 | 155 +++++
 winsup/testsuite/Makefile.am           |  64 +++
 winsup/testsuite/config/default.exp    |   4 +-
 winsup/testsuite/cygrun/Makefile.am    |  21 +
 winsup/testsuite/winsup.api/winsup.exp |   6 +-
 winsup/utils/Makefile.am               |  79 +++
 winsup/utils/mingw/Makefile.am         |  50 ++
 15 files changed, 1251 insertions(+), 59 deletions(-)
 create mode 100644 winsup/Makefile.am
 create mode 100644 winsup/Makefile.am.common
 delete mode 100644 winsup/Makefile.common
 create mode 100644 winsup/cygserver/Makefile.am
 create mode 100644 winsup/cygwin/Makefile.am
 create mode 100644 winsup/doc/Makefile.am
 create mode 100644 winsup/testsuite/Makefile.am
 create mode 100644 winsup/testsuite/cygrun/Makefile.am
 create mode 100644 winsup/utils/Makefile.am
 create mode 100644 winsup/utils/mingw/Makefile.am

diff --git a/winsup/Makefile.am b/winsup/Makefile.am
new file mode 100644
index 000000000..067f74688
--- /dev/null
+++ b/winsup/Makefile.am
@@ -0,0 +1,19 @@
+# Makefile.am for winsup stuff
+#
+# This file is part of Cygwin.
+#
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+# This makefile requires GNU make.
+
+cygdocdir = $(datarootdir)/doc/Cygwin
+
+cygdoc_DATA = \
+	CYGWIN_LICENSE \
+	COPYING
+
+SUBDIRS = cygwin cygserver doc utils testsuite
+
+cygserver utils testsuite: cygwin
diff --git a/winsup/Makefile.am.common b/winsup/Makefile.am.common
new file mode 100644
index 000000000..884194df2
--- /dev/null
+++ b/winsup/Makefile.am.common
@@ -0,0 +1,15 @@
+# Makefile.am.common - common definitions for the winsup directory
+#
+# This file is part of Cygwin.
+#
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+flags_common=-Wall -Wstrict-aliasing -Wwrite-strings -fno-common -pipe -fbuiltin -fmessage-length=0
+
+# compiler flags commonly used (but not for MinGW compilation, because they
+# include the Cygwin header paths via @INCLUDES@)
+
+cxxflags_common=$(INCLUDES) -fno-rtti -fno-exceptions -fno-use-cxa-atexit $(flags_common)
+cflags_common=$(INCLUDES) $(flags_common)
diff --git a/winsup/Makefile.common b/winsup/Makefile.common
deleted file mode 100644
index 3141bd111..000000000
--- a/winsup/Makefile.common
+++ /dev/null
@@ -1,51 +0,0 @@
-# Makefile.common - common definitions for the winsup directory
-#
-# This file is part of Cygwin.
-#
-# This software is a copyrighted work licensed under the terms of the
-# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
-# details.
-
-define justdir
-$(patsubst %/,%,$(dir $1))
-endef
-
-define libname
-$(realpath $(shell ${CC} --print-file-name=$1 $2))
-endef
-
-export PATH:=${winsup_srcdir}:${PATH}
-
-# Allow CFLAGS=-O,-g to control CXXFLAGS too
-opt=$(filter -O%,${CFLAGS}) $(filter -g%,${CFLAGS})
-override CXXFLAGS:=${filter-out -g%,$(filter-out -O%,${CXXFLAGS})} ${opt}
-
-cflags_common:=-Wall -Wstrict-aliasing -Wwrite-strings -fno-common -pipe -fbuiltin -fmessage-length=0
-COMPILE.cc=${CXX} ${INCLUDES} ${CXXFLAGS} -fno-rtti -fno-exceptions -fno-use-cxa-atexit ${cflags_common}
-COMPILE.c=${CC} ${INCLUDES} ${CFLAGS} ${cflags_common}
-
-top_srcdir:=$(call justdir,${winsup_srcdir})
-top_builddir:=$(call justdir,${target_builddir})
-
-cygwin_build:=${target_builddir}/winsup/cygwin
-newlib_build:=${target_builddir}/newlib
-
-VPATH:=${srcdir}
-
-.SUFFIXES:
-.SUFFIXES: .c .cc .def .S .a .o .d .s .E
-
-%.o: %.cc
-	$(strip ${COMPILE.cc} -c -o $@ $<)
-
-%.o: %.c
-	$(strip ${COMPILE.c} -c -o $@ $<)
-
-%.E: %.cc
-	$(strip ${COMPILE.cc} -E -dD -o $@ $<)
-
-%.E: %.c
-	$(strip ${COMPILE.c} -E -dD -o $@ $<)
-
-%.o: %.S
-	$(strip ${COMPILE.S} -c -o $@ $<)
diff --git a/winsup/autogen.sh b/winsup/autogen.sh
index 4a60ef39f..1db91add9 100755
--- a/winsup/autogen.sh
+++ b/winsup/autogen.sh
@@ -1,3 +1,4 @@
 /usr/bin/aclocal --force
 /usr/bin/autoconf -f
+/usr/bin/automake -ac
 /bin/rm -rf autom4te.cache
diff --git a/winsup/configure.ac b/winsup/configure.ac
index 438e629e7..9a11411ab 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -10,8 +10,10 @@ dnl Process this file with autoconf to produce a configure script.
 
 AC_PREREQ([2.59])
 AC_INIT([Cygwin],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
-AC_CONFIG_SRCDIR(Makefile.in)
 AC_CONFIG_AUX_DIR(..)
+AC_CANONICAL_TARGET
+AM_INIT_AUTOMAKE([dejagnu foreign no-define no-dist subdir-objects -Wall -Wno-portability -Wno-extra-portability])
+AM_SILENT_RULES([yes])
 
 realdirpath() {
     test -z "$1" && return 1
@@ -26,13 +28,15 @@ realdirpath() {
 winsup_srcdir="$(realdirpath $srcdir)"
 target_builddir="$(realdirpath ..)"
 
-AC_PROG_INSTALL
 AC_NO_EXECUTABLES
-AC_CANONICAL_TARGET
 
+AC_PROG_INSTALL
+AC_PROG_MKDIR_P
 AC_PROG_CC
 AC_PROG_CXX
 AC_PROG_CPP
+AM_PROG_AS
+
 AC_LANG(C)
 AC_LANG(C++)
 
@@ -82,6 +86,8 @@ AC_SUBST(DEF_DLL_ENTRY)
 AC_SUBST(DIN_FILE)
 AC_SUBST(TLSOFFSETS_H)
 
+AM_CONDITIONAL(TARGET_X86_64, [test $target_cpu = "x86_64"])
+
 AC_CHECK_PROGS([DOCBOOK2XTEXI], [docbook2x-texi db2x_docbook2texi], [true])
 
 if test "x$with_cross_bootstrap" != "xyes"; then
@@ -90,15 +96,24 @@ if test "x$with_cross_bootstrap" != "xyes"; then
     AC_CHECK_PROGS(MINGW_CC, ${target_cpu}-w64-mingw32-gcc)
     test -n "$MINGW_CC" || AC_MSG_ERROR([no acceptable MinGW gcc found in \$PATH])
 fi
+AM_CONDITIONAL(CROSS_BOOTSTRAP, [test "x$with_cross_bootstrap" != "xyes"])
+
 AC_EXEEXT
 
+AC_CHECK_LIB([bfd], [bfd_init], [true],
+	     AC_MSG_WARN([Not building dumper.exe since some required libraries or headers are missing]))
+
+AM_CONDITIONAL(BUILD_DUMPER, [test "x$ac_cv_lib_bfd_bfd_init" = "xyes"])
+
 AC_CONFIG_FILES([
     Makefile
     cygwin/Makefile
     cygserver/Makefile
     doc/Makefile
     utils/Makefile
+    utils/mingw/Makefile
     testsuite/Makefile
+    testsuite/cygrun/Makefile
 ])
 
 AC_OUTPUT
diff --git a/winsup/cygserver/Makefile.am b/winsup/cygserver/Makefile.am
new file mode 100644
index 000000000..d52f93ce0
--- /dev/null
+++ b/winsup/cygserver/Makefile.am
@@ -0,0 +1,58 @@
+# Makefile for Cygwin server
+
+# This file is part of Cygwin.
+
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+include $(top_srcdir)/Makefile.am.common
+
+cygserver_flags=$(cxxflags_common) -Wimplicit-fallthrough=5 -Werror -DSYSCONFDIR="\"$(sysconfdir)\""
+
+noinst_LIBRARIES = libcygserver.a
+sbin_PROGRAMS = cygserver
+bin_SCRIPTS = cygserver-config
+
+cygserver_SOURCES = \
+	bsd_helper.cc \
+	bsd_log.cc \
+	bsd_mutex.cc \
+	client.cc \
+	cygserver.cc \
+	msg.cc \
+	process.cc \
+	pwdgrp.cc \
+	sem.cc \
+	setpwd.cc \
+	shm.cc \
+	sysv_msg.cc \
+	sysv_sem.cc \
+	sysv_shm.cc \
+	threaded_queue.cc \
+	transport.cc \
+	transport_pipes.cc
+
+cygserver_CXXFLAGS = $(cygserver_flags) -D__OUTSIDE_CYGWIN__
+cygserver_LDADD = -lntdll
+cygserver_LDFLAGS = -static -static-libgcc
+
+# Note: the objects in libcygserver are built without -D__OUTSIDE_CYGWIN__,
+# unlike cygserver.exe
+
+libcygserver_a_SOURCES = \
+	$(cygserver_SOURCES)
+
+libcygserver_a_CXXFLAGS = $(cygserver_flags)
+
+cygdocdir = $(datarootdir)/doc/Cygwin
+
+install-data-local:
+	@$(MKDIR_P) $(DESTDIR)$(cygdocdir)
+	$(INSTALL_DATA) $(srcdir)/README $(DESTDIR)$(cygdocdir)/cygserver.README
+	@$(MKDIR_P) $(DESTDIR)$(sysconfdir)/defaults/etc
+	$(INSTALL_DATA) $(srcdir)/cygserver.conf $(DESTDIR)$(sysconfdir)/defaults/etc/cygserver.conf
+
+uninstall-local:
+	rm -f $(DESTDIR)$(cygdocdir)/cygserver.README
+	rm -f $(DESTDIR)$(sysconfdir)/defaults/etc/cygserver.conf
diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
new file mode 100644
index 000000000..2e8215457
--- /dev/null
+++ b/winsup/cygwin/Makefile.am
@@ -0,0 +1,764 @@
+# Makefile.am for Cygwin.
+#
+# This file is part of Cygwin.
+#
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+# This makefile requires GNU make.
+
+include $(top_srcdir)/Makefile.am.common
+
+COMMON_CFLAGS=$($(*F)_CFLAGS) -Wimplicit-fallthrough=5 -Werror -fmerge-constants -ftracer
+if TARGET_X86_64
+COMMON_CFLAGS+=-mcmodel=small
+endif
+
+AM_CFLAGS=$(cflags_common) $(COMMON_CFLAGS)
+AM_CXXFLAGS=$(cxxflags_common) $(COMMON_CFLAGS)
+
+if TARGET_X86_64
+# Needed by mcountFunc.S to choose the right code path and symbol names
+AM_CCASFLAGS=-D_WIN64
+endif
+
+target_builddir=@target_builddir@
+newlib_build=$(target_builddir)/newlib
+
+#
+# Specialize libdir and includedir to use tooldir prefixed paths (containing
+# target_alias) as used by newlib, because we overwrite library and header files
+# installed there by newlib.
+#
+
+toollibdir=$(prefix)/$(target_alias)/lib
+toolincludedir=$(prefix)/$(target_alias)/include
+
+# Parameters used in building the cygwin.dll.
+
+DLL_NAME=cygwin1.dll
+TEST_DLL_NAME=cygwin0.dll
+DIN_FILE=@DIN_FILE@
+DEF_FILE=cygwin.def
+TLSOFFSETS_H=@TLSOFFSETS_H@
+LIB_NAME=libcygwin.a
+TEST_LIB_NAME=libcygwin0.a
+
+#
+# sources
+#
+
+# These objects are included directly into the import library
+LIB_FILES= \
+	lib/_cygwin_crt0_common.cc \
+	lib/atexit.c \
+	lib/cygwin_attach_dll.c \
+	lib/cygwin_crt0.c \
+	lib/dll_entry.c \
+	lib/dll_main.cc \
+	lib/dso_handle.c \
+	lib/libcmain.c \
+	lib/premain0.c \
+	lib/premain1.c \
+	lib/premain2.c \
+	lib/premain3.c \
+	lib/pseudo-reloc-dummy.c
+
+LIBC_FILES= \
+	libc/arc4random_stir.c \
+	libc/base64.c \
+	libc/bsdlib.cc \
+	libc/call_once.c \
+	libc/cnd.c \
+	libc/fnmatch.c \
+	libc/fts.c \
+	libc/ftw.c \
+	libc/getentropy.cc \
+	libc/getopt.c \
+	libc/inet_addr.c \
+	libc/inet_network.c \
+	libc/minires-os-if.c \
+	libc/minires.c \
+	libc/msgcat.c \
+	libc/mtx.c \
+	libc/nftw.c \
+	libc/rcmd.cc \
+	libc/rexec.cc \
+	libc/strfmon.c \
+	libc/strptime.cc \
+	libc/thrd.c \
+	libc/tss.c \
+	libc/xsique.cc
+
+MATH_FILES= \
+	math/acoshl.c \
+	math/acosl.c \
+	math/asinhl.c \
+	math/asinl.c \
+	math/atan2l.c \
+	math/atanhl.c \
+	math/atanl.c \
+	math/cabsl.c \
+	math/cacosl.c \
+	math/cargl.c \
+	math/casinl.c \
+	math/catanl.c \
+	math/cbrtl.c \
+	math/ccosl.c \
+	math/ceill.S \
+	math/cephes_emath.c \
+	math/cexpl.c \
+	math/cimagl.c \
+	math/clog10l.c \
+	math/clogl.c \
+	math/conjl.c \
+	math/copysignl.S \
+	math/coshl.c \
+	math/cosl.c \
+	math/cosl_internal.S \
+	math/cossin.c \
+	math/cpowl.c \
+	math/cprojl.c \
+	math/creall.c \
+	math/csinl.c \
+	math/csqrtl.c \
+	math/ctanl.c \
+	math/erfl.c \
+	math/exp10l.c \
+	math/exp2l.S \
+	math/expl.c \
+	math/expm1l.c \
+	math/fabsl.c \
+	math/fdiml.c \
+	math/finite.c \
+	math/floorl.S \
+	math/fmal.c \
+	math/fmaxl.c \
+	math/fminl.c \
+	math/fmodl.c \
+	math/frexpl.S \
+	math/ilogbl.S \
+	math/internal_logl.S \
+	math/isinf.c \
+	math/isnan.c \
+	math/ldexpl.c \
+	math/lgammal.c \
+	math/llrint.c \
+	math/llrintf.c \
+	math/llrintl.c \
+	math/llroundl.c \
+	math/log10l.S \
+	math/log1pl.S \
+	math/log2l.S \
+	math/logbl.c \
+	math/logl.c \
+	math/lrint.c \
+	math/lrintf.c \
+	math/lrintl.c \
+	math/lroundl.c \
+	math/modfl.c \
+	math/nearbyint.S \
+	math/nearbyintf.S \
+	math/nearbyintl.S \
+	math/nextafterl.c \
+	math/nexttoward.c \
+	math/nexttowardf.c \
+	math/pow10l.c \
+	math/powil.c \
+	math/powl.c \
+	math/remainder.S \
+	math/remainderf.S \
+	math/remainderl.S \
+	math/remquol.S \
+	math/rint.c \
+	math/rintf.c \
+	math/rintl.c \
+	math/roundl.c \
+	math/scalbl.S \
+	math/scalbnl.S \
+	math/sinhl.c \
+	math/sinl.c \
+	math/sinl_internal.S \
+	math/sqrtl.c \
+	math/tanhl.c \
+	math/tanl.S \
+	math/tgammal.c \
+	math/truncl.c
+
+REGEX_FILES = \
+	regex/regcomp.c \
+	regex/regerror.c \
+	regex/regexec.c \
+	regex/regfree.c
+
+TZCODE_FILES= \
+	tzcode/localtime_wrapper.c
+
+DLL_FILES= \
+	advapi32.cc \
+	aio.cc \
+	assert.cc \
+	autoload.cc \
+	clock.cc \
+	ctype.cc \
+	cxx.cc \
+	cygheap.cc \
+	cygthread.cc \
+	cygtls.cc \
+	cygwait.cc \
+	cygxdr.cc \
+	dcrt0.cc \
+	debug.cc \
+	devices.cc \
+	dir.cc \
+	dlfcn.cc \
+	dll_init.cc \
+	dtable.cc \
+	environ.cc \
+	errno.cc \
+	exceptions.cc \
+	exec.cc \
+	external.cc \
+	fcntl.cc \
+	fenv.cc \
+	fhandler.cc \
+	fhandler_clipboard.cc \
+	fhandler_console.cc \
+	fhandler_cygdrive.cc \
+	fhandler_dev.cc \
+	fhandler_disk_file.cc \
+	fhandler_dsp.cc \
+	fhandler_fifo.cc \
+	fhandler_floppy.cc \
+	fhandler_netdrive.cc \
+	fhandler_nodevice.cc \
+	fhandler_pipe.cc \
+	fhandler_proc.cc \
+	fhandler_process.cc \
+	fhandler_process_fd.cc \
+	fhandler_procnet.cc \
+	fhandler_procsys.cc \
+	fhandler_procsysvipc.cc \
+	fhandler_random.cc \
+	fhandler_raw.cc \
+	fhandler_registry.cc \
+	fhandler_serial.cc \
+	fhandler_signalfd.cc \
+	fhandler_socket.cc \
+	fhandler_socket_inet.cc \
+	fhandler_socket_local.cc \
+	fhandler_socket_unix.cc \
+	fhandler_tape.cc \
+	fhandler_termios.cc \
+	fhandler_timerfd.cc \
+	fhandler_tty.cc \
+	fhandler_virtual.cc \
+	fhandler_windows.cc \
+	fhandler_zero.cc \
+	flock.cc \
+	fork.cc \
+	forkable.cc \
+	glob.cc \
+	glob_pattern_p.cc \
+	globals.cc \
+	grp.cc \
+	heap.cc \
+	hookapi.cc \
+	init.cc \
+	ioctl.cc \
+	ipc.cc \
+	kernel32.cc \
+	ldap.cc \
+	libstdcxx_wrapper.cc \
+	loadavg.cc \
+	lsearch.cc \
+	malloc_wrapper.cc \
+	miscfuncs.cc \
+	mktemp.cc \
+	mmap.cc \
+	mmap_alloc.cc \
+	msg.cc \
+	mount.cc \
+	net.cc \
+	netdb.cc \
+	nfs.cc \
+	nlsfuncs.cc \
+	ntea.cc \
+	passwd.cc \
+	path.cc \
+	pinfo.cc \
+	poll.cc \
+	posix_ipc.cc \
+	posix_timer.cc \
+	pseudo-reloc.cc \
+	pthread.cc \
+	quotactl.cc \
+	random.cc \
+	registry.cc \
+	resource.cc \
+	scandir.cc \
+	sched.cc \
+	sec_acl.cc \
+	sec_auth.cc \
+	sec_helper.cc \
+	sec_posixacl.cc \
+	security.cc \
+	select.cc \
+	sem.cc \
+	setlsapwd.cc \
+	shared.cc \
+	shm.cc \
+	signal.cc \
+	sigproc.cc \
+	smallprint.cc \
+	spawn.cc \
+	strace.cc \
+	strfuncs.cc \
+	strsep.cc \
+	strsig.cc \
+	sync.cc \
+	syscalls.cc \
+	sysconf.cc \
+	syslog.cc \
+	termios.cc \
+	thread.cc \
+	timerfd.cc \
+	times.cc \
+	tls_pbuf.cc \
+	tty.cc \
+	uinfo.cc \
+	uname.cc \
+	wait.cc \
+	wincap.cc \
+	window.cc \
+	winf.cc
+
+MALLOC_FILES= \
+	malloc.cc
+
+GMON_FILES= \
+	gmon.c
+	mcount.c
+	mcountFunc.S
+	profil.c
+
+GENERATED_FILES= \
+	sigfe.s
+
+liblib_a_SOURCES= \
+	$(LIB_FILES)
+
+libdll_a_SOURCES= \
+	$(DLL_FILES) \
+	$(REGEX_FILES) \
+	$(MALLOC_FILES) \
+	$(LIBC_FILES) \
+	$(MATH_FILES) \
+	$(TZCODE_FILES) \
+	$(GENERATED_FILES)
+
+#
+# generated sources
+#
+
+shared_info_magic.h: cygmagic shared_info.h
+	$(srcdir)/cygmagic $@ "$(CC) $(INCLUDES) $(CPPFLAGS) -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
+
+child_info_magic.h: cygmagic child_info.h
+	$(srcdir)/cygmagic $@ "$(CC) $(INCLUDES) $(CPPFLAGS) -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
+
+globals.h: mkglobals_h globals.cc
+	$^ > $@
+
+localtime.patched.c: tzcode/localtime.c tzcode/localtime.c.patch
+	patch -u -o localtime.patched.c \
+		    $(srcdir)/tzcode/localtime.c \
+		    $(srcdir)/tzcode/localtime.c.patch
+
+$(srcdir)/devices.cc: gendevices devices.in devices.h
+	$(wordlist 1,2,$^) $@
+
+$(srcdir)/$(TLSOFFSETS_H): gentls_offsets cygtls.h
+	$^ $@ $(target_cpu) $(CC) $(AM_CFLAGS) -c || rm $@
+
+BUILT_SOURCES = \
+	child_info_magic.h \
+	shared_info_magic.h \
+	globals.h \
+	localtime.patched.c
+
+# Every time we touch a source file, the version info has to be rebuilt
+# to maintain a correct build date, especially in uname release output
+dirs = $(srcdir) $(srcdir)/regex $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/tzcode
+find_src_files = $(wildcard $(dir)/*.[chS]) $(wildcard $(dir)/*.cc)
+src_files := $(foreach dir,$(dirs),$(find_src_files))
+
+# mkvers.sh creates version.cc in the first place, winver.o always
+# second, so version.cc is always older than winver.o
+version.cc: mkvers.sh include/cygwin/version.h winver.rc $(src_files)
+	@echo "Making version.cc and winver.o";\
+	export CC="$(CC)";\
+	/bin/sh $(word 1,$^) $(word 2,$^) $(word 3,$^) $(WINDRES) $(CFLAGS)
+
+winver.o: version.cc
+
+VERSION_OFILES = version.o winver.o
+
+#
+# export renames for mkimport
+#
+
+NEW_FUNCTIONS=$(addprefix --replace=,\
+	atexit= \
+	timezone= \
+	uname=uname_x \
+	__xdrrec_getrec= \
+	__xdrrec_setnonblock= \
+	xdr_array= \
+	xdr_bool= \
+	xdr_bytes= \
+	xdr_char= \
+	xdr_double= \
+	xdr_enum= \
+	xdr_float= \
+	xdr_free= \
+	xdr_hyper= \
+	xdr_int= \
+	xdr_int16_t= \
+	xdr_int32_t= \
+	xdr_int64_t= \
+	xdr_int8_t= \
+	xdr_long= \
+	xdr_longlong_t= \
+	xdr_netobj= \
+	xdr_opaque= \
+	xdr_pointer= \
+	xdr_reference= \
+	xdr_short= \
+	xdr_sizeof= \
+	xdr_string= \
+	xdr_u_char= \
+	xdr_u_hyper= \
+	xdr_u_int= \
+	xdr_u_int16_t= \
+	xdr_u_int32_t= \
+	xdr_u_int64_t= \
+	xdr_u_int8_t= \
+	xdr_u_long= \
+	xdr_u_longlong_t= \
+	xdr_u_short= \
+	xdr_uint16_t= \
+	xdr_uint32_t= \
+	xdr_uint64_t= \
+	xdr_uint8_t= \
+	xdr_union= \
+	xdr_vector= \
+	xdr_void= \
+	xdr_wrapstring= \
+	xdrmem_create= \
+	xdrrec_create= \
+	xdrrec_endofrecord= \
+	xdrrec_eof= \
+	xdrrec_skiprecord= \
+	xdrstdio_create= \
+)
+
+if !TARGET_X86_64
+NEW_FUNCTIONS+=$(addprefix --replace=,\
+	acl=_acl32 \
+	aclcheck=_aclcheck32 \
+	aclfrommode=_aclfrommode32 \
+	aclfrompbits=_aclfrompbits32 \
+	aclfromtext=_aclfromtext32 \
+	aclsort=_aclsort32 \
+	acltomode=_acltomode32 \
+	acltopbits=_acltopbits32 \
+	acltotext=_acltotext32 \
+	chown=_chown32 \
+	facl=_facl32 \
+	fchown=_fchown32 \
+	fcntl=_fcntl64 \
+	fdopen=_fdopen64 \
+	fgetpos=_fgetpos64 \
+	fopen=_fopen64 \
+	freopen=_freopen64 \
+	fseeko=_fseeko64 \
+	fsetpos=_fsetpos64 \
+	fstat=_fstat64 \
+	ftello=_ftello64 \
+	ftruncate=_ftruncate64 \
+	getegid=_getegid32 \
+	geteuid=_geteuid32 \
+	getgid=_getgid32 \
+	getgrent=_getgrent32 \
+	getgrgid=_getgrgid32 \
+	getgrnam=_getgrnam32 \
+	getgroups=_getgroups32 \
+	getpwuid=_getpwuid32 \
+	getpwuid_r=_getpwuid_r32 \
+	getuid=_getuid32 \
+	initgroups=_initgroups32 \
+	lchown=_lchown32 \
+	lseek=_lseek64 \
+	lstat=_lstat64 \
+	mknod=_mknod32 \
+	mmap=_mmap64 \
+	open=_open64 \
+	setegid=_setegid32 \
+	seteuid=_seteuid32 \
+	setgid=_setgid32 \
+	setgroups=_setgroups32 \
+	setregid=_setregid32 \
+	setreuid=_setreuid32 \
+	setuid=_setuid32 \
+	stat=_stat64 \
+	tmpfile=_tmpfile64 \
+	truncate=_truncate64 \
+)
+endif
+
+#
+# per-file compilation flags
+#
+
+localtime_wrapper_CFLAGS=-I$(srcdir)/tzcode
+
+# required since gcc 9.x
+exec_CFLAGS=-fno-builtin-execve
+
+fhandler_proc_CFLAGS=-DUSERNAME="\"$(USER)\"" -DHOSTNAME="\"$(HOSTNAME)\"" \
+		     -DGCC_VERSION="\"`$(CC) -v 2>&1 | tail -n 1`\""
+
+if !TARGET_X86_64
+# on x86, exceptions.cc must be compiled with a frame-pointer as it uses RtlCaptureContext()
+exceptions_CFLAGS=-fno-omit-frame-pointer
+endif
+
+dtable_CFLAGS=-fcheck-new
+localtime_wrapper_CFLAGS+=-fwrapv
+
+# If an optimization level is explicitly set in CXXFLAGS, set -O3 for these files
+# XXX: this seems to assume it's not -O0?
+#
+# (the indentation here prevents automake trying to process this as an automake
+# conditional)
+ ifneq "${filter -O%,$(CXXFLAGS)}" ""
+  malloc_CFLAGS=-O3
+  sync_CFLAGS=-O3
+ endif
+
+#
+# libraries and installed objects
+#
+# (Don't ever try to use automake's shared library support via libtool to build
+# Cygwin. Instead we have explicit rules to build it.)
+#
+
+SUBLIBS = \
+	libpthread.a \
+	libutil.a \
+	libm.a \
+	libc.a \
+	libdl.a \
+	libresolv.a \
+	librt.a \
+	libacl.a \
+	libssp.a
+
+EXTRALIBS = \
+	libautomode.a \
+	libbinmode.a \
+	libtextmode.a \
+	libtextreadmode.a
+
+noinst_LIBRARIES = \
+	libdll.a \
+	liblib.a
+
+toollib_LIBRARIES = \
+	libgmon.a \
+	$(EXTRALIBS)
+
+CYGWIN_START=crt0.o
+GMON_START=gcrt0.o
+INSTOBJS=automode.o binmode.o textmode.o textreadmode.o
+
+toollib_DATA = \
+	$(CYGWIN_START) \
+	$(GMON_START) \
+	$(INSTOBJS) \
+	$(LIB_NAME) \
+	$(SUBLIBS)
+
+libgmon_a_SOURCES = $(GMON_FILES)
+libgmon_a_LIBADD = $(GMON_START)
+
+libautomode_a_SOURCES =
+libautomode_a_LIBADD = automode.o
+
+libbinmode_a_SOURCES =
+libbinmode_a_LIBADD = binmode.o
+
+libtextmode_a_SOURCES =
+libtextmode_a_LIBADD = textmode.o
+
+libtextreadmode_a_SOURCES =
+libtextreadmode_a_LIBADD = textreadmode.o
+
+# cygserver library
+cygserver_blddir = ${target_builddir}/winsup/cygserver
+LIBSERVER = $(cygserver_blddir)/libcygserver.a
+
+$(LIBSERVER):
+	$(MAKE) -C $(cygserver_blddir) libcygserver.a
+
+# We build as cygwin0.dll and rename at install time to overcome native
+# rebuilding issues (we don't want the build tools to see a partially built
+# cygwin.dll and attempt to use it instead of the old one).
+
+# linker script
+LDSCRIPT=cygwin.sc
+$(LDSCRIPT): $(LDSCRIPT).in
+	$(CC) -E - -P < $^ -o $@
+
+# cygwin dll
+$(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg libdll.a $(VERSION_OFILES) $(LIBSERVER)
+	$(CXX) $(CXXFLAGS) \
+	-mno-use-libstdc-wrappers \
+	-Wl,--gc-sections -nostdlib -Wl,-T$(LDSCRIPT) -static \
+	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
+	-e @DLL_ENTRY@ $(DEF_FILE) \
+	-Wl,-whole-archive libdll.a -Wl,-no-whole-archive \
+	$(VERSION_OFILES) \
+	$(LIBSERVER) \
+	$(newlib_build)/libm/libm.a \
+	$(newlib_build)/libc/libc.a \
+	-lgcc -lkernel32 -lntdll -Wl,-Map,cygwin.map
+	$(srcdir)/dllfixdbg $(OBJDUMP) $(OBJCOPY) $@ cygwin1.dbg
+	@ln -f $@ new-cygwin1.dll
+
+# cygwin import library
+toolopts=--cpu=@target_cpu@ --ar=@AR@ --as=@AS@ --nm=@NM@ --objcopy=@OBJCOPY@
+
+$(DEF_FILE): gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE) common.din
+	$(srcdir)/gendef --cpu=@target_cpu@ --output-def=$(DEF_FILE) --tlsoffsets=$(srcdir)/$(TLSOFFSETS_H) $(srcdir)/$(DIN_FILE) $(srcdir)/common.din
+
+sigfe.s: $(DEF_FILE)
+	@[ -s $@ ] || \
+	{ rm -f $(DEF_FILE); $(MAKE) -s -j1 $(DEF_FILE); }; \
+	[ -s $@ ] && touch $@
+
+LIBCOS=$(addsuffix .o,$(basename $(LIB_FILES)))
+$(LIB_NAME): $(DEF_FILE) $(LIBCOS) | $(TEST_DLL_NAME)
+	$(srcdir)/mkimport $(toolopts) $(NEW_FUNCTIONS) $@ cygdll.a $(wordlist 2,99,$^)
+
+# cygwin import library used by testsuite
+$(TEST_LIB_NAME): $(LIB_NAME)
+	perl -p -e 'BEGIN{binmode(STDIN); binmode(STDOUT);}; s/cygwin1/cygwin0/g' < $? > $@
+
+# sublibs
+# import libraries for some subset of symbols indicated by given objects
+speclib=\
+	$(srcdir)/speclib $(toolopts) \
+	--exclude='cygwin' \
+	--exclude='(?i:dll)' \
+	--exclude='reloc' \
+	--exclude='^main$$' \
+	--exclude='^_main$$'
+
+libc.a: $(LIB_NAME) libm.a libpthread.a libutil.a
+	$(speclib) $^ -v $(@F)
+
+libm.a: $(LIB_NAME) $(newlib_build)/libm/libm.a $(MATH_OFILES)
+	$(speclib) $^ $(@F)
+
+libpthread.a: $(LIB_NAME) pthread.o thread.o libc/call_once.o libc/cnd.o \
+	      libc/mtx.o libc/thrd.o libc/tss.o
+	$(speclib) $^ $(@F)
+
+libutil.a: $(LIB_NAME) libc/bsdlib.o
+	$(speclib) $^ $(@F)
+
+libdl.a: $(LIB_NAME) dlfcn.o
+	$(speclib) $^ $(@F)
+
+libresolv.a: $(LIB_NAME) libc/minires.o
+	$(speclib) $^ $(@F)
+
+librt.a: $(LIB_NAME) posix_ipc.o
+	$(speclib) $^ $(@F)
+
+libacl.a: $(LIB_NAME) sec_posixacl.o
+	$(speclib) $^ $(@F)
+
+libssp.a: $(LIB_NAME) $(newlib_build)/libc/ssp/lib.a
+	$(speclib) $^ $(@F)
+
+#
+# all
+#
+
+all-local: $(LIB_NAME) $(TEST_LIB_NAME) $(SUBLIBS)
+
+#
+# clean
+#
+
+clean-local:
+	-rm -f $(BUILT_SOURCES)
+	-rm -f $(DEF_FILE) sigfe.s
+	-rm -f cygwin.sc cygdll.a cygwin.map $(TEST_DLL_NAME) cygwin1.dbg new-cygwin1.dll
+	-rm -f $(LIB_NAME) $(TEST_LIB_NAME) $(SUBLIBS)
+	-rm -f version.cc
+
+maintainer-clean-local:
+	-rm -f $(srcdir)/$(TLSOFFSETS_H) $(srcdir)/devices.cc
+
+#
+# install
+#
+
+man_MANS = regex/regex.3 regex/regex.7
+
+install-exec-hook: install-libs
+install-data-local: install-headers install-ldif
+
+install-libs:
+	@$(MKDIR_P) $(DESTDIR)$(bindir)
+	$(INSTALL_PROGRAM) $(TEST_DLL_NAME) $(DESTDIR)$(bindir)/$(DLL_NAME)
+	(cd $(DESTDIR)$(toollibdir) && ln -sf $(LIB_NAME) libg.a)
+
+install-headers:
+	cd $(srcdir)/include; \
+	for sub in `find . -type d -print | sort`; do \
+	    $(MKDIR_P) $(DESTDIR)$(toolincludedir)/$$sub; \
+	    for i in $$sub/*.h ; do \
+	      $(INSTALL_DATA) $$i $(DESTDIR)$(toolincludedir)/$$sub/`basename $$i` ; \
+	    done ; \
+	done ;
+
+install-ldif:
+	@$(MKDIR_P) $(DESTDIR)$(datarootdir)/cygwin
+	$(INSTALL_DATA) $(srcdir)/cygwin.ldif $(DESTDIR)$(datarootdir)/cygwin
+
+#
+# uninstall
+#
+
+uninstall-hook: uninstall-headers uninstall-ldif uninstall-libs
+
+uninstall-libs:
+	rm -f $(DESTDIR)$(bindir)/cygwin1.dll
+	rm -f $(DESTDIR)$(toollibdir)/libg.a
+
+uninstall-headers:
+	cd $(srcdir)/include; \
+	for sub in `find . -type d -print | sort`; do \
+	    for i in $$sub/*.h ; do \
+	      rm -f $(DESTDIR)$(toolincludedir)/$$sub/`basename $$i` ; \
+	    done ; \
+	done ;
+
+uninstall-ldif:
+	rm -f $(DESTDIR)$(datarootdir)/cygwin/cygwin.ldif
diff --git a/winsup/cygwin/config.h.in b/winsup/cygwin/config.h.in
index 5ddff249f..1c4940951 100644
--- a/winsup/cygwin/config.h.in
+++ b/winsup/cygwin/config.h.in
@@ -1,4 +1,4 @@
-/* config.h.in.  Generated from configure.ac by autoheader.  */
+/* cygwin/config.h.in.  Generated from configure.ac by autoheader.  */
 
 /* Define if DEBUGGING support is requested. */
 #undef DEBUGGING
diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
new file mode 100644
index 000000000..72b803c49
--- /dev/null
+++ b/winsup/doc/Makefile.am
@@ -0,0 +1,155 @@
+# -*- Makefile -*- for winsup/doc
+#
+# This file is part of Cygwin.
+#
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+man1_MANS =
+man3_MANS =
+
+doc_DATA = \
+	cygwin-ug-net/cygwin-ug-net.pdf \
+	cygwin-api/cygwin-api.pdf
+
+htmldir = $(datarootdir)/doc
+
+XMLTO=xmlto --skip-validation --with-dblatex
+DOCBOOK2XTEXI=@DOCBOOK2XTEXI@ --xinclude --info --utf8trans-map=charmap
+
+-include Makefile.dep
+
+.PHONY: install-extra-man install-etc
+
+all-local: Makefile.dep \
+	cygwin-api/cygwin-api.html \
+	cygwin-ug-net/cygwin-ug-net.html \
+	faq/faq.html faq/faq.body \
+	cygwin-ug-net/cygwin-ug-net-nochunks.html.gz \
+	api2man.stamp intro2man.stamp utils2man.stamp \
+	cygwin-api.info cygwin-ug-net.info
+
+clean-local:
+	rm -f Makefile.dep
+	rm -f *.html *.html.gz
+	rm -Rf cygwin-api cygwin-ug-net faq
+	rm -f api2man.stamp intro2man.stamp utils2man.stamp
+	rm -f *.1
+	rm -f *.3
+	rm -f *.info* charmap
+
+install-html-local: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
+	@$(MKDIR_P) $(DESTDIR)$(htmldir)/cygwin-ug-net
+	$(INSTALL_DATA) cygwin-ug-net/*.html $(DESTDIR)$(htmldir)/cygwin-ug-net
+	(cd $(DESTDIR)$(htmldir)/cygwin-ug-net && ln -f cygwin-ug-net.html index.html)
+	$(INSTALL_DATA) $(srcdir)/docbook.css $(DESTDIR)$(htmldir)/cygwin-ug-net
+	@$(MKDIR_P) $(DESTDIR)$(htmldir)/cygwin-api
+	$(INSTALL_DATA) cygwin-api/*.html $(DESTDIR)$(htmldir)/cygwin-api
+	(cd $(DESTDIR)$(htmldir)/cygwin-api && ln -f cygwin-api.html index.html)
+	$(INSTALL_DATA) $(srcdir)/docbook.css $(DESTDIR)$(htmldir)/cygwin-api
+
+install-extra-man: api2man.stamp intro2man.stamp utils2man.stamp
+	@$(MKDIR_P) $(DESTDIR)$(man1dir)
+	$(INSTALL_DATA) *.1 $(DESTDIR)$(man1dir)
+	@$(MKDIR_P) $(DESTDIR)$(man3dir)
+	$(INSTALL_DATA) *.3 $(DESTDIR)$(man3dir)
+
+install-info-local: cygwin-ug-net.info cygwin-api.info
+	@$(MKDIR_P) $(DESTDIR)$(infodir)
+	$(INSTALL_DATA) *.info* $(DESTDIR)$(infodir)
+
+install-etc:
+	@$(MKDIR_P) $(DESTDIR)$(sysconfdir)/postinstall
+	$(INSTALL_SCRIPT) $(srcdir)/etc.postinstall.cygwin-doc.sh $(DESTDIR)$(sysconfdir)/postinstall/cygwin-doc.sh
+	@$(MKDIR_P) $(DESTDIR)$(sysconfdir)/preremove
+	$(INSTALL_SCRIPT) $(srcdir)/etc.preremove.cygwin-doc.sh $(DESTDIR)$(sysconfdir)/preremove/cygwin-doc.sh
+
+install-data-hook: install-extra-man install-html-local install-info-local install-etc
+
+uninstall-extra-man:
+	for i in *.1 ; do \
+	    rm -f $(DESTDIR)$(man1dir)/$$i ; \
+	done
+	for i in *.3 ; do \
+	    rm -f $(DESTDIR)$(man3dir)/$$i ; \
+	done
+
+uninstall-html:
+	for i in cygwin-ug-net/*.html ; do \
+	    rm -f $(DESTDIR)$(htmldir)/$$i ; \
+	done ;
+	rm -f $(DESTDIR)$(htmldir)/cygwin-ug-net/index.html
+	rm -f $(DESTDIR)$(htmldir)/cygwin-ug-net/docbook.css
+	for i in cygwin-api/*.html ; do \
+	    rm -f $(DESTDIR)$(htmldir)/$$i ; \
+	done ;
+	rm -f $(DESTDIR)$(htmldir)/cygwin-api/index.html
+	rm -f $(DESTDIR)$(htmldir)/cygwin-api/docbook.css
+
+uninstall-info:
+	for i in *.info* ; do \
+	    rm -f $(DESTDIR)$(infodir)/$$i ; \
+	done ;
+
+uninstall-etc:
+	rm -f $(DESTDIR)$(sysconfdir)/postinstall/cygwin-doc.sh
+	rm -f $(DESTDIR)$(sysconfdir)/preremove/cygwin-doc.sh
+
+uninstall-hook: uninstall-extra-man uninstall-html uninstall-info uninstall-etc
+
+# nochunks ug html is not installed, but will be deployed to website
+cygwin-ug-net/cygwin-ug-net-nochunks.html.gz: $(cygwin-ug-net_SOURCES) html.xsl
+	$(XMLTO) html-nochunks -m $(srcdir)/html.xsl $<
+	@$(MKDIR_P) cygwin-ug-net
+	cp cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html
+	rm -f cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
+	gzip cygwin-ug-net/cygwin-ug-net-nochunks.html
+
+cygwin-ug-net/cygwin-ug-net.html: $(cygwin-ug-net_SOURCES) html.xsl
+	$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/html.xsl $<
+
+cygwin-ug-net/cygwin-ug-net.pdf: $(cygwin-ug-net_SOURCES) fo.xsl
+	$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $<
+
+utils2man.stamp: $(cygwin-ug-net_SOURCES) man.xsl
+	$(XMLTO) man -m $(srcdir)/man.xsl $<
+	@touch $@
+
+cygwin-ug-net.info: $(cygwin-ug-net_SOURCES) charmap
+	$(DOCBOOK2XTEXI) $(srcdir)/cygwin-ug-net.xml --string-param output-file=cygwin-ug-net
+
+cygwin-api/cygwin-api.html: $(cygwin-api_SOURCES) html.xsl
+	$(XMLTO) html -o cygwin-api/ -m $(srcdir)/html.xsl $<
+
+cygwin-api/cygwin-api.pdf: $(cygwin-api_SOURCES) fo.xsl
+	$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $<
+
+api2man.stamp: $(cygwin-api_SOURCES) man.xsl
+	$(XMLTO) man -m $(srcdir)/man.xsl $<
+	@touch $@
+
+cygwin-api.info: $(cygwin-api_SOURCES) charmap
+	$(DOCBOOK2XTEXI) $(srcdir)/cygwin-api.xml --string-param output-file=cygwin-api
+
+# this generates a custom charmap for docbook2x-texi which has a mapping for &reg;
+charmap:
+	cp /usr/share/docbook2X/charmaps/texi.charmap charmap
+	echo "ae (R)" >>charmap
+
+intro2man.stamp: intro.xml man.xsl
+	$(XMLTO) man -m $(srcdir)/man.xsl $<
+	@echo ".so intro.1" >cygwin.1
+	@touch $@
+
+faq/faq.html: $(faq_SOURCES) html.xsl
+	$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
+	sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
+
+# faq body is not installed, but is intended to be deployed to website, where it
+# can be SSI included in a framing page
+faq/faq.body: faq/faq.html
+	$(srcdir)/bodysnatcher.pl $<
+
+Makefile.dep: cygwin-ug-net.xml cygwin-api.xml faq.xml intro.xml
+	cd $(srcdir) && ./xidepend $^ > "$(CURDIR)/$@"
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
new file mode 100644
index 000000000..4b8c7dbb7
--- /dev/null
+++ b/winsup/testsuite/Makefile.am
@@ -0,0 +1,64 @@
+# Makefile.am for Cygwin's testsuite.
+#
+# This file is part of Cygwin.
+#
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+# This makefile requires GNU make.
+
+noinst_LIBRARIES = libltp.a
+
+libltp_a_CPPFLAGS=-I$(srcdir)/libltp/include
+
+libltp_a_SOURCES = \
+	libltp/lib/dataascii.c \
+	libltp/lib/databin.c \
+	libltp/lib/datapid.c \
+	libltp/lib/forker.c \
+	libltp/lib/get_high_address.c \
+	libltp/lib/libtestsuite.c \
+	libltp/lib/open_flags.c \
+	libltp/lib/parse_opts.c \
+	libltp/lib/pattern.c \
+	libltp/lib/rmobj.c \
+	libltp/lib/search_path.c \
+	libltp/lib/str_to_bytes.c \
+	libltp/lib/string_to_tokens.c \
+	libltp/lib/tst_res.c \
+	libltp/lib/tst_sig.c \
+	libltp/lib/tst_tmpdir.c \
+	libltp/lib/write_log.c
+
+DEJATOOL = winsup
+
+# Add '-v' to RUNTESTFLAGS if V=1
+RUNTESTFLAGS_1 = -v
+RUNTESTFLAGS = $(RUNTESTFLAGS_$(V))
+
+# a temporary directory, to be used for files created by tests
+tmpdir = $(abspath $(objdir)/testsuite/tmp/)
+# the same temporary directory, as an absolute, /cygdrive path (so it can be
+# understood by the test DLL, which will have a different mount table)
+testdll_tmpdir = $(shell cygpath -ma $(tmpdir) | sed -e 's#^\([A-Z]\):#/cygdrive/\L\1#')
+
+site-extra.exp: ../config.status Makefile
+	@rm -f ./tmp0
+	@echo "set runtime_root \"`pwd`/../cygwin\"" >> ./tmp0
+	@echo "set CC \"$(CC)\"" >> ./tmp0
+	@echo "set CFLAGS \"\"" >> ./tmp0
+	@echo "set MINGW_CXX \"$(MINGW_CXX)\"" >> ./tmp0
+	@echo "set tmpdir $(tmpdir)" >> ./tmp0
+	@echo "set testdll_tmpdir $(testdll_tmpdir)" >> ./tmp0
+	@echo "set ltp_includes \"$(srcdir)/libltp/include\"" >> ./tmp0
+	@echo "set ltp_libs \"`pwd`/libltp.a\"" >> ./tmp0
+	@echo "set cygrun \"`pwd`/cygrun/cygrun\"" >> ./tmp0
+	@mv ./tmp0 site-extra.exp
+
+EXTRA_DEJAGNU_SITE_CONFIG = site-extra.exp
+
+clean-local:
+	rm -f *.log *.exe *.exp *.bak *.stackdump winsup.sum
+
+SUBDIRS = cygrun
diff --git a/winsup/testsuite/config/default.exp b/winsup/testsuite/config/default.exp
index 3936979a6..28c614187 100644
--- a/winsup/testsuite/config/default.exp
+++ b/winsup/testsuite/config/default.exp
@@ -1,7 +1,7 @@
 proc winsup_version {} {
     global env
-    global rootme
-    clone_output "\n[exec grep ^%%% $rootme/../cygwin/cygwin0.dll]\n"
+    global runtime_root
+    clone_output "\n[exec grep ^%%% $runtime_root/cygwin0.dll]\n"
     if { [info exists env(CYGWIN)] } {
         clone_output "CYGWIN=$env(CYGWIN)\n"
     } else {
diff --git a/winsup/testsuite/cygrun/Makefile.am b/winsup/testsuite/cygrun/Makefile.am
new file mode 100644
index 000000000..eb3b41224
--- /dev/null
+++ b/winsup/testsuite/cygrun/Makefile.am
@@ -0,0 +1,21 @@
+# Makefile.am for Cygwin the testsuite wrapper cygrun.
+#
+# This file is part of Cygwin.
+#
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+# This makefile requires GNU make.
+
+# This is built with the MinGW compiler, so is in a separate Makefile here
+# because it's tricky with Automake to use different compilers for the same
+# language in the same Makefile.
+
+override CC = @MINGW_CC@
+INCLUDES =
+
+noinst_PROGRAMS = cygrun
+
+cygrun_SOURCES = \
+	../cygrun.c
diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
index 4978136a1..584aa5755 100644
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ b/winsup/testsuite/winsup.api/winsup.exp
@@ -9,13 +9,15 @@ if { ! [isnative] } {
 set rv ""
 
 set ltp_includes "-I$ltp_includes"
-set ltp_libs "$rootme/libltp.a"
+set ltp_libs "$ltp_libs"
 
 set add_includes $ltp_includes
 set add_libs $ltp_libs
 
 set test_filter ""
 
+set env(PATH) "$runtime_root:$env(PATH)"
+
 if { [info exists env(CYGWIN_TESTSUITE_TESTS)] } {
     set test_filter "$env(CYGWIN_TESTSUITE_TESTS)"
 }
@@ -69,7 +71,7 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
 	       set redirect_output /dev/null
 	    }
 	    file mkdir $tmpdir/$base
-	    ws_spawn "$rootme/cygrun ./$base.exe $testdll_tmpdir/$base > $redirect_output"
+	    ws_spawn "$cygrun ./$base.exe $testdll_tmpdir/$base > $redirect_output"
 	    file delete -force $tmpdir/$base
 	    if { $rv } {
 		fail "$testcase (execute)"
diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
new file mode 100644
index 000000000..0b974a1fd
--- /dev/null
+++ b/winsup/utils/Makefile.am
@@ -0,0 +1,79 @@
+# Makefile for Cygwin utilities
+
+# This file is part of Cygwin.
+
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+include $(top_srcdir)/Makefile.am.common
+
+CFLAGS_COMMON=-Wimplicit-fallthrough=4 -Werror
+AM_CFLAGS=$(cflags_common) $(CFLAGS_COMMON)
+AM_CXXFLAGS=$(cxxflags_common) $(CFLAGS_COMMON)
+
+bin_PROGRAMS = \
+	chattr \
+	cygpath \
+	gencat \
+	getconf \
+	getfacl \
+	kill \
+	ldd \
+	locale \
+	lsattr \
+	minidumper \
+	mkgroup \
+	mkpasswd \
+	mount \
+	passwd \
+	pldd \
+	ps \
+	regtool \
+	setfacl \
+	setmetamode \
+	ssp \
+	tzset \
+	umount
+
+# dumper is only built if libbfd.a available
+if BUILD_DUMPER
+bin_PROGRAMS += dumper
+endif
+
+# If prog_SOURCES is not specified, automake defaults to the single file prog.c
+cygpath_SOURCES = cygpath.cc
+dumper_SOURCES = dumper.cc module_info.cc
+kill_SOURCES = kill.cc
+ldd_SOURCES = ldd.cc
+locale_SOURCES = locale.cc
+minidumper_SOURCES = minidumper.cc
+mount_SOURCES = mount.cc path.cc
+ps_SOURCES = ps.cc
+regtool_SOURCES = regtool.cc
+umount_SOURCES = umount.cc
+
+# rules to create/update tzmap.h from an online resource
+.PHONY: tzmap
+tzmap:
+	$(srcdir)/tzmap-from-unicode.org > $(srcdir)/$@.h
+
+tzmap.h:
+	[ -f "$(srcdir)/tzmap.h" ] || $(srcdir)/tzmap-from-unicode.org > $(srcdir)/$@
+
+AM_LDFLAGS = -static -Wl,--enable-auto-import
+LDADD = -lnetapi32
+
+cygpath_CXXFLAGS = -fno-threadsafe-statics $(AM_CXXFLAGS)
+cygpath_LDADD = $(LDADD) -luserenv -lntdll
+dumper_CXXFLAGS = -I$(top_srcdir)/../include $(AM_CXXFLAGS)
+dumper_LDADD = $(LDADD) -lpsapi -lbfd -lintl -liconv -liberty -lz -lntdll
+ldd_LDADD = $(LDADD) -lpsapi -lntdll
+mount_CXXFLAGS = -DFSTAB_ONLY $(AM_CXXFLAGS)
+minidumper_LDADD = $(LDADD) -ldbghelp
+pldd_LDADD = $(LDADD) -lpsapi
+ps_LDADD = $(LDADD) -lpsapi -lntdll
+
+if CROSS_BOOTSTRAP
+SUBDIRS = mingw
+endif
diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
new file mode 100644
index 000000000..dca7f09dc
--- /dev/null
+++ b/winsup/utils/mingw/Makefile.am
@@ -0,0 +1,50 @@
+# Makefile for Cygwin utilities
+
+# This file is part of Cygwin.
+
+# This software is a copyrighted work licensed under the terms of the
+# Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+# details.
+
+# We put utilities built with a MinGW compiler in a separate Makefile here
+# because it's tricky with Automake to use different compilers for the same
+# language in the same Makefile.
+
+override CXX = @MINGW_CXX@
+INCLUDES =
+
+include $(top_srcdir)/Makefile.am.common
+
+CFLAGS_COMMON=-Wimplicit-fallthrough=4 -Werror
+AM_CXXFLAGS=-fno-exceptions -fno-rtti -fno-use-cxa-atexit $(flags_common) $(CFLAGS_COMMON)
+
+bin_PROGRAMS = \
+	cygcheck \
+	cygwin-console-helper \
+	ldh \
+	strace
+
+cygcheck_SOURCES = \
+	../bloda.cc \
+	../cygcheck.cc \
+	../dump_setup.cc \
+	../path.cc
+cygcheck_LDADD = -lz -lwininet -lpsapi -lntdll
+
+cygwin_console_helper_SOURCES = ../cygwin-console-helper.cc
+
+ldh_SOURCES = ../ldh.cc
+
+strace_SOURCES = \
+	../path.cc \
+	../strace.cc
+strace_LDADD = -lntdll
+
+noinst_PROGRAMS = path-testsuite
+
+path_testsuite_SOURCES = \
+	../path.cc \
+	../testsuite.cc
+path_testsuite_CXXFLAGS = -DTESTSUITE -Wno-error=write-strings
+
+TESTS = path-testsuite
-- 
2.29.2

