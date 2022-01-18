Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst05.hub.nih.gov (nihsmtpxwayst05.hub.nih.gov
 [165.112.13.52])
 by sourceware.org (Postfix) with ESMTPS id 7F4993858D39
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 22:41:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7F4993858D39
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,298,1635220800"; d="scan'208";a="90486810"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail2.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst05.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2022 17:41:19 -0500
Received: from mail1.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail2.ncbi.nlm.nih.gov (Postfix) with ESMTP id 140641A0004;
 Tue, 18 Jan 2022 17:41:19 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: resolver: Targets in SRV DNS responses may not be
 compressed
Date: Tue, 18 Jan 2022 17:39:16 -0500
Message-Id: <20220118223916.43814-3-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220118223916.43814-1-lavr@ncbi.nlm.nih.gov>
References: <20220118223916.43814-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FROM_GOV_DKIM_AU,
 GIT_PATCH_0, SPF_PASS, TXREP,
 T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 18 Jan 2022 22:41:22 -0000

RFC2782 clearly says so yet it's a common misconception to perform the
compression in the violation of the standard.  This patch fixes that
---
 winsup/cygwin/libc/minires-os-if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index 8d3178f70..5da1c0c55 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -159,6 +159,7 @@ static unsigned char * write_record(unsigned char * ptr, PDNS_RECORD rr,
       PUTSHORT(rr->Data.SRV.wWeight, ptr);
       PUTSHORT(rr->Data.SRV.wPort, ptr);
     }
+    dnptrs = 0;  /* compression not allowed */
     PUTDOMAIN(rr->Data.SRV.pNameTarget, ptr);
     break;
   default:
-- 
2.33.0

