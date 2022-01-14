Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihsmtpxwayst06.hub.nih.gov (nihsmtpxwayst06.hub.nih.gov
 [165.112.13.57])
 by sourceware.org (Postfix) with ESMTPS id D528D3858407
 for <cygwin-patches@cygwin.com>; Fri, 14 Jan 2022 22:10:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D528D3858407
X-SBRS-Extended: Low
X-IronPortListener: non-ces-out
X-IronPortListener: non-ces-out
X-IronPort-AV: E=Sophos;i="5.88,289,1635220800"; d="scan'208";a="90608945"
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail1.ncbi.nlm.nih.gov)
 ([128.231.90.73])
 by nihsmtpxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2022 17:10:53 -0500
Received: from mail2.ncbi.nlm.nih.gov (vhod23.be-md.ncbi.nlm.nih.gov
 [130.14.26.86])
 by mail1.ncbi.nlm.nih.gov (Postfix) with ESMTP id 00FBD340002;
 Fri, 14 Jan 2022 17:10:52 -0500 (EST)
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/7] Process options forward (not backwards)
Date: Fri, 14 Jan 2022 17:10:15 -0500
Message-Id: <20220114221018.43941-5-lavr@ncbi.nlm.nih.gov>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
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
X-List-Received-Date: Fri, 14 Jan 2022 22:10:56 -0000

---
 winsup/cygwin/libc/minires.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/libc/minires.c b/winsup/cygwin/libc/minires.c
index 58c0438d3..2a77098b8 100644
--- a/winsup/cygwin/libc/minires.c
+++ b/winsup/cygwin/libc/minires.c
@@ -86,12 +86,12 @@ Read options
 
 
 ***********************************************************************/
-static void get_options(res_state statp, int i, char **words)
+static void get_options(res_state statp, int n, char **words)
 {
   char *ptr;
-  int value;
+  int i, value;
 
-  while (i-- > 0) {
+  for (i = 0;  i < n;  ++i) {
     if (!strcasecmp("debug", words[i])) {
       statp->options |= RES_DEBUG;
       DPRINTF(statp->options & RES_DEBUG, "%s: 1\n", words[i]);
@@ -208,8 +208,10 @@ static void get_resolv(res_state statp)
 	}
       }
       /* Options line */
-      else if (!strncasecmp("options", words[0], sizes[0]))
+      else if (!strncasecmp("options", words[0], sizes[0])) {
 	get_options(statp, i - 1, &words[1]);
+	debug = statp->options & RES_DEBUG;
+      }
     }
   }
   fclose(fd);
-- 
2.33.0

