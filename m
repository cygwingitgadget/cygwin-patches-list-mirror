Return-Path: <cygwin-patches-return-9875-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115457 invoked by alias); 23 Dec 2019 06:46:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115448 invoked by uid 89); 23 Dec 2019 06:46:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=our, HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 23 Dec 2019 06:46:07 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id xBN6k6T1077183;	Sun, 22 Dec 2019 22:46:06 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdTzDZR6; Sun Dec 22 22:46:01 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Add missing Linux #define of CPU_SETSIZE
Date: Mon, 23 Dec 2019 06:46:00 -0000
Message-Id: <20191223064554.23791-1-mark@maxrnd.com>
In-Reply-To: <a34db430-a10e-9049-3d70-c5512b96ceb7@gmail.com>
References: <a34db430-a10e-9049-3d70-c5512b96ceb7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00146.txt.bz2

Though our implementation of cpu sets doesn't need it, software from
Linux environments expects this definition to be present.  It's
documented on the Linux CPU_SET(3) man page but was left out due to
oversight.

Addresses https://cygwin.com/ml/cygwin/2019-12/msg00248.html

---
 winsup/cygwin/include/sys/cpuset.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index 1adf48d54..572565165 100644
--- a/winsup/cygwin/include/sys/cpuset.h
+++ b/winsup/cygwin/include/sys/cpuset.h
@@ -89,6 +89,7 @@ int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
 #define CPU_XOR(dst, src1, src2)  CPU_XOR_S(sizeof (cpu_set_t), dst, src1, src2)
 #define CPU_EQUAL(src1, src2)     CPU_EQUAL_S(sizeof (cpu_set_t), src1, src2)
 
+#define CPU_SETSIZE               __CPU_SETSIZE
 #endif /* __GNU_VISIBLE */
 
 #ifdef __cplusplus
-- 
2.21.0
