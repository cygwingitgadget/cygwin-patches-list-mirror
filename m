Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 87DDF386100D
 for <cygwin-patches@cygwin.com>; Wed, 22 Jul 2020 19:23:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 87DDF386100D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id yKKQjb40zFXePyKKRj7vdN; Wed, 22 Jul 2020 13:23:00 -0600
X-Authority-Analysis: v=2.3 cv=ePaIcEh1 c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=v5j32Il1EL5RA7lmbAIA:9 a=FpWNpbPu5ModBkCg:21 a=xLTPzbzjunwYX0Nn:21
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add flags and TLB size
Date: Wed, 22 Jul 2020 13:22:54 -0600
Message-Id: <20200722192254.13188-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDvVDnvNnXo6wkY5DhEsRwwmPulQkcHMiScwB0DXJOQiLqysjPEn614ZeKBBhNxpQmKysDC1q2ZPGiGVSK14jStBOne49Jd9JvQkfHK4fP5q/Z9DKLqx
 ITlL66TWZwGhfpOYIitKMsQD/iqAMA0ZtaswrmJcyv3WCTAdndp+o/6/LHfUIpS7bqitrBwjcXpzO2rQ5PI5px7b0g37QTitpxkTny0hnUE9xU4DkwNQb7ma
 olyhHMNiZC/5PJ4RI+LSxA==
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 22 Jul 2020 19:23:04 -0000

update to Linux-next 5.8 order fields and flags:
add amd_dcm, arch_lbr, arch_perfmon, art, cpuid, extd_apicid, ibpb,
ibrs, ibrs_enhanced, nonstop_tsc_s3, nopl, rep_good, ring3mwait, ssbd,
stibp, tsc_known_freq, tsc_reliable, xtopology flags;
add TLB size line;
add ftuprint macro for feature test unconditional flag print;
add commented out flags requiring CR or MSR access in print order with
comment explaining issue;
make cpuid leaf numbers consistent 8 hex digits for searching
---
 winsup/cygwin/fhandler_proc.cc | 297 ++++++++++++++++++++++++++++-----
 1 file changed, 255 insertions(+), 42 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 2396bfe573..4bb8bea176 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -609,8 +609,10 @@ format_proc_stat (void *, char *&destbuf)
 }
 
 #define print(x) { bufptr = stpcpy (bufptr, (x)); }
+/* feature test unconditional print */
+#define ftuprint(msg) print (" " msg)
 /* feature test bit position (0-32) and conditional print */
-#define ftcprint(feat,bitno,msg) if ((feat) & (1 << (bitno))) { print (" " msg); }
+#define ftcprint(feat,bitno,msg) if ((feat) & (1 << (bitno))) { ftuprint (msg); }
 
 static inline uint32_t
 get_msb (uint32_t in)
@@ -1021,8 +1023,8 @@ format_proc_cpuinfo (void *, char *&destbuf)
       ftcprint (features1, 22, "acpi"); /* ACPI via MSR */
       ftcprint (features1, 23, "mmx");  /* multimedia extensions */
       ftcprint (features1, 24, "fxsr"); /* fxsave/fxrstor */
-      ftcprint (features1, 25, "sse");  /* xmm */
-      ftcprint (features1, 26, "sse2"); /* xmm2 */
+      ftcprint (features1, 25, "sse");  /* xmm sse */
+      ftcprint (features1, 26, "sse2"); /* xmm2 sse2 */
       ftcprint (features1, 27, "ss");   /* CPU self snoop */
       ftcprint (features1, 28, "ht");   /* hyper threading */
       ftcprint (features1, 29, "tm");   /* acc automatic clock control */
@@ -1041,27 +1043,171 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 25, "fxsr_opt"); /* fxsave/fxrstor optims */
 	  ftcprint (features1, 26, "pdpe1gb");  /* GB large pages */
 	  ftcprint (features1, 27, "rdtscp");   /* rdtscp */
