Return-Path: <cygwin-patches-return-9752-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15874 invoked by alias); 7 Oct 2019 16:24:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15798 invoked by uid 89); 7 Oct 2019 16:24:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=gran, nonstop, timer, thermal
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:24:44 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVoRisFho; Mon, 07 Oct 2019 10:24:43 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 08/10] fhandler_proc.cc(format_proc_cpuinfo): add feature flags
Date: Mon, 07 Oct 2019 16:24:00 -0000
Message-Id: <20191007162307.7435-9-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00018.txt.bz2

add 99 feature flags inc. AVX512 extensions, AES, SHA with 20 cpuid calls

---
 winsup/cygwin/fhandler_proc.cc | 238 +++++++++++++++++++++++++++++++--
 1 file changed, 229 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index fbcec38df..13338230d 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1019,6 +1019,21 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 30, "3dnowext"); /* 3DNow extensions */
 	  ftcprint (features1, 31, "3dnow");    /* 3DNow */
 	}
+      /* AMD cpuid 0x80000007 edx */
+      if (is_amd && maxe >= 0x80000007)
+	{
+	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
+
+	  ftcprint (features1,  8, "constant_tsc");	/* TSC constant rate */
+	  ftcprint (features1,  8, "nonstop_tsc");	/* nonstop C states */
+	}
+      /* cpuid 0x00000006 ecx */
+      if (maxf >= 0x06)
+	{
+	  cpuid (&unused, &unused, &features1, &unused, 0x06);
+
+	  ftcprint (features1,  0, "aperfmperf");   /* P state hw coord fb */
+	}
 
       /* cpuid 0x00000001 ecx */
       ftcprint (features2,  0, "pni");	    /* xmm3 sse3 */
@@ -1044,6 +1059,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
       ftcprint (features2, 21, "x2apic");   /* x2 APIC */
       ftcprint (features2, 22, "movbe");    /* movbe instruction */
       ftcprint (features2, 23, "popcnt");   /* popcnt instruction */
+      ftcprint (features2, 24, "tsc_deadline_timer"); /* TSC deadline timer */
       ftcprint (features2, 25, "aes");	    /* AES instructions */
       ftcprint (features2, 26, "xsave");    /* xsave/xrstor/xsetbv/xgetbv */
       ftcprint (features2, 27, "osxsave");  /* not output on Linux */
@@ -1084,25 +1100,83 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	      ftcprint (features1, 22, "topoext");      /* topology ext */
 	      ftcprint (features1, 23, "perfctr_core"); /* core perf ctr ext */
 	      ftcprint (features1, 24, "perfctr_nb");   /* NB perf ctr ext */
+	      ftcprint (features1, 26, "bpext");        /* data brkpt ext */
+	      ftcprint (features1, 27, "ptsc");         /* perf timestamp ctr */
 	      ftcprint (features1, 28, "perfctr_llc");  /* ll cache perf ctr */
 	      ftcprint (features1, 29, "mwaitx");       /* monitor/mwaitx ext */
 	    }
 	}
 
       /* features scattered in various CPUID levels. */
