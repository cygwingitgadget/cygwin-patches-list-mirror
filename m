Return-Path: <SRS0=TksR=EZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 11B884BA2E16
	for <cygwin-patches@cygwin.com>; Mon, 29 Jun 2026 11:23:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 11B884BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 11B884BA2E16
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782732247; cv=none;
	b=JeANWFsTTeN2nUej9LM4P6kgUd6yqcZJ4Da9Pxz899xKpvdZ7QZyWc/ie4QgddQISz9bgVTR0JQlXsAxKPBbQI4vcClaXggNJ4igEyUsEPyueoVyM3QJ7A105tM8aJ+gQgqCz8ReeyAG49YEEzNGcF+iZael+RMOco9QJrMOkA8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782732247; c=relaxed/simple;
	bh=BSYr+hG1zm+C0owlUUGExvp3VGMDF5fhjg2wLcjVM4Q=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ikSfHNvclZZIkStzXsIgzOKrZAlx2ROUApNOKIc78DnIrBHsGXeYVvDcspVbm0iC7hwZvfllk4PzgRat72hre8Z2fKnR6FuwgjKov614F30/Vjuk1dWLm3gIL/R5Fo5oMrr4tiBSEJDs5tSStm9O4A9ngSTkfuAqol2ljISz3sU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PIEVtMLx
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 11B884BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PIEVtMLx
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260629112357515.BQDS.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 29 Jun 2026 20:23:57 +0900
Date: Mon, 29 Jun 2026 20:23:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: console: Ensure the master thread runs only
 when it is supposed to
Message-Id: <20260629202355.e305f2aa0d83aaabc10f896e@nifty.ne.jp>
In-Reply-To: <b9f885ff-15bc-0c8a-f1f6-bbc9c19e9fde@gmx.de>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
	<20260610163533.10187-2-takashi.yano@nifty.ne.jp>
	<b9f885ff-15bc-0c8a-f1f6-bbc9c19e9fde@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782732237;
 bh=DtgviNIhw06CM+SWk0w1vltXwwZIfcNENJWCAQEyw1k=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=PIEVtMLxvCwl27nfoX1fUaNieNfasH3YEPS7tQK4e/rY7kgWDIWjmblnX/A8y1yNS0jA1Okz
 lmHWfPsE1M/RJCz4Sv6PXyg7+9xIpI02SU7MkUe5kF2op5I3zq2cTEEk6yaQWjf3BRKZvQDR2R
 kjF9TB2zNM6UHXUbZuR2H6zqCrLeR0j7t1FhHwCg+sAtHmWr/Ws4nFOKBtKqXYICrmz+174Tu2
 P+6Dzs+YjwK2TFWfj23oGaIxNyIGKwYjgQhQ8Z4r3rbsV+asKCgVLgQM+8M+rWWrKR8dpnaCws
 FNZ8LrwncrHqoghq8tcHhmSIjDJTUDZFxFYQMz21ErrHQ7tw==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sat, 27 Jun 2026 10:34:20 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi & Mark,
