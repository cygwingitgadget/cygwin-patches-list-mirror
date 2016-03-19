Return-Path: <cygwin-patches-return-8427-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64888 invoked by alias); 19 Mar 2016 17:46:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64826 invoked by uid 89); 19 Mar 2016 17:46:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=29,6, 2911, HTo:U*cygwin-patches, Hx-languages-length:719
X-HELO: mail-qg0-f66.google.com
Received: from mail-qg0-f66.google.com (HELO mail-qg0-f66.google.com) (209.85.192.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:20 +0000
Received: by mail-qg0-f66.google.com with SMTP id 14so9863948qgg.3        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=1esrAzu3t9BYOmf7/yxbwhHtFrm2R7XxQMz+oqdnyjk=;        b=TzGRTvGQNs/tBslI8vnU9zBAX1sxnbPeB0aKM7EsgqV60Vjhr/PUEX+xSPYa/yBw7i         TocF68j1mSS/v2ZO0g2FXlERhJ3W1yTujOFCx4b8odlIRUYab2ixDsrF0B0hT+6xa7db         +/U+zWVDCh1fS8GcdC4N4gDSCgvXBEXt5PZxGFtFqAJfKsoo+G58HHn7KEwcAy0l7z87         Yls6ItMUAHWMajKekGMyv4VLGz494+pcZxQSJhQQXGdIw9x8mkhB8/Q96ExvAcv9j4DF         tvWWgMJlvsQLhMPrHRYdGB33rT38vbr/P0Nr+y4m8svkugEkp1DNbBEVc1w6JZf5tV9H         3GRQ==
X-Gm-Message-State: AD7BkJJrW8o2LXIFCxrgQaXHNgDwC7I1hk7hwXciYXABvDmohL3sY3WjhToSOQU5g7rPEQ==
X-Received: by 10.140.132.68 with SMTP id 65mr1157585qhe.13.1458409577801;        Sat, 19 Mar 2016 10:46:17 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.17        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:17 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 09/11] Add c++14 sized deallocation operator
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-9-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00130.txt.bz2

When compiling with -std=c++14 (the default for gcc 6.0+), the sized
deallocation operator must be defined to prevent undefined symbols when
linking.

winsup/cygwin/ChangeLog:
cxx.cc (operator delete(void *p, size_t)): Define.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/cxx.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/cxx.cc b/winsup/cygwin/cxx.cc
index 0faeaf7..df7491b 100644
--- a/winsup/cygwin/cxx.cc
+++ b/winsup/cygwin/cxx.cc
@@ -29,6 +29,11 @@ operator delete (void *p)
 {
   free (p);
 }
+void
+operator delete (void *p, size_t)
+{
+  ::operator delete(p);
+}
 
 void *
 operator new[] (std::size_t s)
-- 
2.7.4