-      /* thermal & power cpuid 0x00000006 eax ecx */
+      /* cpuid 0x80000007 edx */
+      if (maxf >= 0x07)
+	{
+	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
+
+	  ftcprint (features1,  9, "cpb");	/* core performance boost */
+	}
+      /* cpuid 0x00000006 ecx */
       if (maxf >= 0x06)
 	{
-	  cpuid (&features1, &unused, &features2, &unused, 0x06);
+	  cpuid (&unused, &unused, &features1, &unused, 0x06);
 
-	  ftcprint (features2,  3, "epb");	/* energy perf bias */
+	  ftcprint (features1,  3, "epb");	/* energy perf bias */
+	}
+      /* cpuid 0x00000010 ebx */
+      if (maxf >= 0x10)
+	{
+	  cpuid (&unused, &features1, &unused, &unused, 0x10);
 
-	  ftcprint (features1,  0, "dtherm");	/* digital thermal sensor */
-	  ftcprint (features1,  1, "ida");      /* Intel dynamic acceleration */
-	  ftcprint (features1,  2, "arat");     /* always running APIC timer */
-	  ftcprint (features1,  4, "pln");      /* power limit notification */
-	  ftcprint (features1,  6, "pts");      /* package thermal status */
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
+      /* cpuid 0x8000001f eax */
+      if (maxe >= 0x8000001f)
+	{
+	  cpuid (&features1, &unused, &unused, &unused, 0x8000001f);
+
+	  ftcprint (features1,  1, "sev");	/* secure encrypted virt */
+	}
+
       /* cpuid 0x00000007 ebx */
       if (maxf >= 0x07)
 	{
@@ -1113,30 +1187,171 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  3, "bmi1");         /* bit manip ext group 1 */
 	  ftcprint (features1,  4, "hle");          /* hardware lock elision */
 	  ftcprint (features1,  5, "avx2");         /* AVX ext instructions */
+	  ftcprint (features1,  6, "fpdx");	    /* FP data ptr upd on exc */
 	  ftcprint (features1,  7, "smep");         /* super mode exec prot */
 	  ftcprint (features1,  8, "bmi2");         /* bit manip ext group 2 */
 	  ftcprint (features1,  9, "erms");         /* enh rep movsb/stosb */
 	  ftcprint (features1, 10, "invpcid");      /* inv proc context id */
 	  ftcprint (features1, 11, "rtm");          /* restricted txnal mem */
+	  ftcprint (features1, 12, "cqm");          /* cache QoS monitoring */
+	  ftcprint (features1, 13, "fpcsdsz");	    /* zero FP cs/ds */
 	  ftcprint (features1, 14, "mpx");          /* mem prot ext */
+	  ftcprint (features1, 15, "rdt_a");        /* rsrc dir tech alloc */
 	  ftcprint (features1, 16, "avx512f");      /* vec foundation */
+	  ftcprint (features1, 17, "avx512dq");     /* vec dq granular */
 	  ftcprint (features1, 18, "rdseed");       /* RNG rdseed instruction */
 	  ftcprint (features1, 19, "adx");          /* adcx/adox */
 	  ftcprint (features1, 20, "smap");         /* sec mode access prev */
+	  ftcprint (features1, 21, "avx512ifma");   /* vec int FMA */
 	  ftcprint (features1, 23, "clflushopt");   /* cache line flush opt */
+	  ftcprint (features1, 24, "clwb");         /* cache line write back */
+	  ftcprint (features1, 25, "intel_pt");     /* intel processor trace */
 	  ftcprint (features1, 26, "avx512pf");     /* vec prefetch */
 	  ftcprint (features1, 27, "avx512er");     /* vec exp/recip aprx */
 	  ftcprint (features1, 28, "avx512cd");     /* vec conflict detect */
+	  ftcprint (features1, 29, "sha_ni");       /* SHA extensions */
+	  ftcprint (features1, 30, "avx512bw");     /* vec byte/word gran */
+	  ftcprint (features1, 31, "avx512vl");     /* vec vec len ext */
 	}
 
-     /* cpuid 0x0000000d:1 eax */
+      /* more random feature flags */
+      /* cpuid 0x0000000d:1 eax */
       if (maxf >= 0x0d)
 	{
 	  cpuid (&features1, &unused, &unused, &unused, 0x0d, 1);
 
 	  ftcprint (features1,  0, "xsaveopt");	/* xsaveopt instruction */
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
+	}
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
+	  ftcprint (features1,  6, "mba"); 	    /* memory BW alloc */
+	  ftcprint (features1,  9, "wbnoinvd");     /* wbnoinvd instruction */
+	  ftcprint (features1, 12, "ibpb" );	    /* ind br pred barrier */
+	  ftcprint (features1, 14, "ibrs" );	    /* ind br restricted spec */
+	  ftcprint (features1, 15, "stibp");	    /* 1 thread ind br pred */
+	  ftcprint (features1, 17, "stibp_always_on"); /* stibp always on */
+	  ftcprint (features1, 24, "ssbd");	    /* spec store byp dis */
+	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
+	  ftcprint (features1, 26, "ssb_no");	    /* ssb fixed in hardware */
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
 	}
 
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
+
       print ("\n");
 
       bufptr += __small_sprintf (bufptr, "bogomips\t: %d.00\n",
@@ -1177,8 +1392,13 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  5, "stc");          /* sw thermal control */
 	  ftcprint (features1,  6, "100mhzsteps");  /* 100 MHz mult control */
 	  ftcprint (features1,  7, "hwpstate");     /* hw P state control */
+	  ftcprint (features1,  8, "invariant_tsc"); /* TSC invariant */
 	  ftcprint (features1,  9, "cpb");          /* core performance boost */
 	  ftcprint (features1, 10, "eff_freq_ro");  /* ro eff freq interface */
+	  ftcprint (features1, 11, "proc_feedback"); /* proc feedback if */
+	  ftcprint (features1, 12, "acc_power");    /* core power reporting */
+	  ftcprint (features1, 13, "connstby");	    /* connected standby */
+	  ftcprint (features1, 14, "rapl");	    /* running average power limit */
 	}
 
       if (orig_affinity_mask != 0)
-- 
2.21.0
