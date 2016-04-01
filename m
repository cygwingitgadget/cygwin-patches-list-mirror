Return-Path: <cygwin-patches-return-8543-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77136 invoked by alias); 1 Apr 2016 23:40:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77042 invoked by uid 89); 1 Apr 2016 23:40:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1645, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 01 Apr 2016 23:39:57 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id A4B16486B2	for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2016 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u31NdqV0030275	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 1 Apr 2016 19:39:55 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/4] winsup/utils: port getconf to 64-bit
Date: Fri, 01 Apr 2016 23:40:00 -0000
Message-Id: <1459553988-14384-4-git-send-email-yselkowi@redhat.com>
In-Reply-To: <1459553988-14384-1-git-send-email-yselkowi@redhat.com>
References: <1459551179-9404-1-git-send-email-yselkowi@redhat.com> <1459553988-14384-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q2/txt/msg00018.txt.bz2

The available specifications obviously differ on 32-bit and 64-bit, as
already handled in <sys/features.h>.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/utils/getconf.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/winsup/utils/getconf.c b/winsup/utils/getconf.c
index 8732be1..993aa29 100644
--- a/winsup/utils/getconf.c
+++ b/winsup/utils/getconf.c
@@ -385,22 +385,33 @@ struct spec_variable {
   int valid;
 };
 
+#if __LP64__
+#define ILP32 0
+#define LP64 1
+#else
+#define ILP32 1
+#define LP64 0
+#endif
+
 static const struct spec_variable spec_table[] = {
-  { "POSIX_V7_ILP32_OFF32",	0 },
-  { "POSIX_V7_ILP32_OFFBIG",	1 },
-  { "POSIX_V7_LP64_OFF64",	0 },
-  { "POSIX_V7_LPBIG_OFFBIG",	0 },
-  { "POSIX_V6_ILP32_OFF32",	0 },
-  { "POSIX_V6_ILP32_OFFBIG",	1 },
-  { "POSIX_V6_LP64_OFF64",	0 },
-  { "POSIX_V6_LPBIG_OFFBIG",	0 },
-  { "XBS5_ILP32_OFF32",		0 },
-  { "XBS5_ILP32_OFFBIG",	1 },
-  { "XBS5_LP64_OFF64",		0 },
-  { "XBS5_LPBIG_OFFBIG",	0 },
+  { "POSIX_V7_ILP32_OFF32",	0	},
+  { "POSIX_V7_ILP32_OFFBIG",	ILP32	},
+  { "POSIX_V7_LP64_OFF64",	LP64	},
+  { "POSIX_V7_LPBIG_OFFBIG",	LP64	},
+  { "POSIX_V6_ILP32_OFF32",	0	},
+  { "POSIX_V6_ILP32_OFFBIG",	ILP32	},
+  { "POSIX_V6_LP64_OFF64",	LP64	},
+  { "POSIX_V6_LPBIG_OFFBIG",	LP64	},
+  { "XBS5_ILP32_OFF32",		0	},
+  { "XBS5_ILP32_OFFBIG",	ILP32	},
+  { "XBS5_LP64_OFF64",		LP64	},
+  { "XBS5_LPBIG_OFFBIG",	LP64	},
   { NULL, 0 },
 };
 
+#undef ILP32
+#undef LP64
+
 static int a_flag = 0;		/* list all variables */
 static int v_flag = 0;		/* follow given specification */
 
-- 
2.7.4
