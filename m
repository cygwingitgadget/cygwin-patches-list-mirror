Return-Path: <SRS0=kb3c=7N=xs4all.nl=dhr-incognito@sourceware.org>
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by sourceware.org (Postfix) with ESMTPS id 766A44BA2E07
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 11:07:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 766A44BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=xs4all.nl
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 766A44BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=195.121.94.167
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767870475; cv=none;
	b=ppZiSJVE+EMlpn11uIdQXHjntD9Ah4At+w0GKwF02ndPtOH6kbNezdDIfYPrQvaDI9/Dx3uB71Ftp+Hvm2kE3qG+rth7XHdZwQSGugBYokq1fhckZS1zxtp0XtVLMqQY0wHzSG0PZ8KGzndkywOf3elaAeA8FN89cOhUdu9Lds0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767870475; c=relaxed/simple;
	bh=p0K+ESgU0dCn84mVvoTiRvSGPfSc6JgICpVR+y+9HU8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=hST15D1VywzYlzkOjv0tKDk+A8AvTPCeGkCkaEivCOrBAePpaqU6Whg4yUSTwmA8QaMbtqNZH7ekOd3vu3FxF2Hr9hEXL7JmcwKal4cUhiKfz/o+ifWJSWC4BGh54CtfWRyTeDCBNEDdFyaGR0eAEt7AJXhJK5+BKmgNdDYs8sU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 766A44BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=GEMbnXXw
X-KPN-MessageId: 4f103b5d-ec82-11f0-9696-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4f103b5d-ec82-11f0-9696-005056abbe64;
	Thu, 08 Jan 2026 12:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=zZxLiLa3o17CBZhnhKimpkG1QoFgyzLmPIo82m0MVKA=;
	b=GEMbnXXwqicnyJ+BlM77m5UNfyE/OfOHS0/dNkflwZpfsxfqP4Gou5uLgsKA8/RD29yWhgMEgt8ZP
	 FeMpCqoiFk2TawMTeIGtGOAoAKeEgVqN3DQ3GXN7CS12fM7a3ExCm6/hkkYmL+yeBjpxUR5NPCRP2I
	 Dzf1bWcyInbCjzl6lBX1G+axGcg27rVBQY5P8Q4mirGNlf4dlawnLWoI89iaFDnvbd1FXML6FsSN4L
	 n97Vlbj4Eewj8tGqnJQcAcjCdyfzn2Ak3yaJZ15eH/GWeCu9R4c/WgvJ3JjxUsP4uwfACUs/Rw2b0t
	 NuxwLYSZalGYeXWwMnuU5509SzceX6w==
X-KPN-MID: 33|Vb2/yTmcuIiTcX/OQ1ZKzfvPmq4qBHrlcUdj6kVb66ZnlF82/fCeSbg/2TeXN4K
 3Fj8VDqamR7UBjmW5H7aXLnnqjbr6doc2RU57wXhMHvE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HiRuRWuEIaiPV+nmBYeJcDmm5vkB8Axk9QWoyKLLMi5BLMiUgS7FVU7a4N0wYMq
 PYYsguQ5V4r99XG2zXEAvAw==
X-Originating-IP: 77.173.35.122
Received: from frodo.. (77-173-35-122.fixed.kpn.net [77.173.35.122])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4797cc62-ec82-11f0-b8d7-005056ab7584;
	Thu, 08 Jan 2026 12:07:54 +0100 (CET)
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
To: cygwin-patches@cygwin.com
Cc: "J.H. vd Water" <dhr-incognito@xs4all.nl>
Subject: [PATCH] Rename cross_bootstrap back to mingw_progs to avoid confusion.
Date: Thu,  8 Jan 2026 12:07:51 +0100
Message-Id: <20260108110751.5727-1-dhr-incognito@xs4all.nl>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon,

As requested. Patches verified (build). (No more "git" for me)

Regards Henri

From c59ddf124bf462b65df90d42c9f865a802d151ff Mon Sep 17 00:00:00 2001
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
Date: Thu, 8 Jan 2026 11:59:14 +0100
Subject: [PATCH] Rename cross_bootstrap back to mingw_progs to avoid
 confusion.

