Return-Path: <SRS0=/AB6=SH=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 106C03858C41
	for <cygwin-patches@cygwin.com>; Tue, 12 Nov 2024 22:46:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 106C03858C41
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 106C03858C41
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731451563; cv=none;
	b=Mlz2hdNEWcd4C6EsP/SZMjYs2l5g1t3qlVC7Nj9YT34xObT67z+CTzyo14BUtgzRdalbRu+1I3Cjypee3xAQLDv6IYiTmsv8Gaij+ktacBcNym0cloML4AXgRA21CSDod6EIRX5RnH9UO/Euxzh+ehWbjE75lMepRO2SMnkad/o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731451563; c=relaxed/simple;
	bh=sualqAV4rxUDQpse1zkyJEz1TR0/x018TP+HaqyD94o=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=K3nWofJiXwkJqCVpYBPDeLYAnYyA9j/qJFp8eTRPzfm1Qua3sNB83HLNX59O06I0J6Wo6gnkF837AV0IywhdEnOqSfwYjmuQzM4fyEWtagss7t6pQR/couORQHtBXrEwLbrokg8TfphRgu8GB+p8/+h/ZC1/P+kcoAPSr3Z7w0M=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 78A4C45C69
	for <cygwin-patches@cygwin.com>; Tue, 12 Nov 2024 17:46:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=VGDZY
	y1VX29y4g/u8MhNrN/xjFI=; b=hYjdJSDqbJxl3+w0EB//VdKbxUbXIefuxXNZ3
	zW+8RQrj3ijuuUclDsv5UjLQY6wUmq6D5RP3u6X86a3X+MqR+iPOExpcjloVRvap
	pAWrN9etuOQryGeKB+NoZ3qB1QP1d+/W3xCyvt24RSsqJuu5TWekxuZKTUrE2Xh0
	rUsO6Y=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 72C4845C4D
	for <cygwin-patches@cygwin.com>; Tue, 12 Nov 2024 17:46:00 -0500 (EST)
Date: Tue, 12 Nov 2024 14:46:00 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygthread: suspend thread before terminating.
Message-ID: <2c68d6fe-5493-b7e0-6335-de5a68d3cd3f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/cygthread.cc | 14 ++++++++++++++
 winsup/cygwin/sigproc.cc   |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

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

