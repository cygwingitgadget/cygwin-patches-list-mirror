Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id 27DD73857C53
 for <cygwin-patches@cygwin.com>; Tue, 29 Jun 2021 17:09:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 27DD73857C53
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
 by cmsmtp with ESMTP
 id yBsylEFj04bInyHEllFak1; Tue, 29 Jun 2021 17:09:27 +0000
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90]) by cmsmtp with ESMTP
 id yHEkliG6QaZZOyHEll9clR; Tue, 29 Jun 2021 17:09:27 +0000
X-Authority-Analysis: v=2.4 cv=e4PD9Yl/ c=1 sm=1 tr=0 ts=60db53c7
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=nz-5sxVJmLUA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=U1ty1mkL6KNLAB6rl7sA:9
 a=QEXdDO2ut3YA:10 a=izgBtNJKWR_rvYu6B2wA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] format_proc_cpuinfo: add Linux 5.13 AMD/Hygon rapl
Date: Tue, 29 Jun 2021 11:09:24 -0600
Message-Id: <20210629170924.30628-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.31.1
Reply-To: patches
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.31.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKmbwHtnWt+Tr6CCCsUixS240ru6i+my5KRCrlKMDeR2GqErHmaUBI5ApMjiFLCw2k9N2+olHG8iAxa3KFsp7fF1O/KzGWDYbeXkWRbWo+B0nEvzfkRZ
 gvJRT4X2PMKcoA2WIryNhZjiB19ivlHvXYIot/Xf+eVRe9YMoCcP9z7fICkb2zvRV1Jw5JoARgZbpfZsjSVMxbwudGHtyPkIuSnh18I92MLIi0U7hhkjna8R
 HFl6yCnGNquW2KntX5LOmll8LY4niuWv/Ys9+yrPzL4=
X-Spam-Status: No, score=-1179.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_BARRACUDACENTRAL,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 29 Jun 2021 17:09:29 -0000

This is a multi-part message in MIME format.
--------------2.31.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Linux 5.13 Opossums on Parade added features and changes:
add AMD 0x80000007 EDX:14 rapl runtime average power limit
---
 winsup/cygwin/fhandler_proc.cc | 8 ++++++++
 1 file changed, 8 insertions(+)


--------------2.31.1
Content-Type: text/x-patch; name="0001-format_proc_cpuinfo-add-Linux-5.13-AMD-Hygon-rapl.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-format_proc_cpuinfo-add-Linux-5.13-AMD-Hygon-rapl.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 7cd0b3af02a2..2a64e7428efa 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1165,6 +1165,14 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  0, "aperfmperf");   /* P state hw coord fb */
 	}
 
+      /* cpuid 0x80000007 edx Advanced power management */
+      if (maxe >= 0x80000007)
+	{
+	  cpuid (&unused, &unused, &unused, &features2, 0x80000007);
+
+	  ftcprint (features2, 14, "rapl"); /* runtime avg power limit */
+	}
+
       /* Penwell, Cloverview, ... TSC doesn't sleep on S3 */
       if (is_intel && family == 6)
 	switch (model)

--------------2.31.1--


