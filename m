Return-Path: <cygwin-patches-return-8425-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64270 invoked by alias); 19 Mar 2016 17:46:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63862 invoked by uid 89); 19 Mar 2016 17:46:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=px, Hx-languages-length:844, HTo:U*cygwin-patches
X-HELO: mail-qg0-f65.google.com
Received: from mail-qg0-f65.google.com (HELO mail-qg0-f65.google.com) (209.85.192.65) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:20 +0000
Received: by mail-qg0-f65.google.com with SMTP id j92so7782019qgj.1        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=rtpaVjDAheja+DUq/b+w6W2jzfWYq7nrrAwc/A5Nj+o=;        b=TllF10lrWxLRVMNaPOXNOe33hsOx5eVTvYuGeJhAgrVMPTJ4PJMfOSLFHuJcnu6w0S         rfLu+Er90BBNN9EhrmD0c6rXSu4SPTWAXjFYnZitPViIfYnLYNkqrXkbCD9DYanaLv/K         llj5H6QG9jemjWaMd7jfRCGuX8QoMgOfu1MvO5kkxf0iHAfPD6/5MJx8KSJBMMM0AG/W         2BSetN9QgsM7yyQrqIcJHhxpBDcmfeLzYMsVXyU8y7+cti9Pf3oGJqvnmYMJ9XjOk/K1         QsqV6BPT1Pi4iLCAArz3DLrINyn00FgcDaR55epjC/ICgJfGJLVRKyn+5Pq+yEr+rcTw         lLBg==
X-Gm-Message-State: AD7BkJJkAgkLc15dJKL+HgS2XSGl8ByJLieRSvsOF1OV+0WMkuqYIlAjoj4TcCvb+F84hQ==
X-Received: by 10.140.225.6 with SMTP id v6mr32617671qhb.0.1458409578440;        Sat, 19 Mar 2016 10:46:18 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.17        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:18 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 10/11] Fix strict aliasing
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-10-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00133.txt.bz2

Fix a strict aliasing error detected by gcc 6.0+

winsup/cygwin/ChangeLog
* pinfo.cc (winpids::enum_process): Fix strict aliasing.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/pinfo.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 17bf063..e6ceba8 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -1391,14 +1391,13 @@ winpids::enum_processes (bool winpid)
 	}
 
       PSYSTEM_PROCESS_INFORMATION px = procs;
-      char *&pxc = (char *&)px;
       while (1)
 	{
 	  if (px->UniqueProcessId)
 	    add (nelem, true, (DWORD) (uintptr_t) px->UniqueProcessId);
 	  if (!px->NextEntryOffset)
 	    break;
-	  pxc += px->NextEntryOffset;
+          px = (PSYSTEM_PROCESS_INFORMATION) ((char *) px + px->NextEntryOffset);
 	}
     }
   return nelem;
-- 
2.7.4
