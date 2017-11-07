Return-Path: <cygwin-patches-return-8905-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112333 invoked by alias); 7 Nov 2017 13:45:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112293 invoked by uid 89); 7 Nov 2017 13:45:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=sock, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f46.google.com
Received: from mail-wm0-f46.google.com (HELO mail-wm0-f46.google.com) (74.125.82.46) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Nov 2017 13:45:00 +0000
Received: by mail-wm0-f46.google.com with SMTP id y83so3943638wmc.4        for <cygwin-patches@cygwin.com>; Tue, 07 Nov 2017 05:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id;        bh=FHYh4MgrFip47JylsTnb4RJAmheLSZB22XnCUY5FpIg=;        b=WGIuRLbX+oChtNlZ4KZjD+kwVY6yVXL2dCEsXg0RVELxwiDl2C3t8Yfs89QyylEXV/         7Lb8H1i7pEu8xtB06gnB41xV2DqRbZaVCJhIrJ80RTvFbEvoCinwxOcuRxDPb7fQDvpp         /SuyTKr2OzAlYLNcaVx+VC/d+60ACgegA8IGl2wVGM5eaqzac4dw4kEsKASpwWotz0K1         1FqHKwpTG73XNdStfnbtOraA/Kr5TYArtfaQsCZfcJONuWIjjQqhSXwO+mbDeF07xBaQ         n9F4Ir663+3nT2GBqSyc07RwpiByZ4J+DpbcHD7DtebDUxBkBz2nl98CtKPwamUhcl5I         WroQ==
X-Gm-Message-State: AJaThX6iTzpi/o2WswyJliZpEJMrTR/g0VD07hfM93BpeHPdDimtfGNh	puB5EQbAA/O8iZED52I7bdOXGJxn
X-Google-Smtp-Source: ABhQp+R2zbvSf5YGzfV2pTGL4xNbOMn8tBq42LERuhMHhVU80AkbHupYNx3eJZJi/J58Rbp1vm1OrQ==
X-Received: by 10.28.241.10 with SMTP id p10mr1340807wmh.113.1510062297546;        Tue, 07 Nov 2017 05:44:57 -0800 (PST)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id 50sm723826wry.84.2017.11.07.05.44.56        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Tue, 07 Nov 2017 05:44:56 -0800 (PST)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix two bugs in the limit of large numbers of sockets:
Date: Tue, 07 Nov 2017 13:45:00 -0000
Message-Id: <20171107134449.11532-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00035.txt.bz2

* Fix the maximum number of sockets allowed in the session to 2048,
  instead of making it relative to sizeof(wsa_event).

  The original choice of 2048 was in order to fit the wsa_events array
  in the .cygwin_dll_common shared section, but there is still enough
  room to grow there to have 2048 sockets on 64-bit as well.

* Return an error and set errno=ENOBUF if a socket can't be created
  due to this limit being reached.
---
 winsup/cygwin/fhandler_socket.cc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_socket.cc
index 7a6dbdc..b8eda57 100644
--- a/winsup/cygwin/fhandler_socket.cc
+++ b/winsup/cygwin/fhandler_socket.cc
@@ -496,7 +496,7 @@ fhandler_socket::af_local_set_secret (char *buf)
 /* Maximum number of concurrently opened sockets from all Cygwin processes
    per session.  Note that shared sockets (through dup/fork/exec) are
    counted as one socket. */
-#define NUM_SOCKS       (32768 / sizeof (wsa_event))
+#define NUM_SOCKS       ((unsigned int) 2048)
 
 #define LOCK_EVENTS	\
   if (wsock_mtx && \
@@ -623,7 +623,14 @@ fhandler_socket::init_events ()
       NtClose (wsock_mtx);
       return false;
     }
-  wsock_events = search_wsa_event_slot (new_serial_number);
+  if (!(wsock_events = search_wsa_event_slot (new_serial_number)));
+    {
+      set_errno (ENOBUFS);
+      NtClose (wsock_evt);
+      NtClose (wsock_mtx);
+      return false;
+    }
+
   /* sock type not yet set here. */
   if (pc.dev == FH_UDP || pc.dev == FH_DGRAM)
     wsock_events->events = FD_WRITE;
-- 
2.8.3
