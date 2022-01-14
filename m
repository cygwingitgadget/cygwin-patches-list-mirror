Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst06.hub.nih.gov (nihsmtpxwayst06.hub.nih.gov
 [165.112.13.57])
 by sourceware.org (Postfix) with ESMTPS id 10E523858423
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 22:10:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 10E523858423
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,289,1635220800"; d="scan'208";a="90608941"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 17:10:53 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id A2C61340002;
 Fri, 14 Jan 2022 17:10:52 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/7] Use matching format for NTSTATUS
Date: Fri, 14 Jan 2022 17:10:13 -0500
Message-Id: <20220114221018.43941-3-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
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
X-List-Received-Date: Fri, 14 Jan 2022 22:10:55 -0000

---
 winsup/cygwin/libc/minires-os-if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
index 666a008de..6e17de0b8 100644
--- a/winsup/cygwin/libc/minires-os-if.c
+++ b/winsup/cygwin/libc/minires-os-if.c
@@ -359,7 +359,7 @@ static void get_registry_dns(res_state statp)
   status = RtlCheckRegistryKey (RTL_REGISTRY_SERVICES, keyName);
   if (!NT_SUCCESS (status))
     {
-      DPRINTF (statp->options & RES_DEBUG, "RtlCheckRegistryKey: status %p\n",
+      DPRINTF (statp->options & RES_DEBUG, "RtlCheckRegistryKey: status 0x%08X\n",
 	       status);
       return;
     }
@@ -381,7 +381,7 @@ static void get_registry_dns(res_state statp)
   if (!NT_SUCCESS (status))
     {
       DPRINTF (statp->options & RES_DEBUG,
-	       "RtlQueryRegistryValues: status %p\n", status);
+	       "RtlQueryRegistryValues: status 0x%08X\n", status);
       return;
     }
 
-- 
2.33.0