> 
> An AutoHotKey-based test I added to
> https://github.com/git-for-windows/msys2-runtime/pull/131 bisected a
> Ctrl-C regression to this commit after it landed on master: Ctrl-C stopped
> interrupting `cat` in the pipeline `cat | ping`. The diagnosis and the fix
> I would propose are below.
> 
> On Thu, 11 Jun 2026, Takashi Yano wrote:
> 
> > @@ -1190,8 +1191,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
> >       in the same process group. */
> >    if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
> >      {
> > -      set_disable_master_thread (false, this);
> >        set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> > +      set_disable_master_thread (false, this);
> >      }
> >    if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
> >      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> > @@ -2087,8 +2088,8 @@ fhandler_console::post_open_setup (int fd)
> >    /* Setting-up console mode for cygwin app started from non-cygwin app. */
> >    if (fd == 0)
> >      {
> > -      set_disable_master_thread (false, this);
> >        set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> > +      set_disable_master_thread (false, this);
> >      }
> >    else if (fd == 1 || fd == 2)
> >      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> 
> The console only delivers Ctrl-C as a raw `0x03` byte (which the console
> master thread then reads and turns into a `SIGINT` for the foreground
> process group) while that thread is live. When the master thread is
> suspended or disabled, `set_input_mode (tty::cygwin)` instead requests
> `ENABLE_PROCESSED_INPUT`, so the console raises a `CTRL_C_EVENT` and the
> `0x03` byte never reaches the master thread.
> 
> The reorder above has `set_input_mode (tty::cygwin)` run while
> `disable_master_thread` is still set, so `ENABLE_PROCESSED_INPUT` stays on
> and a cygwin program sharing a foreground pgrp with a non-cygwin program
> (e.g. the pipeline `cat | ping`) never receives its `SIGINT`. Clearing
> `disable_master_thread` first, so the mode is configured with the master
> thread already live, restores the previous behavior in both `bg_check ()`
> and `post_open_setup ()`. The disable paths and the synchronous suspension
> this commit added are load-bearing for non-cygwin programs and are left
> untouched, so the master thread is still reliably suspended for them.
> 
> The fix I would propose is in
> https://github.com/git-for-windows/msys2-runtime/pull/131/commits/73aae37a62d8246e1abaac6e52d6c6bb89bc4c5d:

Thanks for catching this!

> -- snip --
> From 73aae37a62d8246e1abaac6e52d6c6bb89bc4c5d Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 26 Jun 2026 09:16:49 +0200
> Subject: [PATCH] Cygwin: console: re-enable the master thread before selecting
>  cygwin input mode
> 
> When a cygwin program and a non-cygwin program run in the same foreground
> process group (for example the pipeline `cat | ping`), Ctrl-C stopped
> interrupting the cygwin program after "Cygwin: console: Ensure the master
> thread runs only when it is supposed to".
> 
> The console only delivers Ctrl-C as a raw 0x03 byte (which the console
> master thread reads and turns into a SIGINT for the foreground process
> group) while that thread is live. When it is suspended or disabled,
> set_input_mode (tty::cygwin) instead requests ENABLE_PROCESSED_INPUT, so
> the console raises a CTRL_C_EVENT and the 0x03 byte never reaches the
> master thread. The referenced commit reordered the two enable paths,
> bg_check () and post_open_setup (), so that set_input_mode (tty::cygwin)
> runs while disable_master_thread is still set; that leaves
> ENABLE_PROCESSED_INPUT on and the cygwin program never receives its SIGINT.
> 
> Clear disable_master_thread before selecting cygwin input mode in those two
> paths, so the mode is configured with the master thread already live and
> ENABLE_PROCESSED_INPUT stays off. The disable paths and the synchronous
> suspension that the referenced commit added are left unchanged, so
> non-cygwin programs still get the master thread reliably suspended.
> 
> Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
> Assisted-by: Opus 4.8
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/console.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 0136652878..685e99d62c 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1147,8 +1147,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
>       in the same process group. */
>    if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
>      {
> -      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
>        set_disable_master_thread (false, this);
> +      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
>      }
>    if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> @@ -2035,8 +2035,8 @@ fhandler_console::post_open_setup (int fd)
>    /* Setting-up console mode for cygwin app started from non-cygwin app. */
>    if (fd == 0)
>      {
> -      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
>        set_disable_master_thread (false, this);
> +      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
>      }
>    else if (fd == 1 || fd == 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> -- snap --

I think we also need the following.

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d2ffaa0c4..340bc3f2e 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -991,6 +994,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   termios *ti = shared_console_info[unit] ?
     &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
   /* Cleaning-up console mode for non-cygwin app. */
+  set_disable_master_thread (con.owner == GetCurrentProcessId ());
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
   tty::cons_mode conmode = cons_mode_on_close (p);
@@ -998,7 +1002,6 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);
-  set_disable_master_thread (con.owner == GetCurrentProcessId ());
 }

 /* Return the tty structure associated with a given tty number.  If the


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
