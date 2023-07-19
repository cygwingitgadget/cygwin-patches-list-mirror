Return-Path: <SRS0=fe21=DF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-043.btinternet.com (mailomta10-sa.btinternet.com [213.120.69.16])
	by sourceware.org (Postfix) with ESMTPS id C51A33858C33
	for <cygwin-patches@cygwin.com>; Wed, 19 Jul 2023 12:41:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C51A33858C33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20230719124156.TQGV1396.sa-prd-fep-043.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 19 Jul 2023 13:41:56 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64AECEEE00C7CD75
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehuedutdehhfeutefgieefgfelieettdeigfdtfffhvdevgeegteejfeeftdehgfenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhg
	vghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64AECEEE00C7CD75; Wed, 19 Jul 2023 13:41:56 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/2] Testsuite adjustment and relevant fix
Date: Wed, 19 Jul 2023 13:41:40 +0100
Message-Id: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

[1/2] has the side effect of flipping test stat06 from working to failing.
[2/2] fixes that

When run with TDIRECTORY set, libltp just uses that directory and assumes
something else will clean it up.

When TDIRECTORY is not set, libltp creates a subdirectory under /tmp, and when
the test is completed, removes the expected files and verifies that the
directory is empty.

stat06 fails that check, because it creates the a file named "file" there, and
tries stat("file", -1), testing that it returns the expected value EFAULT.

"file" is removed, but lingers in the STATUS_DELETE_PENDING state until the
Windows handle which stat_worker() leaks when an exception occurs is closed
(when the processes exits).

Future work: It looks like similar problems might generically occur in similar
code througout syscalls.cc.

Jon Turney (2):
  Cygwin: testsuite: Drop setting TDIRECTORY
  Cygwin: Fix Windows file handle leak in stat("file", -1)

 winsup/cygwin/syscalls.cc              | 6 +++---
 winsup/testsuite/Makefile.am           | 8 --------
 winsup/testsuite/cygrun.c              | 5 +----
 winsup/testsuite/winsup.api/winsup.exp | 4 +---
 4 files changed, 5 insertions(+), 18 deletions(-)

-- 
2.39.0

