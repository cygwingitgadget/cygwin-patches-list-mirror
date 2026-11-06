Return-Path: <SRS0=8pk1=I3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 43F584BA2E36
	for <cygwin-patches@cygwin.com>; Fri,  6 Nov 2026 11:31:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 43F584BA2E36
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 43F584BA2E36
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793964690; cv=none;
	b=mJyhHItf9ymcRTX1hrkWvDHpzVsUeArXxsL+VEufR/rPI3kYu90nvMpxKQU5cDmqvRcz4VowpQaW8saihCTYw3jvmS8N3W/V8/8Vc3+WpfNW5aX8tKFD1L7T59p8nHXwl7lTwTC5zeKw3Y1NnWveHyK64gvp7dG0VDPO4HBxWEs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793964690; c=relaxed/simple;
	bh=UPoP6ACMKcL/7h4IvMUbSGFH+LKMi16Tp2xPJmVUKBg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=WS2EaEgiH5yWWvmY5G1arNO84goJpibXlNR2ZAO2likQpA2djx/9kTixN3KmHgXxf9pCYPTKsI7Y6OQXEFPaWlpNie96zu/i8xl0DquoauVcqBQw1ApXDj/8jjFgQz1qkjHb2pvbAVOKcBBApL/PQN7v9aoW4VZO4i9WZ+i000I=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KbNULQ4J
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 43F584BA2E36
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KbNULQ4J
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20261106113128429.DGGF.60338.HP-Z230@nifty.com>;
          Fri, 6 Nov 2026 20:31:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Daniyar Oshakbayev <daniyar29@gmail.com>
Subject: [PATCH] Cygwin: spawn: Create winpid symlink for spawned processes as well
Date: Fri,  6 Nov 2026 20:31:14 +0900
Message-ID: <20261106113122.315-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1793964688;
 bh=tcPahUL7FuAODv0FkKim3c9qHRJ0d7LSePflSYBfbfc=;
 h=From:To:Cc:Subject:Date;
 b=KbNULQ4JEg+XIZ6gEk1mq4T7Ko6SdQr+3lM0GdnSvBP3mONnE56zBZLWpPBUsb2UlHgCwr7A
 06sxwKoViKY9hBRB60+0/5G/CepktKNgYDzNOsDDYOd2qLtTA6LJEzT+56xGIncmCtALRm5m6R
 rS9/XWrXaBkSxM3aCrGfRsi3UQkjFCdFM8N2Nf+tHThR35dg5aF0gjZzK3b4oKcjHpIqEEwXJ9
 5ETOHasj4Z6fuikqX66BcYCWLJBzkYpOV60neKeWtZdVhFFewGqfoayzLmilTgfvHOfD9hVkZD
 ggqrP7xq7W7rRBf4FH10jsVBD+QJpqqsH5bsCL2ctXXUXSsA==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Since commit 1b86dd7d8c19 ("Cygwin: make sure exec'ed process exists
early in process list"), spawned processes have been missing from the
process list (e.g. the output of `ps`). This is because that commit
should also have maintained the winpid symlink for spawned cygwin
processes, but did not.

Addresses: https://cygwin.com/pipermail/cygwin/2026-October/260185.html
Fixes: 1b86dd7d8c19 ("Cygwin: make sure exec'ed process exists early in process list")
Reported-by: Daniyar Oshakbayev <daniyar29@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/spawn.cc | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 6d736888a..87865ddf3 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -794,16 +794,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	     not available. */
 	  DuplicateHandle (GetCurrentProcess (), child.shared_handle (),
 			   pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
+	  /* We have to create a new winpid symlink on behalf of the child
+	     process. For Cygwin processes we also have to create a reference
+	     in the child. */
+	  child.create_winpid_symlink ();
 	  if (!real_path.iscygexec ())
-	    {
-	      /* If the child process is not a Cygwin process, we have to
-		 create a new winpid symlink and induce it into the child
-		 process as well to keep it over the lifetime of the child. */
-	      child.create_winpid_symlink ();
-	      DuplicateHandle (GetCurrentProcess (),
-			       child.shared_winpid_handle (),
-			       pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
-	    }
+	    DuplicateHandle (GetCurrentProcess (),
+			     child.shared_winpid_handle (),
+			     pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
 	  child->start_time = time (NULL); /* Register child's starting time. */
 	  child->nice = myself->nice;
 	  child->sched_policy = myself->sched_policy;
-- 
2.51.0

