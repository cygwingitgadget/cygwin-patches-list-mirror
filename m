Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-043.btinternet.com (mailomta10-sa.btinternet.com [213.120.69.16])
	by sourceware.org (Postfix) with ESMTPS id 9D8C33858C1F
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:39:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9D8C33858C1F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20230713113942.RCNO1396.sa-prd-fep-043.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:39:42 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED31E58
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeelveekheevhffgtdfffeefgfeljedtteegffeijeduffeugeekudekffejhfejgeenucffohhmrghinhepmhgrthhrihigrdhtrghrghgvthenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhho
	nhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED31E58; Thu, 13 Jul 2023 12:39:42 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 01/11] Cygwin: testsuite: Setup test prereqs in 'installation' the tests run in
Date: Thu, 13 Jul 2023 12:38:54 +0100
Message-Id: <20230713113904.1752-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Do some setup in the Cygwin 'installation' at testsuite/testinst/:

* Ensure /tmp exists

* Use BusyBox to provide executables needed by tests which use system()
(sh, sleep, ls)

This enables tests which use system(), or require /tmp to exist to pass.
---
 .github/workflows/cygwin.yml   |  3 ++-
 winsup/cygwin/Makefile.am      |  4 ++--
 winsup/doc/faq-programming.xml |  3 ++-
 winsup/testsuite/Makefile.am   | 25 ++++++++++++++++++++++++-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 575ff1fdc..248a3e4cd 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -71,6 +71,7 @@ jobs:
         packages: >-
           autoconf,
           automake,
+          busybox,
           cocom,
           dblatex,
           dejagnu,
@@ -116,6 +117,6 @@ jobs:
         export PATH=/usr/bin:$(cygpath ${SYSTEMROOT})/system32 &&
         export MAKEFLAGS=-j$(nproc) &&
         cd build &&
-        (export PATH=${{ matrix.target }}/winsup/testsuite/runtime:${PATH} && cmd /c $(cygpath -wa ${{ matrix.target }}/winsup/cygserver/cygserver) &) &&
+        (export PATH=${{ matrix.target }}/winsup/testsuite/testinst/bin:${PATH} && cmd /c $(cygpath -wa ${{ matrix.target }}/winsup/cygserver/cygserver) &) &&
         (cd ${{ matrix.target }}/winsup; make check || true)
       shell: C:\cygwin\bin\bash.exe --noprofile --norc -eo pipefail '{0}'
diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index c34ca6ddc..bfb5ead10 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -602,8 +602,8 @@ $(NEW_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES) $(LIBSERVER)\
 	$(newlib_build)/libm.a \
 	$(newlib_build)/libc.a \
 	-lgcc -lkernel32 -lntdll -Wl,-Map,cygwin.map
-	@$(MKDIR_P) ${target_builddir}/winsup/testsuite/runtime/
-	$(AM_V_at)$(INSTALL_PROGRAM) $(NEW_DLL_NAME) ${target_builddir}/winsup/testsuite/runtime/$(DLL_NAME)
+	@$(MKDIR_P) ${target_builddir}/winsup/testsuite/testinst/bin/
+	$(AM_V_at)$(INSTALL_PROGRAM) $(NEW_DLL_NAME) ${target_builddir}/winsup/testsuite/testinst/bin/$(DLL_NAME)
 
 # cygwin import library
 toolopts=--cpu=@target_cpu@ --ar=@AR@ --as=@AS@ --nm=@NM@ --objcopy=@OBJCOPY@
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 7fc6baf25..15ae6eac4 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -697,7 +697,8 @@ Building these programs can be disabled with the <literal>--without-cross-bootst
 option to <literal>configure</literal>.
 </para>
 
-<!-- If you want to run the tests, <literal>dejagnu</literal> is also required. -->
+<!-- If you want to run the tests, <literal>dejagnu</literal> and
+     <literal>busybox</literal> are also required. -->
 
 <para>
 Building the documentation also requires the <literal>dblatex</literal>,
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 7853d98e8..11332eda2 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -339,7 +339,7 @@ testdll_tmpdir = $(shell cygpath -ma $(tmpdir) | sed -e 's#^\([A-Z]\):#/cygdrive
 
 site-extra.exp: ../config.status Makefile
 	@rm -f ./tmp0
-	@echo "set runtime_root \"`pwd`/runtime\"" >> ./tmp0
+	@echo "set runtime_root \"`pwd`/testinst/bin\"" >> ./tmp0
 	@echo "set tmpdir $(tmpdir)" >> ./tmp0
 	@echo "set testdll_tmpdir $(testdll_tmpdir)" >> ./tmp0
 	@echo "set cygrun \"`pwd`/mingw/cygrun\"" >> ./tmp0
@@ -347,6 +347,29 @@ site-extra.exp: ../config.status Makefile
 
 EXTRA_DEJAGNU_SITE_CONFIG = site-extra.exp
 
+# Set up things in the Cygwin 'installation' at testsuite/testinst/ to provide
+# things which tests need to work
+#
+# * Create /tmp
+# * Ensure there is a /usr/bin/sh for tests which use system()
+# * Ensure there is a /usr/bin/sleep for tests which use system("sleep 10")
+# * Ensure there is a /usr/bin/ls for tests which  use system("ls")
+#
+# copy to avoid all the complexities: hardlink will fail if builddir is on a
+# separate filesystem, symlink would need to be constructed with regard to the
+# mounts of the test installation, and making it into /bin/ will cause
+# CreateProcess() to load cygwin1.dll from there.
+#
+# use busybox executables as they don't have any other shared library
+# dependencies other than cygwin1.dll.
+#
+
+check-local:
+	$(MKDIR_P) ${builddir}/testinst/tmp
+	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe sh.exe
+	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe sleep.exe
+	cd ${builddir}/testinst/bin && cp /usr/libexec/busybox/bin/busybox.exe ls.exe
+
 # target to build all the programs needed by check, without running check
 check_programs: $(check_PROGRAMS)
 
-- 
2.39.0

