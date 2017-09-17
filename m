Return-Path: <cygwin-patches-return-8858-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12843 invoked by alias); 17 Sep 2017 02:04:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11620 invoked by uid 89); 17 Sep 2017 02:04:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=process_state, signal.cc, pid_execed, signalcc
X-HELO: limerock03.mail.cornell.edu
Received: from limerock03.mail.cornell.edu (HELO limerock03.mail.cornell.edu) (128.84.13.243) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 17 Sep 2017 02:04:39 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v8H24bEp002460;	Sat, 16 Sep 2017 22:04:37 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id v8H24LfO025218	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Sat, 16 Sep 2017 22:04:36 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 11/12] cygwin: Remove comparison of 'this' to NULL in _pinfo::exists
Date: Sun, 17 Sep 2017 02:05:00 -0000
Message-Id: <20170917020420.10488-11-kbrown@cornell.edu>
In-Reply-To: <20170917020420.10488-1-kbrown@cornell.edu>
References: <20170917020420.10488-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00059.txt.bz2

Fix all callers.
---
 winsup/cygwin/fhandler_termios.cc |  2 +-
 winsup/cygwin/pinfo.cc            |  2 +-
 winsup/cygwin/signal.cc           |  2 +-
 winsup/cygwin/sigproc.cc          |  5 +++--
 winsup/cygwin/times.cc            | 10 +++++++---
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 19fcfc9cd..4ce53433a 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -131,7 +131,7 @@ tty_min::kill_pgrp (int sig)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      if (!p->exists () || p->ctty != ntty || p->pgid != pgid)
+      if (!p || !p->exists () || p->ctty != ntty || p->pgid != pgid)
 	continue;
       if (p == myself)
 	killself = sig != __SIGSETPGRP && !exit_state;
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 7193f6884..e4eef8b3c 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -529,7 +529,7 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
 bool __reg1
 _pinfo::exists ()
 {
-  return this && process_state && !(process_state & (PID_EXITED | PID_REAPED | PID_EXECED));
+  return process_state && !(process_state & (PID_EXITED | PID_REAPED | PID_EXECED));
 }
 
 bool
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index 016fce1de..69c5e2aad 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -332,7 +332,7 @@ kill_pgrp (pid_t pid, siginfo_t& si)
     {
       _pinfo *p = pids[i];
 
-      if (!p->exists ())
+      if (!p || !p->exists ())
 	continue;
 
       /* Is it a process we want to kill?  */
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 36fc64903..92fa5ea3d 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -152,7 +152,8 @@ proc_can_be_signalled (_pinfo *p)
 bool __reg1
 pid_exists (pid_t pid)
 {
-  return pinfo (pid)->exists ();
+  pinfo p (pid);
+  return p && p->exists ();
 }
 
 /* Return true if this is one of our children, false otherwise.  */
@@ -1135,7 +1136,7 @@ remove_proc (int ci)
       if (_my_tls._ctinfo != procs[ci].wait_thread)
 	procs[ci].wait_thread->terminate_thread ();
     }
-  else if (procs[ci]->exists ())
+  else if (procs[ci] && procs[ci]->exists ())
     return true;
 
   sigproc_printf ("removing procs[%d], pid %d, nprocs %d", ci, procs[ci]->pid,
diff --git a/winsup/cygwin/times.cc b/winsup/cygwin/times.cc
index fb480513f..5da0bbc7a 100644
--- a/winsup/cygwin/times.cc
+++ b/winsup/cygwin/times.cc
@@ -522,7 +522,7 @@ clock_gettime (clockid_t clk_id, struct timespec *tp)
 	pid = getpid ();
 
       pinfo p (pid);
-      if (!p->exists ())
+      if (!p || !p->exists ())
 	{
 	  set_errno (EINVAL);
 	  return -1;
@@ -746,8 +746,12 @@ clock_setres (clockid_t clk_id, struct timespec *tp)
 extern "C" int
 clock_getcpuclockid (pid_t pid, clockid_t *clk_id)
 {
-  if (pid != 0 && !pinfo (pid)->exists ())
-    return (ESRCH);
+  if (pid != 0)
+    {
+      pinfo p (pid);
+      if (!p || !p->exists ())
+	return (ESRCH);
+    }
   *clk_id = (clockid_t) PID_TO_CLOCKID (pid);
   return 0;
 }
-- 
2.14.1
