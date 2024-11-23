Return-Path: <SRS0=Yvyq=SS=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 6B5093858C42
	for <cygwin-patches@cygwin.com>; Sat, 23 Nov 2024 16:37:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6B5093858C42
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6B5093858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732379846; cv=none;
	b=DkczFzcJSJ0C8kkmreWeqLHY7wnhwJzCSoDF0V2Af/cLKASW4E1Y4PdeK9znDZptJzFmnRm0SS9EjSFnoYYmQDsMqo/B7Ye5JhbuZuc1PoscMaB/1CPtvUaHX5Fn6AMC+iNJ/rva/okBG/VcZAiRLRlS0c21OUUIh8YgoEv8/GU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732379846; c=relaxed/simple;
	bh=9gEns8T4lKpTev/8j5j2uS3z5FlSTye01qQEzMeHof4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=G6yk/am/yt/bYlE5ZsJa+hSozP6UCsC/mfLJDTAwl5lci7zl81YwsnmoVUH1SsP7NazyctNmyOpWE+IepjUgaVkac4bSXjPkCI6fFcZbmF72xTiC3Nbng/tUuSX8r5eKbk8vN65VHJpU0gFgNu+6lhaMGFWcDyKiSPLTcy4+Rc8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6B5093858C42
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=oFVLNR7f
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 10E5745C5A
	for <cygwin-patches@cygwin.com>; Sat, 23 Nov 2024 11:37:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=7cyZC
	7J2GuWyokg+RVPmeQx/jTE=; b=oFVLNR7fDWmGk55VK2VpitWJbg6QYF9pInktt
	aCBHM2n22F++sNrHJbM+Mr6+1N+QnjtcoWTcUp+OW3HNR9W2L27NooE6wyCaO2js
	9jmUMFEa80x9SadEXxx8GjfaA1K0UCN86gOGvVH3des3Y8jxhtD7342vXy6Xdl8c
	Dz+n0c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0A34C45C56
	for <cygwin-patches@cygwin.com>; Sat, 23 Nov 2024 11:37:26 -0500 (EST)
Date: Sat, 23 Nov 2024 08:37:25 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: revert use of CancelSyncronousIo on wait_thread.
Message-ID: <65158100-4a68-30c8-8060-e8fef1861c5d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

It appears this is causing hangs on native x86_64 in similar scenarios
as the hangs on ARM64, because `CancelSynchronousIo` is returning `TRUE`
but not canceling the `ReadFile` call as expected.

Addresses: https://github.com/msys2/MSYS2-packages/issues/4340#issuecomment-2491401847
Fixes: b091b47b9e56 ("cygthread: suspend thread before terminating.")
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
see also https://github.com/msys2/msys2-runtime/pull/243

 winsup/cygwin/pinfo.cc   | 10 +++-------
 winsup/cygwin/sigproc.cc | 12 ++----------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index f1db715951..e31a67d8f4 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -1252,17 +1252,13 @@ proc_waiter (void *arg)

   for (;;)
     {
-      DWORD nb, err;
+      DWORD nb;
       char buf = '\0';

       if (!ReadFile (vchild.rd_proc_pipe, &buf, 1, &nb, NULL)
-	  && (err = GetLastError ()) != ERROR_BROKEN_PIPE)
+	  && GetLastError () != ERROR_BROKEN_PIPE)
 	{
-	  /* ERROR_OPERATION_ABORTED is expected due to the possibility that
-	     CancelSynchronousIo interruped the ReadFile call, so don't output
-	     that error */
-	  if (err != ERROR_OPERATION_ABORTED)
-	    system_printf ("error on read of child wait pipe %p, %E", vchild.rd_proc_pipe);
+	  system_printf ("error on read of child wait pipe %p, %E", vchild.rd_proc_pipe);
 	  break;
 	}

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 9e20ae6f71..81b6c31695 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -409,11 +409,7 @@ proc_terminate ()
 	     to 1 iff it is a Cygwin process.  */
 	  if (!have_execed || !have_execed_cygwin)
 	    chld_procs[i]->ppid = 1;
-	  /* Attempt to exit the wait_thread cleanly via CancelSynchronousIo
-	     before falling back to the (explicitly dangerous) cross-thread
-	     termination */
-	  if (chld_procs[i].wait_thread
-	      && !CancelSynchronousIo (chld_procs[i].wait_thread->thread_handle ()))
+	  if (chld_procs[i].wait_thread)
 	    chld_procs[i].wait_thread->terminate_thread ();
 	  /* Release memory associated with this process unless it is 'myself'.
 	     'myself' is only in the chld_procs table when we've execed.  We
@@ -1178,11 +1174,7 @@ remove_proc (int ci)
 {
   if (have_execed)
     {
-      /* Attempt to exit the wait_thread cleanly via CancelSynchronousIo
-	 before falling back to the (explicitly dangerous) cross-thread
-	 termination */
-      if (_my_tls._ctinfo != chld_procs[ci].wait_thread
-	  && !CancelSynchronousIo (chld_procs[ci].wait_thread->thread_handle ()))
+      if (_my_tls._ctinfo != chld_procs[ci].wait_thread)
 	chld_procs[ci].wait_thread->terminate_thread ();
     }
   else if (chld_procs[ci] && chld_procs[ci]->exists ())
-- 
2.47.0.windows.2

