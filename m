Return-Path: <cygwin-patches-return-8520-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113252 invoked by alias); 31 Mar 2016 16:34:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113236 invoked by uid 89); 31 Mar 2016 16:34:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=target_cpu, 1094, circular, HTo:U*cygwin-patches
X-HELO: mail-qg0-f46.google.com
Received: from mail-qg0-f46.google.com (HELO mail-qg0-f46.google.com) (209.85.192.46) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 31 Mar 2016 16:33:55 +0000
Received: by mail-qg0-f46.google.com with SMTP id w104so63840512qge.3        for <cygwin-patches@cygwin.com>; Thu, 31 Mar 2016 09:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=DvYv1DETmtm9sVXB4b/MQmPM3JdrTyJu2XnR1rLJPLc=;        b=RKZnQhp0O5gDjTwsvDvTmM6BXHVzh3bfB5UxJii/w+4pF4BgI8/OTeTtq39XpgEoMI         6F1zvJRJzZZhRPdPS/OthsDbaJ2R2Ss9Xm1kgHb9Wkl78FoZ2hFVynWkj0LoJT2zWWTW         ykRNZjjTl8GkfZ37w/GEY4Uh1fIoaOcUyciMEXKplnlSBZ5HG0abwrxx2cpRpRl83iov         Nc6dAFS9q4CQi4lnTxuftjV69G7K5hnIuKlGH58VKTDS++ejCu5S3vywBfgR6u0SsUgJ         qu3dsuOgwD0cMXXn8TcoVwKw0pNqE0JTXioqcmwVeHyO/E/Fb33jck2EcSQZ4kzL/gvB         97qA==
X-Gm-Message-State: AD7BkJID0Hxv0BK3bdMMo9xBjwHFpwQmkjUEW4MQvpQa+ltYA8IQ8B9KMxRhkxd80M3slw==
X-Received: by 10.141.6.9 with SMTP id i9mr18341434qhd.21.1459442033364;        Thu, 31 Mar 2016 09:33:53 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id x136sm4265931qka.0.2016.03.31.09.33.52        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Thu, 31 Mar 2016 09:33:52 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH] Add without-library-checks
Date: Thu, 31 Mar 2016 16:34:00 -0000
Message-Id: <1459442026-4544-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00226.txt.bz2

When cross-compiling a toolchan targeting cygwin, building cygwin1.dll
requires libgcc.
However, building libgcc requires the cygwin headers to be
installed.
Configuring cygwin requries the mingw-crt libraries, which require the
cygwin headers to be installed.
Work around this circular dependency by adding a
--without-library-checks configure option to skip cygwin's configure checks
for valid mingw-crt libraries.
Since the mingw-crt libraries only require the cygwin headers to be
installed, this allows us to successfully configure cygwin so that we
can only install the headers without trying to build any
libraries.

winsup/ChangeLog
configure.ac: add without-library-checks option
configure: regenerate
winsup/cygserver/ChangeLog
configure.ac: don't check AC_WINDOWS_LIBS when using without-library-checks
configure: regenerate
winsup/cygwin/ChangeLog
configure.ac: don't check AC_WINDOWS_LIBS when using without-library-checks
configure: regenerate

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/configure              | 14 ++++++++++++++
 winsup/configure.ac           |  5 ++++-
 winsup/cygserver/configure    |  2 ++
 winsup/cygserver/configure.ac |  9 ++++++---
 winsup/cygwin/configure       |  2 ++
 winsup/cygwin/configure.ac    | 11 +++++++----
 6 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/winsup/configure b/winsup/configure
index 541c81b..5abf793 100755
--- a/winsup/configure
+++ b/winsup/configure
@@ -666,6 +666,7 @@ ac_subst_files=''
 ac_user_opts='
 enable_option_checking
 with_mingw_progs
+with_library_checks
 with_windows_headers
 with_windows_libs
 '
@@ -1297,6 +1298,9 @@ Optional Packages:
   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
   --without-mingw-progs   do not build programs using the mingw toolchain
                           (useful for cross-compiling)
+  --without-library-checks
+                          do not check for valid w32api libraries (useful for
+                          bootstraping a cross-compiler)
   --with-windows-headers=DIR
                           specify where the windows includes are located
   --with-windows-libs=DIR specify where the windows libraries are located
@@ -3370,6 +3374,14 @@ else
 fi
 
 
+# Check whether --with-library_checks was given.
+if test "${with_library_checks+set}" = set; then :
+  withval=$with_library_checks;
+else
+  with_library_checks=yes
+fi
+
+
 
 
 # Check whether --with-windows-headers was given.
@@ -3379,6 +3391,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_library_checks" != "xno"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3397,6 +3410,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
diff --git a/winsup/configure.ac b/winsup/configure.ac
index b04f044..3c27674 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -26,9 +26,12 @@ AC_PROG_CXX
 AC_PROG_CPP
 AC_LANG(C)
 AC_ARG_WITH([mingw-progs],[AS_HELP_STRING([--without-mingw-progs],[do not build programs using the mingw toolchain (useful for cross-compiling)])],[],[with_mingw_progs=yes])
+AC_ARG_WITH([library_checks],[AS_HELP_STRING([--without-library-checks],[do not check for valid w32api libraries (useful for bootstraping a cross-compiler)])],[],[with_library_checks=yes])
 
 AC_WINDOWS_HEADERS
-AC_WINDOWS_LIBS
+if test "x$with_library_checks" != "xno"; then
+    AC_WINDOWS_LIBS
+fi
 
 AC_LANG(C++)
 
diff --git a/winsup/cygserver/configure b/winsup/cygserver/configure
index 37caf57..c2112ed 100755
--- a/winsup/cygserver/configure
+++ b/winsup/cygserver/configure
@@ -3381,6 +3381,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_library_checks" != "xno"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3399,6 +3400,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
diff --git a/winsup/cygserver/configure.ac b/winsup/cygserver/configure.ac
index 5d1464b..3c96a57 100644
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
+if test "x$with_library_checks" != "xno"; then
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
index aa26015..8e69354 100755
--- a/winsup/cygwin/configure
+++ b/winsup/cygwin/configure
@@ -3392,6 +3392,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_library_checks" != "xno"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3410,6 +3411,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index fe8e038..efef76f 100644
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
+if test "x$with_library_checks" != "xno"; then
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
