Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id E6E893858C2C
 for <cygwin-patches@cygwin.com>; Thu, 24 Mar 2022 04:58:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E6E893858C2C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id X0YAn12KegTZYXFY6nRS7d; Thu, 24 Mar 2022 04:58:14 +0000
Received: from BWINGLISD.cg.shawcable.net. ([184.64.124.72])
 by cmsmtp with ESMTP
 id XFY5n3wCeQV6mXFY5nGyGz; Thu, 24 Mar 2022 04:58:14 +0000
X-Authority-Analysis: v=2.4 cv=PbTsOwtd c=1 sm=1 tr=0 ts=623bfa66
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17 a=7vT8eNxyAAAA:8
 a=r77TgQKjGQsHNAKrUKIA:9 a=Fubkae2diaQA:10 a=TjClg5NT7KohLBBQbJgA:9
 a=QEXdDO2ut3YA:10 a=Q9-mM32qkEwUNn8quOYA:9 a=B2y7HmGcmWMA:10
 a=Mzmg39azMnTNyelF985k:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: "Cygwin Patches" <cygwin-patches@Cygwin.com>
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux Superb Owl
 cpuinfo flags
Date: Wed, 23 Mar 2022 22:57:58 -0600
Message-Id: <20220324045759.57242-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.35.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBk+Sgu7FcQ7M0jYUrm96ZBx69iZNeHJ4L1d6LVZ6tcfjnLGvbMH9s83aT1z3JrXpUw2NsjiLp9gFtW3/hSw1QypcIeI/rplde1Yol3VTaxTEM+p7hMZ
 Cw36xVYPgcDvDoME09ngHOZpq/rcpOootjM6yU+B4rAkQbwvsmCUmGjaVJdKTnbjGPiSluHqG6X4vbqt56/ASgbgB3zxErt9AMWeBDqhO+6jiW2gMCJFIEGZ
 pTVxFiDKgeyWRir6bYnLE93LMVKxjFuOOyJAjhxl/Eg=
X-Spam-Status: No, score=-1170.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP,
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
X-List-Received-Date: Thu, 24 Mar 2022 04:58:16 -0000

From: "Brian Inglis" <Brian.Inglis@SystematicSW.ab.ca>

This is a multi-part message in MIME format.
--------------2.35.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


0x00000007:1 EBX:0  intel_ppin	Intel Protected Processor Inventory Number
0x00000006:0 EAX:19 hfi		Hardware Feedback Interface
0x00000007:0 EDX:20 ibt		Intel Indirect Branch Tracking
---
 winsup/cygwin/fhandler_proc.cc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)


--------------2.35.1
Content-Type: text/x-patch; name="0001-fhandler_proc.cc-format_proc_cpuinfo-add-Linux-Superb-Owl-cpuinfo-flags.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-fhandler_proc.cc-format_proc_cpuinfo-add-Linux-Superb-Owl-cpuinfo-flags.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 0b01e68f8e50..9ba241981a5e 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1303,6 +1303,13 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	  ftcprint (features1,  3, "epb");	/* energy perf bias */
 	}
+      /* cpuid 0x00000007:1 ebx */
+      if (maxf >= 0x00000007)
+	{
+	  cpuid (&unused, &features1, &unused, &unused, 0x00000007, 1);
+
+	  ftcprint (features1,  0, "intel_ppin"); /* Prot Proc Id No */
+	}
       /* cpuid 0x00000010 ebx */
       if (maxf >= 0x00000010)
 	{
@@ -1330,8 +1337,6 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 /*	  ftcprint (features1, 11, "pti");*//* Page Table Isolation reqd with Meltdown */
 
-/*	  ftcprint (features1, 14, "intel_ppin");*//* MSR_PPIN_CTL Prot Proc Id No */
-
       /* cpuid 0x00000010:2 ecx */
       if (maxf >= 0x00000010)
 	{
@@ -1497,6 +1502,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  9, "hwp_act_window"); /* HWP activity window */
 	  ftcprint (features1, 10, "hwp_epp");  /* HWP energy perf pref */
 	  ftcprint (features1, 11, "hwp_pkg_req"); /* HWP package level req */
+	  ftcprint (features1, 19, "hfi");	/* Hardware Feedback Interface */
 	}
 
       /* AMD SVM cpuid 0x8000000a edx */
@@ -1573,6 +1579,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
           ftcprint (features1, 16, "tsxldtrk");		   /* TSX Susp Ld Addr Track */
           ftcprint (features1, 18, "pconfig");		   /* platform config */
           ftcprint (features1, 19, "arch_lbr");		   /* last branch records */
+	  ftcprint (features1, 20, "ibt");		   /* Indirect Branch Tracking */
 	  ftcprint (features1, 22, "amx_bf16");	    /* Advanced Matrix eXtensions Brain Float 16 dot product */
           ftcprint (features1, 23, "avx512_fp16");	   /* avx512 fp16 */
 	  ftcprint (features1, 24, "amx_tile");	    /* Advanced Matrix eXtensions Tile matrix multiply */

--------------2.35.1--


