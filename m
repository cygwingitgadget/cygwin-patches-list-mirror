Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta12-re.btinternet.com
 [213.120.69.105])
 by sourceware.org (Postfix) with ESMTPS id 0A2403870858
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 19:30:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0A2403870858
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20201012193033.HIQF4131.re-prd-fep-049.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 12 Oct 2020 20:30:33 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.141.130.13]
X-OWM-Source-IP: 86.141.130.13 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddugedurddufedtrddufeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedurddufedtrddufedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.130.13) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC158894DE; Mon, 12 Oct 2020 20:30:33 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 6/8] Remove autoconf variable INSTALL_LICENSE
Date: Mon, 12 Oct 2020 20:29:41 +0100
Message-Id: <20201012192943.15732-7-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Mon, 12 Oct 2020 19:30:35 -0000

Remove autoconf variable INSTALL_LICENSE, which has a constant value
which is only used once.
---
 winsup/Makefile.in  | 4 +---
 winsup/configure.ac | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/winsup/Makefile.in b/winsup/Makefile.in
index 148d98531..dc1c04444 100644
--- a/winsup/Makefile.in
+++ b/winsup/Makefile.in
@@ -44,8 +44,6 @@ SUBDIRS=@subdirs@
 INSTALL_SUBDIRS=${patsubst %,install_%,$(SUBDIRS)}
 CLEAN_SUBDIRS=${patsubst %,clean_%,$(SUBDIRS)}
 
-INSTALL_LICENSE:=@INSTALL_LICENSE@
-
 .PHONY: all install clean distclean all-info info install-info install-license check \
 	$(SUBDIRS) $(INSTALL_SUBDIRS) $(CLEAN_SUBDIRS)
 
@@ -67,7 +65,7 @@ install-license: CYGWIN_LICENSE COPYING
 	  ${INSTALL} $$i $(DESTDIR)$(prefix)/share/doc/Cygwin ; \
 	done
 
-install: Makefile $(INSTALL_LICENSE) $(INSTALL_SUBDIRS)
+install: Makefile install-license $(INSTALL_SUBDIRS)
 
 clean distclean: $(CLEAN_SUBDIRS)
 
diff --git a/winsup/configure.ac b/winsup/configure.ac
index e917ee1c5..13f8883eb 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -39,9 +39,5 @@ if test "x$with_cross_bootstrap" != "xyes"; then
     AC_CONFIG_SUBDIRS([utils])
 fi
 
-INSTALL_LICENSE="install-license"
-
-AC_SUBST(INSTALL_LICENSE)
-
 AC_CONFIG_FILES([Makefile])
 AC_OUTPUT
-- 
2.28.0

