Return-Path: <cygwin-patches-return-8546-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66244 invoked by alias); 2 Apr 2016 14:57:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66228 invoked by uid 89); 2 Apr 2016 14:57:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=subdirs, cross-compiler, crosscompiler, HTo:U*cygwin-patches
X-HELO: mail-qg0-f51.google.com
Received: from mail-qg0-f51.google.com (HELO mail-qg0-f51.google.com) (209.85.192.51) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 02 Apr 2016 14:57:06 +0000
Received: by mail-qg0-f51.google.com with SMTP id j35so118378474qge.0        for <cygwin-patches@cygwin.com>; Sat, 02 Apr 2016 07:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=JEovI4haAqzR7jbJROiPjbEk6DOMkNSZOuCnpykCsFA=;        b=baiq8yw/MUq+5wWPXbiTMAtg31AoATmscURgpqznCPnLs/+9J5WokCdmOnWp+BpHQA         3JHLP76mOIOjq5ZNf414H8Qz/GhOGoUExVAwtEjGQzMTsBvhKwDj+ScYGsMTTC46Fed/         sbhRVQCa4nDaN+2ZtACtsmVhWXEAqlNi6GkCYEDkpsb7fxvB6sbqY+FHg7XXg7q0Zjrp         4sg2HnxZrwIeiwLIhU4tdhfQFBAJ2nO6UoPl/axrOxcb9KXlRrHV6zMtq1f0CU6QfVaj         ymF7SJiynZW9knchmB3VEO3Nf0oqNklMdWYa78djYw/juB9+JNVPswTPbWSQ9/f96W6h         XQRw==
X-Gm-Message-State: AD7BkJIZkBiTcNjpAyzjv+pxDmKCiA85VDE1xkFrUcwPPq8jAcdx6zr8gn7awFDKgaZhjw==
X-Received: by 10.140.16.165 with SMTP id 34mr30674392qgb.79.1459609024139;        Sat, 02 Apr 2016 07:57:04 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id x136sm8479058qka.0.2016.04.02.07.57.03        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 02 Apr 2016 07:57:03 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH v2] Rename without-mingw-progs to with-cross-bootstrap
Date: Sat, 02 Apr 2016 14:57:00 -0000
Message-Id: <1459609004-28850-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00021.txt.bz2

Rename without-mingw-progs to with-cross-bootstrap, since it now
disables additional checks that are problematic for cross-compilers.

When cross-compiling a toolchain targeting cygwin, building cygwin1.dll
requires libgcc.
However, building libgcc requires the cygwin headers to be
installed.
Configuring cygwin requries the mingw-crt libraries, which require the
cygwin headers to be installed.
Work around this circular dependency by making the
--with-cross-bootstrap configure option skip cygwin's configure checks
for valid mingw-crt libraries. Cygwin will still properly link against
these libraries if they exist, but this allows configure to succeed even
if the libraries have not been built yet.
Since the mingw-crt libraries only require the cygwin headers to be
installed, this allows us to successfully configure cygwin so that we
can only install the headers without trying to build any
libraries.

winsup/ChangeLog
configure.ac: rename without-mingw-progs option to with-cross-bootstrap
configure: regenerate
winsup/cygserver/ChangeLog
configure.ac: don't check AC_WINDOWS_LIBS when using with-cross-bootstrap
configure: regenerate
winsup/cygwin/ChangeLog
configure.ac: don't check AC_WINDOWS_LIBS when using with-cross-bootstrap
configure: regenerate

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/configure              | 19 +++++++++++--------
 winsup/configure.ac           |  8 +++++---
 winsup/cygserver/configure    |  2 ++
 winsup/cygserver/configure.ac |  9 ++++++---
 winsup/cygwin/configure       |  2 ++
 winsup/cygwin/configure.ac    | 11 +++++++----
 6 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/winsup/configure b/winsup/configure
index 541c81b..23b3a7b 100755
--- a/winsup/configure
+++ b/winsup/configure
@@ -665,7 +665,7 @@ target_builddir'
 ac_subst_files=''
 ac_user_opts='
 enable_option_checking
-with_mingw_progs
+with_cross_bootstrap
 with_windows_headers
 with_windows_libs
 '
@@ -1295,8 +1295,9 @@ if test -n "$ac_init_help"; then
 Optional Packages:
   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
-  --without-mingw-progs   do not build programs using the mingw toolchain
-                          (useful for cross-compiling)
+  --with-cross-bootstrap  do not build programs using the mingw toolchain or
+                          check for mingw libraries (useful for bootstrapping
+                          a cross-compiler)
   --with-windows-headers=DIR
                           specify where the windows includes are located
   --with-windows-libs=DIR specify where the windows libraries are located
@@ -3362,11 +3363,11 @@ ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $
 ac_compiler_gnu=$ac_cv_c_compiler_gnu
 
 
-# Check whether --with-mingw-progs was given.
-if test "${with_mingw_progs+set}" = set; then :
-  withval=$with_mingw_progs;
+# Check whether --with-cross-bootstrap was given.
+if test "${with_cross_bootstrap+set}" = set; then :
+  withval=$with_cross_bootstrap;
 else
