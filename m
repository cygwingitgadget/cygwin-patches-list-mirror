Return-Path: <cygwin-patches-return-9753-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19535 invoked by alias); 7 Oct 2019 16:25:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19524 invoked by uid 89); 7 Oct 2019 16:25:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=MAC, ibs, cid, multimedia
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:25:43 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVoQisFhk; Mon, 07 Oct 2019 10:24:43 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 07/10] fhandler_proc.cc(format_proc_cpuinfo): use feature test print macro
Date: Mon, 07 Oct 2019 16:25:00 -0000
Message-Id: <20191007162307.7435-8-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00024.txt.bz2

feature test print macro makes feature, bit, and flag text comparison 
and checking easier; 
handle as common former Intel only feature flags also supported on AMD; 
change order and some flag names to agree with current Linux

---
 winsup/cygwin/fhandler_proc.cc | 421 ++++++++++++---------------------
 1 file changed, 153 insertions(+), 268 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 51bbdc43f..fbcec38df 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -609,6 +609,8 @@ format_proc_stat (void *, char *&destbuf)
 }
 
 #define print(x) { bufptr = stpcpy (bufptr, (x)); }
+/* feature test bit position (0-32) and conditional print */
+#define ftcprint(feat,bitno,msg) if ((feat) & (1 << (bitno))) { print (" " msg); }
 
 static inline uint32_t
 get_msb (uint32_t in)
@@ -969,278 +971,170 @@ format_proc_cpuinfo (void *, char *&destbuf)
 				 (features1 & (1 << 0)) ? "yes" : "no",
 				 level);
       print ("flags\t\t:");
