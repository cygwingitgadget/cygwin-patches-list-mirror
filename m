Return-Path: <SRS0=0NVs=7N=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.227.115])
	by sourceware.org (Postfix) with ESMTPS id 509B74BA2E05
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 12:35:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 509B74BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 509B74BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.115
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767875713; cv=none;
	b=URNF4yXEx3ZKSpoiBvpfdHgDVbfzQWcn3n5dUD0TCNv/VeLxzTRoBmB9TZZ75lPdqMoMSi9l8UPhZYFopW2bhmPA1d68X8+bZABIZuJDfqf7xTl/6CmfcK4OiiKbXc6STiC/JqLbtQYz6nZpyRSDsINWb8T6QPa6IFLcE4lxGUw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767875713; c=relaxed/simple;
	bh=u1WT8cCe2kccku8Vjxs4X2EowQacPjjMPHHkDXCChxU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qgHhzgnfgUCkEu2AlsijC0TNXl6voPBWDGGeLNpJ7dCTNCBU9/YAwWzOW+JAz2SMGu0R9VhzsYQ0+8M7XlElbop3CpakZuM97wMktP9P0Xc/ZwnrGFOBLAfJX52auoJDSGowmWJps1TVXMsbKmFce6Gr6xztAUNIqDuDrL0I0uk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 509B74BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bP669UTL
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20260108123510194.JVTR.47114.HP-Z230@nifty.com>;
          Thu, 8 Jan 2026 21:35:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: flock: Remove the unnecessary fdtab lock
Date: Thu,  8 Jan 2026 21:34:40 +0900
Message-ID: <20260108123502.989-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767875710;
 bh=lp1hZpzOqm5Vs8eUMC2x/+k9qsKQizfeDzA9knfrSEA=;
 h=From:To:Cc:Subject:Date;
 b=bP669UTLJQfyXYMNpGniuj5pGVB1gj2+gX7kSWx1iF2GsZv64/diN4ooibKaRtHeXMm6vDYc
 ypN3LS/wfGpa6N2lRQrd5+WoDqvyYuKJiYTHvrUMnUykQwNRbuvRz4qkpufP+bhT6Rbb9Gkyab
 +oQ1DBF1EpxX6WGUw8lZzMV56lJFJgKd8uE3hPru5IQ6HtDv6FSdbJOsx2Juc6xug9U4lIZ4PX
 WTMI3fe+BjJJFP5GGvrihDYErkEXB2A8r2RCgbxD9Gox1V2FNd5POWqMgtEoaHUXUFasyg8VBV
 +kTZ9PqPgiat7pgo191kBVS9gyppccMFG0eNMVhPpP2qxSzQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

There were two fdtab locks: one is in inode_t::del_my_locks(), and
the other is in fixup_lockf_after_exec().  The merely counts the file
descriptors affected by the corresponding lock, so locking fdtab seems
unnecessary.  The latter only only during execve(), when no other
threads exist.  Therefore, these two locks are redundant. This patch
removes them.

Suggested-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 221501d65..857762f4a 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -379,7 +379,7 @@ inode_t::del_my_locks (long long id, HANDLE fhdl)
       else if (id && lock->lf_id == id)
 	{
 	  int cnt = 0;
-	  cygheap_fdenum cfd (true);
+	  cygheap_fdenum cfd (false);
 	  while (cfd.next () >= 0)
 	    if (cfd->get_unique_id () == lock->lf_id && ++cnt > 1)
 	      break;
@@ -441,7 +441,7 @@ fixup_lockf_after_exec (bool exec)
     {
       node->notused ();
       int cnt = 0;
-      cygheap_fdenum cfd (true);
+      cygheap_fdenum cfd (false);
       while (cfd.next () >= 0)
 	if (cfd->get_dev () == node->i_dev
 	    && cfd->get_ino () == node->i_ino
-- 
2.51.0

