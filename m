Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id 773084BA2E0E
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 11:47:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 773084BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 773084BA2E0E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782820067; cv=none;
	b=xdWbCiBZCxc2rX8iEiC8ZOzw+dkxOmE7m83Zo+WHvkmpjWQ4xQ4RW6gi1knB4kQ5knCj0faYfWimkkeMXaG1Of+vcoWVwvWabmvWI9sHCz5N96PfgQ4RUPoTfoAX75U5vGRAY1eOUT3LqwzHF3hEo/gXPkMBeXiJvVPGSOek/2Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782820067; c=relaxed/simple;
	bh=ZLr0c6cCOdjNvEunVebn0CM7knjv37WMEavziwoYTZQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Jao5crbgdOv+5KXH9GkMi9YRmloDAc80c0OsSSsnmWFRkHEJOF7s3ROSsvVmqRRWprEX8uc5NV4paSbObyhYe4VuSjkRdO91OF0ZrCcK2drAKl4Fw2j1+ejDNOduN8OIYx4Hj96MLUF9QYYyulm+ningZFslISFqVICvAoTAod0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JYmXqAiZ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 773084BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JYmXqAiZ
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260630114743511.VLBG.44671.HP-Z230@nifty.com>;
          Tue, 30 Jun 2026 20:47:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: console: re-enable the master thread before selecting cygwin input mode
Date: Tue, 30 Jun 2026 20:47:23 +0900
Message-ID: <20260630114735.118967-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782820063;
 bh=SW5CMHOdp7DPDNagThzZwI+0GQ6NQUw3QNJRN+Gfd/0=;
 h=From:To:Cc:Subject:Date;
 b=JYmXqAiZIo/clOa0CcBgCq2KjnUHwFlX5xLLMxLxFLw/LkIqUuLL6nplswBbQE7G2wr9/Dfp
 sLAJEe/fW+4q890+9uc63HhtXobhrbX5Wh2tc27wkQ04rAjuerI5nv8YPGyWtrbYSW7VJ5q9UJ
 37Hr7YkyAL/8QOrr43BcKb9extrpcHoeSpGr4dL9ltin+QCEyYsCcT53Gh5Oz4YqD6+QUv22E5
 +hdMdUKgKaCXyxOKQXPsmf4oH1g3xLrmRfkKXK1VfpAJbSCQurznqaDbf5uiSw1zI325iPRQMI
 50QhCI71hhC6WR6g/6Wd8AYzPwplPRa3D53ss0sWsVcSrRUA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a cygwin program and a non-cygwin program run in the same foreground
process group (for example the pipeline `cat | ping`), Ctrl-C stopped
interrupting the cygwin program after "Cygwin: console: Ensure the master
thread runs only when it is supposed to".

The console only delivers Ctrl-C as a raw 0x03 byte (which the console
master thread reads and turns into a SIGINT for the foreground process
group) while that thread is live. When it is suspended or disabled,
set_input_mode (tty::cygwin) instead requests ENABLE_PROCESSED_INPUT, so
the console raises a CTRL_C_EVENT and the 0x03 byte never reaches the
master thread. The referenced commit reordered the two enable paths,
bg_check () and post_open_setup (), so that set_input_mode (tty::cygwin)
runs while disable_master_thread is still set; that leaves
ENABLE_PROCESSED_INPUT on and the cygwin program never receives its SIGINT.

Clear disable_master_thread before selecting cygwin input mode in those two
paths, so the mode is configured with the master thread already live and
ENABLE_PROCESSED_INPUT stays off. The disable paths and the synchronous
suspension that the referenced commit added are left unchanged, so
non-cygwin programs still get the master thread reliably suspended.

Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
Assisted-by: Opus 4.8
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Co-Authored-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 1e4367816..730bb0b45 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -991,6 +991,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   termios *ti = shared_console_info[unit] ?
     &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
   /* Cleaning-up console mode for non-cygwin app. */
+  set_disable_master_thread (con.owner == GetCurrentProcessId ());
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
   tty::cons_mode conmode = cons_mode_on_close (p);
@@ -998,7 +999,6 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);
-  set_disable_master_thread (con.owner == GetCurrentProcessId ());
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1191,8 +1191,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
      in the same process group. */
   if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
     {
-      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
       set_disable_master_thread (false, this);
+      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
     }
   if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
@@ -2111,8 +2111,8 @@ fhandler_console::post_open_setup (int fd)
   /* Setting-up console mode for cygwin app started from non-cygwin app. */
   if (fd == 0)
     {
-      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
       set_disable_master_thread (false, this);
+      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
-- 
2.51.0

