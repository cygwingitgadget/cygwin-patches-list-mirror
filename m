Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id 5FDF83894C18
 for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2020 18:51:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5FDF83894C18
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id Iz0CkRXXJs3D6Iz0DkTljv; Thu, 17 Sep 2020 12:51:30 -0600
X-Authority-Analysis: v=2.4 cv=bZHV7MDB c=1 sm=1 tr=0 ts=5f63b032
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=pZ2pBc1l7yVo5J1wLZUA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add tsxldtrk,
 sev_es flags
Date: Thu, 17 Sep 2020 12:51:25 -0600
Message-Id: <20200917185125.6208-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBkpe4erME+u/MYuCNMHjlkEClQwUbq6C2wRl/xADkKbenZXhyraj/s/USNpjpyiSYCdJlVYpaiHwIwKr1BKzj7rKV4gGiK2OO4XvlLnEzjMbbP6f8hf
 z+KFzSADlA5MyK+xtSPbO09EIEWdMF9ZD5oDHwPhqqYNPterzVRp2kiqce65bgg1Ei0/kOpbkRkgc6kvBvAE8/XTPghY113TMZfYfPvZTqI/CE/sCAi6YZf+
 8f6GrkgIvJnQIBMp2ceTfW+LpVOAe45QUnZruD3aSaI=
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Thu, 17 Sep 2020 18:51:32 -0000

Add linux-next cpuinfo flags for Intel TSX suspend load address tracking
instructions and AMD Secure Encrypted Virtualization with Encrypted State
---
 winsup/cygwin/fhandler_proc.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 196bafd18993..6f6e8291a0ca 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1376,6 +1376,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  cpuid (&features2, &unused, &unused, &unused, 0x8000001f);
 
 	  ftcprint (features2,  1, "sev");	/* secure encrypted virt */
+	/*ftcprint (features2,  3, "sev_es"); - print below */
 	}
       /* cpuid 0x80000008 ebx */
       if (maxe >= 0x80000008)
@@ -1400,6 +1401,12 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1, 26, "ssb_no");	*//* ssb fixed in hardware */
         }
 
+      /* cpuid 0x8000001f eax - set above */
+      if (maxe >= 0x8000001f)
+	{
+	  ftcprint (features2,  3, "sev_es");	/* AMD SEV encrypted state */
+	}
+
       /* cpuid 0x00000007 ebx */
       if (maxf >= 0x00000007)
 	{
@@ -1579,6 +1586,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
           ftcprint (features1,  8, "avx512_vp2intersect"); /* vec intcpt d/q */
           ftcprint (features1, 10, "md_clear");            /* verw clear buf */
           ftcprint (features1, 14, "serialize");           /* SERIALIZE instruction */
+          ftcprint (features1, 16, "tsxldtrk");		   /* TSX Susp Ld Addr Track */
           ftcprint (features1, 18, "pconfig");		   /* platform config */
           ftcprint (features1, 19, "arch_lbr");		   /* last branch records */
           ftcprint (features1, 28, "flush_l1d");	   /* flush l1d cache */
-- 
2.28.0

