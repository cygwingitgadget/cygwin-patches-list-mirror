Return-Path: <SRS0=86ZD=7M=xs4all.nl=dhr-incognito@sourceware.org>
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by sourceware.org (Postfix) with ESMTPS id 0F0E14BA2E05
	for <cygwin-patches@cygwin.com>; Wed,  7 Jan 2026 02:13:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0F0E14BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=xs4all.nl
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0F0E14BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=195.121.94.167
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767752022; cv=none;
	b=iebWIEC/Hk/FVLKPGYBW9oEr8jlv5iGohlhamM3VEEyrLlRWPw/PejhedcIdgGRRywNXHKTkIrAmXBWX3PznpQ3wPboOnzhdiVoav9BONVW3otxGKnQQI/InTBs3Jg3NGeZKQmZOjc9128hToHDfUwF8Cw965f6kOZxY2bRVaXE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767752022; c=relaxed/simple;
	bh=qlVFJ7zE35ueWzioCVkIS3DDZ5cm8HABbOOyzukucOs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=i/mzAppIaDy68bmJbdaDHyUQ+UkakCqGwFhBbURIgfoEQM93rnd5NYY/JCB3JDFnfMwvmMorskffScAhEOcQF6DQlPL0cn8ljr9Xbj6vkMRW0i3d/2GCmET4wcgr+HMBv/7wK9yM7CbPLZaiwUL86wsDgpXQHeyS6KyNhhZOuvI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0F0E14BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=IJ+zBRcJ
X-KPN-MessageId: 7fa1fc44-eb6e-11f0-9696-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7fa1fc44-eb6e-11f0-9696-005056abbe64;
	Wed, 07 Jan 2026 03:13:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=QxA4n9P9XPd+qEJ4OCmFchI1i/yeaS+3w0Tw1ss+nus=;
	b=IJ+zBRcJA/CRw9JEwq8OepFSbQUM5cjq7G3SiK6A0bVDdWxak/2iMI1bIt4v86xAdGO0BLGHpRgzj
	 vuydq/v01vgnaN5JuCEIyL/JjpD2I5vvbaaZHnDCoTKcEAE07pFYXJklWNi/87yfaFV4RWbDMTrpOo
	 ldv93isfVjGV9EGYHzu/mXLZb5oIJFSlyv1F/wpelc1CTICJteITZfck0gPzt+mzpkCQPgaltHJ+1v
	 nbUOnVaY2Wp8902VGOy7jFk2zuTIw/Dl6z2+uplW9S1sXj1jF+a+USzf56oaN5qmEVNZPDjG92M0oK
	 70cfQED8dhNWsPqf6TMJwd3FlkfELqg==
X-KPN-MID: 33|aHHL6C7WuweSC9CTT3OFAdszde/MzFe6s42BCyLoSqRZ9d/n9kUrAF6TisnQsEV
 v07EkyS7CRpSIIQAYFEJ6FPzd0y7K+l74Pu95q8nbkGI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3Kl1SVbTmzKR8gFFQZm2g/iDlK9OY3zQOBqmYHAOwab2m0wuw29IIai7DH0Ja36
 etvKhGAVIdxjXywB2DO9dQw==
