Return-Path: <cygwin-patches-return-8454-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29273 invoked by alias); 21 Mar 2016 17:16:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29109 invoked by uid 89); 21 Mar 2016 17:16:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=sk:xcross, CC, 109, cpp
X-HELO: mail-qk0-f195.google.com
Received: from mail-qk0-f195.google.com (HELO mail-qk0-f195.google.com) (209.85.220.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 17:16:01 +0000
Received: by mail-qk0-f195.google.com with SMTP id e124so7402420qkc.3        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 10:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=YS4husHXkciLsTF/B5qzsW335RYICekB8xQqwIUkSo0=;        b=G2egMxwHVGOaUpMqa4pwIQLhVVI/oSn9VrLbjO8iic/CeOsRCV0YSPw4/0erkYYBcu         ViFelUjOJo7HZCKZqNRWzXoMlQhn+MFl7XQMiAjnlu7O5RuhKmtvu6wpfCK+BIUa/QkN         m9HglDTTTgvTnpRSlt+s0FEbtDBMYRwA+cav49edtKXFcj0hqMlFhtWLqbjn1yaVN7Gt         e9WvufvAa6ILEJdnEBC/kr4r7mw/RV9NPC4XmQj5sspWW2J9o//xYDFexyLg5Cv8AZYR         dt/h2+YWDNo0yqWwtxuABtDR8UWAsyL5TBOIPw0NaVQwAH/RBnlBqw9XNYKN4EAQw6Nz         OqmQ==
X-Gm-Message-State: AD7BkJK9vckUjmqzVhJI8CSw04x7ouepYtc53cb3aV5VOAunGbO1bicdRuI5TkbP+TwRdw==
X-Received: by 10.55.76.213 with SMTP id z204mr41311092qka.58.1458580559195;        Mon, 21 Mar 2016 10:15:59 -0700 (PDT)
Received: from bronx.local.pefoley.com ([2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id n83sm12492145qhn.46.2016.03.21.10.15.58        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Mon, 21 Mar 2016 10:15:58 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 4/5] Don't build utils/lsaauth when cross compiling.
Date: Mon, 21 Mar 2016 17:16:00 -0000
Message-Id: <1458580546-14484-4-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00160.txt.bz2

Don't require a mingw compiler when bootstrapping a cross toolchain.
Also update some obsolete macros.

winsup/ChangeLog
configure.ac: Only build lsaauth and utils when compiling natively
configure: Regenerate.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/configure    | 11 ++++++++---
 winsup/configure.ac | 16 ++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)
 mode change 100755 => 100644 winsup/configure.ac

diff --git a/winsup/configure b/winsup/configure
index 0887d66..57c3378 100755
--- a/winsup/configure
+++ b/winsup/configure
@@ -680,7 +680,8 @@ CXX
 CXXFLAGS
 CCC
 CPP'
-ac_subdirs_all='cygwin utils cygserver lsaauth doc'
+ac_subdirs_all='utils lsaauth
+cygwin cygserver doc'
 
 # Initialize some variables set by options.
 ac_init_help=
@@ -2092,7 +2093,6 @@ test -n "$target_alias" &&
     NONENONEs,x,x, &&
   program_prefix=${target_alias}-
 
-
 ac_ext=c
 ac_cpp='$CPP $CPPFLAGS'
 ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
@@ -3433,9 +3433,14 @@ export CXX
 
 
 
+if test "x$cross_compiling" != xyes; then
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
index 43b95c5..ce4f4bb
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
 
@@ -20,7 +19,7 @@ AC_CONFIG_AUX_DIR(..)
 
 AC_PROG_INSTALL
 AC_NO_EXECUTABLES
-AC_CANONICAL_SYSTEM
+AC_CANONICAL_TARGET
 
 AC_PROG_CC
 AC_PROG_CXX
@@ -34,11 +33,16 @@ AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
 
-AC_CONFIG_SUBDIRS(cygwin utils cygserver lsaauth doc)
+if test "x$cross_compiling" != xyes; then
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
