Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.139])
 by sourceware.org (Postfix) with ESMTPS id 03A533858D35
 for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2020 17:35:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 03A533858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44]) by shaw.ca with ESMTP
 id srUyj4WwuYYpxsrUzj2ztc; Tue, 07 Jul 2020 11:35:17 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=BqgCfznX7MUA:10 a=UsIZ3BRvCboA:10 a=CCpqsmhAAAAA:8 a=9hJHHtsMjto-fbLiiKYA:9
 a=YocQtCf9LIkA:10 a=ul9cdbp4aOFLsgKbc677:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] format_proc_cpuinfo: add microcode registry lookup values
Date: Tue,  7 Jul 2020 11:33:41 -0600
Message-Id: <20200707173339.4554-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfG7aHfrmK1mfsF+xG0CS46SN1XKxciXdVKGjFOo3dGbSZ2Bl8K8oP5+Vu5wws8nz+pYtJHHtgni0vFD1umF9tdrxQViyLGRpBfZInasprnMsYD30ZAL8
 x58VeHV6veCv5Yfpz1VOBaFaw3y2IHkX/6GgbMwQeZuzaW+vckZWIWMDEH7oF0A7zMlkbC4xB4Gm0kkrPoRdm3XvkVl2a8R5jbBFUmdK2OfzBVb0OafACTAG
 26gDQ3mWxhL4zNGSc174Dw==
X-Spam-Status: No, score=-14.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 07 Jul 2020 17:35:21 -0000

Re: CPU microcode reported wrong in /proc/cpuinfo
    https://sourceware.org/pipermail/cygwin/2020-May/245063.html
earlier Windows releases used different registry values to store microcode
revisions depending on the MSR name being used to get microcode revisions:
add these alternative registry values to the cpuinfo registry value lookup;
iterate thru the registry data until a valid microcode revision is found;
some revision values are in the high bits, so if the low bits are all clear,
shift the revision value down into the low bits
---
 winsup/cygwin/fhandler_proc.cc | 44 +++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index f1bc1c7405..f637dfd8e4 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -692,26 +692,52 @@ format_proc_cpuinfo (void *, char *&destbuf)
       union
         {
 	  LONG uc_len;		/* -max size of buffer before call */
-	  char uc_microcode[16];
-        } uc;
+	  char uc_microcode[16];	/* at least 8 bytes */
+        } uc[4];		/* microcode values changed historically */
 
-      RTL_QUERY_REGISTRY_TABLE tab[3] =
+      RTL_QUERY_REGISTRY_TABLE tab[6] =
         {
 	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
-	    L"~Mhz", &cpu_mhz, REG_NONE, NULL, 0 },
+	    L"~Mhz",		       &cpu_mhz, REG_NONE, NULL, 0 },
 	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
-	    L"Update Revision", &uc, REG_NONE, NULL, 0 },
+	    L"Update Revision",		 &uc[0], REG_NONE, NULL, 0 },
+							/* latest MSR */
+	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
+	    L"Update Signature",	 &uc[1], REG_NONE, NULL, 0 },
+							/* previous MSR */
+	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
+	    L"CurrentPatchLevel",	 &uc[2], REG_NONE, NULL, 0 },
+							/* earlier MSR */
+	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
+	    L"Platform Specific Field1", &uc[3], REG_NONE, NULL, 0 },
+							/* alternative */
 	  { NULL, 0, NULL, NULL, 0, NULL, 0 }
         };
 
-      memset (&uc, 0, sizeof (uc.uc_microcode));
-      uc.uc_len = -16;	/* -max size of microcode buffer */
+      for (size_t uci = 0; uci < sizeof (uc)/sizeof (*uc); ++uci)
+	{
+	  memset (&uc[uci], 0, sizeof (uc[uci]));
+	  uc[uci].uc_len = -(LONG)sizeof (uc[0].uc_microcode);
+							/* neg buffer size */
+	}
+
       RtlQueryRegistryValues (RTL_REGISTRY_ABSOLUTE, cpu_key, tab,
 			      NULL, NULL);
       cpu_mhz = ((cpu_mhz - 1) / 10 + 1) * 10;	/* round up to multiple of 10 */
       DWORD bogomips = cpu_mhz * 2; /* bogomips is double cpu MHz since MMX */
-      long long microcode = 0;	/* at least 8 bytes for AMD */
-      memcpy (&microcode, &uc, sizeof (microcode));
+
+      unsigned long long microcode = 0;	/* needs 8 bytes */
+      for (size_t uci = 0; uci < sizeof (uc)/sizeof (*uc) && !microcode; ++uci)
+	{
+	  /* still neg buffer size => no data */
+	  if (-(LONG)sizeof (uc[uci].uc_microcode) != uc[uci].uc_len)
+	    {
+	      memcpy (&microcode, uc[uci].uc_microcode, sizeof (microcode));
+
+	      if (!(microcode & 0xFFFFFFFFLL))	/* some values in high bits */
+		  microcode <<= 32;		/* shift them down */
+	    }
+	}
 
       bufptr += __small_sprintf (bufptr, "processor\t: %d\n", cpu_number);
       uint32_t maxf, vendor_id[4], unused;
-- 
2.27.0

