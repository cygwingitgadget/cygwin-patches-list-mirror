Return-Path: <cygwin-patches-return-9744-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14792 invoked by alias); 7 Oct 2019 16:24:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14782 invoked by uid 89); 7 Oct 2019 16:24:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:2363, HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:24:42 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVoPisFhE; Mon, 07 Oct 2019 10:24:41 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 01/10] fhandler_proc.cc(format_proc_cpuinfo): fix cache size
Date: Mon, 07 Oct 2019 16:24:00 -0000
Message-Id: <20191007162307.7435-2-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00015.txt.bz2

fix cache size return code handling and make AMD/Intel code common

---
 winsup/cygwin/fhandler_proc.cc | 45 ++++++++++++++--------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 48476beb8..13cc36858 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -744,6 +744,8 @@ format_proc_cpuinfo (void *, char *&destbuf)
       int cache_size = -1,
 	  clflush = 64,
 	  cache_alignment = 64;
+      long (*get_cpu_cache) (int, uint32_t) = NULL;
+      uint32_t max;
       if (features1 & (1 << 19)) /* CLFSH */
 	clflush = ((extra_info >> 8) & 0xff) << 3;
       if (is_intel && family == 15)
@@ -751,45 +753,34 @@ format_proc_cpuinfo (void *, char *&destbuf)
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
 	{
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
-- 
2.21.0
