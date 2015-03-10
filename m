Return-Path: <cygwin-patches-return-8061-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51848 invoked by alias); 10 Mar 2015 17:16:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51829 invoked by uid 89); 10 Mar 2015 17:16:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,SPF_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 10 Mar 2015 17:16:20 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2AHGHEo003804	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2015 13:16:18 -0400
Received: from localhost.localdomain ([10.10.116.23])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2AGQWXa026948	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2015 12:26:33 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin: fix __x86_64__ conditional in stdint.h
Date: Tue, 10 Mar 2015 17:16:00 -0000
Message-Id: <1426004792-11916-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2015-q1/txt/msg00016.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/ChangeLog        | 4 ++++
 winsup/cygwin/include/stdint.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/ChangeLog b/winsup/cygwin/ChangeLog
index 550490a..cd2dbb9 100644
--- a/winsup/cygwin/ChangeLog
+++ b/winsup/cygwin/ChangeLog
@@ -1,3 +1,7 @@
+2015-03-10  Yaakov Selkowitz  <yselkowitz@cygwin.com>
+
+	* include/stdint.h: Fix __x86_64__ conditional.
+
 2015-03-05  Corinna Vinschen  <corinna@vinschen.de>
 
 	* tty.h (tty::set_master_ctl_closed): Rename from set_master_closed.
diff --git a/winsup/cygwin/include/stdint.h b/winsup/cygwin/include/stdint.h
index b670884..94b6b76 100644
--- a/winsup/cygwin/include/stdint.h
+++ b/winsup/cygwin/include/stdint.h
@@ -114,7 +114,7 @@ typedef unsigned long long uintmax_t;
 #if !defined (__cplusplus) || defined (__STDC_LIMIT_MACROS) \
     || defined (__INSIDE_CYGWIN__)
 
-#if __x86_64__
+#ifdef __x86_64__
 # define __I64(n) n ## L
 # define __U64(n) n ## UL
 #else
-- 
2.1.4
