Return-Path: <cygwin-patches-return-8931-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47075 invoked by alias); 28 Nov 2017 04:11:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46113 invoked by uid 89); 28 Nov 2017 04:11:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_NUMSUBJECT,KB_WAM_FROM_NAME_SINGLEWORD,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=Selkowitz, selkowitz, sk:yselkow, H*Ad:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 04:11:05 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 430D4883C0	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-142.rdu2.redhat.com [10.10.120.142])	by smtp.corp.redhat.com (Postfix) with ESMTPS id CC1A960600	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 04:11:03 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Feature test macros overhaul: Cygwin limits.h, part 2
Date: Tue, 28 Nov 2017 04:11:00 -0000
Message-Id: <20171128041053.3888-1-yselkowi@redhat.com>
In-Reply-To: <13d8d4b7-8d73-44f7-5768-a26da81f966f@redhat.com>
References: <13d8d4b7-8d73-44f7-5768-a26da81f966f@redhat.com>
X-SW-Source: 2017-q4/txt/msg00061.txt.bz2

http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/limits.h.html
https://sourceware.org/ml/newlib/2017/msg01133.html

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/include/limits.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limits.h
index cf3c8d04d..fe1b8b493 100644
--- a/winsup/cygwin/include/limits.h
+++ b/winsup/cygwin/include/limits.h
@@ -24,6 +24,7 @@ details. */
 #undef CHAR_BIT
 #define CHAR_BIT __CHAR_BIT__
 
+#if __XSI_VISIBLE || __POSIX_VISIBLE >= 200809
 /* Number of bits in a `long'.  */
 #undef LONG_BIT
 #define LONG_BIT (__SIZEOF_LONG__ * __CHAR_BIT__)
@@ -31,6 +32,7 @@ details. */
 /* Number of bits in a `int'.  */
 #undef WORD_BIT
 #define WORD_BIT (__SIZEOF_INT__ * __CHAR_BIT__)
+#endif /* __XSI_VISIBLE || __POSIX_VISIBLE >= 200809 */
 
 /* Maximum length of a multibyte character.  */
 #ifndef MB_LEN_MAX
@@ -118,6 +120,7 @@ details. */
 #define ULONG_LONG_MAX (LONG_LONG_MAX * 2ULL + 1)
 #endif
 
+#if __ISO_C_VISIBLE >= 1999
 /* Minimum and maximum values a `signed long long int' can hold.  */
 #undef LLONG_MIN
 #define LLONG_MIN (-LLONG_MAX-1)
@@ -127,6 +130,7 @@ details. */
 /* Maximum value an `unsigned long long int' can hold.  (Minimum is 0).  */
 #undef ULLONG_MAX
 #define ULLONG_MAX (LLONG_MAX * 2ULL + 1)
+#endif /* __ISO_C_VISIBLE >= 1999 */
 
 /* Maximum size of ssize_t. Sadly, gcc doesn't give us __SSIZE_MAX__
    the way it does for __SIZE_MAX__.  On the other hand, we happen to
@@ -171,9 +175,11 @@ details. */
 #undef ARG_MAX
 #define ARG_MAX 32000
 
+#if __XSI_VISIBLE || __POSIX_VISIBLE >= 200809
 /* Maximum number of functions that may be registered with atexit(). */
 #undef ATEXIT_MAX
 #define ATEXIT_MAX 32
+#endif
 
 /* Maximum number of simultaneous processes per real user ID. */
 #undef CHILD_MAX
@@ -187,9 +193,11 @@ details. */
 #undef HOST_NAME_MAX
 #define HOST_NAME_MAX 255
 
+#if __XSI_VISIBLE
 /* Maximum number of iovcnt in a writev (an arbitrary number) */
 #undef IOV_MAX
 #define IOV_MAX 1024
+#endif
 
 /* Maximum number of characters in a login name. */
 #undef LOGIN_NAME_MAX
@@ -212,9 +220,11 @@ details. */
 
 /* Size in bytes of a page. */
 #undef PAGESIZE
-#undef PAGE_SIZE
 #define PAGESIZE 65536
+#if __XSI_VISIBLE
+#undef PAGE_SIZE
 #define PAGE_SIZE PAGESIZE
+#endif
 
 /* Maximum number of attempts made to destroy a thread's thread-specific
    data values on thread exit. */
@@ -381,6 +391,7 @@ details. */
 
 /* Runtime Increasable Values */
 
+#if __POSIX_VISIBLE >= 2
 /* Maximum obase values allowed by the bc utility. */
 #undef BC_BASE_MAX
 #define BC_BASE_MAX 99
@@ -428,6 +439,7 @@ details. */
    using the interval notation \{m,n\} */
 #undef RE_DUP_MAX
 #define RE_DUP_MAX 255
+#endif /* __POSIX_VISIBLE >= 2 */
 
 
 /* POSIX values */
@@ -435,6 +447,7 @@ details. */
 /* They represent the minimum values that POSIX systems must support.
    POSIX-conforming apps must not require larger values. */
 
+#if __POSIX_VISIBLE
 /* Maximum Values */
 
 #define _POSIX_CLOCKRES_MIN                 20000000
@@ -478,7 +491,9 @@ details. */
 #define _POSIX_TRACE_USER_EVENT_MAX               32
 #define _POSIX_TTY_NAME_MAX	                   9
 #define _POSIX_TZNAME_MAX                          6
+#endif /* __POSIX_VISIBLE */
 
+#if __POSIX_VISIBLE >= 2
 #define _POSIX2_BC_BASE_MAX	                  99
 #define _POSIX2_BC_DIM_MAX	                2048
 #define _POSIX2_BC_SCALE_MAX	                  99
@@ -487,23 +502,34 @@ details. */
 #define _POSIX2_EXPR_NEST_MAX	                  32
 #define _POSIX2_LINE_MAX	                2048
 #define _POSIX2_RE_DUP_MAX	                 255
+#endif /* __POSIX_VISIBLE >= 2 */
 
+#if __XSI_VISIBLE
 #define _XOPEN_IOV_MAX                            16
 #define _XOPEN_NAME_MAX                          255
 #define _XOPEN_PATH_MAX                         1024
+#endif
 
 /* Other Invariant Values */
 
 #define NL_ARGMAX                                  9
+#if __XSI_VISIBLE
 #define NL_LANGMAX                                14
+#endif
+#if __XSI_VISIBLE || __POSIX_VISIBLE >= 200809
 #define NL_MSGMAX                              32767
-#define NL_NMAX                              INT_MAX
 #define NL_SETMAX                                255
 #define NL_TEXTMAX                  _POSIX2_LINE_MAX
+#endif
+#if __POSIX_VISIBLE < 200809
+#define NL_NMAX                              INT_MAX
+#endif
 
+#if __XSI_VISIBLE
 /* Default process priority. */
 #undef NZERO
 #define NZERO			                  20
+#endif
 
 #endif /* _MACH_MACHLIMITS_H_ */
 #endif /* _LIMITS_H___ */
-- 
2.15.0
