Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id 065C438618C9
 for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021 16:28:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 065C438618C9
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([24.64.172.44])
 by shaw.ca with ESMTP
 id CPgwlIV36HmS3CPgxlRZTv; Wed, 17 Feb 2021 09:28:43 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=602d443b
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=nz-5sxVJmLUA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=CK5ovNVcWVCeCUjQAzIA:9
 a=QEXdDO2ut3YA:10 a=VSevBwtulvAOWX-5JCwA:9 a=B2y7HmGcmWMA:10
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/2] cpuinfo: add AVX features; move SME, SEV/_ES features
Date: Wed, 17 Feb 2021 09:28:36 -0700
Message-Id: <20210217162836.57947-3-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217162836.57947-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20210217162836.57947-1-Brian.Inglis@SystematicSW.ab.ca>
Reply-To: patches
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.30.0"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDPEFV+r2F08XOu+6V/0BaXXsJT6A7GtFOAD3MTXYbwDIe1D8WfIqfogkNz82stbVPZxeKim7eN2auGmLNXcN0YvCwHZszfPPXlErLIYbv44KlkGbNXc
 BnumnOp5e3TnaHxZ4l+AvruSlSRhQcAmZy2oWm+WNirLqFXntjYU0wWmTw9uUTc2nifk99HSHcWzr+dSI5+bltnlZARTCTIshrTvK82dDvDtxvQQKiOuCCuu
 V3jkhHyKavxVIz6AopjdH6Cz1k99tN1iXyi/DrCghtw=
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPAM_BODY, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Wed, 17 Feb 2021 16:28:45 -0000

This is a multi-part message in MIME format.
--------------2.30.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Linux 5.11 💕 Valentine's Day Edition 💕 added features and changes:
add Intel 0x00000007 EDX:23 avx512_fp16 and 0x00000007:1 EAX:4 avx_vnni;
group scattered AMD 0x8000001f EAX Secure Mem/Encrypted Virt features at end:
0 sme, 1 sev, 3 sev_es (more to come not yet displayed)
---
 winsup/cygwin/fhandler_proc.cc | 44 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 21 deletions(-)


--------------2.30.0
Content-Type: text/x-patch; name="0002-cpuinfo-add-AVX-features-move-SME-SEV-_ES-features.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0002-cpuinfo-add-AVX-features-move-SME-SEV-_ES-features.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index d4c8613eb392..501c157daae5 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1330,13 +1330,6 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  7, "hw_pstate");	/* hw P state */
 	  ftcprint (features1, 11, "proc_feedback"); /* proc feedback interf */
 	}
-      /* cpuid 0x8000001f eax */
-      if (maxe >= 0x8000001f)
-	{
-	  cpuid (&features1, &unused, &unused, &unused, 0x8000001f);
-
-	  ftcprint (features1,  0, "sme");	/* secure memory encryption */
-	}
 
 /*	  ftcprint (features1, 11, "pti");*//* Page Table Isolation reqd with Meltdown */
 
@@ -1370,14 +1363,6 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  from above */
 	  ftcprint (features1,  6, "mba");	/* memory bandwidth alloc */
 	}
-      /* cpuid 0x8000001f eax */
-      if (maxe >= 0x8000001f)
-	{
-	  cpuid (&features2, &unused, &unused, &unused, 0x8000001f);
-
-	  ftcprint (features2,  1, "sev");	/* secure encrypted virt */
-	/*ftcprint (features2,  3, "sev_es"); - print below */
-	}
       /* cpuid 0x80000008 ebx */
       if (maxe >= 0x80000008)
         {
@@ -1401,12 +1386,6 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1, 26, "ssb_no");	*//* ssb fixed in hardware */
         }
 
-      /* cpuid 0x8000001f eax - set above */
-      if (maxe >= 0x8000001f)
-	{
-	  ftcprint (features2,  3, "sev_es");	/* AMD SEV encrypted state */
-	}
-
       /* cpuid 0x00000007 ebx */
       if (maxf >= 0x00000007)
 	{
@@ -1478,6 +1457,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	{
 	  cpuid (&features1, &unused, &unused, &unused, 0x00000007, 1);
 
+	  ftcprint (features1,  4, "avx_vnni");	    /* vex enc NN vec */
 	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
 	}
 
@@ -1539,6 +1519,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 13, "avic");             /* virt int control */
 	  ftcprint (features1, 15, "v_vmsave_vmload");  /* virt vmsave vmload */
 	  ftcprint (features1, 16, "vgif");             /* virt glb int flag */
+/*	  ftcprint (features1, 28, "svme_addr_chk");  *//* secure vmexit addr check */
         }
 
       /* Intel cpuid 0x00000007 ecx */
@@ -1592,10 +1573,31 @@ format_proc_cpuinfo (void *, char *&destbuf)
           ftcprint (features1, 16, "tsxldtrk");		   /* TSX Susp Ld Addr Track */
           ftcprint (features1, 18, "pconfig");		   /* platform config */
           ftcprint (features1, 19, "arch_lbr");		   /* last branch records */
+          ftcprint (features1, 23, "avx512_fp16");	   /* avx512 fp16 */
           ftcprint (features1, 28, "flush_l1d");	   /* flush l1d cache */
           ftcprint (features1, 29, "arch_capabilities");   /* arch cap MSR */
         }
 
+      /* cpuid x8000001f eax */
+      if (is_amd && maxe >= 0x8000001f)
+	{
+	  cpuid (&features2, &unused, &unused, &unused, 0x8000001f);
+
+	  ftcprint (features2,  0, "sme");	/* secure memory encryption */
+	  ftcprint (features2,  1, "sev");	/* AMD secure encrypted virt */
+/*	  ftcprint (features2,  2, "vm_page_flush");*/	/* VM page flush MSR */
+	  ftcprint (features2,  3, "sev_es");	/* AMD SEV encrypted state */
+/*	  ftcprint (features2,  4, "sev_snp");*//* AMD SEV secure nested paging */
+/*	  ftcprint (features2,  5, "vmpl");   *//* VM permission levels support */
+/*	  ftcprint (features2, 10, "sme_coherent");   *//* SME h/w cache coherent */
+/*	  ftcprint (features2, 11, "sev_64b");*//* SEV 64 bit host guest only */
+/*	  ftcprint (features2, 12, "sev_rest_inj");   *//* SEV restricted injection */
+/*	  ftcprint (features2, 13, "sev_alt_inj");    *//* SEV alternate injection */
+/*	  ftcprint (features2, 14, "sev_es_dbg_swap");*//* SEV-ES debug state swap */
+/*	  ftcprint (features2, 15, "no_host_ibs");    *//* host IBS unsupported */
+/*	  ftcprint (features2, 16, "vte");    *//* virtual transparent encryption */
+	}
+
       print ("\n");
 
       bufptr += __small_sprintf (bufptr, "bogomips\t: %d.00\n",

--------------2.30.0--


