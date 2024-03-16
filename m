Return-Path: <SRS0=svlf=KW=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id 2E3333858D37
	for <cygwin-patches@cygwin.com>; Sat, 16 Mar 2024 16:44:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2E3333858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2E3333858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710607494; cv=none;
	b=ahzd1Di4l08JX8wVCFAaqgp/haxtVFAPVGn3Zurgw3TUmZSnHjiB7EBnUTisRKJCONZbzVp9Yk9NP5DH/F5m0rUIYrKtHRMPuOX/tmndC3kfXPqZZGkuvMRRseUHX8BKWD4JkLilco5ligGFXf6MBCTtKPm8ffKsCUOCr0VAl34=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710607494; c=relaxed/simple;
	bh=rbg6/Vj51Gediu5hawyhN3XLWfwCZHd82mAX8lMaSwI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nykFLhjx3oqCn857gyjVcAtiQiubnTWpk4VOhEWxDmNy4tX/SrK+9vgjTnhIWGDnLHxSUOmj5yNR2Qxdk8/catOdGSryNo4Lj6NfTsgKZJqWgmnWZEnEIRXK8scbn9cCoMT+Sq15BCvVeXu4AQFIjFej7gPwZXr5qb2hINdU83Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 95716140A5F;
	Sat, 16 Mar 2024 16:44:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 3F92420024;
	Sat, 16 Mar 2024 16:44:48 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/cygwin/fhandler/proc.cc: format_proc_cpuinfo() Linux 6.8 cpuinfo flags
Date: Sat, 16 Mar 2024 10:44:00 -0600
Message-ID: <86a84fad25ec3b5c49e9b737dfccbdb2f510556e.1710519553.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F92420024
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: wefxtgb8yegtq5ewg7jecxzq4qu4zxjh
X-Rspamd-Server: rspamout01
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18sd1oTM4bJYwU44rIsK32IW3NEel8zsRs=
X-HE-Tag: 1710607488-776243
X-HE-Meta: U2FsdGVkX18HJrEgFJ/voJfGYCuVw7eWAkNj0xdGI6TYwhkIpSPf6OX7cd87CSfn4t5/L4W2d6blIs2knDcC3iz/JJcXmOBHpSGu8LWObJXwCC1Vu1e7qX6VjdTdcxxd/BnvPNDst0AhJhcDiPkICn3xpDXma992+xrZUpZLsR7JfYrPVIptHQTw7+24pRQYkrD4zMMNetf4KMxK+29p8sU27ASheTthny1nsz5oqnR2X6vh+QyE4GrnC9x7PIZWgLclUcvNCSU1qp/yImqmU1vNEPYMGBaFtl4LbHF/lyIxmbhQbLS7JnqikyxcFdg20kAtF+YQOCY=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

add Linux 6.8 cpuinfo flags:
Intel 0x00000007:1 eax:17 fred		Flexible Return and Event Delivery;
AMD   0x8000001f   eax:4  sev_snp	SEV secure nested paging;
document unused and some unprinted bits that could look like omissions;
fix typos and misalignments;

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/cygwin/fhandler/proc.cc | 38 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index be107cb8eacc..cb754185b833 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1233,6 +1233,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
       ftcprint (features2, 13, "cx16");     /* cmpxchg16b instruction */
       ftcprint (features2, 14, "xtpr");     /* send task priority messages */
       ftcprint (features2, 15, "pdcm");     /* perf/debug capabilities MSR */
+/*    ftcprint (features2, 16, "");     */  /* unused */
       ftcprint (features2, 17, "pcid");     /* process context identifiers */
       ftcprint (features2, 18, "dca");      /* direct cache access */
       ftcprint (features2, 19, "sse4_1");   /* xmm 4_1 sse 4.1 */
@@ -1273,14 +1274,18 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	      ftcprint (features1, 11, "xop");		/* sse 5 extended AVX */
 	      ftcprint (features1, 12, "skinit");       /* skinit/stgi */
 	      ftcprint (features1, 13, "wdt");          /* watchdog timer */
+/*	      ftcprint (features1, 14, ""); */		/* unused */
 	      ftcprint (features1, 15, "lwp");          /* light weight prof */
 	      ftcprint (features1, 16, "fma4");         /* 4 operand MAC */
 	      ftcprint (features1, 17, "tce");          /* translat cache ext */
