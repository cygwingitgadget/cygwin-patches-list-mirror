Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id F05AA4BA2E0E
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 11:51:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F05AA4BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F05AA4BA2E0E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782820297; cv=none;
	b=EwliB5Q6bqWwe30UQ9tiS9Y6NRdRCsP7onpuKQZQKepnfqv8zYGGAd72jwqhiPTS8XbucRBku6juRooGuKV49mnHiy14jBeOxup8lHKcyjkcoxsZtDBZaIf+SYTnlDRE0jD3ezXhdJtev+ej/7dA8mgss8eu42kUqetT7PEg8eM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782820297; c=relaxed/simple;
	bh=13GbHxPmlbFnAXxqKZTaAHEGE/whJPX6zc4bzVXmIvQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=MKUGFJl6QHfFCf1dEfJIb1L6+YKD1P/wjlnldZ1glB8/iuUqsVVXrUOA7ket2eOvMecL8mKi0BWbQhbM79VmMH0fKVZgh23CaHKq+6FO722WKw5M3uU1U0/uxGo/Y3mcAuE6hiY+pZoILhocq9e1dHATdMg6sy/kc1+S419tlao=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IcRhTtGB
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F05AA4BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IcRhTtGB
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260630115135273.VOVE.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 20:51:35 +0900
Date: Tue, 30 Jun 2026 20:51:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: console: Ensure the master thread runs only
 when it is supposed to
Message-Id: <20260630205133.7db9b7c2f71ffb7b5648b3df@nifty.ne.jp>
In-Reply-To: <20260629202355.e305f2aa0d83aaabc10f896e@nifty.ne.jp>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
	<20260610163533.10187-2-takashi.yano@nifty.ne.jp>
	<b9f885ff-15bc-0c8a-f1f6-bbc9c19e9fde@gmx.de>
	<20260629202355.e305f2aa0d83aaabc10f896e@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782820295;
 bh=cmmTPj880rkhNTqlRprsicxYHrR/SX/Rf5Os77BJovE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=IcRhTtGB8GZho1gmgdanW1nmNhcPxehhEnBsSqyV9Zft1RJbGZTiUx+pDp4TMLpTLAlf94cT
 RU3ysSo3zmVPuz7gXM+wTnzOsfiKau0zf61PRgAig+fikF1WtY0/ZH7pfaBeFYN7Tv7ylpNsHW
 8EpWYgyu7OsabRKFEh7XHXbQkAqAs5yoivbSv03slAj3LON564KA7KXisRA1OgGcBsoNtQDyEF
 QtLrvEPqKQMG0qOQXLj1J60U0qFTWU+ogiQnTIVSCiA+fkDXvE83xdXTholDG5tvYJmidIWVTF
 MqXCJTz7F4e2qZInrBozmfDIXwTcjHPbqNEjk2SFUKRJ1Zlg==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 29 Jun 2026 20:23:55 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> On Sat, 27 Jun 2026 10:34:20 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi & Mark,
