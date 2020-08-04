Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id 7BDF43861893
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 06:52:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7BDF43861893
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id 2qnsk5j8HFXeP2qntkk5sL; Tue, 04 Aug 2020 00:52:05 -0600
X-Authority-Analysis: v=2.3 cv=ePaIcEh1 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=RHbJGUuhA2qiN4U_1BMA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): use _small_sprintf %X
 for microcode
Date: Tue,  4 Aug 2020 00:51:56 -0600
Message-Id: <20200804065156.5072-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJckTbjcHC9y32s2E2QxV5qBDMUF3kS/7dbWBU519/3FeDNbwFzgrNGBo1Nop7HA2HoDyUgJXqSwugwh/pHr8T7AQ6IyZVeNS8YeF+saPzzcMk0BUAST
 +kPa5jgxLvkI5JHexhqopPidP1mGuXBQP6uWUjrYPVZYmUavW4LxbwfresZZSPfNe4BPhErxrC82SxrTwCjZz1JKHcSYz6BsIcQhlL4dOTbRBhcwENq26zXZ
 KmNlev02SNbrkPxWVVuUzg==
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 04 Aug 2020 06:52:07 -0000

microcode is unsigned long long, printed by _small_sprintf using %x;
Cygwin32 used last 4 bytes of microcode for next field MHz, printing 0;
use correct _small_sprintf format %X to print microcode, producing
correct MHz value under Cygwin32
---
 winsup/cygwin/fhandler_proc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 72ffa89cdc79..9a20c23d4b65 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -833,7 +833,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 					 "model\t\t: %d\n"
 					 "model name\t: %s\n"
 					 "stepping\t: %d\n"
-					 "microcode\t: 0x%x\n"
+					 "microcode\t: 0x%X\n"
 					 "cpu MHz\t\t: %d.000\n",
 				 family,
 				 model,
-- 
2.28.0

