Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id 32A453858413
 for <cygwin-patches@cygwin.com>; Wed, 25 May 2022 12:31:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 32A453858413
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id tpSfnnMifwtwGtqAanZ7tr; Wed, 25 May 2022 12:31:20 +0000
Received: from BWINGLISD.cg.shawcable.net. ([184.64.124.72])
 by cmsmtp with ESMTP
 id tqAenHE12Cg6jtqAenMeVM; Wed, 25 May 2022 12:31:25 +0000
X-Authority-Analysis: v=2.4 cv=SMhR6cjH c=1 sm=1 tr=0 ts=628e219d
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=Ns4QfxKm2_Rbu5hpYlQA:9 a=QEXdDO2ut3YA:10
 a=4mw1Ilp_0pGWXIFUwx0A:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.18 cpuinfo
 flags
Date: Wed, 25 May 2022 06:30:45 -0600
Message-Id: <20220525123045.8880-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.36.1
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.36.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKaDW9YiWGCu276zUgJzqJoQx2kJ3tFCw3JrPfgrV94NXHLRmmhivdS8NjD2Xgq2jQZUgjjxE/GfC4JxaKa2wcoaUICJgC6lAL7jnUCldK9256uOUDaW
 AyyNgGGXAeUQIiq3XdokWxLA/XoeYgFTaFnTtGqsuVUJseTKu8mq+BG8fsDJewlvHLfDhlu2srXZHK74j0Mv0wZBy5rUt9tX/vxIXwqYlEo2FVsABigRERKn
 f8XwXF1lIUEIAbUWMy1p373y5K8MR0Jykik3u8rC/K0=
X-Spam-Status: No, score=-1170.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Wed, 25 May 2022 12:31:27 -0000

This is a multi-part message in MIME format.
--------------2.36.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


0x80000008:0 EBX:31 brs		AMD Branch Sampling available
0x80000022:0 EAX:0  perfmon_v2	AMD ExtPerfMonAndDbg Performance Monitoring Version 2
0x00000021:0 EBX|EDX|ECX=="IntelTDX    " tdx_guest Intel Trust Domain Extensions- Guest Support
---
 winsup/cygwin/fhandler_proc.cc | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)


--------------2.36.1
Content-Type: text/x-patch; name="0001-fhandler_proc.cc-format_proc_cpuinfo-add-Linux-5.18-cpuinfo-flags.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-fhandler_proc.cc-format_proc_cpuinfo-add-Linux-5.18-cpuinfo-flags.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 9ba241981a5e..af553644e231 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1362,14 +1362,21 @@ format_proc_cpuinfo (void *, char *&destbuf)
       if (maxe >= 0x80000008)
 	{
 /*	  cpuid (&unused, &features1, &unused, &unused, 0x80000008, 0); */
-/*	  from above */
+/*	  from above ^ */
 	  ftcprint (features1,  6, "mba");	/* memory bandwidth alloc */
 	}
+      /* cpuid 0x80000022 ebx AMD ExtPerfMonAndDbg */
+      if (maxe >= 0x80000022)
+	{
+	  cpuid (&features2, &unused, &unused, &unused, 0x80000022);
+
+	  ftcprint (features2,  0, "perfmon_v2"); /* Performance Monitoring Version 2 */
+	}
       /* cpuid 0x80000008 ebx */
       if (maxe >= 0x80000008)
         {
 /*	  cpuid (&unused, &features1, &unused, &unused, 0x80000008, 0); */
-/*	  from above */
+/*	  from above ^ */
 /*	  ftcprint (features1,  0, "clzero");	*//* clzero instruction */
 /*	  ftcprint (features1,  1, "irperf");   *//* instr retired count */
 /*	  ftcprint (features1,  2, "xsaveerptr");*//* save/rest FP err ptrs */
@@ -1388,6 +1395,16 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1, 26, "ssb_no");	*//* ssb fixed in hardware */
         }
 
+      /* cpuid 0x00000021 ebx|edx|ecx == "IntelTDX    " */
+      if (is_intel && maxf >= 0x00000021)
+	{
+	  uint32_t tdx[3];
+
+	  cpuid (&unused, &tdx[0], &tdx[2],  &tdx[1], 0x00000021, 0);
+	  if (!memcmp ("IntelTDX    ", tdx, sizeof (tdx)))
+	    ftuprint ("tdx_guest"); /* Intel Trust Domain Extensions Guest Support */
+	}
+
       /* cpuid 0x00000007 ebx */
       if (maxf >= 0x00000007)
 	{
@@ -1485,6 +1502,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
 /*	  ftcprint (features1, 26, "ssb_no"); */    /* ssb fixed in hardware */
 	  ftcprint (features1, 27, "cppc");	    /* collab proc perf ctl */
+	  ftcprint (features1, 31, "brs");	    /* branch sampling */
         }
 
       /* thermal & power cpuid 0x00000006 eax */

--------------2.36.1--


