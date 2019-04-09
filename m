Return-Path: <cygwin-patches-return-9316-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 848 invoked by alias); 9 Apr 2019 09:23:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 837 invoked by uid 89); 9 Apr 2019 09:23:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 09 Apr 2019 09:23:39 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 11:23:36 +0200
Received: from [172.28.53.60]	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hDmyd-0002xC-U4; Tue, 09 Apr 2019 11:23:36 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [rebase PATCH] Introduce --with-posix-shell configure flag.
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <65e46d68-33be-bfea-dfd2-756812ac3472@ssi-schaefer.com>
Date: Tue, 09 Apr 2019 09:23:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00023.txt.bz2

Some distros prefer a POSIX shell other than /bin/ash and /bin/dash.
---
 Makefile.in   |  4 ++--
 configure.ac  | 22 +++++++++++++++++-----
 peflagsall.in |  2 +-
 rebaseall.in  |  2 +-
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index e984070..34c4684 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -53,7 +53,7 @@ LN_S = @LN_S@
 SED = @SED@
 EGREP = @EGREP@
 FGREP = @FGREP@
-ASH = @ASH@
+POSIXSHELL = @POSIXSHELL@
 
 DEFAULT_INCLUDES = -I. -I$(srcdir) -I$(srcdir)/imagehelper
 DEFS = @DEFS@ -DVERSION='"$(PACKAGE_VERSION)"' -DLIB_VERSION='"$(LIB_VERSION)"' -DSYSCONFDIR='"$(sysconfdir)"'
@@ -128,7 +128,7 @@ edit = sed \
 	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
 	-e 's|@prefix[@]|$(prefix)|g' \
 	-e 's|@exec_prefix[@]|$(exec_prefix)|g' \
-	-e 's|@ASH[@]|$(ASH)|g' \
+	-e 's|@POSIXSHELL[@]|$(POSIXSHELL)|g' \
 	-e 's|@DEFAULT_OFFSET_VALUE[@]|$(DEFAULT_OFFSET_VALUE)|g'
 
 rebaseall peflagsall: Makefile
diff --git a/configure.ac b/configure.ac
index 1dc9bf4..2b42e47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -8,11 +8,23 @@ AC_CONFIG_SRCDIR([peflags.c])
 AC_PREFIX_DEFAULT([/usr])
 AC_CANONICAL_HOST
 
-AC_ARG_WITH([dash], AS_HELP_STRING([use dash instead of ash]),
-            [], [with_dash=no])
-ASH=ash
-AS_IF([test "x$with_dash" != xno], [ASH=dash])
-AC_SUBST([ASH])
+AC_MSG_CHECKING([for POSIX shell to use in scripts])
+AC_ARG_WITH([dash],
+			AS_HELP_STRING([--with-dash],
+						   [use /bin/dash instead of /bin/ash (deprecated in favor of --with-posix-shell=/bin/dash)]),
+            [with_posix_shell=/bin/dash])
+AC_ARG_WITH([posix-shell],
+			AS_HELP_STRING([--with-posix-shell=/bin/dash],
+						   [POSIX shell to use for scripts, default=/bin/ash]),
+			[AS_CASE([$with_posix_shell],
+					 [yes|no|''],
+					 [AC_MSG_ERROR([Need shell path for --with-posix-shell, got '$with_posix_shell'.])],
+					 [/*],
+					 [POSIXSHELL=$with_posix_shell],
+					 [AC_MSG_ERROR([Need absolute path for --with-posix-shell, got '$with_posix_shell'.])])],
+			[POSIXSHELL=/bin/ash])
+AC_SUBST([POSIXSHELL])
+AC_MSG_RESULT([$POSIXSHELL])
 
 AC_PROG_INSTALL
 AC_PROG_MKDIR_P
diff --git a/peflagsall.in b/peflagsall.in
index d838201..6839db4 100644
--- a/peflagsall.in
+++ b/peflagsall.in
@@ -1,4 +1,4 @@
-#!/bin/@ASH@
+#!@POSIXSHELL@
 
 #
 # Copyright (c) 2009,2011 Charles Wilson
diff --git a/rebaseall.in b/rebaseall.in
index 076cc32..af4fe3f 100644
--- a/rebaseall.in
+++ b/rebaseall.in
@@ -1,4 +1,4 @@
-#!/bin/@ASH@
+#!@POSIXSHELL@
 
 #
 # Copyright (c) 2003, 2005, 2006, 2008, 2011, 2012 Jason Tishler
-- 
2.19.2
