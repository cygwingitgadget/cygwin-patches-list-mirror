Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id 5AB653858C1F
 for <cygwin-patches@cygwin.com>; Tue, 15 Feb 2022 21:54:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5AB653858C1F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
 by cmsmtp with ESMTP
 id K28qn4NTz5Rf1K5mCn7K1F; Tue, 15 Feb 2022 21:54:24 +0000
Received: from BWINGLISD.shawcable.net. ([184.64.124.72]) by cmsmtp with ESMTP
 id K5mCnP69z2SCrK5mCn9mDD; Tue, 15 Feb 2022 21:54:24 +0000
X-Authority-Analysis: v=2.4 cv=JLwoDuGb c=1 sm=1 tr=0 ts=620c2110
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=hNZfkREwxPR_96-FR58A:9 a=QEXdDO2ut3YA:10
 a=1cF8Z3q_FTqyLXo45agA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix bad bits in last
 change
Date: Tue, 15 Feb 2022 14:54:20 -0700
Message-Id: <20220215215420.40254-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.35.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKEwx6HaW/BgneIn+CcxFCjlTyu4ivdFW5XJbH+iUDDYxBXV/4i5YWMkhRQUv0E+ZYeSodXpOCrPPNZQspzN9wsWNS8BUKOa/R4OLDjFNCxdT7JTQkem
 qLjokxHK71eg9owC99X5nSTjCBF55C7AYkAyhpbVDcqykHw6ilbJF6ba+hXR7Qd8hO8oM/9qTizgld8V2r61/IYJtwgb4utoSXDvPrC5QaYbOlE3xHhf+cEF
 N3ZSNCwhiS+jAW8gNLZ55UukNQq3hwzhnlZS8GGnBT4=
X-Spam-Status: No, score=-1169.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 15 Feb 2022 21:54:26 -0000

This is a multi-part message in MIME format.
--------------2.35.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


move Linux 5.16 Gobble Gobble flags to 5.17 Superb Owl correct positions:
0x00000007:1 Intel Advanced Matrix eXtensions:
		 EAX:22 amx_bf16 Brain Float 16 dot product
		 EAX:24 amx_tile Tile matrix multiply
		 EAX:25 amx_int8 Int 8 byte dot product
0x00000007:0 Intel Advanced Matrix eXtensions:
		 EDX:22 amx_bf16 Brain Float 16 dot product
		 EDX:24 amx_tile Tile matrix multiply
		 EDX:25 amx_int8 Int 8 byte dot product
---
 winsup/cygwin/fhandler_proc.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


--------------2.35.1
Content-Type: text/x-patch; name="0001-fhandler_proc.cc-format_proc_cpuinfo-fix-bad-bits-in-last-change.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-fhandler_proc.cc-format_proc_cpuinfo-fix-bad-bits-in-last-change.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index d51f171a3a41..0b01e68f8e50 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1456,9 +1456,6 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	  ftcprint (features1,  4, "avx_vnni");	    /* vex enc NN vec */
 	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
-	  ftcprint (features1, 22, "amx_bf16");	    /* Advanced Matrix eXtensions Brain Float 16 dot product */
-	  ftcprint (features1, 24, "amx_tile");	    /* Advanced Matrix eXtensions Tile matrix multiply */
-	  ftcprint (features1, 25, "amx_int8");	    /* Advanced Matrix eXtensions Int 8 byte dot product */
 	}
 
       /* AMD cpuid 0x80000008 ebx */
@@ -1576,7 +1573,10 @@ format_proc_cpuinfo (void *, char *&destbuf)
           ftcprint (features1, 16, "tsxldtrk");		   /* TSX Susp Ld Addr Track */
           ftcprint (features1, 18, "pconfig");		   /* platform config */
           ftcprint (features1, 19, "arch_lbr");		   /* last branch records */
+	  ftcprint (features1, 22, "amx_bf16");	    /* Advanced Matrix eXtensions Brain Float 16 dot product */
           ftcprint (features1, 23, "avx512_fp16");	   /* avx512 fp16 */
+	  ftcprint (features1, 24, "amx_tile");	    /* Advanced Matrix eXtensions Tile matrix multiply */
+	  ftcprint (features1, 25, "amx_int8");	    /* Advanced Matrix eXtensions Int 8 byte dot product */
           ftcprint (features1, 28, "flush_l1d");	   /* flush l1d cache */
           ftcprint (features1, 29, "arch_capabilities");   /* arch cap MSR */
         }

--------------2.35.1--


