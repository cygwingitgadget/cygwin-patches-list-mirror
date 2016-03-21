Return-Path: <cygwin-patches-return-8450-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28652 invoked by alias); 21 Mar 2016 17:16:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28612 invoked by uid 89); 21 Mar 2016 17:16:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:912, HTo:U*cygwin-patches
X-HELO: mail-qk0-f193.google.com
Received: from mail-qk0-f193.google.com (HELO mail-qk0-f193.google.com) (209.85.220.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 17:16:00 +0000
Received: by mail-qk0-f193.google.com with SMTP id q184so7357593qkb.0        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 10:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=VwnMCIaxHTGBXB/jspjDZ9K6CiMGLsOtAI+HMTx9FSE=;        b=YmzcbXVyytmtZm+Bc445sqU7XCZNQa7pReTDxt+/n4lb0/cAmzcJtQP6d6fxzJUwF3         IJA7VdklFdOWT+i0jGAlgIEc9Pmuf0wM4ZXyINKp/jIR4EHQA+yyDI/b2fvsza0mL5To         e2RtlEmGttDFJ6gqZ939kACgjjbu1X91K7hNJBNX8ECNBYNBB9VUAnH8EgFLH/8IGMdu         faXlKHQq4bcFThtMEpHKrmS+3/ux4G6vb86vpa8FFA8oP+hlfBRTUFXrGPLWxr9xdSoa         jkXpYD/cC6GwNYYZFIGouAGJk/yVjzj1uO8lZZm4pHZIN++dsNhfXsvoPYxsZYex1iYz         qDiQ==
X-Gm-Message-State: AD7BkJL1/V5Gn9l6Hoi9S/AQS3r6kr9JEapNCuEnJOZT4Ma75Ixn2jNA0bJQypglB/7Sbg==
X-Received: by 10.55.80.131 with SMTP id e125mr41819349qkb.62.1458580557884;        Mon, 21 Mar 2016 10:15:57 -0700 (PDT)
Received: from bronx.local.pefoley.com ([2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id n83sm12492145qhn.46.2016.03.21.10.15.57        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Mon, 21 Mar 2016 10:15:57 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 2/5] Link against libdnsapi to avoid undefined reference
Date: Mon, 21 Mar 2016 17:16:00 -0000
Message-Id: <1458580546-14484-2-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00156.txt.bz2

/home/peter/cross/src/cygwin/winsup/cygwin/libc/minires-os-if.c:289:
undefined reference to `DnsFree'

winsup/cygwin/ChangeLog
Makefile.in: Add libdnsapi to DLL_IMPORTS

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/Makefile.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 6695488..5ada7cb 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -149,7 +149,8 @@ EXTRA_OFILES:=
 
 MALLOC_OFILES:=malloc.o
 
-DLL_IMPORTS:=${shell $(CC) -print-file-name=w32api/libkernel32.a} ${shell $(CC) -print-file-name=w32api/libntdll.a}
+DLL_IMPORTS:=${shell $(CC) -print-file-name=w32api/libkernel32.a} ${shell $(CC) -print-file-name=w32api/libntdll.a} ${shell $(CC) -print-file-name=w32api/libdnsapi.a}
+
 
 MT_SAFE_OBJECTS:=
 #
-- 
2.7.4