-      if (features1 & (1 << 0))
-	print (" fpu");
-      if (features1 & (1 << 1))
-	print (" vme");
-      if (features1 & (1 << 2))
-	print (" de");
-      if (features1 & (1 << 3))
-	print (" pse");
-      if (features1 & (1 << 4))
-	print (" tsc");
-      if (features1 & (1 << 5))
-	print (" msr");
-      if (features1 & (1 << 6))
-	print (" pae");
-      if (features1 & (1 << 7))
-	print (" mce");
-      if (features1 & (1 << 8))
-	print (" cx8");
-      if (features1 & (1 << 9))
-	print (" apic");
-      if (features1 & (1 << 11))
-	print (" sep");
-      if (features1 & (1 << 12))
-	print (" mtrr");
-      if (features1 & (1 << 13))
-	print (" pge");
-      if (features1 & (1 << 14))
-	print (" mca");
-      if (features1 & (1 << 15))
-	print (" cmov");
-      if (features1 & (1 << 16))
-	print (" pat");
-      if (features1 & (1 << 17))
-	print (" pse36");
-      if (features1 & (1 << 18))
-	print (" pn");
-      if (features1 & (1 << 19))
-	print (" clflush");
-      if (is_intel && features1 & (1 << 21))
-	print (" dts");
-      if (is_intel && features1 & (1 << 22))
-	print (" acpi");
-      if (features1 & (1 << 23))
-	print (" mmx");
-      if (features1 & (1 << 24))
-	print (" fxsr");
-      if (features1 & (1 << 25))
-	print (" sse");
-      if (features1 & (1 << 26))
-	print (" sse2");
-      if (is_intel && (features1 & (1 << 27)))
-	print (" ss");
-      if (features1 & (1 << 28))
-	print (" ht");
-      if (is_intel)
-	{
-	  if (features1 & (1 << 29))
-	    print (" tm");
-	  if (features1 & (1 << 30))
-	    print (" ia64");
-	  if (features1 & (1 << 31))
-	    print (" pbe");
-	}
-
+      /* cpuid 0x00000001 edx */
+      ftcprint (features1,  0, "fpu");	/* x87 floating point */
+      ftcprint (features1,  1, "vme");  /* VM enhancements */
+      ftcprint (features1,  2, "de");   /* debugging extensions */
+      ftcprint (features1,  3, "pse");  /* page size extensions */
+      ftcprint (features1,  4, "tsc");  /* rdtsc/p */
+      ftcprint (features1,  5, "msr");  /* rd/wrmsr */
+      ftcprint (features1,  6, "pae");  /* phy addr extensions */
+      ftcprint (features1,  7, "mce");  /* Machine check exception */
+      ftcprint (features1,  8, "cx8");  /* cmpxchg8b */
+      ftcprint (features1,  9, "apic"); /* APIC enabled */
+      ftcprint (features1, 11, "sep");  /* sysenter/sysexit */
+      ftcprint (features1, 12, "mtrr"); /* memory type range registers */
+      ftcprint (features1, 13, "pge");  /* page global extension */
+      ftcprint (features1, 14, "mca");  /* machine check architecture */
+      ftcprint (features1, 15, "cmov"); /* conditional move */
+      ftcprint (features1, 16, "pat");  /* page attribute table */
+      ftcprint (features1, 17, "pse36");/* 36 bit page size extensions */
+      ftcprint (features1, 18, "pn");   /* processor serial number */
+      ftcprint (features1, 19, "clflush"); /* clflush instruction */
+      ftcprint (features1, 21, "dts");  /* debug store */
+      ftcprint (features1, 22, "acpi"); /* ACPI via MSR */
+      ftcprint (features1, 23, "mmx");  /* multimedia extensions */
+      ftcprint (features1, 24, "fxsr"); /* fxsave/fxrstor */
+      ftcprint (features1, 25, "sse");  /* xmm */
+      ftcprint (features1, 26, "sse2"); /* xmm2 */
+      ftcprint (features1, 27, "ss");   /* CPU self snoop */
+      ftcprint (features1, 28, "ht");   /* hyper threading */
+      ftcprint (features1, 29, "tm");   /* acc automatic clock control */
+      ftcprint (features1, 30, "ia64"); /* IA 64 processor */
+      ftcprint (features1, 31, "pbe");  /* pending break enable */
+
+      /* AMD cpuid 0x80000001 edx */
       if (is_amd && maxe >= 0x80000001)
 	{
 	  cpuid (&unused, &unused, &unused, &features1, 0x80000001);
 
-	  if (features1 & (1 << 11))
-	    print (" syscall");
-	  if (features1 & (1 << 19)) /* Huh?  Not in AMD64 specs. */
-	    print (" mp");
-	  if (features1 & (1 << 20))
-	    print (" nx");
-	  if (features1 & (1 << 22))
-	    print (" mmxext");
-	  if (features1 & (1 << 25))
-	    print (" fxsr_opt");
-	  if (features1 & (1 << 26))
-	    print (" pdpe1gb");
-	  if (features1 & (1 << 27))
-	    print (" rdtscp");
-	  if (features1 & (1 << 29))
-	    print (" lm");
-	  if (features1 & (1 << 30)) /* 31th bit is on. */
-	    print (" 3dnowext");
-	  if (features1 & (1 << 31)) /* 32th bit (highest) is on. */
-	    print (" 3dnow");
-	}
-
-      if (features2 & (1 << 0))
-	print (" pni");
-      if (is_intel)
-	{
-	  if (features2 & (1 << 2))
-	    print (" dtes64");
-	  if (features2 & (1 << 3))
-	    print (" monitor");
-	  if (features2 & (1 << 4))
-	    print (" ds_cpl");
-	  if (features2 & (1 << 5))
-	    print (" vmx");
-	  if (features2 & (1 << 6))
-	    print (" smx");
-	  if (features2 & (1 << 7))
-	    print (" est");
-	  if (features2 & (1 << 8))
-	    print (" tm2");
-	  if (features2 & (1 << 9))
-	    print (" ssse3");
-	  if (features2 & (1 << 10))
-	    print (" cid");
-	  if (features2 & (1 << 12))
-	    print (" fma");
-	}
-      if (features2 & (1 << 13))
-	print (" cx16");
-      if (is_intel)
-	{
-	  if (features2 & (1 << 14))
-	    print (" xtpr");
-	  if (features2 & (1 << 15))
-	    print (" pdcm");
-	  if (features2 & (1 << 18))
-	    print (" dca");
-	  if (features2 & (1 << 19))
-	    print (" sse4_1");
-	  if (features2 & (1 << 20))
-	    print (" sse4_2");
-	  if (features2 & (1 << 21))
-	    print (" x2apic");
-	  if (features2 & (1 << 22))
-	    print (" movbe");
-	  if (features2 & (1 << 23))
-	    print (" popcnt");
-	  if (features2 & (1 << 25))
-	    print (" aes");
-	  if (features2 & (1 << 26))
-	    print (" xsave");
-	  if (features2 & (1 << 27))
-	    print (" osxsave");
-	  if (features2 & (1 << 28))
-	    print (" avx");
-	  if (features2 & (1 << 29))
-	    print (" f16c");
-	  if (features2 & (1 << 30))
-	    print (" rdrand");
-	  if (features2 & (1 << 31))
-	    print (" hypervisor");
+	  ftcprint (features1, 11, "syscall");	/* syscall/sysret */
+	  ftcprint (features1, 19, "mp");       /* MP capable */
+	  ftcprint (features1, 20, "nx");       /* no-execute protection */
+	  ftcprint (features1, 22, "mmxext");   /* MMX extensions */
+	  ftcprint (features1, 25, "fxsr_opt"); /* fxsave/fxrstor optims */
+	  ftcprint (features1, 26, "pdpe1gb");  /* GB large pages */
+	  ftcprint (features1, 27, "rdtscp");   /* rdtscp */
+	  ftcprint (features1, 29, "lm");       /* long mode (x86 64) */
+	  ftcprint (features1, 30, "3dnowext"); /* 3DNow extensions */
+	  ftcprint (features1, 31, "3dnow");    /* 3DNow */
 	}
 
