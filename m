Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta4-sa.btinternet.com
 [213.120.69.10])
 by sourceware.org (Postfix) with ESMTPS id 92EFD3857C61
 for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020 13:54:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 92EFD3857C61
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20201116135407.IOTN11685.sa-prd-fep-044.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 16 Nov 2020 13:54:07 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9AA6E1AB283BE
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudefuddgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeuieejgeduvdeutdffieeileefffdufeekhefgjefffeehtdekjeegkeeftdfffeenucfkphepkeeirddufeelrdduheekrddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddugedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E1AB283BE; Mon, 16 Nov 2020 13:54:07 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] Use automake
Date: Mon, 16 Nov 2020 13:53:47 +0000
Message-Id: <20201116135350.27289-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3571.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Mon, 16 Nov 2020 13:54:11 -0000

Remove recursive configure for Cygwin and convert to automake.

I need to do some more checking that the build products are correct before
this is suitable for being applied.

The only thing I know about that is missing is the magic which copies -O,-g
flags from CFLAGS to CXXFLAGS (because I couldn't work out how to add it).

This makes building documentation unconditional, rather than silently
ignoring errors (which reveals that xmlto hasn't been working on 32-bit
Cygwin for some time).

For ease of reviewing, this patch series doesn't contain changes to
generated files which would be made by running ./autogen.sh.

Jon Turney (3):
  Remove recursive configure for cygwin
  Remove surplus autoconf auxiliary files
  Use automake

 winsup/Makefile.am                     |   19 +
 winsup/Makefile.am.common              |   15 +
 winsup/Makefile.common                 |   51 -
 winsup/Makefile.in                     |    6 +-
 winsup/acinclude.m4                    |   14 +-
 winsup/autogen.sh                      |   15 +-
 winsup/config.guess                    | 1537 -------
 winsup/config.sub                      | 1789 --------
 winsup/configure.ac                    |  101 +-
 winsup/configure.cygwin                |   38 -
 winsup/cygserver/Makefile.am           |   58 +
 winsup/cygserver/Makefile.in           |    4 -
 winsup/cygserver/aclocal.m4            |   55 -
 winsup/cygserver/autogen.sh            |    4 -
 winsup/cygserver/configure             | 5219 ----------------------
 winsup/cygserver/configure.ac          |   48 -
 winsup/cygwin/Makefile.am              |  764 ++++
 winsup/cygwin/Makefile.in              |    8 -
 winsup/cygwin/aclocal.m4               |   54 -
 winsup/cygwin/autogen.sh               |    4 -
 winsup/cygwin/config.h.in              |    2 +-
 winsup/cygwin/configure                | 5643 ------------------------
 winsup/cygwin/configure.ac             |   73 -
 winsup/doc/Makefile.am                 |  155 +
 winsup/doc/Makefile.in                 |    3 -
 winsup/doc/configure                   | 4064 -----------------
 winsup/doc/configure.ac                |   24 -
 winsup/install-sh                      |  520 ---
 winsup/testsuite/Makefile.am           |   64 +
 winsup/testsuite/Makefile.in           |    7 +-
 winsup/testsuite/autogen.sh            |    4 -
 winsup/testsuite/config/default.exp    |    4 +-
 winsup/testsuite/configure             | 4199 ------------------
 winsup/testsuite/configure.ac          |   28 -
 winsup/testsuite/cygrun/Makefile.am    |   21 +
 winsup/testsuite/winsup.api/winsup.exp |    6 +-
 winsup/utils/Makefile.am               |   79 +
 winsup/utils/Makefile.in               |    9 +-
 winsup/utils/aclocal.m4                |   54 -
 winsup/utils/autogen.sh                |    4 -
 winsup/utils/configure                 | 4409 ------------------
 winsup/utils/configure.ac              |   36 -
 winsup/utils/mingw/Makefile.am         |   50 +
 43 files changed, 1334 insertions(+), 27927 deletions(-)
 create mode 100644 winsup/Makefile.am
 create mode 100644 winsup/Makefile.am.common
 delete mode 100644 winsup/Makefile.common
 delete mode 100755 winsup/config.guess
 delete mode 100755 winsup/config.sub
 delete mode 100755 winsup/configure.cygwin
 create mode 100644 winsup/cygserver/Makefile.am
 delete mode 100644 winsup/cygserver/aclocal.m4
 delete mode 100755 winsup/cygserver/autogen.sh
 delete mode 100755 winsup/cygserver/configure
 delete mode 100644 winsup/cygserver/configure.ac
 create mode 100644 winsup/cygwin/Makefile.am
 delete mode 100644 winsup/cygwin/aclocal.m4
 delete mode 100755 winsup/cygwin/autogen.sh
 delete mode 100755 winsup/cygwin/configure
 delete mode 100644 winsup/cygwin/configure.ac
 create mode 100644 winsup/doc/Makefile.am
 delete mode 100755 winsup/doc/configure
 delete mode 100644 winsup/doc/configure.ac
 delete mode 100755 winsup/install-sh
 create mode 100644 winsup/testsuite/Makefile.am
 delete mode 100755 winsup/testsuite/autogen.sh
 delete mode 100755 winsup/testsuite/configure
 delete mode 100755 winsup/testsuite/configure.ac
 create mode 100644 winsup/testsuite/cygrun/Makefile.am
 create mode 100644 winsup/utils/Makefile.am
 delete mode 100644 winsup/utils/aclocal.m4
 delete mode 100755 winsup/utils/autogen.sh
 delete mode 100755 winsup/utils/configure
 delete mode 100644 winsup/utils/configure.ac
 create mode 100644 winsup/utils/mingw/Makefile.am

-- 
2.29.2

