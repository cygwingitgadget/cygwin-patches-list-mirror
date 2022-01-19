Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst05.hub.nih.gov (nihsmtpxwayst05.hub.nih.gov
 [165.112.13.52])
 by sourceware.org (Postfix) with ESMTPS id 7A77A3858409
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 00:08:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7A77A3858409
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,298,1635220800"; d="scan'208";a="90495286"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail2.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst05.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2022 19:08:11 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail2.ncbi.nlm.nih.gov (Postfix) with ESMTP id 0DE9C1A0002;
 Tue, 18 Jan 2022 19:08:11 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: resolver: A few fixes for cygwin_query(), part 2
Date: Tue, 18 Jan 2022 19:07:55 -0500
Message-Id: <20220119000755.1324-1-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FROM_GOV_DKIM_AU,
 GIT_PATCH_0, KAM_NUMSUBJECT, SPF_PASS, TXREP,
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
X-List-Received-Date: Wed, 19 Jan 2022 00:08:13 -0000

Make sure Windows ResultSet is free'd when dn_comp failed internally
---
 winsup/cygwin/libc/minires-os-if.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index 5da1c0c55..c6fde776a 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -246,8 +246,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
       statp->res_h_errno = NO_RECOVERY;
       break;
     }
-    len = -1;
-    goto done;
+    return -1;
   }
 
   ptr = AnsPtr + HFIXEDSZ; /* Skip header */
@@ -293,10 +292,12 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
     rr = rr->pNext;
   }
 
-  DnsFree(pQueryResultsSet, DnsFreeRecordList);
-
   len = ptr - AnsPtr;
+
 done:
+
+  DnsFree(pQueryResultsSet, DnsFreeRecordList);
+
   if (HFIXEDSZ <= AnsLength) {
     ptr = AnsPtr;
     PUTSHORT(Id, ptr);
-- 
2.33.0

