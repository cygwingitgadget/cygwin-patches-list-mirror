Return-Path: <SRS0=jPCG=2A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 1FAAB3857BBA
	for <cygwin-patches@cygwin.com>; Sat, 19 Jul 2025 15:16:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1FAAB3857BBA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1FAAB3857BBA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752938189; cv=none;
	b=XSfxpYAhqcZJKfh9pXgc3AiLukg3TftF2fRGORf1pMXR4BSKDmC6u4Tw4HRv0df9ula7iduMlNZvsLTqRtfdw8s6vfhtv5ygazmpRPamo4n95t7bseHv/H15jU+d6qJHF/JmUXRomeAWlZZXxbJ7wb7iZ+zhXuJ6YhVBrRXsy3k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752938189; c=relaxed/simple;
	bh=mTX1LBq60cwPXmu1+A8iBujrR/JMoOWdLhKemmQUsSQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=WYfvbbu0ZOf0FsZUQ4s1MPKQAP6085kdlgaav3M1JKaZE0rQm3ZEOpuCQUwdwzv8IYbUZrwyL8Cqed1U16kzr8Fwie05Rn8Mwzs2ic2oNXGPd2snXBk97j885ypcu33u40xlRUt0s8s8BuqPNIa5pYu7OwkPcM0UmPaUV8xhqvY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1FAAB3857BBA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lUrRy8Z9
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250719151627578.GEEX.69071.localhost.localdomain@nifty.com>;
          Sun, 20 Jul 2025 00:16:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/2] Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
Date: Sun, 20 Jul 2025 00:15:42 +0900
Message-ID: <20250719151557.340849-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250719151557.340849-1-takashi.yano@nifty.ne.jp>
References: <20250719151557.340849-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1752938187;
 bh=FWETZOkCB4pzVRRA6flAstTYvK2EST+WfHXXHmi1fl4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lUrRy8Z9cmWndkv/5n1ZabXzsj3lipk3hom5KLMYqOr3VuHrj4WxUXO3+QfGCST1LKmemP/6
 uIjd4HPY4J0TOCysZKzAyrd2w0+oX4lgJGS4uhis30moz0AfMZ1xnC/euCl4jBZYRxG8c3Y54k
 f8P8U3/4tzK4Ethdn1jye9bFKpm6PERZKbSe7Rv40duvjlQzJvwTCE2WpzbbkevSLIsspyWC8+
 3rq0GvtA+DnZANm9Di1Ke4kJwrR3y05SOaqisbstldQW5IkvOVYKgIp9IDD11sMSgCxZ3H3O8G
 PO7cFVUq5STlvOdi8CK66sbsiJgNPa62UtBg+QkN5kuM3BOQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

...completion in child process because the cygheap should not be
changed to avoid mismatch between child_info::cygheap_max and
::cygheap_max. Otherwise, child_copy() might copy cygheap being
modified by other process.

Fixes: 977ad5434cc0 ("* spawn.cc (spawn_guts): Call refresh_cygheap before creating a new process to ensure that cygheap_max is up-to-date.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/mm/cygheap.cc | 2 +-
 winsup/cygwin/spawn.cc      | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/mm/cygheap.cc b/winsup/cygwin/mm/cygheap.cc
index 338886468..b3ebca5d6 100644
--- a/winsup/cygwin/mm/cygheap.cc
+++ b/winsup/cygwin/mm/cygheap.cc
@@ -35,7 +35,7 @@ static mini_cygheap NO_COPY cygheap_dummy =
 init_cygheap NO_COPY *cygheap = (init_cygheap *) &cygheap_dummy;
 void NO_COPY *cygheap_max;
 
-static NO_COPY SRWLOCK cygheap_protect = SRWLOCK_INIT;
+NO_COPY SRWLOCK cygheap_protect = SRWLOCK_INIT;
 
 struct cygheap_entry
 {
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cb58b6eed..a4c2b0549 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -273,6 +273,7 @@ struct system_call_handle
 };
 
 child_info_spawn NO_COPY ch_spawn;
+extern SRWLOCK cygheap_protect;
 
 extern "C" void __posix_spawn_sem_release (void *sem, int error);
 
@@ -542,7 +543,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
       if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
-      refresh_cygheap ();
 
       if (mode == _P_DETACH)
 	/* all set */;
@@ -611,6 +611,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
 
+      AcquireSRWLockExclusive (&cygheap_protect);
+      refresh_cygheap ();
       wchar_t wcmd[(size_t) cmd];
       if (!::cygheap->user.issetuid ()
 	  || (::cygheap->user.saved_uid == ::cygheap->user.real_uid
@@ -844,6 +846,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	/* Just mark a non-cygwin process as 'synced'.  We will still eventually
 	   wait for it to exit in maybe_set_exit_code_from_windows(). */
 	synced = iscygwin () ? sync (pi.dwProcessId, pi.hProcess, INFINITE) : true;
+      ReleaseSRWLockExclusive (&cygheap_protect);
 
       switch (mode)
 	{
-- 
2.45.1

