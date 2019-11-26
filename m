Return-Path: <cygwin-patches-return-9858-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100680 invoked by alias); 26 Nov 2019 15:36:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100671 invoked by uid 89); 26 Nov 2019 15:36:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 26 Nov 2019 15:36:34 +0000
Received: from Brian.Inglis@Shaw.ca ([24.64.172.44])	by shaw.ca with ESMTP	id ZctCi9gf6nCigZctEiZs2C; Tue, 26 Nov 2019 08:36:32 -0700
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH] newlib/libc/include/sys/features.h: update __STDC_ISO_10646__
Date: Tue, 26 Nov 2019 15:36:00 -0000
Message-Id: <20191126153441.63022-1-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191125084633.GC13501@calimero.vinschen.de>
References: <20191125084633.GC13501@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00129.txt.bz2

newlib wide char conversion functions were updated to
Unicode 11 on 2019-01-12
update standard symbol __STDC_ISO_10646__ to
Unicode 11 release date 2018-06-05 for Cygwin
---
 newlib/libc/include/sys/features.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/newlib/libc/include/sys/features.h b/newlib/libc/include/sys/features.h
index f28dd071b..218807178 100644
--- a/newlib/libc/include/sys/features.h
+++ b/newlib/libc/include/sys/features.h
@@ -521,9 +521,13 @@ extern "C" {
 /* #define _XOPEN_UNIX				    -1 */
 #endif /* __XSI_VISIBLE */
 
-/* The value corresponds to UNICODE version 5.2, which is the current
-   state of newlib's wide char conversion functions. */
-#define __STDC_ISO_10646__ 200910L
+/*
+ * newlib's wide char conversion functions were updated on
+ *	2019-01-12
+ * to UNICODE version:
+ *	11.0.0 released 2018-06-05
+ */
+#define __STDC_ISO_10646__ 201806L
 
 #endif /* __CYGWIN__ */
 
-- 
2.21.0
