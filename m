Return-Path: <SRS0=cgT5=7L=xs4all.nl=dhr-incognito@sourceware.org>
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by sourceware.org (Postfix) with ESMTPS id 4D9A14BA2E20
	for <cygwin-patches@cygwin.com>; Tue,  6 Jan 2026 16:06:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4D9A14BA2E20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=xs4all.nl
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4D9A14BA2E20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=195.121.94.167
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767715560; cv=none;
	b=pH2KBuP1AFM82vkI6iJff/h36XT1+n6Vm7ouu9I+oXb+TrwlDVkiUCTPq+H3iCbOFZhHWmAeUKgv+8QG5XITTZAEbignicBGKkCipEa27S+5kVLFSzjXZYbQe+HOC1UOTGVbeYMZ+EPqpQ+xpmEL9MecbeSMw7kqzoFgcMCFdFw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767715560; c=relaxed/simple;
	bh=dejjgOKseIj1g5ZV8bL0c6poNrCP3kOBABsDcr/AWUI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version; b=xAVrZHLIOHmHE8YD73U+XXo6tZ44dZMK4gGFjs/7s7vRJn5opUyDO1QZpKuwSdvNibd6CFBT6xS7dtQwENb0srxOYSTVla3d9wVPe0HmYirpAeyUIy5nND7LqEBqYtAuP5zGLLiuqFHWJaOX/ctoUyJrhZNwoVOsQ4aMFtp6e+w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4D9A14BA2E20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=SA5dT9gF
X-KPN-MessageId: 99cf90eb-eb19-11f0-9696-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 99cf90eb-eb19-11f0-9696-005056abbe64;
	Tue, 06 Jan 2026 17:06:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=EYmhVI72rXXYKWkanq8KAWDlkmhEcAQYgjJmv1W5kgU=;
	b=SA5dT9gFqAb7fm4hmaBZ8JBSZ9c2J+OeBSWL9qKVzwGxCi3Ozl9k43+b9aWDymumLcOD/8yxX+H1I
	 5ki3qqT8XPymSUMIZ/T1hlKyS9Dg0xRfkkB5M3gUjkU8c4cFzJWVMX0p9z4qiFeyp2QHdDkbp+LGKY
	 heGoe4sjJSbgbD6ZdDXtHREB8KKcE+eZt8HQv/eMcodYNlmVpHTwcOHaAqlXucin+ylRSAjI3GDATL
	 vhj6QcTzMe+PVjD2cFhan+lnXi+QD4O0vC1aFoc6mE5XJlSwTF9qNoe6pQq2tBQKrAbCWC38CH09TQ
	 /8XBBJjUzwUYZfA9AkLwyzhagwCbzsA==
X-KPN-MID: 33|122VxjbRjWZc1nuHSOujGpBtYY+o1eE9Uoqz460Tp3BQga3v3uwLI/6YX0mqKLA
 QMX+9HrBDxKZu/jLQIJbf/fkpVTKTvvRawl5sVdzenQY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Ovsy/K5IKRirr4Vu9hT8h+chEh7AsbNChTKJdeZg3FEokbSZYP3ZNEZm0egb6Uw
 Y7AWE2tbwMox88g1KkdtzhQ==
X-Originating-IP: 77.173.35.122
Received: from frodo.. (77-173-35-122.fixed.kpn.net [77.173.35.122])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 96d6bd21-eb19-11f0-b8d7-005056ab7584;
	Tue, 06 Jan 2026 17:05:58 +0100 (CET)
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
To: cygwin-patches@cygwin.com
Cc: "J.H. vd Water" <dhr-incognito@xs4all.nl>
Subject: [PATCH 1/1] Renaming AC_ARG_WITH([cross_bootstrap] to ... in order to avoid confusion.
Date: Tue,  6 Jan 2026 17:05:17 +0100
Message-Id: <20260106160517.4785-1-dhr-incognito@xs4all.nl>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Renaming macro  AC_ARG_WITH([cross_bootstrap]  to  AC_ARG_WITH([skip_mingw],  in
order to avoid confusion ...

About 10 years ago, Foley (a] was "messing around" with a stage1 gcc compiler for
Cygwin, and decided to rebuild cygwin1.dll, as he required only cygwin1.dll.

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

