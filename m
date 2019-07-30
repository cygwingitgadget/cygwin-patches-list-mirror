Return-Path: <cygwin-patches-return-9534-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26027 invoked by alias); 30 Jul 2019 15:24:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26011 invoked by uid 89); 30 Jul 2019 15:24:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=UD:cygwin.com, cygwincom, cygwin.com
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Jul 2019 15:24:32 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 17:24:27 +0200
Received: from [172.28.42.244] (helo=wamas.com)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <haubi@wamas.com>)	id 1hsTzH-0002uP-Fd; Tue, 30 Jul 2019 17:24:27 +0200
Received: with nullmailer 2.2;	Tue, 30 Jul 2019 15:24:27 -0000
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 1/2] Cygwin: pinfo: new remember_without_attach method
Date: Tue, 30 Jul 2019 15:24:00 -0000
Message-Id: <20190730152256.22873-2-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <20190730152256.22873-1-michael.haubenwallner@ssi-schaefer.com>
References: <20190730152256.22873-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q3/txt/msg00054.txt.bz2

During fork, the child process requires the process table to be
initialized for fixup_shms_after_fork, while still allowing subsequent
dlls.load_after_fork to fail silently (for when the "forkable" hardlinks
are not created yet).

Prepares to improve "Cygwin: fork: Remember child not before success."
commit f03ea8e1c57bd5cea83f6cd47fa02870bdfeb1c5, which leads to fork
problems if cygserver is running:

https://cygwin.com/ml/cygwin-patches/2019-q2/msg00155.html
---
 winsup/cygwin/pinfo.h    | 9 ++++++++-
 winsup/cygwin/sigproc.cc | 4 +---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/pinfo.h b/winsup/cygwin/pinfo.h
index 8cf1bba2e..35f6f5ac6 100644
--- a/winsup/cygwin/pinfo.h
+++ b/winsup/cygwin/pinfo.h
@@ -195,13 +195,20 @@ public:
     destroy = res ? false : true;
     return res;
   }
-  int remember (bool detach)
+  int remember_without_attach (bool detach)
   {
     int res = proc_subproc (detach ? PROC_DETACHED_CHILD : PROC_ADDCHILD,
 			    (uintptr_t) this);
     destroy = res ? false : true;
     return res;
   }
+  int remember (bool detach)
+  {
+    int res = remember_without_attach (detach);
+    if (res && !detach)
+      res = reattach ();
+    return res;
+  }
 #endif
   HANDLE shared_handle () {return h;}
   HANDLE shared_winpid_handle () {return winpid_hdl;}
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 900facd58..9af47ce48 100644
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
-- 
2.21.0
