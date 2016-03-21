Return-Path: <cygwin-patches-return-8452-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28735 invoked by alias); 21 Mar 2016 17:16:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28611 invoked by uid 89); 21 Mar 2016 17:16:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1449, 2537, HTo:U*cygwin-patches
X-HELO: mail-qg0-f66.google.com
Received: from mail-qg0-f66.google.com (HELO mail-qg0-f66.google.com) (209.85.192.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 17:15:59 +0000
Received: by mail-qg0-f66.google.com with SMTP id 51so7159698qgy.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 10:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:references         :in-reply-to;        bh=zxys3bvULusj9xlrFDzUw5dwkcguHOUairY9FGZPna0=;        b=gKie+BMiIm7sU7GHl0PFZqOUswdTYGjGVUh97DJdr7EjNJ4KMmweEysZMfWYWFajFb         n7VXzW5Dq+U0YcsZF6E3Qpj0q2bbmzOm7J1UNeQ1vKhVolaqwORWHpEga3HzTGKHLDoX         WQVNRWq6A/wqmK/B6mrh+3GmUAFPoEexe2AGbJrF31Mb/uCQX5P31JmWw/kUBUUkPR1u         xrQ7c3PE/xsNMZns8k5LKjNWLk6uOhJGbccehGTnz+GrSGt9lHrQ1s1xn7PLcX91RA9N         DZkJliQvYNZlhcKqjUDjTeiotq2HauIbY+igcr80qHV5jdOEDQukkSxmoO/M+Tm/roUQ         GntQ==
X-Gm-Message-State: AD7BkJKXpZoMN9Yt8w1R11yrzZqHnTlZB3u//fR/BDG9dtQMs2MXp6s0c4ihB0F7HvcuLQ==
X-Received: by 10.140.19.147 with SMTP id 19mr41508845qgh.70.1458580557169;        Mon, 21 Mar 2016 10:15:57 -0700 (PDT)
Received: from bronx.local.pefoley.com ([2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id n83sm12492145qhn.46.2016.03.21.10.15.56        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Mon, 21 Mar 2016 10:15:56 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH v2 1/5] Add nonnull annotation to posix_memalign.
Date: Mon, 21 Mar 2016 17:16:00 -0000
Message-Id: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de> <CAOFdcFPxwdnyjbtAm5FVD6d4DhZB9Cm80kPzzNVaCPKfN9yX9Q@mail.gmail.com>
In-Reply-To: <CAOFdcFPxwdnyjbtAm5FVD6d4DhZB9Cm80kPzzNVaCPKfN9yX9Q@mail.gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00159.txt.bz2

GCC 6.0+ asserts that the memptr argument to the builtin function
posix_memalign is nonnull.
Add the necessary annotation to the prototype and
remove the now unnecessary check to fix a warning.

newlib/Changelog
newlib/libc/include/stdlib.h: Annotate arg to posix_memalign as
non-null.

winsup/cygwin/ChangeLog
malloc_wrapper.cc (posix_memalign): Remove always true nonnull check.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 newlib/libc/include/stdlib.h    | 2 +-
 winsup/cygwin/malloc_wrapper.cc | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/newlib/libc/include/stdlib.h b/newlib/libc/include/stdlib.h
index f4b2626..7d4ae76 100644
--- a/newlib/libc/include/stdlib.h
+++ b/newlib/libc/include/stdlib.h
@@ -253,7 +253,7 @@ int	_EXFUN(_unsetenv_r,(struct _reent *, const char *__string));
 
 #ifdef __rtems__
 #if __POSIX_VISIBLE >= 200112
-int _EXFUN(posix_memalign,(void **, size_t, size_t));
+int _EXFUN(__nonnull (1) posix_memalign,(void **, size_t, size_t));
 #endif
 #endif
 
diff --git a/winsup/cygwin/malloc_wrapper.cc b/winsup/cygwin/malloc_wrapper.cc
index 43b8144..0db5de8 100644
--- a/winsup/cygwin/malloc_wrapper.cc
+++ b/winsup/cygwin/malloc_wrapper.cc
@@ -126,8 +126,7 @@ posix_memalign (void **memptr, size_t alignment, size_t bytes)
   __malloc_unlock ();
   if (!res)
     return ENOMEM;
-  if (memptr)
-    *memptr = res;
+  *memptr = res;
   return 0;
 }
 
-- 
2.7.4
