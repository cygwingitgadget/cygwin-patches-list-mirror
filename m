Return-Path: <SRS0=Jqgh=2C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id B2A173858D1E
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 16:12:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B2A173858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B2A173858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753114349; cv=none;
	b=OPbR8p2KZl0ivoeiDoB1O1naTL0Gjg9YhZRO7j6R+CCeVmTrYw1Kei9eHDLi50eqmLkLmR/M/zA0wpiBRL8Zx2JKG+Zytx3YrRgLujiPKmlRQ7nM7l+dy74bxzjujFh6DVwp+jtoOXJl0yFGUOBwMbdy6Xhe3O2aWBTivw6Eg7I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753114349; c=relaxed/simple;
	bh=DaZD48wKz7dYHV4OGCuEzIXerfT8Bw9HS0TnvDj/3vI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=pB12ACuG6OGEYmfkGu8wICbf+OYsHaPEERLTNoD3tUMOvLAwYk7K2ip3Oh49hFVYF3SmcHb0eLnD+6N1I8NOjsFJ5MAozhu7PKiQMrt+6UGteYU+USl/w0hFUBxVKZRxROr//iikY2iObluBodmoo79equ9YMUA2kLuf0MW61Ks=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250721161226955.TETO.91923.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 01:12:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v4 2/3] Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
Date: Tue, 22 Jul 2025 01:11:41 +0900
Message-ID: <20250721161151.1053-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250721161151.1053-1-takashi.yano@nifty.ne.jp>
References: <20250721161151.1053-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753114347;
 bh=UCyJU8jxKWJvhN9Gd0v0CEbOzzBUAV8fG4UO6CfxcRA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O/nt+GlGpJU85++t7zvHXM/gR4ku+PU5QbPCV032h2gVD3AVxsGLNKKYP/mPMqWH8z0II5p0
 SfDErOJ1fUC23Uvt+fhyrzRZIpBNvI6AzKlTuqGRQ/k3q4DzMeF+qhh3RxyrTI1qq9AfPAJw8l
 OeQ58O/71hESw4/GAXYa2JOkqFW7a8jO6k0QbGJgk+CVfWGBMxToRlfUmbTwAc9C4hu3HQr+Va
 Mp4aed46pAtFC8K6EJ00oRjYsN/63OOURcop95Edulhg4+cd8WP2aro1tdSQZT6vR02TXBwxix
 Jit079MzRFYlecKuitG5p0x/ub4Jl3gNXT/og8892hb9PYLw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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

