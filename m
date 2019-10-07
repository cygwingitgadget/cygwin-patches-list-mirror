Return-Path: <cygwin-patches-return-9749-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15239 invoked by alias); 7 Oct 2019 16:24:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15096 invoked by uid 89); 7 Oct 2019 16:24:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=connected, HX-Languages-Length:4611, timer, dis
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:24:43 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVoRisFhq; Mon, 07 Oct 2019 10:24:43 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 09/10] fhandler_proc.cc(format_proc_cpuinfo): comment flags not reported
Date: Mon, 07 Oct 2019 16:24:00 -0000
Message-Id: <20191007162307.7435-10-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00022.txt.bz2

comment out flags not reported by Linux in cpuinfo,
although some flags may not be used at all by Linux

---
 winsup/cygwin/fhandler_proc.cc | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 13338230d..c924cf2e0 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1062,7 +1062,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
       ftcprint (features2, 24, "tsc_deadline_timer"); /* TSC deadline timer */
       ftcprint (features2, 25, "aes");	    /* AES instructions */
       ftcprint (features2, 26, "xsave");    /* xsave/xrstor/xsetbv/xgetbv */
-      ftcprint (features2, 27, "osxsave");  /* not output on Linux */
+/*    ftcprint (features2, 27, "osxsave"); */ /* not output on Linux */
       ftcprint (features2, 28, "avx");	    /* advanced vector extensions */
       ftcprint (features2, 29, "f16c");     /* 16 bit FP conversions */
       ftcprint (features2, 30, "rdrand");   /* RNG rdrand instruction */
@@ -1187,14 +1187,14 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  3, "bmi1");         /* bit manip ext group 1 */
 	  ftcprint (features1,  4, "hle");          /* hardware lock elision */
 	  ftcprint (features1,  5, "avx2");         /* AVX ext instructions */
-	  ftcprint (features1,  6, "fpdx");	    /* FP data ptr upd on exc */
+/*	  ftcprint (features1,  6, "fpdx"); */	    /* FP data ptr upd on exc */
 	  ftcprint (features1,  7, "smep");         /* super mode exec prot */
 	  ftcprint (features1,  8, "bmi2");         /* bit manip ext group 2 */
 	  ftcprint (features1,  9, "erms");         /* enh rep movsb/stosb */
 	  ftcprint (features1, 10, "invpcid");      /* inv proc context id */
 	  ftcprint (features1, 11, "rtm");          /* restricted txnal mem */
 	  ftcprint (features1, 12, "cqm");          /* cache QoS monitoring */
-	  ftcprint (features1, 13, "fpcsdsz");	    /* zero FP cs/ds */
+/*	  ftcprint (features1, 13, "fpcsdsz"); */   /* zero FP cs/ds */
 	  ftcprint (features1, 14, "mpx");          /* mem prot ext */
 	  ftcprint (features1, 15, "rdt_a");        /* rsrc dir tech alloc */
 	  ftcprint (features1, 16, "avx512f");      /* vec foundation */
@@ -1255,15 +1255,15 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  0, "clzero");	    /* clzero instruction */
 	  ftcprint (features1,  1, "irperf");       /* instr retired count */
 	  ftcprint (features1,  2, "xsaveerptr");   /* save/rest FP err ptrs */
-	  ftcprint (features1,  6, "mba"); 	    /* memory BW alloc */
+/*	  ftcprint (features1,  6, "mba"); */	    /* memory BW alloc */
 	  ftcprint (features1,  9, "wbnoinvd");     /* wbnoinvd instruction */
-	  ftcprint (features1, 12, "ibpb" );	    /* ind br pred barrier */
-	  ftcprint (features1, 14, "ibrs" );	    /* ind br restricted spec */
-	  ftcprint (features1, 15, "stibp");	    /* 1 thread ind br pred */
-	  ftcprint (features1, 17, "stibp_always_on"); /* stibp always on */
-	  ftcprint (features1, 24, "ssbd");	    /* spec store byp dis */
+/*	  ftcprint (features1, 12, "ibpb" ); */	    /* ind br pred barrier */
+/*	  ftcprint (features1, 14, "ibrs" ); */	    /* ind br restricted spec */
+/*	  ftcprint (features1, 15, "stibp"); */	    /* 1 thread ind br pred */
+/*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
+/*	  ftcprint (features1, 24, "ssbd"); */	    /* spec store byp dis */
 	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
-	  ftcprint (features1, 26, "ssb_no");	    /* ssb fixed in hardware */
+/*	  ftcprint (features1, 26, "ssb_no"); */    /* ssb fixed in hardware */
         }
 
       /* thermal & power cpuid 0x00000006 eax */
@@ -1392,13 +1392,13 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  5, "stc");          /* sw thermal control */
 	  ftcprint (features1,  6, "100mhzsteps");  /* 100 MHz mult control */
 	  ftcprint (features1,  7, "hwpstate");     /* hw P state control */
-	  ftcprint (features1,  8, "invariant_tsc"); /* TSC invariant */
+/*	  ftcprint (features1,  8, "invariant_tsc"); */ /* TSC invariant */
 	  ftcprint (features1,  9, "cpb");          /* core performance boost */
 	  ftcprint (features1, 10, "eff_freq_ro");  /* ro eff freq interface */
-	  ftcprint (features1, 11, "proc_feedback"); /* proc feedback if */
-	  ftcprint (features1, 12, "acc_power");    /* core power reporting */
-	  ftcprint (features1, 13, "connstby");	    /* connected standby */
-	  ftcprint (features1, 14, "rapl");	    /* running average power limit */
+/*	  ftcprint (features1, 11, "proc_feedback"); */ /* proc feedback if */
+/*	  ftcprint (features1, 12, "acc_power"); */ /* core power reporting */
+/*	  ftcprint (features1, 13, "connstby"); */  /* connected standby */
+/*	  ftcprint (features1, 14, "rapl"); */	    /* running average power limit */
 	}
 
       if (orig_affinity_mask != 0)
-- 
2.21.0
