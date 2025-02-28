Return-Path: <SRS0=PYjw=VT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 32CAD385840C
	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2025 13:43:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 32CAD385840C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 32CAD385840C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740750185; cv=none;
	b=jruWquiQB+zKDxltH5vz3BJv/NcFrH2ztvGHJIuzImnftfk0QoNjmCGlF8qSAKPwslySMDOZqoYcFMGECEfp2u6qgW3x5PDHIrMHUD+cFXnXOovrU4vyhthFc7KtZrBho98ZBKgKkXdUfs5uRfR1/mDMtJWXCf2GFuA+k7kFab0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740750185; c=relaxed/simple;
	bh=D+C0umZdUks46PPFjRGZsNABBOvzTSwaS2rf4kFL+gI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vNY0pkXePpFaEzrTjcWqeAYtvyH7TAEZuj+3Sn+gm3wmMIHP+yXpCiUw4kWpyaUHQYKeW5gPyzCp6CchFIGnedQeMeBTtBpjydMZnjA2CmgU3cGh3o1/7gCmlF7oP/dgILMbG14c1qeBatwqxDwccV0Uwz/L2xZ2zZUjBmDL1CY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 32CAD385840C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=e4nRIJqN
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20250228134303555.ETRV.40215.localhost.localdomain@nifty.com>;
          Fri, 28 Feb 2025 22:43:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 2/3] Cygwin: signal: Fix a race issue on modifying _pinfo::process_state
Date: Fri, 28 Feb 2025 22:42:19 +0900
Message-ID: <20250228134231.1701-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250228134231.1701-1-takashi.yano@nifty.ne.jp>
References: <20250228134231.1701-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740750183;
 bh=0OZO4DD5515NhlkHFIEalkTq10CgsOzBw6JoJn2h6B8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=e4nRIJqNtZ33yd/lTaVnrs6h6h3+tKOT6ImtwkISnZvdu3hjJvluVyivHYD1In7naMVOZzd8
 oKM4Od2zCS+GaZr8Pvh4+IAU+zss1Sn91ga/IjCby2603+/KAMMEI3B2c3CFJ1K2goBYk9+Y+o
 zAuLJ+EynS3gXV+Q2p8kzeQtNmSrvPDRlIb82FkEaTSO8hDIX96Xg3eHO5TN6+kl5axVEyiwWH
 10OPG4dQZzK42edBz5/Ins0yvsJlTBXkL9g47lHFahhqP+RdWLbOnn2rZdhMVB0Z5nwbtujVTS
 j8vJU57EytBYyEqBx5M2WtiiIiXD9Rw3m9qrcIIeBBW1VLMg==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The PID_STOPPED flag in _ponfo::process_state is sometimes accidentally
cleared due to a race condition when modifying it with the "|=" or "&="
operators. This patch uses InterlockedOr/And() instead to avoid the
race condition.

Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257473.html
Fixes: 1fd5e000ace55 ("import winsup-2000-02-17 snapshot")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/exceptions.cc          |  6 +++---
 winsup/cygwin/fork.cc                |  5 +++--
 winsup/cygwin/local_includes/pinfo.h |  4 ++--
 winsup/cygwin/pinfo.cc               | 11 ++++++-----
 winsup/cygwin/signal.cc              |  6 ++++--
 winsup/cygwin/sigproc.cc             |  2 +-
 winsup/cygwin/spawn.cc               |  6 +++---
 7 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index c6e82b6c5..45c71cbdf 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -882,7 +882,7 @@ sig_handle_tty_stop (int sig, siginfo_t *, void *)
   /* Silently ignore attempts to suspend if there is no accommodating
      cygwin parent to deal with this behavior. */
   if (!myself->cygstarted)
