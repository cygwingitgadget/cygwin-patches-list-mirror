Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id 0E106385C6FC
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 06:44:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0E106385C6FC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0E106385C6FC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753166693; cv=none;
	b=QH3T7Et9RyXm8EGSpc+PGeqsyEDwT8tJSLSNM+dXxERDCsYmOsv3o3wiQjJ5Lf5YT02OXBcZfD/Om9poxGZsm0iek1/T8E4QpkmZg9zLUtnXnIZtMiBPtO0hyPkrVEIOqwvA/QGJSUOwOuzdd685hXI/SXhFbAtTvESV1AFe6wA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753166693; c=relaxed/simple;
	bh=oDtpiaKUqjbzPfEHYstKXb2ifNdXklurpggYxTszRSw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=OerODuWGfbQkyo1jglPSIC/D93xWPE+xFSJnIyRQMuEh4QMBOkJYmvYarXArT4mHpnpAlZiXm2MAwzGKCBgDJrjdIMbrf3mPwTNo8+ObPgjMCr/edtbyNSwUsfqwirXzPqPAT1uwarOMvAUsaqYW0XW7KaC6LAXW/lfouS46JiY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0E106385C6FC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FkNSJ54U
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250722064451392.TQVZ.62593.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 15:44:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v6 2/3] Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
Date: Tue, 22 Jul 2025 15:44:01 +0900
Message-ID: <20250722064415.1590-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250722064415.1590-1-takashi.yano@nifty.ne.jp>
References: <20250722064415.1590-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753166691;
 bh=glpWWHlXdlkMGcQYRpsWe+94e6A8L/LNcX3tqQvWiOY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FkNSJ54UJLQjUHiOjJC+3R1J/4MmE0k77BojYMDSgmY/KN0UdnyEMP5phOV/ImltSf4P4eL6
 wv0ejNF4DsS7pqPOxcUuMYdhKb1TIQmcN7P43eLbp/Z66Uk2tKhGSogf0nONknVBBi5lIEkUzy
 8peNpfo22tFOhIVmMVb1w7xlQDeE7COuqc59KJ2S5kwxuHQlhMimJnl9iKxewtgApWq53TBL+n
 2bQT63zfoco658lPGRK6W1h/hh4+PpO+peUn6toZtGQ57yMJsndQMsWzXHy3VWu70ylJwvILR2
 pMOiuk8p7YkcezKy+kHZViej7bFDBqAJnl0LeQh3MeypeVsA==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

...completion in child process because the cygheap should not be
changed to avoid mismatch between child_info::cygheap_max and
::cygheap_max. Otherwise, child_copy() might copy cygheap being
modified by other process. However, do not lock cygheap if the
child process is non-cygwin process, because child_copy() will
not be called in it. Not only it is unnecessary, it can also fall
into deadlock in close_all_files() while cygheap is already locked.

Fixes: 977ad5434cc0 ("* spawn.cc (spawn_guts): Call refresh_cygheap before creating a new process to ensure that cygheap_max is up-to-date.")
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/child_info.h | 10 ++++++++++
 winsup/cygwin/spawn.cc                    |  7 ++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 2da62ffaa..460a83684 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -191,6 +191,16 @@ public:
   operator HANDLE& () {return hExeced;}
   int worker (const char *, const char *const *, const char *const [],
 		     int, int = -1, int = -1);
+  inline void spawn_cygheap_lock ()
+  {
+    if (iscygwin ())
+      cygheap->lock ();
+  }
+  inline void spawn_cygheap_unlock ()
+  {
+    if (iscygwin ())
+      cygheap->unlock ();
+  }
 };
 
 extern child_info_spawn ch_spawn;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cb58b6eed..8ca19868a 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -542,7 +542,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
       if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
-      refresh_cygheap ();
 
       if (mode == _P_DETACH)
 	/* all set */;
@@ -611,6 +610,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
 
+      spawn_cygheap_lock ();
+      refresh_cygheap ();
       wchar_t wcmd[(size_t) cmd];
       if (!::cygheap->user.issetuid ()
 	  || (::cygheap->user.saved_uid == ::cygheap->user.real_uid
@@ -728,6 +729,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    ::cygheap->user.reimpersonate ();
 
 	  res = -1;
+	  spawn_cygheap_unlock ();
 	  __leave;
 	}
 
@@ -781,6 +783,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      if (get_errno () != ENOMEM)
 		set_errno (EAGAIN);
 	      res = -1;
+	      spawn_cygheap_unlock ();
 	      __leave;
 	    }
 	  child->dwProcessId = pi.dwProcessId;
@@ -816,6 +819,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      CloseHandle (pi.hProcess);
 	      ForceCloseHandle (pi.hThread);
 	      res = -1;
+	      spawn_cygheap_unlock ();
 	      __leave;
 	    }
 	}
@@ -844,6 +848,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	/* Just mark a non-cygwin process as 'synced'.  We will still eventually
 	   wait for it to exit in maybe_set_exit_code_from_windows(). */
 	synced = iscygwin () ? sync (pi.dwProcessId, pi.hProcess, INFINITE) : true;
+      spawn_cygheap_unlock ();
 
       switch (mode)
 	{
-- 
2.45.1

