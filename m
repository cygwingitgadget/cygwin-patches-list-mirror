Return-Path: <cygwin-patches-return-9745-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15108 invoked by alias); 7 Oct 2019 16:24:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14999 invoked by uid 89); 7 Oct 2019 16:24:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:24:43 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVoQisFhI; Mon, 07 Oct 2019 10:24:42 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 02/10] fhandler_proc.cc(format_proc_cpuinfo): fix cpuid level count
Date: Mon, 07 Oct 2019 16:24:00 -0000
Message-Id: <20191007162307.7435-3-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00016.txt.bz2

fix cpuid level count as number of non-zero leafs excluding sub-leafs

---
 winsup/cygwin/fhandler_proc.cc | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 13cc36858..78518baf9 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -927,13 +927,30 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	}
 
+      /* level is number of non-zero leafs exc. sub-leafs */
+      int level = maxf + 1 + (maxe & 0x7fffffff) + 1;
+
+      for (uint32_t l = maxe; 0x80000001 < l; --l)
+        {
+	  uint32_t a, b, c, d;
+	  cpuid (&a, &b, &c, &d, l);
+	  if (!(a | b | c | d))	--level;
+        }
+
+      for (uint32_t l = maxf; 1 < l; --l)
+        {
+	  uint32_t a, b, c, d;
+	  cpuid (&a, &b, &c, &d, l);
+	  if (!(a | b | c | d))	--level;
+        }
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
       if (features1 & (1 << 0))
 	print (" fpu");
-- 
2.21.0
