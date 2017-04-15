Return-Path: <cygwin-patches-return-8738-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117579 invoked by alias); 15 Apr 2017 22:23:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117557 invoked by uid 89); 15 Apr 2017 22:23:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp1.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 15 Apr 2017 22:23:24 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61DE07F6D7;	Sat, 15 Apr 2017 18:23:24 -0400 (EDT)
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A2887F6D6;	Sat, 15 Apr 2017 18:23:24 -0400 (EDT)
Received: from localhost.localdomain (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BF777F6D5;	Sat, 15 Apr 2017 18:23:23 -0400 (EDT)
From: Daniel Santos <daniel.santos@pobox.com>
To: cygwin-patches@cygwin.com
Cc: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH] strace: Fix crash caused over-optimization
Date: Sat, 15 Apr 2017 22:23:00 -0000
Message-Id: <20170415222750.28067-1-daniel.santos@pobox.com>
X-Pobox-Relay-ID: 236E50DE-222A-11E7-8CCD-E680B56B9B0B-06139138!pb-smtp1.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00009.txt.bz2

Recent versions of gcc are optimizing away the TLS buffer allocated in
main, so we need to tell gcc that it's really used.
---
 winsup/utils/strace.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/utils/strace.cc b/winsup/utils/strace.cc
index beab67b90..1e581b4a4 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/strace.cc
@@ -1192,6 +1192,8 @@ main (int argc, char **argv)
   char buf[CYGTLS_PADSIZE];
 
   memset (buf, 0, sizeof (buf));
+  /* Prevent buf from being optimized away.  */
+  __asm__ __volatile__("" :: "m" (buf));
   exit (main2 (argc, argv));
 }
 
-- 
2.11.0
