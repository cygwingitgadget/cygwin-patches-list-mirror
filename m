Return-Path: <SRS0=dMBQ=EG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id D02D341439A9
	for <cygwin-patches@cygwin.com>; Wed, 10 Jun 2026 16:35:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D02D341439A9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D02D341439A9
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781109358; cv=none;
	b=RCogNQLyjgF3b5mN+KRzy3qZahVnbDE4IkpW4TSaTJwuGK7yeqI17odhUCigNM1Evg+ycG3szCkGwv9Ev19gDqOyyu6AMBnA+ptcUYx5EdP2MLXPLsLnRw4MP3iI00XqLwNonpUSUOWIp5/4tzRGgL3uL0ELqzXPwxKb10m8S0I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781109358; c=relaxed/simple;
	bh=ZqLOOvSnVouHYwhUMaD6JuNIEq16ILffBPr9n9F7r04=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=wpCOH+OUOaje9GUgZqPYRD2OTjmTBkir+UU4KtT9Aq6TVawgOAx7EGEVoeSKvcu3xjk6FJI5xB+cWB7fQuZYi/y3UXk6S/m6e7rE9cm+gRT6SHK/R6n9JCW3jEXrp7bB0ZB44VEXZZwEw9UZx2N38TMoTKypG9se0JE9juEBTFk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oLgvPv6U
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D02D341439A9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oLgvPv6U
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260610163556108.KSYK.3198.HP-Z230@nifty.com>;
          Thu, 11 Jun 2026 01:35:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/3] Cygwin: console: Ensure the master thread runs only when it is supposed to
Date: Thu, 11 Jun 2026 01:35:12 +0900
Message-ID: <20260610163533.10187-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781109356;
 bh=k5p1YV6VnaLaC7md6wd81C2Vz77a4Y1fjK0P6mLXCCU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oLgvPv6UJ3i2EvlcnvA8XtDQoGCopDGNGgz92k6yLieo9u+9ZUPLGSYQzG/yVrZyDgAOBPY0
 Zco7bJTV9Ntx3V5Nc97TWLYSOWEZLotE22qfcNKu6ZvLNDjJCH6ckPMlXnp0Eu9F8pmH1WJCEz
 b87baSRRt4kyeJnd++CRjIu2SZjfp6l9NPLsqhLUkLZpzPEjrqQ3RcekVobT9Fdiz1Ndz7716I
 mQ66z8bcnHY37nz63NSCLi9vIJ242XxvxuyRnRNOJjfe2i9YOeopG59PUUqUD0g6SBSuS9XYpB
 k1LKaB+GkpSzLDha8rSD28rFuC6ebK3g3slx57/0H+TJnZcQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, disabling cons_master_thread is done by just setting the
flag disable_master_thread. In fact, actual suspension of master
thread is delayed a bit. Therefore, non-cygwin program where the
master thread should be disabled may run even though the master
thread is running in a short time. This patch ensure that the master
thread is suspended when non-cygwin app is running. In addition,
while master thread is running, console mode should not be changed.
Therefore, the order of set_input_mode() call and disabling/enabling
master thread is swapped.

Fixes: d2b14c303c04 ("Cygwin: console: Redesign handling of special keys.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 45eff6efe..a5e6cd89d 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -439,6 +439,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 
       if (con.disable_master_thread)
 	{
+	  con.master_thread_suspended = true;
 	  cygwait (40);
 	  continue;
 	}
@@ -976,9 +977,9 @@ fhandler_console::setup_for_non_cygwin_app ()
      console mode. */
   if (get_ttyp ()->getpgid () == myself->pgid)
     {
+      set_disable_master_thread (true, this);
       set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
       set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
-      set_disable_master_thread (true, this);
     }
 }
 
@@ -990,7 +991,6 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   termios *ti = shared_console_info[unit] ?
     &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
   /* Cleaning-up console mode for non-cygwin app. */
-  set_disable_master_thread (con.owner == GetCurrentProcessId ());
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
   tty::cons_mode conmode = cons_mode_on_close (p);
@@ -998,6 +998,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);
+  set_disable_master_thread (con.owner == GetCurrentProcessId ());
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1190,8 +1191,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
      in the same process group. */
   if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
     {
-      set_disable_master_thread (false, this);
       set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
+      set_disable_master_thread (false, this);
     }
   if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
@@ -2087,8 +2088,8 @@ fhandler_console::post_open_setup (int fd)
   /* Setting-up console mode for cygwin app started from non-cygwin app. */
   if (fd == 0)
     {
-      set_disable_master_thread (false, this);
       set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+      set_disable_master_thread (false, this);
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
@@ -2106,11 +2107,11 @@ fhandler_console::close (int flag)
   if (shared_console_info[unit] && (dev_t) myself->ctty == get_device ()
       && cons_mode_on_close (&handle_set) == tty::restore)
     {
+      set_disable_master_thread (true, this);
       if (con.curr_output_mode != tty::restore)
 	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
       if (con.curr_input_mode != tty::restore)
 	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
-      set_disable_master_thread (true, this);
     }
 
   if (shared_console_info[unit] && con.owner == GetCurrentProcessId ())
@@ -4445,10 +4446,10 @@ fhandler_console::set_console_mode_to_native ()
 	fhandler_console *cons = (fhandler_console *) (fhandler_base *) cfd;
 	if (cons->get_device () == cons->tc ()->getntty ())
 	  {
+	    set_disable_master_thread (true, cons);
 	    termios *cons_ti = &cons->tc ()->ti;
 	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
 	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
-	    set_disable_master_thread (true, cons);
 	    break;
 	  }
       }
@@ -4825,6 +4826,8 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
   cons->acquire_input_mutex (mutex_timeout);
   con.disable_master_thread = x;
   cons->release_input_mutex ();
+  while (con.master_thread_suspended != x)
+    Sleep (1);
 }
 
 int
-- 
2.51.0

