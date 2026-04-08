Return-Path: <SRS0=6Jdb=CH=gmail.com=joel.sherrill@sourceware.org>
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	by sourceware.org (Postfix) with ESMTPS id 044B04BA5439
	for <cygwin-patches@cygwin.com>; Wed,  8 Apr 2026 15:23:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 044B04BA5439
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=rtems.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 044B04BA5439
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775661837; cv=none;
	b=RJggTN0v6u7WcdSUKpSESYh9v44aUXY2ZadQrlCUDIqil41lKnXYltu/O13GHNLdzAIsua8ET5trMj3hijkkw0k01tKQcEvEuQ0Sd9D3GS7C/4G5MyHOI8N5yCNQp1VSfKnIeuF5s7nVNqCYGfbQf1m5xpdcFNwXVZXhJWzd+EA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775661837; c=relaxed/simple;
	bh=Lk08iuraSV5zQd3o5YYb4RdArNGde8oC0oGp0GGY1mU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uYAEQxTZCMAdL9zReZxwlP99r4ptpjiGlFz7s0OhAreiHUrU+V+BjT+AVC9NGbcxkZEqVKjFXpFf6bNHEYm9cuRthLyMXoPPDze4VX/XjeBBvHwjMjoE6sEAxboKRmor/J9vmDdfZcvj2Qx/euX/yKfw2fDopJVT9VP2FCImrXw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 044B04BA5439
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7927261a3acso187077b3.0
        for <cygwin-patches@cygwin.com>; Wed, 08 Apr 2026 08:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661836; x=1776266636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOaTvCJ0HCMVJuGF78QHwk0T5XdYl+RadaeV5ecrmY4=;
        b=kkjhIGTlWZBqdS2XnJT3Q6OKJzQMkKmo50D/FEmdb9zI6pG/Tn2E3FN9oSsBfKCDSb
         xUhwdjntRzHSo3QLYeY58IdhFgI54Kdys0xkuW2O/UAKcXLGqpKgDjDdkKehoVQtx4zY
         EuMHa+WoBMzEScpYCYVvfbP8TjI+1VDYrm+OeqSRWc2fONvyapFzqrJ09klFDqDHX/3/
         +034BqmJ6EetPi2Tu+8LUd0Gi4dJuNG9RCJu1gt6d3hPVa+9qlaYo7A1Jt6kJkiLisrV
         5YvTW8y+HkYqP4OlrgQnv1+OVnbDGxbugePTu/RQYPscU6I87sEulBhl63yQHe8+gcJF
         BaEg==
X-Gm-Message-State: AOJu0YwNMLKDJ2TH9ZDvPtF2d8Ix5NJdVOxaKjZdgfm85EbENmwDlfIb
	HwOJvBMTrInKF1rnakhg9cvWYPROAdJI97y/m2kr+W9u9tapPlw37x2wrKyqHw==
X-Gm-Gg: AeBDievxGRtCv8tRrTEkgBXczT/bFUKy43N1on8hgRI7HoiqhalA6u44B+L/NGIpazg
	g2b6qe815AP48mP9LI7fxMzyiwI31+jcKOUiZm3eshctzlDRrsKtR1JZdKfy8qHN9hdAUHVf3RU
	1GaHXuiXKtq2UaB66vA5OtfijT0L6Mv+Ep0iOCUR6ng6cfDCWM1+rMoOlfr7lMa0XrdBdjBnPT3
	XZ9+XHNUmaY8QOw5LxhNtsuJxOzEff8aNmrGyW5JHlEcJRsFzql9fRVHJFgsbt1qKLNxYjBjuFX
	2ZUavVb2GQcEiwbjcwOfURhz30W0d08nVGiyvx8WyA0Mo/zRsmHFyBtK69MqyWvowTbkHlvHiwL
	HA36XZ4QEOZ7hogcXOrbm774Fj45OPuHx2GQLrnTOuwk77Hk0Sqmh8+wutG3KUcp7z+l/y23mBw
	lnvB51lLugouJVP0tIh4rueex+FbVsMkgVtnYGKIc8GN021Xt047W+yuh7hAgDUg==
X-Received: by 2002:a05:690c:19:b0:79a:b46c:e60a with SMTP id 00721157ae682-7a4d8db073bmr209138177b3.44.1775661835834;
        Wed, 08 Apr 2026 08:23:55 -0700 (PDT)