-	  ftcprint (features1, 29, "lm");       /* long mode (x86 64) */
+	  ftcprint (features1, 29, "lm");       /* long mode (x86-64 amd64) */
 	  ftcprint (features1, 30, "3dnowext"); /* 3DNow extensions */
 	  ftcprint (features1, 31, "3dnow");    /* 3DNow */
 	}
+
+      /* cpuid 0x80000007 edx */
+      if (maxe >= 0x80000007)
+	{
+	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
+
+	  ftcprint (features1,  8, "constant_tsc"); /* TSC ticks at a constant rate */
+	}
+
+/*	  ftcprint (features2,  9, "up");	 *//* SMP kernel running on UP N/A */
+
+      /* cpuid 0x00000007 ebx */
+      if (maxf >= 0x00000007)
+	  cpuid (&unused, &features1, &unused, &unused, 0x00000007, 0);
+      else
+	  features1 = 0;
+      /* cpuid 0x80000007 edx */
+      if (maxe >= 0x80000007)
+	  cpuid (&unused, &unused, &unused, &features2, 0x80000007);
+      else
+	  features2 = 0;
+      uint32_t cr_den, cr_num, Hz;
+      /* cpuid 0x00000015 eax ebx ecx clock ratios optional Hz */
+      if (is_intel && maxf >= 0x00000015)
+	  cpuid (&cr_den, &cr_num, &Hz, &unused, 0x00000015);
+      else
+	  cr_den = 0;
+      /* TSC requires adjustment, nonstop, and clock ratio divider min */
+      if ((features1 & (1 << 1)) &&	/* TSC adjustment MSR 0x3B */
+	  (features2 & (1 << 8)) &&	/* nonstop C states */
+		(cr_den > 1))		/* clock ratio denominator > min */
+	  ftuprint ("art");	/* Always running timer (ART) */
+
+      /* Intel cpuid 0x0000000a eax Arch Perf Mon */
+      if (is_intel && maxf >= 0x0000000a)
+	{
+	  cpuid (&features2, &unused, &unused, &unused, 0x0000000a);
+
+	  /* rev > 0 and # counters/cpu > 1 */
+	  if ((features2 & 0xff) > 0 && (((features2 >> 8) & 0xff) > 1))
+	    ftuprint ("arch_perfmon"); /* Intel Arch Perf Mon */
+	}
+
+/*	  ftcprint (features2, 12, "pebs");*//* MSR_IA32_MISC_ENABLE 12 Precise-Event Based Sampling */
+/*	  ftcprint (features2, 13, "bts"); *//* MSR_IA32_MISC_ENABLE 11 Branch Trace Store */
+
+      /* AMD cpuid 0x00000001 eax */
+      if (is_amd && maxf >= 0x00000001)
+	  cpuid(&features2, &unused, &unused, &unused, 0x00000001);
+      else
+	  features2 = 0;
+
+/* Intel family 6 or AMD family >= x10 or ... */
+/* ... or AMD cpuid 0x00000001 eax in [0x0f58,) or [0x0f48,0x0f50) */
+      if ((is_intel && family == 6) ||
+	  (is_amd && (family >= 0x10 ||
+			(features2 >= 0x0f58 ||
+			(features2 >= 0x0f48 && features2 < 0x0f50)))))
+	  ftuprint ("rep_good");	/* REP microcode works well */
+
+      /* cpuid 0x80000007 edx Advanced power management */
+      if (maxe >= 0x80000007)
+	{
+	  cpuid (&unused, &unused, &unused, &features2, 0x80000007);
+
+	  ftcprint (features2, 12, "acc_power"); /* accum power */
+	}
+
+#if __x86_64__
+      ftuprint ("nopl");	/* NOPL (0F 1F) instructions */
+#endif
+
+/* cpuid 0x0000000b ecx[8:15] type */
+#define BAD_TYPE    0
+#define SMT_TYPE    1
+#define CORE_TYPE   2
+      /* cpuid 0x0000000b ebx ecx */
+      if (maxf >= 0x0000000b)
+        {
+	  cpuid(&unused, &features1, &features2, &unused, 0x0000000b);
+
+	/* check if SMT implemented */
+	  if (features1 != 0 && (((features2 >> 8) & 0xff) == SMT_TYPE))
+	      ftuprint ("xtopology");	/* CPU topology enum extensions */
+	}
+
       /* AMD cpuid 0x80000007 edx */
       if (is_amd && maxe >= 0x80000007)
 	{
 	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
 
-	  ftcprint (features1,  8, "constant_tsc");	/* TSC constant rate */
+	  ftcprint (features1,  8, "tsc_reliable");	/* TSC constant rate */
 	  ftcprint (features1,  8, "nonstop_tsc");	/* nonstop C states */
 	}
