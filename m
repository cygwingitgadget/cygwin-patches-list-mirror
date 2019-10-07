Return-Path: <cygwin-patches-return-9750-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15528 invoked by alias); 7 Oct 2019 16:24:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15376 invoked by uid 89); 7 Oct 2019 16:24:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 16:24:44 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id HVnciNyDCUIS2HVoQisFhh; Mon, 07 Oct 2019 10:24:42 -0600
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH v3 06/10] fhandler_proc.cc(format_proc_cpuinfo): add microcode
Date: Mon, 07 Oct 2019 16:24:00 -0000
Message-Id: <20191007162307.7435-7-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00017.txt.bz2

add microcode from Windows registry Update Revision REG_BINARY

---
 winsup/cygwin/fhandler_proc.cc | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 8c290d2ff..51bbdc43f 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -687,16 +687,30 @@ format_proc_cpuinfo (void *, char *&destbuf)
       yield ();
 
       DWORD cpu_mhz = 0;
-      RTL_QUERY_REGISTRY_TABLE tab[2] = {
-	{ NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
-	  L"~Mhz", &cpu_mhz, REG_NONE, NULL, 0 },
-	{ NULL, 0, NULL, NULL, 0, NULL, 0 }
-      };
+      union
+        {
+	  LONG uc_len;		/* -max size of buffer before call */
+	  char uc_microcode[16];
+        } uc;
 
+      RTL_QUERY_REGISTRY_TABLE tab[3] =
+        {
+	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
+	    L"~Mhz", &cpu_mhz, REG_NONE, NULL, 0 },
+	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
+	    L"Update Revision", &uc, REG_NONE, NULL, 0 },
+	  { NULL, 0, NULL, NULL, 0, NULL, 0 }
+        };
+
+      memset (&uc, 0, sizeof (uc.uc_microcode));
+      uc.uc_len = -16;	/* -max size of microcode buffer */
       RtlQueryRegistryValues (RTL_REGISTRY_ABSOLUTE, cpu_key, tab,
 			      NULL, NULL);
       cpu_mhz = ((cpu_mhz - 1) / 10 + 1) * 10;	/* round up to multiple of 10 */
       DWORD bogomips = cpu_mhz * 2; /* bogomips is double cpu MHz since MMX */
+      long long microcode = 0;	/* at least 8 bytes for AMD */
+      memcpy (&microcode, &uc, sizeof (microcode));
+
       bufptr += __small_sprintf (bufptr, "processor\t: %d\n", cpu_number);
       uint32_t maxf, vendor_id[4], unused;
 
@@ -789,11 +803,13 @@ format_proc_cpuinfo (void *, char *&destbuf)
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
-- 
2.21.0
