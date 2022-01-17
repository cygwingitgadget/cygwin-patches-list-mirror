Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxway6.hub.nih.gov (nihsmtpxway6.hub.nih.gov
 [128.231.90.122])
 by sourceware.org (Postfix) with ESMTPS id 6C7E73858019
 for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022 18:03:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6C7E73858019
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,296,1635220800"; d="scan'208";a="96427568"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxway6.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2022 13:03:36 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod11.be-md.ncbi.nlm.nih.gov
 [130.14.26.81])
 by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id 341E1340003;
 Mon, 17 Jan 2022 13:03:36 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH 5/5] Cygwin: resolver: Added processing of AAAA records
Date: Mon, 17 Jan 2022 13:03:14 -0500
Message-Id: <20220117180314.29064-6-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220117180314.29064-1-lavr@ncbi.nlm.nih.gov>
References: <20220117180314.29064-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
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
X-List-Received-Date: Mon, 17 Jan 2022 18:03:40 -0000

AAAA records returned from Windows resolver were flagged as "No structure" in
debug output because of being processed (although correctly) in the default
catch-all case.  This patch makes the AAAA records properly recognized.
---
 winsup/cygwin/libc/minires-os-if.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index 6b4c5e33e..bb6786f6c 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -69,15 +69,14 @@ static unsigned char * write_record(unsigned char * ptr, PDNS_RECORD rr,
 
   switch(rr->wType) {
   case DNS_TYPE_A:
+  case DNS_TYPE_AAAA:
   {
-    u_int8_t * aptr = (u_int8_t *) & rr->Data.A.IpAddress;
-    if (ptr + 4 <= EndPtr) {
-      ptr[0] = aptr[0];
-      ptr[1] = aptr[1];
-      ptr[2] = aptr[2];
-      ptr[3] = aptr[3];
-    }
-    ptr += 4;
+    u_int8_t * aptr = rr->wType == DNS_TYPE_A
+      ? (u_int8_t *) & rr->Data.A.IpAddress : (u_int8_t *) & rr->Data.AAAA.Ip6Address;
+    int sz = rr->wType == DNS_TYPE_A ? NS_INADDRSZ/*4*/ : NS_IN6ADDRSZ/*16*/;
+    if (ptr + sz <= EndPtr)
+      memcpy(ptr, aptr, sz);
+    ptr += sz;
     break;
   }
   case DNS_TYPE_NS:
-- 
2.33.0

