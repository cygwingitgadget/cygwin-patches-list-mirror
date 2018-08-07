Return-Path: <cygwin-patches-return-9169-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62010 invoked by alias); 7 Aug 2018 05:54:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61998 invoked by uid 89); 7 Aug 2018 05:54:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=worker, Hx-languages-length:1175, initiate, H*r:sk:daemon@
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Aug 2018 05:54:24 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w775sNfR043230;	Mon, 6 Aug 2018 22:54:23 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdII446j; Mon Aug  6 22:54:16 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2] Fix return value on aio_read/write success
Date: Tue, 07 Aug 2018 05:54:00 -0000
Message-Id: <20180807055406.4604-1-mark@maxrnd.com>
In-Reply-To: <20180804202329.GA4180@calimero.vinschen.de>
References: <20180804202329.GA4180@calimero.vinschen.de>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00064.txt.bz2

Internally track resultant byte counts as ssize_t, but return 0 as int
for success indication, per POSIX.
---
 winsup/cygwin/aio.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
index fe63dec04..7d5d98299 100644
--- a/winsup/cygwin/aio.cc
+++ b/winsup/cygwin/aio.cc
@@ -265,7 +265,7 @@ aiowaiter (void *unused)
     }
 }
 
-static int
+static ssize_t
 asyncread (struct aiocb *aio)
 { /* Try to initiate an asynchronous read, either from app or worker thread */
   ssize_t       res = 0;
@@ -296,7 +296,7 @@ asyncread (struct aiocb *aio)
   return res;
 }
 
-static int
+static ssize_t
 asyncwrite (struct aiocb *aio)
 { /* Try to initiate an asynchronous write, either from app or worker thread */
   ssize_t       res = 0;
@@ -712,7 +712,7 @@ aio_read (struct aiocb *aio)
       ; /* I think this is not possible */
     }
 
-  return res;
+  return res < 0 ? (int) res : 0; /* return 0 on success */
 }
 
 ssize_t
@@ -902,7 +902,7 @@ aio_write (struct aiocb *aio)
       ; /* I think this is not possible */
     }
 
-  return res;
+  return res < 0 ? (int) res : 0; /* return 0 on success */
 }
 
 int
-- 
2.17.0