+      /* cpuid 0x00000001 ecx */
+      ftcprint (features2,  0, "pni");	    /* xmm3 sse3 */
+      ftcprint (features2,  1, "pclmuldq"); /* pclmulqdq instruction */
+      ftcprint (features2,  2, "dtes64");   /* 64-bit debug store */
+      ftcprint (features2,  3, "monitor");  /* monitor/mwait support */
+      ftcprint (features2,  4, "ds_cpl");   /* CPL-qual debug store */
+      ftcprint (features2,  5, "vmx");      /* hardware virtualization */
+      ftcprint (features2,  6, "smx");      /* safer mode extensions */
+      ftcprint (features2,  7, "est");      /* enhanced speedstep */
+      ftcprint (features2,  8, "tm2");      /* thermal monitor 2 */
+      ftcprint (features2,  9, "ssse3");    /* supplemental sse3 */
+      ftcprint (features2, 10, "cid");      /* context id */
+      ftcprint (features2, 11, "sdbg");     /* silicon debug */
+      ftcprint (features2, 12, "fma");      /* fused multiply add */
+      ftcprint (features2, 13, "cx16");     /* cmpxchg16b instruction */
+      ftcprint (features2, 14, "xtpr");     /* send task priority messages */
+      ftcprint (features2, 15, "pdcm");     /* perf/debug capabilities MSR */
+      ftcprint (features2, 17, "pcid");     /* process context identifiers */
+      ftcprint (features2, 18, "dca");      /* direct cache access */
+      ftcprint (features2, 19, "sse4_1");   /* xmm 4_1 sse 4.1 */
+      ftcprint (features2, 20, "sse4_2");   /* xmm 4_2 sse 4.2 */
+      ftcprint (features2, 21, "x2apic");   /* x2 APIC */
+      ftcprint (features2, 22, "movbe");    /* movbe instruction */
+      ftcprint (features2, 23, "popcnt");   /* popcnt instruction */
+      ftcprint (features2, 25, "aes");	    /* AES instructions */
+      ftcprint (features2, 26, "xsave");    /* xsave/xrstor/xsetbv/xgetbv */
+      ftcprint (features2, 27, "osxsave");  /* not output on Linux */
+      ftcprint (features2, 28, "avx");	    /* advanced vector extensions */
+      ftcprint (features2, 29, "f16c");     /* 16 bit FP conversions */
+      ftcprint (features2, 30, "rdrand");   /* RNG rdrand instruction */
+      ftcprint (features2, 31, "hypervisor"); /* hypervisor guest */
+
+      /* cpuid 0x80000001 ecx */
       if (maxe >= 0x80000001)
 	{
 	  cpuid (&unused, &unused, &features1, &unused, 0x80000001);
 
-	  if (features1 & (1 << 0))
-	    print (" lahf_lm");
-	  if (features1 & (1 << 1))
-	    print (" cmp_legacy");
+	  ftcprint (features1,  0, "lahf_lm");		/* l/sahf long mode */
+	  ftcprint (features1,  1, "cmp_legacy");       /* HT not valid */
 	  if (is_amd)
 	    {
-	      if (features1 & (1 << 2))
-		print (" svm");
-	      if (features1 & (1 << 3))
-		print (" extapic");
-	      if (features1 & (1 << 4))
-		print (" cr8_legacy");
-	      if (features1 & (1 << 5))
-		print (" abm");
-	      if (features1 & (1 << 6))
-		print (" sse4a");
-	      if (features1 & (1 << 7))
-		print (" misalignsse");
-	      if (features1 & (1 << 8))
-		print (" 3dnowprefetch");
-	      if (features1 & (1 << 9))
-		print (" osvw");
+	      ftcprint (features1,  2, "svm");          /* secure VM */
+	      ftcprint (features1,  3, "extapic");      /* ext APIC space */
+	      ftcprint (features1,  4, "cr8_legacy");   /* CR8 32 bit mode */
+	      ftcprint (features1,  5, "abm");          /* adv bit manip lzcnt */
+	      ftcprint (features1,  6, "sse4a");        /* sse 4a */
+	      ftcprint (features1,  7, "misalignsse");  /* misaligned SSE ok */
+	      ftcprint (features1,  8, "3dnowprefetch"); /* 3DNow prefetch */
+	      ftcprint (features1,  9, "osvw");         /* OS vis workaround */
 	    }
-	  if (features1 & (1 << 10))
-	    print (" ibs");
+	  ftcprint (features1, 10, "ibs");	/* instr based sampling */
 	  if (is_amd)
 	    {
-	      if (features1 & (1 << 11))
-		print (" sse5");
-	      if (features1 & (1 << 12))
-		print (" skinit");
-	      if (features1 & (1 << 13))
-		print (" wdt");
-	      if (features1 & (1 << 15))
-		print (" lwp");
-	      if (features1 & (1 << 16))
-		print (" fma4");
-	      if (features1 & (1 << 17))
-		print (" tce");
-	      if (features1 & (1 << 19))
-		print (" nodeid_msr");
-	      if (features1 & (1 << 21))
-		print (" tbm");
-	      if (features1 & (1 << 22))
-		print (" topoext");
-	      if (features1 & (1 << 23))
-		print (" perfctr_core");
-	      if (features1 & (1 << 24))
-		print (" perfctr_nb");
-	      if (features1 & (1 << 28))
-		print (" perfctr_l2");
+	      ftcprint (features1, 11, "xop");		/* sse 5 extended AVX */
+	      ftcprint (features1, 12, "skinit");       /* skinit/stgi */
+	      ftcprint (features1, 13, "wdt");          /* watchdog timer */
+	      ftcprint (features1, 15, "lwp");          /* light weight prof */
+	      ftcprint (features1, 16, "fma4");         /* 4 operand MAC */
+	      ftcprint (features1, 17, "tce");          /* translat cache ext */
+	      ftcprint (features1, 19, "nodeid_msr");   /* nodeid MSR */
+	      ftcprint (features1, 21, "tbm");          /* trailing bit manip */
+	      ftcprint (features1, 22, "topoext");      /* topology ext */
+	      ftcprint (features1, 23, "perfctr_core"); /* core perf ctr ext */
+	      ftcprint (features1, 24, "perfctr_nb");   /* NB perf ctr ext */
+	      ftcprint (features1, 28, "perfctr_llc");  /* ll cache perf ctr */
+	      ftcprint (features1, 29, "mwaitx");       /* monitor/mwaitx ext */
 	    }
 	}
