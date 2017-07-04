Return-Path: <cygwin-patches-return-8798-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29200 invoked by alias); 4 Jul 2017 14:10:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28083 invoked by uid 89); 4 Jul 2017 14:10:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-spam-relays-external:209.85.192.194, H*RU:209.85.192.194, HTo:U*cygwin-patches
X-HELO: mail-pf0-f194.google.com
Received: from mail-pf0-f194.google.com (HELO mail-pf0-f194.google.com) (209.85.192.194) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Jul 2017 14:10:35 +0000
Received: by mail-pf0-f194.google.com with SMTP id z6so30634286pfk.3        for <cygwin-patches@cygwin.com>; Tue, 04 Jul 2017 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=SvgZodlIGI0eBsYzoCozfwlDqoSfFdvFhahEp0l7O8U=;        b=IAAJmMeX109ZM2cdnwxEek5wEJiitlwKPuVX0g+2uw0i0qxLyVgDgKG6GLesghkGOB         uOgKOTDjDKs/oiwTMXX+cGvCgQTMEJAPWVM+8tcLTzbmbpY5GJeFWVPcW+H+P6MYXI5O         zd82Su06cWRiWeTVAxtJBItqUiP6LRhk06/M1YUeNu9b+ikafjVSqggp6jcHbkIXE2JG         xAoV1KE2SnpY6o2aCEyoQqHdD0JOXg0dQKyV1pPoP7NVtJPV/G1VCl6tTQhZzz1aNCJM         IbfDM4ugt4ELQ/A1RhZ06yvBOKWxBArEvwr27wmyGjeimDndfB7at06BXKkt3DwjlY8G         132Q==
X-Gm-Message-State: AIVw1126U3ZfqGHKB0Zy1mC1M4pFJuAmcX99M25Izc3mq/DwmHqhwJE4	lmBihcyb3vcPeFnvXks=
X-Received: by 10.99.96.194 with SMTP id u185mr1289492pgb.120.1499177434045;        Tue, 04 Jul 2017 07:10:34 -0700 (PDT)
Received: from localhost.localdomain ([63.223.66.152])        by smtp.gmail.com with ESMTPSA id z82sm48139434pfk.1.2017.07.04.07.10.31        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Tue, 04 Jul 2017 07:10:33 -0700 (PDT)
From: comicfans <comicfans44@gmail.com>
To: cygwin-patches@cygwin.com
Cc: comicfans <comicfans44@gmail.com>
Subject: [PATCH] fix incorrect parameter passed from scandirat to scandir
Date: Tue, 04 Jul 2017 14:10:00 -0000
Message-Id: <20170704221014.1623-1-comicfans44@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00000.txt.bz2

fullpath is stored in 'path', but 'pathname' is passed to scandir
---
 winsup/cygwin/syscalls.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index faee928..df7f3c8 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4771,7 +4771,7 @@ scandirat (int dirfd, const char *pathname, struct dirent ***namelist,
       char *path = tp.c_get ();
       if (gen_full_path_at (path, dirfd, pathname))
 	__leave;
-      return scandir (pathname, namelist, select, compar);
+      return scandir (path, namelist, select, compar);
     }
   __except (EFAULT) {}
   __endtry
-- 
2.13.0
