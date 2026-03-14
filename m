Return-Path: <SRS0=giYG=BO=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id ADEDD4C31831
	for <cygwin-patches@cygwin.com>; Sat, 14 Mar 2026 06:45:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ADEDD4C31831
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ADEDD4C31831
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773470740; cv=none;
	b=MyX5waR4Qk2acVUMXZVH7Gun8yNBrPeunv5g9ySqEVsw/HHLTxUCSTPckBeZFex2Eb5yFtFH9hQZcQIAZbdY2xlDK0HGRoQNBWftKgOJOZ2TEjv4ShLI50W2flI9d2nyvMiFUbPyd0JCn9hsBoyOenpmbfxSympa825bujYDhg8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773470740; c=relaxed/simple;
	bh=VD5zBoQxsRXuvrynuPSTO8XJ0oI6o0ZyERME6EzPaIU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=wrXYzC+UpEG5Y9YlXd2xXHg6kl1+qiOYt1Osv5TUIl/vvXenNRj8bwteN6P85FyVESju4IvCWlUAbl6GAwROpqSlQibijR+n/jPR8K0RJhsOizFk51Q4iRPXV+qK57uNkLODoiMnlHNDywNW71JMO7MGOCCPna7SWvEZPBPqbFs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ADEDD4C31831
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 62E723Bx023949;
	Sat, 14 Mar 2026 00:02:03 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdrGDyqE; Fri Mar 13 23:01:57 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Quash Windows error text to user on fork() error
Date: Fri, 13 Mar 2026 23:44:34 -0700
Message-ID: <20260314064539.1418-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2026q1/014745.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q1/014745.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

For a very long time, since 2011 or earlier, fork() has printed an internal
error message when it fails due to a CreateProcess() error.  This patch
quashes the error message as far as the user can tell, but it will still be
present in an strace.

This change is a judgement call based on the fact we now support
RLIMIT_NPROC and so a user limiting the number of subprocesses may hit
more CreateProcess() errors by design.  Don't clutter the scene.

Fixes: 855108782321 (* dll_init.c (dll_list::load_after_fork): Don't
clear in_forkee here.)
Signed-off-by: Mark Geisert <mark@maxrnd.com>

---
 winsup/cygwin/fork.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 3e5d81fe4..48e8b7557 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -400,6 +400,7 @@ frok::parent (volatile char * volatile stack_here)
 	{
 	  this_errno = geterrno_from_win_error ();
 	  error ("CreateProcessW failed for '%W'", myself->progname);
+	  ch.silentfail (true);
 	  dlls.release_forkables ();
 	  memset (&pi, 0, sizeof (pi));
 	  goto cleanup;
-- 
2.51.0

