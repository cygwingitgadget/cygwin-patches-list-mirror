Return-Path: <cygwin-patches-return-9732-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84746 invoked by alias); 4 Oct 2019 20:18:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84729 invoked by uid 89); 4 Oct 2019 20:18:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.2 required=5.0 tests=AWL,BAYES_00,DATE_IN_PAST_06_12,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=timer, tech, voltage, gran
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 04 Oct 2019 20:18:50 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id GU2HixkIisAGkGU2IiqCnN; Fri, 04 Oct 2019 14:18:47 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, flags
Date: Fri, 04 Oct 2019 20:18:00 -0000
Message-Id: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00003.txt.bz2

fix cache size return code handling and make AMD/Intel code common; 
fix cpuid level count as number of non-zero leafs excluding sub-leafs; 
fix AMD physical cores count to be documented nc + 1; 
round cpu MHz to correct Windows and match Linux cpuinfo; 
add microcode from Windows registry Update Revision REG_BINARY; 
add bogomips which has been cpu MHz*2 since Pentium MMX; 
handle as common former Intel only feature flags also supported on AMD; 
add 88 feature flags inc. AVX512 extensions, AES, SHA with 20 cpuid calls; 
commented out flags are mostly used but not currently reported in cpuinfo 
but some may not currently be used by Linux

---
 winsup/cygwin/fhandler_proc.cc | 735 +++++++++++++++++++--------------
 1 file changed, 434 insertions(+), 301 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 48476beb8..6bfc4fd93 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -609,6 +609,8 @@ format_proc_stat (void *, char *&destbuf)
 }
 
 #define print(x) { bufptr = stpcpy (bufptr, (x)); }
+/* feature test bit position (0-32) and conditional print */
+#define ftcprint(feat,bitno,msg) if ((feat) & (1 << (bitno))) { print (" " msg); }
 
 static inline uint32_t
 get_msb (uint32_t in)
@@ -686,15 +688,34 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	 to be rescheduled */
       yield ();
 
