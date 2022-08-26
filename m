Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta17-re.btinternet.com [213.120.69.110])
	by sourceware.org (Postfix) with ESMTPS id 3D1CD3858C74
	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022 12:59:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3D1CD3858C74
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20220826125958.WKJM3291.re-prd-fep-042.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 26 Aug 2022 13:59:58 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 61A69BAC2ADD076A
X-Originating-IP: [86.139.158.127]
X-OWM-Source-IP: 86.139.158.127 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudefledrudehkedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrdduvdejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.127) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC2ADD076A; Fri, 26 Aug 2022 13:59:57 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/6] testsuite: various fixes
Date: Fri, 26 Aug 2022 13:59:36 +0100
Message-Id: <20220826125943.49-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3568.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This are some fixes for the testsuite I wrote back when I was looking at the
automake conversion, which mainly fix x86_64-specific problems in the
testsuite.

Jon Turney (6):
  Cygwin: testsuite: Don't write coredump in a child which is expected
    to segfault
  Cygwin: testsuite: Remove passing tests from XFAIL list
  Cygwin: testsuite: Fix TEST_RETURN for 64-bit
  Cygwin: testsuite: Fix size of write to temporary file to be mmap()ed
  Cygwin: testsuite: In pathconf01 use the temporary directory instead
    of "/tmp"
  Cygwin: testsuite: Add x86_64 code to "dynamically load cygwin" test

 winsup/cygwin/DevDocs/how-cygtls-works.txt   | 25 +++++---------------
 winsup/testsuite/libltp/include/usctest.h    |  6 ++---
 winsup/testsuite/libltp/lib/parse_opts.c     |  2 +-
 winsup/testsuite/winsup.api/cygload.cc       | 22 ++++++++++++++---
 winsup/testsuite/winsup.api/cygload.exp      |  8 ++++++-
 winsup/testsuite/winsup.api/known_bugs.tcl   |  4 ++--
 winsup/testsuite/winsup.api/ltp/mmap02.c     |  2 +-
 winsup/testsuite/winsup.api/ltp/mmap03.c     |  2 +-
 winsup/testsuite/winsup.api/ltp/mmap04.c     |  2 +-
 winsup/testsuite/winsup.api/ltp/mmap05.c     |  3 +--
 winsup/testsuite/winsup.api/ltp/mmap06.c     |  2 +-
 winsup/testsuite/winsup.api/ltp/mmap07.c     |  2 +-
 winsup/testsuite/winsup.api/ltp/pathconf01.c |  8 ++++++-
 winsup/testsuite/winsup.api/resethand.c      |  5 +++-
 14 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.37.2

