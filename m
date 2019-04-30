Return-Path: <cygwin-patches-return-9391-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74668 invoked by alias); 30 Apr 2019 07:09:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 74658 invoked by uid 89); 30 Apr 2019 07:09:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=H*MI:sk:2019043, createprocess
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Apr 2019 07:09:50 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 09:09:47 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hLMtf-0000rM-LV; Tue, 30 Apr 2019 09:09:47 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH 2/2] Cygwin: fork: Remember child not before success.
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
References: <20190412175825.GD4248@calimero.vinschen.de> <20190430070750.20436-1-michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <dab3c580-772a-d18b-ca77-e2b5f646fcae@ssi-schaefer.com>
Date: Tue, 30 Apr 2019 07:09:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430070750.20436-1-michael.haubenwallner@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00098.txt.bz2

Do not remember the child before it was successfully initialized, or we
would need more sophisticated cleanup on child initialization failure,
like cleaning up the process table and suppressing SIGCHILD delivery
with multiple threads ("waitproc") involved.
---
 winsup/cygwin/fork.cc | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 59b13806c..05d5bb915 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -181,7 +181,8 @@ frok::child (volatile char * volatile here)
   cygheap->fdtab.fixup_after_fork (hParent);
 
   /* Signal that we have successfully initialized, so the parent can
-     - transfer data/bss for dynamically loaded dlls (if any), or
+     - transfer data/bss for dynamically loaded dlls (if any), and
+     - start up some tracker threads to remember the child, or
      - terminate the current fork call even if the child is initialized. */
   sync_with_parent ("performed fork fixups and dynamic dll loading", true);
 
@@ -411,20 +412,6 @@ frok::parent (volatile char * volatile stack_here)
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
 
@@ -508,12 +495,28 @@ frok::parent (volatile char * volatile stack_here)
 	}
     }
 
+  /* Hopefully, this will succeed.  The alternative to doing things this
+     way is to reserve space prior to calling CreateProcess and then fill
+     it in afterwards.  This requires more bookkeeping than I like, though,
+     so we'll just do it the easy way.  So, terminate any child process if
+     we can't actually record the pid in the internal table. */
+  if (!child.remember (false))
+    {
+      this_errno = EAGAIN;
+#ifdef DEBUGGING0
+      error ("child remember failed");
+#endif
+      goto cleanup;
+    }
+
   /* Finally start the child up. */
   resume_child (forker_finished);
 
   ForceCloseHandle (forker_finished);
   forker_finished = NULL;
 
+  yield (); /* For child.remember (), to perform async thread startup. */
+
   return child_pid;
 
 /* Common cleanup code for failure cases */
-- 
2.19.2
