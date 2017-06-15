Return-Path: <cygwin-patches-return-8787-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54625 invoked by alias); 15 Jun 2017 13:31:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54373 invoked by uid 89); 15 Jun 2017 13:30:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=17697, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, sum
X-HELO: mail-wr0-f196.google.com
Received: from mail-wr0-f196.google.com (HELO mail-wr0-f196.google.com) (209.85.128.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Jun 2017 13:30:27 +0000
Received: by mail-wr0-f196.google.com with SMTP id x23so3746415wrb.0        for <cygwin-patches@cygwin.com>; Thu, 15 Jun 2017 06:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id;        bh=h5asnl457xeEino7rEZLvQtHbpHMUGzCRp01lbXiY4s=;        b=X/D6zOrWKZho9GQM/risBNakNBjezMGs4hA+PpMQV3knmgJgOA7sXtvCg1DOeYe7Qm         ZxWrbF7vFSLkHQ61AoTnsWYROaUJBDWhPdaaRsFraJgizJogdV3hqBOkXd9w/c1Uh7fm         6S8sUQTDzbjJodKOT8sCDnyCLBMoJ9L1M8/w5WcsfexZ/ttPytVUdIu0iCaP6q19pj51         Briu7PTrYGxr02iu2mopZaQ2LiHPWggxztf7+Xi3YL9eg9Nct8RAbmRnNPwHUTnHWUA1         iSCxZJnjUZTsmCIVcyxJikRBwmBvmFFjFd1B3t5G2bpkt/nhPuLFa0SgLgCyE3htCptL         5rVA==
X-Gm-Message-State: AKS2vOxGlUBW9Tf9ssuR+5p3WmT1dkPXhWuhfboG7riIr3Ig5EZGS5+N	BWASUoL3vMzfo0TC+fc=
X-Received: by 10.28.92.13 with SMTP id q13mr3711214wmb.20.1497533422901;        Thu, 15 Jun 2017 06:30:22 -0700 (PDT)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id e131sm96259wmd.28.2017.06.15.06.30.22        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 15 Jun 2017 06:30:22 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Ensure that send() interrupted by a signal returns sucessfully
Date: Thu, 15 Jun 2017 13:31:00 -0000
Message-Id: <20170615133008.19708-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00058.txt.bz2

When SA_RESTART is not set on a socket, a blocking send() that is
interrupted mid-transition by a signal should return success (and
report just how many bytes were actually transmitted).

The err variable used here was not always guaranteed to be set
correctly in the loop, so better to just remove it and call
WSAGetLastError() explicitly.
---
 winsup/cygwin/fhandler_socket.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_socket.cc
index f3d1d69..7a6dbdc 100644
--- a/winsup/cygwin/fhandler_socket.cc
+++ b/winsup/cygwin/fhandler_socket.cc
@@ -1769,7 +1769,7 @@ inline ssize_t
 fhandler_socket::send_internal (struct _WSAMSG *wsamsg, int flags)
 {
   ssize_t res = 0;
-  DWORD ret = 0, err = 0, sum = 0;
+  DWORD ret = 0, sum = 0;
   WSABUF out_buf[wsamsg->dwBufferCount];
   bool use_sendmsg = false;
   DWORD wait_flags = flags & MSG_DONTWAIT;
@@ -1830,14 +1830,14 @@ fhandler_socket::send_internal (struct _WSAMSG *wsamsg, int flags)
 	    res = WSASendTo (get_socket (), wsamsg->lpBuffers,
 			     wsamsg->dwBufferCount, &ret, flags,
 			     wsamsg->name, wsamsg->namelen, NULL, NULL);
-	  if (res && (err = WSAGetLastError ()) == WSAEWOULDBLOCK)
+	  if (res && (WSAGetLastError () == WSAEWOULDBLOCK))
 	    {
 	      LOCK_EVENTS;
 	      wsock_events->events &= ~FD_WRITE;
 	      UNLOCK_EVENTS;
 	    }
 	}
-      while (res && err == WSAEWOULDBLOCK
+      while (res && (WSAGetLastError () == WSAEWOULDBLOCK)
 	     && !(res = wait_for_events (FD_WRITE | FD_CLOSE, wait_flags)));
 
       if (!res)
@@ -1851,7 +1851,7 @@ fhandler_socket::send_internal (struct _WSAMSG *wsamsg, int flags)
 	  if (get_socket_type () != SOCK_STREAM || ret < out_len)
 	    break;
 	}
-      else if (is_nonblocking () || err != WSAEWOULDBLOCK)
+      else if (is_nonblocking () || WSAGetLastError() != WSAEWOULDBLOCK)
 	break;
     }
 
-- 
2.8.3
