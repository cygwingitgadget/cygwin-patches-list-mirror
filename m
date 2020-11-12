Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-048.btinternet.com (mailomta7-sa.btinternet.com
 [213.120.69.13])
 by sourceware.org (Postfix) with ESMTPS id 8470A39FF04A
 for <cygwin-patches@cygwin.com>; Thu, 12 Nov 2020 19:46:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8470A39FF04A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-048.btinternet.com with ESMTP id
 <20201112194642.MDZE7754.sa-prd-fep-048.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 12 Nov 2020 19:46:42 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B6611A29D084
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddvfedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B6611A29D084; Thu, 12 Nov 2020 19:46:42 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/4] Use grep in text mode to look for version strings
Date: Thu, 12 Nov 2020 19:46:25 +0000
Message-Id: <20201112194629.13493-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112194629.13493-1-jon.turney@dronecode.org.uk>
References: <20201112194629.13493-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 12 Nov 2020 19:46:44 -0000

Invoke grep in text mode when looking for version strings inside cygwin
DLL, so it outputs something more informative than:

  Binary file ../cygwin/cygwin0.dll matches
---
 winsup/testsuite/config/default.exp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/testsuite/config/default.exp b/winsup/testsuite/config/default.exp
index 3936979a6..8033ea627 100644
--- a/winsup/testsuite/config/default.exp
+++ b/winsup/testsuite/config/default.exp
@@ -1,7 +1,7 @@
 proc winsup_version {} {
     global env
     global rootme
-    clone_output "\n[exec grep ^%%% $rootme/../cygwin/cygwin0.dll]\n"
+    clone_output "\n[exec grep -a ^%%% $rootme/../cygwin/cygwin0.dll]\n"
     if { [info exists env(CYGWIN)] } {
         clone_output "CYGWIN=$env(CYGWIN)\n"
     } else {
-- 
2.29.2

