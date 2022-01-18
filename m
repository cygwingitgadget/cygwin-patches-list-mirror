Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst05.hub.nih.gov (nihsmtpxwayst05.hub.nih.gov
 [165.112.13.52])
 by sourceware.org (Postfix) with ESMTPS id 5BA523858409
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 22:41:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5BA523858409
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,298,1635220800"; d="scan'208";a="90486807"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail2.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst05.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2022 17:41:19 -0500
Received: from mail1.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail2.ncbi.nlm.nih.gov (Postfix) with ESMTP id E1FDE1A0003;
 Tue, 18 Jan 2022 17:41:18 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Cygwin: resolver: Fix to match response ID with request ID
Date: Tue, 18 Jan 2022 17:39:15 -0500
Message-Id: <20220118223916.43814-2-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220118223916.43814-1-lavr@ncbi.nlm.nih.gov>
References: <20220118223916.43814-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
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

In case when the native OS resolver is used (via os_query) the returned
response ID is always 0.  It should actually match the ID passed in to
res_send() in the DNS request header.  This patch fixes that
---
 winsup/cygwin/libc/minires-os-if.c | 6 +++++-
 winsup/cygwin/libc/minires.c       | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index c4183db9c..8d3178f70 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -189,10 +189,14 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
   DWORD section;
   int len, counts[4] = {0, 0, 0, 0}, debug = statp->options & RES_DEBUG;
   unsigned char * dnptrs[256], * ptr;
+  unsigned short Id = 0;
 
   dnptrs[0] = AnsPtr;
   dnptrs[1] = NULL;
 
+  if (AnsLength >= 2)
+    memcpy(&Id, AnsPtr, 2);
+
   memset(AnsPtr, 0, AnsLength);
 
   if (Class != ns_c_in) {
@@ -294,7 +298,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
 done:
   if (HFIXEDSZ <= AnsLength) {
     ptr = AnsPtr;
-    PUTSHORT(0, ptr); /* Id */
+    PUTSHORT(Id, ptr);
     PUTSHORT((QR << 8) + RA + RD, ptr);
     for (section = 0; section < DIM(counts); section++) {
       PUTSHORT(counts[section], ptr);
diff --git a/winsup/cygwin/libc/minires.c b/winsup/cygwin/libc/minires.c
index fdc6087f5..b540f6a1b 100644
--- a/winsup/cygwin/libc/minires.c
+++ b/winsup/cygwin/libc/minires.c
@@ -450,6 +450,8 @@ int res_nsend( res_state statp, const unsigned char * MsgPtr,
       ptr += len;
       GETSHORT(Type, ptr);
       GETSHORT(Class, ptr);
+      if (AnsLength >= 2)
+          memcpy(AnsPtr, MsgPtr, 2);
       return ((os_query_t *) statp->os_query)(statp, DomName, Class, Type, AnsPtr, AnsLength);
     }
     else {
@@ -709,8 +711,11 @@ int res_nquery( res_state statp, const char * DomName, int Class, int Type,
   statp->res_h_errno = NETDB_SUCCESS;
 
   /* If a hook exists to a native implementation, use it */
-  if (statp->os_query)
+  if (statp->os_query) {
+    if (AnsLength >= 2)
+        memset(AnsPtr, 0/*Id*/, 2);
     return ((os_query_t *) statp->os_query)(statp, DomName, Class, Type, AnsPtr, AnsLength);
+  }
 
   if ((len = res_nmkquery (statp, QUERY, DomName, Class, Type,
 			   0, 0, 0, packet, PACKETSZ)) < 0)
-- 
2.33.0

