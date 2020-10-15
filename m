Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta21-re.btinternet.com
 [213.120.69.114])
 by sourceware.org (Postfix) with ESMTPS id 3469F3950C6E
 for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2020 14:37:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3469F3950C6E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20201015143717.OORB30588.re-prd-fep-041.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 15 Oct 2020 15:37:17 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.143.43.37]
X-OWM-Source-IP: 86.143.43.37 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrieefgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudegfedrgeefrdefjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeefrdegfedrfeejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.143.43.37) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC15FB5ACB; Thu, 15 Oct 2020 15:37:17 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Remove --with-windows-{libs,headers}
Date: Thu, 15 Oct 2020 15:36:52 +0100
Message-Id: <20201015143652.56501-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015143652.56501-1-jon.turney@dronecode.org.uk>
References: <20201015143652.56501-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1201.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 15 Oct 2020 14:37:19 -0000

---
 winsup/acinclude.m4           | 41 -----------------------------------
 winsup/configure.ac           |  5 -----
 winsup/cygserver/configure.ac |  6 -----
 winsup/cygwin/Makefile.in     |  4 +---
 winsup/cygwin/configure.ac    |  5 -----
 winsup/utils/Makefile.in      |  4 +---
 winsup/utils/configure.ac     |  3 ---
 7 files changed, 2 insertions(+), 66 deletions(-)

diff --git a/winsup/acinclude.m4 b/winsup/acinclude.m4
index 5f71871ec..5248e2a2a 100644
--- a/winsup/acinclude.m4
+++ b/winsup/acinclude.m4
@@ -1,33 +1,6 @@
 dnl This provides configure definitions used by all the cygwin
 dnl configure.in files.
 
-AC_DEFUN([AC_WINDOWS_HEADERS],[
-AC_ARG_WITH(
-    [windows-headers],
-    [AS_HELP_STRING([--with-windows-headers=DIR],
-		    [specify where the windows includes are located])],
-    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-windows-headers])]
-)
-])
-
-AC_DEFUN([AC_WINDOWS_LIBS],[
-AC_ARG_WITH(
-    [windows-libs],
-    [AS_HELP_STRING([--with-windows-libs=DIR],
-		    [specify where the windows libraries are located])],
-    [test -z "$withval" && AC_MSG_ERROR([must specify value for --with-windows-libs])]
-)
-windows_libdir=$(realdirpath "$with_windows_libs")
-if test -z "$windows_libdir"; then
-    windows_libdir=$(realdirpath $(${ac_cv_prog_CC:-$CC} -xc /dev/null  -Wl,--verbose=1 -lntdll 2>&1 | sed -rn 's%^.*\s(\S+)/libntdll\..*succeeded%\1%p'))
-    if test -z "$windows_libdir"; then
-	AC_MSG_ERROR([cannot find windows library files])
-    fi
-fi
-AC_SUBST(windows_libdir)
-]
-)
-
 AC_DEFUN([AC_CYGWIN_INCLUDES], [
 : ${ac_cv_prog_CXX:=$CXX}
 : ${ac_cv_prog_CC:=$CC}
@@ -43,25 +16,11 @@ if test -z "$newlib_headers"; then
 fi
 newlib_headers="$target_builddir/newlib/targ-include $newlib_headers"
 
-if test -n "$with_windows_headers"; then
-    if test -e "$with_windows_headers/windef.h"; then
-	windows_headers="$with_windows_headers"
-    else
-	AC_MSG_ERROR([cannot find windef.h in specified --with-windows-headers path: $saw_windows_headers]);
-    fi
-else
-    windows_headers=$(cd $($ac_cv_prog_CC -xc /dev/null -E -include windef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1) 2>/dev/null && pwd)
-    if test -z "$windows_headers" -o ! -d "$windows_headers"; then
-	AC_MSG_ERROR([cannot find windows header files])
-    fi
-fi
-
 INCLUDES="-I${srcdir}/../cygwin -I${target_builddir}/winsup/cygwin"
 INCLUDES="${INCLUDES} -isystem ${cygwin_headers}"
 for h in ${newlib_headers}; do
     INCLUDES="${INCLUDES} -isystem $h"
 done
-INCLUDES="${INCLUDES} -isystem ${windows_headers}"
 AC_SUBST(INCLUDES)
 ])
 
