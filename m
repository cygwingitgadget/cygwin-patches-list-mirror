Return-Path: <cygwin-patches-return-9538-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14506 invoked by alias); 31 Jul 2019 10:36:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14493 invoked by uid 89); 31 Jul 2019 10:36:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=goto, prepares, INFINITE, closehandle
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Jul 2019 10:36:10 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 12:36:08 +0200
Received: from fril0049.wamas.com ([172.28.42.244] helo=wamas.com)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <haubi@wamas.com>)	id 1hslxn-0000IU-Qf; Wed, 31 Jul 2019 12:36:07 +0200
Received: with nullmailer 2.2;	Wed, 31 Jul 2019 10:36:07 -0000
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH v2 1/2] Cygwin: pinfo: stop remember doing reattach
Date: Wed, 31 Jul 2019 10:36:00 -0000
Message-Id: <20190731103531.559-2-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <20190731103531.559-1-michael.haubenwallner@ssi-schaefer.com>
References: <20190730160754.GZ11632@calimero.vinschen.de> <20190731103531.559-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q3/txt/msg00058.txt.bz2

During fork, the child process requires the process table to be
initialized for fixup_shms_after_fork, while still allowing subsequent
dlls.load_after_fork to fail silently (for when the "forkable" hardlinks
are not created yet).
pinfo::remember not performing reattach anymore requires explicit
pinfo::reattach now where appropriate.

Prepares to improve "Cygwin: fork: Remember child not before success."
commit f03ea8e1c57bd5cea83f6cd47fa02870bdfeb1c5, which leads to fork
problems if cygserver is running:

https://cygwin.com/ml/cygwin-patches/2019-q2/msg00155.html
---
 winsup/cygwin/fork.cc    | 8 ++++++++
 winsup/cygwin/sigproc.cc | 7 +++----
 winsup/cygwin/spawn.cc   | 4 +++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 59b13806c..0119581df 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -421,6 +421,14 @@ frok::parent (volatile char * volatile stack_here)
       this_errno = EAGAIN;
 #ifdef DEBUGGING0
       error ("child remember failed");
+#endif
+      goto cleanup;
+    }
+  if (!child.reattach ())
+    {
+      this_errno = EAGAIN;
+#ifdef DEBUGGING0
+      error ("child reattach failed");
 #endif
       goto cleanup;
     }
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 900facd58..8003e2db6 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -216,9 +216,7 @@ proc_subproc (DWORD what, uintptr_t val)
 	  vchild->process_state |= PID_INITIALIZING;
 	  vchild->ppid = what == PROC_DETACHED_CHILD ? 1 : myself->pid;	/* always set last */
 	}
-      if (what == PROC_DETACHED_CHILD)
-	break;
-      /* fall through intentionally */
+      break;
 
     case PROC_REATTACH_CHILD:
       procs[nprocs] = vchild;
@@ -873,7 +871,8 @@ void
 child_info_spawn::wait_for_myself ()
 {
   postfork (myself);
-  myself.remember (false);
+  if (myself.remember (false))
+    myself.reattach ();
   WaitForSingleObject (ev, INFINITE);
 }
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 579b3c9c3..f719410a8 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -779,7 +779,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  child->start_time = time (NULL); /* Register child's starting time. */
 	  child->nice = myself->nice;
 	  postfork (child);
-	  if (!child.remember (mode == _P_DETACH))
+	  if (mode == _P_DETACH ?
+	      !child.remember (true) :
+	      !(child.remember (false) && child.reattach ()))
 	    {
 	      /* FIXME: Child in strange state now */
 	      CloseHandle (pi.hProcess);
-- 
2.21.0
