Return-Path: <cygwin-patches-return-9376-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79344 invoked by alias); 23 Apr 2019 14:56:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79330 invoked by uid 89); 23 Apr 2019 14:56:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: mail-wr1-f51.google.com
Received: from mail-wr1-f51.google.com (HELO mail-wr1-f51.google.com) (209.85.221.51) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Apr 2019 14:56:03 +0000
Received: by mail-wr1-f51.google.com with SMTP id g3so20607492wrx.9        for <cygwin-patches@cygwin.com>; Tue, 23 Apr 2019 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=from:to:subject:date:message-id;        bh=45BXT+JNZG+pxtMKEY65EqF3sVToMRw37gELgdIMxUA=;        b=rV3wtQrd0KYo7SM/0dhoD6fqfCvA1LQhSC95NIxZKEeG5qE80krXfeiM9Wz8sJACWP         QLzLAb2X20AEOb9Fo4D+6i2t3eXB7ont4oziooyXNdKS8lONim8Tr9BGFacIGQc7uJzY         hR0ozLBouGXxSb2iUmQwMoivUFNkHiYcJJBrPprbaFGmbMJsBcBO8GFjYw0qrDzO0WUA         F/ftt66+37p/lwKCNeyYTm4YJyBoiPNQJuDlwTyteqdxHfJ9eh19Q7gCRjy7XilY3xlt         hB89k4UQAtEth/wchSRv/zvOBlcxNs0tdxgKrFIiBGGqSxq33agzClm9GCvtGNZ2K6Ui         B+/w==
Return-Path: <erik.m.bray@gmail.com>
Received: from smtp.lri.fr (lri30-247.lri.fr. [129.175.30.247])        by smtp.gmail.com with ESMTPSA id 13sm14650770wmf.23.2019.04.23.07.55.59        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Tue, 23 Apr 2019 07:56:00 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Minor improvements to socket error handling:
Date: Tue, 23 Apr 2019 14:56:00 -0000
Message-Id: <20190423145533.34172-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00083.txt.bz2

* Change default fallback for failed winsock error -> POSIX error
  mappings to EACCES, which is a valid errno for more socket-related
  syscalls.

* Added a few previously missing entries to the wsock_errmap table
  that have obvious POSIX errno.h analogues.
---
 winsup/cygwin/net.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index cd296d19d..437712c63 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -177,6 +177,9 @@ static const errmap_t wsock_errmap[] = {
   {WSAEREMOTE, "WSAEREMOTE", EREMOTE},
   {WSAEINVAL, "WSAEINVAL", EINVAL},
   {WSAEFAULT, "WSAEFAULT", EFAULT},
+  {WSAEBADF, "WSAEBADF", EBADF},
+  {WSAEACCES, "WSAEACCES", EACCES},
+  {WSAEMFILE, "WSAEMFILE", EMFILE},
   {0, "NOERROR", 0},
   {0, NULL, 0}
 };
@@ -188,7 +191,7 @@ find_winsock_errno (DWORD why)
     if (why == wsock_errmap[i].w)
       return wsock_errmap[i].e;
 
-  return EPERM;
+  return EACCES;
 }
 
 void
-- 
2.15.1
