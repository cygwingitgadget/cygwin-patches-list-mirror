Return-Path: <SRS0=+170=D2=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.80])
	by sourceware.org (Postfix) with ESMTP id 42C744BA2E2E
	for <cygwin-patches@cygwin.com>; Fri, 29 May 2026 13:02:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 42C744BA2E2E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 42C744BA2E2E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780059727; cv=none;
	b=dS/MwZJauC0KNdgEE1JPUHV9Hub8wJmEI40Mol+0EU/RXfEhg2nDlunvHjKPzIf3dxpP2DgmUlf1xEyf6HPjZ5FWsOUWZu1R/RwKOBU5VBJxTyvXryMIuEMdy+w805mHuwbmb5jH2q7xKmMQ15onc5VHbwTcTV+YDNbI2Kp6zkU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780059727; c=relaxed/simple;
	bh=yjSt0M24DEWtaAD34fLZFhfrGsU4kNxJ6iSOLLMez1g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=opffju5S8TPXfN6xbPPVaQpZagIWMkpdCSdo4MG1GUCnrswCKL6lOkBk+UY4PX/4t/vCWGKalOC6KbCGhBgusrXgYnD6K1z9AOAkP28sTJFXivRm5ZNw7/F8KdKdL3YgS6+PKcE0iBqB2fMZdKdZBsuOErhy0BIHamCuQxBTAxs=
ARC-Authentication-Results: i=1; sourceware.org
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A03A62201586AF4
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFwwtrzc739WTQmMosjf/vLZbtjCtlR5euThiEKnX0vViTKyNlggmKk4gcE4lPUvBR0Lc5Se5euMfOTgZ4oL4wZ38742v4QC1bWO90j3ArIfJUrrNkhsEJ3UHLK2PTp868T4TuOnsPYXGC9O4m2j4kZSkUMjaNQjmgQaQb0GGjT1huodlFZuui1m+NSDRqKgWMgKaad9B5dpKpSXkTfGPGtDWF2SBp37X7r+BgwUoqo0BMkxy+58Ho0Af5RKnUuy2/U9MofkgaykpbgGdSBl34iZFZFZe3z3MWcZYpB40lzdXGmPkP+GrZsHRybgA9h51b9BcRF0OQTc903jITrcUZZA9bxJB9Ynm29sQmL14lIXB5sHuztjjuEbI6p1PB0GTFmxfuoEU7sfQXWLX/1gcETueTKG1JAIg3ISct8YqPpeJEHE6/VLEk2bRISdNgm0yse3INu6rfZOxhJDDDl/arvLEOqseFWJ+E0lrUYuZkIySvhe+m/M1uaTWimviUR9xw7vZklEzdd0LOu0UZ1tKybKYAvVCgTD+5ojLJgQ/y44/7LNjKyO7W+CCnHPLvn7aP4hUmJLd6mJ9YWuMfUxtlzpTHoqX0z74azQew7JISrzt2sAMNsKZuuBYCmojiYHJW+tStIpAiXOcIVPP482JnmN6TdJOgWDI9DR4xUyf1Tgg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (83.105.142.8) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A03A62201586AF4; Fri, 29 May 2026 14:01:46 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Only compute BFD_LIBS if building dumper
Date: Fri, 29 May 2026 14:01:40 +0100
Message-ID: <20260529130140.1275824-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Don't bother trying to determine the flags needed to link the BFD
library if we're not even building dumper.

(AC_NO_EXECUTABLES doesn't do what the name would simply suggest: It
silently checks if a trivial program can link, and turns itself off if
that suceeds.

Tests which rely on linking are only made to fail by AC_NO_EXECUTABLES
if that trivial link has failed (which OK, were probably going to fail
anyway, but now you get the error 'link tests are not allowed after
AC_NO_EXECUTABLES', which is perhaps slightly more informative when you
are cross-compiling with a bootstrap compiler).)

Anyhow, if we're using a compiler which can't link executables, these
instances of AC_CHECK_LIB will definitely fail.  But we can't possibly
build dumper in that situation, so we'll be configuring with
--disable-dumper, and doing those checks serves no purpose.
---
 winsup/configure.ac | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index ac96968e4..ad63cbf95 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -153,12 +153,14 @@ AC_ARG_ENABLE([dumper],
 
 AM_CONDITIONAL(BUILD_DUMPER, [test "x$build_dumper" = "xyes"])
 
-# libbfd.a doesn't have a pkgconfig file, so we guess what it's dependencies
-# are, based on what's present in the build environment
-BFD_LIBS="-lintl -liconv -liberty -lz"
-AC_CHECK_LIB([sframe], [sframe_decode], [BFD_LIBS="${BFD_LIBS} -lsframe"])
-AC_CHECK_LIB([zstd], [ZSTD_isError], [BFD_LIBS="${BFD_LIBS} -lzstd"])
-AC_SUBST([BFD_LIBS])
+if test "x$build_dumper" != "xno"; then
+  # libbfd.a doesn't have a pkgconfig file, so we guess what it's dependencies
+  # are, based on what's present in the build environment
+  BFD_LIBS="-lintl -liconv -liberty -lz"
+  AC_CHECK_LIB([sframe], [sframe_decode], [BFD_LIBS="${BFD_LIBS} -lsframe"])
+  AC_CHECK_LIB([zstd], [ZSTD_isError], [BFD_LIBS="${BFD_LIBS} -lzstd"])
+  AC_SUBST([BFD_LIBS])
+fi
 
 AC_CONFIG_FILES([
     Makefile
-- 
2.51.0