+
+      if (is_amd || is_intel)
+	  ftuprint ("cpuid");		/* CPU has CPUID instruction */
+
+      if (is_amd && family > 0x16)
+	  ftuprint ("extd_apicid");	/* Extended APICID (8 bits) */
+
+      /* AMD cpuid 0x8000001e ecx */
+      if (is_amd && maxe >= 0x8000001e)
+	{
+	  cpuid (&unused, &unused, &features1, &unused, 0x8000001e);
+
+	  if (((features1 >> 8) & 7) + 1 > 1)	/* nodes/socket */
+	      ftuprint ("amd_dcm"); /* AMD multi-node processor */
+	}
+
       /* cpuid 0x00000006 ecx */
-      if (maxf >= 0x06)
+      if (maxf >= 0x00000006)
 	{
-	  cpuid (&unused, &unused, &features1, &unused, 0x06);
+	  cpuid (&unused, &unused, &features1, &unused, 0x00000006);
 
 	  ftcprint (features1,  0, "aperfmperf");   /* P state hw coord fb */
 	}
 
+      /* Penwell, Cloverview, ... TSC doesn't sleep on S3 */
+      if (is_intel && family == 6)
+	switch (model)
+	  {
+	    case 0x27: /* Atom Saltwell Mid Penwell */
+	    case 0x35: /* Atom Saltwell Tablet Cloverview */
+	    case 0x4a: /* Atom Silvermont Mid Merriefield */
+	    case 0x75: /* Atom Airmont NP Lightning Mountain */
+	      ftuprint ("nonstop_tsc_s3"); /* TSC doesn't stop in S3 state */
+	      break;
+	  }
+
+      /* cpuid 0x00000015 eax ebx ecx clock ratios optional Hz */
+      if (is_intel && maxf >= 0x00000015)
+	{
+	  uint32_t cr_den, cr_num, Hz, kHz;
+	  cpuid (&cr_den, &cr_num, &Hz, &unused, 0x00000015);
+	  if (cr_num != 0 && cr_den != 0)
+	    {
+	      kHz = Hz / 1000;
+	      /* Denverton don't report hz nor support cpuid 0x16 so set 25MHz */
+	      if (kHz == 0 && model == 0x5F) /* Atom Goldmont D Denverton */
+		  kHz = 25000;
+
+	      /* cpuid TSC frequency is known */
+	      if (kHz != 0)
+		  ftuprint ("tsc_known_freq"); /* TSC has known frequency */
+#if 0 /* keep for future and doc */
+	      else /* kHz == 0 */
+	      /* Skylake and Kabylake don't report clock so use CPU speed and ratio */
+	      if (maxf >= 0x00000016)
+		{
+		  uint32_t mHz;
+		  cpuid(&mHz, &unused, &unused, &unused, 0x00000016);
+		  kHz = mHz * 1000 * cr_num / cr_den;
+		}
+#endif
+	    }
+	}
+
       /* cpuid 0x00000001 ecx */