diff --git a/winsup/configure.ac b/winsup/configure.ac
index 13f8883eb..65369ae7f 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -25,11 +25,6 @@ AC_PROG_CPP
 AC_LANG(C)
 AC_ARG_WITH([cross-bootstrap],[AS_HELP_STRING([--with-cross-bootstrap],[do not build programs using the mingw toolchain or check for mingw libraries (useful for bootstrapping a cross-compiler)])],[],[with_cross_bootstrap=no])
 
-AC_WINDOWS_HEADERS
-if test "x$with_cross_bootstrap" != "xyes"; then
-    AC_WINDOWS_LIBS
-fi
-
 AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
diff --git a/winsup/cygserver/configure.ac b/winsup/cygserver/configure.ac
index d8b2a61fa..9a6baceb7 100644
--- a/winsup/cygserver/configure.ac
+++ b/winsup/cygserver/configure.ac
@@ -23,12 +23,6 @@ AC_PROG_CC
 AC_PROG_CXX
 AC_PROG_CPP
 AC_LANG(C)
-
-AC_WINDOWS_HEADERS
-if test "x$with_cross_bootstrap" != "xyes"; then
-  AC_WINDOWS_LIBS
-fi
-
 AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 01c2f72a3..a56a311b8 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -52,8 +52,6 @@ override INSTALL:=@INSTALL@
 override INSTALL_PROGRAM:=@INSTALL_PROGRAM@
 override INSTALL_DATA:=@INSTALL_DATA@
 
-WINDOWS_LIBDIR:=@windows_libdir@
-
 cygserver_blddir:=${target_builddir}/winsup/cygserver
 LIBSERVER:=${cygserver_blddir}/libcygserver.a
 
@@ -680,7 +678,7 @@ $(LDSCRIPT): $(LDSCRIPT).in
 # Rule to build cygwin.dll
 $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(LIBSERVER) $(LIBC) $(LIBM) $(API_VER) Makefile $(VERSION_OFILES)
 	$(CXX) $(CXXFLAGS) \
-	-mno-use-libstdc-wrappers -L${WINDOWS_LIBDIR} \
+	-mno-use-libstdc-wrappers \
 	-Wl,--gc-sections $(nostdlib) -Wl,-T$(firstword $^) -static \
 	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
 	-e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) $(VERSION_OFILES) \
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index 32862d7e5..0e9df29bb 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -25,11 +25,6 @@ AC_PROG_CXX
 AC_PROG_CPP
 AC_LANG(C)
 
-AC_WINDOWS_HEADERS
-if test "x$with_cross_bootstrap" != "xyes"; then
-  AC_WINDOWS_LIBS
-fi
-
 AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index bd17d6862..add29d10f 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -22,8 +22,6 @@ include ${srcdir}/../Makefile.common
 
 cygwin_build:=${target_builddir}/winsup/cygwin
 
-WINDOWS_LIBDIR:=@windows_libdir@
-
 prefix:=@prefix@
 exec_prefix:=@exec_prefix@
 
@@ -39,7 +37,7 @@ EXEEXT_FOR_BUILD:=@EXEEXT_FOR_BUILD@
 .PHONY: all install clean realclean warn_dumper warn_cygcheck_zlib
 
 LDLIBS := -lnetapi32 -ladvapi32 -lkernel32 -luser32
-CYGWIN_LDFLAGS := -static -Wl,--enable-auto-import -L${WINDOWS_LIBDIR} $(LDLIBS)
+CYGWIN_LDFLAGS := -static -Wl,--enable-auto-import $(LDLIBS)
 DEP_LDLIBS := $(cygwin_build)/libcygwin.a
 
 MINGW_CXX      := @MINGW_CXX@
diff --git a/winsup/utils/configure.ac b/winsup/utils/configure.ac
index ce35f9c7b..5fff31414 100644
--- a/winsup/utils/configure.ac
+++ b/winsup/utils/configure.ac
@@ -21,9 +21,6 @@ AC_CANONICAL_TARGET
 
 AC_PROG_CC
 
-AC_WINDOWS_HEADERS
-AC_WINDOWS_LIBS
-
 AC_PROG_CXX
 
 AC_CYGWIN_INCLUDES
-- 
2.28.0