-      if (is_intel) /* features scattered in various CPUID levels. */
+
+      /* features scattered in various CPUID levels. */
+      /* thermal & power cpuid 0x00000006 eax ecx */
+      if (maxf >= 0x06)
 	{
 	  cpuid (&features1, &unused, &features2, &unused, 0x06);
 
-	  if (features1 & (1 << 1))
-	    print (" ida");
-	  if (features1 & (1 << 2))
-	    print (" arat");
-	  if (features2 & (1 << 3))
-	    print (" epb");
-
-	  cpuid (&features2, &unused, &unused, &unused, 0x0d, 1);
-	  if (features2 & (1 << 0))
-	    print (" xsaveopt");
-
-	  if (features1 & (1 << 4))
-	    print (" pln");
-	  if (features1 & (1 << 6))
-	    print (" pts");
-	  if (features1 & (1 << 0))
-	    print (" dtherm");
+	  ftcprint (features2,  3, "epb");	/* energy perf bias */
+
+	  ftcprint (features1,  0, "dtherm");	/* digital thermal sensor */
+	  ftcprint (features1,  1, "ida");      /* Intel dynamic acceleration */
+	  ftcprint (features1,  2, "arat");     /* always running APIC timer */
+	  ftcprint (features1,  4, "pln");      /* power limit notification */
+	  ftcprint (features1,  6, "pts");      /* package thermal status */
 	}
