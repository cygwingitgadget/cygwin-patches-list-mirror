Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 9A3E83858416
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 12:11:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9A3E83858416
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9A3E83858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753186270; cv=none;
	b=QSMdOBnXhw0jRfpcDfbiBPmLrI/9YRS1gv218+YAPwCU3RuqooHvPS2YYXm0Cpqj+PAZO3WEIHPrHAtQW1BXWTckxdEm9iS64FidBBM8KM6bQLB0OJH4LIDoHiNNbagiCfKCxxihhNfi/azgr5jyLDX3m1BVXeqcjM9DL9Trqfk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753186270; c=relaxed/simple;
	bh=yxmsC1MyKY0xAH1mDbPGl0wsIuWaHtGhcA7UOH0XR0k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Cb2CAEK/k2Qaito1uOREn0L1goJ5xMfH/DkilHYWf1LiMIcQhqT/8KeJybiJfFx0mXsWjetz2nORKRj2Vs0iQU6shLyMtSkH2Z2LzGUMfjVQou7IpiLlC9G48GvRZPwalQc+DvfmTUWpn120bmpNfTHea2bSy2+5sdtk0Fy/zwI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9A3E83858416
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WpvBEU2A
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250722121102841.VVRV.74565.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 21:11:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v7 2/3] Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
Date: Tue, 22 Jul 2025 21:10:15 +0900
Message-ID: <20250722121032.4755-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250722121032.4755-1-takashi.yano@nifty.ne.jp>
References: <20250722121032.4755-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753186262;
 bh=VNOG0RpR2EceZYEFf+pa6Crlz2hC8cRNDeCOvMUilcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WpvBEU2At03yowu5fBaJEq+NM6sQYhyGy8Rsm1N3f4lQzzhfnjbViDDCLsz/JMkAtWqBNKLI
 H5XfosxKC4eJOeDggcAJPWC7TMuzlYBO0UIxYgYj2aC5W5FQALgESeDLc21748wf+hrdZpRI+2
 ZWpAjIqV9AZigyqVtfj8HMooTVQfLpTq6qtL6inmwt4DzrsCDkolFIcTS5uZw5cfBHQZ9dYSSc
 2zTefhjzGZXM+0uEpuWUakpwgBk2CxoxqiZzPk6sVpw+1BEteR6dcSOEeiLG8YoQmGZrfr+eAX
 aVwVWTRn/DuE3bgHS23PtWXgkK/kd6Lx2gBYObuQZPgz548A==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

...completion in child process because the cygheap should not be
changed to avoid mismatch between child_info::cygheap_max and
::cygheap_max. Otherwise, child_copy() might copy cygheap being
modified by other process.

In addition, to avoid deadlock, move close_all_files() for non-
Cygwin processes after unlocking cygheap, since close_all_files()
calls cfree(), which attempts to lock cygheap even when it's already
locked.

Fixes: 977ad5434cc0 ("* spawn.cc (spawn_guts): Call refresh_cygheap before creating a new process to ensure that cygheap_max is up-to-date.")
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/spawn.cc | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cb58b6eed..7f2f5a8aa 100644
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
@@ -728,6 +729,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    ::cygheap->user.reimpersonate ();
 
 	  res = -1;
+	  cygheap->unlock ();
 	  __leave;
 	}
 
@@ -764,8 +766,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  NtClose (old_winpid_hdl);
 	  real_path.get_wide_win32_path (myself->progname); // FIXME: race?
 	  sigproc_printf ("new process name %W", myself->progname);
-	  if (!iscygwin ())
-	    close_all_files ();
 	}
       else
 	{
@@ -781,6 +781,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      if (get_errno () != ENOMEM)
 		set_errno (EAGAIN);
 	      res = -1;
+	      cygheap->unlock ();
 	      __leave;
 	    }
 	  child->dwProcessId = pi.dwProcessId;
@@ -816,6 +817,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      CloseHandle (pi.hProcess);
 	      ForceCloseHandle (pi.hThread);
 	      res = -1;
+	      cygheap->unlock ();
 	      __leave;
 	    }
 	}
@@ -844,6 +846,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	/* Just mark a non-cygwin process as 'synced'.  We will still eventually
 	   wait for it to exit in maybe_set_exit_code_from_windows(). */
 	synced = iscygwin () ? sync (pi.dwProcessId, pi.hProcess, INFINITE) : true;
+      cygheap->unlock ();
 
       switch (mode)
 	{
@@ -860,8 +863,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  else
 	    {
-	      if (iscygwin ())
-		close_all_files (true);
+	      close_all_files (iscygwin ());
 	      if (!my_wr_proc_pipe
 		  && WaitForSingleObject (pi.hProcess, 0) == WAIT_TIMEOUT)
 		wait_for_myself ();
-- 
2.45.1

