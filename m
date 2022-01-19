Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxway6.hub.nih.gov (nihsmtpxway6.hub.nih.gov
 [128.231.90.122])
 by sourceware.org (Postfix) with ESMTPS id EE60A3857C65
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 13:13:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EE60A3857C65
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,299,1635220800"; d="scan'208";a="96658940"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail2.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxway6.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2022 08:13:21 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod21.be-md.ncbi.nlm.nih.gov
 [130.14.26.82])
 by mail2.ncbi.nlm.nih.gov (Postfix) with ESMTP id BE0B51A0002;
 Wed, 19 Jan 2022 08:13:20 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: resolver: cygwin_query() skip response header on
 internal error
Date: Wed, 19 Jan 2022 08:12:55 -0500
Message-Id: <20220119131255.27821-1-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
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
X-List-Received-Date: Wed, 19 Jan 2022 13:13:32 -0000

- When dn_comp() failed internally there is no longer any need to
fill the response header since it's now all cleared upon entry
---
 winsup/cygwin/libc/minires-os-if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index c6fde776a..4e8e9cf21 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -266,6 +266,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
       if ((len = dn_comp(rr->pName, ptr, AnsLength - 4,
 			 dnptrs, &dnptrs[DIM(dnptrs) - 1])) < 0) {
 	statp->res_h_errno = NETDB_INTERNAL;  /* dn_comp sets errno */
+	AnsLength = 0;
 	len = -1;
 	goto done;
       }
@@ -283,7 +284,7 @@ static int cygwin_query(res_state statp, const char * DomName, int Class, int Ty
       DPRINTF(debug, "Unexpected section order for \"%s\" %d\n", DomName, Type);
       continue;
     }
-    section =  rr->Flags.DW & 0x3;
+    section = rr->Flags.DW & 0x3;
 
     ptr = write_record(ptr, rr, AnsPtr + AnsLength, dnptrs,
 		       &dnptrs[DIM(dnptrs) - 1], debug);
-- 
2.33.0

