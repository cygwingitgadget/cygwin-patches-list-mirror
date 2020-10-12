Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta29-re.btinternet.com
 [213.120.69.122])
 by sourceware.org (Postfix) with ESMTPS id 7A23C3870858
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 19:30:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7A23C3870858
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20201012193017.VLOF4599.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 12 Oct 2020 20:30:17 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.141.130.13]
X-OWM-Source-IP: 86.141.130.13 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddugedurddufedtrddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedurddufedtrddufedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.130.13) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC158892B4; Mon, 12 Oct 2020 20:30:17 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/8] Remove AC_PROG_MAKE_SET
Date: Mon, 12 Oct 2020 20:29:38 +0100
Message-Id: <20201012192943.15732-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 12 Oct 2020 19:30:20 -0000

This is only needed if we are using an ancient make which doesn't set
${MAKE}, but we say "This makefile requires GNU make." everywhere.

It only has an effect if @SET_MAKE@ is used, which we aren't doing
consistently.
---
 winsup/configure.ac           | 2 --
 winsup/cygserver/configure.ac | 2 --
 winsup/cygwin/Makefile.in     | 2 --
 winsup/cygwin/configure.ac    | 2 --
 4 files changed, 8 deletions(-)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index 131dc79ee..e917ee1c5 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -43,7 +43,5 @@ INSTALL_LICENSE="install-license"
 
 AC_SUBST(INSTALL_LICENSE)
 
-AC_PROG_MAKE_SET
-
 AC_CONFIG_FILES([Makefile])
 AC_OUTPUT
diff --git a/winsup/cygserver/configure.ac b/winsup/cygserver/configure.ac
index 560de0c05..d8b2a61fa 100644
--- a/winsup/cygserver/configure.ac
+++ b/winsup/cygserver/configure.ac
@@ -55,8 +55,6 @@ AC_CHECK_TOOL(NM, nm, nm)
 AC_CHECK_TOOL(DLLTOOL, dlltool, dlltool)
 AC_CHECK_TOOL(WINDRES, windres, windres)
 
-AC_PROG_MAKE_SET
-
 AC_ARG_ENABLE(debugging,
 [ --enable-debugging		Build a cygwin DLL which has more consistency checking for debugging],
 [case "${enableval}" in
diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 3a7a73adb..7f19a57fd 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -94,8 +94,6 @@ STRIP:=@STRIP@
 LDSCRIPT:=cygwin.sc
 MKDIRP:=$(INSTALL) -m 755 -d
 
-@SET_MAKE@
-
 # Setup the testing framework, if you have one
 EXPECT = `if [ -f $${rootme}/../../expect/expect$(EXEEXT) ] ; then \
 	    echo $${rootme}/../../expect/expect$(EXEEXT) ; \
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index ff12dc259..ac019c94e 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -59,8 +59,6 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
 AC_CHECK_TOOL(STRIP, strip, strip)
 AC_CHECK_TOOL(WINDRES, windres, windres)
 
-AC_PROG_MAKE_SET
-
 AC_ARG_ENABLE(debugging,
 [ --enable-debugging		Build a cygwin DLL which has more consistency checking for debugging],
 [case "${enableval}" in
-- 
2.28.0

