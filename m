Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta2-re.btinternet.com
 [213.120.69.95])
 by sourceware.org (Postfix) with ESMTPS id 0FB783887001
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 19:30:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0FB783887001
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20201012193028.HIQB4131.re-prd-fep-049.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 12 Oct 2020 20:30:28 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.141.130.13]
X-OWM-Source-IP: 86.141.130.13 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddugedurddufedtrddufeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedurddufedtrddufedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.130.13) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC1588942D; Mon, 12 Oct 2020 20:30:28 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/8] Drop AC_SUBST(LIBSERVER)
Date: Mon, 12 Oct 2020 20:29:40 +0100
Message-Id: <20201012192943.15732-6-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Mon, 12 Oct 2020 19:30:30 -0000

The autoconf variable LIBSERVER isn't defined, and it's value isn't
used. (The Makefile.in contains a literal value for the name of this
library instead).
---
 winsup/cygwin/configure.ac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index 757ebcfb0..32862d7e5 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -86,7 +86,6 @@ case "$target_cpu" in
 esac
 
 AC_CONFIGURE_ARGS
-AC_SUBST(LIBSERVER)
 AC_SUBST(DLL_NAME)
 AC_SUBST(DLL_ENTRY)
 AC_SUBST(DEF_DLL_ENTRY)
-- 
2.28.0

