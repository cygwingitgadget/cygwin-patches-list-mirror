Return-Path: <cygwin-patches-return-8597-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114918 invoked by alias); 13 Jul 2016 21:02:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114904 invoked by uid 89); 13 Jul 2016 21:02:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_40,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=qualities, gcc's, gccs, fingers
X-HELO: resqmta-po-01v.sys.comcast.net
Received: from resqmta-po-01v.sys.comcast.net (HELO resqmta-po-01v.sys.comcast.net) (96.114.154.160) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 13 Jul 2016 21:02:33 +0000
Received: from resomta-po-11v.sys.comcast.net ([96.114.154.235])	by resqmta-po-01v.sys.comcast.net with SMTP	id NRHPbz6t6ucHZNRIebGRrX; Wed, 13 Jul 2016 21:02:32 +0000
Received: from red.redhat.com ([24.10.254.122])	by comcast with SMTP	id NRIbb7QiC5YR5NRIdbwymd; Wed, 13 Jul 2016 21:02:31 +0000
From: Eric Blake <eblake@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix 32-bit SSIZE_MAX
Date: Wed, 13 Jul 2016 21:02:00 -0000
Message-Id: <1468443748-25335-1-git-send-email-eblake@redhat.com>
X-CMAE-Envelope: MS4wfJ5YczOrCP2J4FwR6V1au/t1pKGC0RhddNUEVjSDNk2scbx1Rke71+K8kdqO3DAhtE1mu4RWuoHC0TxNBmW3RKC0M6vw7c0S4seuxPpKyF8uNKL8SPoe s0IKFFuIxPsO+LFcR3k2EVuXf/02LyFSuiSwdTzEWUiSlteknaphjYVMkrxo+2eh6hsb94h5xE3adw==
X-IsSubscribed: yes
X-SW-Source: 2016-q3/txt/msg00005.txt.bz2

POSIX requires that SSIZE_MAX have the same type as ssize_t, but
on 32-bit, we were defining it as a long even though ssize_t
resolves to an int.  It also requires that SSIZE_MAX be usable
via preprocessor #if, so we can't cheat and use a cast.

If this were newlib, I'd have had to hack _intsup.h to probe the
qualities of size_t (via gcc's __SIZE_TYPE__), similar to how we
already probe the qualities of int8_t and friends, then cross our
fingers that ssize_t happens to have the same rank (most systems
do, but POSIX permits a system where they differ such as size_t
being long while ssize_t is int).  Unfortunately gcc gives us
neither __SSIZE_TYPE__ nor __SSIZE_MAX__.  On the other hand, our
limits.h is specific to cygwin, we can just shortcut to the
correct results rather than being generic to all possible ABI.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 winsup/cygwin/include/limits.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limits.h
index 2083e3e..cf3c8d0 100644
--- a/winsup/cygwin/include/limits.h
+++ b/winsup/cygwin/include/limits.h
@@ -128,9 +128,17 @@ details. */
 #undef ULLONG_MAX
 #define ULLONG_MAX (LLONG_MAX * 2ULL + 1)

-/* Maximum size of ssize_t */
+/* Maximum size of ssize_t. Sadly, gcc doesn't give us __SSIZE_MAX__
+   the way it does for __SIZE_MAX__.  On the other hand, we happen to
+   know that for Cygwin, ssize_t is 'int' on 32-bit and 'long' on
+   64-bit, and this particular header is specific to Cygwin, so we
+   don't have to jump through hoops. */
 #undef SSIZE_MAX
+#if __WORDSIZE == 64
 #define SSIZE_MAX (__LONG_MAX__)
+#else
+#define SSIZE_MAX (__INT_MAX__)
+#endif


 /* Runtime Invariant Values */
-- 
2.5.5