+      cpuid (&unused, &unused, &features2, &unused, 0x00000001);
+
       ftcprint (features2,  0, "pni");	    /* xmm3 sse3 */
       ftcprint (features2,  1, "pclmuldq"); /* pclmulqdq instruction */
       ftcprint (features2,  2, "dtes64");   /* 64-bit debug store */
@@ -1088,7 +1234,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
       ftcprint (features2, 24, "tsc_deadline_timer"); /* TSC deadline timer */
       ftcprint (features2, 25, "aes");	    /* AES instructions */
       ftcprint (features2, 26, "xsave");    /* xsave/xrstor/xsetbv/xgetbv */
-/*    ftcprint (features2, 27, "osxsave"); */ /* not output on Linux */
+/*    ftcprint (features2, 27, "osxsave");*//* "" XSAVE supported in OS */
       ftcprint (features2, 28, "avx");	    /* advanced vector extensions */
       ftcprint (features2, 29, "f16c");     /* 16 bit FP conversions */
       ftcprint (features2, 30, "rdrand");   /* RNG rdrand instruction */
@@ -1133,34 +1279,49 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	    }
 	}
 
-      /* features scattered in various CPUID levels. */
+	/* ring 3 monitor/mwait */
+	if (is_intel && family == 6)
+	    switch (model)
+	      {
+		case 0x57: /* Xeon Phi Knights Landing */
+		case 0x85: /* Xeon Phi Knights Mill */
+		  ftuprint ("ring3mwait"); /* Ring 3 MONITOR/MWAIT instructions */
+		  break;
+	      }
+
+/*	  ftcprint (features1,  1, "cpuid_fault");*//* MSR_PLATFORM_INFO Intel CPUID faulting */
+
+/* features scattered in various CPUID levels. */
       /* cpuid 0x80000007 edx */
-      if (maxf >= 0x07)
+      if (maxf >= 0x00000007)
 	{
 	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
 
 	  ftcprint (features1,  9, "cpb");	/* core performance boost */
 	}
       /* cpuid 0x00000006 ecx */
-      if (maxf >= 0x06)
+      if (maxf >= 0x00000006)
 	{
-	  cpuid (&unused, &unused, &features1, &unused, 0x06);
+	  cpuid (&unused, &unused, &features1, &unused, 0x00000006);
 
 	  ftcprint (features1,  3, "epb");	/* energy perf bias */
 	}
       /* cpuid 0x00000010 ebx */
-      if (maxf >= 0x10)
+      if (maxf >= 0x00000010)
 	{
-	  cpuid (&unused, &features1, &unused, &unused, 0x10);
+	  cpuid (&unused, &features1, &unused, &unused, 0x00000010);
 
 	  ftcprint (features1,  1, "cat_l3");	/* cache alloc tech l3 */
 	  ftcprint (features1,  2, "cat_l2");	/* cache alloc tech l2 */
 
 	  /* cpuid 0x00000010:1 ecx */
-	  cpuid (&unused, &unused, &features1, &unused, 0x10, 1);
+	  cpuid (&unused, &unused, &features1, &unused, 0x00000010, 1);
 
 	  ftcprint (features1,  2, "cdp_l3");	/* code data prior l3 */
 	}
+
+/*	  ftcprint (features1,  7, "invpcid_single");*//* INVPCID && CR4.PCIDE=1 */
+
       /* cpuid 0x80000007 edx */
       if (maxe >= 0x80000007)
 	{
@@ -1176,51 +1337,87 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	  ftcprint (features1,  0, "sme");	/* secure memory encryption */
 	}
+
+/*	  ftcprint (features1, 11, "pti");*//* Page Table Isolation reqd with Meltdown */
+
+/*	  ftcprint (features1, 14, "intel_ppin");*//* MSR_PPIN_CTL Prot Proc Id No */
+
       /* cpuid 0x00000010:2 ecx */
