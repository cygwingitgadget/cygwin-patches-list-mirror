Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta14-sa.btinternet.com
 [213.120.69.20])
 by sourceware.org (Postfix) with ESMTPS id 8961E382D83C
 for <cygwin-patches@cygwin.com>; Fri, 20 Nov 2020 14:09:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8961E382D83C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20201120140914.TBSE15135.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Fri, 20 Nov 2020 14:09:14 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9AFBE1B580EC7
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeuieejgeduvdeutdffieeileefffdufeekhefgjefffeehtdekjeegkeeftdfffeenucfkphepkeeirddufeelrdduheekrddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddugedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE1B580EC7; Fri, 20 Nov 2020 14:09:14 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] Further build cleanups
Date: Fri, 20 Nov 2020 14:08:58 +0000
Message-Id: <20201120140901.44474-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3570.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_LINKBAIT, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Fri, 20 Nov 2020 14:09:17 -0000

Jon Turney (3):
  Drop libgmon.a build dependency on gcrt0.o
  Use standard CXXFLAGS when compiling localtime_wrapper.c
  Have cygmagic not create output if an error occurs

 winsup/cygwin/Makefile.in |  4 ++--
 winsup/cygwin/cygmagic    | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

-- 
2.29.2

