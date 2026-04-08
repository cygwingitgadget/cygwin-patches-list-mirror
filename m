Return-Path: <SRS0=6Jdb=CH=gmail.com=joel.sherrill@sourceware.org>
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	by sourceware.org (Postfix) with ESMTPS id D82D64BA2E04
	for <cygwin-patches@cygwin.com>; Wed,  8 Apr 2026 15:10:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D82D64BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=rtems.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D82D64BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775661009; cv=none;
	b=M7F5AJAAl0o+QBOVfhqMl/M05MTLKAhDxULWcz/SmeMX/Cw8Ol897Pf28fIhVAruRxHeqObbAm3dCA9o0hYxLCZWDU33YuKeJ/lVKYbl6033Q6M7gzsrV0B+IS8mW9uO48gcF6+R05hsPZbpZWiE7UHbLytnAF1gX4MZTbOze9M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775661009; c=relaxed/simple;
	bh=Lk08iuraSV5zQd3o5YYb4RdArNGde8oC0oGp0GGY1mU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EVqkXWc7IanaPrVVnguXrwBPre5bILvJOwcB1gYvj+D3WASQB9UPnmx93fJEWFqekCVztY7OqmzmOai9uHtOVptx62m3Amfs8IBXYWK6MqK+gvDcLmoGt/25joV8zcyv4gDq+85ujLNNrNfprEoUSmPuIfpXhDb4FtWrXey7OU4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D82D64BA2E04
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79827d28fc4so55904777b3.1
        for <cygwin-patches@cygwin.com>; Wed, 08 Apr 2026 08:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661009; x=1776265809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOaTvCJ0HCMVJuGF78QHwk0T5XdYl+RadaeV5ecrmY4=;
        b=BuKhDJMKaaXNpoRBi0OevKv1Li8nvEMKL0Dl+OG6irYi5B74CbxT6hu3Dlepup+nTh
         LMBycYevXvfz29B6/7ySAt6YcuvR5R6pgu0ZaLLnTwkvMbqB4eXba1StM4ix1pfxqQGg
         /j81PDnQhoCWvaRZrn6tg1lyk+Ixcmc4CHlwS2YaEFL78NgBsExR/joRW+NTQiD9NVeI
         7s+WgbAEi+1RZbQnMj/ZEdwb7/02waQ7+TyXTQJjcH06hWvAaZ6v+XAXvI6jmt3zDqXW
         3Wx2xbhxTaIJRsUsjeAlaIgqwReIlFrDOivUc2oaf567T+J2D5DcErmDpZYzemA9tQeQ
         goSA==
X-Gm-Message-State: AOJu0YzXOGbY+xTKJSMyWlbgMc8PQoCVzr2Du5d3nTUu1715U7BR+TT9
	wb/21bEBSlUyUJdpLWoQm3ze8nHm2b9hqs49rt8LJOUOeRYp9P1IBVu0TXKNPw==
X-Gm-Gg: AeBDieuXtQVDl3bHRPnoc4WwoLwzpWR71JGd+suZlFgJbOrBRqZuD7AI+mEqy58wwrH
	v6X/OHp97DK8FQ68ONSulh+IK7HNDJd+DnJ/5KV8Tf7dCtzh9ufRI5nxbpN+oY9mdG59Vhy9Z67
	fjfbDhUzuEFThFpiWBOaYETpJnqgGkVeSFoKBJnxch7JzMwTSG0O6oqpIsuxrhJsEdYjJVrssvV
	qKNH54vnc9QHGOHBSwsEgWjwtffYYAWtsJcAWMcOrya1szbFokxTHyTuiUqroEu2byZkdR5btpD
	ofVHvWm0421CSLQngaJVB4DEqXeosQCZUwQOQFjUuYoy7HSIWbT48dIyL8QmJPbLdz9e2fsHinK
	A0DtPxbH0gl3D7LBda1rz4ggzgy04IDUmZMmMNOsNCUuhV3n5tnMmoqMnMzF8W4eX8R/FNaY/DM
	zg4Wv0YPqMVS5LK94NHeYHspkXl5PG6iyajfCwFkos3fL8iJYPiaMa6S11iWp5hw==
X-Received: by 2002:a05:690c:e654:b0:79f:7972:f88c with SMTP id 00721157ae682-7a4d64480eemr132721407b3.11.1775661008636;
        Wed, 08 Apr 2026 08:10:08 -0700 (PDT)
Received: from gitlab.oarcorp.com (d27-96-189-151.evv.wideopenwest.com. [96.27.151.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370906c94sm88322917b3.28.2026.04.08.08.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:08 -0700 (PDT)
From: Joel Sherrill <joel@rtems.org>
To: cygwin-patches@cygwin.com
Cc: Joel Sherrill <joel@rtems.org>
Subject: [PATCH 1/1] Cygwin: winsup/cygwin/include/limits.h: Add C23 ..._WIDTH definitions
Date: Wed,  8 Apr 2026 10:09:30 -0500
Message-ID: <20260408150930.1766201-2-joel@rtems.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408150930.1766201-1-joel@rtems.org>
References: <20260408150930.1766201-1-joel@rtems.org>
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

