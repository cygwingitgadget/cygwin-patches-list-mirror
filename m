Return-Path: <SRS0=Rby/=4M=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-041.btinternet.com (mailomta19-sa.btinternet.com [213.120.69.25])
	by sourceware.org (Postfix) with ESMTPS id ABEBE382E748
	for <cygwin-patches@cygwin.com>; Wed, 14 Dec 2022 17:31:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org ABEBE382E748
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20221214173111.GDCQ8077.sa-prd-fep-041.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 14 Dec 2022 17:31:11 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C47E10ACA
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 6139417C47E10ACA; Wed, 14 Dec 2022 17:31:11 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Cygwin: configure: Add option to disable building 'dumper'
Date: Wed, 14 Dec 2022 17:30:39 +0000
Message-Id: <20221214173040.8431-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214173040.8431-1-jon.turney@dronecode.org.uk>
References: <20221214173040.8431-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Rather than guessing, based on just the presence of libbfd, add an
explicit configuration option, to build dumper or not, defaulting to
building it.

This might have some use when bootstrapping Cygwin for a new
architecture, or when building your own Cygwin-targetted cross-compiler,
rather than installing one from the copr, along with the dependencies of
libbfd.
---
 winsup/configure.ac            | 8 +++++---
 winsup/doc/faq-programming.xml | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index 9205a8886..7a2121dae 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -111,10 +111,12 @@ AM_CONDITIONAL(CROSS_BOOTSTRAP, [test "x$with_cross_bootstrap" != "xyes"])
 
 AC_EXEEXT
 
-AC_CHECK_LIB([bfd], [bfd_init], [true],
-	     AC_MSG_WARN([Not building dumper.exe since some required libraries or headers are missing]))
+AC_ARG_ENABLE([dumper],
+	      [AS_HELP_STRING([--disable-dumper], [do not build the 'dumper' utility])],
+	      [build_dumper=$enableval],
+	      [build_dumper=yes])
 
-AM_CONDITIONAL(BUILD_DUMPER, [test "x$ac_cv_lib_bfd_bfd_init" = "xyes"])
+AM_CONDITIONAL(BUILD_DUMPER, [test "x$build_dumper" = "xyes"])
 
 AC_CONFIG_FILES([
     Makefile
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index a24b781cf..24c7f928e 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -685,7 +685,8 @@ installed; you at least need <literal>gcc-g++</literal>,
 <para>
 Additionally, building the <code>dumper</code> utility requires
 <literal>gettext-devel</literal>, <literal>libiconv-devel</literal>
-<literal>zlib-devel</literal>.
+<literal>zlib-devel</literal>.  Building this program can be disabled with the
+<literal>--disable-dumper</literal> option to <literal>configure</literal>.
 </para>
 
 <para>
-- 
2.39.0

