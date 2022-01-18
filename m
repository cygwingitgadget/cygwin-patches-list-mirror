Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst05.hub.nih.gov (nihsmtpxwayst05.hub.nih.gov
 [165.112.13.52])
 by sourceware.org (Postfix) with ESMTPS id 6311B3858D39
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 21:34:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6311B3858D39
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,298,1635220800"; d="scan'208";a="90473571"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail2.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst05.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2022 16:34:45 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail2.ncbi.nlm.nih.gov (Postfix) with ESMTP id DF0811A0002;
 Tue, 18 Jan 2022 16:34:44 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: resolver: A few fixes for cygwin_query()
Date: Tue, 18 Jan 2022 16:34:34 -0500
Message-Id: <20220118213434.35894-1-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
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
X-List-Received-Date: Tue, 18 Jan 2022 21:34:46 -0000

- Make sure the answer buffer is properly cleared so there is no trailing
garbage when the response does not fit entirely in;
- Make sure an internal decomp failure gets reported correctly (w/return code -1);
- Make sure that the buffer is not overrun when filling out the header.
---
 winsup/cygwin/libc/minires-os-if.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index bb6786f6c..c4183db9c 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -193,6 +193,8 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
   dnptrs[0] = AnsPtr;
   dnptrs[1] = NULL;
 
+  memset(AnsPtr, 0, AnsLength);
+
   if (Class != ns_c_in) {
     errno = ENOSYS;
     statp->res_h_errno = NETDB_INTERNAL;
@@ -214,7 +216,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
     switch (res) {
     case ERROR_INVALID_NAME:
       errno = EINVAL;
-      statp->res_h_errno = NETDB_INTERNAL;;
+      statp->res_h_errno = NETDB_INTERNAL;
       break;
     case ERROR_TIMEOUT:
       statp->res_h_errno = TRY_AGAIN;
@@ -259,8 +261,9 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
       /* No question. Adopt the first name as the name in the question */
       if ((len = dn_comp(rr->pName, ptr, AnsLength - 4,
 			 dnptrs, &dnptrs[DIM(dnptrs) - 1])) < 0) {
-	ptr = NULL;
-	break;
+	statp->res_h_errno = NETDB_INTERNAL;  /* dn_comp sets errno */
+	len = -1;
+	goto done;
       }
       ptr += len;
       PUTSHORT(Type, ptr);
@@ -289,11 +292,13 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
 
   len = ptr - AnsPtr;
 done:
-  ptr = AnsPtr;
-  PUTSHORT(0, ptr); /* Id */
-  PUTSHORT((QR << 8) + RA + RD, ptr);
-  for (section = 0; section < DIM(counts); section++) {
-    PUTSHORT(counts[section], ptr);
+  if (HFIXEDSZ <= AnsLength) {
+    ptr = AnsPtr;
+    PUTSHORT(0, ptr); /* Id */
+    PUTSHORT((QR << 8) + RA + RD, ptr);
+    for (section = 0; section < DIM(counts); section++) {
+      PUTSHORT(counts[section], ptr);
+    }
   }
   return len;
 }
-- 
2.33.0