-      if (maxf >= 0x10)
+      if (maxf >= 0x00000010)
 	{
-	  cpuid (&unused, &unused, &features1, &unused, 0x10, 2);
+	  cpuid (&unused, &unused, &features2, &unused, 0x00000010, 2);
 
-	  ftcprint (features1,  2, "cdp_l2");	/* code data prior l2 */
+	  ftcprint (features2,  2, "cdp_l2");	/* code data prior l2 */
+	}
+      /* cpuid 0x80000008 ebx */
+      if (maxe >= 0x80000008)
+        {
+	  cpuid (&unused, &features1, &unused, &unused, 0x80000008, 0);
 
-	  /* cpuid 0x00000010 ebx */
-	  cpuid (&unused, &features1, &unused, &unused, 0x10);
+	  ftcprint (features1, 24, "ssbd");	/* spec store byp dis */
+        }
+      /* cpuid 0x00000010 ebx */
+      if (maxf >= 0x00000010)
+	{
+	  cpuid (&unused, &features2, &unused, &unused, 0x00000010);
 
-	  ftcprint (features1,  3, "mba");	/* memory bandwidth alloc */
+	  ftcprint (features2,  3, "mba");	/* memory bandwidth alloc */
 	}
       /* cpuid 0x80000008 ebx */
       if (maxe >= 0x80000008)
 	{
-	  cpuid (&unused, &features1, &unused, &unused, 0x80000008);
-
+/*	  cpuid (&unused, &features1, &unused, &unused, 0x80000008, 0); */
+/*	  from above */
 	  ftcprint (features1,  6, "mba");	/* memory bandwidth alloc */
 	}
       /* cpuid 0x8000001f eax */
       if (maxe >= 0x8000001f)
 	{
-	  cpuid (&features1, &unused, &unused, &unused, 0x8000001f);
+	  cpuid (&features2, &unused, &unused, &unused, 0x8000001f);
 
-	  ftcprint (features1,  1, "sev");	/* secure encrypted virt */
+	  ftcprint (features2,  1, "sev");	/* secure encrypted virt */
 	}
+      /* cpuid 0x80000008 ebx */
+      if (maxe >= 0x80000008)
+        {
+/*	  cpuid (&unused, &features1, &unused, &unused, 0x80000008, 0); */
+/*	  from above */
+/*	  ftcprint (features1,  0, "clzero");	*//* clzero instruction */
+/*	  ftcprint (features1,  1, "irperf");   *//* instr retired count */
+/*	  ftcprint (features1,  2, "xsaveerptr");*//* save/rest FP err ptrs */
+/*	  ftcprint (features1,  4, "rdpru");	*//* user level rd proc reg */
+/*	  ftcprint (features1,  6, "mba");	*//* memory BW alloc */
+/*	  ftcprint (features1,  9, "wbnoinvd"); *//* wbnoinvd instruction */
+	  ftcprint (features1, 14, "ibrs");	/* ind br restricted spec */
+	  ftcprint (features1, 12, "ibpb");	/* ind br pred barrier */
+	  ftcprint (features1, 15, "stibp");	/* 1 thread ind br pred */
+	  ftcprint (features1, 16, "ibrs_enhanced"); /* IBRS_ALL enhanced IBRS always on */
+/*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
+/*	  ftcprint (features1, 18, "ibrs_pref");*//* IBRS_PREF IBRS preferred */
+/*	  ftcprint (features1, 23, "amd_ppin"); *//* protected proc id no */
+/*	  ftcprint (features1, 24, "ssbd");	*//* spec store byp dis */
+/*	  ftcprint (features1, 25, "virt_ssbd");*//* vir spec store byp dis */
+/*	  ftcprint (features1, 26, "ssb_no");	*//* ssb fixed in hardware */
+        }
 
       /* cpuid 0x00000007 ebx */