-      DWORD cpu_mhz = 0;
-      RTL_QUERY_REGISTRY_TABLE tab[2] = {
+      DWORD cpu_mhz;
+      DWORD bogomips;
+      long long microcode = 0xffffffff;	/* at least 8 bytes for AMD */
+      union {
+	  LONG len;
+	  char uc_microcode[16];
+      } uc;
+
+      cpu_mhz = 0;
+      bogomips = 0;
+      microcode = 0;
+      memset(&uc, 0, sizeof(uc.uc_microcode));
+      uc.len = -16;	/* max length of microcode buffer */
+
+      RTL_QUERY_REGISTRY_TABLE tab[3] = {
 	{ NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
 	  L"~Mhz", &cpu_mhz, REG_NONE, NULL, 0 },
+	{ NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
+	  L"Update Revision", &uc, REG_NONE, NULL, 0 },
 	{ NULL, 0, NULL, NULL, 0, NULL, 0 }
       };
 
       RtlQueryRegistryValues (RTL_REGISTRY_ABSOLUTE, cpu_key, tab,
 			      NULL, NULL);
+      cpu_mhz = ((cpu_mhz - 1)/10 + 1)*10;	/* round up a digit */
+      bogomips = cpu_mhz*2;	/* bogomips is double cpu MHz since MMX */
+      memcpy(&microcode, &uc, sizeof(microcode));
+
       bufptr += __small_sprintf (bufptr, "processor\t: %d\n", cpu_number);
       uint32_t maxf, vendor_id[4], unused;
 
@@ -720,9 +741,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	       stepping		= cpuid_sig   & 0x0000000f,
 	       apic_id		= (extra_info & 0xff000000) >> 24;
       if (family == 15)
-	family += (cpuid_sig >> 20) & 0xff;
+	family += (cpuid_sig >> 20) & 0xff;	/* ext family + family */
       if (family >= 6)
-	model += ((cpuid_sig >> 16) & 0x0f) << 4;
+	model |= ((cpuid_sig >> 16) & 0x0f) << 4; /* ext model<<4 | model */
 
       uint32_t maxe = 0;
       cpuid (&maxe, &unused, &unused, &unused, 0x80000000);
@@ -744,6 +765,8 @@ format_proc_cpuinfo (void *, char *&destbuf)
       int cache_size = -1,
 	  clflush = 64,
 	  cache_alignment = 64;
+      long (*get_cpu_cache) (int, uint32_t) = NULL;
+      uint32_t max;
       if (features1 & (1 << 19)) /* CLFSH */
 	clflush = ((extra_info >> 8) & 0xff) << 3;
       if (is_intel && family == 15)
@@ -751,56 +774,47 @@ format_proc_cpuinfo (void *, char *&destbuf)
       if (is_intel)
 	{
 	  extern long get_cpu_cache_intel (int sysc, uint32_t maxf);
-	  long cs;
-
-	  cs = get_cpu_cache_intel (_SC_LEVEL3_CACHE_SIZE, maxf);
-	  if (cs == -1)
-	    cs = get_cpu_cache_intel (_SC_LEVEL2_CACHE_SIZE, maxf);
-	  if (cs == -1)
-	    {
-	      cs = get_cpu_cache_intel (_SC_LEVEL1_ICACHE_SIZE, maxf);
-	      if (cs != -1)
-		cache_size = cs;
-	      cs = get_cpu_cache_intel (_SC_LEVEL1_DCACHE_SIZE, maxf);
-	      if (cs != -1)
-		cache_size += cs;
-	    }
-	  else
-	    cache_size = cs;
-	  if (cache_size != -1)
-	    cache_size >>= 10;
+	  get_cpu_cache = get_cpu_cache_intel;
+	  max = maxf;	/* Intel uses normal cpuid levels */
 	}
       else if (is_amd)
-	{
+        {
 	  extern long get_cpu_cache_amd (int sysc, uint32_t maxe);
+	  get_cpu_cache = get_cpu_cache_amd;
+	  max = maxe;	/* AMD uses extended cpuid levels */
+	}
+      if (get_cpu_cache)
+	{
 	  long cs;
 
-	  cs = get_cpu_cache_amd (_SC_LEVEL3_CACHE_SIZE, maxe);
-	  if (cs == -1)
-	    cs = get_cpu_cache_amd (_SC_LEVEL2_CACHE_SIZE, maxe);
-	  if (cs == -1)
+	  cs = get_cpu_cache (_SC_LEVEL3_CACHE_SIZE, max);
+	  if (cs <= 0)
+	    cs = get_cpu_cache (_SC_LEVEL2_CACHE_SIZE, max);
+	  if (cs <= 0)
 	    {
-	      cs = get_cpu_cache_amd (_SC_LEVEL1_ICACHE_SIZE, maxe);
-	      if (cs != -1)
+	      cs = get_cpu_cache (_SC_LEVEL1_ICACHE_SIZE, max);
+	      if (cs > 0)
 		cache_size = cs;
-	      cs = get_cpu_cache_amd (_SC_LEVEL1_DCACHE_SIZE, maxe);
-	      if (cs != -1)
+	      cs = get_cpu_cache (_SC_LEVEL1_DCACHE_SIZE, max);
+	      if (cs > 0)
 		cache_size += cs;
 	    }
 	  else
 	    cache_size = cs;
-	  if (cache_size != -1)
+	  if (cache_size > 0)
 	    cache_size >>= 10;
 	}
       bufptr += __small_sprintf (bufptr, "cpu family\t: %d\n"
 					 "model\t\t: %d\n"
 					 "model name\t: %s\n"
 					 "stepping\t: %d\n"
+					 "microcode\t: 0x%x\n"
 					 "cpu MHz\t\t: %d.000\n",
 				 family,
 				 model,
 				 in_buf.s + strspn (in_buf.s, " 	"),
 				 stepping,
+				 microcode,
 				 cpu_mhz);
 
       if (cache_size >= 0)
@@ -894,11 +908,11 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 		  cpuid (&unused, &unused, &core_info, &unused, 0x80000008);
 		  cpuid (&unused, &cus, &unused, &unused, 0x8000001e);
-		  siblings = (core_info & 0xff) + 1;
+		  siblings = (core_info & 0xff) + 1;	/* physical cores */
+		  cpu_cores = siblings;			/* physical cores */
 		  logical_bits = (core_info >> 12) & 0xf;
 		  cus = ((cus >> 8) & 0x3) + 1;
 		  ht_bits = mask_bits (cus);
-		  cpu_cores = siblings >> ht_bits;
 		}
 	      else if (maxe >= 0x80000008)
 		{
@@ -936,291 +950,414 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	}
 
+      /* level is number of non-zero leafs exc. sub-leafs */
+      int level = maxf + 1 + (maxe & 0x7fffffff) + 1;
+
+      for (uint32_t l = maxe; 0x80000001 < l; --l) {
+	  uint32_t a, b, c, d;
+	  cpuid (&a, &b, &c, &d, l);
+	  if (!(a | b | c | d))	--level;
+      }
+
+      for (uint32_t l = maxf; 1 < l; --l) {
+	  uint32_t a, b, c, d;
+	  cpuid (&a, &b, &c, &d, l);
+	  if (!(a | b | c | d))	--level;
+      }
+
       bufptr += __small_sprintf (bufptr, "fpu\t\t: %s\n"
 					 "fpu_exception\t: %s\n"
 					 "cpuid level\t: %d\n"
 					 "wp\t\t: yes\n",
 				 (features1 & (1 << 0)) ? "yes" : "no",
 				 (features1 & (1 << 0)) ? "yes" : "no",
-				 maxf);
+				 level);
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
-
-      if (features2 & (1 << 0))
-	print (" pni");
-      if (is_intel)
+      /* AMD cpuid 0x80000007 edx */
+      if (is_amd && maxe >= 0x80000007)
 	{
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
+	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
+
+	  ftcprint (features1,  8, "constant_tsc");	/* TSC constant rate */
+	  ftcprint (features1,  8, "nonstop_tsc");	/* nonstop C states */
 	}
