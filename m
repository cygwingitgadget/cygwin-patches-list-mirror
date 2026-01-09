Return-Path: <SRS0=Giq6=7O=xs4all.nl=dhr-incognito@sourceware.org>
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by sourceware.org (Postfix) with ESMTPS id 56F6F4BA2E05
	for <cygwin-patches@cygwin.com>; Fri,  9 Jan 2026 19:04:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 56F6F4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=xs4all.nl
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 56F6F4BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=195.121.94.167
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767985457; cv=none;
	b=VqY4dss2mbdnhc3+2CgV9GHy12LR34aNJzy+n9n768u13QmTYM2uLBCi6affskG3TsRB/DfUiUNdP9Rv9bD0a0FuzDe7JrBhjQ5zN6bNInn28uWPtPqTw2rsFgB0cR6o02EBQIT+ul/fmmRtfxuvyCCZhJMZhf7k4ltELtF2pMw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767985457; c=relaxed/simple;
	bh=Yr2LhrL+UDXj1XrLFfGU5HibHUFjCh27tYVOLVEeCYc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=R3x+UitEjX8zKBtICYmOLyTSEaHl6xG4IaJS6m09A7CrBe37Som5M2xus+/hRm2mnzpp82Z3YCwe9/XavKhaHCymD/m6u7d4BdBzi0ytKUwFCaH0RugFaYkYYlXbHYtNhPlMjkVGL/Pu5hq9J8/nuATdK/lyyQlh9nDyO8LAaYY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 56F6F4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=aofh8ZOK
X-KPN-MessageId: 088cb42a-ed8e-11f0-9696-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 088cb42a-ed8e-11f0-9696-005056abbe64;
	Fri, 09 Jan 2026 20:04:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=d72cx52AFUyLntb7WA3zfG3XIIRxmBwd25PxfNWz3Ro=;
	b=aofh8ZOKS+lseHmKtlNNqRG607Z9Qq5OM7TWkIAmLAEl9G6zSkJqlHJYvyLJuLEtXi46wETvzrWt5
	 CYR+Oi1mQjSBQZLH7utqGezwF9GC/KNXjgz8fFa5GaeHm1Ch/VdvNyTLZSsHw6KdIvQF4eGdRJDFN2
	 lTm2DhZH8HmdXthNA/GfjbMr+U27AjSLtiX3dlFmmLAiOPM6zzSAw0KzVdRyvtI7GtVoKppBs9WVn0
	 QM3yaMS/fFWiFgvNIfu3fK/QHzGXStx0k/YWwWX9UuzmirGT/OxWM3F849wcOH7Vud5G1H9lin2d3B
	 /Utp7QWTVRnVKGTBXp526FFci3ZSNAw==
X-KPN-MID: 33|00gCyJcveHIhtjMufPFEoSz3eOWEqZq7IZufyxQlJcs2+kcx4uqFK7ZuG0BMBpO
 68BfC6K6dvNBo5DY8APW12a0vFCyvb8V5pK+RM2puYDU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|rZt9PVMCCTqka/Viavqf2yukGnKfnvuSb7rcvRc+Ema8ONWrqAQXFs5D4ByajlZ
 C1mEas1RCg2aWXAGhy+rMcA==
X-Originating-IP: 77.173.35.122
Received: from frodo.. (77-173-35-122.fixed.kpn.net [77.173.35.122])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id fe479897-ed8d-11f0-800f-005056ab7447;
	Fri, 09 Jan 2026 20:04:16 +0100 (CET)
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
To: cygwin-patches@cygwin.com
Cc: "J.H. vd Water" <dhr-incognito@xs4all.nl>
Subject: [PATCH 1/1] Rename cross_bootstrap back to mingw_progs to avoid confusion.
Date: Fri,  9 Jan 2026 20:04:15 +0100
Message-Id: <20260109190415.25785-2-dhr-incognito@xs4all.nl>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260109190415.25785-1-dhr-incognito@xs4all.nl>
References: <20260109190415.25785-1-dhr-incognito@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Revert the option name in AC_ARG_WITH([cross_bootstrap] back to its previous name,
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

Signed-off-by: J.H. vd Water <dhr-incognito@xs4all.nl>
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

