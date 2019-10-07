Return-Path: <cygwin-patches-return-9748-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15222 invoked by alias); 7 Oct 2019 16:24:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15062 invoked by uid 89); 7 Oct 2019 16:24:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:24:44 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVoQisFhZ; Mon, 07 Oct 2019 10:24:42 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 05/10] fhandler_proc.cc(format_proc_cpuinfo): add bogomips
Date: Mon, 07 Oct 2019 16:24:00 -0000
Message-Id: <20191007162307.7435-6-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00021.txt.bz2

add bogomips which has been cpu MHz*2 since Pentium MMX

---
 winsup/cygwin/fhandler_proc.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 86c1f6253..8c290d2ff 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -696,6 +696,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
       RtlQueryRegistryValues (RTL_REGISTRY_ABSOLUTE, cpu_key, tab,
 			      NULL, NULL);
       cpu_mhz = ((cpu_mhz - 1) / 10 + 1) * 10;	/* round up to multiple of 10 */
+      DWORD bogomips = cpu_mhz * 2; /* bogomips is double cpu MHz since MMX */
       bufptr += __small_sprintf (bufptr, "processor\t: %d\n", cpu_number);
       uint32_t maxf, vendor_id[4], unused;
 
@@ -1228,7 +1229,8 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
       print ("\n");
 
-      /* TODO: bogomips */
+      bufptr += __small_sprintf (bufptr, "bogomips\t: %d.00\n",
+						bogomips);
 
       bufptr += __small_sprintf (bufptr, "clflush size\t: %d\n"
 					 "cache_alignment\t: %d\n",
-- 
2.21.0
