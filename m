Return-Path: <cygwin-patches-return-7723-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1168 invoked by alias); 17 Oct 2012 16:13:30 -0000
Received: (qmail 1149 invoked by uid 22791); 17 Oct 2012 16:13:27 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,KHOP_RCVD_TRUST,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_LG,TW_WC,TW_YG
X-Spam-Check-By: sourceware.org
Received: from mail-ea0-f171.google.com (HELO mail-ea0-f171.google.com) (209.85.215.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 17 Oct 2012 16:13:20 +0000
Received: by mail-ea0-f171.google.com with SMTP id k14so1877657eaa.2        for <cygwin-patches@cygwin.com>; Wed, 17 Oct 2012 09:13:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.14.221.194 with SMTP id r42mr14187982eep.25.1350490398788; Wed, 17 Oct 2012 09:13:18 -0700 (PDT)
Received: by 10.14.213.134 with HTTP; Wed, 17 Oct 2012 09:13:18 -0700 (PDT)
Date: Wed, 17 Oct 2012 16:13:00 -0000
Message-ID: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>
Subject: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: Kai Tietz <ktietz70@googlemail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=047d7b66f6097e0b0104cc438c33
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00000.txt.bz2


--047d7b66f6097e0b0104cc438c33
Content-Type: text/plain; charset=ISO-8859-1
Content-length: 14131

Hello everybody,

This patch modifies the bits of build-process so that cygwin and mingw
building is decoupled from each other.
Additionally the patch decouples cygwin's build from the w32api of mingw.org.
By this change it is now possible to build cygwin (and utilities) with
mingw.org's and mingw-w64's psdk and compilers.  Later are necessary
to build cygwin's native utils, which have not to depend on
cygwin1.dll.
These changes are also necessary for having 64-bit build support in
future. By this reason the mingw-script in utils/ had to learn about
the host's architecture and about how to search for an installed
mingw-toolchain for given architecture.  As Corinna told me that
cygwin wants to use in question the -w64- mingw-environment, this
script is searching first for -w64- based toolchain.  On second
attempt it searches for any mingw triplet for given architecture.


ChangeLog winsup/

2012-10-17  Kai Tietz

	* Makefile.common: Remove w32api specific internal
	configure.
	(nostdincxx): Always turn off default libraries.
	* Makefile.in: Remove for cygwin build dependencies
	to w32api and mingw.
	* configure.in: Make test for w32api directory optional.

ChangeLog lsaauth/

2012-10-17  Kai Tietz

	* Makefile.in (WIN32_INCLUDES): Remove use of
	w32api_include and w32api_include.

ChangeLog utils/

2012-10-17  Kai Tietz

	* Makefile.in (HOST_CPU): New variable.
	(MINGW_CXX): Inster HOST_CPU argument on call of the mingw script.
	(ALL_LDFLAGS, ALL_DEP_LDLIBS): Remove w32api dependencies.
	(MINGW_BINS): Change dependency from MINGW_DEP_LDLIBS to ALL_DEP_LDLIBS.
	(MINGW_LIB): Removed.
	* configure.in (HOST_CPU): Set Makefile.in's HOST_CPU variable.
	* mingw: Extend script to handle architecture dependent cross-compiler
	  setup.

Tested for i686-pc-cygwin build.  Ok for apply?

Regards,
Kai


Index: winsup/Makefile.common
===================================================================
RCS file: /cvs/src/src/winsup/Makefile.common,v
retrieving revision 1.59
diff -p -u -3 -r1.59 Makefile.common
--- winsup/Makefile.common	30 Jul 2012 04:43:21 -0000	1.59
+++ winsup/Makefile.common	17 Oct 2012 15:21:32 -0000
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

-mingw_include:=${shell [ -d "$(mingw_source)/include" ] && echo
"-I$(mingw_source)/include"}
-ifneq (,$(mingw_include))
 nostdlib:=-nostdlib
-else
-nostdlib:=
-endif

 ifeq (,${nostdlib})
 nostdinc:=
 endif

-INCLUDES:=-I. $(cygwin_include) -I$(cygwin_source) $(newlib_include)
$(w32api_include)
+INCLUDES:=-I. $(cygwin_include) -I$(cygwin_source) $(newlib_include)
 ifdef CONFIG_DIR
 INCLUDES+=-I$(CONFIG_DIR)
 endif

-MINGW_INCLUDES:=${mingw_include} $(w32api_include)
-MINGW_CFLAGS:=-mno-cygwin $(MINGW_INCLUDES)
-MINGW_CXXFLAGS:=${filter-out $(newlib_source)/%,$(CXXFLAGS)}
-mno-cygwin $(MINGW_INCLUDES)
-MINGW_LDFLAGS:=-L${mingw_build} -L${mingw_build}/mingwex
+MINGW_LDFLAGS:=
+MINGW_CFLAGS:=
+MINGW_CXXFLAGS:=${filter-out $(newlib_source)/%,$(CXXFLAGS)}

 GCC_DEFAULT_OPTIONS:=$(CFLAGS_COMMON) $(CFLAGS_CONFIG) $(INCLUDES)

@@ -134,7 +118,7 @@ COMPILE_CXX=$(CXX) $c $(if $($(*F)_STDIN
 	     $(ALL_CXXFLAGS) $(GCC_INCLUDE) -fno-rtti -fno-exceptions
 COMPILE_CC=$(CC) $c $(if $($(*F)_STDINCFLAGS),,$(nostdinc))
$(ALL_CFLAGS) $(GCC_INCLUDE)

-vpath %.a	$(cygwin_build):$(w32api_lib):$(newlib_build)/libc:$(newlib_build)/libm
+vpath %.a	$(cygwin_build):$(newlib_build)/libc:$(newlib_build)/libm

 MAKEOVERRIDES_WORKAROUND=${wordlist 2,1,a b c}

Index: winsup/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/Makefile.in,v
retrieving revision 1.33
diff -p -u -3 -r1.33 Makefile.in
--- winsup/Makefile.in	24 Feb 2009 02:11:13 -0000	1.33
+++ winsup/Makefile.in	17 Oct 2012 15:21:32 -0000
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
diff -p -u -3 -r1.33 configure.in
--- winsup/configure.in	29 Jan 2011 06:41:28 -0000	1.33
+++ winsup/configure.in	17 Oct 2012 15:21:32 -0000
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
Index: winsup/lsaauth/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/lsaauth/Makefile.in,v
retrieving revision 1.6
diff -p -u -3 -r1.6 Makefile.in
--- winsup/lsaauth/Makefile.in	29 May 2012 12:46:01 -0000	1.6
+++ winsup/lsaauth/Makefile.in	17 Oct 2012 15:21:33 -0000
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
diff -p -u -3 -r1.100 Makefile.in
--- winsup/utils/Makefile.in	11 Jul 2012 16:41:51 -0000	1.100
+++ winsup/utils/Makefile.in	17 Oct 2012 15:21:33 -0000
@@ -28,6 +28,7 @@ EXEEXT_FOR_BUILD:=@EXEEXT_FOR_BUILD@
 CC:=@CC@
 CC_FOR_TARGET:=$(CC)
 CXX:=@CXX@
+HOST_CPU=@HOST_CPU@
 CXX_FOR_TARGET:=$(CXX)

 CFLAGS:=@CFLAGS@
@@ -40,15 +41,11 @@ include $(srcdir)/../Makefile.common
 .NOEXPORT:
 .PHONY: all install clean realclean warn_dumper warn_cygcheck_zlib

-ALL_LDLIBS     := -lnetapi32 -ladvapi32
-ALL_LDFLAGS    := -static-libgcc -Wl,--enable-auto-import
-B$(newlib_build)/libc -B$(w32api_lib) $(LDFLAGS) $(ALL_LDLIBS)
-ALL_DEP_LDLIBS := $(cygwin_build)/libcygwin.a ${patsubst -l%,\
-                    $(w32api_lib)/lib%.a,$(ALL_LDLIBS) -lkernel32 -luser32}
-
-MINGW_LIB        := $(mingw_build)/libmingw32.a
-MINGW_LDLIBS     := $(ALL_LDLIBS) $(MINGW_LIB)
-MINGW_DEP_LDLIBS := $(ALL_DEP_LDLIBS) $(MINGW_LIB)
-MINGW_CXX        := ${srcdir}/mingw ${CXX} -I${updir}
+ALL_LDLIBS     := -lnetapi32 -ladvapi32 -lkernel32 -luser32
+ALL_LDFLAGS    := -static-libgcc -Wl,--enable-auto-import
-B$(newlib_build)/libc $(LDFLAGS) $(ALL_LDLIBS)
+ALL_DEP_LDLIBS := $(cygwin_build)/libcygwin.a
+
+MINGW_CXX        := ${srcdir}/mingw ${HOST_CPU} ${CXX} -I${updir}

 # List all binaries to be linked in Cygwin mode.  Each binary on this list
 # must have a corresponding .o of the same name.
@@ -83,7 +80,6 @@ strace.exe: MINGW_LDFLAGS += -lntdll
 ldd.exe: ALL_LDFLAGS += -lpsapi
 pldd.exe: ALL_LDFLAGS += -lpsapi

-ldh.exe: MINGW_LDLIBS :=
 ldh.exe: MINGW_LDFLAGS := -nostdlib -lkernel32

 # Check for dumper's requirements and enable it if found.
@@ -142,10 +138,10 @@ endif
 # how to link a MinGW binary
 $(MINGW_BINS): %.exe: %.o
 ifdef VERBOSE
-	$(MINGW_CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^}
-B$(mingw_build)/ $(MINGW_LDFLAGS)
+	$(MINGW_CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} $(MINGW_LDFLAGS)
 else
 	@echo $(MINGW_CXX) -o $@ ${filter %.o,$^} ${filter-out -B%,
$(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)};\
-	$(MINGW_CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^}
-B$(mingw_build)/ $(MINGW_LDFLAGS)
+	$(MINGW_CXX) $(MINGW_CXXFLAGS) -o $@ ${filter %.o,$^} $(MINGW_LDFLAGS)
 endif

 # how to link a Cygwin binary
@@ -160,7 +156,7 @@ endif
 # note: how to compile a Cygwin object is covered by the pattern rule
in Makefile.common

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
diff -p -u -3 -r1.9 configure.in
--- winsup/utils/configure.in	25 Jul 2008 15:03:25 -0000	1.9
+++ winsup/utils/configure.in	17 Oct 2012 15:21:33 -0000
@@ -23,6 +23,9 @@ AC_ARG_PROGRAM
 AC_CHECK_LIB(iconv, libiconv, libiconv=-liconv)
 AC_SUBST(libiconv)

+HOST_CPU="$host_cpu"
+AC_SUBST(HOST_CPU)
+
 INSTALL="/bin/sh "`cd $srcdir/../..; echo $(pwd)/install-sh -c`

 AC_PROG_INSTALL
Index: winsup/utils/mingw
===================================================================
RCS file: /cvs/src/src/winsup/utils/mingw,v
retrieving revision 1.8
diff -p -u -3 -r1.8 mingw
--- winsup/utils/mingw	14 Jun 2011 15:04:04 -0000	1.8
+++ winsup/utils/mingw	17 Oct 2012 15:21:33 -0000
@@ -5,17 +5,82 @@
 #
 # Find the path to the compiler.
 #
+cpu=$1; shift
 compiler=$1; shift
 dir=$(cd $(dirname $("$compiler" -print-prog-name=ld))/../..; pwd)

 #
+# Find the tool's name without the target-prefix
+#
+case $compiler in
+*-*-*-*)
+tool=`echo "$compiler" | sed 's/^\([^-]*\)-\([^-]*\)-\([^-]*\)-\(.*\)$/\4/'` ;;
+*) tool=compiler ;;
+esac
+
+#
 # The mingw32 directory should live somewhere close by to the
 # compiler.  Search for it.
 #
-[ "$dir" = '/' ] && dir=''
+[ "$dir" = '/' ] && dir='';
+
+mingw_compiler=''
+
+#
+# We search first for installed *-w64-mingw* toolchain with adequate
+# architecture.  We don't consider to check secondary target for
+# multilib toolchains here.
+#
+for d in "$dir"/bin/"$cpu"-w64-mingw*-"$tool"* \
+        "$dir"/usr/bin/"$cpu"-w64-mingw*-"$tool"* \
+        /bin/"$cpu"-w64-mingw*-"$tool"* /usr/bin/"$cpu"-w64-mingw*-"$tool"* \
+        /usr/local/bin/"$cpu"-w64-mingw*-"$tool"* \
+        "$dir"/"$cpu"-w64-mingw*/sys-root/bin/"$cpu"-w64-mingw*-"$tool"* \
+        "$dir"/usr/"$cpu"-w64-mingw*/sys-root/bin/"$cpu"-w64-mingw*-"$tool"* \
+        /"$cpu"-w64-mingw*/sys-root/bin/"$cpu"-w64-mingw*-"$tool"* \
+        /usr/"$cpu"-w64-mingw*/sys-root/bin/"$cpu"-w64-mingw*-"$tool"*; do
+    case "$d" in
+        *\**) continue ;;
+        *)
+           if test -f "$d"; then
+             mingw_compiler=$d;
+             break;
+           fi
+    esac
+done
+
+#
+# If we didn't found an installed *-w64-mingw* toolchain for architecture
+# cpu, we search for a *-mingw* toolchain.
+#
+if [ -z "$mingw_compiler" ]; then
+  for d in "$dir"/bin/"$cpu"-*-mingw*--"$tool"* \
+        "$dir"/usr/bin/"$cpu"-*-mingw*-"$tool"* \
+        /bin/"$cpu"-w64-mingw*-"$tool"* /usr/bin/"$cpu"-w64-mingw*-"$tool"* \
+        /usr/local/bin/"$cpu"-w64-mingw*-"$tool"* \
+        "$dir"/"$cpu"-w64-mingw*/sys-root/bin/"$cpu"-w64-mingw*-"$tool"* \
+        "$dir"/usr/"$cpu"-w64-mingw*/sys-root/bin/"$cpu"-w64-mingw*-"$tool"* \
+        /"$cpu"-w64-mingw*/sys-root/bin/"$cpu"-w64-mingw*-"$tool"* \
+        /usr/"$cpu"-w64-mingw*/sys-root/bin/"$cpu"-w64-mingw*-"$tool"*; do
+    case "$d" in
+        *\**) continue ;;
+        *)
+           if test -f "$d"; then
+             mingw_compiler=$d;
+             break;
+           fi
+    esac
+  done
+fi
+
+#
+# Search for mingw's sys-root.  Again, first for -w64-mingw* toolchain ...
+#
 mingw_dir=''