+/*	      ftcprint (features1, 18, ""); */		/* unused */
 	      ftcprint (features1, 19, "nodeid_msr");   /* nodeid MSR */
+/*	      ftcprint (features1, 20, ""); */		/* unused */
 	      ftcprint (features1, 21, "tbm");          /* trailing bit manip */
 	      ftcprint (features1, 22, "topoext");      /* topology ext */
 	      ftcprint (features1, 23, "perfctr_core"); /* core perf ctr ext */
 	      ftcprint (features1, 24, "perfctr_nb");   /* NB perf ctr ext */
+/*	      ftcprint (features1, 25, ""); */		/* unused */
 	      ftcprint (features1, 26, "bpext");        /* data brkpt ext */
 	      ftcprint (features1, 27, "ptsc");         /* perf timestamp ctr */
 	      ftcprint (features1, 28, "perfctr_llc");  /* ll cache perf ctr */
@@ -1447,6 +1452,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 19, "adx");          /* adcx/adox */
 	  ftcprint (features1, 20, "smap");         /* sec mode access prev */
 	  ftcprint (features1, 21, "avx512ifma");   /* vec int FMA */
+/*	  ftcprint (features1, 22, ""); */	    /* unused */
 	  ftcprint (features1, 23, "clflushopt");   /* cache line flush opt */
 	  ftcprint (features1, 24, "clwb");         /* cache line write back */
 	  ftcprint (features1, 25, "intel_pt");     /* intel processor trace */
@@ -1468,6 +1474,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  1, "xsavec");   /* xsavec instruction */
 	  ftcprint (features1,  2, "xgetbv1");  /* xgetbv ecx 1 */
 	  ftcprint (features1,  3, "xsaves");   /* xsaves/xrstors */
+/*	  ftcprint (features1,  4, "xfd"); */	/* eXtended Feature Disabling */
 	}
       /* cpuid 0x0000000f edx */
       if (maxf >= 0x0000000f)
@@ -1502,9 +1509,18 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  4, "avx_vnni");	    /* vex enc NN vec */
 	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
 /*	  ftcprint (features1,  7, "cmpccxadd"); */ /* CMPccXADD instructions */
-/*	  ftcprint (features1, 18, "lkgs");	 */ /* load kernel (userspace) GS */
-/*	  ftcprint (features1, 21, "amx_fp16");	 */ /* AMX fp16 Support */
-/*	  ftcprint (features1, 23, "avx_ifma");	 */ /* Support for VPMADD52[H,L]UQ */
+/*	  ftcprint (features1,  8, "arch_perf"); */ /* Arch PerfMon Extension */
+/*	  ftcprint (features1, 10, "fzrm");	*/  /* Fast zero-length REP MOVSB */
+/*	  ftcprint (features1, 11, "fsrs");	*/  /* Fast short REP STOSB    */
+/*	  ftcprint (features1, 12, "fsrc");	*/  /* Fast short REP {CMPSB,SCASB} */
+	  ftcprint (features1, 17, "fred");	    /* Flexible Return and Event Delivery */
+/*	  ftcprint (features1, 18, "lkgs");	*/  /* load kernel (userspace) GS */
+/*	  ftcprint (features1, 19, "wrmsrns");	*/  /* Non-serializing WRMSR */
+/*	  ftcprint (features1, 21, "amx_fp16");	*/  /* AMX fp16 Support	*/
+/*	  ftcprint (features1, 22, "amx_bf16");	*/  /* AMX bf16 Support */
+/*	  ftcprint (features1, 23, "avx_ifma");	*/  /* Support for VPMADD52[H,L]UQ */
+/*	  ftcprint (features1, 24, "amx_tile");	*/  /* AMX tile Support */
+/*	  ftcprint (features1, 25, "amx_int8");	*/  /* AMX int8 Support */
 	  ftcprint (features1, 26, "lam");	    /* Linear Address Masking */
 	}
 
@@ -1531,6 +1547,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1, 26, "ssb_no"); */    /* ssb fixed in hardware */
 	  ftcprint (features1, 27, "cppc");	    /* collab proc perf ctl */
 /*	  ftcprint (features1, 28, "amd_psfd"); */  /* predictive store fwd dis */