-      if (maxf >= 0x07)
+      if (maxf >= 0x00000007)
 	{
-	  cpuid (&unused, &features1, &unused, &unused, 0x07, 0);
+	  cpuid (&unused, &features1, &unused, &unused, 0x00000007, 0);
 
 	  ftcprint (features1,  0, "fsgsbase");	    /* rd/wr fs/gs base */
 	  ftcprint (features1,  1, "tsc_adjust");   /* TSC adjustment MSR 0x3B */
 	  ftcprint (features1,  3, "bmi1");         /* bit manip ext group 1 */
 	  ftcprint (features1,  4, "hle");          /* hardware lock elision */
 	  ftcprint (features1,  5, "avx2");         /* AVX ext instructions */
-/*	  ftcprint (features1,  6, "fpdx"); */	    /* FP data ptr upd on exc */
+/*	  ftcprint (features1,  6, "fpdx"); */	    /* "" FP data ptr upd on exc */
 	  ftcprint (features1,  7, "smep");         /* super mode exec prot */
 	  ftcprint (features1,  8, "bmi2");         /* bit manip ext group 2 */
 	  ftcprint (features1,  9, "erms");         /* enh rep movsb/stosb */
 	  ftcprint (features1, 10, "invpcid");      /* inv proc context id */
 	  ftcprint (features1, 11, "rtm");          /* restricted txnal mem */
 	  ftcprint (features1, 12, "cqm");          /* cache QoS monitoring */
-/*	  ftcprint (features1, 13, "fpcsdsz"); */   /* zero FP cs/ds */
+/*	  ftcprint (features1, 13, "fpcsdsz"); */   /* "" zero FP cs/ds */
 	  ftcprint (features1, 14, "mpx");          /* mem prot ext */
 	  ftcprint (features1, 15, "rdt_a");        /* rsrc dir tech alloc */
 	  ftcprint (features1, 16, "avx512f");      /* vec foundation */
@@ -1242,9 +1439,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
       /* more random feature flags */
       /* cpuid 0x0000000d:1 eax */
-      if (maxf >= 0x0d)
+      if (maxf >= 0x0000000d)
 	{
-	  cpuid (&features1, &unused, &unused, &unused, 0x0d, 1);
+	  cpuid (&features1, &unused, &unused, &unused, 0x0000000d, 1);
 
 	  ftcprint (features1,  0, "xsaveopt");	/* xsaveopt instruction */
 	  ftcprint (features1,  1, "xsavec");   /* xsavec instruction */
@@ -1252,23 +1449,26 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  3, "xsaves");   /* xsaves/xrstors */
 	}
       /* cpuid 0x0000000f edx */
-      if (maxf >= 0x0f)
+      if (maxf >= 0x0000000f)
 	{
-	  cpuid (&unused, &unused, &unused, &features1, 0x0f);
+	  cpuid (&unused, &unused, &unused, &features1, 0x0000000f);
 
 	  ftcprint (features1,  1, "cqm_llc");		/* llc QoS */
 
 	  /* cpuid 0x0000000f:1 edx */
-	  cpuid (&unused, &unused, &unused, &features1, 0x0f, 1);
+	  cpuid (&unused, &unused, &unused, &features1, 0x0000000f, 1);
 
 	  ftcprint (features1,  0, "cqm_occup_llc");	/* llc occup monitor */
 	  ftcprint (features1,  1, "cqm_mbm_total");	/* llc total MBM mon */
 	  ftcprint (features1,  2, "cqm_mbm_local");	/* llc local MBM mon */
 	}
+
+/*	  ftcprint (features1,  6, "split_lock_detect");*//* MSR_TEST_CTRL split lock */
+
       /* cpuid 0x00000007:1 eax */
-      if (maxf >= 0x07)
+      if (maxf >= 0x00000007)
 	{
-	  cpuid (&features1, &unused, &unused, &unused, 0x07, 1);
+	  cpuid (&features1, &unused, &unused, &unused, 0x00000007, 1);
 
 	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
 	}
