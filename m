Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-048.btinternet.com (mailomta17-sa.btinternet.com
 [213.120.69.23])
 by sourceware.org (Postfix) with ESMTPS id 937B93861817
 for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2020 21:26:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 937B93861817
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-048.btinternet.com with ESMTP id
 <20200701212648.DLKM4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 1 Jul 2020 22:26:48 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgdduieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepfedurdehuddrvddtiedrfedunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirdefuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.31) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E04BC56C5; Wed, 1 Jul 2020 22:26:48 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/8] Cygwin: Make dumper scan more than first 4GB of VM on
 x86_64
Date: Wed,  1 Jul 2020 22:25:25 +0100
Message-Id: <20200701212529.13998-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 01 Jul 2020 21:26:50 -0000

It's unclear that we need an end address here at all, or can just rely
on VirtualQueryEx() failing when we reach the end of memory regions.
---
 winsup/utils/dumper.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index dcf01e800..ccc4bd12f 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -296,7 +296,7 @@ dumper::collect_memory_sections ()
     return 0;
 
   LPBYTE current_page_address;
-  LPBYTE last_base = (LPBYTE) 0xFFFFFFFF;
+  LPBYTE last_base = (LPBYTE) -1;
   SIZE_T last_size = (SIZE_T) 0;
   SIZE_T done;
 
@@ -307,7 +307,7 @@ dumper::collect_memory_sections ()
   if (hProcess == NULL)
     return 0;
 
-  for (current_page_address = 0; current_page_address < (LPBYTE) 0xFFFF0000;)
+  for (current_page_address = 0; current_page_address < (LPBYTE) -1;)
     {
       if (!VirtualQueryEx (hProcess, current_page_address, &mbi, sizeof (mbi)))
 	break;
-- 
2.27.0

