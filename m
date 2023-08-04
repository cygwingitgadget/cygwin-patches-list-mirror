Return-Path: <SRS0=REvR=DV=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta17-sa.btinternet.com [213.120.69.23])
	by sourceware.org (Postfix) with ESMTPS id F247F3858C62
	for <cygwin-patches@cygwin.com>; Fri,  4 Aug 2023 12:47:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F247F3858C62
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20230804124740.LNDR9056.sa-prd-fep-047.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 4 Aug 2023 13:47:40 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64C837300077D1AD
X-Originating-IP: [86.139.167.52]
X-OWM-Source-IP: 86.139.167.52 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehuedutdehhfeutefgieefgfelieettdeigfdtfffhvdevgeegteejfeeftdehgfenucfkphepkeeirddufeelrdduieejrdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdehvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqhedvrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfk
	rfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.52) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64C837300077D1AD; Fri, 4 Aug 2023 13:47:39 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/4] Testsuite update
Date: Fri,  4 Aug 2023 13:47:19 +0100
Message-Id: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This gets us down to no permanent failures in the testsuite in CI.

When run locally, msgtest, semtest and shmtest fail because they need a running cygserver using the test DLL,
and I haven't got a good idea about how to automate that.  devdsp fails due to a hang in child while exiting.

Jon Turney (4):
  Cygwin: testsuite: Add '-notimeout' option to cygrun
  Cygwin: testsuite: Update README
  Cygwin: testsuite: Fix cygload test
  Cygwin: CI: XFAIL umask03

 winsup/testsuite/Makefile.am |  6 ++-
 winsup/testsuite/README      | 82 +++++++++++++++++++++++++-----------
 winsup/testsuite/cygrun.c    | 26 ++++++++++--
 winsup/testsuite/cygrun.sh   |  2 +-
 4 files changed, 86 insertions(+), 30 deletions(-)

-- 
2.39.0

