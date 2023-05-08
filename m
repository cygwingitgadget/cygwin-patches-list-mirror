Return-Path: <SRS0=T6CX=A5=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 2DD8A3858D28
	for <cygwin-patches@cygwin.com>; Mon,  8 May 2023 03:12:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2DD8A3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id vdCepnbZr6NwhvrISpzKCU; Mon, 08 May 2023 03:12:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1683515540; bh=mH+etOTBtZBDsScyvImmd8dmxufWmw5R8ySz48oTiig=;
	h=From:To:Subject:Date:Reply-To;
	b=lWoBYLWZqlyI2L7xJzY1CL9bOs8R1WtkTwkN2hnA+QEpXsnIr/hnfaKxhASZ9DvQ6
	 U+/j7kHYNbMuVM0B2fnR9MD+6r/igwt37BwXM5XARfQIgQsV+6XOrq0shv544rU6Th
	 2i81sVWalZN7cW9Uec1r+636pt7T4bhmY3+rmndGpfh2N0ETaXI7H8XSYS2/9ExcbP
	 PYbJZrmSQUOvp4WT4qEQfTGYqhe6gL0rwpnnN2qX/oiZYt9aQ5s+F+UEDbeYNAQd2N
	 OU3W1uH4ZsVToIjygQkKB1+1LR1j0j/81hSBrxI7YiArmpGGGs5qVM8MwNKDMS0lzg
	 LUerkTURi4U5g==
Received: from localhost.localdomain ([184.64.102.149])
	by cmsmtp with ESMTP
	id vrIRpZzrrcyvuvrISpyFRP; Mon, 08 May 2023 03:12:20 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=64586894
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=QPqxtosSyodWa1nf_Q0A:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo
Date: Sun,  7 May 2023 21:12:10 -0600
Message-Id: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Reply-To: cygwin-patches@cygwin.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKZllTAuQn4VDuLMc6DrkRiX6bgM3ZB8TbWJOsWhDZWTTXD5muA/sSCm6wEWycgakFgFgb7t+85FcjR1PoXWcmZT+yt8TdXCmMvFZ6fouK6WtrFX53Mw
 /1fcmD34VAE5W0l07R+Ml98CwmAO81QEiSvD5aw+Vwoa03TsuxeA6U5MMHl8pU65rKWyJhyqYfVF/qbqLcCyEb9BCwJTD9hjBttDiZL3eWnTceYovgb5OUgx
 c2Ozf9bFrPtThkRKlcbblQ==
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

cpuid    0x00000007:0 ecx:7 shstk Shadow Stack support & Windows [20]20H1/[20]2004+
		    => user_shstk User mode program Shadow Stack support
AMD SVM  0x8000000a:0 edx:25 vnmi virtual Non-Maskable Interrrupts
Sync AMD 0x80000008:0 ebx flags across two output locations
---
 winsup/cygwin/fhandler/proc.cc | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index 0e60c519ef79..3c79762e0fbd 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1384,8 +1384,8 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	  ftcprint (features2,  0, "perfmon_v2"); /* Performance Monitoring Version 2 */
 	}
-      /* cpuid 0x80000008 ebx */
-      if (maxe >= 0x80000008)
+      /* AMD cpuid 0x80000008 ebx */
+      if (is_amd && maxe >= 0x80000008)
         {
 /*	  cpuid (&unused, &features1, &unused, &unused, 0x80000008, 0); */
 /*	  from above ^ */
@@ -1395,16 +1395,19 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1,  4, "rdpru");	*//* user level rd proc reg */
 /*	  ftcprint (features1,  6, "mba");	*//* memory BW alloc */
 /*	  ftcprint (features1,  9, "wbnoinvd"); *//* wbnoinvd instruction */
-	  ftcprint (features1, 14, "ibrs");	/* ind br restricted spec */
 	  ftcprint (features1, 12, "ibpb");	/* ind br pred barrier */
+	  ftcprint (features1, 14, "ibrs");	/* ind br restricted spec */
 	  ftcprint (features1, 15, "stibp");	/* 1 thread ind br pred */
