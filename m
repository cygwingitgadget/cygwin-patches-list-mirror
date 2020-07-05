Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-043.btinternet.com (mailomta27-sa.btinternet.com
 [213.120.69.33])
 by sourceware.org (Postfix) with ESMTPS id DDA19385E444
 for <cygwin-patches@cygwin.com>; Sun,  5 Jul 2020 16:46:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DDA19385E444
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-043.btinternet.com with ESMTP id
 <20200705164620.EJUH26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sun, 5 Jul 2020 17:46:20 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddugddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeihefhheduvefhteevkeelgeevjeehieekuddtieehleffjeeuueehhefhleektdenucffohhmrghinheprghnugdruggrthgrnecukfhppeefuddrhedurddvtdeirdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdehuddrvddtiedrfedupdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.31) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED99EC905523EA4; Sun, 5 Jul 2020 17:46:20 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 12/8] Don't dump non-writable image regions
Date: Sun,  5 Jul 2020 17:45:31 +0100
Message-Id: <20200705164531.31995-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200705164531.31995-1-jon.turney@dronecode.org.uk>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <20200705164531.31995-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Sun, 05 Jul 2020 16:46:23 -0000

After this, we will end up dumping memory regions where:

- state is MEM_COMMIT (i.e. is not MEM_RESERVE or MEM_FREE), and
-- type is MEM_PRIVATE and protection allows reads (i.e. not a guardpage), or
-- type is MEM_IMAGE and protection allows writes

Making this decision based on the current protection isn't 100% correct,
because it may have been changed using VirtualProtect().  But we don't
know how to determine if a region is shareable.

(As a practical matter, anything which gets us the stack (MEM_PRIVATE)
and .data/.bss (RW MEM_IMAGE) is going to be enough for 99% of cases)
---
 winsup/utils/dumper.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 2a0c66002..b96ee54cc 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -292,6 +292,12 @@ dumper::collect_memory_sections ()
       int skip_region_p = 0;
       const char *disposition = "dumped";
 
+      if ((mbi.Type & MEM_IMAGE) && !(mbi.Protect & (PAGE_EXECUTE_READWRITE | PAGE_READWRITE)))
+	{
+	  skip_region_p = 1;
+	  disposition = "skipped due to non-writeable MEM_IMAGE";
+	}
+
       if (mbi.Protect & PAGE_NOACCESS)
 	{
 	  skip_region_p = 1;
-- 
2.27.0

