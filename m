Return-Path: <cygwin-patches-return-8421-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63440 invoked by alias); 19 Mar 2016 17:46:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63249 invoked by uid 89); 19 Mar 2016 17:46:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mail-qk0-f194.google.com
Received: from mail-qk0-f194.google.com (HELO mail-qk0-f194.google.com) (209.85.220.194) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:17 +0000
Received: by mail-qk0-f194.google.com with SMTP id s5so4937718qkd.2        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=3HtdfIiQ8JGNNXXi8I9pmOFK6zFqDwPloGXBDNOoCaE=;        b=bRKgz8lrAKfvN02rwn/3tIEWh/eHJS8T1mT+w7u4IzW7QSSQXtCXzKZ+xZdLwCZEZ1         xW7X5J3zRQGmsqxA7aKlX6j941Hso2haN9zoelHm6GZeB9iMm2O/JtSd+22MWUDNmT2b         4wD9WlQ92/3vlB+rJ+HZiiqgAD1HDRWPxDeYTjmBKh3k5RO6sfgukuZGDTka0qJ5roGb         6dmVl3YwRfRkD5G30jqOa6ftYKpjneTZyZVZIP2f2iL4riMXMluCzfyDKiVSkyc7n+Vo         C4LLwPFWzPT+bPI7niKBuozmw5r2gD/IY/xqclR7abkdEL8U2yZugHmOrOZQ0ESmSdSE         5AsQ==
X-Gm-Message-State: AD7BkJKCY2GpKs6XwWMT3/Lm/DEaRM32y3aLUC+zAuxv+uOOnRtWnM7CHqeGdf4tmCp/lA==
X-Received: by 10.55.71.195 with SMTP id u186mr30569866qka.38.1458409575168;        Sat, 19 Mar 2016 10:46:15 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.14        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:14 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 05/11] A pointer to a pointer is nonnull.
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-5-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00124.txt.bz2

GCC 6.0+ can assert that this argument is nonnull.
Remove the unnecessary check to fix a warning.

winsup/cygwin/ChangeLog
malloc_wrapper.cc (posix_memalign): Remove always true nonnull check.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/malloc_wrapper.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
