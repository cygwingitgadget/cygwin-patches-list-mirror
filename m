Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta22-re.btinternet.com
 [213.120.69.115])
 by sourceware.org (Postfix) with ESMTPS id 5240E385702C
 for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2020 19:47:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5240E385702C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20201021194719.BKOW18340.re-prd-fep-041.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
 Wed, 21 Oct 2020 20:47:19 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C2FD16E8D90D
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgddugedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeuieejgeduvdeutdffieeileefffdufeekhefgjefffeehtdekjeegkeeftdfffeenucfkphepkeeirddufeelrdduheekrddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddvjedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.27) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C2FD16E8D90D; Wed, 21 Oct 2020 20:47:19 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] Remove recursive configure for Cygwin
Date: Wed, 21 Oct 2020 20:47:02 +0100
Message-Id: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3571.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_ASCII_DIVIDERS, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 21 Oct 2020 19:47:24 -0000

A couple more Makefile/configure cleanups, and remove recursive configure
for Cygwin.

For ease of reviewing, this patch series doesn't contain changes to
generated files which would be made by an autoreconf.

Jon Turney (3):
  Remove intro2man.stamp on clean
  Drop AC_SUBST(build_exeext)
  Remove recursive configure for cygwin

 winsup/Makefile.in            |    4 +-
 winsup/acinclude.m4           |   14 +-
 winsup/autogen.sh             |    5 -
 winsup/configure.ac           |   91 +-
 winsup/configure.cygwin       |   38 -
 winsup/cygserver/Makefile.in  |    4 -
 winsup/cygserver/aclocal.m4   |   55 -
 winsup/cygserver/autogen.sh   |    4 -
 winsup/cygserver/configure    | 5231 ------------------------------
 winsup/cygserver/configure.ac |   59 -
 winsup/cygwin/Makefile.in     |    8 -
 winsup/cygwin/aclocal.m4      |   54 -
 winsup/cygwin/autogen.sh      |    4 -
 winsup/cygwin/configure       | 5659 ---------------------------------
 winsup/cygwin/configure.ac    |   87 -
 winsup/doc/Makefile.in        |    8 +-
 winsup/doc/configure          | 4064 -----------------------
 winsup/doc/configure.ac       |   26 -
 winsup/testsuite/aclocal.m4   |  831 -----
 winsup/testsuite/configure    | 3950 -----------------------
 winsup/testsuite/configure.ac |   19 -
 winsup/utils/Makefile.in      |    9 +-
 winsup/utils/aclocal.m4       |   54 -
 winsup/utils/autogen.sh       |    4 -
 winsup/utils/configure        | 4409 -------------------------
 winsup/utils/configure.ac     |   36 -
 26 files changed, 92 insertions(+), 24635 deletions(-)
 delete mode 100755 winsup/configure.cygwin
 delete mode 100644 winsup/cygserver/aclocal.m4
 delete mode 100755 winsup/cygserver/autogen.sh
 delete mode 100755 winsup/cygserver/configure
 delete mode 100644 winsup/cygserver/configure.ac
 delete mode 100644 winsup/cygwin/aclocal.m4
 delete mode 100755 winsup/cygwin/autogen.sh
 delete mode 100755 winsup/cygwin/configure
 delete mode 100644 winsup/cygwin/configure.ac
 delete mode 100755 winsup/doc/configure
 delete mode 100644 winsup/doc/configure.ac
 delete mode 100644 winsup/testsuite/aclocal.m4
 delete mode 100755 winsup/testsuite/configure
 delete mode 100755 winsup/testsuite/configure.ac
 delete mode 100644 winsup/utils/aclocal.m4
 delete mode 100755 winsup/utils/autogen.sh
 delete mode 100755 winsup/utils/configure
 delete mode 100644 winsup/utils/configure.ac

-- 
2.28.0

