Return-Path: <cygwin-patches-return-9399-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13691 invoked by alias); 2 May 2019 10:12:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13680 invoked by uid 89); 2 May 2019 10:12:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=needless, tracker, 24h, createprocess
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 May 2019 10:12:53 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 12:12:49 +0200
Received: from [172.28.53.61]	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hM8ht-0002Ac-BP; Thu, 02 May 2019 12:12:49 +0200
Subject: Re: [PATCH 2/2] Cygwin: fork: Remember child not before success.
References: <20190412175825.GD4248@calimero.vinschen.de> <20190430070750.20436-1-michael.haubenwallner@ssi-schaefer.com> <dab3c580-772a-d18b-ca77-e2b5f646fcae@ssi-schaefer.com> <20190430160725.GM3383@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <9757474d-767d-e450-67c0-2fd2be3aa4b9@ssi-schaefer.com>
Date: Thu, 02 May 2019 10:12:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430160725.GM3383@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------A7E4F78B8CE0B747329F8E55"
X-SW-Source: 2019-q2/txt/msg00106.txt.bz2

This is a multi-part message in MIME format.
--------------A7E4F78B8CE0B747329F8E55
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1175

On 4/30/19 6:07 PM, Corinna Vinschen wrote:
> On Apr 30 09:09, Michael Haubenwallner wrote:
>> Do not remember the child before it was successfully initialized, or we
>> would need more sophisticated cleanup on child initialization failure,
>> like cleaning up the process table and suppressing SIGCHILD delivery
>> with multiple threads ("waitproc") involved.
>> ---
>>  winsup/cygwin/fork.cc | 33 ++++++++++++++++++---------------
>>  1 file changed, 18 insertions(+), 15 deletions(-)
>> [...]
>> +  yield (); /* For child.remember (), to perform async thread startup. */
> 
> Is that really necessary?  What's that fixing and what effect does this
> have on the performance of the already very slow fork()?

Indeed, that's needless.  Testing around the original patch in this thread
did lead me to the idea that the "waitproc" cygthread is started using
QueueUserAPC and async_startup, being executed by WFMO in ch.sync, which
I've reduced to yield later on.  But apparently I've been wrong here and the
waitproc thread is started synchronously.  Performance wise, I found it
negligible, but admitted I didn't perform the full >24h build.

Patch updated.

Thanks!
/haubi/

--------------A7E4F78B8CE0B747329F8E55
Content-Type: text/x-patch;
 name="0001-Cygwin-fork-Remember-child-not-before-success.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Cygwin-fork-Remember-child-not-before-success.patch"
Content-length: 2836

From 69c21e8e5d19cc6ec205a4e44d6b84542b1fef98 Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Mon, 29 Apr 2019 16:03:51 +0200
Subject: [PATCH] Cygwin: fork: Remember child not before success.

Do not remember the child before it was successfully initialized, or we
would need more sophisticated cleanup on child initialization failure,
like cleaning up the process table and suppressing SIGCHILD delivery
with multiple threads ("waitproc") involved.  Compared to that, the
potential slowdown due to an extra yield () call should be negligible.
---
 winsup/cygwin/fork.cc | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 59b13806c..c69081fc0 100644
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
 
@@ -508,6 +495,20 @@ frok::parent (volatile char * volatile stack_here)
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
 
-- 
2.19.2


--------------A7E4F78B8CE0B747329F8E55--
