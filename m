Return-Path: <cygwin-patches-return-8801-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49139 invoked by alias); 7 Jul 2017 08:47:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48661 invoked by uid 89); 7 Jul 2017 08:47:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.1 required=5.0 tests=BAYES_00,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-spam-relays-external:209.85.128.194, H*RU:209.85.128.194
X-HELO: mail-wr0-f194.google.com
Received: from mail-wr0-f194.google.com (HELO mail-wr0-f194.google.com) (209.85.128.194) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jul 2017 08:47:09 +0000
Received: by mail-wr0-f194.google.com with SMTP id z45so6145334wrb.2        for <cygwin-patches@cygwin.com>; Fri, 07 Jul 2017 01:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to         :references:mime-version:content-transfer-encoding;        bh=T9uETr2GiKZ/LF16ikecTjoc9LN42JrNjYZ04GSPcuQ=;        b=AmXyN4nylnrMtQc1lpYDEA/fSKYT8TOyesk1YZGgr4lkvWHVsb/XzmKjxVlsQLncyy         qMqmvXXq+2q3ZNz/LEHqzww7hmAemrGu3VcZzlwEboOQ1h8TeTLukiVnXEqf8k6ZdNtT         VVR6hYVbekQVNubOlcW97Fg7Yzj/ug23zIkmD/r8dR8oqan79OzwnT6T2fjwYu28dyaL         ymdunNmQKoNFbwMsyKN3ZqlyYTHjVPsB11GwsML7SoQbO0ToSi8Lds9LKKlqnewX/Jil         Ey4XuI73TPE1xMMxi9XEnEOmvRO6rVFSHRustOoGR6FG/HSNVVe8URkhUDS7930A7H0X         uyxQ==
X-Gm-Message-State: AIVw110WBOBRUstEhiCkSx1rAKLHY0q3zsWY4H4fOHZtZ2O4hVvh141f	u0z1jEi/dR0Ygwp81IE=
X-Received: by 10.223.155.150 with SMTP id d22mr68448wrc.193.1499417226950;        Fri, 07 Jul 2017 01:47:06 -0700 (PDT)
Received: from localhost ([193.165.236.119])        by smtp.gmail.com with ESMTPSA id o6sm2874218wrc.48.2017.07.07.01.47.06        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);        Fri, 07 Jul 2017 01:47:06 -0700 (PDT)
Date: Fri, 07 Jul 2017 08:47:00 -0000
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com, newlib@sourceware.org
Subject: [PATCH] Rename __in and __out in headers to avoid collision with Windows APIs
Message-ID: <20170707104702.00003877@gmail.com>
In-Reply-To: <20170707002450.00007720@gmail.com>
References: <20170707002450.00007720@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00003.txt.bz2

* string.h: Local variables in expansion of strdupa and strndupa
* sys/wait.h: Fields in anonymous union in expansion of __wait_status_to_int
---
Reposting to the newlib ML.

There should be no API nor ABI changes, as the changed names are private to the macros.

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
