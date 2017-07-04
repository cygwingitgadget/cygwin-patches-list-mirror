Return-Path: <cygwin-patches-return-8799-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80218 invoked by alias); 4 Jul 2017 23:21:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80205 invoked by uid 89); 4 Jul 2017 23:21:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=sk:yselkow, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Jul 2017 23:21:31 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 1F1CE811AC	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2017 23:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 1F1CE811AC
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx03.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=yselkowi@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 1F1CE811AC
Received: from localhost.localdomain (ovpn-120-7.rdu2.redhat.com [10.10.120.7])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 996916FF04	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2017 23:21:29 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fix signal.h with _POSIX_C_SOURCE=1
Date: Tue, 04 Jul 2017 23:21:00 -0000
Message-Id: <20170704232116.18628-1-yselkowi@redhat.com>
X-SW-Source: 2017-q3/txt/msg00001.txt.bz2

struct sigaction is POSIX.1-1990 but siginfo_t, which is used by its
sa_sigaction member, is POSIX.1b-1993.  Therefore it needs to be guarded
as well, and as part of a union, the struct size is protected.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/cygwin/signal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/include/cygwin/signal.h
index 700d45c13..e73874c62 100644
--- a/winsup/cygwin/include/cygwin/signal.h
+++ b/winsup/cygwin/include/cygwin/signal.h
@@ -325,7 +325,9 @@ struct sigaction
   __extension__ union
   {
     _sig_func_ptr sa_handler;  		/* SIG_DFL, SIG_IGN, or pointer to a function */
+#if __POSIX_VISIBLE >= 199309
     void  (*sa_sigaction) ( int, siginfo_t *, void * );
+#endif
   };
   sigset_t sa_mask;
   int sa_flags;
-- 
2.12.3
