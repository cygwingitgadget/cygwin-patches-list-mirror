Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net
 (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
 by sourceware.org (Postfix) with ESMTPS id AF45F3858416
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 06:04:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AF45F3858416
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id 7JtrnkLuryr5H7WkUnS3n2; Wed, 12 Jan 2022 06:04:42 +0000
Received: from BWINGLISD.shawcable.net. ([68.147.0.90]) by cmsmtp with ESMTP
 id 7WkTnqVmgNat47WkTnzoSS; Wed, 12 Jan 2022 06:04:42 +0000
X-Authority-Analysis: v=2.4 cv=e9cV9Il/ c=1 sm=1 tr=0 ts=61de6f7a
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=q1C59PPjy2xrb2DZ_kAA:9 a=QEXdDO2ut3YA:10
 a=FOUth4ti_gXw_67V6NYA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux 5.16 Gobble
 Gobble flags
Date: Tue, 11 Jan 2022 23:04:31 -0700
Message-Id: <20220112060431.7956-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.34.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDbeSiGn/qXWTe7B7Cz2JSZxbQK0zl1c/g6OyOhi15Rbp9HBKWx81FqnLuaKyd+51IT6kaqm03zBveyOAuI7Q5KymkP/pK9a1wFp8q/L2onVsV/9TDKG
 4PSQMT8UFcH6zWvtvls0D+0dg1CnV3md2OViRcPIxgPUkhFLMQXveNZGaeGWtqrTg4f0PCeFK7r16OLTygPmscGs+gY7FkUb29yf7ISdoJ4gx1nIytLabOLi
 4oo7gpxvijxzfSymF721PhIA4Y6Gl5vM7l7/IORwjz8=
X-Spam-Status: No, score=-1169.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_BARRACUDACENTRAL,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 12 Jan 2022 06:04:43 -0000

This is a multi-part message in MIME format.
--------------2.34.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


0x00000007:1 Intel Advanced Matrix eXtensions:
		 EAX:22 amx_bf16 Brain Float 16 dot product
		 EAX:24 amx_tile Tile matrix multiply
		 EAX:25 amx_int8 Int 8 byte dot product
0x80000008:0 AMD EBX:27 cppc      Collaborative Processor Performance Control
---
 winsup/cygwin/fhandler_proc.cc | 4 ++++
 1 file changed, 4 insertions(+)


--------------2.34.1
Content-Type: text/x-patch; name="0001-fhandler_proc.cc-format_proc_cpuinfo-add-Linux-5.16-Gobble-Gobble-flags.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-fhandler_proc.cc-format_proc_cpuinfo-add-Linux-5.16-Gobble-Gobble-flags.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 6ec6f8bc47d9..d51f171a3a41 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1456,6 +1456,9 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	  ftcprint (features1,  4, "avx_vnni");	    /* vex enc NN vec */
 	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
+	  ftcprint (features1, 22, "amx_bf16");	    /* Advanced Matrix eXtensions Brain Float 16 dot product */
+	  ftcprint (features1, 24, "amx_tile");	    /* Advanced Matrix eXtensions Tile matrix multiply */
+	  ftcprint (features1, 25, "amx_int8");	    /* Advanced Matrix eXtensions Int 8 byte dot product */
 	}
 
       /* AMD cpuid 0x80000008 ebx */
@@ -1479,6 +1482,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1, 24, "ssbd"); */	    /* spec store byp dis */
 	  ftcprint (features1, 25, "virt_ssbd");    /* vir spec store byp dis */
 /*	  ftcprint (features1, 26, "ssb_no"); */    /* ssb fixed in hardware */
+	  ftcprint (features1, 27, "cppc");	    /* collab proc perf ctl */
         }
 
       /* thermal & power cpuid 0x00000006 eax */

--------------2.34.1--