-    myself->process_state &= ~PID_STOPPED;
+    InterlockedAnd ((LONG *) &myself->process_state, ~PID_STOPPED);
   else
     {
       _my_tls.incyg = 1;
@@ -948,7 +948,7 @@ _cygtls::interrupt_setup (siginfo_t& si, void *handler, struct sigaction& siga)
   if (handler == sig_handle_tty_stop)
     {
       myself->stopsig = 0;
-      myself->process_state |= PID_STOPPED;
+      InterlockedOr ((LONG *) &myself->process_state, PID_STOPPED);
     }
 
   infodata = si;
@@ -1435,7 +1435,7 @@ _cygtls::handle_SIGCONT ()
     yield ();
 
   myself->stopsig = 0;
-  myself->process_state &= ~PID_STOPPED;
+  InterlockedAnd ((LONG *) &myself->process_state, ~PID_STOPPED);
 
   /* Clear pending stop signals */
   sig_clear (SIGSTOP, false);
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 41a533705..783971b76 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -678,8 +678,9 @@ dofork (void **proc, bool *with_forkables)
 
   if (ischild)
     {
-      myself->process_state |= PID_ACTIVE;
-      myself->process_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
+      InterlockedOr ((LONG *) &myself->process_state, PID_ACTIVE);
+      InterlockedAnd ((LONG *) &myself->process_state,
+		      ~(PID_INITIALIZING | PID_EXITED | PID_REAPED));
     }
   else if (res < 0)
     {
diff --git a/winsup/cygwin/local_includes/pinfo.h b/winsup/cygwin/local_includes/pinfo.h
index 4de0f80dd..3086f9941 100644
--- a/winsup/cygwin/local_includes/pinfo.h
+++ b/winsup/cygwin/local_includes/pinfo.h
@@ -271,9 +271,9 @@ public:
   push_process_state (int add_flag)
   {
     flag = add_flag;
-    myself->process_state |= flag;
+    InterlockedOr ((LONG *) &myself->process_state, flag);
   }
-  void pop () { myself->process_state &= ~(flag); }
+  void pop () { InterlockedAnd ((LONG *) &myself->process_state, ~(flag)); }
   ~push_process_state () { pop (); }
 };
 
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 1f26a3ccd..c69213f9a 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -69,7 +69,7 @@ pinfo::thisproc (HANDLE h)
      child_info_spawn::handle_spawn. */
 
   init (cygheap->pid, flags, h);
-  procinfo->process_state |= PID_IN_USE;
+  InterlockedOr ((LONG *) &procinfo->process_state, PID_IN_USE);
   procinfo->dwProcessId = myself_initial.dwProcessId;
   procinfo->sendsig = myself_initial.sendsig;
   wcscpy (procinfo->progname, myself_initial.progname);
@@ -89,7 +89,7 @@ pinfo_init (char **envp, int envc)
     {
       environ_init (envp, envc);
       /* spawn has already set up a pid structure for us so we'll use that */
-      myself->process_state |= PID_CYGPARENT;
+      InterlockedOr ((LONG *) &myself->process_state, PID_CYGPARENT);
     }
   else
     {
@@ -108,10 +108,11 @@ pinfo_init (char **envp, int envc)
       debug_printf ("Set nice to %d", myself->nice);
     }
 
-  myself->process_state |= PID_ACTIVE;
-  myself->process_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
+  InterlockedOr ((LONG *) &myself->process_state, PID_ACTIVE);
+  InterlockedAnd ((LONG *) &myself->process_state,
+		  ~(PID_INITIALIZING | PID_EXITED | PID_REAPED));
   if (being_debugged ())
-    myself->process_state |= PID_DEBUGGED;
+    InterlockedOr ((LONG *) &myself->process_state, PID_DEBUGGED);
   myself.preserve ();
   debug_printf ("pid %d, pgid %d, process_state %y",
 		myself->pid, myself->pgid, myself->process_state);
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index 0bd64963f..f8ba67e75 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -456,9 +456,11 @@ sigaction_worker (int sig, const struct sigaction *newact,
 		sig_clear (sig, true);
 	      if (sig == SIGCHLD)
 		{
-		  myself->process_state &= ~PID_NOCLDSTOP;
+		  InterlockedAnd ((LONG *)&myself->process_state,
+				  ~PID_NOCLDSTOP);
 		  if (gs.sa_flags & SA_NOCLDSTOP)
-		    myself->process_state |= PID_NOCLDSTOP;
+		    InterlockedOr ((LONG *) &myself->process_state,
+				   PID_NOCLDSTOP);
 		}
 	    }
 
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 1ffe00a94..8739f18f5 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -252,7 +252,7 @@ proc_subproc (DWORD what, uintptr_t val)
 	  vchild->sid = myself->sid;
 	  vchild->ctty = myself->ctty;
 	  vchild->cygstarted = true;
-	  vchild->process_state |= PID_INITIALIZING;
+	  InterlockedOr ((LONG *)&vchild->process_state, PID_INITIALIZING);
 	  vchild->ppid = myself->pid;	/* always set last */
 	}
       break;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 8016f0864..06b84236d 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -543,7 +543,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       refresh_cygheap ();
 
       if (c_flags & CREATE_NEW_PROCESS_GROUP)
-	myself->process_state |= PID_NEW_PG;
+	InterlockedOr ((LONG *) &myself->process_state, PID_NEW_PG);
 
       if (mode == _P_DETACH)
 	/* all set */;
@@ -603,7 +603,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       ::cygheap->user.deimpersonate ();
 
       if (!real_path.iscygexec () && mode == _P_OVERLAY)
-	myself->process_state |= PID_NOTCYGWIN;
+	InterlockedOr ((LONG *) &myself->process_state, PID_NOTCYGWIN);
 
       cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
 
@@ -705,7 +705,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      myself->sendsig = myself->exec_sendsig;
 	      myself->exec_sendsig = NULL;
 	    }
-	  myself->process_state &= ~PID_NOTCYGWIN;
+	  InterlockedAnd ((LONG *) &myself->process_state, ~PID_NOTCYGWIN);
 	  /* Reset handle inheritance to default when the execution of a'
 	     non-Cygwin process fails.  Only need to do this for _P_OVERLAY
 	     since the handle will be closed otherwise.  Don't need to do
-- 
2.45.1

