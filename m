Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-044.btinternet.com (mailomta28-re.btinternet.com
 [213.120.69.121])
 by sourceware.org (Postfix) with ESMTPS id B1BD6385B83D
 for <cygwin-patches@cygwin.com>; Sat, 18 Dec 2021 17:48:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B1BD6385B83D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-044.btinternet.com with ESMTP id
 <20211218174814.DRFD13120.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
 Sat, 18 Dec 2021 17:48:14 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 61A69BAC020F4390
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrleekgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeuieejgeduvdeutdffieeileefffdufeekhefgjefffeehtdekjeegkeeftdfffeenucfkphepkedurdduvdelrddugeeirddvtdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrvddtledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.209) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 61A69BAC020F4390; Sat, 18 Dec 2021 17:48:14 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Conditionally build documentation
Date: Sat, 18 Dec 2021 17:47:21 +0000
Message-Id: <20211218174721.12448-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 18 Dec 2021 17:48:20 -0000

Add a configure option '--disable-doc' to disable building of the
documentation by the 'all' target.

Check for the required tools at configure time, and require them if
building documentation is enabled.

Even if building the documentation was diabled with '--disable-doc',
'make -C doc' at the top-level can still make the documentation, if the
documentation tools were found. If the tools were not found, 'missing'
is used to issue a warning about that.

Update instructions for building Cygwin appropriately.

(Building documentation remains the default to increase the chances of
noticing when building the documentation is broken.)
---
 winsup/Makefile.am             |  6 +++++-
 winsup/configure.ac            | 25 ++++++++++++++++++++++++-
 winsup/doc/Makefile.am         |  2 +-
 winsup/doc/faq-programming.xml | 14 +++++++++-----
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/winsup/Makefile.am b/winsup/Makefile.am
index 067f74688..9efdd4cb1 100644
--- a/winsup/Makefile.am
+++ b/winsup/Makefile.am
@@ -14,6 +14,10 @@ cygdoc_DATA = \
 	CYGWIN_LICENSE \
 	COPYING
 
-SUBDIRS = cygwin cygserver doc utils testsuite
+SUBDIRS = cygwin cygserver utils testsuite
+
+if BUILD_DOC
+SUBDIRS += doc
+endif
 
 cygserver utils testsuite: cygwin
diff --git a/winsup/configure.ac b/winsup/configure.ac
index cf1128b37..4ae20509a 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -88,7 +88,30 @@ AC_SUBST(TLSOFFSETS_H)
 
 AM_CONDITIONAL(TARGET_X86_64, [test $target_cpu = "x86_64"])
 
-AC_CHECK_PROGS([DOCBOOK2XTEXI], [docbook2x-texi db2x_docbook2texi], [true])
+AC_ARG_ENABLE(doc,
+	      [AS_HELP_STRING([--enable-doc], [Build documentation])],,
+	      enable_doc=yes)
+AM_CONDITIONAL(BUILD_DOC, [test $enable_doc != "no"])
+
+AC_CHECK_PROGS([DOCBOOK2XTEXI], [docbook2x-texi db2x_docbook2texi])
+if test -z "$DOCBOOK2XTEXI" ; then
+    if test "x$enable_doc" != "xno"; then
+        AC_MSG_ERROR([docbook2texi is required to build documentation])
+    else
+        unset DOCBOOK2XTEXI
+        AM_MISSING_PROG([DOCBOOK2XTEXI], [docbook2texi])
+    fi
+fi
+
+AC_CHECK_PROGS([XMLTO], [xmlto])
+if test -z "$XMLTO"; then
+    if test "x$enable_doc" != "xno"; then
+        AC_MSG_ERROR([xmlto is required to build documentation])
+    else
+        unset XMLTO
+        AM_MISSING_PROG([XMLTO], [xmlto])
+    fi
+fi
 
 if test "x$with_cross_bootstrap" != "xyes"; then
     AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)
diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
index 534d67480..5164c6e0a 100644
--- a/winsup/doc/Makefile.am
+++ b/winsup/doc/Makefile.am
@@ -16,7 +16,7 @@ doc_DATA = \
 
 htmldir = $(datarootdir)/doc
 
-XMLTO=xmlto --skip-validation --with-dblatex
+XMLTO=@XMLTO@ --skip-validation --with-dblatex
 DOCBOOK2XTEXI=@DOCBOOK2XTEXI@ --xinclude --info --utf8trans-map=charmap
 
 -include Makefile.dep
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 26fcfe921..46dd23ab8 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -689,12 +689,16 @@ Building for 32-bit Cygwin also requires
 Building for 64-bit Cygwin also requires
 <literal>mingw64-x86_64-gcc-g++</literal> and
 <literal>mingw64-x86_64-zlib</literal>.
+</para>
+
 <!-- If you want to run the tests, <literal>dejagnu</literal> is also required. -->
-Normally, building ignores any errors in building the documentation,
-which requires the <literal>dblatex</literal>, <literal>docbook2X</literal>,
-<literal>docbook-xml45</literal>, <literal>docbook-xsl</literal>, and
-<literal>xmlto</literal> packages.  For more information on building the
-documentation, see the README included in the <literal>cygwin-doc</literal> package.
+
+<para>
+Building the documentation also requires the <literal>dblatex</literal>,
+<literal>docbook2X</literal>, <literal>docbook-xml45</literal>,
+<literal>docbook-xsl</literal>, and <literal>xmlto</literal> packages.  Building
+the documentation can be disabled with the <literal>--disable-doc</literal>
+option to <literal>configure</literal>.
 </para>
 
 <para>Next, check out the Cygwin sources from the
-- 
2.34.1

