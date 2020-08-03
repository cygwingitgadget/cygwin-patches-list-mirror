Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 5F9153857C52
 for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2020 16:22:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5F9153857C52
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id 2dEfk1PuMFXeP2dEgkiFFY; Mon, 03 Aug 2020 10:22:50 -0600
X-Authority-Analysis: v=2.3 cv=ePaIcEh1 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17 a=VwQbUJbxAAAA:8
 a=AConyIYJqjWt_wrPaNUA:9 a=AjGcO6oz07-iQ99wixmX:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add SERIALIZE
 instruction flag
Date: Mon,  3 Aug 2020 10:22:46 -0600
Message-Id: <20200803162246.2872-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHc4U6zr9MpPPJatuFLf1XHT3DaO/fex9a2n9bAURjdBV8H+BVqqAekilXjAtJzfU3ksoVa1H2aDlY9ifqDd/r7I8hhw00dmvPZrA+f0aZK3Nw1lDPJF
 4OnuXLAOzZzP2091s8c3nIBIXlVbA8264HdrGfSyTTcb0oKqCLE1AlwfPN1oftdx+QkXTxcXmdbdPJ0kpT+prafKP25WeyidS5AxGK+jD9qzI4QIWUhLViEF
 o8wqbW22dx7yET11fH0q7A==
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 03 Aug 2020 16:22:53 -0000

CPUID 7:0 EDX[14] serialize added in linux-next 5.8 by Ricardo Neri-Calderon:
The Intel architecture defines a set of Serializing Instructions (a
detailed definition can be found in Vol.3 Section 8.3 of the Intel "main"
manual, SDM). However, these instructions do more than what is required,
have side effects and/or may be rather invasive. Furthermore, some of
these instructions are only available in kernel mode or may cause VMExits.
Thus, software using these instructions only to serialize execution (as
defined in the manual) must handle the undesired side effects.

As indicated in the name, SERIALIZE is a new Intel architecture
Serializing Instruction. Crucially, it does not have any of the mentioned
side effects. Also, it does not cause VMExit and can be used in user mode.

This new instruction is currently documented in the latest "extensions"
manual (ISE). It will appear in the "main" manual in the future.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/x86/include/asm/cpufeatures.h?id=85b23fbc7d88f8c6e3951721802d7845bc39663d
---
 winsup/cygwin/fhandler_proc.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 4bb8bea1766c..72ffa89cdc79 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1578,6 +1578,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
           ftcprint (features1,  4, "fsrm");		   /* fast short REP MOVSB */
           ftcprint (features1,  8, "avx512_vp2intersect"); /* vec intcpt d/q */
           ftcprint (features1, 10, "md_clear");            /* verw clear buf */
+          ftcprint (features1, 14, "serialize");           /* SERIALIZE instruction */
           ftcprint (features1, 18, "pconfig");		   /* platform config */
           ftcprint (features1, 19, "arch_lbr");		   /* last branch records */
           ftcprint (features1, 28, "flush_l1d");	   /* flush l1d cache */
-- 
2.27.0

