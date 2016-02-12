Return-Path: <cygwin-patches-return-8306-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19942 invoked by alias); 12 Feb 2016 17:27:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19925 invoked by uid 89); 12 Feb 2016 17:27:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=8087, 808,7, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 12 Feb 2016 17:27:25 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (Postfix) with ESMTPS id 8023A804E4	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1CHRMeH013978	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 12:27:23 -0500
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] cygwin: fix errors with GCC 5
Date: Fri, 12 Feb 2016 17:27:00 -0000
Message-Id: <1455298020-14696-1-git-send-email-yselkowi@redhat.com>
In-Reply-To: <20160212093124.GB19968@calimero.vinschen.de>
References: <20160212093124.GB19968@calimero.vinschen.de>
X-SW-Source: 2016-q1/txt/msg00012.txt.bz2

GCC 5 switched from C89 to C11 by default. This implies a change from
GNU to C99 inline by default, which have very different meanings of
extern inline vs. static inline:

https://gcc.gnu.org/onlinedocs/gcc/Inline.html

Marking these as gnu_inline retains the previous behaviour.

	winsup/cygwin/
	* exceptions.cc (exception::handle): Change debugging to int to fix
	an always-true boolean comparison warning.
	* include/cygwin/config.h (__getreent): Mark gnu_inline.
	* winbase.h (ilockcmpexch, ilockcmpexch64): Ditto.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/exceptions.cc           | 4 ++--
 winsup/cygwin/include/cygwin/config.h | 1 +
 winsup/cygwin/winbase.h               | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index c3a45d2..1627d43 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -637,7 +637,7 @@ EXCEPTION_DISPOSITION
 exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
 		   PDISPATCHER_CONTEXT dispatch)
 {
-  static bool NO_COPY debugging;
+  static int NO_COPY debugging = 0;
   _cygtls& me = _my_tls;
 
 #ifndef __x86_64__
@@ -808,7 +808,7 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
     rtl_unwind (frame, e);
   else
     {
-      debugging = true;
+      debugging = 1;
       return ExceptionContinueExecution;
     }
 
diff --git a/winsup/cygwin/include/cygwin/config.h b/winsup/cygwin/include/cygwin/config.h
index 58cff05..204826d 100644
--- a/winsup/cygwin/include/cygwin/config.h
+++ b/winsup/cygwin/include/cygwin/config.h
@@ -43,6 +43,7 @@ extern "C" {
 #else
 #include "../tlsoffsets.h"
 #endif
+__attribute__((gnu_inline))
 extern inline struct _reent *__getreent (void)
 {
   register char *ret;
diff --git a/winsup/cygwin/winbase.h b/winsup/cygwin/winbase.h
index 666f74a..1e825e4 100644
--- a/winsup/cygwin/winbase.h
+++ b/winsup/cygwin/winbase.h
@@ -11,6 +11,7 @@ details. */
 #ifndef _WINBASE2_H
 #define _WINBASE2_H
 
+__attribute__((gnu_inline))
 extern __inline__ LONG
 ilockcmpexch (volatile LONG *t, LONG v, LONG c)
 {
@@ -30,6 +31,7 @@ ilockcmpexch (volatile LONG *t, LONG v, LONG c)
 #undef InterlockedCompareExchangePointer
 
 #ifdef __x86_64__
+__attribute__((gnu_inline))
 extern __inline__ LONGLONG
 ilockcmpexch64 (volatile LONGLONG *t, LONGLONG v, LONGLONG c)
 {
-- 
2.7.0
