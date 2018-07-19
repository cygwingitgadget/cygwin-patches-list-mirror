Return-Path: <cygwin-patches-return-9131-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 661 invoked by alias); 19 Jul 2018 09:36:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 649 invoked by uid 89); 19 Jul 2018 09:36:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Jul 2018 09:36:05 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6J9a3Ik001937;	Thu, 19 Jul 2018 02:36:03 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdqRC1q1; Thu Jul 19 02:35:53 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] fix duration handling in sigtimedwait
Date: Thu, 19 Jul 2018 09:36:00 -0000
Message-Id: <20180719093540.5156-1-mark@maxrnd.com>
In-Reply-To: <20180718112628.GI27673@calimero.vinschen.de>
References: <20180718112628.GI27673@calimero.vinschen.de>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00026.txt.bz2

---
 winsup/cygwin/signal.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index e581d28da..de3e88697 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -640,6 +640,8 @@ sigtimedwait (const sigset_t *set, siginfo_t *info, const timespec *timeout)
       waittime.QuadPart = (LONGLONG) timeout->tv_sec * NS100PERSEC
                           + ((LONGLONG) timeout->tv_nsec + (NSPERSEC/NS100PERSEC) - 1)
 			    / (NSPERSEC/NS100PERSEC);
+      /* negate waittime to code as duration for NtSetTimer() below cygwait() */
+      waittime.QuadPart = -waittime.QuadPart;
     }
 
   return sigwait_common (set, info, timeout ? &waittime : cw_infinite);
-- 
2.17.0
