Return-Path: <cygwin-patches-return-8492-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67324 invoked by alias); 23 Mar 2016 13:34:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67246 invoked by uid 89); 23 Mar 2016 13:34:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Process, 187, 98, i
X-HELO: mail-qg0-f65.google.com
Received: from mail-qg0-f65.google.com (HELO mail-qg0-f65.google.com) (209.85.192.65) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 23 Mar 2016 13:34:23 +0000
Received: by mail-qg0-f65.google.com with SMTP id 14so1230978qgg.3        for <cygwin-patches@cygwin.com>; Wed, 23 Mar 2016 06:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references:references:in-reply-to;        bh=rXKcuQzI67fUXfTuageuj/UxF0/ifr3uVK0uzGygV3Q=;        b=E/0GtRsmUM765GZrm1rQfo6uvVuKdu5iElObX1DdRAX76cokrynJvpOBJZr2IwLa5h         TqZ7uJDO0pab8YV5JrOiclC7frBUCalOQ1s5dkcRYfjwqBR05nIR9nGgOBnWvoLhS2OV         xBxynosVKFpSipPchFW9drcoLBGwDLP67054hk20GnCtbFzSXqGYQ5jQI+oJJQL3Yj3B         0L5PVMikKL1mA7NVLB3anB9Rz+aL3tsLOthdn2fTiNtkY3/YHx95VcWcgH/JLbZ8uWbv         21VyPqOHfUe7adNyDGVfgMORJswcdRwzr5W0xL+tl7Q+kInDLeEh7bS56hW8sefSMTWa         cF5g==
X-Gm-Message-State: AD7BkJLXuUEA7XriiJozWA/Po8aYuaNY4pVqUTf2xVdj8kG7luSstkSy+bQBuTHybatrfQ==
X-Received: by 10.140.249.6 with SMTP id u6mr3703718qhc.83.1458740061702;        Wed, 23 Mar 2016 06:34:21 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id g76sm1087796qge.5.2016.03.23.06.34.20        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Wed, 23 Mar 2016 06:34:21 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 2/3] Add with-only-headers
Date: Wed, 23 Mar 2016 13:34:00 -0000
Message-Id: <1458740052-19618-2-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com>
References: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-5-git-send-email-pefoley2@pefoley.com> <20160321194758.GH14892@calimero.vinschen.de> <CAOFdcFMC60YLscHWDzsRz3q9cF1-KAc-d=CPhS5W_LeFRb83tg@mail.gmail.com> <20160321203235.GM14892@calimero.vinschen.de> <CAOFdcFMxbfteqjYWG_FOJ73Ey3LUbTQ-hKRJYOdBBBdM3k7m_w@mail.gmail.com> <CAOFdcFNRzey3=r76N1RD=b3rYu7RRow_CzLQitZJc4cV2heY=A@mail.gmail.com>
In-Reply-To: <CAOFdcFNRzey3=r76N1RD=b3rYu7RRow_CzLQitZJc4cV2heY=A@mail.gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00198.txt.bz2

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
 winsup/configure              | 13 +++++++++++++
 winsup/configure.ac           |  6 +++++-
 winsup/cygserver/configure    |  3 ++-
 winsup/cygserver/configure.ac | 12 +++++++-----
 winsup/cygwin/configure       |  3 ++-
 winsup/cygwin/configure.ac    | 14 ++++++++------
 7 files changed, 42 insertions(+), 14 deletions(-)

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
index 988ce54..2cf3775 100755
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
@@ -666,6 +667,7 @@ ac_subst_files=''
 ac_user_opts='
 enable_option_checking
 with_mingw_progs
+with_only_headers
 with_windows_headers
 with_windows_libs
 '
@@ -1297,6 +1299,8 @@ Optional Packages:
   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
   --without-mingw-progs   do not build programs using the mingw toolchain
                           (useful for cross-compiling)
+  --with-only-headers     only install headers for bootstraping a
+                          cross-compiler
   --with-windows-headers=DIR
                           specify where the windows includes are located
   --with-windows-libs=DIR specify where the windows libraries are located
@@ -3370,6 +3374,13 @@ else
 fi
 
 
+# Check whether --with-only-headers was given.
+if test "${with_only_headers+set}" = set; then :
+  withval=$with_only_headers;
+fi
+
+
+
 
 
 # Check whether --with-windows-headers was given.
@@ -3379,6 +3390,7 @@ if test "${with_windows_headers+set}" = set; then :
 fi
 
 
+if test "x$with_only_headers" != "xyes"; then
 
 
 # Check whether --with-windows-libs was given.
@@ -3397,6 +3409,7 @@ fi
 
 
 
+fi
 
 ac_ext=cpp
 ac_cpp='$CXXCPP $CPPFLAGS'
diff --git a/winsup/configure.ac b/winsup/configure.ac
index afa0d42..cc41d3f 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -26,9 +26,13 @@ AC_PROG_CXX
 AC_PROG_CPP
 AC_LANG(C)
 AC_ARG_WITH([mingw-progs],[AS_HELP_STRING([--without-mingw-progs],[do not build programs using the mingw toolchain (useful for cross-compiling)])],[],[with_mingw_progs=yes])
+AC_ARG_WITH([only-headers],[AS_HELP_STRING([--with-only-headers],[only install headers for bootstraping a cross-compiler])])
+AC_SUBST(with_only_headers)
 
 AC_WINDOWS_HEADERS
-AC_WINDOWS_LIBS
+if test "x$with_only_headers" != "xyes"; then
+    AC_WINDOWS_LIBS
+fi
 
 AC_LANG(C++)
 
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