> > 
> > An AutoHotKey-based test I added to
> > https://github.com/git-for-windows/msys2-runtime/pull/131 bisected a
> > Ctrl-C regression to this commit after it landed on master: Ctrl-C stopped
> > interrupting `cat` in the pipeline `cat | ping`. The diagnosis and the fix
> > I would propose are below.
> > 
> > On Thu, 11 Jun 2026, Takashi Yano wrote:
> > 
> > > @@ -1190,8 +1191,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
> > >       in the same process group. */
> > >    if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
> > >      {
> > > -      set_disable_master_thread (false, this);
> > >        set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> > > +      set_disable_master_thread (false, this);
> > >      }
> > >    if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
> > >      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> > > @@ -2087,8 +2088,8 @@ fhandler_console::post_open_setup (int fd)
> > >    /* Setting-up console mode for cygwin app started from non-cygwin app. */
> > >    if (fd == 0)
> > >      {
> > > -      set_disable_master_thread (false, this);
> > >        set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> > > +      set_disable_master_thread (false, this);
> > >      }
> > >    else if (fd == 1 || fd == 2)
> > >      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> > 
> > The console only delivers Ctrl-C as a raw `0x03` byte (which the console
> > master thread then reads and turns into a `SIGINT` for the foreground
> > process group) while that thread is live. When the master thread is
> > suspended or disabled, `set_input_mode (tty::cygwin)` instead requests
> > `ENABLE_PROCESSED_INPUT`, so the console raises a `CTRL_C_EVENT` and the
> > `0x03` byte never reaches the master thread.
> > 
> > The reorder above has `set_input_mode (tty::cygwin)` run while
> > `disable_master_thread` is still set, so `ENABLE_PROCESSED_INPUT` stays on
> > and a cygwin program sharing a foreground pgrp with a non-cygwin program
> > (e.g. the pipeline `cat | ping`) never receives its `SIGINT`. Clearing
> > `disable_master_thread` first, so the mode is configured with the master
> > thread already live, restores the previous behavior in both `bg_check ()`
> > and `post_open_setup ()`. The disable paths and the synchronous suspension
> > this commit added are load-bearing for non-cygwin programs and are left
> > untouched, so the master thread is still reliably suspended for them.
> > 
> > The fix I would propose is in
> > https://github.com/git-for-windows/msys2-runtime/pull/131/commits/73aae37a62d8246e1abaac6e52d6c6bb89bc4c5d:
> 
> Thanks for catching this!
> 
> > -- snip --
> > From 73aae37a62d8246e1abaac6e52d6c6bb89bc4c5d Mon Sep 17 00:00:00 2001
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Date: Fri, 26 Jun 2026 09:16:49 +0200
> > Subject: [PATCH] Cygwin: console: re-enable the master thread before selecting
> >  cygwin input mode
> > 
> > When a cygwin program and a non-cygwin program run in the same foreground
> > process group (for example the pipeline `cat | ping`), Ctrl-C stopped
> > interrupting the cygwin program after "Cygwin: console: Ensure the master
> > thread runs only when it is supposed to".
> > 
> > The console only delivers Ctrl-C as a raw 0x03 byte (which the console
> > master thread reads and turns into a SIGINT for the foreground process
> > group) while that thread is live. When it is suspended or disabled,
> > set_input_mode (tty::cygwin) instead requests ENABLE_PROCESSED_INPUT, so
> > the console raises a CTRL_C_EVENT and the 0x03 byte never reaches the
> > master thread. The referenced commit reordered the two enable paths,
> > bg_check () and post_open_setup (), so that set_input_mode (tty::cygwin)
> > runs while disable_master_thread is still set; that leaves
> > ENABLE_PROCESSED_INPUT on and the cygwin program never receives its SIGINT.
> > 
> > Clear disable_master_thread before selecting cygwin input mode in those two
> > paths, so the mode is configured with the master thread already live and
> > ENABLE_PROCESSED_INPUT stays off. The disable paths and the synchronous
> > suspension that the referenced commit added are left unchanged, so
> > non-cygwin programs still get the master thread reliably suspended.
> > 
> > Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
> > Assisted-by: Opus 4.8
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/fhandler/console.cc | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 0136652878..685e99d62c 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1147,8 +1147,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
> >       in the same process group. */
> >    if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
> >      {
> > -      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> >        set_disable_master_thread (false, this);
> > +      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> >      }
> >    if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
> >      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> > @@ -2035,8 +2035,8 @@ fhandler_console::post_open_setup (int fd)
> >    /* Setting-up console mode for cygwin app started from non-cygwin app. */
> >    if (fd == 0)
> >      {
> > -      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> >        set_disable_master_thread (false, this);
> > +      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> >      }
> >    else if (fd == 1 || fd == 2)
> >      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> > -- snap --
> 
> I think we also need the following.
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index d2ffaa0c4..340bc3f2e 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -991,6 +994,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>    termios *ti = shared_console_info[unit] ?
>      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
>    /* Cleaning-up console mode for non-cygwin app. */
> +  set_disable_master_thread (con.owner == GetCurrentProcessId ());
>    /* conmode can be tty::restore when non-cygwin app is
>       exec'ed from login shell. */
>    tty::cons_mode conmode = cons_mode_on_close (p);
> @@ -998,7 +1002,6 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>      set_output_mode (conmode, ti, p);
>    if (con.curr_input_mode != conmode)
>      set_input_mode (conmode, ti, p);
> -  set_disable_master_thread (con.owner == GetCurrentProcessId ());
>  }
> 
>  /* Return the tty structure associated with a given tty number.  If the

If you agree with:
https://cygwin.com/pipermail/cygwin-patches/2026q2/015136.html
, I'll push this to master and cygwin-3_6-branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
