Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta28-sa.btinternet.com
 [213.120.69.34])
 by sourceware.org (Postfix) with ESMTPS id 1EFCE384B0C1
 for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2020 21:26:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1EFCE384B0C1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20200701212609.NBEI3440.sa-prd-fep-044.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 1 Jul 2020 22:26:09 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgdduieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedtledtkeegffevffelgfeufeetffefgeevgfeugfefudelvddtkeetveegkeeiveenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeefuddrhedurddvtdeirdefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdehuddrvddtiedrfedupdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.31) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E04BC5079; Wed, 1 Jul 2020 22:26:09 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/8] Cygwin: Update ELF target used by dumper on x86_64
Date: Wed,  1 Jul 2020 22:25:23 +0100
Message-Id: <20200701212529.13998-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 01 Jul 2020 21:26:11 -0000

Like [1], but actually making the effort to be 'usable' and 'tested'.

[1] https://cygwin.com/pipermail/cygwin/2019-October/242815.html
---
 winsup/utils/dumper.cc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 226c2283d..e16d80a36 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -645,7 +645,13 @@ dumper::init_core_dump ()
 {
   bfd_init ();
 
-  core_bfd = bfd_openw (file_name, "elf32-i386");
+#ifdef __x86_64__
+  const char *target = "elf64-x86-64";
+#else
+  const char *target = "elf32-i386";
+#endif
+
+  core_bfd = bfd_openw (file_name, target);
   if (core_bfd == NULL)
     {
       bfd_perror ("opening bfd");
@@ -658,7 +664,7 @@ dumper::init_core_dump ()
       goto failed;
     }
 
-  if (!bfd_set_arch_mach (core_bfd, bfd_arch_i386, 0))
+  if (!bfd_set_arch_mach (core_bfd, bfd_arch_i386, 0 /* = default */))
     {
       bfd_perror ("setting bfd architecture");
       goto failed;
-- 
2.27.0

