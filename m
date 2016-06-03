Return-Path: <cygwin-patches-return-8567-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113378 invoked by alias); 3 Jun 2016 08:39:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113359 invoked by uid 89); 3 Jun 2016 08:39:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=sk:yselkow, winsup, Hx-languages-length:685, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 03 Jun 2016 08:39:41 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 9BA413B71B	for <cygwin-patches@cygwin.com>; Fri,  3 Jun 2016 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-39.rdu2.redhat.com [10.10.116.39])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u538dc4Q015004	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 3 Jun 2016 04:39:39 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: include sys/types.h in sys/xattr.h
Date: Fri, 03 Jun 2016 08:39:00 -0000
Message-Id: <20160603083932.17328-1-yselkowi@redhat.com>
X-SW-Source: 2016-q2/txt/msg00042.txt.bz2

Using libattr's <xattr/xattr.h> requires consumers to explicitly include
<sys/types.h> first, but glibc's header in sys/ already contains the include.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/sys/xattr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/include/sys/xattr.h b/winsup/cygwin/include/sys/xattr.h
index 1f32392..902bb86 100644
--- a/winsup/cygwin/include/sys/xattr.h
+++ b/winsup/cygwin/include/sys/xattr.h
@@ -13,6 +13,7 @@ details. */
 #ifndef _SYS_XATTR_H
 #define _SYS_XATTR_H
 
+#include <sys/types.h>
 #include <attr/xattr.h>
 
 #endif /* _SYS_XATTR_H */
-- 
2.8.3
