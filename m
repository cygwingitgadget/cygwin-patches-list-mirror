Return-Path: <cygwin-patches-return-8453-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29245 invoked by alias); 21 Mar 2016 17:16:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29119 invoked by uid 89); 21 Mar 2016 17:16:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=98, sk:xcross, 99, CC
X-HELO: mail-qk0-f193.google.com
Received: from mail-qk0-f193.google.com (HELO mail-qk0-f193.google.com) (209.85.220.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 17:16:02 +0000
Received: by mail-qk0-f193.google.com with SMTP id s5so7315526qkd.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 10:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=SK2h1uk0v14aYwGjzGUOcF8jxBD6oolrp0+kAJJzDHM=;        b=F/mFmPBwpzusfKeXL9kernIadlwq6Kr6Z+F1gtcOmzM4OJG98zysxINAcL16qH8432         2KN/DOATjCAeUC4Fn8STGr39uXkXNgHDnzlwgHu4Z94aQavICoFdKeZkl1U/tI2oOQ3x         scQsMU6gtZF7Jn8AOjRZY349v8WXbLDes4ZkOMXFrt2NxLam/I4UP0vP6v/hvV3Wy9i7         qIoZ1ihwodF4MaHu22qItLrVHfp+LxH/2u8hVEmpNyniZI7uYKzrrWnnYghvNOmL2RZt         kOol49hwu7+0E8c8fDgvxnEkWM1Y3HFNO+7kXBRpyh+frz8omETw9/QJFWh3pF2Aixni         I1yg==
X-Gm-Message-State: AD7BkJL8Q1JOn/MvSddPzGW1q3laN+6i375eGLi5NCCGFNYYQR1r6Qe/Zk+y0nEccgwHVg==
X-Received: by 10.55.76.11 with SMTP id z11mr41540337qka.83.1458580559878;        Mon, 21 Mar 2016 10:15:59 -0700 (PDT)
Received: from bronx.local.pefoley.com ([2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id n83sm12492145qhn.46.2016.03.21.10.15.59        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Mon, 21 Mar 2016 10:15:59 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 5/5] Add with-only-headers
Date: Mon, 21 Mar 2016 17:16:00 -0000
Message-Id: <1458580546-14484-5-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00158.txt.bz2

When cross-compiling a toolchan targeting cygwin, building cygwin1.dll
requires libstdc++v3 to be built.
However, building libstdc++v3 requires the cygwin headers to be
installed.
Work around this circular dependency by adding a --with-only-headers
configure option to only install the headers without trying to build any
libraries.

winsup/ChangeLog
Makefile.in: add special install target for with-only-headers
configure.ac: add with-only-headers option
configure: regenerate
winsup/cygserver/ChangeLog
configure.ac: don't check AC_WINDOWS_LIBS when using with-only-headers
configure: regenerate
winsup/cygwin/ChangeLog
configure.ac: don't check AC_WINDOWS_LIBS when using with-only-headers
configure: regenerate

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/Makefile.in            |  5 +++++
 winsup/configure              | 15 ++++++++++++++-
 winsup/configure.ac           |  8 ++++++--
 winsup/cygserver/configure    |  3 ++-
 winsup/cygserver/configure.ac | 12 +++++++-----
 winsup/cygwin/configure       |  3 ++-
 winsup/cygwin/configure.ac    | 14 ++++++++------
 7 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/winsup/Makefile.in b/winsup/Makefile.in
index 1fdf93a..76da977 100644
--- a/winsup/Makefile.in
+++ b/winsup/Makefile.in
@@ -69,7 +69,12 @@ install-license: CYGWIN_LICENSE COPYING
 	  ${INSTALL} $$i $(DESTDIR)$(prefix)/share/doc/Cygwin ; \
 	done
 
+ifeq (@with_only_headers@,yes)
+install: Makefile
+	@${MAKE} -C cygwin install-headers
+else
 install: Makefile $(INSTALL_LICENSE) $(INSTALL_SUBDIRS)
+endif
 
 clean: $(CLEAN_SUBDIRS)
 
diff --git a/winsup/configure b/winsup/configure
index 57c3378..55a5490 100755
--- a/winsup/configure
+++ b/winsup/configure
@@ -596,6 +596,7 @@ cygwin_headers
 newlib_headers
 windows_headers
 windows_libdir
+with_only_headers
 CPP
 ac_ct_CXX
 CXXFLAGS
@@ -665,6 +666,7 @@ target_builddir'
 ac_subst_files=''
 ac_user_opts='
 enable_option_checking
+with_only_headers
 with_windows_headers
 with_windows_libs
 '
@@ -1294,6 +1296,8 @@ if test -n "$ac_init_help"; then
 Optional Packages:
   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
+  --with-only-headers     only install headers for bootstraping a
+                          cross-compiler
   --with-windows-headers=DIR
                           specify where the windows includes are located
   --with-windows-libs=DIR specify where the windows libraries are located
@@ -3359,6 +3363,13 @@ ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $
 ac_compiler_gnu=$ac_cv_c_compiler_gnu
 
 
+# Check whether --with-only-headers was given.
+if test "${with_only_headers+set}" = set; then :
+  withval=$with_only_headers;
+fi
+
+
+
 
 
 # Check whether --with-windows-headers was given.
@@ -3368,6 +3379,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_only_headers" != "xyes"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3386,6 +3398,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
@@ -3433,7 +3446,7 @@ export CXX
 
 
 
-if test "x$cross_compiling" != xyes; then
+if test "x$cross_compiling" != "xyes"; then
 
 
 subdirs="$subdirs utils lsaauth"
diff --git a/winsup/configure.ac b/winsup/configure.ac
index ce4f4bb..01c61dc 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -25,15 +25,19 @@ AC_PROG_CC
 AC_PROG_CXX
 AC_PROG_CPP
 AC_LANG(C)
+AC_ARG_WITH([only-headers],[AS_HELP_STRING([--with-only-headers],[only install headers for bootstraping a cross-compiler])])
+AC_SUBST(with_only_headers)
 
 AC_WINDOWS_HEADERS
-AC_WINDOWS_LIBS
+if test "x$with_only_headers" != "xyes"; then
+    AC_WINDOWS_LIBS
+fi
 
 AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
 
-if test "x$cross_compiling" != xyes; then
+if test "x$cross_compiling" != "xyes"; then
     AC_CONFIG_SUBDIRS([utils lsaauth])
 fi
 
diff --git a/winsup/cygserver/configure b/winsup/cygserver/configure
index a4feae1..dd8f4de 100755
--- a/winsup/cygserver/configure
+++ b/winsup/cygserver/configure
@@ -2106,7 +2106,6 @@ test -n "$target_alias" &&
     NONENONEs,x,x, &&
   program_prefix=${target_alias}-
 
-
 ac_ext=c
 ac_cpp='$CPP $CPPFLAGS'
 ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -3382,6 +3381,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_only_headers" != "xyes"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3400,6 +3400,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
diff --git a/winsup/cygserver/configure.ac b/winsup/cygserver/configure.ac
index 4e2cb45..d04c39f 100644
--- a/winsup/cygserver/configure.ac
+++ b/winsup/cygserver/configure.ac
@@ -9,9 +9,8 @@ dnl details.
 dnl
 dnl Process this file with autoconf to produce a configure script.
 
-AC_PREREQ(2.59)dnl
-AC_INIT([Cygwin Cygserver], 0,
-	cygwin@cygwin.com, cygwin, https://cygwin.com)
+AC_PREREQ([2.59])
+AC_INIT([Cygwin Cygserver],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
 AC_CONFIG_SRCDIR(cygserver.cc)
 AC_CONFIG_AUX_DIR(..)
 
@@ -19,7 +18,7 @@ AC_CONFIG_AUX_DIR(..)
 
 AC_PROG_INSTALL
 AC_NO_EXECUTABLES
-AC_CANONICAL_SYSTEM
+AC_CANONICAL_TARGET
 
 AC_PROG_CC
 AC_PROG_CXX
@@ -27,7 +26,9 @@ AC_PROG_CPP
 AC_LANG(C)
 
 AC_WINDOWS_HEADERS
+if test "x$with_only_headers" != "xyes"; then
 AC_WINDOWS_LIBS
+fi
 
 AC_LANG(C++)
 
@@ -66,4 +67,5 @@ esac
 ])
 
 AC_CONFIGURE_ARGS
-AC_OUTPUT(Makefile)
+AC_CONFIG_FILES([Makefile])
+AC_OUTPUT
diff --git a/winsup/cygwin/configure b/winsup/cygwin/configure
index 522fae6..4d6b449 100755
--- a/winsup/cygwin/configure
+++ b/winsup/cygwin/configure
@@ -2117,7 +2117,6 @@ test -n "$target_alias" &&
     NONENONEs,x,x, &&
   program_prefix=${target_alias}-
 
-
 ac_ext=c
 ac_cpp='$CPP $CPPFLAGS'
 ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -3393,6 +3392,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_only_headers" != "xyes"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3411,6 +3411,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index fc7697b..29b1e0c 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -10,9 +10,8 @@ dnl details.
 dnl
 dnl Process this file with autoconf to produce a configure script.
 
-AC_PREREQ(2.59)dnl
-AC_INIT([Cygwin DLL], 0,
-	cygwin@cygwin.com, cygwin, https://cygwin.com)
+AC_PREREQ([2.59])
+AC_INIT([Cygwin DLL],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
 AC_CONFIG_SRCDIR(Makefile.in)
 AC_CONFIG_HEADER(config.h)
 AC_CONFIG_AUX_DIR(..)
@@ -21,7 +20,7 @@ AC_CONFIG_AUX_DIR(..)
 
 AC_PROG_INSTALL
 AC_NO_EXECUTABLES
-AC_CANONICAL_SYSTEM
+AC_CANONICAL_TARGET
 
 AC_PROG_CC
 AC_PROG_CXX
@@ -29,7 +28,9 @@ AC_PROG_CPP
 AC_LANG(C)
 
 AC_WINDOWS_HEADERS
+if test "x$with_only_headers" != "xyes"; then
 AC_WINDOWS_LIBS
+fi
 
 AC_LANG(C++)
 
@@ -100,7 +101,7 @@ case "$target_cpu" in
 		DIN_FILE="x86_64.din"
 		TLSOFFSETS_H="tlsoffsets64.h"
 		;;
-   *)		AC_MSG_ERROR(Invalid target processor \"$target_cpu\") ;;
+   *)		AC_MSG_ERROR([Invalid target processor "$target_cpu"]) ;;
 esac
 
 AC_CONFIGURE_ARGS
@@ -110,4 +111,5 @@ AC_SUBST(DLL_ENTRY)
 AC_SUBST(DEF_DLL_ENTRY)
 AC_SUBST(DIN_FILE)
 AC_SUBST(TLSOFFSETS_H)
-AC_OUTPUT(Makefile)
+AC_CONFIG_FILES([Makefile])
+AC_OUTPUT
-- 
2.7.4
