Return-Path: <SRS0=6VUL=4P=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 0DDA9386FF15
	for <cygwin-patches@cygwin.com>; Sat, 17 Dec 2022 21:44:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0DDA9386FF15
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id 6defpwWDac9C46eytpwEow; Sat, 17 Dec 2022 21:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1671313471; bh=NERhLUVJoomnGDmgnAFf+i68RCo//fTrPqPQzrmHEzg=;
	h=From:To:Subject:Date;
	b=QWGbXo9ZrhtmpOR33mWNSx6rx3bjVLO7lh2YpFBum5qZKJkCbIz7HjjL+ula9eAox
	 Qt0eXc503M7Qlen+luDOPNv90NYr5kzydKpxzh9KfUeDN4POf7N/Wc7WAooSjIvfKI
	 5MwuQl2hQTIxrWU+VDLOddpCwlUnvpMkYIzzo9viz7hbio8SJ6XbEtGP2FCyL48Cl/
	 smHdz7pnJP9BuqjuP5QUVBgeTL49gEQE8EAVMiit+buP9NrkkEGHDMhhqY/vgl8Jpd
	 qhLBTay9zUyMFOSOSfEnBwz+JEwcpfTO+qUNSQBA2j8ZC87xYkMcv0rivAd7OGNlhR
	 t7c92J+MZn2xQ==
Received: from localhost.localdomain ([184.64.124.72])
	by cmsmtp with ESMTP
	id 6eytpfvrVyAOe6eytpT7t6; Sat, 17 Dec 2022 21:44:31 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=639e383f
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=GGNMLsTMJl_t6llyz44A:9 a=QEXdDO2ut3YA:10
 a=k4UfgQKOEQEA:10 a=RdwwBK8X-F3Ms-17ZgIA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): add Linux 6.1 cpuinfo
Date: Sat, 17 Dec 2022 14:44:14 -0700
Message-Id: <20221217214414.29573-1-Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.38.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCTAcsItWTjmL/omDyMpRsu4pUWJSMaHDYLqSMNpC5oBOpZ6tqJtFEgJLI8YZ/gb80qRMZ852MggJclhMi8VYRI3K66gHOuh9Cu6kabT+pIH1NRyf/Kx
 aRq/O0nvH68cZxLeLRXkfF8LuWj7Jan+qFHFndRYdpIvb0vPOdrBEvxTyTT7auGvUUO4mO9qw3DcTWKwj5IfS5fS8B6Ss5sWKeP804FOKuGNNgFb6yc8M5aZ
 J/So6MRNHwttWAPQYckiMg==
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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


