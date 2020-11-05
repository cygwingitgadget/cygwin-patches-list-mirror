Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-047.btinternet.com (mailomta21-sa.btinternet.com
 [213.120.69.27])
 by sourceware.org (Postfix) with ESMTPS id 4294739F501E
 for <cygwin-patches@cygwin.com>; Thu,  5 Nov 2020 19:48:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4294739F501E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-047.btinternet.com with ESMTP id
 <20201105194818.YFPU28522.sa-prd-fep-047.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 5 Nov 2020 19:48:18 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B66119336E06
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnheptdeltdekgeffvefflefgueeftefffeegvefguefgfeduledvtdekteevgeekieevnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddufeelrdduheekrddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddugedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B66119336E06; Thu, 5 Nov 2020 19:48:18 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 06/11] Define target_builddir autoconf and Makefile variables
Date: Thu,  5 Nov 2020 19:47:43 +0000
Message-Id: <20201105194748.31282-7-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 05 Nov 2020 19:48:20 -0000

This now required as cygwin_build is defined in terms of
target_builddir.

(Note that in other subdirectories, the autoconf variable
target_builddir is AC_SUBST-ed as a side-effect of using a macro from
winsup/acinclude.m4, which is perhaps less than ideal)
---
 winsup/testsuite/Makefile.in  | 1 +
 winsup/testsuite/configure.ac | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
index aaa5851b2..2a44fec07 100644
--- a/winsup/testsuite/Makefile.in
+++ b/winsup/testsuite/Makefile.in
@@ -12,6 +12,7 @@ SHELL:=@SHELL@
 srcdir:=@srcdir@
 objdir:=.
 libltp_srcdir=$(srcdir)/libltp
+target_builddir:=@target_builddir@
 
 target_alias:=@target_alias@
 build_alias:=@build_alias@
diff --git a/winsup/testsuite/configure.ac b/winsup/testsuite/configure.ac
index 46f9fb092..effea48c9 100755
--- a/winsup/testsuite/configure.ac
+++ b/winsup/testsuite/configure.ac
@@ -12,8 +12,12 @@ AC_PREREQ(2.59)
 AC_INIT([Cygwin Testsuite],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
 AC_CONFIG_SRCDIR(Makefile.in)
 
+. ${srcdir}/../configure.cygwin
+
 AC_PROG_CC
 AC_PROG_CPP
 AC_CHECK_TOOL(AR,ar)
 
+AC_SUBST(target_builddir)
+
 AC_OUTPUT(Makefile)
-- 
2.29.0

