Return-Path: <SRS0=WBac=7G=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-047.btinternet.com (mailomta20-re.btinternet.com [213.120.69.113])
	by sourceware.org (Postfix) with ESMTPS id 4F8D93858D37
	for <cygwin-patches@cygwin.com>; Tue, 14 Mar 2023 14:16:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4F8D93858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20230314141629.UIUU20465.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Tue, 14 Mar 2023 14:16:29 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 63FE976D018ABF66
X-Originating-IP: [86.139.167.100]
X-OWM-Source-IP: 86.139.167.100 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhephfeugfehhedtgfefvedtveelkefgjeelgeffgfeijeeluefgffetgfdvudduiedunecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkeeirddufeelrdduieejrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedruddttddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudeijedquddttddrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhr
	nhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhprhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.100) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 63FE976D018ABF66; Tue, 14 Mar 2023 14:16:29 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: doc: Upate a link from gitweb to cgit
Date: Tue, 14 Mar 2023 14:16:16 +0000
Message-Id: <20230314141616.9110-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.5 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Also, reword 'considerable patch' to be more idomatic.
---
 winsup/doc/faq-api.xml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/faq-api.xml b/winsup/doc/faq-api.xml
index 6b5824cf2..c9b35f6b0 100644
--- a/winsup/doc/faq-api.xml
+++ b/winsup/doc/faq-api.xml
@@ -41,8 +41,8 @@ deprecated by regular, automated test releases.  See the next FAQ entry
 <answer>
 
 <para>Yes.  Starting December 2022, regular, automated test releases
-are created whenever a considerable patch is pushed to the Cygwin git
-repo at <ulink url="https://cygwin.com/git/newlib-cygwin.git"/>.
+are created whenever a significant patch is pushed to the Cygwin git
+repo at <ulink url="https://cygwin.com/cgit/newlib-cygwin/"/>.
 You can download the cygwin package test releases just like any other
 test release for any Cgywin package using the Cygwin Setup program.
 For more info, see
-- 
2.39.0

