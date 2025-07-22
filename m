Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:26])
	by sourceware.org (Postfix) with ESMTPS id DF9DA385C6D6
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 00:32:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF9DA385C6D6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF9DA385C6D6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:26
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753144342; cv=none;
	b=nPEucV4sXIrIe/apquNBF9VxQMnv7D1vmV9dV1mqBzSBtZNkgUhMfED2xcrPvT6ef8VWB3t3/cokEDZ7GPnaiztxYqYqwU6c6aFSVcnItTX0T1yO3JcbGDuHy5QSCOgWhbkF4/UWWD+iXcoV/dLPic+6ayTnDtaV+BJFn/EsxXI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753144342; c=relaxed/simple;
	bh=KD/CaOYjj1X5vSOlAUT8oGJ2a+DveZuWWSFOMyrxwmY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ECrbbdoXpVzl6oAmZ51zCZ0VkDVubiTPSrciqN1FMr6WURF+Zb01ZeF8DhCWxVm/CXoB0rCi0FFMy+GHIP12J4kJztZGAEaM3VpVQFhZFFrM/7IV/xLQMKNYs+0YdV+7GhOmhiX4A5MHtPKyPAoJqyMFTkNSH0KwUlitSwTEItg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF9DA385C6D6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=M0dscH5p
Received: from localhost.localdomain by mta-snd-e06.mail.nifty.com
          with ESMTP
          id <20250722003219751.NVHG.42575.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 09:32:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v5 2/3] Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
Date: Tue, 22 Jul 2025 09:31:32 +0900
Message-ID: <20250722003142.4722-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250722003142.4722-1-takashi.yano@nifty.ne.jp>
References: <20250722003142.4722-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753144339;
 bh=ibmKiOPc77+M+XkVL8GNCA9l+n5uhZBSrvNaAx2H4vg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M0dscH5pFY96TvMZNADuursBPFmr9h2/5wOUcB7NJxvSTfkSTN5t49jeHz8QyMhkAMTHs8UG
 U9FYsWKxnMQjPgPANn1BrOW2zQiO0Jo0Kwr4d5bvm2KfyBSs2BuL4ALNajM/8jglCSrMGJ3xGr
 hlKDoBVB/IjqsGJ5lnNc9xFYmRXUa9xDNJdfX39MGND/ZK6UN2a6QoNZn+K07U7URHPsnR5gSI
 QkIXPAHhSiRT1Uu8b8jbSV6LR0pBk1XpzUeXrohwr6XW772RQT60vx1AFJFildD/POJ4Ux14Ep
 dNAPz0Kmt6/yHPcrRgLzihTw6anpga+e4X+lX5eXkAIu1uKQ==
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/spawn.cc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cb58b6eed..cf344d382 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -542,7 +542,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
       if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
-      refresh_cygheap ();
 
       if (mode == _P_DETACH)
 	/* all set */;
@@ -611,6 +610,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
 
+      if (iscygwin ())
+	cygheap->lock ();
+      refresh_cygheap ();
       wchar_t wcmd[(size_t) cmd];
       if (!::cygheap->user.issetuid ()
 	  || (::cygheap->user.saved_uid == ::cygheap->user.real_uid
@@ -728,6 +730,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    ::cygheap->user.reimpersonate ();
 
 	  res = -1;
+	  if (iscygwin ())
+	    cygheap->unlock ();
 	  __leave;
 	}
 
@@ -781,6 +785,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      if (get_errno () != ENOMEM)
 		set_errno (EAGAIN);
 	      res = -1;
+	      if (iscygwin ())
+		cygheap->unlock ();
 	      __leave;
 	    }
 	  child->dwProcessId = pi.dwProcessId;
@@ -816,6 +822,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      CloseHandle (pi.hProcess);
 	      ForceCloseHandle (pi.hThread);
 	      res = -1;
+	      if (iscygwin ())
+		cygheap->unlock ();
 	      __leave;
 	    }
 	}
@@ -844,6 +852,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	/* Just mark a non-cygwin process as 'synced'.  We will still eventually
 	   wait for it to exit in maybe_set_exit_code_from_windows(). */
 	synced = iscygwin () ? sync (pi.dwProcessId, pi.hProcess, INFINITE) : true;
+      if (iscygwin ())
+	cygheap->unlock ();
 
       switch (mode)
 	{
-- 
2.45.1