-      if (features2 & (1 << 13))
-	print (" cx16");
-      if (is_intel)
+      /* cpuid 0x00000006 ecx */
+      if (maxf >= 0x06)
 	{
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
+	  cpuid (&unused, &unused, &features1, &unused, 0x06);
+
+	  ftcprint (features1,  0, "aperfmperf");   /* P state hw coord fb */
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
+      ftcprint (features2, 24, "tsc_deadline_timer"); /* TSC deadline timer */
+      ftcprint (features2, 25, "aes");	    /* AES instructions */
+      ftcprint (features2, 26, "xsave");    /* xsave/xrstor/xsetbv/xgetbv */
+/*    ftcprint (features2, 27, "osxsave"); */ /* not output on Linux */
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
+	      ftcprint (features1, 26, "bpext");        /* data brkpt ext */
+	      ftcprint (features1, 27, "ptsc");         /* perf timestamp ctr */
+	      ftcprint (features1, 28, "perfctr_llc");  /* ll cache perf ctr */
+	      ftcprint (features1, 29, "mwaitx");       /* monitor/mwaitx ext */
 	    }
 	}
-      if (is_intel) /* features scattered in various CPUID levels. */
+
+      /* random feature flags */
+      /* cpuid 0x80000007 edx */
+      if (maxf >= 0x07)
 	{
-	  cpuid (&features1, &unused, &features2, &unused, 0x06);
+	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
+
+	  ftcprint (features1,  9, "cpb");	/* core performance boost */
+	}
+      /* cpuid 0x00000006 ecx */
+      if (maxf >= 0x06)
+	{
+	  cpuid (&unused, &unused, &features1, &unused, 0x06);
+
+	  ftcprint (features1,  3, "epb");	/* energy perf bias */
+	}
+      /* cpuid 0x00000010 ebx */
+      if (maxf >= 0x10)
+	{
+	  cpuid (&unused, &features1, &unused, &unused, 0x10);
 
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
+	  ftcprint (features1,  1, "cat_l3");	/* cache alloc tech l3 */
+	  ftcprint (features1,  2, "cat_l2");	/* cache alloc tech l2 */
+
+	  /* cpuid 0x00000010:1 ecx */
+	  cpuid (&unused, &unused, &features1, &unused, 0x10, 1);
+
+	  ftcprint (features1,  2, "cdp_l3");	/* code data prior l3 */
+	}
+      /* cpuid 0x80000007 edx */
+      if (maxe >= 0x80000007)
+	{
+	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
+
+	  ftcprint (features1,  7, "hw_pstate");	/* hw P state */
+	  ftcprint (features1, 11, "proc_feedback"); /* proc feedback interf */
+	}
+      /* cpuid 0x8000001f eax */
+      if (maxe >= 0x8000001f)
+	{
+	  cpuid (&features1, &unused, &unused, &unused, 0x8000001f);
+
+	  ftcprint (features1,  0, "sme");	/* secure memory encryption */
+	}
+      /* cpuid 0x00000010:2 ecx */
+      if (maxf >= 0x10)
+	{
+	  cpuid (&unused, &unused, &features1, &unused, 0x10, 2);
+
+	  ftcprint (features1,  2, "cdp_l2");	/* code data prior l2 */
+
+	  /* cpuid 0x00000010 ebx */
+	  cpuid (&unused, &features1, &unused, &unused, 0x10);
+
+	  ftcprint (features1,  3, "mba");	/* memory bandwidth alloc */
+	}
+      /* cpuid 0x80000008 ebx */
+      if (maxe >= 0x80000008)
+	{
+	  cpuid (&unused, &features1, &unused, &unused, 0x80000008);
+
+	  ftcprint (features1,  6, "mba");	/* memory bandwidth alloc */
 	}
