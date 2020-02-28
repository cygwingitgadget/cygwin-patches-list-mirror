Return-Path: <cygwin-patches-return-10138-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53163 invoked by alias); 28 Feb 2020 12:04:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53154 invoked by uid 89); 28 Feb 2020 12:04:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.1 required=5.0 tests=AWL,BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KHOP_HELO_FCRDNS,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=$-16, UD:N.B, nb, NB
X-HELO: sa-prd-fep-042.btinternet.com
Received: from mailomta5-sa.btinternet.com (HELO sa-prd-fep-042.btinternet.com) (213.120.69.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 12:04:27 +0000
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])          by sa-prd-fep-042.btinternet.com with ESMTP          id <20200228120424.QJXU20292.sa-prd-fep-042.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;          Fri, 28 Feb 2020 12:04:24 +0000
Authentication-Results: btinternet.com;    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-OWM-Source-IP: 31.51.207.12 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from localhost.localdomain (31.51.207.12) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as jonturney@btinternet.com)        id 5E3A241103AACC2A; Fri, 28 Feb 2020 12:04:24 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: remove %esp from asm clobber list
Date: Fri, 28 Feb 2020 12:04:00 -0000
Message-Id: <20200228120413.1560-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2020-q1/txt/msg00244.txt

Mentioning the stack pointer in the clobber list is now a gcc warning.

We never wanted gcc to try to restore %esp after this (x86-specific)
asm, since the whole point of the inline asm here is to adjust %esp to
satisfy alignment, so remove %esp from the asm clobber list.

Of more concern is the alleged requirement that %esp must be unchanged
over an asm statement (which makes what this code is trying to do
impossible to write as a C function), although on x86 we are probably ok
in this particular instance.

../../../../winsup/cygwin/init.cc: In function 'void threadfunc_fe(void*)':
../../../../winsup/cygwin/init.cc:33:46: error: listing the stack pointer register '%esp' in a clobber list is deprecated [-Werror=deprecated]
../../../../winsup/cygwin/init.cc:33:46: note: the value of the stack pointer after an 'asm' statement must be the same as it was before the statement

Also, because we now using gcc's "basic" rather than "extended" asm
syntax we don't need to escape the '%' in '%esp' as '%%esp'.
---

Notes:
    N.B: This comes with a 'this should be ok, but I haven't actually
    tested that x86 Cygwin works after this' caveat.

 winsup/cygwin/crt0.c  | 2 +-
 winsup/cygwin/init.cc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/crt0.c b/winsup/cygwin/crt0.c
index fee4b2e24..9fcebd8fa 100644
--- a/winsup/cygwin/crt0.c
+++ b/winsup/cygwin/crt0.c
@@ -27,7 +27,7 @@ mainCRTStartup ()
 #if __GNUC_PREREQ(6,0)
 #pragma GCC diagnostic pop
 #endif
-  asm volatile ("andl $-16,%%esp" ::: "%esp");
+  asm volatile ("andl $-16,%esp");
 #endif
 
   cygwin_crt0 (main);
diff --git a/winsup/cygwin/init.cc b/winsup/cygwin/init.cc
index 851a7ffed..7ae7d08fe 100644
--- a/winsup/cygwin/init.cc
+++ b/winsup/cygwin/init.cc
@@ -30,7 +30,7 @@ threadfunc_fe (VOID *arg)
 #if __GNUC_PREREQ(6,0)
 #pragma GCC diagnostic pop
 #endif
-  asm volatile ("andl $-16,%%esp" ::: "%esp");
+  asm volatile ("andl $-16,%esp");
 #endif
   _cygtls::call ((DWORD (*)  (void *, void *)) TlsGetValue (_my_oldfunc), arg);
 }
-- 
2.21.0
