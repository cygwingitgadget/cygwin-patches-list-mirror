Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id B36F64BA23EC
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 14:09:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B36F64BA23EC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B36F64BA23EC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781359773; cv=none;
	b=Sm/xnlZ8nbAS1Qj4n3ngR9wf+tdshReXmuGTUBT3TwCbsuBOsZQIJiI3sIqhRLsrvGhXCOw3VKowoZebJlzKWTsHoSU0MGm/oVVo1/eFGsT5NOHIlFv9V5Vs4ipaJTpDiuF23OkE+/ZZojX+4bR7QT4agbu9+HZxkICNe+tBnBw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781359773; c=relaxed/simple;
	bh=W03Er4GBtUhek04is3NjhuAMRWK6FFfxkWY4Boc9Yrk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=AQbkAc1GfkXWBHIaYQZULttHwWjEZ+WN7Xh+gJvZJnn0N+pmSstrZj+Mt/+POita/oTp3okMY9LkhjZCNDp0fqoBRMbTe9Gauoiro2B16l22rVH0XTBK9yEVOv/fR1y4f/+wHaJuvOl7+CBSeqKRpHkwYL47M5W3Q2oD17zpK2I=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EA7PWHG3
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B36F64BA23EC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EA7PWHG3
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260613140928897.XYZJ.102121.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 23:09:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/3] Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned children
Date: Sat, 13 Jun 2026 23:09:00 +0900
Message-ID: <20260613140917.27155-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781359768;
 bh=VY47VdlNpovwDqmqDFaatnlEOX+VRXJoLcyVNj/dHk4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EA7PWHG3VWLvcY3lJt4enasXJvJZ+y9yFyAtLJvTeHft1kddIs+sfYUVTbIi0PvglY/ShiA4
 5IJJKFDWz32LLRa/jSb/yhFIVXynqyV5ag2yXrl8BAvssygNIHVDHdcU6HtjnGKHkepSgX7rdG
 nBZcCdB52JFDloW6Bv/pg/I7w6aRFYcgYac6OvBLZDhrcpJ1N7r0269fxT84XL2w+GfP+KElB1
 VaXvHJtSCVR7xOHBKstJR/6gwVpLojMYNEn/hKuG9b9m81jI3n95ZduvAV5/FQodX5g0NUwPRb
 qICyyQURBktmXJmPYG3eBnquLCgucr1v0X/SRtD1i6fczIwg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a Cygwin process (e.g. `bash` under MinTTY) spawns a native
Win32 child (e.g. `git.exe`) with pseudo console support enabled,
the child gets a pseudo console that bridges the pty. If that native
child then spawns a Cygwin grandchild (e.g. `vim`, `less`), the
grandchild inherits the pseudo console's console handles. In
`init_std_file_from_handle()`, the grandchild's msys2-runtime sees
`GetConsoleScreenBufferInfo()` succeed on those handles and, with
no valid `ctty` set, falls back to `FH_CONSOLE` and gives the
process `cons0` instead of connecting to the pty.

This causes scrollback clobbering in MinTTY because alternate screen
sequences (`ESC[?1049h` / `ESC[?1049l`) are handled by
`fhandler_console`'s `save_restore()` against the pseudo
console's buffer, which has no correspondence to MinTTY's scrollback.

Fix this in the existing console branch of
`init_std_file_from_handle()`: when there is no valid `ctty` and
we are about to fall back to `FH_CONSOLE`, first scan the shared
tty table for an entry whose `pcon_activated` is set and whose
`nat_pipe_owner_pid` is in our console's process list (via
`GetConsoleProcessList`). If found, parse the device as that pty
slave instead of as a real console. The handle is closed in either
fallback path, matching the existing `FH_CONSOLE` behavior.
`myself->ctty` is left untouched; the regular
`fhandler_pty_slave::open_setup()` path will set it via
`myself->set_ctty()` when the pty slave is opened.