+/*	  ftcprint (features1, 29, "btc_no"); */    /* Not vulnerable to Branch Type Confusion */
 	  ftcprint (features1, 31, "brs");	    /* branch sampling */
         }
 
@@ -1564,7 +1581,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  4, "tsc_scale");        /* TSC rate control */
 	  ftcprint (features1,  5, "vmcb_clean");       /* VMCB clean bits */
 	  ftcprint (features1,  6, "flushbyasid");      /* flush by ASID */
-	  ftcprint (features1,  7, "decode_assists");   /* decode assists */
+	  ftcprint (features1,  7, "decodeassists");	/* decode assists */
 	  ftcprint (features1, 10, "pausefilter");      /* filt pause intrcpt */
 	  ftcprint (features1, 12, "pfthreshold");      /* pause filt thresh */
 	  ftcprint (features1, 13, "avic");             /* virt int control */
@@ -1580,6 +1597,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
         {
 	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
 
+/*	  ftcprint (features1,  0, ""); */		/* unused */
 	  ftcprint (features1,  1, "avx512vbmi");	/* vec bit manip */
 	  ftcprint (features1,  2, "umip");             /* user mode ins prot */
 	  ftcprint (features1,  3, "pku");              /* prot key userspace */
@@ -1594,10 +1612,14 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 12, "avx512_bitalg");    /* vpopcnt/b/w vpshuf */
 	  ftcprint (features1, 13, "tme");              /* total mem encrypt */
 	  ftcprint (features1, 14, "avx512_vpopcntdq"); /* vec popcnt dw/qw */
+/*	  ftcprint (features1, 15, ""); */		/* unused */
 	  ftcprint (features1, 16, "la57");             /* 5 level paging */
+/*	  ftcprint (features1, .., ""); */		/* unused */
 	  ftcprint (features1, 22, "rdpid");            /* rdpid instruction */
+/*	  ftcprint (features1, 23, ""); */		/* unused */
 	  ftcprint (features1, 24, "bus_lock_detect");	/* bus lock detect dbg excptn */
 	  ftcprint (features1, 25, "cldemote");         /* cldemote instr */
+/*	  ftcprint (features1, 26, ""); */		/* unused */
 	  ftcprint (features1, 27, "movdiri");          /* movdiri instr */
 	  ftcprint (features1, 28, "movdir64b");        /* movdir64b instr */
 	  ftcprint (features1, 29, "enqcmd");		/* enqcmd/s instructions*/
@@ -1610,8 +1632,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
           cpuid (&unused, &features1, &unused, &unused, 0x80000007, 0);
 
           ftcprint (features1,  0, "overflow_recov");	/* MCA oflow recovery */
-          ftcprint (features1,  1, "succor");           /* uncor err recovery */
-          ftcprint (features1,  3, "smca");             /* scalable MCA */
+          ftcprint (features1,  1, "succor");		/* uncor err recovery */
+/*        ftcprint (features1,  2, ""); */		/* unused */
+          ftcprint (features1,  3, "smca");		/* scalable MCA */
         }
 
       /* Intel cpuid 0x00000007 edx */
@@ -1646,8 +1669,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features2,  1, "sev");	/* AMD secure encrypted virt */
 /*	  ftcprint (features2,  2, "vm_page_flush");*/	/* VM page flush MSR */
 	  ftcprint (features2,  3, "sev_es");	/* AMD SEV encrypted state */
-/*	  ftcprint (features2,  4, "sev_snp");*//* AMD SEV secure nested paging */
+	  ftcprint (features2,  4, "sev_snp");	/* AMD SEV secure nested paging */
 /*	  ftcprint (features2,  5, "vmpl");   *//* VM permission levels support */
+/*	  ftcprint (features2,  9, "v_tsc_aux"); */	/* Virtual TSC_AUX */
 /*	  ftcprint (features2, 10, "sme_coherent");   *//* SME h/w cache coherent */
 /*	  ftcprint (features2, 11, "sev_64b");*//* SEV 64 bit host guest only */
 /*	  ftcprint (features2, 12, "sev_rest_inj");   *//* SEV restricted injection */
-- 
2.43.0

