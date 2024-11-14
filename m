Return-Path: <SRS0=WwA8=SJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 64F7B3858D20
	for <cygwin-patches@cygwin.com>; Thu, 14 Nov 2024 16:24:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 64F7B3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 64F7B3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731601454; cv=none;
	b=yCgyqYw+Pr692CIXqwNKr4G9l3Gtt9qX6cD0bnWUtbzPTlteqcXddlNvzwbs5btNgoikusVT/GepKy31k14zCk8w72Uh462IGW5tQqDiIenLHGhVKZucioA/lJj+Xmng2AQDuQNYgzDkFHfiyvGcCHsS+KksVkA2g8UnGc2vYPo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731601454; c=relaxed/simple;
	bh=JoPvC1AB/+W45lsy6siHCLcBhGEycj/oT8k6d+H/xtU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=OLyiqtiiCQXi96EPAggSzPehH0EBCjO7cXfem/9VS6mplZUPPG2TS85zuU9nGbMYjvuXsy2qhe7QFY+hdYNV1Vz6K9Hmpxq1+WCOa4/gKnSDEp6wSR8I8d6g7Ib4xzOTeqZXLDSmSDQhP2BDRZzpPyeyUrYBHjvrP6eCGmwGLc4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 64F7B3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=lnIFLyU0
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4FBF745C4D
	for <cygwin-patches@cygwin.com>; Thu, 14 Nov 2024 11:24:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=+i5/u
	Re9eVqH+jB6VO2r6jc+qT8=; b=lnIFLyU0MHzfxqM2ikRZlC2eKC37MboBWufL5
	x8FyeMbTf19jOTjXA00SEysMFqPvhs0kbYXcGrP6l5FCOwrQjoSb5Cm8E/QsdT3O
	KVS7uZMXVnrjOwoC0VZOuabCl9UfaN42O8yjhHNtA60MgXGnuzewIVGee9WGH35s
	8XQ5iU=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 2510645C3D
	for <cygwin-patches@cygwin.com>; Thu, 14 Nov 2024 11:24:13 -0500 (EST)
Date: Thu, 14 Nov 2024 08:24:11 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] cygthread: suspend thread before terminating.
Message-ID: <ac88704b-3f63-1f14-3412-4acce012f729@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

This addresses an extremely difficult to debug deadlock when running
under emulation on ARM64.

A relatively easy way to trigger this bug is to call `fork()`, then within the
child process immediately call another `fork()` and then `exit()` the
intermediate process.

It would seem that there is a "code emulation" lock on the wait thread at
this stage, and if the thread is terminated too early, that lock still exists
albeit without a thread, and nothing moves forward.

It seems that a `SuspendThread()` combined with a `GetThreadContext()`
(to force the thread to _actually_ be suspended, for more details see
https://devblogs.microsoft.com/oldnewthing/20150205-00/?p=44743)
makes sure the thread is "booted" from emulation before it is suspended.

Hopefully this means it won't be holding any locks or otherwise leave
emulation in a bad state when the thread is terminated.

Also, attempt to use `CancelSynchonousIo()` (as seen in `flock.cc`) to avoid
the need for `TerminateThread()` altogether.  This doesn't always work,
however, so was not a complete fix for the deadlock issue.

Addresses: https://cygwin.com/pipermail/cygwin-developers/2024-May/012694.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

v2: suppress output for a now-expected error in `proc_waiter` due to the
addition of the CancelSynchronousIo call in `proc_terminate`


 winsup/cygwin/cygthread.cc | 14 ++++++++++++++
 winsup/cygwin/pinfo.cc     |  7 ++++---
 winsup/cygwin/sigproc.cc   |  3 ++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/cygthread.cc b/winsup/cygwin/cygthread.cc
index 54918e7677..4f16097531 100644
--- a/winsup/cygwin/cygthread.cc
+++ b/winsup/cygwin/cygthread.cc
@@ -302,6 +302,20 @@ cygthread::terminate_thread ()
   if (!inuse)
     goto force_notterminated;

+  if (_my_tls._ctinfo != this)
+    {
+      CONTEXT context;
+      context.ContextFlags = CONTEXT_CONTROL;
+      /* SuspendThread makes sure a thread is "booted" from emulation before
+	 it is suspended.  As such, the emulator hopefully won't be in a bad
+	 state (aka, holding any locks) when the thread is terminated. */
+      SuspendThread (h);
+      /* We need to call GetThreadContext, even though we don't care about the
+	 context, because SuspendThread is asynchronous and GetThreadContext
+	 will make sure the thread is *really* suspended before returning */
+      GetThreadContext (h, &context);
+    }
+
   TerminateThread (h, 0);
   WaitForSingleObject (h, INFINITE);
   CloseHandle (h);
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index e31a67d8f4..2395c36665 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -1252,13 +1252,14 @@ proc_waiter (void *arg)

   for (;;)
     {
-      DWORD nb;
+      DWORD nb, err;
       char buf = '\0';

       if (!ReadFile (vchild.rd_proc_pipe, &buf, 1, &nb, NULL)
-	  && GetLastError () != ERROR_BROKEN_PIPE)
+	  && (err = GetLastError ()) != ERROR_BROKEN_PIPE)
 	{
-	  system_printf ("error on read of child wait pipe %p, %E", vchild.rd_proc_pipe);
+	  if (err != ERROR_OPERATION_ABORTED)
+	    system_printf ("error on read of child wait pipe %p, %E", vchild.rd_proc_pipe);
 	  break;
 	}

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 81b6c31695..360bdac232 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -410,7 +410,8 @@ proc_terminate ()
 	  if (!have_execed || !have_execed_cygwin)
 	    chld_procs[i]->ppid = 1;
 	  if (chld_procs[i].wait_thread)
-	    chld_procs[i].wait_thread->terminate_thread ();
+	    if (!CancelSynchronousIo (chld_procs[i].wait_thread->thread_handle ()))
+	      chld_procs[i].wait_thread->terminate_thread ();
 	  /* Release memory associated with this process unless it is 'myself'.
 	     'myself' is only in the chld_procs table when we've execed.  We
 	     reach here when the next process has finished initializing but we
-- 
2.47.0.windows.2