The structure of `find_pcon_pty()` matters and is easy to get
wrong in case a keen developer would like to refactor this code in
the future. This code runs on every Cygwin process startup whose
parent is non-Cygwin, so the common path (no pty with an active
pseudo console) must remain free of expensive operations. Two
pitfalls to avoid: filtering tty entries with `tty::exists()`
looks correct but creates and destroys a named pipe per entry
(128 entries on every call), and hoisting the
`GetConsoleProcessList()` call out of the loop pays the
cross-process cost even when no candidate exists. The current
shape, a cheap shared-memory boolean check first and a lazily
fetched process list only on the first candidate, keeps the
common case at a handful of pointer reads.

Reported downstream at https://github.com/git-for-windows/git/issues/5303
and bisected to a Git for Windows release that upgraded the bundled
msys2-runtime from 3.3.6 (no pseudo console code) to 3.4.6 (the new
pseudo console architecture).

Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
Assisted-by: Claude Opus 4.7 (1M context)
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc            | 14 ++++++++++-
 winsup/cygwin/local_includes/tty.h |  5 ++++
 winsup/cygwin/tty.cc               | 37 ++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index f1832a169..e4d1cdf8f 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -326,7 +326,19 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
       if (CTTY_IS_VALID (myself->ctty))
 	dev.parse (myself->ctty);
       else
-	dev.parse (FH_CONSOLE);
+	{
+	  /* Check whether the inherited console is actually a pseudo
+	     console bridging a pty.  This happens when our non-Cygwin
+	     parent was itself spawned by a Cygwin process from a pty
+	     (e.g. bash spawning git.exe which then spawns vim).  In
+	     that case, connect to the pty slave instead of treating
+	     the handle as a real console. */
+	  int pcon_minor = cygwin_shared->tty.find_pcon_pty ();
+	  if (pcon_minor >= 0)
+	    dev.parse (FHDEV (DEV_PTYS_MAJOR, pcon_minor));
+	  else
+	    dev.parse (FH_CONSOLE);
+	}
     }
   else if (GetCommState (handle, &dcb))
     /* FIXME: Not right - assumes ttyS0 */
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 0adad03e6..507f7772e 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -181,6 +181,10 @@ public:
   void wait_fwd ();
   bool pty_input_state_eq (xfer_dir x) { return pty_input_state == x; }
   bool nat_fg (pid_t pgid);
+  bool has_active_pcon () const
+    { return pcon_activated && switch_to_nat_pipe; }
+  bool has_pcon_and_owner (DWORD pid) const
+    { return pcon_activated && switch_to_nat_pipe && nat_pipe_owner_pid == pid; }
   friend class fhandler_pty_common;
   friend class fhandler_pty_master;
   friend class fhandler_pty_slave;
@@ -199,6 +203,7 @@ public:
   int connect (int);
   void init ();
   tty_min *get_cttyp ();
+  int find_pcon_pty ();
   int attach (int n);
   static void init_session ();
   friend class lock_ttys;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index e8083dc1f..667aa2682 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -123,6 +123,43 @@ tty_list::init ()
     }
 }
 
+/* Search for a pty whose pseudo console owns our console.
+   Return tty minor number or -1 if not found.
+   Called from init_std_file_from_handle() for processes started by
+   non-Cygwin parents to detect that inherited console handles are
+   from a pcon-backed pty.
+
+   The cheap precondition (any tty with pcon active in shared memory)
+   short-circuits the common case where no pty has a pseudo console
+   active, avoiding the GetConsoleProcessList() LPC call entirely. */
+int
+tty_list::find_pcon_pty ()
+{
+  DWORD pids[128];
+  DWORD count = 0;
+  bool got_pids = false;
+
+  for (int i = 0; i < NTTYS; i++)
+    {
+      if (!ttys[i].has_active_pcon ())
+	continue;
+
+      /* Fetch the console process list lazily, only on first candidate. */
+      if (!got_pids)
+	{
+	  count = GetConsoleProcessList (pids, 128);
+	  if (!count)
+	    return -1;
+	  got_pids = true;
+	}
+
+      for (DWORD j = 0; j < count; j++)
+	if (ttys[i].has_pcon_and_owner (pids[j]))
+	  return i;
+    }
+  return -1;
+}
+
 /* Search for a free tty and allocate it.
    Return tty number or -1 if error.
  */
-- 
2.51.0