-  with_mingw_progs=yes
+  with_cross_bootstrap=no
 fi
 
 
@@ -3379,6 +3380,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_cross_bootstrap" != "xyes"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3397,6 +3399,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
@@ -3448,7 +3451,7 @@ export CXX
 
 subdirs="$subdirs cygwin cygserver doc"
 
-if test "x$with_mingw_progs" != xno; then
+if test "x$with_cross_bootstrap" != "xyes"; then
     subdirs="$subdirs utils lsaauth"
 
 fi
diff --git a/winsup/configure.ac b/winsup/configure.ac
index b04f044..3daa2ac 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -25,17 +25,19 @@ AC_PROG_CC
 AC_PROG_CXX
 AC_PROG_CPP
 AC_LANG(C)
-AC_ARG_WITH([mingw-progs],[AS_HELP_STRING([--without-mingw-progs],[do not build programs using the mingw toolchain (useful for cross-compiling)])],[],[with_mingw_progs=yes])
+AC_ARG_WITH([cross-bootstrap],[AS_HELP_STRING([--with-cross-bootstrap],[do not build programs using the mingw toolchain or check for mingw libraries (useful for bootstrapping a cross-compiler)])],[],[with_cross_bootstrap=no])
 
 AC_WINDOWS_HEADERS
-AC_WINDOWS_LIBS
+if test "x$with_cross_bootstrap" != "xyes"; then
+    AC_WINDOWS_LIBS
+fi
 
 AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
 
 AC_CONFIG_SUBDIRS(cygwin cygserver doc)
-if test "x$with_mingw_progs" != xno; then
+if test "x$with_cross_bootstrap" != "xyes"; then
     AC_CONFIG_SUBDIRS([utils lsaauth])
 fi
 
diff --git a/winsup/cygserver/configure b/winsup/cygserver/configure
index 37caf57..71d1592 100755
--- a/winsup/cygserver/configure
+++ b/winsup/cygserver/configure
@@ -3381,6 +3381,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_cross_bootstrap" != "xyes"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3399,6 +3400,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
diff --git a/winsup/cygserver/configure.ac b/winsup/cygserver/configure.ac
index 5d1464b..eb6a894 100644
--- a/winsup/cygserver/configure.ac
+++ b/winsup/cygserver/configure.ac
@@ -9,7 +9,7 @@ dnl details.
 dnl
 dnl Process this file with autoconf to produce a configure script.
 
-AC_PREREQ(2.59)
+AC_PREREQ([2.59])
 AC_INIT([Cygwin Cygserver],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
 AC_CONFIG_SRCDIR(cygserver.cc)
 AC_CONFIG_AUX_DIR(..)
@@ -26,7 +26,9 @@ AC_PROG_CPP
 AC_LANG(C)
 
 AC_WINDOWS_HEADERS
-AC_WINDOWS_LIBS
+if test "x$with_cross_bootstrap" != "xyes"; then
+  AC_WINDOWS_LIBS
+fi
 
 AC_LANG(C++)
 
@@ -65,4 +67,5 @@ esac
 ])
 
 AC_CONFIGURE_ARGS
-AC_OUTPUT(Makefile)
+AC_CONFIG_FILES([Makefile])
+AC_OUTPUT
diff --git a/winsup/cygwin/configure b/winsup/cygwin/configure
index 30a1405..f655f57 100755
--- a/winsup/cygwin/configure
+++ b/winsup/cygwin/configure
@@ -3392,6 +3392,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_cross_bootstrap" != "xyes"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3410,6 +3411,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index 6397931..d8cdcde 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -10,7 +10,7 @@ dnl details.
 dnl
 dnl Process this file with autoconf to produce a configure script.
 
-AC_PREREQ(2.59)
+AC_PREREQ([2.59])
 AC_INIT([Cygwin DLL],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
 AC_CONFIG_SRCDIR(Makefile.in)
 AC_CONFIG_HEADER(config.h)
@@ -28,7 +28,9 @@ AC_PROG_CPP
 AC_LANG(C)
 
 AC_WINDOWS_HEADERS
-AC_WINDOWS_LIBS
+if test "x$with_cross_bootstrap" != "xyes"; then
+  AC_WINDOWS_LIBS
+fi
 
 AC_LANG(C++)
 
@@ -99,7 +101,7 @@ case "$target_cpu" in
 		DIN_FILE="x86_64.din"
 		TLSOFFSETS_H="tlsoffsets64.h"
 		;;
-   *)		AC_MSG_ERROR(Invalid target processor \"$target_cpu\") ;;
+   *)		AC_MSG_ERROR([Invalid target processor "$target_cpu"]) ;;
 esac
 
 AC_CONFIGURE_ARGS
@@ -109,4 +111,5 @@ AC_SUBST(DLL_ENTRY)
 AC_SUBST(DEF_DLL_ENTRY)
 AC_SUBST(DIN_FILE)
 AC_SUBST(TLSOFFSETS_H)
-AC_OUTPUT(Makefile)
+AC_CONFIG_FILES([Makefile])
+AC_OUTPUT
-- 
2.8.0