-      if (is_intel) /* Extended feature flags */
+      /* cpuid 0x8000001f eax */
+      if (maxe >= 0x8000001f)
+	{
+	  cpuid (&features1, &unused, &unused, &unused, 0x8000001f);
+
+	  ftcprint (features1,  1, "sev");	/* secure encrypted virt */
+	}
+
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
+/*	  ftcprint (features1,  6, "fpdx"); */      /* FP data ptr upd on exc */
+	  ftcprint (features1,  7, "smep");         /* super mode exec prot */
+	  ftcprint (features1,  8, "bmi2");         /* bit manip ext group 2 */
+	  ftcprint (features1,  9, "erms");         /* enh rep movsb/stosb */
+	  ftcprint (features1, 10, "invpcid");      /* inv proc context id */
+	  ftcprint (features1, 11, "rtm");          /* restricted txnal mem */
+	  ftcprint (features1, 12, "cqm");          /* cache QoS monitoring */
+/*	  ftcprint (features1, 13, "fpcsdsz"); */   /* zero FP cs/ds */
+	  ftcprint (features1, 14, "mpx");          /* mem prot ext */
+	  ftcprint (features1, 15, "rdt_a");        /* rsrc dir tech alloc */
+	  ftcprint (features1, 16, "avx512f");      /* vec foundation */
+	  ftcprint (features1, 17, "avx512dq");     /* vec dq granular */
+	  ftcprint (features1, 18, "rdseed");       /* RNG rdseed instruction */
+	  ftcprint (features1, 19, "adx");          /* adcx/adox */
+	  ftcprint (features1, 20, "smap");         /* sec mode access prev */
+	  ftcprint (features1, 21, "avx512ifma");   /* vec int FMA */
+	  ftcprint (features1, 23, "clflushopt");   /* cache line flush opt */
+	  ftcprint (features1, 24, "clwb");         /* cache line write back */
+	  ftcprint (features1, 25, "intel_pt");     /* intel processor trace */
+	  ftcprint (features1, 26, "avx512pf");     /* vec prefetch */
+	  ftcprint (features1, 27, "avx512er");     /* vec exp/recip aprx */
+	  ftcprint (features1, 28, "avx512cd");     /* vec conflict detect */
+	  ftcprint (features1, 29, "sha_ni");       /* SHA extensions */
+	  ftcprint (features1, 30, "avx512bw");     /* vec byte/word gran */
+	  ftcprint (features1, 31, "avx512vl");     /* vec vec len ext */
+	}
+
+      /* more random feature flags */
+      /* cpuid 0x0000000d:1 eax */
+      if (maxf >= 0x0d)
+	{
+	  cpuid (&features1, &unused, &unused, &unused, 0x0d, 1);
+
+	  ftcprint (features1,  0, "xsaveopt");	/* xsaveopt instruction */
+	  ftcprint (features1,  1, "xsavec");   /* xsavec instruction */
+	  ftcprint (features1,  2, "xgetbv1");  /* xgetbv ecx 1 */
+	  ftcprint (features1,  3, "xsaves");   /* xsaves/xrstors */
+	}
+      /* cpuid 0x0000000f edx */
+      if (maxf >= 0x0f)
+	{
+	  cpuid (&unused, &unused, &unused, &features1, 0x0f);
+
+	  ftcprint (features1,  1, "cqm_llc");		/* llc QoS */
+
+	  /* cpuid 0x0000000f:1 edx */
+	  cpuid (&unused, &unused, &unused, &features1, 0x0f, 1);
+
+	  ftcprint (features1,  0, "cqm_occup_llc");	/* llc occup monitor */
+	  ftcprint (features1,  1, "cqm_mbm_total");	/* llc total MBM mon */
+	  ftcprint (features1,  2, "cqm_mbm_local");	/* llc local MBM mon */
 	}