X-Originating-IP: 77.173.35.122
Received: from frodo.. (77-173-35-122.fixed.kpn.net [77.173.35.122])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 7b9958a1-eb6e-11f0-a6ca-005056abf0db;
	Wed, 07 Jan 2026 03:13:40 +0100 (CET)
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
To: cygwin-patches@cygwin.com
Cc: "J.H. vd Water" <dhr-incognito@xs4all.nl>
Subject: [PATCH v2] Rename cross_bootstrap to skip_mingw to avoid confusion.
Date: Wed,  7 Jan 2026 03:13:36 +0100
Message-Id: <20260107021336.2481-1-dhr-incognito@xs4all.nl>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Rename macro  AC_ARG_WITH([cross_bootstrap] to AC_ARG_WITH([skip_mingw], in order
to avoid confusion ...

About 10 years ago, Foley (1] was "messing around" with a stage1 cross-compiler
for Cygwin, and decided to rebuild cygwin1.dll, as he required only cygwin1.dll.

He did not like to rebuild assets, like cygcheck, strace, for which he was forced
to install mingw-runtime (then: mingw-crt) and the MinGW toolchain.

To meet his intention, Foley decided to change the AC_ARG_WITH([mingw_progs] macro
in winsup/configure.ac; he not only changed the option name of the macro, he also
inverted the meaning of the  --with-FOO  switch (as Foley also inverted both tests
that follow the macro) ...

    with-FOO changed from: "Hunt for mingw" ... to "do NOT hunt for mingw".

Originally:
AC_ARG_WITH([mingw_progs], ...
if test "x$with_mingw_progs" != xno; then
  Hunt for mingw

Foley:
AC_ARG_WITH([cross_bootstrap], ...
if test "x$with_cross_bootstrap" != "xyes"; then
  Hunt for mingw

Foley changed the option name of the macro to "cross-bootstrap", which confused not
only Corinna V. [2], but is still confusing to everyone today!

A better name would have been: "skip_mingw".

Once more: by --withOUT cross-bootstrap,  Foley meant:  Hunt for mingw (contrary to
how the switch is usually interpreted) ...

[1]
 - https://cygwin.com/cgit/newlib-cygwin/commit/winsup/configure.ac?id=e7e6119241d02241c3d114cff037340c12245393
   ( Rename without-mingw-progs to with-cross-bootstrap ) ... 2016-04-02

[2]
 - https://cygwin.com/cgit/cygwin-htdocs/commit/faq/faq.html?id=9d693eea564ec608569c2f5d78536827e99f1661
   ( Cygwin 3.5.0 release ) ... 2024-02-01

Therefore I suggest to change the option name of the macro into  "skip_mingw" , as
follows:
---
 winsup/configure.ac            | 10 +++++++---
 winsup/doc/faq-programming.xml |  4 ++--
 winsup/testsuite/Makefile.am   |  2 +-
 winsup/utils/Makefile.am       |  2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index 05b5a9897..c52645eb7 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -40,7 +40,11 @@ AM_PROG_AS
 AC_LANG(C)
 AC_LANG(C++)
 
-AC_ARG_WITH([cross-bootstrap],[AS_HELP_STRING([--with-cross-bootstrap],[do not build programs using the MinGW toolchain or check for MinGW libraries (useful for bootstrapping a cross-compiler)])],[],[with_cross_bootstrap=no])
+AC_ARG_WITH([skip_mingw],
+  [AS_HELP_STRING([--with-skip-mingw],
+    [do not build programs using the MinGW toolchain])],
+  [],
+  [with_skip_mingw=no])
 
 AC_CYGWIN_INCLUDES
 
@@ -132,13 +136,13 @@ if test -z "$XMLTO"; then
     fi
 fi
 
-if test "x$with_cross_bootstrap" != "xyes"; then
+if test "x$with_skip_mingw" != "xyes"; then
     AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)
     test -n "$MINGW_CXX" || AC_MSG_ERROR([no acceptable MinGW g++ found in \$PATH])
     AC_CHECK_PROGS(MINGW_CC, ${target_cpu}-w64-mingw32-gcc)
     test -n "$MINGW_CC" || AC_MSG_ERROR([no acceptable MinGW gcc found in \$PATH])
 fi
-AM_CONDITIONAL(CROSS_BOOTSTRAP, [test "x$with_cross_bootstrap" != "xyes"])
+AM_CONDITIONAL(SKIP_MINGW, [test "x$with_skip_mingw" != "xyes"])
 
 AC_EXEEXT
 
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index ac361839a..2e69e7574 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -694,7 +694,7 @@ Additionally, building the <code>dumper</code> utility requires
 Building those Cygwin utilities which are not themselves Cygwin programs
 (e.g. <code>cygcheck</code> and <code>strace</code>) also requires
 <literal>mingw64-x86_64-gcc-g++</literal> and <literal>mingw64-x86_64-zlib</literal>.
-Building these programs can be disabled with the <literal>--without-cross-bootstrap</literal>
+Building these programs can be disabled with the <literal>--with-skip-mingw</literal>
 option to <literal>configure</literal>.
 </para>
 
@@ -707,7 +707,7 @@ Build of <literal>cygserver</literal> can be skipped with
 <para>
 In combination, <literal>--disable-cygserver</literal>,
 <literal>--disable-dumper</literal>, <literal>--disable-utils</literal>
-and <literal>--without-cross-bootstrap</literal> allow building of just
+and <literal>--with-skip-mingw</literal> allow building of just
 <literal>cygwin1.dll</literal> and <literal>crt0.o</literal> for a stage2
 compiler, when being built with stage1 compiler which does not support linking
 executables yet (because those files are missing).
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 20e06b9c5..a3d33bb82 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -382,6 +382,6 @@ clean-local:
 	rm -f *.stackdump
 	rm -rf ${builddir}/testinst/tmp
 
-if CROSS_BOOTSTRAP
+if SKIP_MINGW
 SUBDIRS = mingw
 endif
diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
index 57a4f377c..7d05a83e6 100644
--- a/winsup/utils/Makefile.am
+++ b/winsup/utils/Makefile.am
@@ -90,6 +90,6 @@ profiler_LDADD = $(LDADD) -lntdll
 cygps_LDADD = $(LDADD) -lpsapi -lntdll
 newgrp_LDADD = $(LDADD) -luserenv
 
-if CROSS_BOOTSTRAP
+if SKIP_MINGW
 SUBDIRS = mingw
 endif
-- 
2.38.1