Received: from gitlab.oarcorp.com (d27-96-189-151.evv.wideopenwest.com. [96.27.151.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a3712f8c8dsm86532617b3.46.2026.04.08.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:23:55 -0700 (PDT)
From: Joel Sherrill <joel@rtems.org>
To: cygwin-patches@cygwin.com
Cc: Joel Sherrill <joel@rtems.org>
Subject: [PATCH 1/1] Cygwin: winsup/cygwin/include/limits.h: Add C23 ..._WIDTH definitions
Date: Wed,  8 Apr 2026 10:19:02 -0500
Message-ID: <20260408151902.2022129-2-joel@rtems.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408151902.2022129-1-joel@rtems.org>
References: <20260408151902.2022129-1-joel@rtems.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3037.0 required=5.0 tests=BAYES_00,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GIT_PATCH_0,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

C23 adds the following constants to reflect the bit width of various
types: CHAR_WIDTH, SCHAR_WIDTH, UCHAR_WIDTH, SHRT_WIDTH, USHRT_WIDTH,
INT_WIDTH, UINT_WIDTH, LONG_WIDTH, ULONG_WIDTH, LLONG_WIDTH, and
ULLONG_WIDTH.
---
 winsup/cygwin/include/limits.h | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limits.h
index 28b7527f5..8cb02c84d 100644
--- a/winsup/cygwin/include/limits.h
+++ b/winsup/cygwin/include/limits.h
@@ -47,10 +47,20 @@ details. */
 #undef SCHAR_MAX
 #define SCHAR_MAX 127
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef SCHAR_WIDTH
+#define SCHAR_WIDTH __SCHAR_WIDTH__
+#endif
+
 /* Maximum value an `unsigned char' can hold.  (Minimum is 0).  */
 #undef UCHAR_MAX
 #define UCHAR_MAX 255
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef UCHAR_WIDTH
+#define UCHAR_WIDTH __SCHAR_WIDTH__
+#endif
+
 /* Minimum and maximum values a `char' can hold.  */
 #ifdef __CHAR_UNSIGNED__
 #undef CHAR_MIN
@@ -64,16 +74,31 @@ details. */
 #define CHAR_MAX 127
 #endif
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef CHAR_WIDTH
+#define CHAR_WIDTH __SCHAR_WIDTH__
+#endif
+
 /* Minimum and maximum values a `signed short int' can hold.  */
 #undef SHRT_MIN
 #define SHRT_MIN (-32768)
 #undef SHRT_MAX
 #define SHRT_MAX 32767
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef SHRT_WIDTH
+#define SHRT_WIDTH __SHRT_WIDTH__
+#endif
+
 /* Maximum value an `unsigned short int' can hold.  (Minimum is 0).  */
 #undef USHRT_MAX
 #define USHRT_MAX 65535
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef USHRT_WIDTH
+#define USHRT_WIDTH __SHRT_WIDTH__
+#endif
+
 /* Minimum and maximum values a `signed int' can hold.  */
 #ifndef __INT_MAX__
 #define __INT_MAX__ 2147483647
@@ -83,10 +108,20 @@ details. */
 #undef INT_MAX
 #define INT_MAX __INT_MAX__
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef INT_WIDTH
+#define INT_WIDTH __INT_WIDTH__
+#endif
+
 /* Maximum value an `unsigned int' can hold.  (Minimum is 0).  */
 #undef UINT_MAX
 #define UINT_MAX (INT_MAX * 2U + 1)
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef UINT_WIDTH
+#define UINT_WIDTH __INT_WIDTH__
+#endif
+
 /* Minimum and maximum values a `signed long int' can hold.
    (Same as `int').  */
 #ifndef __LONG_MAX__
@@ -97,10 +132,21 @@ details. */
 #undef LONG_MAX
 #define LONG_MAX __LONG_MAX__
 
+
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef LONG_WIDTH
+#define LONG_WIDTH __LONG_WIDTH__
+#endif
+
 /* Maximum value an `unsigned long int' can hold.  (Minimum is 0).  */
 #undef ULONG_MAX
 #define ULONG_MAX (LONG_MAX * 2UL + 1)
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef ULONG_WIDTH
+#define ULONG_WIDTH __LONG_WIDTH__
+#endif
+
 /* Minimum and maximum values a `signed long long int' can hold.  */
 #ifndef __LONG_LONG_MAX__
 #define __LONG_LONG_MAX__ 9223372036854775807LL
@@ -124,11 +170,21 @@ details. */
 #undef LLONG_MAX
 #define LLONG_MAX __LONG_LONG_MAX__
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef LLONG_WIDTH
+#define LLONG_WIDTH __LONG_LONG_WIDTH__
+#endif
+
 /* Maximum value an `unsigned long long int' can hold.  (Minimum is 0).  */
 #undef ULLONG_MAX
 #define ULLONG_MAX (LLONG_MAX * 2ULL + 1)
 #endif /* __ISO_C_VISIBLE >= 1999 */
 
+#if defined(__STDC_WANT_IEC_60559_BFP_EXT__) || __ISO_C_VISIBLE >= 2023
+#undef ULLONG_WIDTH
+#define ULLONG_WIDTH __LONG_LONG_WIDTH__
+#endif
+
 /* Maximum size of ssize_t. Sadly, gcc doesn't give us __SSIZE_MAX__
    the way it does for __SIZE_MAX__.  On the other hand, we happen to
    know that for Cygwin, ssize_t is 'long' and this particular header
-- 
2.47.3

