Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-044.btinternet.com (mailomta2-sa.btinternet.com [213.120.69.8])
	by sourceware.org (Postfix) with ESMTPS id D560D3858C74
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:39:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D560D3858C74
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20230713113924.SEBJ11931.sa-prd-fep-044.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:39:24 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64067D310ED31CD1
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehuedutdehhfeutefgieefgfelieettdeigfdtfffhvdevgeegteejfeeftdehgfenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhg
	vghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED31CD1; Thu, 13 Jul 2023 12:39:24 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 00/11] More testsuite fixes
Date: Thu, 13 Jul 2023 12:38:53 +0100
Message-Id: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This gets us from :

FAIL: cygload
FAIL: devdsp.c
FAIL: ltp/access05.c
FAIL: ltp/fcntl07.c
FAIL: ltp/symlink01.c
FAIL: ltp/symlink03.c
FAIL: ltp/umask03.c
FAIL: pthread/cancel11.c
FAIL: pthread/cancel3.c
FAIL: pthread/cancel5.c
FAIL: pthread/inherit1.c
FAIL: pthread/priority1.c
FAIL: pthread/priority2.c
FAIL: systemcall.c

to:

FAIL: cygload
FAIL: devdsp.c
FAIL: ltp/umask03.c
FAIL: pthread/cancel11.c
FAIL: pthread/priority1.c

Notes on the remaining failures:

cygload: I have no idea of the voodoo needed to make this work

devdsp: forkplaytest() is broken in some complex way I don't understand, causing a hang. It looks like the child 
process doesn't exit, which must be a bug in Cygwin?

devdsp: it's totally unclear to me if opening /dev/dsp twice is meant to be allowed or not

umask03: was utterly broken, now fails, but accurately reports the failure. I don't quite understand the 
permissions issue which is causing it to fail.

cancel11: some funkiness I can't work out, causing the save/restoring signal handlers around system() to not 
work correctly

priority1: this looks like a bug with pthread_create() and a non-null pthread_attr_t *, for which I'll send a 
patch shortly.

Jon Turney (11):
  Cygwin: testsuite: Setup test prereqs in 'installation' the tests run
    in
  Cygwin: testsuite: Add a simple timeout mechanism
  Cygwin: testsuite: Remove const from writable string in fcntl07b
  Cygwin: testsuite: Skip devdsp test when no audio devices present
  Cygwin: testsuite: Just log result of second open of /dev/dsp
  Cygwin: testsuite: Also check direct call in systemcall
  Cygwin: testsuite: Fix for limited thread priority values
  Cygwin: testsuite: Busy-wait in cancel3 and cancel5
  Cygwin: testsuite: Fix a buffer overflow in symlink01
  Cygwin: testsuite: Minor fixes to umask03
  Cygwin: testsuite: Drop Adminstrator privileges while running tests

 .github/workflows/cygwin.yml                  |  4 ++-
 winsup/cygwin/Makefile.am                     |  4 +--
 winsup/doc/faq-programming.xml                |  4 ++-
 winsup/testsuite/Makefile.am                  | 28 ++++++++++++++-
 winsup/testsuite/cygrun.c                     | 17 +++++++--
 winsup/testsuite/winsup.api/devdsp.c          | 35 +++++++++++--------
 winsup/testsuite/winsup.api/ltp/fcntl07B.c    |  2 +-
 winsup/testsuite/winsup.api/ltp/symlink01.c   |  2 +-
 winsup/testsuite/winsup.api/ltp/umask03.c     | 21 ++++++-----
 winsup/testsuite/winsup.api/pthread/cancel3.c | 24 +++++++++----
 winsup/testsuite/winsup.api/pthread/cancel5.c | 24 +++++++++----
 .../testsuite/winsup.api/pthread/inherit1.c   | 21 ++++++++++-
 .../testsuite/winsup.api/pthread/priority1.c  | 24 +++++++++++--
 .../testsuite/winsup.api/pthread/priority2.c  | 22 ++++++++++--
 winsup/testsuite/winsup.api/systemcall.c      | 10 +++++-
 winsup/testsuite/winsup.api/winsup.exp        |  2 +-
 16 files changed, 194 insertions(+), 50 deletions(-)

-- 
2.39.0

