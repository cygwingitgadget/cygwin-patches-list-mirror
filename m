Return-Path: <SRS0=Rby/=4M=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-043.btinternet.com (mailomta29-sa.btinternet.com [213.120.69.35])
	by sourceware.org (Postfix) with ESMTPS id CF81A383557B
	for <cygwin-patches@cygwin.com>; Wed, 14 Dec 2022 17:31:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CF81A383557B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20221214173102.IYHD10574.sa-prd-fep-043.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 14 Dec 2022 17:31:02 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139417C47E109BB
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 6139417C47E109BB; Wed, 14 Dec 2022 17:31:02 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/2] Improvements in configure options for reducing dependencies
Date: Wed, 14 Dec 2022 17:30:37 +0000
Message-Id: <20221214173040.8431-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3568.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,KAM_LINKBAIT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney (2):
  Cygwin: FAQ: Mention configure options to build with reduced
    dependencies
  Cygwin: configure: Add option to disable building 'dumper'

 winsup/configure.ac            |  8 +++++---
 winsup/doc/faq-programming.xml | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.39.0

