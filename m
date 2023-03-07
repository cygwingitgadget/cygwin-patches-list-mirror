Return-Path: <SRS0=/Ih6=67=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
	by sourceware.org (Postfix) with ESMTPS id 997793858C66
	for <cygwin-patches@cygwin.com>; Tue,  7 Mar 2023 02:34:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 997793858C66
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-12.nifty.com with ESMTP id 3272YIar022788;
	Tue, 7 Mar 2023 11:34:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 3272YIar022788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1678156464;
	bh=hJpY+bLqGziuOjbhBVhNe9B9GNx8kVSlUWLHgm261pM=;
	h=From:To:Cc:Subject:Date:From;
	b=d9tJtbo6wVjDaEX+88Cwwr9S56R8BNoSCQWeln2qnEEa3pC/uIfO9pJhENcrzCA8z
	 gMc3YMcQwk9BQXR+nsK/V10r9wlE0ehTzFv1UK41KVdQTb568UCcOW5OPEne09DmtA
	 O+r0UfdZ9zNlcMaHigYcL6UPdoCDbNONp87N9+IOevVLZcCCXVy1yQpj9V3bYmIQXe
	 JSJapc2eigcsxA9j2SjFnHidhbblndAD8bOyDI2+BWYMurBg4XLlMJe96MlHbhGZC/
	 u69cvDJabyNMpgLooqM0rm0WcY5Mrngj7L4Tk4+3YffVx/33KrNJA9gj7ykpGhyGYw
	 bMWy1nfHFBw4w==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: ctty: Remove old 'kludge' code.
Date: Tue,  7 Mar 2023 11:34:10 +0900
Message-Id: <20230307023410.1200-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Remove old 'kludge' code which does not seem necessary anymore. The
comment of the 'kludge' is as follows.

  * syscalls.cc (setsid): On second thought, in the spirit of keeping
    things kludgy, set ctty to -2 here as a special flag, and...
    (open): ...only eschew setting O_NOCTTY when that case is detected.

Fixes: c38a2d837303
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc   |  7 -------
 winsup/cygwin/syscalls.cc | 11 -----------
 2 files changed, 18 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 6b2394814..0ed3ea85d 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -764,13 +764,6 @@ dtable::dup3 (int oldfd, int newfd, int flags)
       return -1;
     }
 
-  /* This is a temporary kludge until all utilities can catch up with
-     a change in behavior that implements linux functionality:  opening
-     a tty should not automatically cause it to become the controlling
-     tty for the process.  */
-  if (newfd > 2)
-    flags |= O_NOCTTY;
-
   if ((newfh = dup_worker (fds[oldfd], flags)) == NULL)
     {
       res = -1;
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 15ddbb0a8..c529192b4 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1452,17 +1452,6 @@ open (const char *unix_path, int flags, ...)
       int opt = PC_OPEN | PC_SYM_NOFOLLOW_PROCFD;
       opt |= (flags & (O_NOFOLLOW | O_EXCL)) ? PC_SYM_NOFOLLOW
 					     : PC_SYM_FOLLOW;
-      /* This is a temporary kludge until all utilities can catch up
-	 with a change in behavior that implements linux functionality:
-	 opening a tty should not automatically cause it to become the
-	 controlling tty for the process.  */
-      if (!(flags & O_NOCTTY) && fd > 2 && myself->ctty != -2)
-	{
-	  flags |= O_NOCTTY;
-	  /* flag that, if opened, this fhandler could later be capable
-	     of being a controlling terminal if /dev/tty is opened. */
-	  opt |= PC_CTTY;
-	}
 
       /* If we're opening a FIFO, we will call device_access_denied
 	 below.  This leads to a call to fstat, which can use the
-- 
2.39.0

