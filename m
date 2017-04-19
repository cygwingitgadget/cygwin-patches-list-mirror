Return-Path: <cygwin-patches-return-8743-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44051 invoked by alias); 19 Apr 2017 16:01:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44024 invoked by uid 89); 19 Apr 2017 16:01:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=H*m:20170419160602, HTo:U*cygwin-patches
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp1.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 19 Apr 2017 16:01:37 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0836389440;	Wed, 19 Apr 2017 12:01:37 -0400 (EDT)
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0068A8943F;	Wed, 19 Apr 2017 12:01:37 -0400 (EDT)
Received: from localhost.localdomain (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 327088943E;	Wed, 19 Apr 2017 12:01:36 -0400 (EDT)
From: Daniel Santos <daniel.santos@pobox.com>
To: cygwin-patches@cygwin.com
Cc: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH v2] strace: Fix "over-optimization" flaw in strace.
Date: Wed, 19 Apr 2017 16:01:00 -0000
Message-Id: <20170419160602.3952-1-daniel.santos@pobox.com>
In-Reply-To: <20170418100400.GA29220@calimero.vinschen.de>
References: <20170418100400.GA29220@calimero.vinschen.de>
X-Pobox-Relay-ID: 77455EAE-2519-11E7-8775-E680B56B9B0B-06139138!pb-smtp1.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00014.txt.bz2

Recent versions of gcc are optimizing away the TLS buffer allocated in
main, so we need to tell gcc that it's really used.  RtlSecureZeroMemory
accomplishes this while also inlining the memset.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 winsup/utils/strace.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
index beab67b90..ae62cdc5f 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/strace.cc
@@ -1191,7 +1191,7 @@ main (int argc, char **argv)
      registry setting to 0x100000 (TOP_DOWN). */
   char buf[CYGTLS_PADSIZE];
 
-  memset (buf, 0, sizeof (buf));
+  RtlSecureZeroMemory (buf, sizeof (buf));
   exit (main2 (argc, argv));
 }
 
-- 
2.11.0
