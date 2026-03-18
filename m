Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:29])
	by sourceware.org (Postfix) with ESMTPS id D93DD4BB5924
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 05:34:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D93DD4BB5924
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D93DD4BB5924
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773812080; cv=none;
	b=NssSAUEbnH3oq6bCNiggyeJQxs6gzQrZ9KW2VOzM4gFR4wwhshKKXBk2Y2F0UOVyPO9u1NiIxwXbT0zAYQSa9Ndimd5bLbA0FCeKHPzrvbejiY7KY/BkfmJBRVsTe3/8v/S9i9d2SL/PFeZMuN+rXox58+A7ClDENMTgl8TC1mA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773812080; c=relaxed/simple;
	bh=r8o8PZCUNG5cSgYZwJy6P5XzKILPzH+R/BSG9M/KUNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=tNsHsVVzlgTGZSmkdJ7O+WM9kgrrMTyzI/zLf7RlT70ACoVdo9kI3zMu34COjavdrTb9nZsXqR9Dajc8nzSwsCPxfRYlcvTEVmeVUGHqy0Q4f8DerJjuXJT0z1NlRqpGSuYOd9tlr1ch/PFAsiiNMzO+sguEDLnugepQxBxhobg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D93DD4BB5924
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lOcbkwNE
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260318053437941.MJOL.116672.HP-Z230@nifty.com>;
          Wed, 18 Mar 2026 14:34:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 6/6] Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
Date: Wed, 18 Mar 2026 14:33:48 +0900
Message-ID: <20260318053430.375-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-7-takashi.yano@nifty.ne.jp>
References: <20260317122433.721-7-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773812078;
 bh=/EKJYKYAh8unQ8cI7MdfdkihRgSLkD82niuR+2KQ6cM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lOcbkwNELFnXO21H76gTKw7hlKFLx0WPLp9wKv8B7YmsAdBTN8HcwXZ1rxEwKeZWT7njph3y
 n5a8hHpmEKNal2UdCxS+ZzrNpaEx4GSD24rpx1h4ZzPQ08r+T0bXq6TArmwDQWpc6xSzcqS8Wb
 yjTz8ZgINurzsGXFDGejZ0GQaI2tW8DLhNXSulWJ+6XfNYqWXZBxI1PzSxGx/oM3q/Tv/kY3O7
 6+rVH+H2tFdicVdp6f9jQEA72GmXkCrIZRds01ynzyiaLK2B9UCpKg5slYfJK2g0G8rRzS6uFS
 ZoON1C+MGrarLZDuQy3Pp/s8sDrrSfU1FqeHL1xcMHfWw2bw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If to_be_read_from_nat_pipe() is called during pipe switching between
cygwin pipe and nat pipe, the return value mignt not as expected due
to incomplete state change. With this patch, to_be_read_from_nat_pipe()
is guarded by pipe_sw_mutex to avoid that. In addition, duration of
the acquiring the pipe_sw_mutex is reduced to avoid deadlock.

Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 50 +++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 4c38c49e1..ecd60f56c 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1301,22 +1301,44 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
 bool
 fhandler_pty_common::to_be_read_from_nat_pipe (void)
 {
+  /* If the slave is in setup_pseudoconsole(), pipe_sw_mutex cannot
+     be acquired because the slave has it. In this case pcon_start
+     will be asserted. During pcon_start, other input than response
+     to CSI6n should be go to cyg-pipe. So, wait for pcon_start and
+     return false. */
+  while (WaitForSingleObject (pipe_sw_mutex, 0) != WAIT_OBJECT_0)
+    if (get_ttyp ()->pcon_start)
+      return false;
+    else
+      yield ();
+
+  bool ret = false;
   if (!get_ttyp ()->switch_to_nat_pipe)
-    return false;
+    goto out;
 
-  char name[MAX_PATH];
-  shared_name (name, TTY_SLAVE_READING, get_minor ());
-  HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
-  CloseHandle (masked);
+  do
+    {
+      char name[MAX_PATH];
+      shared_name (name, TTY_SLAVE_READING, get_minor ());
+      HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
+      CloseHandle (masked);
 
-  if (masked) /* The foreground process is cygwin process */
-    return false;
+      if (masked) /* The foreground process is cygwin process */
+	goto out;
+    }
+  while (false);
 
   if (!pinfo (get_ttyp ()->getpgid ()))
     /* GDB may set invalid process group for non-cygwin process. */
-    return true;
+    {
+      ret = true;
+      goto out;
+    }
 
-  return get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
+  ret = get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
+out:
+  ReleaseMutex (pipe_sw_mutex);
+  return ret;
 }
 
 void
@@ -3943,7 +3965,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
     goto maybe_dumb;
 
   /* Check if terminal has CSI6n */
-  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   WaitForSingleObject (input_mutex, mutex_timeout);
   /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle_nat rather than io_handle. */
@@ -3979,7 +4000,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   while (len);
   get_ttyp ()->pcon_activated = false;
   get_ttyp ()->nat_pipe_owner_pid = 0;
-  ReleaseMutex (pipe_sw_mutex);
   if (len == 0)
     goto not_has_csi6n;
 
@@ -3995,7 +4015,6 @@ not_has_csi6n:
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
-  ReleaseMutex (pipe_sw_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
   return false;
@@ -4302,7 +4321,6 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
-  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
@@ -4317,6 +4335,7 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 	  ReleaseMutex (p->input_mutex);
 	}
     }
+  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
   else
@@ -4335,6 +4354,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
       && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
+      ReleaseMutex (pipe_sw_mutex);
       WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
@@ -4345,6 +4365,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
 	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
     {
+      ReleaseMutex (pipe_sw_mutex);
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
       DWORD resume_pid = 0;
@@ -4371,7 +4392,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	release_attach_mutex ();
       ReleaseMutex (input_mutex);
     }
-  ReleaseMutex (pipe_sw_mutex);
+  else
+    ReleaseMutex (pipe_sw_mutex);
 }
 
 bool
-- 
2.51.0

