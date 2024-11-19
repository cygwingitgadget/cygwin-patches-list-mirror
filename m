Return-Path: <SRS0=tabE=SO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 66813385840C
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 19:06:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 66813385840C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 66813385840C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732043203; cv=none;
	b=R3twnK879RHVr5MyC+S5USGfsHnvQxC6TK55HIBIrJEAKHkLWl/zaGknxWt2IVZpzRCZwx8hQ20QXcUfNLZlc5Db+qMTqx9SfgaOlDZrZGFLilOLytJ5glx8ZeERXCrmbxbrWkMpvdBZ+gHMyvXCzm0wrLyddQE7+2j2VQScCNk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732043203; c=relaxed/simple;
	bh=JGFhgsSJ/4XSWiBFA4H55ELDvOZsVgjPpKE9UcW3fxE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rhppJnGkRRFcjJdwDN5cmkFPVuh0t/rP0kN7n9qBS8FDL95atmGrFzH5CxG6qfcSV5c9uSgyZ3R9RnBQ+VHzYt26kr/R80GT+AlTeT6xgcvOzJTbY1cIifoR9I9UmVPj/YZZUcFEPD2Km/QoGSw8b9cMLrw9irS1y8QktKV8Itw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CD1CE45C75
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 14:06:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=m7PtZ
	YmQFhOZ9zjkAZ83TGOjYcE=; b=txtzeD0jO6J/PxtbJceMLafjs9G66qgVKSSdN
	pz2xt1pCN5roqqC6zKszSo4vfaaoVQsG5H7QQXnmd8OKVopOZaf28IZUWsMWqVsf
	eVejJIeiU16oQUfqnO6LQB/v1jr8piiUX4EJfIIuqPVdf8hpHz6CCJrFYlZHm0aJ
	UWsn9M=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C945145C61
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 14:06:42 -0500 (EST)
Date: Tue, 19 Nov 2024 11:06:42 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v3] cygthread: suspend thread before terminating.
Message-ID: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com>
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

v3: address review comments (add comments, change nested ifs to &&
conditons), and add CancelSynchronousIo call to try to avoid another
terminate_thread call that I happened to notice.

(I searched for other callers of terminate_thread after this, and the only
one left without CancelSynchronousIo is in ldap.cc and I'm pretty sure
that's a "can't happen" case.)


 winsup/cygwin/cygthread.cc | 14 ++++++++++++++
 winsup/cygwin/pinfo.cc     | 10 +++++++---
 winsup/cygwin/sigproc.cc   | 12 ++++++++++--
 3 files changed, 31 insertions(+), 5 deletions(-)

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
index e31a67d8f4..f1db715951 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -1252,13 +1252,17 @@ proc_waiter (void *arg)

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
+	  /* ERROR_OPERATION_ABORTED is expected due to the possibility that
+	     CancelSynchronousIo interruped the ReadFile call, so don't output
+	     that error */
+	  if (err != ERROR_OPERATION_ABORTED)
+	    system_printf ("error on read of child wait pipe %p, %E", vchild.rd_proc_pipe);
 	  break;
 	}

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 81b6c31695..9e20ae6f71 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -409,7 +409,11 @@ proc_terminate ()
 	     to 1 iff it is a Cygwin process.  */
 	  if (!have_execed || !have_execed_cygwin)
 	    chld_procs[i]->ppid = 1;
-	  if (chld_procs[i].wait_thread)
+	  /* Attempt to exit the wait_thread cleanly via CancelSynchronousIo
+	     before falling back to the (explicitly dangerous) cross-thread
+	     termination */
+	  if (chld_procs[i].wait_thread
+	      && !CancelSynchronousIo (chld_procs[i].wait_thread->thread_handle ()))
 	    chld_procs[i].wait_thread->terminate_thread ();
 	  /* Release memory associated with this process unless it is 'myself'.
 	     'myself' is only in the chld_procs table when we've execed.  We
@@ -1174,7 +1178,11 @@ remove_proc (int ci)
 {
   if (have_execed)
     {
-      if (_my_tls._ctinfo != chld_procs[ci].wait_thread)
+      /* Attempt to exit the wait_thread cleanly via CancelSynchronousIo
+	 before falling back to the (explicitly dangerous) cross-thread
+	 termination */
+      if (_my_tls._ctinfo != chld_procs[ci].wait_thread
+	  && !CancelSynchronousIo (chld_procs[ci].wait_thread->thread_handle ()))
 	chld_procs[ci].wait_thread->terminate_thread ();
     }
   else if (chld_procs[ci] && chld_procs[ci]->exists ())
-- 
2.47.0.windows.2

