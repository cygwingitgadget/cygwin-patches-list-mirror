Return-Path: <SRS0=Jqgh=2C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id EBAC93858D1E
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 13:47:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EBAC93858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EBAC93858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753105631; cv=none;
	b=u/djKWJlNZy1PD/5UeJt7bS/erglEBPxVrEPMGfJCY4LVMIfn0Nkfvzc2l6lj7xyJ/XCF7DSkBR0TKixERaZBNFM04E7Tk4ev4h33mfPz6Bk/uVlxFIV5HbsHzg9WhmVnBisyInfz/J3xs8xN9+CcjFCTiJ8rcregb4/F93RLm4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753105631; c=relaxed/simple;
	bh=DaZD48wKz7dYHV4OGCuEzIXerfT8Bw9HS0TnvDj/3vI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=erVnxN88JMP2dvZs/0wEeTo988g2IdFFjrLSyiCxBGiFgr58AxDxPId4E93E8LcNp8ViusyMn3Rvi7/EIQdunOGiq8pskislMjX/rz0tR8zkaC86JqYmBGgtXwNaQcCo8BwLJ3K6Tvcbk/2Pmce7M2/26PI/GpMD9/6HIskJFcM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250721134708261.SKCC.74565.localhost.localdomain@nifty.com>;
          Mon, 21 Jul 2025 22:47:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 2/3] Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
Date: Mon, 21 Jul 2025 22:46:18 +0900
Message-ID: <20250721134628.2908-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
References: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753105628;
 bh=UCyJU8jxKWJvhN9Gd0v0CEbOzzBUAV8fG4UO6CfxcRA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=s4W99dtrPn1E92B3VuPupiWiXS6zu7gjCbetM38mCYG/1Xob4TBdq3sAVeEiqtW2gZAuEKDE
 WqU7JqI7Ge0pyTVUMZJcn0WguR/XDHIW+uiTLXVFG9is0AX8+1p+bNpu3qMSISosyfdWxBzujA
 07J1cHVW6laWgvfseMhoMTgAjwVCnz+8vw6M7UG9PVkkhpkNQ7V0W/r2z18gGO4fpYZX300juO
 ISzO+UJ8y/dYz56KXGS64mEvzh8fgr/x7eS6d8qLlyZ13bEmE3X03kw/5DUznKf+BjXyaQ8mov
 1tup4g5Hex8kbtaxWl8x3YRL1iGh/McYMST8677pDricLSEA==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

...completion in child process because the cygheap should not be
changed to avoid mismatch between child_info::cygheap_max and
::cygheap_max. Otherwise, child_copy() might copy cygheap being
modified by other process.

Fixes: 977ad5434cc0 ("* spawn.cc (spawn_guts): Call refresh_cygheap before creating a new process to ensure that cygheap_max is up-to-date.")
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/spawn.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cb58b6eed..fd623f4c5 100644
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
 
+      cygheap->lock ();
+      refresh_cygheap ();
       wchar_t wcmd[(size_t) cmd];
       if (!::cygheap->user.issetuid ()
 	  || (::cygheap->user.saved_uid == ::cygheap->user.real_uid
@@ -844,6 +845,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	/* Just mark a non-cygwin process as 'synced'.  We will still eventually
 	   wait for it to exit in maybe_set_exit_code_from_windows(). */
 	synced = iscygwin () ? sync (pi.dwProcessId, pi.hProcess, INFINITE) : true;
+      cygheap->unlock ();
 
       switch (mode)
 	{
-- 
2.45.1

