Return-Path: <SRS0=Pl6r=5H=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-048.btinternet.com (mailomta6-re.btinternet.com [213.120.69.99])
	by sourceware.org (Postfix) with ESMTPS id A62783858CDA
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 16:37:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A62783858CDA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20230110163730.YOT25570.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 10 Jan 2023 16:37:30 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 61A69BAC3ED8A2A5
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehuedutdehhfeutefgieefgfelieettdeigfdtfffhvdevgeegteejfeeftdehgfenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC3ED8A2A5; Tue, 10 Jan 2023 16:37:30 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/8] Further testsuite fixes
Date: Tue, 10 Jan 2023 16:37:01 +0000
Message-Id: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3569.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This gets us from:

> FAIL: cygload (execute)
> FAIL: devdsp.c (execute)
> FAIL: ltp/access05.c (execute)
> FAIL: ltp/fcntl07.c (execute)
> FAIL: ltp/fcntl07B.c (execute)
> FAIL: ltp/fork09.c (execute)
> FAIL: ltp/link04.c (execute)
> FAIL: ltp/symlink03.c (execute)
> FAIL: msgtest.c (execute)
> FAIL: pthread/cancel11.c (execute)
> FAIL: pthread/cancel3.c (execute)
> FAIL: pthread/cancel5.c (execute)
> FAIL: pthread/inherit1.c (execute)
> FAIL: pthread/mutex5.c (execute)
> FAIL: pthread/mutex7.c (execute)
> FAIL: pthread/mutex7d.c (execute)
> FAIL: pthread/mutex7n.c (execute)
> FAIL: pthread/priority1.c (execute)
> FAIL: pthread/priority2.c (execute)
> FAIL: pthread/rwlock6.c (execute)
> FAIL: semtest.c (execute)
> FAIL: shmtest.c (execute)
> FAIL: systemcall.c (execute)
> 
> 		=== winsup Summary ===
> 
> # of expected passes		255
> # of unexpected failures	23
> # of expected failures		6

to:

> FAIL: cygload
> FAIL: devdsp.c
> FAIL: ltp/access05.c
> FAIL: ltp/fcntl07.c
> FAIL: ltp/fork09.c
> FAIL: ltp/symlink01.c
> FAIL: ltp/symlink03.c
> FAIL: ltp/umask03.c
> FAIL: pthread/cancel11.c
> FAIL: pthread/cancel3.c
> FAIL: pthread/cancel5.c
> FAIL: pthread/inherit1.c
> FAIL: pthread/priority1.c
> FAIL: pthread/priority2.c
> FAIL: systemcall.c
> 
> 		=== winsup Summary ===
> 
> # of expected passes		263
> # of unexpected failures	15
> # of expected failures		5

which is almost manageable!

Jon Turney (8):
  Cygwin: testsuite: automake doesn't define objdir
  Cygwin: testsuite: Build testcases using automake
  Cygwin: testsuite: Fix compilation warnings
  Cygwin: testsuite: 64-bit fixes in pthread testcases
  Cygwin: testsuite: Update mutex tests for changed default mutex type
  Cygwin: testsuite: Update pthread tests for default SCHED_FIFO
  Cygwin: testsuite: Drop appending 'ntsec' to CYGWIN in cygrun wrapper
  Cygwin: CI: Run cygserver for tests

 .github/workflows/cygwin.yml                  |  16 +-
 winsup/configure.ac                           |   2 +-
 winsup/testsuite/Makefile.am                  | 309 +++++++++++++++++-
 winsup/testsuite/README                       |   2 +-
 winsup/testsuite/cygrun.c                     |  16 -
 winsup/testsuite/libltp/include/usctest.h     |   2 +-
 .../testsuite/{cygrun => mingw}/Makefile.am   |  11 +-
 winsup/testsuite/winsup.api/cygload.exp       |  32 +-
 winsup/testsuite/winsup.api/ltp/execv01.c     |   2 +-
 winsup/testsuite/winsup.api/ltp/execve01.c    |   2 +-
 winsup/testsuite/winsup.api/ltp/execvp01.c    |   2 +-
 winsup/testsuite/winsup.api/ltp/mmap02.c      |  10 +-
 winsup/testsuite/winsup.api/ltp/mmap03.c      |  10 +-
 winsup/testsuite/winsup.api/ltp/mmap04.c      |  10 +-
 winsup/testsuite/winsup.api/ltp/mmap05.c      |  10 +-
 winsup/testsuite/winsup.api/ltp/mmap06.c      |   8 +-
 winsup/testsuite/winsup.api/ltp/mmap07.c      |   8 +-
 winsup/testsuite/winsup.api/ltp/mmap08.c      |   8 +-
 winsup/testsuite/winsup.api/mmaptest03.c      |   2 +-
 winsup/testsuite/winsup.api/pthread/cancel2.c |  10 +-
 winsup/testsuite/winsup.api/pthread/cancel3.c |  10 +-
 winsup/testsuite/winsup.api/pthread/cancel4.c |  10 +-
 winsup/testsuite/winsup.api/pthread/cancel5.c |  12 +-
 .../testsuite/winsup.api/pthread/cleanup2.c   |  10 +-
 .../testsuite/winsup.api/pthread/cleanup3.c   |   8 +-
 .../testsuite/winsup.api/pthread/condvar2_1.c |  12 +-
 .../testsuite/winsup.api/pthread/condvar3_1.c |  12 +-
 .../testsuite/winsup.api/pthread/condvar3_2.c |  14 +-
 winsup/testsuite/winsup.api/pthread/exit3.c   |   2 +-
 .../testsuite/winsup.api/pthread/inherit1.c   |  12 +-
 winsup/testsuite/winsup.api/pthread/join1.c   |  10 +-
 winsup/testsuite/winsup.api/pthread/join2.c   |   8 +-
 winsup/testsuite/winsup.api/pthread/mutex4.c  |   2 +-
 winsup/testsuite/winsup.api/pthread/mutex5.c  |   2 +-
 winsup/testsuite/winsup.api/pthread/mutex7.c  |   3 +-
 winsup/testsuite/winsup.api/pthread/mutex7d.c |   3 +-
 winsup/testsuite/winsup.api/pthread/mutex7n.c |   1 -
 .../testsuite/winsup.api/pthread/priority1.c  |  10 +-
 .../testsuite/winsup.api/pthread/priority2.c  |  12 +-
 winsup/testsuite/winsup.api/pthread/rwlock6.c |  22 +-
 .../winsup.api/samples/sample-miscompile.c    |   1 -
 winsup/testsuite/winsup.api/systemcall.c      |   2 +-
 winsup/testsuite/winsup.api/user_malloc.c     |   4 +-
 winsup/testsuite/winsup.api/winsup.exp        |  37 +--
 44 files changed, 470 insertions(+), 221 deletions(-)
 rename winsup/testsuite/{cygrun => mingw}/Makefile.am (58%)
 delete mode 100644 winsup/testsuite/winsup.api/samples/sample-miscompile.c

-- 
2.39.0

