Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta5-sa.btinternet.com
 [213.120.69.11])
 by sourceware.org (Postfix) with ESMTPS id 4B5A43858C2B
 for <cygwin-patches@cygwin.com>; Thu,  5 Nov 2020 19:48:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4B5A43858C2B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20201105194804.XATB28150.sa-prd-fep-046.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 5 Nov 2020 19:48:04 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9B66119336C7D
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B66119336C7D; Thu, 5 Nov 2020 19:48:04 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 00/11] testsuite refurbishment
Date: Thu,  5 Nov 2020 19:47:37 +0000
Message-Id: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3571.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 05 Nov 2020 19:48:10 -0000

Fix testsuite Makefile/configure, so I have some idea what it's supposed to
be doing, prior to cleanup and Automake-ification.

> $ make check
[...]
> # of expected passes            253
> # of unexpected failures        23
> # of unexpected successes       1
> # of expected failures          7
 
Future work:
- Investigate and fix failing tests
- Tests are re-compiled every time they are run
- No parallelization of tests

For ease of reviewing, this patch series doesn't contain changes to
generated files which would be made by an autoreconf.

Jon Turney (11):
  Add testsuite directory to autogen.sh
  Always configure in testsuite subdirectory
  Add rule to testsuite Makefile to regenerate it when needed
  Avoid 'Makefile.in seems to ignore the --datarootdir setting' warning
  Move adding libltp to VPATH after Makefile.common
  Define target_builddir autoconf and Makefile variables
  Detect and use MinGW compilers for testsuite wrappers
  Use absolute path to libltp includes
  Check exit code of a test, rather than stdout
  Set PATH for tests to pick up cygwin0.dll
  Ensure temporary directory used by tests exists

 winsup/Makefile.in                      |  16 +-
 winsup/autogen.sh                       |   2 +-
 winsup/configure.ac                     |   2 +-
 winsup/testsuite/Makefile.in            |  31 +-
 winsup/testsuite/aclocal.m4             | 831 ------------------------
 winsup/testsuite/autogen.sh             |   4 +
 winsup/testsuite/configure.ac           |   9 +
 winsup/testsuite/cygrun.c               |   5 +-
 winsup/testsuite/winsup.api/cygload.exp |   2 +-
 winsup/testsuite/winsup.api/winsup.exp  |  24 +-
 10 files changed, 60 insertions(+), 866 deletions(-)
 delete mode 100644 winsup/testsuite/aclocal.m4
 create mode 100755 winsup/testsuite/autogen.sh

-- 
2.29.0

