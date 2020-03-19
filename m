Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta21-sa.btinternet.com
 [213.120.69.27])
 by sourceware.org (Postfix) with ESMTPS id 19C88385E830
 for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2020 13:58:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 19C88385E830
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-045.btinternet.com with ESMTP id
 <20200319135851.RJIU5147.sa-prd-fep-045.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 19 Mar 2020 13:58:51 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.134]
X-OWM-Source-IP: 31.51.206.134 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrudefledgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdgthihgfihinhdqughotgdrshhhnecukfhppeefuddrhedurddvtdeirddufeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddufeegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.134) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5E3A27DB06A763E0; Thu, 19 Mar 2020 13:58:51 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Use a separate Start Menu folder for WoW64 installs
Date: Thu, 19 Mar 2020 13:58:37 +0000
Message-Id: <20200319135837.2104-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-23.7 required=5.0 tests=FORGED_SPF_HELO, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_PASS,
 SPF_NONE autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 19 Mar 2020 13:58:53 -0000

This aligns the shortcuts to documentation with the setup changes in
https://sourceware.org/pipermail/cygwin-apps/2020-March/039873.html
---
 winsup/doc/etc.postinstall.cygwin-doc.sh | 3 ++-
 winsup/doc/etc.preremove.cygwin-doc.sh   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
index de7d9e0c3..65ce2ad77 100755
--- a/winsup/doc/etc.postinstall.cygwin-doc.sh
+++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
@@ -37,7 +37,8 @@ do
 done
 
 # Cygwin Start Menu directory
-smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin"
+case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
+smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
 
 # check Cygwin Start Menu directory exists
 [ -d "$smpc_dir/" ] || exit 0
diff --git a/winsup/doc/etc.preremove.cygwin-doc.sh b/winsup/doc/etc.preremove.cygwin-doc.sh
index 5e47eb579..f07b70c5d 100755
--- a/winsup/doc/etc.preremove.cygwin-doc.sh
+++ b/winsup/doc/etc.preremove.cygwin-doc.sh
@@ -26,7 +26,8 @@ do
 done
 
 # Cygwin Start Menu directory
-smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin"
+case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
+smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
 
 # check Cygwin Start Menu directory still exists
 [ -d "$smpc_dir/" ] || exit 0
-- 
2.21.0