-      if (is_intel) /* Extended feature flags */
+      /* cpuid 0x00000007 ebx */
+      if (maxf >= 0x07)
 	{
 	  cpuid (&unused, &features1, &unused, &unused, 0x07, 0);
 
-	  if (features1 & (1 << 0))
-	    print (" fsgsbase");
-	  if (features1 & (1 << 1))
-	    print (" tsc_adjust");
-	  if (features1 & (1 << 3))
-	    print (" bmi1");
-	  if (features1 & (1 << 4))
-	    print (" hle");
-	  if (features1 & (1 << 5))
-	    print (" avx2");
-	  if (features1 & (1 << 7))
-	    print (" smep");
-	  if (features1 & (1 << 8))
-	    print (" bmi2");
-	  if (features1 & (1 << 9))
-	    print (" erms");
-	  if (features1 & (1 << 10))
-	    print (" invpcid");
-	  if (features1 & (1 << 11))
-	    print (" rtm");
-	  if (features1 & (1 << 14))
-	    print (" mpx");
-	  if (features1 & (1 << 16))
-	    print (" avx512f");
-	  if (features1 & (1 << 18))
-	    print (" rdseed");
-	  if (features1 & (1 << 19))
-	    print (" adx");
-	  if (features1 & (1 << 20))
-	    print (" smap");
-	  if (features1 & (1 << 23))
-	    print (" clflushopt");
-	  if (features1 & (1 << 26))
-	    print (" avx512pf");
-	  if (features1 & (1 << 27))
-	    print (" avx512er");
-	  if (features1 & (1 << 28))
-	    print (" avx512cd");
+	  ftcprint (features1,  0, "fsgsbase");	    /* rd/wr fs/gs base */
+	  ftcprint (features1,  1, "tsc_adjust");   /* TSC adjustment MSR 0x3B */
+	  ftcprint (features1,  3, "bmi1");         /* bit manip ext group 1 */
+	  ftcprint (features1,  4, "hle");          /* hardware lock elision */
+	  ftcprint (features1,  5, "avx2");         /* AVX ext instructions */
+	  ftcprint (features1,  7, "smep");         /* super mode exec prot */
+	  ftcprint (features1,  8, "bmi2");         /* bit manip ext group 2 */
+	  ftcprint (features1,  9, "erms");         /* enh rep movsb/stosb */
+	  ftcprint (features1, 10, "invpcid");      /* inv proc context id */
+	  ftcprint (features1, 11, "rtm");          /* restricted txnal mem */
+	  ftcprint (features1, 14, "mpx");          /* mem prot ext */
+	  ftcprint (features1, 16, "avx512f");      /* vec foundation */
+	  ftcprint (features1, 18, "rdseed");       /* RNG rdseed instruction */
+	  ftcprint (features1, 19, "adx");          /* adcx/adox */
+	  ftcprint (features1, 20, "smap");         /* sec mode access prev */
+	  ftcprint (features1, 23, "clflushopt");   /* cache line flush opt */
+	  ftcprint (features1, 26, "avx512pf");     /* vec prefetch */
+	  ftcprint (features1, 27, "avx512er");     /* vec exp/recip aprx */
+	  ftcprint (features1, 28, "avx512cd");     /* vec conflict detect */
+	}
+
+     /* cpuid 0x0000000d:1 eax */
+      if (maxf >= 0x0d)
+	{
+	  cpuid (&features1, &unused, &unused, &unused, 0x0d, 1);
+
+	  ftcprint (features1,  0, "xsaveopt");	/* xsaveopt instruction */
 	}
 
       print ("\n");