@@ -1287,7 +1487,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1, 12, "ibpb" ); */	    /* ind br pred barrier */
 /*	  ftcprint (features1, 14, "ibrs" ); */	    /* ind br restricted spec */
 /*	  ftcprint (features1, 15, "stibp"); */	    /* 1 thread ind br pred */
+/*	  ftcprint (features1, 16, "ibrs_enhanced");*//* IBRS_ALL enhanced IBRS always on */
 /*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
+/*	  ftcprint (features1, 18, "ibrs_pref");*//* IBRS_PREF IBRS preferred */
 	  ftcprint (features1, 23, "amd_ppin");     /* protected proc id no */
 /*	  ftcprint (features1, 24, "ssbd"); */	    /* spec store byp dis */
 	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
@@ -1295,9 +1497,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
         }
 
       /* thermal & power cpuid 0x00000006 eax */
-      if (maxf >= 0x06)
+      if (maxf >= 0x00000006)
 	{
-	  cpuid (&features1, &unused, &features2, &unused, 0x06);
+	  cpuid (&features1, &unused, &features2, &unused, 0x00000006);
 
 	  ftcprint (features1,  0, "dtherm");	/* digital thermal sensor */
 	  ftcprint (features1,  1, "ida");      /* Intel dynamic acceleration */
@@ -1332,9 +1534,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
         }
 
       /* Intel cpuid 0x00000007 ecx */
-      if (is_intel && maxf >= 0x07)
+      if (is_intel && maxf >= 0x00000007)
         {
-	  cpuid (&unused, &unused, &features1, &unused, 0x07, 0);
+	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
 
 	  ftcprint (features1,  1, "avx512vbmi");	/* vec bit manip */
 	  ftcprint (features1,  2, "umip");             /* user mode ins prot */
@@ -1367,9 +1569,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
         }
 
       /* Intel cpuid 0x00000007 edx */
-      if (is_intel && maxf >= 0x07)
+      if (is_intel && maxf >= 0x00000007)
         {
-          cpuid (&unused, &unused, &unused, &features1, 0x07, 0);
+          cpuid (&unused, &unused, &unused, &features1, 0x00000007, 0);
 
           ftcprint (features1,  2, "avx512_4vnniw");	   /* vec dot prod dw */
           ftcprint (features1,  3, "avx512_4fmaps");       /* vec 4 FMA single */
@@ -1377,6 +1579,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
           ftcprint (features1,  8, "avx512_vp2intersect"); /* vec intcpt d/q */
           ftcprint (features1, 10, "md_clear");            /* verw clear buf */
           ftcprint (features1, 18, "pconfig");		   /* platform config */
+          ftcprint (features1, 19, "arch_lbr");		   /* last branch records */
           ftcprint (features1, 28, "flush_l1d");	   /* flush l1d cache */
           ftcprint (features1, 29, "arch_capabilities");   /* arch cap MSR */
         }
@@ -1386,6 +1589,16 @@ format_proc_cpuinfo (void *, char *&destbuf)
       bufptr += __small_sprintf (bufptr, "bogomips\t: %d.00\n",
 						bogomips);
 
+      /* cpuid 0x80000006 ebx TLB size */
+      if (maxe >= 0x80000006)
+	{
+	  cpuid( &unused, &features1, &unused, &unused, 0x80000006, 0);
+	  uint32_t tlbsize = ((features1 >> 16) & 0xfff) + (features1 & 0xfff);
+	  if (tlbsize > 0)
+	    bufptr += __small_sprintf (bufptr, "TLB size\t: %d 4K pages\n",
+						tlbsize);
+	}
+
       bufptr += __small_sprintf (bufptr, "clflush size\t: %d\n"
 					 "cache_alignment\t: %d\n",
 				 clflush,
-- 
2.27.0

