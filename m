Return-Path: <cygwin-patches-return-8864-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15146 invoked by alias); 17 Sep 2017 02:05:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11600 invoked by uid 89); 17 Sep 2017 02:04:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=process_state, signal.cc, signalcc, UD:signal.cc
X-HELO: limerock01.mail.cornell.edu
Received: from limerock01.mail.cornell.edu (HELO limerock01.mail.cornell.edu) (128.84.13.241) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 17 Sep 2017 02:04:38 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock01.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v8H24agX024133;	Sat, 16 Sep 2017 22:04:36 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v8H24LfN025218	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Sat, 16 Sep 2017 22:04:35 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 10/12] cygwin: Remove comparison of 'this' to 'NULL' in _pinfo::kill
Date: Sun, 17 Sep 2017 02:05:00 -0000
Message-Id: <20170917020420.10488-10-kbrown@cornell.edu>
In-Reply-To: <20170917020420.10488-1-kbrown@cornell.edu>
References: <20170917020420.10488-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00065.txt.bz2

Fix all callers.
---
 winsup/cygwin/signal.cc | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index fbd2b241e..016fce1de 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -260,7 +260,7 @@ _pinfo::kill (siginfo_t& si)
 	}
       this_pid = pid;
     }
-  else if (this && process_state == PID_EXITED)
+  else if (process_state == PID_EXITED)
     {
       this_process_state = process_state;
       this_pid = pid;
@@ -296,8 +296,17 @@ kill0 (pid_t pid, siginfo_t& si)
       syscall_printf ("signal %d out of range", si.si_signo);
       return -1;
     }
-
-  return (pid > 0) ? pinfo (pid)->kill (si) : kill_pgrp (-pid, si);
+  if (pid > 0)
+    {
+      pinfo p (pid);
+      if (!p)
+	{
+	  set_errno (ESRCH);
+	  return -1;
+	}
+      return p->kill (si);
+    }
+  return kill_pgrp (-pid, si);
 }
 
 int
-- 
2.14.1
