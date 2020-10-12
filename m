Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta23-re.btinternet.com
 [213.120.69.116])
 by sourceware.org (Postfix) with ESMTPS id 1DE69386F020
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 19:30:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1DE69386F020
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20201012193004.SKWB13627.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 12 Oct 2020 20:30:04 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.141.130.13]
X-OWM-Source-IP: 86.141.130.13 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddugedurddufedtrddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedurddufedtrddufedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.130.13) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC158890D6; Mon, 12 Oct 2020 20:30:04 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/8] Drop looking for w32api in winsup/w32api
Date: Mon, 12 Oct 2020 20:29:36 +0100
Message-Id: <20201012192943.15732-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 12 Oct 2020 19:30:20 -0000

Stop looking for w32api headers in the (no longer existent)
winsup/w32api directory (removed in commit 61746d6a).
---
 winsup/acinclude.m4 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/acinclude.m4 b/winsup/acinclude.m4
index 80c920e8c..865ef8b5d 100644
--- a/winsup/acinclude.m4
+++ b/winsup/acinclude.m4
@@ -50,8 +50,6 @@ if test -n "$with_windows_headers"; then
     else
 	AC_MSG_ERROR([cannot find windef.h in specified --with-windows-headers path: $saw_windows_headers]);
     fi
-elif test -d "$winsup_srcdir/w32api/include/windef.h"; then
-    windows_headers="$winsup_srcdir/w32api/include"
 else
     windows_headers=$(cd $($ac_cv_prog_CC -xc /dev/null -E -include windef.h 2>/dev/null | sed -n 's%^# 1 "\([^"]*\)/windef\.h".*$%\1%p' | head -n1) 2>/dev/null && pwd)
     if test -z "$windows_headers" -o ! -d "$windows_headers"; then
-- 
2.28.0

