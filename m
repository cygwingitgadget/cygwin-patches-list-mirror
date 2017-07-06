Return-Path: <cygwin-patches-return-8800-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49244 invoked by alias); 6 Jul 2017 22:25:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49199 invoked by uid 89); 6 Jul 2017 22:24:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.1 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=H*RU:209.85.128.196, Hx-spam-relays-external:209.85.128.196, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wr0-f196.google.com
Received: from mail-wr0-f196.google.com (HELO mail-wr0-f196.google.com) (209.85.128.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 06 Jul 2017 22:24:58 +0000
Received: by mail-wr0-f196.google.com with SMTP id z45so3569466wrb.2        for <cygwin-patches@cygwin.com>; Thu, 06 Jul 2017 15:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:date:from:to:subject:message-id:mime-version         :content-transfer-encoding;        bh=lBO9evC5jjNcZEve2iGaL7QYu7RDln7++IX4h6ZwhoI=;        b=oLxqwRH12GHIPqCBbiePSL2NvkBv+XjRn4JKrDDe3ZlHUwRWqmk15RZCarRchMPnrZ         p3jUnhsSegALlqCDSZ/+ZNb8NUtMle6XrGBvW3O++sfu5sSNwc3jH6qDoJuTq0QbGlB/         5eLTeEDY4///HHhD93aZ9gwlrUHyiArl5LuShO3M5mD7I7pzCaRzGRcwJ4L3/WXwglt8         LWsi5ZkgyHmu6vyt8YlJkKK+c87q4ybmn5Zs1b+TrE8ghCR468qIGqvwhYKBuIRLBEge         1gVhWxzwCM46PYB3xYFFcai/NpQwy32hnZdg6IjQYnns88Ju5lCc8PtL+zPIRIVEY1O3         qAuw==
X-Gm-Message-State: AKS2vOwKpjt8Amt5C9MUq5pydyFFdl8PPk/d1TmwQfykt1iiWPngbEJG	Og2UoUdUO/P9772Yq8g=
X-Received: by 10.223.130.162 with SMTP id 31mr40260621wrc.202.1499379895885;        Thu, 06 Jul 2017 15:24:55 -0700 (PDT)
Received: from localhost ([193.165.236.142])        by smtp.gmail.com with ESMTPSA id k75sm1967901wmh.10.2017.07.06.15.24.55        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);        Thu, 06 Jul 2017 15:24:55 -0700 (PDT)
Date: Thu, 06 Jul 2017 22:25:00 -0000
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Rename __in and __out in headers to avoid collision with Windows APIs
Message-ID: <20170707002450.00007720@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00002.txt.bz2

* string.h: Local variables in expansion of strdupa and strndupa
* sys/wait.h: Fields in anonymous union in expansion of __wait_status_to_int
---
The new "s" in string.h comes from the __s parameter. The new "s" in wait.h comes from "status".  I'm not sure what the naming conventions are, so I'm open to corrections.

 newlib/libc/include/string.h     | 18 +++++++++---------
 winsup/cygwin/include/sys/wait.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/newlib/libc/include/string.h b/newlib/libc/include/string.h
index 29e0d44766..7833aa1561 100644
--- a/newlib/libc/include/string.h
+++ b/newlib/libc/include/string.h
@@ -141,16 +141,16 @@ int	 _EXFUN(strverscmp,(const char *, const char *));
 
 #if __GNU_VISIBLE && defined(__GNUC__)
 #define strdupa(__s) \
-	(__extension__ ({const char *__in = (__s); \
-			 size_t __len = strlen (__in) + 1; \
-			 char * __out = (char *) __builtin_alloca (__len); \
-			 (char *) memcpy (__out, __in, __len);}))
+	(__extension__ ({const char *__sin = (__s); \
+			 size_t __len = strlen (__sin) + 1; \
+			 char * __sout = (char *) __builtin_alloca (__len); \
+			 (char *) memcpy (__sout, __sin, __len);}))
 #define strndupa(__s, __n) \
-	(__extension__ ({const char *__in = (__s); \
-			 size_t __len = strnlen (__in, (__n)) + 1; \
-			 char *__out = (char *) __builtin_alloca (__len); \
-			 __out[__len-1] = '\0'; \
-			 (char *) memcpy (__out, __in, __len-1);}))
+	(__extension__ ({const char *__sin = (__s); \
+			 size_t __len = strnlen (__sin, (__n)) + 1; \
+			 char *__sout = (char *) __builtin_alloca (__len); \
+			 __sout[__len-1] = '\0'; \
+			 (char *) memcpy (__sout, __sin, __len-1);}))
 #endif /* __GNU_VISIBLE && __GNUC__ */
 
 /* There are two common basename variants.  If you do NOT #include <libgen.h>
diff --git a/winsup/cygwin/include/sys/wait.h b/winsup/cygwin/include/sys/wait.h
index 69e1b9d9bf..dc89458437 100644
--- a/winsup/cygwin/include/sys/wait.h
+++ b/winsup/cygwin/include/sys/wait.h
@@ -88,7 +88,7 @@ inline int __wait_status_to_int (const union wait & __status)
 #else /* !__cplusplus */
 
 #define __wait_status_to_int(__status)  (__extension__ \
-  (((union { __typeof(__status) __in; int __out; }) { .__in = (__status) }).__out))
+  (((union { __typeof(__status) __sin; int __sout; }) { .__sin = (__status) }).__sout))
 
 #endif /* __cplusplus */
 
-- 
2.13.2.windows.1

--
David Macek
