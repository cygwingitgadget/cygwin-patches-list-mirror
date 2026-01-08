Return-Path: <SRS0=0NVs=7N=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 0E09E4BA2E21
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 08:30:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0E09E4BA2E21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0E09E4BA2E21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767861043; cv=none;
	b=qY/IjxDbFV2fdpaIU2W9mwMGhOWMerhc5F8XQpvo0zDyomS5Lejr94uv9NRfSqOxgi2J+XB83uYLabEKUFeAhOWMZbeVEuax5ffnytaVupptt4sJmqaLBHsY5qjau9Me0a80gZXemcBv6aVqWL1TOq0B1ozUU4PPd156DrYTtsY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767861043; c=relaxed/simple;
	bh=uvVQ2bJLT5Pp/YlRtD+OcXRx/AOYo5i2H4i745zdQoM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=l/yAhN+nrZaJH36tkS3Cm3gwbgRONro0BuVdbfSDj4js2M7Qo7O2iGjUCCL+BXbRLoR273nBUiO9qUgcApRyS4UQbUQcPKp2zK2S++PEGmbHl2BMODHvgJpTkhCYkaIUYS8Xu2af3fAv/k5wJ7x4j5jC/mKl+BRgAwMPvYvlHDc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0E09E4BA2E21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=SzoTuegG
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20260108083038193.OQKY.78984.HP-Z230@nifty.com>;
          Thu, 8 Jan 2026 17:30:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Nahor <nahor.j+cygwin@gmail.com>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: flock: Do not lock fdtab in create_lock_in_parent()
Date: Thu,  8 Jan 2026 17:30:22 +0900
Message-ID: <20260108083031.1364-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767861038;
 bh=slgrL3VV2w1xZSaw/XM9f0IzbZ1vLsYWpiKXffsN7Bg=;
 h=From:To:Cc:Subject:Date;
 b=SzoTuegGDyylIi0y/gHw7LeXpxUKnh/YMkFRXUhIDNYXm4pZy1s8W+z2CqzhyPLQrdPwYbPB
 XXM0IBt5G1++i6onWpxi3gpjGShskf+WD1nBpU92O/Pbe3/Fj7b8w1XYubiY3c8JfXej8+l3em
 9xboxuAHoaAsBa1ulzuVGmuxdg3dfMGVU1SkcObCSehnQ/E4rZ9t1Yt0Xw9pVhxMiQkyUSiwpQ
 PF7j9ppcTDLotXZzNe7HwJbpAw+Wtdu++Ty/Dgrm09yGdkfrXNEMWivZmgMqTw4sAz18kvXJWU
 tj2FnlzVV0Pdag2s2qA6dnDGaxEeQJ58ufUv5RVJeJ7MjfBQ==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Otherwise, a deadlock can occur if the child process attempts to
lock a file while the parent process is closing the same file, which
is already locked. The deadlock mechanism is as follows.

When the child process attempts to lock a file, it notifies the parent
process by calling CreateRemoteThread(), which creates a remote thread
in the parent. That thread checks whether the file being locked is
currently opened in the parent. During the operation, cygheap->fdtab
is temporarily locked in order to enumerate the file descriptors.

However, if the parent process is closing the same file at that moment,
it also locks fdtab via cygheap_fdget cfd(fd, true) in __close().
If the parent acquires th fdtab lock first, it proceeds to call
del_my_locks(), which attempts to lock the inode in inode_t:get().

At this point, the inode is already locked in the child,
so the parent waits for the child to release the inode. Meanwhile,
the child is waiting to acquire the fdtab lock, which is still held
by the parent. As a result, the parent and child become deadlocked.

There are two options to fix the deadlock: eather avoid locking fdtab
in __close(), or avoid locking fdtab in create_lock_in_parent().
The latter is safer than the former because __close() calls release(),
which modifies the fdtab contents, while cygheap_fdenum only reads
them. Therefore, to resolve the issue, this patch removes the fdtab
lock from create_lock_in_parent().

Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259187.html
Fixes: df63bd490a52 ("* cygheap.h (cygheap_fdmanip): New class: simplifies locking and retrieval of fds from cygheap->fdtab.")
Reported-by: Nahor <nahor.j+cygwin@gmail.com>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index ee79af3c9..221501d65 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -692,7 +692,7 @@ create_lock_in_parent (PVOID param)
   /* Check if we have an open file handle with the same unique id. */
   {
     cnt = 0;
-    cygheap_fdenum cfd (true);
+    cygheap_fdenum cfd (false);
     while (cfd.next () >= 0)
       if (cfd->get_unique_id () == newlock.lf_id && ++cnt > 0)
 	break;
-- 
2.51.0