+      /* cpuid 0x00000007:1 eax */
+      if (maxf >= 0x07)
+	{
+	  cpuid (&features1, &unused, &unused, &unused, 0x07, 1);
+
+	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
+	}
+
+      /* AMD cpuid 0x80000008 ebx */
+      if (is_amd && maxe >= 0x80000008)
+        {
+	  cpuid (&unused, &features1, &unused, &unused, 0x80000008, 0);
+
+	  ftcprint (features1,  0, "clzero");	    /* clzero instruction */
+	  ftcprint (features1,  1, "irperf");       /* instr retired count */
+	  ftcprint (features1,  2, "xsaveerptr");   /* save/rest FP err ptrs */
+/*	  ftcprint (features1,  6,  "mba" }, */	    /* memory BW alloc */
+	  ftcprint (features1,  9, "wbnoinvd");     /* wbnoinvd instruction */
+/*	  ftcprint (features1, 12, "ibpb" ); */	    /* ind br pred barrier */
+/*	  ftcprint (features1, 14, "ibrs" ); */	    /* ind br restricted spec */
+/*	  ftcprint (features1, 15, "stibp"); */	    /* 1 thread ind br pred */
+/*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
+/*	  ftcprint (features1, 24, "ssbd"); */	    /* spec store byp dis */
+	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
+/*	  ftcprint (features1, 26, "ssb_no"); */    /* ssb fixed in hardware */
+        }
+
+      /* thermal & power cpuid 0x00000006 eax */
+      if (maxf >= 0x06)
+	{
+	  cpuid (&features1, &unused, &features2, &unused, 0x06);
+
+	  ftcprint (features1,  0, "dtherm");	/* digital thermal sensor */
+	  ftcprint (features1,  1, "ida");      /* Intel dynamic acceleration */
+	  ftcprint (features1,  2, "arat");     /* always running APIC timer */
+	  ftcprint (features1,  4, "pln");      /* power limit notification */
+	  ftcprint (features1,  6, "pts");      /* package thermal status */
+	  ftcprint (features1,  7, "hwp");      /* hardware P states */
+	  ftcprint (features1,  8, "hwp_notify"); /* HWP notification */
+	  ftcprint (features1,  9, "hwp_act_window"); /* HWP activity window */
+	  ftcprint (features1, 10, "hwp_epp");  /* HWP energy perf pref */
+	  ftcprint (features1, 11, "hwp_pkg_req"); /* HWP package level req */
+	}
+
+      /* AMD SVM cpuid 0x8000000a edx */
+      if (is_amd && maxe >= 0x8000000a)
+        {
+	  cpuid (&unused, &unused, &unused, &features1, 0x8000000a, 0);
+
+	  ftcprint (features1,  0, "npt");		/* nested paging */
+	  ftcprint (features1,  1, "lbrv");             /* lbr virtualization */
+	  ftcprint (features1,  2, "svm_lock");         /* SVM locking MSR */
+	  ftcprint (features1,  3, "nrip_save");        /* SVM next rip save */
+	  ftcprint (features1,  4, "tsc_scale");        /* TSC rate control */
+	  ftcprint (features1,  5, "vmcb_clean");       /* VMCB clean bits */
+	  ftcprint (features1,  6, "flushbyasid");      /* flush by ASID */
+	  ftcprint (features1,  7, "decode_assists");   /* decode assists */
+	  ftcprint (features1, 10, "pausefilter");      /* filt pause intrcpt */
+	  ftcprint (features1, 12, "pfthreshold");      /* pause filt thresh */
+	  ftcprint (features1, 13, "avic");             /* virt int control */
+	  ftcprint (features1, 15, "v_vmsave_vmload");  /* virt vmsave vmload */
+	  ftcprint (features1, 16, "vgif");             /* virt glb int flag */
+        }
+
+      /* Intel cpuid 0x00000007 ecx */
+      if (is_intel && maxf >= 0x07)
+        {
+	  cpuid (&unused, &unused, &features1, &unused, 0x07, 0);
+
+	  ftcprint (features1,  1, "avx512vbmi");	/* vec bit manip */
+	  ftcprint (features1,  2, "umip");             /* user mode ins prot */
+	  ftcprint (features1,  3, "pku");              /* prot key userspace */
+	  ftcprint (features1,  4, "ospke");            /* OS prot keys en */
+	  ftcprint (features1,  5, "waitpkg");          /* umon/umwait/tpause */
+	  ftcprint (features1,  6, "avx512_vbmi2");     /* vec bit manip 2 */
+	  ftcprint (features1,  8, "gfni");             /* Galois field instr */
+	  ftcprint (features1,  9, "vaes");             /* vector AES */
+	  ftcprint (features1, 10, "vpclmulqdq");       /* nc mul dbl quad */
+	  ftcprint (features1, 11, "avx512_vnni");      /* vec neural net */
+	  ftcprint (features1, 12, "avx512_bitalg");    /* vpopcnt/b/w vpshuf */
+	  ftcprint (features1, 13, "tme");              /* total mem encrypt */
+	  ftcprint (features1, 14, "avx512_vpopcntdq"); /* vec popcnt dw/qw */
+	  ftcprint (features1, 16, "la57");             /* 5 level paging */
+	  ftcprint (features1, 22, "rdpid");            /* rdpid instruction */
+	  ftcprint (features1, 25, "cldemote");         /* cldemote instr */
+	  ftcprint (features1, 27, "movdiri");          /* movdiri instr */
+	  ftcprint (features1, 28, "movdir64b");        /* movdir64b instr */
+        }
+
+      /* AMD MCA cpuid 0x80000007 ebx */
+      if (is_amd && maxe >= 0x80000007)
+        {
+          cpuid (&unused, &features1, &unused, &unused, 0x80000007, 0);
+
+          ftcprint (features1,  0, "overflow_recov");	/* MCA oflow recovery */
+          ftcprint (features1,  1, "succor");           /* uncor err recovery */
+          ftcprint (features1,  3, "smca");             /* scalable MCA */
+        }
+
+      /* Intel cpuid 0x00000007 edx */
+      if (is_intel && maxf >= 0x07)
+        {
+          cpuid (&unused, &unused, &unused, &features1, 0x07, 0);
+
+          ftcprint (features1,  2, "avx512_4vnniw");	   /* vec dot prod dw */
+          ftcprint (features1,  3, "avx512_4fmaps");       /* vec 4 FMA single */
+          ftcprint (features1,  8, "avx512_vp2intersect"); /* vec intcpt d/q */
+          ftcprint (features1, 10, "md_clear");            /* verw clear buf */
+          ftcprint (features1, 18, "pconfig");		   /* platform config */
+          ftcprint (features1, 28, "flush_l1d");	   /* flush l1d cache */
+          ftcprint (features1, 29, "arch_capabilities");   /* arch cap MSR */
+        }
 
       print ("\n");
 
-      /* TODO: bogomips */
+      bufptr += __small_sprintf (bufptr, "bogomips\t: %d.00\n",
+						bogomips);
 
       bufptr += __small_sprintf (bufptr, "clflush size\t: %d\n"
 					 "cache_alignment\t: %d\n",
@@ -1243,31 +1380,27 @@ format_proc_cpuinfo (void *, char *&destbuf)
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
+/*	  ftcprint (features1,  8, "invariant_tsc");*/ /* TSC invariant */
+	  ftcprint (features1,  9, "cpb");          /* core performance boost */
+	  ftcprint (features1, 10, "eff_freq_ro");  /* ro eff freq interface */
+/*	  ftcprint (features1, 11, "proc_feedback");*/ /* proc feedback if */
+/*	  ftcprint (features1, 12, "acc_power");    */ /* core power reporting */
+/*	  ftcprint (features1, 13, "connstby");	    */ /* connected standby */
+/*	  ftcprint (features1, 14, "rapl");	    */ /* running average power limit */
 	}
 
       if (orig_affinity_mask != 0)
-- 
2.21.0

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
