Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta1-re.btinternet.com
 [213.120.69.94])
 by sourceware.org (Postfix) with ESMTPS id 1A75E386F80B
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 19:30:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1A75E386F80B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20201012193010.VLNR4599.re-prd-fep-047.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 12 Oct 2020 20:30:10 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.141.130.13]
X-OWM-Source-IP: 86.141.130.13 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddugedurddufedtrddufeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedurddufedtrddufedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.130.13) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC158891AC; Mon, 12 Oct 2020 20:30:10 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/8] Drop STDINCFLAGS overrides
Date: Mon, 12 Oct 2020 20:29:37 +0100
Message-Id: <20201012192943.15732-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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

This used to turn off -nostdinc on a per-file basis, but has no effect
since 4c36016b.
---
 winsup/cygwin/Makefile.in | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index f775f0691..3a7a73adb 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -583,10 +583,6 @@ exec_CFLAGS:=-fno-builtin-execve
 fhandler_proc_CFLAGS+=-DUSERNAME="\"$(USER)\"" -DHOSTNAME="\"$(HOSTNAME)\""
 fhandler_proc_CFLAGS+=-DGCC_VERSION="\"`$(CC) -v 2>&1 | tail -n 1`\""
 
-_cygwin_crt0_common_STDINCFLAGS:=yes
-libstdcxx_wrapper_STDINCFLAGS:=yes
-cxx_STDINCFLAGS:=yes
-
 .PHONY: all force dll_ofiles install all_target install_target all_host \
 	install_host install install-libs install-headers \
 	clean distclean realclean maintainer-clean
-- 
2.28.0

