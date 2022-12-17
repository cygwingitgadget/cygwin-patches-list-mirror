Return-Path: <SRS0=6VUL=4P=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id C84A1385B188
	for <cygwin-patches@cygwin.com>; Sat, 17 Dec 2022 21:14:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C84A1385B188
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id 6deepwWDGc9C46eW3pwBDC; Sat, 17 Dec 2022 21:14:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1671311683; bh=NERhLUVJoomnGDmgnAFf+i68RCo//fTrPqPQzrmHEzg=;
	h=From:To:Subject:Date;
	b=SnGpp2hVM+QqgrZMmckMvvwc2ufSj/42gtHxe21+n0T3IOkQsINUnfuGxQ21o0Jw+
	 KkxOcPsU0opEtoUAuLFhs5JbyZd/3Pgf6Kld3KgxWSAnOIECxwByrLfTMRHpGzqH1A
	 URTOQrImka/xAD5RI68ruZ/JfGaRqZH3TiKsXu5sewkR6iLrWzkxYyf+E5K28Mlf1e
	 oez15ZYwVqtpGuaN4BDC+1EvUOoKNo6p3VLNCS6aPW+fjGhZzLnf5BHnVKr4hPEChw
	 IwdE8pqlfRbiH1AW/m9eLo02ec60/uCcfmbfwWC2YQ6aPiT97ka+FEAwjqXwbiz4OI
	 rgtoaLEcIz8Wg==
Received: from localhost.localdomain ([184.64.124.72])
	by cmsmtp with ESMTP
	id 6eW2pfoHQyAOe6eW2pT5IL; Sat, 17 Dec 2022 21:14:43 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=639e3143
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=GGNMLsTMJl_t6llyz44A:9 a=QEXdDO2ut3YA:10
 a=k4UfgQKOEQEA:10 a=RdwwBK8X-F3Ms-17ZgIA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): add Linux 6.1 cpuinfo
Date: Sat, 17 Dec 2022 14:14:27 -0700
Message-Id: <20221217211427.29453-1-Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.38.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLz6uJEXjgJE922EdOhy6xUGrTnUuLaGuo1o3pu7y7G/5PyNd/AR4/xcrBa5XCm+H03Joi7EIrIvQGyraivdZbRanpr+q9fm5YD+xkxUER5UEx68KQ7z
 Svybv3vHGme6lLf+KklcsVYeUq5Q80LcElAIVVXBNrFBlp3KaiRhH8xP7CKrgcTqJ1GhOMLZS4Q55zSq10FIM3tEt4q/T9Hhxwgi1QrveKEWu7+0ZEL3qAmt
 L6EdpHFCPJjQlRtTHRL0JA==
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------2.38.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Intel 0x00000007:1 EAX:26 lam	Linear Address Masking (& recent entries)
---
 winsup/cygwin/fhandler/proc.cc | 4 ++++
 1 file changed, 4 insertions(+)


--------------2.38.1
Content-Type: text/x-patch; name="0001-fhandler-proc.cc-format_proc_cpuinfo-add-Linux-6.1-cpuinfo.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-fhandler-proc.cc-format_proc_cpuinfo-add-Linux-6.1-cpuinfo.patch"

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index 6643d1f1aa0f..75a6a85517cd 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1484,6 +1484,10 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	  ftcprint (features1,  4, "avx_vnni");	    /* vex enc NN vec */
 	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
+/*	  ftcprint (features1,  7, "cmpccxadd"); */ /* CMPccXADD instructions */
+/*	  ftcprint (features1, 21, "amx_fp16");	 */ /* AMX fp16 Support */
+/*	  ftcprint (features1, 23, "avx_ifma");	 */ /* Support for VPMADD52[H,L]UQ */
+	  ftcprint (features1, 26, "lam");	    /* Linear Address Masking */
 	}
 
       /* AMD cpuid 0x80000008 ebx */

--------------2.38.1--