-for d in "$dir"/*-mingw32 "$dir"/usr/*-mingw32 "$dir"/*-mingw*
"$dir"/usr/*-mingw* \
-         /*-mingw32 /usr/*-mingw32 /*-mingw* /usr/*-mingw*; do
+for d in "$dir"/"$cpu"-w64-mingw* "$dir"/usr/"$cpu"-w64-mingw* \
+        "$dir"/"$cpu"-w64-mingw* "$dir"/usr/"$cpu"-w64-mingw* \
+        /"$cpu"-w64-mingw* /usr/"$cpu"-w64-mingw* /"$cpu"-w64-mingw* \
+        /usr/"$cpu"-w64-mingw*; do
     case "$d" in
 	*\**)	continue ;;
 	*)	if [ -d "$d"/sys-root/mingw ]; then
@@ -26,8 +91,33 @@ for d in "$dir"/*-mingw32 "$dir"/usr/*-m
     esac
 done

+#
+# ... else for *-mingw* toolchain.
+if [ -z "$mingw_dir" ]; then
+  for d in "$dir"/"$cpu"-*-mingw* "$dir"/usr/"$cpu"-*-mingw* \
+        "$dir"/"$cpu"-*-mingw* "$dir"/usr/"$cpu"-*-mingw* \
+        /"$cpu"-*-mingw* /usr/"$cpu"-*-mingw* /"$cpu"-*-mingw* \
+        /usr/"$cpu"-*-mingw*; do
+    case "$d" in
+        *\**)   continue ;;
+        *)      if [ -d "$d"/sys-root/mingw ]; then
+                    mingw_dir=$d/sys-root/mingw
+                else
+                    mingw_dir=$d;
+                fi; break;
+    esac
+  done
+fi
+
+if [ -z "$mingw_compiler" ]; then
+  mingw_compiler=$compiler
+fi
+
+#
+# Check if mingw's sys-root directory could be detected
+#
 if [ -z "$mingw_dir" ]; then
-    echo "$0: couldn't find i686-pc-mingw32 directory" 1>&2
+    echo "$0: couldn't find $cpu-*-mingw32 directory" 1>&2
     exit 1
 fi

@@ -90,10 +180,10 @@ fi
 if sawofile || ! sawcfile || ! sawcomp; then
     w32api=$($compiler -print-file-name=libc.a)
     w32api=$(cd $(dirname "$w32api")/w32api; pwd)
-    set -- -Wl,-nostdlib -L"${w32api}" "$@"
+    set -- -Wl,-nostdlib -B"${w32api}" "$@"
     ! sawnostdlib && set -- -nostdlib "$@" -lmingw32 -lgcc -lmoldname
-lmingwex -lmsvcrt -lmingw32 -luser32 -lkernel32 -ladvapi32 -lshell32
-lmingw32 -lgcc -lmoldname -lmingwex -lmsvcrt
     ! sawnostdlib && ! sawshared && { sawofile || sawcfile; } && set
-- "$mingw_dir"/lib/crt2.o "$@"
 fi

 # Execute the compiler with new mingw-specific options.
-exec $compiler "$@"
+exec $mingw_compiler "$@"

--047d7b66f6097e0b0104cc438c33
Content-Type: text/plain; charset=US-ASCII; name="build_patch.txt"
Content-Disposition: attachment; filename="build_patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h8en30de0
Content-length: 16743

SW5kZXg6IHdpbnN1cC9NYWtlZmlsZS5jb21tb24KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9NYWtlZmls
ZS5jb21tb24sdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNTkKZGlmZiAtcCAt
dSAtMyAtcjEuNTkgTWFrZWZpbGUuY29tbW9uCi0tLSB3aW5zdXAvTWFrZWZp
bGUuY29tbW9uCTMwIEp1bCAyMDEyIDA0OjQzOjIxIC0wMDAwCTEuNTkKKysr
IHdpbnN1cC9NYWtlZmlsZS5jb21tb24JMTcgT2N0IDIwMTIgMTU6MjE6MzIg
LTAwMDAKQEAgLTcyLDM4ICs3MiwyMiBAQCBpZmVxICgsJHtmaW5kc3RyaW5n
ICQoY3lnd2luX3NvdXJjZSkvaW5jCiBjeWd3aW5faW5jbHVkZTo9LUkkKGN5
Z3dpbl9zb3VyY2UpL2luY2x1ZGUKIGVuZGlmCiAKLSMgVHJ5IHRvIGRldGVy
bWluZSB3aGF0IGRpcmVjdG9yaWVzIGFyZSBhdmFpbGFibGUgaW4gd2luc3Vw
LgotIyBBdHRlbXB0IHRvIHByb3Blcmx5IGRldGVjdCBtaXNzaW5nIG1pbmd3
IG9yIHczMmFwaSBhbmQgYWRqdXN0IGNvbW1hbmQKLSMgbGluZSBwYXJhbWV0
ZXJzIGFwcHJvcHJpYXRlbHkKLQotIyBub3N0ZGluYzo9JHtzaGVsbCBbIC1k
ICIkKHVwZGlyKS93MzJhcGkiIF0gJiYgZWNobyAiLW5vc3RkaW5jIn0KLSMg
aWZuZXEgKCwkKG5vc3RkaW5jKSkKIG5vc3RkaW5jeHg6PS1ub3N0ZGluYysr
Ci0jIGlmZXEgKCwke2ZpbmRzdHJpbmcgJCh3MzJhcGlfc291cmNlKSwkKENG
TEFHUykgJChDWFhGTEFHUykgJChDWFgpICQoQ0MpfSkKLXczMmFwaV9pbmNs
dWRlOj0tSSQodzMyYXBpX3NvdXJjZSkvaW5jbHVkZQotIyBlbmRpZgotIyBl
bmRpZgogCi1taW5nd19pbmNsdWRlOj0ke3NoZWxsIFsgLWQgIiQobWluZ3df
c291cmNlKS9pbmNsdWRlIiBdICYmIGVjaG8gIi1JJChtaW5nd19zb3VyY2Up
L2luY2x1ZGUifQotaWZuZXEgKCwkKG1pbmd3X2luY2x1ZGUpKQogbm9zdGRs
aWI6PS1ub3N0ZGxpYgotZWxzZQotbm9zdGRsaWI6PQotZW5kaWYKIAogaWZl
cSAoLCR7bm9zdGRsaWJ9KQogbm9zdGRpbmM6PQogZW5kaWYKIAotSU5DTFVE
RVM6PS1JLiAkKGN5Z3dpbl9pbmNsdWRlKSAtSSQoY3lnd2luX3NvdXJjZSkg
JChuZXdsaWJfaW5jbHVkZSkgJCh3MzJhcGlfaW5jbHVkZSkKK0lOQ0xVREVT
Oj0tSS4gJChjeWd3aW5faW5jbHVkZSkgLUkkKGN5Z3dpbl9zb3VyY2UpICQo
bmV3bGliX2luY2x1ZGUpCiBpZmRlZiBDT05GSUdfRElSCiBJTkNMVURFUys9
LUkkKENPTkZJR19ESVIpCiBlbmRpZgogCi1NSU5HV19JTkNMVURFUzo9JHtt
aW5nd19pbmNsdWRlfSAkKHczMmFwaV9pbmNsdWRlKQotTUlOR1dfQ0ZMQUdT
Oj0tbW5vLWN5Z3dpbiAkKE1JTkdXX0lOQ0xVREVTKQotTUlOR1dfQ1hYRkxB
R1M6PSR7ZmlsdGVyLW91dCAkKG5ld2xpYl9zb3VyY2UpLyUsJChDWFhGTEFH
Uyl9IC1tbm8tY3lnd2luICQoTUlOR1dfSU5DTFVERVMpCi1NSU5HV19MREZM
QUdTOj0tTCR7bWluZ3dfYnVpbGR9IC1MJHttaW5nd19idWlsZH0vbWluZ3dl
eAorTUlOR1dfTERGTEFHUzo9CitNSU5HV19DRkxBR1M6PQorTUlOR1dfQ1hY
RkxBR1M6PSR7ZmlsdGVyLW91dCAkKG5ld2xpYl9zb3VyY2UpLyUsJChDWFhG
TEFHUyl9CiAKIEdDQ19ERUZBVUxUX09QVElPTlM6PSQoQ0ZMQUdTX0NPTU1P
TikgJChDRkxBR1NfQ09ORklHKSAkKElOQ0xVREVTKQogCkBAIC0xMzQsNyAr
MTE4LDcgQEAgQ09NUElMRV9DWFg9JChDWFgpICRjICQoaWYgJCgkKCpGKV9T
VERJTgogCSAgICAgJChBTExfQ1hYRkxBR1MpICQoR0NDX0lOQ0xVREUpIC1m
bm8tcnR0aSAtZm5vLWV4Y2VwdGlvbnMKIENPTVBJTEVfQ0M9JChDQykgJGMg
JChpZiAkKCQoKkYpX1NURElOQ0ZMQUdTKSwsJChub3N0ZGluYykpICQoQUxM
X0NGTEFHUykgJChHQ0NfSU5DTFVERSkKIAotdnBhdGggJS5hCSQoY3lnd2lu
X2J1aWxkKTokKHczMmFwaV9saWIpOiQobmV3bGliX2J1aWxkKS9saWJjOiQo
bmV3bGliX2J1aWxkKS9saWJtCit2cGF0aCAlLmEJJChjeWd3aW5fYnVpbGQp
OiQobmV3bGliX2J1aWxkKS9saWJjOiQobmV3bGliX2J1aWxkKS9saWJtCiAK
IE1BS0VPVkVSUklERVNfV09SS0FST1VORD0ke3dvcmRsaXN0IDIsMSxhIGIg
Y30KIApJbmRleDogd2luc3VwL01ha2VmaWxlLmluCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvTWFrZWZp
bGUuaW4sdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzMKZGlmZiAtcCAtdSAt
MyAtcjEuMzMgTWFrZWZpbGUuaW4KLS0tIHdpbnN1cC9NYWtlZmlsZS5pbgky
NCBGZWIgMjAwOSAwMjoxMToxMyAtMDAwMAkxLjMzCisrKyB3aW5zdXAvTWFr
ZWZpbGUuaW4JMTcgT2N0IDIwMTIgMTU6MjE6MzIgLTAwMDAKQEAgLTEyMSwy
MCArMTIxLDIwIEBAIGNoZWNrOiBjeWd3aW4KIAlmaTsgXAogCSQoTUFLRSkg
Y2hlY2sKIAotdXRpbHM6IGN5Z3dpbiBtaW5ndwordXRpbHM6IGN5Z3dpbgog
CiBtaW5ndzogdzMyYXBpCiAKLWN5Z3dpbjogdzMyYXBpCitjeWd3aW46CiAK
IGN5Z3NlcnZlcjogY3lnd2luCiAKLWluc3RhbGxfdXRpbHM6IGN5Z3dpbiBt
aW5ndworaW5zdGFsbF91dGlsczogY3lnd2luCiAKIGluc3RhbGxfbWluZ3c6
IHczMmFwaQogCi1pbnN0YWxsX2N5Z3dpbjogdzMyYXBpCitpbnN0YWxsX2N5
Z3dpbjoKIAogaW5zdGFsbF9jeWdzZXJ2ZXI6IGN5Z3dpbgogCi1sc2FhdXRo
OiBtaW5ndyBjeWd3aW4KK2xzYWF1dGg6IGN5Z3dpbgpJbmRleDogd2luc3Vw
L2NvbmZpZ3VyZS5pbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxl
OiAvY3ZzL3NyYy9zcmMvd2luc3VwL2NvbmZpZ3VyZS5pbix2CnJldHJpZXZp
bmcgcmV2aXNpb24gMS4zMwpkaWZmIC1wIC11IC0zIC1yMS4zMyBjb25maWd1
cmUuaW4KLS0tIHdpbnN1cC9jb25maWd1cmUuaW4JMjkgSmFuIDIwMTEgMDY6
NDE6MjggLTAwMDAJMS4zMworKysgd2luc3VwL2NvbmZpZ3VyZS5pbgkxNyBP
Y3QgMjAxMiAxNToyMTozMiAtMDAwMApAQCAtNDUsNyArNDUsMTAgQEAgZXNh
YwogaWYgdGVzdCAtZCAkc3JjZGlyL21pbmd3OyB0aGVuCiAgIEFDX0NPTkZJ
R19TVUJESVJTKG1pbmd3KQogZmkKLUFDX0NPTkZJR19TVUJESVJTKHczMmFw
aSBjeWdzZXJ2ZXIpCitpZiB0ZXN0IC1kICRzcmNkaXIvdzMyYXBpOyB0aGVu
CisgIEFDX0NPTkZJR19TVUJESVJTKHczMmFwaSkKK2ZpCitBQ19DT05GSUdf
U1VCRElSUyhjeWdzZXJ2ZXIpCiAKIGNhc2UgIiR3aXRoX2Nyb3NzX2hvc3Qi
IGluCiAgICIifCpjeWd3aW4qKQpJbmRleDogd2luc3VwL2xzYWF1dGgvTWFr
ZWZpbGUuaW4KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2
cy9zcmMvc3JjL3dpbnN1cC9sc2FhdXRoL01ha2VmaWxlLmluLHYKcmV0cmll
dmluZyByZXZpc2lvbiAxLjYKZGlmZiAtcCAtdSAtMyAtcjEuNiBNYWtlZmls
ZS5pbgotLS0gd2luc3VwL2xzYWF1dGgvTWFrZWZpbGUuaW4JMjkgTWF5IDIw
MTIgMTI6NDY6MDEgLTAwMDAJMS42CisrKyB3aW5zdXAvbHNhYXV0aC9NYWtl
ZmlsZS5pbgkxNyBPY3QgMjAxMiAxNToyMTozMyAtMDAwMApAQCAtMzMsNyAr
MzMsNyBAQCBDRkxBR1MgICAgICAgICAgOj0gQENGTEFHU0AKIAogaW5jbHVk
ZSAkKHNyY2RpcikvLi4vTWFrZWZpbGUuY29tbW9uCiAKLVdJTjMyX0lOQ0xV
REVTICA6PSAtSS4gLUkkKHNyY2RpcikgJCh3MzJhcGlfaW5jbHVkZSkgJCh3
MzJhcGlfaW5jbHVkZSkvZGRrCitXSU4zMl9JTkNMVURFUyAgOj0gLUkuIC1J
JChzcmNkaXIpCiBXSU4zMl9DRkxBR1MgICAgOj0gJChDRkxBR1MpICQoV0lO
MzJfQ09NTU9OKSAkKFdJTjMyX0lOQ0xVREVTKQogV0lOMzJfTERGTEFHUwk6
PSAkKENGTEFHUykgJChXSU4zMl9DT01NT04pIC1ub3N0ZGxpYiAtV2wsLXNo
YXJlZAogCkluZGV4OiB3aW5zdXAvdXRpbHMvTWFrZWZpbGUuaW4KPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1
cC91dGlscy9NYWtlZmlsZS5pbix2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4x
MDAKZGlmZiAtcCAtdSAtMyAtcjEuMTAwIE1ha2VmaWxlLmluCi0tLSB3aW5z
dXAvdXRpbHMvTWFrZWZpbGUuaW4JMTEgSnVsIDIwMTIgMTY6NDE6NTEgLTAw
MDAJMS4xMDAKKysrIHdpbnN1cC91dGlscy9NYWtlZmlsZS5pbgkxNyBPY3Qg
MjAxMiAxNToyMTozMyAtMDAwMApAQCAtMjgsNiArMjgsNyBAQCBFWEVFWFRf
Rk9SX0JVSUxEOj1ARVhFRVhUX0ZPUl9CVUlMREAKIENDOj1AQ0NACiBDQ19G
T1JfVEFSR0VUOj0kKENDKQogQ1hYOj1AQ1hYQAorSE9TVF9DUFU9QEhPU1Rf
Q1BVQAogQ1hYX0ZPUl9UQVJHRVQ6PSQoQ1hYKQogCiBDRkxBR1M6PUBDRkxB
R1NACkBAIC00MCwxNSArNDEsMTEgQEAgaW5jbHVkZSAkKHNyY2RpcikvLi4v
TWFrZWZpbGUuY29tbW9uCiAuTk9FWFBPUlQ6CiAuUEhPTlk6IGFsbCBpbnN0
YWxsIGNsZWFuIHJlYWxjbGVhbiB3YXJuX2R1bXBlciB3YXJuX2N5Z2NoZWNr
X3psaWIKIAotQUxMX0xETElCUyAgICAgOj0gLWxuZXRhcGkzMiAtbGFkdmFw
aTMyCi1BTExfTERGTEFHUyAgICA6PSAtc3RhdGljLWxpYmdjYyAtV2wsLS1l
bmFibGUtYXV0by1pbXBvcnQgLUIkKG5ld2xpYl9idWlsZCkvbGliYyAtQiQo
dzMyYXBpX2xpYikgJChMREZMQUdTKSAkKEFMTF9MRExJQlMpCi1BTExfREVQ
X0xETElCUyA6PSAkKGN5Z3dpbl9idWlsZCkvbGliY3lnd2luLmEgJHtwYXRz
dWJzdCAtbCUsXAotICAgICAgICAgICAgICAgICAgICAkKHczMmFwaV9saWIp
L2xpYiUuYSwkKEFMTF9MRExJQlMpIC1sa2VybmVsMzIgLWx1c2VyMzJ9Ci0K
LU1JTkdXX0xJQiAgICAgICAgOj0gJChtaW5nd19idWlsZCkvbGlibWluZ3cz
Mi5hCi1NSU5HV19MRExJQlMgICAgIDo9ICQoQUxMX0xETElCUykgJChNSU5H
V19MSUIpCi1NSU5HV19ERVBfTERMSUJTIDo9ICQoQUxMX0RFUF9MRExJQlMp
ICQoTUlOR1dfTElCKQotTUlOR1dfQ1hYICAgICAgICA6PSAke3NyY2Rpcn0v
bWluZ3cgJHtDWFh9IC1JJHt1cGRpcn0KK0FMTF9MRExJQlMgICAgIDo9IC1s
bmV0YXBpMzIgLWxhZHZhcGkzMiAtbGtlcm5lbDMyIC1sdXNlcjMyCitBTExf
TERGTEFHUyAgICA6PSAtc3RhdGljLWxpYmdjYyAtV2wsLS1lbmFibGUtYXV0
by1pbXBvcnQgLUIkKG5ld2xpYl9idWlsZCkvbGliYyAkKExERkxBR1MpICQo
QUxMX0xETElCUykKK0FMTF9ERVBfTERMSUJTIDo9ICQoY3lnd2luX2J1aWxk
KS9saWJjeWd3aW4uYQorCitNSU5HV19DWFggICAgICAgIDo9ICR7c3JjZGly
fS9taW5ndyAke0hPU1RfQ1BVfSAke0NYWH0gLUkke3VwZGlyfQogCiAjIExp
c3QgYWxsIGJpbmFyaWVzIHRvIGJlIGxpbmtlZCBpbiBDeWd3aW4gbW9kZS4g
IEVhY2ggYmluYXJ5IG9uIHRoaXMgbGlzdAogIyBtdXN0IGhhdmUgYSBjb3Jy
ZXNwb25kaW5nIC5vIG9mIHRoZSBzYW1lIG5hbWUuCkBAIC04Myw3ICs4MCw2
IEBAIHN0cmFjZS5leGU6IE1JTkdXX0xERkxBR1MgKz0gLWxudGRsbAogbGRk
LmV4ZTogQUxMX0xERkxBR1MgKz0gLWxwc2FwaQogcGxkZC5leGU6IEFMTF9M
REZMQUdTICs9IC1scHNhcGkKIAotbGRoLmV4ZTogTUlOR1dfTERMSUJTIDo9
CiBsZGguZXhlOiBNSU5HV19MREZMQUdTIDo9IC1ub3N0ZGxpYiAtbGtlcm5l
bDMyCiAKICMgQ2hlY2sgZm9yIGR1bXBlcidzIHJlcXVpcmVtZW50cyBhbmQg
ZW5hYmxlIGl0IGlmIGZvdW5kLgpAQCAtMTQyLDEwICsxMzgsMTAgQEAgZW5k
aWYKICMgaG93IHRvIGxpbmsgYSBNaW5HVyBiaW5hcnkKICQoTUlOR1dfQklO
Uyk6ICUuZXhlOiAlLm8KIGlmZGVmIFZFUkJPU0UKLQkkKE1JTkdXX0NYWCkg
JChNSU5HV19DWFhGTEFHUykgLW8gJEAgJHtmaWx0ZXIgJS5vLCRefSAtQiQo
bWluZ3dfYnVpbGQpLyAkKE1JTkdXX0xERkxBR1MpCisJJChNSU5HV19DWFgp
ICQoTUlOR1dfQ1hYRkxBR1MpIC1vICRAICR7ZmlsdGVyICUubywkXn0gJChN
SU5HV19MREZMQUdTKQogZWxzZQogCUBlY2hvICQoTUlOR1dfQ1hYKSAtbyAk
QCAke2ZpbHRlciAlLm8sJF59ICR7ZmlsdGVyLW91dCAtQiUsICQoTUlOR1df
Q1hYRkxBR1MpICQoTUlOR1dfTERGTEFHUyl9O1wKLQkkKE1JTkdXX0NYWCkg
JChNSU5HV19DWFhGTEFHUykgLW8gJEAgJHtmaWx0ZXIgJS5vLCRefSAtQiQo
bWluZ3dfYnVpbGQpLyAkKE1JTkdXX0xERkxBR1MpCisJJChNSU5HV19DWFgp
ICQoTUlOR1dfQ1hYRkxBR1MpIC1vICRAICR7ZmlsdGVyICUubywkXn0gJChN
SU5HV19MREZMQUdTKQogZW5kaWYKIAogIyBob3cgdG8gbGluayBhIEN5Z3dp
biBiaW5hcnkKQEAgLTE2MCw3ICsxNTYsNyBAQCBlbmRpZgogIyBub3RlOiBo
b3cgdG8gY29tcGlsZSBhIEN5Z3dpbiBvYmplY3QgaXMgY292ZXJlZCBieSB0
aGUgcGF0dGVybiBydWxlIGluIE1ha2VmaWxlLmNvbW1vbgogCiAjIHRoZXNl
IGRlcGVuZGVuY2llcyBlbnN1cmUgdGhhdCB0aGUgcmVxdWlyZWQgaW4tdHJl
ZSBsaWJzIGFyZSBidWlsdCBmaXJzdAotJChNSU5HV19CSU5TKTogJChNSU5H
V19ERVBfTERMSUJTKQorJChNSU5HV19CSU5TKTogJChBTExfREVQX0xETElC
UykKICQoQ1lHV0lOX0JJTlMpOiAkKEFMTF9ERVBfTERMSUJTKQogCiBjbGVh
bjoKQEAgLTE3OSw5ICsxNzUsNiBAQCBpbnN0YWxsOiBhbGwKICQoY3lnd2lu
X2J1aWxkKS9saWJjeWd3aW4uYTogJChjeWd3aW5fYnVpbGQpL01ha2VmaWxl
CiAJQCQoTUFLRSkgLUMgJChARCkgJChARikKIAotJChNSU5HV19MSUIpOiAk
KG1pbmd3X2J1aWxkKS9NYWtlZmlsZQotCUAkKE1BS0UpIC1DICQoQEQpICQo
QEYpCi0KIHdhcm5fZHVtcGVyOgogCUBlY2hvICcqKiogTm90IGJ1aWxkaW5n
IGR1bXBlci5leGUgc2luY2Ugc29tZSByZXF1aXJlZCBsaWJyYXJpZXMgb3In
CiAJQGVjaG8gJyoqKiBvciBoZWFkZXJzIGFyZSBtaXNzaW5nLiAgUG90ZW50
aWFsIGNhbmRpZGF0ZXMgYXJlOicKSW5kZXg6IHdpbnN1cC91dGlscy9jb25m
aWd1cmUuaW4KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2
cy9zcmMvc3JjL3dpbnN1cC91dGlscy9jb25maWd1cmUuaW4sdgpyZXRyaWV2
aW5nIHJldmlzaW9uIDEuOQpkaWZmIC1wIC11IC0zIC1yMS45IGNvbmZpZ3Vy
ZS5pbgotLS0gd2luc3VwL3V0aWxzL2NvbmZpZ3VyZS5pbgkyNSBKdWwgMjAw
OCAxNTowMzoyNSAtMDAwMAkxLjkKKysrIHdpbnN1cC91dGlscy9jb25maWd1
cmUuaW4JMTcgT2N0IDIwMTIgMTU6MjE6MzMgLTAwMDAKQEAgLTIzLDYgKzIz
LDkgQEAgQUNfQVJHX1BST0dSQU0KIEFDX0NIRUNLX0xJQihpY29udiwgbGli
aWNvbnYsIGxpYmljb252PS1saWNvbnYpCiBBQ19TVUJTVChsaWJpY29udikK
IAorSE9TVF9DUFU9IiRob3N0X2NwdSIKK0FDX1NVQlNUKEhPU1RfQ1BVKQor
CiBJTlNUQUxMPSIvYmluL3NoICJgY2QgJHNyY2Rpci8uLi8uLjsgZWNobyAk
KHB3ZCkvaW5zdGFsbC1zaCAtY2AKIAogQUNfUFJPR19JTlNUQUxMCkluZGV4
OiB3aW5zdXAvdXRpbHMvbWluZ3cKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91dGlscy9taW5ndyx2CnJl
dHJpZXZpbmcgcmV2aXNpb24gMS44CmRpZmYgLXAgLXUgLTMgLXIxLjggbWlu
Z3cKLS0tIHdpbnN1cC91dGlscy9taW5ndwkxNCBKdW4gMjAxMSAxNTowNDow
NCAtMDAwMAkxLjgKKysrIHdpbnN1cC91dGlscy9taW5ndwkxNyBPY3QgMjAx
MiAxNToyMTozMyAtMDAwMApAQCAtNSwxNyArNSw4MiBAQAogIwogIyBGaW5k
IHRoZSBwYXRoIHRvIHRoZSBjb21waWxlci4KICMKK2NwdT0kMTsgc2hpZnQK
IGNvbXBpbGVyPSQxOyBzaGlmdAogZGlyPSQoY2QgJChkaXJuYW1lICQoIiRj
b21waWxlciIgLXByaW50LXByb2ctbmFtZT1sZCkpLy4uLy4uOyBwd2QpCiAK
ICMKKyMgRmluZCB0aGUgdG9vbCdzIG5hbWUgd2l0aG91dCB0aGUgdGFyZ2V0
LXByZWZpeAorIworY2FzZSAkY29tcGlsZXIgaW4KKyotKi0qLSopCit0b29s
PWBlY2hvICIkY29tcGlsZXIiIHwgc2VkICdzL15cKFteLV0qXCktXChbXi1d
KlwpLVwoW14tXSpcKS1cKC4qXCkkL1w0LydgIDs7CisqKSB0b29sPWNvbXBp
bGVyIDs7Citlc2FjCisKKyMKICMgVGhlIG1pbmd3MzIgZGlyZWN0b3J5IHNo
b3VsZCBsaXZlIHNvbWV3aGVyZSBjbG9zZSBieSB0byB0aGUKICMgY29tcGls
ZXIuICBTZWFyY2ggZm9yIGl0LgogIwotWyAiJGRpciIgPSAnLycgXSAmJiBk
aXI9JycKK1sgIiRkaXIiID0gJy8nIF0gJiYgZGlyPScnOworCittaW5nd19j
b21waWxlcj0nJworCisjCisjIFdlIHNlYXJjaCBmaXJzdCBmb3IgaW5zdGFs
bGVkICotdzY0LW1pbmd3KiB0b29sY2hhaW4gd2l0aCBhZGVxdWF0ZQorIyBh
cmNoaXRlY3R1cmUuICBXZSBkb24ndCBjb25zaWRlciB0byBjaGVjayBzZWNv
bmRhcnkgdGFyZ2V0IGZvcgorIyBtdWx0aWxpYiB0b29sY2hhaW5zIGhlcmUu
CisjCitmb3IgZCBpbiAiJGRpciIvYmluLyIkY3B1Ii13NjQtbWluZ3cqLSIk
dG9vbCIqIFwKKyAgICAgICAgIiRkaXIiL3Vzci9iaW4vIiRjcHUiLXc2NC1t
aW5ndyotIiR0b29sIiogXAorICAgICAgICAvYmluLyIkY3B1Ii13NjQtbWlu
Z3cqLSIkdG9vbCIqIC91c3IvYmluLyIkY3B1Ii13NjQtbWluZ3cqLSIkdG9v
bCIqIFwKKyAgICAgICAgL3Vzci9sb2NhbC9iaW4vIiRjcHUiLXc2NC1taW5n
dyotIiR0b29sIiogXAorICAgICAgICAiJGRpciIvIiRjcHUiLXc2NC1taW5n
dyovc3lzLXJvb3QvYmluLyIkY3B1Ii13NjQtbWluZ3cqLSIkdG9vbCIqIFwK
KyAgICAgICAgIiRkaXIiL3Vzci8iJGNwdSItdzY0LW1pbmd3Ki9zeXMtcm9v
dC9iaW4vIiRjcHUiLXc2NC1taW5ndyotIiR0b29sIiogXAorICAgICAgICAv
IiRjcHUiLXc2NC1taW5ndyovc3lzLXJvb3QvYmluLyIkY3B1Ii13NjQtbWlu
Z3cqLSIkdG9vbCIqIFwKKyAgICAgICAgL3Vzci8iJGNwdSItdzY0LW1pbmd3
Ki9zeXMtcm9vdC9iaW4vIiRjcHUiLXc2NC1taW5ndyotIiR0b29sIio7IGRv
CisgICAgY2FzZSAiJGQiIGluCisgICAgICAgICpcKiopIGNvbnRpbnVlIDs7
CisgICAgICAgICopCisgICAgICAgICAgIGlmIHRlc3QgLWYgIiRkIjsgdGhl
bgorICAgICAgICAgICAgIG1pbmd3X2NvbXBpbGVyPSRkOworICAgICAgICAg
ICAgIGJyZWFrOworICAgICAgICAgICBmaQorICAgIGVzYWMKK2RvbmUKKwor
IworIyBJZiB3ZSBkaWRuJ3QgZm91bmQgYW4gaW5zdGFsbGVkICotdzY0LW1p
bmd3KiB0b29sY2hhaW4gZm9yIGFyY2hpdGVjdHVyZQorIyBjcHUsIHdlIHNl
YXJjaCBmb3IgYSAqLW1pbmd3KiB0b29sY2hhaW4uCisjCitpZiBbIC16ICIk
bWluZ3dfY29tcGlsZXIiIF07IHRoZW4KKyAgZm9yIGQgaW4gIiRkaXIiL2Jp
bi8iJGNwdSItKi1taW5ndyotLSIkdG9vbCIqIFwKKyAgICAgICAgIiRkaXIi
L3Vzci9iaW4vIiRjcHUiLSotbWluZ3cqLSIkdG9vbCIqIFwKKyAgICAgICAg
L2Jpbi8iJGNwdSItdzY0LW1pbmd3Ki0iJHRvb2wiKiAvdXNyL2Jpbi8iJGNw
dSItdzY0LW1pbmd3Ki0iJHRvb2wiKiBcCisgICAgICAgIC91c3IvbG9jYWwv
YmluLyIkY3B1Ii13NjQtbWluZ3cqLSIkdG9vbCIqIFwKKyAgICAgICAgIiRk
aXIiLyIkY3B1Ii13NjQtbWluZ3cqL3N5cy1yb290L2Jpbi8iJGNwdSItdzY0
LW1pbmd3Ki0iJHRvb2wiKiBcCisgICAgICAgICIkZGlyIi91c3IvIiRjcHUi
LXc2NC1taW5ndyovc3lzLXJvb3QvYmluLyIkY3B1Ii13NjQtbWluZ3cqLSIk
dG9vbCIqIFwKKyAgICAgICAgLyIkY3B1Ii13NjQtbWluZ3cqL3N5cy1yb290
L2Jpbi8iJGNwdSItdzY0LW1pbmd3Ki0iJHRvb2wiKiBcCisgICAgICAgIC91
c3IvIiRjcHUiLXc2NC1taW5ndyovc3lzLXJvb3QvYmluLyIkY3B1Ii13NjQt
bWluZ3cqLSIkdG9vbCIqOyBkbworICAgIGNhc2UgIiRkIiBpbgorICAgICAg
ICAqXCoqKSBjb250aW51ZSA7OworICAgICAgICAqKQorICAgICAgICAgICBp
ZiB0ZXN0IC1mICIkZCI7IHRoZW4KKyAgICAgICAgICAgICBtaW5nd19jb21w
aWxlcj0kZDsKKyAgICAgICAgICAgICBicmVhazsKKyAgICAgICAgICAgZmkK
KyAgICBlc2FjCisgIGRvbmUKK2ZpCisKKyMKKyMgU2VhcmNoIGZvciBtaW5n
dydzIHN5cy1yb290LiAgQWdhaW4sIGZpcnN0IGZvciAtdzY0LW1pbmd3KiB0
b29sY2hhaW4gLi4uCisjCiBtaW5nd19kaXI9JycKLWZvciBkIGluICIkZGly
Ii8qLW1pbmd3MzIgIiRkaXIiL3Vzci8qLW1pbmd3MzIgIiRkaXIiLyotbWlu
Z3cqICIkZGlyIi91c3IvKi1taW5ndyogXAotICAgICAgICAgLyotbWluZ3cz
MiAvdXNyLyotbWluZ3czMiAvKi1taW5ndyogL3Vzci8qLW1pbmd3KjsgZG8K
K2ZvciBkIGluICIkZGlyIi8iJGNwdSItdzY0LW1pbmd3KiAiJGRpciIvdXNy
LyIkY3B1Ii13NjQtbWluZ3cqIFwKKyAgICAgICAgIiRkaXIiLyIkY3B1Ii13
NjQtbWluZ3cqICIkZGlyIi91c3IvIiRjcHUiLXc2NC1taW5ndyogXAorICAg
ICAgICAvIiRjcHUiLXc2NC1taW5ndyogL3Vzci8iJGNwdSItdzY0LW1pbmd3
KiAvIiRjcHUiLXc2NC1taW5ndyogXAorICAgICAgICAvdXNyLyIkY3B1Ii13
NjQtbWluZ3cqOyBkbwogICAgIGNhc2UgIiRkIiBpbgogCSpcKiopCWNvbnRp
bnVlIDs7CiAJKikJaWYgWyAtZCAiJGQiL3N5cy1yb290L21pbmd3IF07IHRo
ZW4KQEAgLTI2LDggKzkxLDMzIEBAIGZvciBkIGluICIkZGlyIi8qLW1pbmd3
MzIgIiRkaXIiL3Vzci8qLW0KICAgICBlc2FjCiBkb25lCiAKKyMKKyMgLi4u
IGVsc2UgZm9yICotbWluZ3cqIHRvb2xjaGFpbi4KK2lmIFsgLXogIiRtaW5n
d19kaXIiIF07IHRoZW4KKyAgZm9yIGQgaW4gIiRkaXIiLyIkY3B1Ii0qLW1p
bmd3KiAiJGRpciIvdXNyLyIkY3B1Ii0qLW1pbmd3KiBcCisgICAgICAgICIk
ZGlyIi8iJGNwdSItKi1taW5ndyogIiRkaXIiL3Vzci8iJGNwdSItKi1taW5n
dyogXAorICAgICAgICAvIiRjcHUiLSotbWluZ3cqIC91c3IvIiRjcHUiLSot
bWluZ3cqIC8iJGNwdSItKi1taW5ndyogXAorICAgICAgICAvdXNyLyIkY3B1
Ii0qLW1pbmd3KjsgZG8KKyAgICBjYXNlICIkZCIgaW4KKyAgICAgICAgKlwq
KikgICBjb250aW51ZSA7OworICAgICAgICAqKSAgICAgIGlmIFsgLWQgIiRk
Ii9zeXMtcm9vdC9taW5ndyBdOyB0aGVuCisgICAgICAgICAgICAgICAgICAg
IG1pbmd3X2Rpcj0kZC9zeXMtcm9vdC9taW5ndworICAgICAgICAgICAgICAg
IGVsc2UKKyAgICAgICAgICAgICAgICAgICAgbWluZ3dfZGlyPSRkOworICAg
ICAgICAgICAgICAgIGZpOyBicmVhazsKKyAgICBlc2FjCisgIGRvbmUKK2Zp
CisKK2lmIFsgLXogIiRtaW5nd19jb21waWxlciIgXTsgdGhlbgorICBtaW5n
d19jb21waWxlcj0kY29tcGlsZXIKK2ZpCisKKyMKKyMgQ2hlY2sgaWYgbWlu
Z3cncyBzeXMtcm9vdCBkaXJlY3RvcnkgY291bGQgYmUgZGV0ZWN0ZWQKKyMK
IGlmIFsgLXogIiRtaW5nd19kaXIiIF07IHRoZW4KLSAgICBlY2hvICIkMDog
Y291bGRuJ3QgZmluZCBpNjg2LXBjLW1pbmd3MzIgZGlyZWN0b3J5IiAxPiYy
CisgICAgZWNobyAiJDA6IGNvdWxkbid0IGZpbmQgJGNwdS0qLW1pbmd3MzIg
ZGlyZWN0b3J5IiAxPiYyCiAgICAgZXhpdCAxCiBmaQogCkBAIC05MCwxMCAr
MTgwLDEwIEBAIGZpCiBpZiBzYXdvZmlsZSB8fCAhIHNhd2NmaWxlIHx8ICEg
c2F3Y29tcDsgdGhlbgogICAgIHczMmFwaT0kKCRjb21waWxlciAtcHJpbnQt
ZmlsZS1uYW1lPWxpYmMuYSkKICAgICB3MzJhcGk9JChjZCAkKGRpcm5hbWUg
IiR3MzJhcGkiKS93MzJhcGk7IHB3ZCkKLSAgICBzZXQgLS0gLVdsLC1ub3N0
ZGxpYiAtTCIke3czMmFwaX0iICIkQCIKKyAgICBzZXQgLS0gLVdsLC1ub3N0
ZGxpYiAtQiIke3czMmFwaX0iICIkQCIKICAgICAhIHNhd25vc3RkbGliICYm
IHNldCAtLSAtbm9zdGRsaWIgIiRAIiAtbG1pbmd3MzIgLWxnY2MgLWxtb2xk
bmFtZSAtbG1pbmd3ZXggLWxtc3ZjcnQgLWxtaW5ndzMyIC1sdXNlcjMyIC1s
a2VybmVsMzIgLWxhZHZhcGkzMiAtbHNoZWxsMzIgLWxtaW5ndzMyIC1sZ2Nj
IC1sbW9sZG5hbWUgLWxtaW5nd2V4IC1sbXN2Y3J0CiAgICAgISBzYXdub3N0
ZGxpYiAmJiAhIHNhd3NoYXJlZCAmJiB7IHNhd29maWxlIHx8IHNhd2NmaWxl
OyB9ICYmIHNldCAtLSAiJG1pbmd3X2RpciIvbGliL2NydDIubyAiJEAiCiBm
aQogCiAjIEV4ZWN1dGUgdGhlIGNvbXBpbGVyIHdpdGggbmV3IG1pbmd3LXNw
ZWNpZmljIG9wdGlvbnMuCi1leGVjICRjb21waWxlciAiJEAiCitleGVjICRt
aW5nd19jb21waWxlciAiJEAiCg==

--047d7b66f6097e0b0104cc438c33--
