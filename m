Return-Path: <cygwin-patches-return-8862-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14897 invoked by alias); 17 Sep 2017 02:05:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11739 invoked by uid 89); 17 Sep 2017 02:04:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:675, COMMON_CFLAGS, common_cflags, crt0o
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 17 Sep 2017 02:04:40 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v8H24bC7024149;	Sat, 16 Sep 2017 22:04:38 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v8H24LfP025218	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Sat, 16 Sep 2017 22:04:37 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 12/12] cygwin: Remove workaround for GCC 6 null pointer check warnings
Date: Sun, 17 Sep 2017 02:05:00 -0000
Message-Id: <20170917020420.10488-12-kbrown@cornell.edu>
In-Reply-To: <20170917020420.10488-1-kbrown@cornell.edu>
References: <20170917020420.10488-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00063.txt.bz2

---
 winsup/cygwin/Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 98727c019..add1de0e9 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -73,7 +73,7 @@ CRT0:=$(cygwin_build)/crt0.o
 #
 MT_SAFE:=@MT_SAFE@
 CCEXTRA=
-COMMON_CFLAGS=-MMD ${$(*F)_CFLAGS} -Werror -fno-delete-null-pointer-checks -fmerge-constants -ftracer $(CCEXTRA)
+COMMON_CFLAGS=-MMD ${$(*F)_CFLAGS} -Werror -fmerge-constants -ftracer $(CCEXTRA)
 ifeq ($(target_cpu),x86_64)
 COMMON_CFLAGS+=-mcmodel=small
 endif
-- 
2.14.1