-	  ftcprint (features1, 16, "ibrs_enhanced"); /* IBRS_ALL enhanced IBRS always on */
+	  ftcprint (features1, 16, "ibrs_enhanced"); /* ibrs_enhanced IBRS always on */
 /*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
-/*	  ftcprint (features1, 18, "ibrs_pref");*//* IBRS_PREF IBRS preferred */
+/*	  ftcprint (features1, 18, "ibrs_pref");*//* ibrs_pref IBRS preferred */
 /*	  ftcprint (features1, 23, "amd_ppin"); *//* protected proc id no */
 /*	  ftcprint (features1, 24, "ssbd");	*//* spec store byp dis */
 /*	  ftcprint (features1, 25, "virt_ssbd");*//* vir spec store byp dis */
 /*	  ftcprint (features1, 26, "ssb_no");	*//* ssb fixed in hardware */
+/*	  ftcprint (features1, 27, "cppc");	*//* collab proc perf ctl */
+/*	  ftcprint (features1, 28, "amd_psfd"); *//* predictive store fwd dis */
+/*	  ftcprint (features1, 31, "brs");	*//* branch sampling */
         }
 
       /* cpuid 0x00000021 ebx|edx|ecx == "IntelTDX    " */
@@ -1483,6 +1486,14 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 /*	  ftcprint (features1,  6, "split_lock_detect");*//* MSR_TEST_CTRL split lock */
 
+      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
+      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
+					 && wincap.build_number () >= 19041)
+        {
+	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
+	  ftcprint (features1,  7, "user_shstk");	/* "user shadow stack" */
+	}
+
       /* cpuid 0x00000007:1 eax */
       if (maxf >= 0x00000007)
 	{
@@ -1491,6 +1502,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  4, "avx_vnni");	    /* vex enc NN vec */
 	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
 /*	  ftcprint (features1,  7, "cmpccxadd"); */ /* CMPccXADD instructions */
+/*	  ftcprint (features1, 18, "lkgs");	 */ /* load kernel (userspace) GS */
 /*	  ftcprint (features1, 21, "amx_fp16");	 */ /* AMX fp16 Support */
 /*	  ftcprint (features1, 23, "avx_ifma");	 */ /* Support for VPMADD52[H,L]UQ */
 	  ftcprint (features1, 26, "lam");	    /* Linear Address Masking */
@@ -1510,14 +1522,15 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1, 12, "ibpb" ); */	    /* ind br pred barrier */
 /*	  ftcprint (features1, 14, "ibrs" ); */	    /* ind br restricted spec */
 /*	  ftcprint (features1, 15, "stibp"); */	    /* 1 thread ind br pred */
-/*	  ftcprint (features1, 16, "ibrs_enhanced");*//* IBRS_ALL enhanced IBRS always on */
+/*	  ftcprint (features1, 16, "ibrs_enhanced"); */  /* ibrs_enhanced IBRS always on */
 /*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
-/*	  ftcprint (features1, 18, "ibrs_pref");*//* IBRS_PREF IBRS preferred */
+/*	  ftcprint (features1, 18, "ibrs_pref"); */ /* ibrs_pref IBRS preferred */
 	  ftcprint (features1, 23, "amd_ppin");     /* protected proc id no */
 /*	  ftcprint (features1, 24, "ssbd"); */	    /* spec store byp dis */
 	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
 /*	  ftcprint (features1, 26, "ssb_no"); */    /* ssb fixed in hardware */
 	  ftcprint (features1, 27, "cppc");	    /* collab proc perf ctl */
+/*	  ftcprint (features1, 28, "amd_psfd"); */  /* predictive store fwd dis */
 	  ftcprint (features1, 31, "brs");	    /* branch sampling */
         }
 
@@ -1558,6 +1571,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 15, "v_vmsave_vmload");  /* virt vmsave vmload */
 	  ftcprint (features1, 16, "vgif");             /* virt glb int flag */
 	  ftcprint (features1, 20, "v_spec_ctrl");	/* virt spec ctrl support */
+	  ftcprint (features1, 25, "vnmi");             /* virt NMI */
 /*	  ftcprint (features1, 28, "svme_addr_chk");  *//* secure vmexit addr check */
         }
 
@@ -1572,6 +1586,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  4, "ospke");            /* OS prot keys en */
 	  ftcprint (features1,  5, "waitpkg");          /* umon/umwait/tpause */
 	  ftcprint (features1,  6, "avx512_vbmi2");     /* vec bit manip 2 */
+/*	  ftcprint (features1,  7, "shstk"); */		/* Shadow stack */
 	  ftcprint (features1,  8, "gfni");             /* Galois field instr */
 	  ftcprint (features1,  9, "vaes");             /* vector AES */
 	  ftcprint (features1, 10, "vpclmulqdq");       /* nc mul dbl quad */
-- 
2.39.0