@@ -1269,31 +1163,22 @@ format_proc_cpuinfo (void *, char *&destbuf)
 				     phys, virt);
 	}
 
+      /* cpuid 0x80000007 edx */
       if (maxe >= 0x80000007) /* Advanced power management. */
 	{
 	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
 
 	  print ("power management:");
-	  if (features1 & (1 << 0))
-	    print (" ts");
-	  if (features1 & (1 << 1))
-	    print (" fid");
-	  if (features1 & (1 << 2))
-	    print (" vid");
-	  if (features1 & (1 << 3))
-	    print (" ttp");
-	  if (features1 & (1 << 4))
-	    print (" tm");
-	  if (features1 & (1 << 5))
-	    print (" stc");
-	  if (features1 & (1 << 6))
-	    print (" 100mhzsteps");
-	  if (features1 & (1 << 7))
-	    print (" hwpstate");
-	  if (features1 & (1 << 9))
-	    print (" cpb");
-	  if (features1 & (1 << 10))
-	    print (" eff_freq_ro");
+	  ftcprint (features1,  0, "ts");	    /* temperature sensor */
+	  ftcprint (features1,  1, "fid");          /* frequency id control */
+	  ftcprint (features1,  2, "vid");          /* voltage id control */
+	  ftcprint (features1,  3, "ttp");          /* thermal trip */
+	  ftcprint (features1,  4, "tm");           /* hw thermal control */
+	  ftcprint (features1,  5, "stc");          /* sw thermal control */
+	  ftcprint (features1,  6, "100mhzsteps");  /* 100 MHz mult control */
+	  ftcprint (features1,  7, "hwpstate");     /* hw P state control */
+	  ftcprint (features1,  9, "cpb");          /* core performance boost */
+	  ftcprint (features1, 10, "eff_freq_ro");  /* ro eff freq interface */
 	}
 
       if (orig_affinity_mask != 0)
-- 
2.21.0
