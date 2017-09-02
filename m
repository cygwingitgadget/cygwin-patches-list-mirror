Return-Path: <cygwin-patches-return-8847-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64520 invoked by alias); 1 Sep 2017 22:27:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64242 invoked by uid 89); 1 Sep 2017 22:27:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=sk:yselkow, para, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Sep 2017 22:27:29 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 24E3B4E4C2	for <cygwin-patches@cygwin.com>; Fri,  1 Sep 2017 22:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 24E3B4E4C2
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx09.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=yselkowi@redhat.com
Received: from localhost.localdomain (ovpn-120-61.rdu2.redhat.com [10.10.120.61])	by smtp.corp.redhat.com (Postfix) with ESMTPS id B9FB75FCA2	for <cygwin-patches@cygwin.com>; Fri,  1 Sep 2017 22:27:27 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: Document crypt_r
Date: Sat, 02 Sep 2017 19:02:00 -0000
Message-Id: <20170901222718.19076-1-yselkowi@redhat.com>
X-SW-Source: 2017-q3/txt/msg00049.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/doc/posix.xml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 6e96272b7..c99e003ba 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1286,6 +1286,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     clog10
     clog10f
     clog10l
+    crypt_r			(available in external "crypt" library)
     dladdr			(see chapter "Implementation Notes")
     dremf
     dup3
-- 
2.14.1
