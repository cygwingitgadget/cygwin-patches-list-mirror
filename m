Return-Path: <SRS0=+gxg=EX=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id DD25F4BA2E2D
	for <cygwin-patches@cygwin.com>; Sat, 27 Jun 2026 08:34:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DD25F4BA2E2D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DD25F4BA2E2D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782549276; cv=none;
	b=ZGo9II/L828dX4T5U/iesu0zZq/rt/ddklAGEolxX2ZWOBOqeidvvTZGPwlaVTVgN6JOi+ZxjwG1yl6pWcYqhvfHdGeSjb0g2GdM1hjEkn9nxUOY+dxFrPJKodArbr6S/EjVoiwJS5hWPSD4ZE3DhoB6iO1TZTLrwpZH7G/QLTs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782549276; c=relaxed/simple;
	bh=fRt0co73BFmTptL95QJRIViv8afe58fSEjLQyE1N200=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=RTrOmPuusHRcHoTTvBN2p5rSryp22k83RHVX9Rc30C9rl9ozxrBcN24VJYeNBvk1G088xs5uNrAM9R4/SCZ4+ibVm8nZmB+9DNBshvFB/BoCp3iCwNf541F14qwj5onI0S+xI2hn3R7MvpWhk7+bSvsKTM2dc2zig83JIQ9xO9Q=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bkKgmJG7
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DD25F4BA2E2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bkKgmJG7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782549262; x=1783154062;
	i=johannes.schindelin@gmx.de;
	bh=IDomC+FZbc3RfVNzcIP/ZIJAQHDVacSW02vAy774C58=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bkKgmJG7M98bvZwh7WQkTTCIeFfJXhZkt2t+N795dAmq8FWBMFSJatD2MCgfhilb
	 nMKPiEJn5SaqnMRf//QRmlvqXhr2g0ZusG34LrgcAjgEPSiHVEMwqhwTfvuQKtm8o
	 LLf8XmHNlJVQyOLrVwbMjFvqj+l+pzZSs3KSnfFtEraH8kxLgSVQta5DuF0XtA1II
	 hPa1IYDnJ3pwhqOSGnkOC0FNUCyAaG3ib53DT1IhJU47xo5YhlVn8DvteuPT6grRj
	 uZymvr6Picid5E2DUCU2AhSjq3D5NrG4cV6sLj8+YasvWLLwwL3ZXbstj6L8gcPPI
	 UhhnIVnNngqx4lF49g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS5A-1x0vg40pK6-00az6L; Sat, 27
 Jun 2026 10:34:22 +0200
Date: Sat, 27 Jun 2026 10:34:20 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>, Mark Geisert <mark@maxrnd.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: console: Ensure the master thread runs only
 when it is supposed to
In-Reply-To: <20260610163533.10187-2-takashi.yano@nifty.ne.jp>
Message-ID: <b9f885ff-15bc-0c8a-f1f6-bbc9c19e9fde@gmx.de>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp> <20260610163533.10187-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:uBQNYTC4g7PYti3v8c+Lnw1XjUp8DKYQ7Fw423FN9GRG7yY+RDY
 9MSIAT/9WiUvAhfqXgVYsIm/viH2391dCRMK2rmaCUyJ0HkHlXoV7VQ+6wjX5QuyFzvLRzr
 xdVt5+uIFZrwSyCES034ib+Y3VGxgyweNaAGjew3LpsjSlrwfN6NH6xb8k9Urk2Eh4yfoui
 0SDtsVmWKSmZGBaEcxJ+g==
UI-OutboundReport: notjunk:1;M01:P0:ZOxE36uPnCE=;o+3Kp3J0RRiWUxjiwBAIKAaAuxg
 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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi & Mark,

An AutoHotKey-based test I added to
https://github.com/git-for-windows/msys2-runtime/pull/131 bisected a
Ctrl-C regression to this commit after it landed on master: Ctrl-C stopped
interrupting `cat` in the pipeline `cat | ping`. The diagnosis and the fix
I would propose are below.

On Thu, 11 Jun 2026, Takashi Yano wrote:

> @@ -1190,8 +1191,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
>       in the same process group. */
>    if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
>      {
> -      set_disable_master_thread (false, this);
>        set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> +      set_disable_master_thread (false, this);
>      }
>    if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> @@ -2087,8 +2088,8 @@ fhandler_console::post_open_setup (int fd)
>    /* Setting-up console mode for cygwin app started from non-cygwin app. */
>    if (fd == 0)
>      {
> -      set_disable_master_thread (false, this);
>        set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +      set_disable_master_thread (false, this);
>      }
>    else if (fd == 1 || fd == 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);

The console only delivers Ctrl-C as a raw `0x03` byte (which the console
master thread then reads and turns into a `SIGINT` for the foreground
process group) while that thread is live. When the master thread is
suspended or disabled, `set_input_mode (tty::cygwin)` instead requests
`ENABLE_PROCESSED_INPUT`, so the console raises a `CTRL_C_EVENT` and the
`0x03` byte never reaches the master thread.

The reorder above has `set_input_mode (tty::cygwin)` run while
`disable_master_thread` is still set, so `ENABLE_PROCESSED_INPUT` stays on
and a cygwin program sharing a foreground pgrp with a non-cygwin program
(e.g. the pipeline `cat | ping`) never receives its `SIGINT`. Clearing
`disable_master_thread` first, so the mode is configured with the master
thread already live, restores the previous behavior in both `bg_check ()`
and `post_open_setup ()`. The disable paths and the synchronous suspension
this commit added are load-bearing for non-cygwin programs and are left
untouched, so the master thread is still reliably suspended for them.

The fix I would propose is in
https://github.com/git-for-windows/msys2-runtime/pull/131/commits/73aae37a62d8246e1abaac6e52d6c6bb89bc4c5d:

-- snip --
From 73aae37a62d8246e1abaac6e52d6c6bb89bc4c5d Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 26 Jun 2026 09:16:49 +0200
Subject: [PATCH] Cygwin: console: re-enable the master thread before selecting
 cygwin input mode

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
---
 winsup/cygwin/fhandler/console.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 0136652878..685e99d62c 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1147,8 +1147,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
      in the same process group. */
   if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
     {
-      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
       set_disable_master_thread (false, this);
+      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
     }
   if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
@@ -2035,8 +2035,8 @@ fhandler_console::post_open_setup (int fd)
   /* Setting-up console mode for cygwin app started from non-cygwin app. */
   if (fd == 0)
     {
-      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
       set_disable_master_thread (false, this);
+      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
-- snap --

Ciao,
Johannes
