Return-Path: <cygwin-patches-return-9327-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23326 invoked by alias); 12 Apr 2019 13:31:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23054 invoked by uid 89); 12 Apr 2019 13:31:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=H*r:4.77, dll, H*RU:sk:michael, H*r:sk:michael
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Apr 2019 13:31:44 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 15:31:41 +0200
Received: from fril0049.wamas.com ([172.28.42.244])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hEwHM-0004w4-8Y; Fri, 12 Apr 2019 15:31:40 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] Cygwin: fork: remember child as late as possible
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <2cc9ac65-ff3c-f88e-e8d3-13105115bdcf@ssi-schaefer.com>
Date: Fri, 12 Apr 2019 13:31:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00034.txt.bz2

Otherwise, when the child does fail to reload dlls and terminates, we
produce a SIGCHILD signal, even if we did not succeed in starting up the
child process at all.  Also, we would need to reap that child somewhere.
---
 winsup/cygwin/fork.cc | 71 ++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 74ee9acf4..a5b45f851 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -186,14 +186,14 @@ frok::child (volatile char * volatile here)
 
   cygheap->fdtab.fixup_after_fork (hParent);
 
-  /* If we haven't dynamically loaded any dlls, just signal the parent.
-     Otherwise, tell the parent that we've loaded all the dlls
-     and wait for the parent to fill in the loaded dlls' data/bss. */
-  if (!load_dlls)
-    sync_with_parent ("performed fork fixup", false);
-  else
+  /* If we have dynamically loaded some dlls, we need anoter stop to
+     wait for the parent to fill in the loaded dll's data/bss. */
+  if (load_dlls)
     sync_with_parent ("loaded dlls", true);
 
+  /* Signal the parent. */
+  sync_with_parent ("performed fork fixup", false);
+
   init_console_handler (myself->ctty > 0);
   ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
 
@@ -420,20 +420,6 @@ frok::parent (volatile char * volatile stack_here)
   child.hProcess = hchild;
   ch.postfork (child);
 
-  /* Hopefully, this will succeed.  The alternative to doing things this
-     way is to reserve space prior to calling CreateProcess and then fill
-     it in afterwards.  This requires more bookkeeping than I like, though,
-     so we'll just do it the easy way.  So, terminate any child process if
-     we can't actually record the pid in the internal table. */
-  if (!child.remember (false))
-    {
-      this_errno = EAGAIN;
-#ifdef DEBUGGING0
-      error ("child remember failed");
-#endif
-      goto cleanup;
-    }
-
   /* CHILD IS STOPPED */
   debug_printf ("child is alive (but stopped)");
 
@@ -483,20 +469,20 @@ frok::parent (volatile char * volatile stack_here)
 	}
     }
 
-  /* Start thread, and then wait for it to reload dlls.  */
-  resume_child (forker_finished);
-  if (!ch.sync (child->pid, hchild, FORK_WAIT_TIMEOUT))
-    {
-      this_errno = EAGAIN;
-      error ("died waiting for dll loading");
-      goto cleanup;
-    }
-
   /* If DLLs were loaded in the parent, then the child has reloaded all
      of them and is now waiting to have all of the individual data and
      bss sections filled in. */
   if (load_dlls)
     {
+      /* Start the child up, and then wait for it to reload dlls.  */
+      resume_child (forker_finished);
+      if (!ch.sync (child->pid, hchild, FORK_WAIT_TIMEOUT))
+	{
+	  this_errno = EAGAIN;
+	  error ("died waiting for dll loading");
+	  goto cleanup;
+	}
+
       /* CHILD IS STOPPED */
       /* write memory of reloaded dlls */
       for (dll *d = dlls.istart (DLL_LOAD); d; d = dlls.inext ())
@@ -514,8 +500,31 @@ frok::parent (volatile char * volatile stack_here)
 	      goto cleanup;
 	    }
 	}
-      /* Start the child up again. */
-      resume_child (forker_finished);
+    }
+
+  /* Hopefully, this will succeed.  The alternative to doing things this
+     way is to reserve space prior to calling CreateProcess and then fill
+     it in afterwards.  This requires more bookkeeping than I like, though,
+     so we'll just do it the easy way.  So, terminate any child process if
+     we can't actually record the pid in the internal table.
+     Note: child.remember () needs the subsequent WFMO in ch.sync (),
+     to perform the asynchronous start of the controlling threads. */
+  if (!child.remember (false))
+    {
+      this_errno = EAGAIN;
+#ifdef DEBUGGING0
+      error ("child remember failed");
+#endif
+      goto cleanup;
+    }
+
+  /* Start the child up, finally. */
+  resume_child (forker_finished);
+  if (!ch.sync (child->pid, hchild, FORK_WAIT_TIMEOUT))
+    {
+      this_errno = EAGAIN;
+      error ("died waiting for dll loading");
+      goto cleanup;
     }
 
   ForceCloseHandle (forker_finished);
-- 
2.19.2
