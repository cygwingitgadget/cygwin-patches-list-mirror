Return-Path: <cygwin-patches-return-9674-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48134 invoked by alias); 14 Sep 2019 04:58:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48125 invoked by uid 89); 14 Sep 2019 04:58:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 14 Sep 2019 04:58:28 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x8E4wQXW068256;	Fri, 13 Sep 2019 21:58:26 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdBRnYYs; Fri Sep 13 21:58:16 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: fix CPU_SET macro visibility
Date: Sat, 14 Sep 2019 04:58:00 -0000
Message-Id: <20190914045802.693-1-mark@maxrnd.com>
In-Reply-To: <855a9543-6908-42f0-576a-0f161777f715@ssi-schaefer.com>
References: <855a9543-6908-42f0-576a-0f161777f715@ssi-schaefer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00194.txt.bz2

The CPU_SET macros defined in Cygwin's include/sys/cpuset.h must not
be visible in an application's namespace unless _GNU_SOURCE has been
#defined.  Internally this means wrapping them in #if __GNU_VISIBLE.

---
 winsup/cygwin/include/sys/cpuset.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index 2056f6af7..1adf48d54 100644
--- a/winsup/cygwin/include/sys/cpuset.h
+++ b/winsup/cygwin/include/sys/cpuset.h
@@ -26,6 +26,7 @@ typedef struct
   __cpu_mask __bits[__CPU_GROUPMAX];
 } cpu_set_t;
 
+#if __GNU_VISIBLE
 int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
 
 /* These macros alloc or free dynamically-sized cpu sets of size 'num' cpus.
@@ -88,6 +89,8 @@ int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
 #define CPU_XOR(dst, src1, src2)  CPU_XOR_S(sizeof (cpu_set_t), dst, src1, src2)
 #define CPU_EQUAL(src1, src2)     CPU_EQUAL_S(sizeof (cpu_set_t), src1, src2)
 
+#endif /* __GNU_VISIBLE */
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.21.0
