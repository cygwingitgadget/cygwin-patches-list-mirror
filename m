Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta26-re.btinternet.com
 [213.120.69.119])
 by sourceware.org (Postfix) with ESMTPS id DA2053833036
 for <cygwin-patches@cygwin.com>; Sun,  2 May 2021 15:26:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DA2053833036
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20210502152654.FSUZ29050.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sun, 2 May 2021 16:26:54 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C0CC313CE4D8
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdefuddgudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC313CE4D8; Sun, 2 May 2021 16:26:54 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/2] Improve automake object file location for utils/mingw/
Date: Sun,  2 May 2021 16:25:34 +0100
Message-Id: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3570.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sun, 02 May 2021 15:26:57 -0000

This is the simple part, leaving potentially pulling apart path.cc for later...

Jon Turney (2):
  Unpick cygpath TESTSUITE
  Move source files used in utils/mingw/ into that subdirectory

 winsup/utils/mingw/Makefile.am                | 23 +++++++------
 winsup/utils/{ => mingw}/bloda.cc             |  0
 winsup/utils/{ => mingw}/cygcheck.cc          |  0
 .../{ => mingw}/cygwin-console-helper.cc      |  0
 winsup/utils/{ => mingw}/dump_setup.cc        |  0
 winsup/utils/{ => mingw}/ldh.cc               |  0
 winsup/utils/mingw/path.cc                    |  1 +
 winsup/utils/{ => mingw}/strace.cc            | 10 +++---
 winsup/utils/{ => mingw}/testsuite.cc         | 31 +++++++++--------
 winsup/utils/{ => mingw}/testsuite.h          | 34 ++++++-------------
 winsup/utils/path.cc                          | 31 +++++++----------
 winsup/utils/path.h                           | 10 ++++--
 12 files changed, 67 insertions(+), 73 deletions(-)
 rename winsup/utils/{ => mingw}/bloda.cc (100%)
 rename winsup/utils/{ => mingw}/cygcheck.cc (100%)
 rename winsup/utils/{ => mingw}/cygwin-console-helper.cc (100%)
 rename winsup/utils/{ => mingw}/dump_setup.cc (100%)
 rename winsup/utils/{ => mingw}/ldh.cc (100%)
 create mode 100644 winsup/utils/mingw/path.cc
 rename winsup/utils/{ => mingw}/strace.cc (99%)
 rename winsup/utils/{ => mingw}/testsuite.cc (85%)
 rename winsup/utils/{ => mingw}/testsuite.h (94%)

-- 
2.31.1