Revert the option name in AC_ARG_WITH([cross_bootstrap] back it its previous name,
mingw_progs, in order to avoid confusion ... Also revert the meaning of the macro.

About 10 years ago, Foley (1] was messing around with a stage1 gcc cross-compiler
for Cygwin on Linux, and decided he only required cygwin1.dll.

He did not like to rebuild assets, like cygcheck, strace, for which he was forced
to install the mingw-runtime (then: mingw-crt) and the MinGW toolchain.

Foley decided to change the option name of the AC_ARG_WITH([mingw_progs] macro in
winsup/configure.ac; however, he also inverted the meaning of the --with(out)-FOO
switch (as Foley also inverted the test that follows the macro) ...

    --with-FOO changed from: "Hunt for mingw" ... to "do NOT hunt for mingw"
    --without-FOO changed from: "do NOT hunt for mingw" ... to "Hunt for mingw"

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

Therefore I suggest to revert both the option name of the macro and the meaning of
the macro to what they were: option name: mingw_progs, meaning: Hunt for the MinGW
Toolchain (if --with-mingw-progs is specified).

[1]
 - https://cygwin.com/cgit/newlib-cygwin/commit/winsup/configure.ac?id=e7e6119241d02241c3d114cff037340c12245393
   ( Rename without-mingw-progs to with-cross-bootstrap ) ... 2016-04-02

[2]
 - https://cygwin.com/cgit/cygwin-htdocs/commit/faq/faq.html?id=9d693eea564ec608569c2f5d78536827e99f1661
   ( Cygwin 3.5.0 release ) ... 2024-02-01
---
 winsup/configure.ac            | 10 +++++++---
 winsup/doc/faq-programming.xml |  4 ++--
 winsup/testsuite/Makefile.am   |  2 +-
 winsup/utils/Makefile.am       |  2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index 05b5a9897..d40869f57 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -40,7 +40,11 @@ AM_PROG_AS
 AC_LANG(C)
 AC_LANG(C++)
 
-AC_ARG_WITH([cross-bootstrap],[AS_HELP_STRING([--with-cross-bootstrap],[do not build programs using the MinGW toolchain or check for MinGW libraries (useful for bootstrapping a cross-compiler)])],[],[with_cross_bootstrap=no])
+AC_ARG_WITH([mingw_progs],
+  [AS_HELP_STRING([--without-mingw-progs],
+    [do not build programs using the MinGW toolchain])],
+  [],
+  [with_mingw_progs=yes])
 
 AC_CYGWIN_INCLUDES
 
@@ -132,13 +136,13 @@ if test -z "$XMLTO"; then
     fi
 fi
 
-if test "x$with_cross_bootstrap" != "xyes"; then
+if test "x$with_mingw_progs" != "xno"; then
     AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)
     test -n "$MINGW_CXX" || AC_MSG_ERROR([no acceptable MinGW g++ found in \$PATH])
     AC_CHECK_PROGS(MINGW_CC, ${target_cpu}-w64-mingw32-gcc)
     test -n "$MINGW_CC" || AC_MSG_ERROR([no acceptable MinGW gcc found in \$PATH])
 fi
-AM_CONDITIONAL(CROSS_BOOTSTRAP, [test "x$with_cross_bootstrap" != "xyes"])
+AM_CONDITIONAL(MINGW_PROGS, [test "x$with_mingw_progs" != "xno"])
 
 AC_EXEEXT
 
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index ac361839a..0359e01f1 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -694,7 +694,7 @@ Additionally, building the <code>dumper</code> utility requires
 Building those Cygwin utilities which are not themselves Cygwin programs
 (e.g. <code>cygcheck</code> and <code>strace</code>) also requires
 <literal>mingw64-x86_64-gcc-g++</literal> and <literal>mingw64-x86_64-zlib</literal>.
-Building these programs can be disabled with the <literal>--without-cross-bootstrap</literal>
+Building these programs can be disabled with the <literal>--without-mingw-progs</literal>
 option to <literal>configure</literal>.
 </para>
 
@@ -707,7 +707,7 @@ Build of <literal>cygserver</literal> can be skipped with
 <para>
 In combination, <literal>--disable-cygserver</literal>,
 <literal>--disable-dumper</literal>, <literal>--disable-utils</literal>
-and <literal>--without-cross-bootstrap</literal> allow building of just
+and <literal>--without-mingw-progs</literal> allow building of just
 <literal>cygwin1.dll</literal> and <literal>crt0.o</literal> for a stage2
 compiler, when being built with stage1 compiler which does not support linking
 executables yet (because those files are missing).
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 20e06b9c5..0ff23d041 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -382,6 +382,6 @@ clean-local:
 	rm -f *.stackdump
 	rm -rf ${builddir}/testinst/tmp
 
-if CROSS_BOOTSTRAP
+if MINGW_PROGS
 SUBDIRS = mingw
 endif
diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
index 57a4f377c..4a7936a6e 100644
--- a/winsup/utils/Makefile.am
+++ b/winsup/utils/Makefile.am
@@ -90,6 +90,6 @@ profiler_LDADD = $(LDADD) -lntdll
 cygps_LDADD = $(LDADD) -lpsapi -lntdll
 newgrp_LDADD = $(LDADD) -luserenv
 
-if CROSS_BOOTSTRAP
+if MINGW_PROGS
 SUBDIRS = mingw
 endif
-- 
2.38.1

