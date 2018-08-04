Return-Path: <cygwin-patches-return-9165-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99448 invoked by alias); 4 Aug 2018 08:44:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99437 invoked by uid 89); 4 Aug 2018 08:44:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=H*Ad:U*mark, Hx-languages-length:778
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 04 Aug 2018 08:44:48 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w748iknU096051;	Sat, 4 Aug 2018 01:44:46 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdZ5XS7k; Sat Aug  4 01:44:41 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Fix return value on aio_read/write success
Date: Sat, 04 Aug 2018 08:44:00 -0000
Message-Id: <20180804084426.4128-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00060.txt.bz2

Oops. Something that iozone testing had found but I regarded as an
iozone bug.  Re-reading the man pages set me straight.
---
 winsup/cygwin/aio.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
index fe63dec04..571a9621b 100644
--- a/winsup/cygwin/aio.cc
+++ b/winsup/cygwin/aio.cc
@@ -712,7 +712,7 @@ aio_read (struct aiocb *aio)
       ; /* I think this is not possible */
     }
 
-  return res;
+  return res < 0 ? res : 0; /* Return 0 on success, not byte count */
 }
 
 ssize_t
@@ -902,7 +902,7 @@ aio_write (struct aiocb *aio)
       ; /* I think this is not possible */
     }
 
-  return res;
+  return res < 0 ? res : 0; /* Return 0 on success, not byte count */
 }
 
 int
-- 
2.17.0
