Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta28-re.btinternet.com
 [213.120.69.121])
 by sourceware.org (Postfix) with ESMTPS id 150E3388EC3F
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 19:30:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 150E3388EC3F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20201012193043.CBIL4080.re-prd-fep-045.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 12 Oct 2020 20:30:43 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.141.130.13]
X-OWM-Source-IP: 86.141.130.13 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedttdffveetjeevheeggeektdffjeekkeefgfeiueeiheduveejgeetudeuheffhfenucffohhmrghinhepohgrshhishdqohhpvghnrdhorhhgpdiffedrohhrghenucfkphepkeeirddugedurddufedtrddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedurddufedtrddufedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.130.13) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC15889615; Mon, 12 Oct 2020 20:30:43 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 8/8] Remove unused doc/ug-info.xml
Date: Mon, 12 Oct 2020 20:29:43 +0100
Message-Id: <20201012192943.15732-9-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 12 Oct 2020 19:30:45 -0000

Remove doc/ug-info.xml, not used in any document.
---
 winsup/doc/ug-info.xml | 36 ------------------------------------
 1 file changed, 36 deletions(-)
 delete mode 100644 winsup/doc/ug-info.xml

diff --git a/winsup/doc/ug-info.xml b/winsup/doc/ug-info.xml
deleted file mode 100644
index c5b4a67c8..000000000
--- a/winsup/doc/ug-info.xml
+++ /dev/null
@@ -1,36 +0,0 @@
-<?xml version="1.0" encoding='UTF-8'?>
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
-		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
-
-<bookinfo xmlns:xi="http://www.w3.org/2001/XInclude">
-	<date>2001-22-03</date>
-	<title>Cygwin User's Guide</title>
-	<authorgroup>
-		<author>
-			<firstname>Joshua Daniel</firstname>
-			<surname>Franklin</surname>
-		</author>
-		<author>
-			<firstname>Corinna</firstname>
-			<surname>Vinschen</surname>
-		</author>
-		<author>
-			<firstname>Christopher</firstname>
-			<surname>Faylor</surname>
-		</author>
-		<author>
-			<firstname>DJ</firstname>
-			<surname>Delorie</surname>
-		</author>
-		<author>
-			<firstname>Pierre</firstname>
-			<surname>Humblet</surname>
-		</author>
-		<author>
-			<firstname>Geoffrey</firstname>
-			<surname>Noer</surname>
-		</author>
-	</authorgroup>
-
-	<xi:include href="legal.xml"/>
-</bookinfo>
-- 
2.28.0

