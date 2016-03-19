Return-Path: <cygwin-patches-return-8423-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64109 invoked by alias); 19 Mar 2016 17:46:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63705 invoked by uid 89); 19 Mar 2016 17:46:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:783, mistaken, HTo:U*cygwin-patches
X-HELO: mail-qg0-f65.google.com
Received: from mail-qg0-f65.google.com (HELO mail-qg0-f65.google.com) (209.85.192.65) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:19 +0000
Received: by mail-qg0-f65.google.com with SMTP id 14so9863935qgg.3        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=DA4mKqhWxiDajoQ5SHd5KiBIqpfoDTJop8Ar+cNGvls=;        b=ULruQdN2s1IenkRE6UoWehcHE8/tXxLm/1lr0dk9Bf9wkpJUyxWbCikE49lnxYeEZ1         gLf73tYk71MOpw1tcGWNs0wqQlQf3/o7oQfH6/AIXstqa0QINYvmAoqOEgZvVUTfiBur         irhSdz19ImhwTsCv80BCJT9/HBvgrDIsyF+OEnCrTl/ks0b7GxX4MPIjDKtiMRs+6oVc         6XRhsGlp7Su/UxnhhHD9a0BSsr9qffyzkAF3cqjCYKdtEwXLH7gSU7wT4jOqg5XYSDA9         yv9IpKcyHsA7CYozjIqVkZ6sjLLY6+a5EkDKyE4TLqKVi8fP1O0RQ7hH4BD+FpOoyq5w         OwKQ==
X-Gm-Message-State: AD7BkJLLbUPm2Cfi9RpbBEiYeIk1xpIhp7uDBev1S3KJO/2m+OV7ng3OPO1pMPpUbsLehA==
X-Received: by 10.140.136.70 with SMTP id 67mr32609370qhi.46.1458409577127;        Sat, 19 Mar 2016 10:46:17 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.16        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:16 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 08/11] Fix typoed comparison
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-8-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00131.txt.bz2

winsup/cygwin/ChangeLog
* thread.cc (semaphore::open): Fix mistaken conditional.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/thread.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 531d6a8..05757ac 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -3746,7 +3746,7 @@ semaphore::open (unsigned long long hash, LUID luid, int fd, int oflag,
   for (semaphore *sema = semaphores.head; sema; sema = sema->next)
     if (sema->fd >= 0 && sema->hash == hash
 	&& sema->luid.HighPart == luid.HighPart
-	&& sema->luid.LowPart == sema->luid.LowPart)
+	&& sema->luid.LowPart == luid.LowPart)
       {
 	wasopen = true;
 	semaphores.mx.unlock ();
-- 
2.7.4
