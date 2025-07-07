Return-Path: <SRS0=hEVR=ZU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id EAFFB3858D32
	for <cygwin-patches@cygwin.com>; Mon,  7 Jul 2025 18:33:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EAFFB3858D32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EAFFB3858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751913213; cv=none;
	b=gaA/EpCErtm10xOq+T3GxZkFl9tPxVTed402cMxzmoNhDaAbVFLRoy7wpyKdZaGKzlaOCMUd8su9Bvxz2IQIU8k3szKitI/NvCbxjgl2aZ8i2jMZKFswex1iUFZyekEswzBCmXvlCGBlhJdyXsuL6l/4mM1+zNDDmN5f/tovt1I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751913213; c=relaxed/simple;
	bh=ySAlXQy5t6vE3twUmrlAsQuSAYVVAtV7kRgpBqfYN50=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZwMgEBr9J+I/3xopMCkK6q/CnAZ9dgNZ3zeei7W1loNri2efKmlBoyFXistap2sMzuAeaN2FTl1HROZXzpQ+LoXxp8bK8ojVvh9tlAqd11E3Zvop5Br+tFsQ++dPgsjDcGwtMxit2I01dx5Dyudq1udMrwPWeApSYQ2wTWVcAys=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EAFFB3858D32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=vkiZxRZM
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9986C45C0C
	for <cygwin-patches@cygwin.com>; Mon, 07 Jul 2025 14:33:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=vvuvg
	Vy/aQDE4qlVNetcQ77dvyo=; b=vkiZxRZMr3BF/fsm129bbLKsTSaY32aDV13t8
	97w7YE6ha2vKLTNqyt9UtkBvf1U8gRHXnBiSU/iDiPYx9TOQiJs5qmY4loszS78u
	7JhXzHLX+g03FmBOobI4BB5bmQaEQ1Cc1gPbHpoTFk4KWnAMNlCousy2Ij9FWODx
	FijYLs=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 802B745A25
	for <cygwin-patches@cygwin.com>; Mon, 07 Jul 2025 14:33:32 -0400 (EDT)
Date: Mon, 7 Jul 2025 11:33:32 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: spawn: apply PID_NEW_PG flag to spawned child
Message-ID: <82c767ad-97d0-ea70-1e1f-2590c8d3a8ca@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, it was always applied to "myself", which is only appropriate
in the case of _P_OVERLAY (aka exec).  Apply the flag to "myself" only
in that case, and apply it to the new child instead in other cases.
Also, clear the flag from "myself" in the case of a failed exec.

Fixes: 8d8724ee1b5a ("Cygwin: pty: Fix Ctrl-C handling further for non-cygwin apps.")
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/spawn.cc | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index ef175e7082..cb58b6eed0 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -544,9 +544,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
       refresh_cygheap ();

-      if (c_flags & CREATE_NEW_PROCESS_GROUP)
-	InterlockedOr ((LONG *) &myself->process_state, PID_NEW_PG);
-
       if (mode == _P_DETACH)
 	/* all set */;
       else if (mode != _P_OVERLAY || !my_wr_proc_pipe)
@@ -605,7 +602,12 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       ::cygheap->user.deimpersonate ();

       if (!real_path.iscygexec () && mode == _P_OVERLAY)
-	InterlockedOr ((LONG *) &myself->process_state, PID_NOTCYGWIN);
+	{
+	  LONG pidflags = PID_NOTCYGWIN;
+	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
+	    pidflags |= PID_NEW_PG;
+	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
+	}

       cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;

@@ -707,7 +709,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      myself->sendsig = myself->exec_sendsig;
 	      myself->exec_sendsig = NULL;
 	    }
-	  InterlockedAnd ((LONG *) &myself->process_state, ~PID_NOTCYGWIN);
+	  InterlockedAnd ((LONG *) &myself->process_state,
+			  ~(PID_NOTCYGWIN|PID_NEW_PG));
 	  /* Reset handle inheritance to default when the execution of a'
 	     non-Cygwin process fails.  Only need to do this for _P_OVERLAY
 	     since the handle will be closed otherwise.  Don't need to do
@@ -769,7 +772,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  myself->set_has_pgid_children ();
 	  ProtectHandle (pi.hThread);
 	  pinfo child (cygpid,
-		       PID_IN_USE | (real_path.iscygexec () ? 0 : PID_NOTCYGWIN));
+		       PID_IN_USE |
+		       (real_path.iscygexec () ? 0 : PID_NOTCYGWIN) |
+		       ((c_flags & CREATE_NEW_PROCESS_GROUP) ? PID_NEW_PG : 0));
 	  if (!child)
 	    {
 	      syscall_printf ("pinfo failed");
-- 
2.49.0.windows.1

