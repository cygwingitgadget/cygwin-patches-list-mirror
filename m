Return-Path: <cygwin-patches-return-8491-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67161 invoked by alias); 23 Mar 2016 13:34:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67127 invoked by uid 89); 23 Mar 2016 13:34:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Process, CCC, HTo:U*cygwin-patches
X-HELO: mail-qg0-f66.google.com
Received: from mail-qg0-f66.google.com (HELO mail-qg0-f66.google.com) (209.85.192.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 23 Mar 2016 13:34:23 +0000
Received: by mail-qg0-f66.google.com with SMTP id y89so1273738qge.0        for <cygwin-patches@cygwin.com>; Wed, 23 Mar 2016 06:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=GF6TeBUl6h5DGAfmpg2RFGfyWGHLKJ2fbocLalXx9yU=;        b=AkkBaTW6GI5+jsjXu1exOaD6VyEUqtPFX3BRR4MzsTI2PWg5nc6HRccXr+g3obuivL         q7P/mFpqig9Etia8FKqhjjGfA+rgjcwtgzSLqA4NBJy+akUs4VlNZZZRTRimudob7nmP         fZly9b/+r0IFawkdr6drmBZ7jAr+gXQ+uw4rkAgpl8dMWfGUNOMWnnNXPBM5+EJFM8us         /8hcTdD/WWT3iIH/PLY6QYpXG17zjKTH1sgSu5vkhLOEg7X333SyMqwDJAtGhTuhV1FF         1Q1r2biKvbjTXmI7XIUc7EcLRAbjRCOwiTIg1RpIR8EPcaNyb7F0qf7L0DgVK9HShsAK         jpzw==
X-Gm-Message-State: AD7BkJIslq0fidtHQLfVzt5Rco3S73mAa5UrkOr13bqJTsyPHYqKBxbuXzb+kztneat+nw==
X-Received: by 10.140.145.151 with SMTP id 145mr3658182qhr.95.1458740060876;        Wed, 23 Mar 2016 06:34:20 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id g76sm1087796qge.5.2016.03.23.06.34.20        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Wed, 23 Mar 2016 06:34:20 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH v2 1/3] Add option to not build mingw programs when cross compiling.
Date: Wed, 23 Mar 2016 13:34:00 -0000
Message-Id: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <56F0A4A9.7050305@cygwin.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com> <20160321193052.GG14892@calimero.vinschen.de> <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com> <20160321195845.GL14892@calimero.vinschen.de> <CAOFdcFMJon17kNFhOVBccrrUJH0PmD6Vsf75FO9QTAv+qf_d0A@mail.gmail.com> <56F0A4A9.7050305@cygwin.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00197.txt.bz2

Add an option to not require a mingw compiler when bootstrapping a cross toolchain.
Defaults to existing behavior.
Also update some obsolete macros.

winsup/ChangeLog
configure.ac: Add option to skip building programs that require mingw.
configure: Regenerate.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/configure    | 22 +++++++++++++++++++---
 winsup/configure.ac | 17 +++++++++++------
 2 files changed, 30 insertions(+), 9 deletions(-)
 mode change 100755 => 100644 winsup/configure.ac

diff --git a/winsup/configure b/winsup/configure
index 0887d66..988ce54 100755
--- a/winsup/configure
+++ b/winsup/configure
@@ -665,6 +665,7 @@ target_builddir'
 ac_subst_files=''
 ac_user_opts='
 enable_option_checking
+with_mingw_progs
 with_windows_headers
 with_windows_libs
 '
@@ -680,7 +681,8 @@ CXX
 CXXFLAGS
 CCC
 CPP'
-ac_subdirs_all='cygwin utils cygserver lsaauth doc'
+ac_subdirs_all='utils lsaauth
+cygwin cygserver doc'
 
 # Initialize some variables set by options.
 ac_init_help=
@@ -1293,6 +1295,8 @@ if test -n "$ac_init_help"; then
 Optional Packages:
   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
+  --without-mingw-progs   do not build programs using the mingw toolchain
+                          (useful for cross-compiling)
   --with-windows-headers=DIR
                           specify where the windows includes are located
   --with-windows-libs=DIR specify where the windows libraries are located
@@ -2092,7 +2096,6 @@ test -n "$target_alias" &&
     NONENONEs,x,x, &&
   program_prefix=${target_alias}-
 
-
 ac_ext=c
 ac_cpp='$CPP $CPPFLAGS'
 ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -3359,6 +3362,14 @@ ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $
 ac_compiler_gnu=$ac_cv_c_compiler_gnu
 
 
+# Check whether --with-mingw-progs was given.
+if test "${with_mingw_progs+set}" = set; then :
+  withval=$with_mingw_progs;
+else
+  with_mingw_progs=yes
+fi
+
+
 
 
 # Check whether --with-windows-headers was given.
@@ -3433,9 +3444,14 @@ export CXX
 
 
 
+if test "x$with_mingw_progs" != xyes; then
+
 
+subdirs="$subdirs utils lsaauth"
+
+fi
 
-subdirs="$subdirs cygwin utils cygserver lsaauth doc"
+subdirs="$subdirs cygwin cygserver doc"
 
 INSTALL_LICENSE="install-license"
 
diff --git a/winsup/configure.ac b/winsup/configure.ac
old mode 100755
new mode 100644
index 43b95c5..afa0d42
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -10,9 +10,8 @@ dnl details.
 dnl
 dnl Process this file with autoconf to produce a configure script.
 
-AC_PREREQ(2.59)dnl
-AC_INIT([Cygwin toplevel], 0,
-	cygwin@cygwin.com, cygwin, https://cygwin.com)
+AC_PREREQ([2.59])
+AC_INIT([Cygwin toplevel],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
 AC_CONFIG_SRCDIR(Makefile.in)
 AC_CONFIG_AUX_DIR(..)
 
@@ -20,12 +19,13 @@ AC_CONFIG_AUX_DIR(..)
 
 AC_PROG_INSTALL
 AC_NO_EXECUTABLES
-AC_CANONICAL_SYSTEM
+AC_CANONICAL_TARGET
 
 AC_PROG_CC
 AC_PROG_CXX
 AC_PROG_CPP
 AC_LANG(C)
+AC_ARG_WITH([mingw-progs],[AS_HELP_STRING([--without-mingw-progs],[do not build programs using the mingw toolchain (useful for cross-compiling)])],[],[with_mingw_progs=yes])
 
 AC_WINDOWS_HEADERS
 AC_WINDOWS_LIBS
@@ -34,11 +34,16 @@ AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
 
-AC_CONFIG_SUBDIRS(cygwin utils cygserver lsaauth doc)
+if test "x$with_mingw_progs" != xyes; then
+    AC_CONFIG_SUBDIRS([utils lsaauth])
+fi
+
+AC_CONFIG_SUBDIRS(cygwin cygserver doc)
 INSTALL_LICENSE="install-license"
 
 AC_SUBST(INSTALL_LICENSE)
 
 AC_PROG_MAKE_SET
 
-AC_OUTPUT(Makefile)
+AC_CONFIG_FILES([Makefile])
+AC_OUTPUT
-- 
2.7.4
