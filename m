Return-Path: <SRS0=WkfY=HQ=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 84C704BB3BAA
	for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 19:17:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 84C704BB3BAA
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 84C704BB3BAA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790277424; cv=none;
	b=jCjlVW3wa197vF+5m+64f5z4gh2ghlyZRc+288/ag3uPRnGkTsE+Q42tYKIbO/nHPyIo8z8nlGRxS569skmEctdqpO/3ZbYrvgxmKC+BoYjZPTohNLQ8XlbaFt28+LOM+kPQnYMt57gTTZ2F5U4BfjrcktPKUz/HpHMKFERln84=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790277424; c=relaxed/simple;
	bh=Az5zi3FG0nhwkdLhlLdSWpzDqmd+WUKMfG2NRYqvrLc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Shw9LDmtynSJptbFkFLTL8yHdsKx0hliEOwgAfs3jXG+OMc1kv0cL0mGsjOJdgZAh9UKguYXGWs5kPOrmh1fuAi0xhwOqBp4MLfCNKNcbPFxt9LrR/3lTD4X65iD+h8z17qtx8IULXCpkddAsOHUrJHY0J0TitIuqc8QZtMpVOw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=l/GavzU4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 84C704BB3BAA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=l/GavzU4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790277422; x=1790882222;
	i=johannes.schindelin@gmx.de;
	bh=D/fhCEgCj13AEX3/F3yKdoI81ZRJp0lvfQk1ZJSfy8o=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l/GavzU4T1Bk+mwICciwInViByEQHhjJJTUN2eYkEskJrICZh89RNVRf+1yICCqe
	 boYAFrECxh6h1oFwScuRcCXxSWbYeXtej6WnE/9vlMcu01201ULsTjWkK2wt3zcpg
	 bHsCghzps0wQRF9QdVjMhFK/jYElG0RJKgra6a50ZzbhAZqHWGrdQEnv2Y+Jfibmr
	 gJSWWn9Rtm7CweXT7DPrNz6pDaNXUp9TrPjYKKHqa/38lQCmf6RP180JXYZ50xG4d
	 CfauN0MtK+EPvtaO8M4gNLcO6ebCrOG1S2S+CO6PR7e4MHzQkh4UcVDs4jsHM//jr
	 mqUas5gIVIl7JmHLjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzk3-1xG25906UT-00YDfC; Thu, 24
 Sep 2026 21:17:02 +0200
Date: Thu, 24 Sep 2026 21:17:02 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v18] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
In-Reply-To: <20260919004709.26360-1-takashi.yano@nifty.ne.jp>
Message-ID: <2311c8be-0e57-6153-728f-144f22fcbbec@gmx.de>
References: <20260919004709.26360-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:zE89BlJYNVFXL8NM0eJVkjMW6LEZe6MHgxJGKBKj5gztkgzbP9J
 J72Q1WktxUKGGjIRttEmRM0fxkBBe4nDFIo6+Xua27bPn5oR6wWqm3zkrzTP9C/L6QbK0u7
 nPO95E45rZS1Ie3a0z79uTM/RwVGPPuRLC0m1E9gIyZGtir1LuqzP2XEMNr2BCTtNTp1bYY
 7YiwjRh5cshck2RlB7SvA==
UI-OutboundReport: notjunk:1;M01:P0:q7oowwkjk/M=;64iU4wlGVW2QaLmI60ZhIIRrte+
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

I'm very sorry, I just realized that I never responded to this iteration:
It looks good to me!

Thank you _so much_!
Johannes

On Sat, 19 Sep 2026, Takashi Yano wrote:

> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one lost appropriate console mode, since
> the first one restored it to tty::cygwin. This patch counts the
> active console process whose pgid is pgid of the tty and if the
> result is zero (means the last non-cygwin foreground process),
> restore console mode. To avoid race issue between apps modifying
> console mode simultaneously, this patch also introduce a mutex
> named `cons_mode_mutex`.
>=20
> Known limitation:
> In the case of non-overlayed spawn, there still exists a small
> window in which another non-cygwin process may restore tty::cygwin
> mode even though new non-cygwin app is about to start.
>=20
> In addition:
> Avoid the cleanup/startup deadlock: cleanup can hold `cons_mode_mutex`
> while waiting for a console master that a new owner cannot start until
> acquiring that mutex. Startup must precede the mode-mutex wait without
> changing the handshake or mode serialization.
>=20
> Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Stop counting up/down the counter by itself.
>     Use num_active_non_cygwin_apps() instead.
> v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> v4: Guard all mode changes in console by cons_mode_mutex.
> v5: Fix the issue of mutex acquisition order.
>     Fix the race window around the process creation.
>     Improve latency of checking existence of non-cygwin apps.
>     Handle errors in checking existence of non-cygwin apps.
> v6: Match the conditions for incrementing and decrementing the counter.
> v7: Decrement the counter only if it was incremented by myself.
> v8: Symlify the conditions for incrementing and decrementing the counter
>     a bit.
> v9: Minimize the argument of set_non_cygwin_app_setup_ongoing().
> v10: Set process_state before calling spawn_worker::setup() rather than
>      using the counter. In addition, resume non-cygwin app before
> 	 modifying process table. These make things much simpler.
>      Narrowing the period of acquiring input_mutex in peek_console()
>      in select.cc.
> v11: Release output_mutex before calling bg_check() in ioctl().
>      Suppress unecessary console-mode change attempts.
> v12: Change handling of disabling master thread in the case of win32
>      input mode.
>      Wait for console attaching only when the spawned app is a console
>      app. In addition, a timeout is introduced to this wait loop for
>      safety.
> v13: Do not perform cleanup for non-cygwin apps on the error in
>      active_non_cygwin_apps_exist().
>      Handle WAIT_ABANDONED in CSI?9001h/l handling.
>      Fix ABBA deadlock about echo code path.
>      Set need_win32_input_mode_fix before set_disable_master_thread()
>      in CSI?9001h/l handling.
>      Setting and checking for need_win32_input_mode_fix inside the
>      input_mutex.
>      Fix the problem that the flag need_win32_input_mode_fix is set,
>      but disable_master_thread does not set if another thread holds
>      cons_mode_mutex.
> v14: Re-design echo code path. (Introduce raw_write() for doecho())
>      Re-design the handling of need_win32_input_mode_fix from scratch.
> v15: Fix possible deadlock with input_mutex regarding doecho()
> v16: Avoid to overwrite ENABLE_PROCESS_INPUT in tty::native mode.
>      Call fix_input_mode_if_necessary in TIMEOUT case as well.
> v17: Three more fixes suggested by Johannes:
>        (1) Create master thread before the console mode change in
>            open().
>        (2) Call fix_input_mode_if_necessary() in the canonical mode
>            loop in read().
>        (3) Ack for disable_master_thread =3D false when
>            need_win32_input_mode_fix is true.
> v18: Two more fixes suggested by Johannes:
>        (1) Call fix_input_mode_if_necessary() for WINCH cases.
>            (in read() and peek_console())
>        (2) Also cover read_more case in read() with
>            fix_input_mode_if_necessary().
>=20
>  winsup/cygwin/fhandler/console.cc       | 245 ++++++++++++++++++++----
>  winsup/cygwin/fhandler/termios.cc       |  40 +++-
>  winsup/cygwin/local_includes/fhandler.h |  10 +-
>  winsup/cygwin/select.cc                 |  20 +-
>  winsup/cygwin/spawn.cc                  |  44 +++--
>  5 files changed, 281 insertions(+), 78 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index be41bf3a2..2d5382c0d 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -443,6 +443,12 @@ fhandler_console::cons_master_thread (handle_set_t =
*p, tty *ttyp)
>  	  cygwait (40);
>  	  continue;
>  	}
> +      if (con.need_win32_input_mode_fix)
> +	{
> +	  con.master_thread_suspended =3D false;
> +	  cygwait (40);
> +	  continue;
> +	}
> =20
>        acquire_attach_mutex (mutex_timeout);
>        GetNumberOfConsoleInputEvents (p->input_handle, &total_read);
> @@ -841,6 +847,8 @@ fhandler_console::setup ()
>        con.num_processed =3D 0;
>        con.curr_input_mode =3D tty::restore;
>        con.curr_output_mode =3D tty::restore;
> +      con.need_win32_input_mode_fix =3D false;
> +      con.is_processed_input =3D false;
>      }
>  }
> =20
> @@ -877,6 +885,44 @@ fhandler_console::rabuflen ()
>  static DWORD prev_input_mode_backup;
>  static DWORD prev_output_mode_backup;
> =20
> +/* Even under cons_mode_mutex, only need_win32_input_mode_fix can be
> +   modified by another thread. This function sets or clears the
> +   ENABLE_PROCESSED_INPUT flag to reflect the current value of
> +   need_win32_input_mode_fix. */
> +void
> +fhandler_console::fix_input_mode_if_necessary ()
> +{
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> +  if (con.curr_input_mode !=3D tty::cygwin)
> +    {
> +      ReleaseMutex (cons_mode_mutex);
> +      return;
> +    }
> +  bool need_processed_input =3D
> +    con.master_thread_suspended || con.disable_master_thread
> +    || con.need_win32_input_mode_fix;
> +  if (need_processed_input =3D=3D con.is_processed_input)
> +    {
> +      ReleaseMutex (cons_mode_mutex);
> +      return;
> +    }
> +  WaitForSingleObject (input_mutex, mutex_timeout);
> +  acquire_attach_mutex (mutex_timeout);
> +  DWORD resume_pid =3D attach_console (con.owner);
> +  DWORD flags;
> +  GetConsoleMode (get_handle (), &flags);
> +  if (need_processed_input)
> +    flags |=3D ENABLE_PROCESSED_INPUT;
> +  else
> +    flags &=3D ~ENABLE_PROCESSED_INPUT;
> +  con.is_processed_input =3D need_processed_input;
> +  SetConsoleMode (get_handle (), flags);
> +  detach_console (resume_pid, con.owner);
> +  release_attach_mutex ();
> +  ReleaseMutex (input_mutex);
> +  ReleaseMutex (cons_mode_mutex);
> +}
> +
>  /* The function set_{in,out}put_mode() should be static so that they
>     can be called even after the fhandler_console instance is deleted. *=
/
>  void
> @@ -899,7 +945,10 @@ fhandler_console::set_input_mode (tty::cons_mode m,=
 const termios *t,
>        break;
>      case tty::cygwin:
>        flags |=3D ENABLE_WINDOW_INPUT;
> -      if (con.master_thread_suspended || con.disable_master_thread)
> +      con.is_processed_input =3D
> +	con.master_thread_suspended || con.disable_master_thread
> +	|| con.need_win32_input_mode_fix;
> +      if (con.is_processed_input)
>  	flags |=3D ENABLE_PROCESSED_INPUT;
>        if (wincap.has_con_24bit_colors () && !con_is_legacy)
>  	flags |=3D ENABLE_VIRTUAL_TERMINAL_INPUT;
> @@ -921,6 +970,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, =
const termios *t,
>      }
>    con.curr_input_mode =3D m;
>    SetConsoleMode (p->input_handle, flags);
> +  con.is_processed_input =3D (flags & ENABLE_PROCESSED_INPUT) !=3D 0;
>    if (!(oflags & ENABLE_VIRTUAL_TERMINAL_INPUT)
>        && (flags & ENABLE_VIRTUAL_TERMINAL_INPUT)
>        && con.cursor_key_app_mode)
> @@ -977,16 +1027,92 @@ fhandler_console::setup_for_non_cygwin_app ()
>       console mode. */
>    if (get_ttyp ()->getpgid () =3D=3D myself->pgid)
>      {
> +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>        set_disable_master_thread (true, this);
>        set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
>        set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
> +      ReleaseMutex (cons_mode_mutex);
> +    }
> +}
> +
> +/* Return values
> +   0: not exist
> +   1: exist
> +  -1: error */
> +int
> +fhandler_console::active_non_cygwin_apps_exist (pid_t pgid)
> +{
> +  tmp_pathbuf tp;
> +  DWORD *list =3D (DWORD *) tp.c_get ();
> +  const DWORD buf_size =3D NT_MAX_PATH / sizeof (DWORD);
> +
> +  DWORD buf_size1 =3D 1;
> +  DWORD num;
> +  /* The buffer of too large size does not seem to be expected by new c=
ondrv.
> +     https://github.com/microsoft/terminal/issues/18264#issuecomment-25=
15448548
> +     Use the minimum buffer size in the loop. */
> +  while ((num =3D GetConsoleProcessList (list, buf_size1)) > buf_size1)
> +    {
> +      if (num > buf_size)
> +	return -1;
> +      buf_size1 =3D num;
>      }
> +  if (num =3D=3D 0)
> +    return -1;
> +
> +  /* Last one is the oldest. */
> +  /* https://github.com/microsoft/terminal/issues/95 */
> +  /* Assuming that newer processes are more likely to be non-cygwin. */
> +  for (DWORD i =3D 0; i < num; i++)
> +    {
> +      DWORD my_pid =3D myself->exec_dwProcessId ? : myself->dwProcessId=
;
> +      if (list[i] =3D=3D my_pid)
> +	continue;
> +      pid_t pid =3D cygwin_pid (list[i]);
> +      if (pid =3D=3D 0)
> +	continue;
> +      pinfo p (pid);
> +      if (!!p && p->pgid =3D=3D pgid && ISSTATE (p, PID_NOTCYGWIN))
> +	return 1;
> +    }
> +  return 0;
>  }
> =20
>  void
>  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>  {
>    const _minor_t unit =3D p->unit;
> +  pid_t pgid =3D shared_console_info[unit] ?
> +    shared_console_info[unit]->tty_min_state.getpgid () : 0;
> +
> +  WaitForSingleObject (p->cons_mode_mutex, mutex_timeout);
> +  tty::cons_mode conmode =3D cons_mode_on_close (p);
> +  if (con.curr_input_mode =3D=3D conmode && con.curr_output_mode =3D=3D=
 conmode
> +      && con.disable_master_thread =3D=3D (con.owner =3D=3D GetCurrentP=
rocessId ()))
> +    {
> +      ReleaseMutex (p->cons_mode_mutex);
> +      return;
> +    }
> +  switch (active_non_cygwin_apps_exist (pgid))
> +    {
> +    case -1: /* Error */
> +      /* In case of an error, do not perform the cleanup, since the
> +	 cygwin app has a chnce to restore console mode in bg_check()
> +	 called from read()/write(). So give a priority to non-cygwin
> +	 apps here that may exist. */
> +      system_printf ("Checking for existence of non-cygwin app failed."=
);
> +      if (con.owner =3D=3D GetCurrentProcessId ())
> +	/* This process is supposed to be the last non-cygwin process */
> +	break;
> +      fallthrough;
> +    case 1: /* Exist */
> +      ReleaseMutex (p->cons_mode_mutex);
> +      return;
> +    case 0: /* Not exist */
> +    default:
> +      break;
> +    }
> +
>    termios dummy =3D {0, };
>    termios *ti =3D shared_console_info[unit] ?
>      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
> @@ -994,11 +1120,11 @@ fhandler_console::cleanup_for_non_cygwin_app (han=
dle_set_t *p)
>    set_disable_master_thread (con.owner =3D=3D GetCurrentProcessId ());
>    /* conmode can be tty::restore when non-cygwin app is
>       exec'ed from login shell. */
> -  tty::cons_mode conmode =3D cons_mode_on_close (p);
>    if (con.curr_output_mode !=3D conmode)
>      set_output_mode (conmode, ti, p);
>    if (con.curr_input_mode !=3D conmode)
>      set_input_mode (conmode, ti, p);
> +  ReleaseMutex (p->cons_mode_mutex);
>  }
> =20
>  /* Return the tty structure associated with a given tty number.  If the
> @@ -1055,6 +1181,10 @@ fhandler_console::setup_io_mutex (void)
>    if (res =3D=3D WAIT_OBJECT_0)
>      release_output_mutex ();
> =20
> +  shared_name (buf, "cygcons.cons_mode.mutex", get_minor ());
> +  if (!cons_mode_mutex)
> +    cons_mode_mutex =3D CreateMutex (&sec_none, FALSE, buf);
> +
>    extern HANDLE attach_mutex;
>    if (!attach_mutex)
>      attach_mutex =3D CreateMutex (&sec_none_nih, FALSE, NULL);
> @@ -1182,13 +1312,13 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECOR=
D& mouse_event)
>  		 || con.use_mouse >=3D 3));
>  }
> =20
> -
>  bg_check_types
>  fhandler_console::bg_check (int sig, bool dontsignal)
>  {
>    /* Setting-up console mode for cygwin app. This is necessary if the
>       cygwin app and other non-cygwin apps are started simultaneously
>       in the same process group. */
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (sig =3D=3D SIGTTIN && con.curr_input_mode !=3D tty::cygwin)
>      {
>        set_disable_master_thread (false, this);
> @@ -1196,6 +1326,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>      }
>    if (sig =3D=3D SIGTTOU && con.curr_output_mode !=3D tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    return fhandler_termios::bg_check (sig, dontsignal);
>  }
> @@ -1248,6 +1379,7 @@ wait_retry:
>  	case WAIT_TIMEOUT:
>  	  if (copied_chars)
>  	    {
> +	      fix_input_mode_if_necessary (); /* for win32_input_mode */
>  	      buflen =3D copied_chars;
>  	      return;
>  	    }
> @@ -1281,12 +1413,14 @@ wait_retry:
>  	  goto err;
>  	case input_processing:
>  	  release_input_mutex ();
> +	  fix_input_mode_if_necessary (); /* for win32_input_mode */
>  	  continue;
>  	case input_ok: /* input ready */
>  	  break;
>  	case input_signalled: /* signalled */
>  	case input_winch:
>  	  release_input_mutex ();
> +	  fix_input_mode_if_necessary (); /* for win32_input_mode */
>  	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
>  	    continue;
>  	  goto sig_exit;
> @@ -1308,6 +1442,8 @@ wait_retry:
>      input_ready =3D false;
>    release_input_mutex ();
> =20
> +  fix_input_mode_if_necessary (); /* for win32_input_mode */
> +
>    if (buflen > copied_chars && !(get_ttyp ()->ti.c_lflag & ICANON)
>        && copied_chars < get_ttyp ()->ti.c_cc[VMIN])
>      goto read_more;
> @@ -2011,22 +2147,8 @@ fhandler_console::open (int flags, mode_t)
>    if (in_is_console)
>      CloseHandle (h_in);
> =20
> -  if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
> -    {
> -      prev_input_mode_backup =3D con.prev_input_mode;
> -      GetConsoleMode (get_handle (), &con.prev_input_mode);
> -      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> -    }
> -  if (out_is_console && con.curr_output_mode !=3D tty::cygwin)
> -    {
> -      prev_output_mode_backup =3D con.prev_output_mode;
> -      GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> -      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> -    }
> -
> -  debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
> -		get_output_handle ());
> -
> +  /* Another process may hold cons_mode_mutex while waiting for the
> +     master thread to acknowledge a state change. */
>    if (GetCurrentProcessId () =3D=3D con.owner)
>      {
>        if (GetModuleHandle ("ConEmuHk64.dll"))
> @@ -2044,6 +2166,25 @@ fhandler_console::open (int flags, mode_t)
>  	debug_printf ("Failed to create thread_sync_event %08x",
>  		      GetLastError ());
>      }
> +
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> +  if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
> +    {
> +      prev_input_mode_backup =3D con.prev_input_mode;
> +      GetConsoleMode (get_handle (), &con.prev_input_mode);
> +      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +    }
> +  if (out_is_console && con.curr_output_mode !=3D tty::cygwin)
> +    {
> +      prev_output_mode_backup =3D con.prev_output_mode;
> +      GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> +      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +    }
> +  ReleaseMutex (cons_mode_mutex);
> +
> +  debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
> +		get_output_handle ());
> +
>    return 1;
>  }
> =20
> @@ -2106,6 +2247,7 @@ fhandler_console::open_setup (int flags)
>        handle_set.output_handle =3D get_output_handle ();
>        handle_set.input_mutex =3D input_mutex;
>        handle_set.output_mutex =3D output_mutex;
> +      handle_set.cons_mode_mutex =3D cons_mode_mutex;
>        handle_set.unit =3D unit;
>      }
>    return fhandler_base::open_setup (flags);
> @@ -2115,6 +2257,7 @@ void
>  fhandler_console::post_open_setup (int fd)
>  {
>    /* Setting-up console mode for cygwin app started from non-cygwin app=
. */
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (fd =3D=3D 0)
>      {
>        set_disable_master_thread (false, this);
> @@ -2122,6 +2265,7 @@ fhandler_console::post_open_setup (int fd)
>      }
>    else if (fd =3D=3D 1 || fd =3D=3D 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    fhandler_base::post_open_setup (fd);
>  }
> @@ -2131,18 +2275,20 @@ fhandler_console::close (int flag)
>  {
>    debug_printf ("closing: %p, %p", get_handle (), get_output_handle ())=
;
> =20
> -  acquire_output_mutex (mutex_timeout);
> -
>    if (shared_console_info[unit] && (dev_t) myself->ctty =3D=3D get_devi=
ce ()
>        && cons_mode_on_close (&handle_set) =3D=3D tty::restore)
>      {
> +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>        set_disable_master_thread (true, this);
>        if (con.curr_output_mode !=3D tty::restore)
>  	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
>        if (con.curr_input_mode !=3D tty::restore)
>  	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
> +      ReleaseMutex (cons_mode_mutex);
>      }
> =20
> +  acquire_output_mutex (mutex_timeout);
> +
>    if (shared_console_info[unit] && con.owner =3D=3D GetCurrentProcessId=
 ())
>      {
>        if (master_thread_started)
> @@ -2197,6 +2343,8 @@ fhandler_console::close (int flag)
>    input_mutex =3D NULL;
>    CloseHandle (output_mutex);
>    output_mutex =3D NULL;
> +  CloseHandle (cons_mode_mutex);
> +  cons_mode_mutex =3D NULL;
> =20
>    pcon_hand_over_proc ();
> =20
> @@ -2246,8 +2394,8 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
rg)
>  	release_output_mutex ();
>  	return 0;
>        case TIOCSWINSZ:
> -	bg_check (SIGTTOU);
>  	release_output_mutex ();
> +	bg_check (SIGTTOU);
>  	return 0;
>        case KDGKBMETA:
>  	*(int *) arg =3D (con.metabit) ? K_METABIT : K_ESCPREFIX;
> @@ -2370,10 +2518,12 @@ int
>  fhandler_console::tcsetattr (int a, struct termios const *t)
>  {
>    get_ttyp ()->ti =3D *t;
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (con.curr_input_mode =3D=3D tty::cygwin)
>      set_input_mode (tty::cygwin, t, &handle_set);
>    if (con.curr_output_mode =3D=3D tty::cygwin)
>      set_output_mode (tty::cygwin, t, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
>    return 0;
>  }
> =20
> @@ -3140,12 +3290,7 @@ fhandler_console::char_command (char c)
>  		  if (con.args[i] =3D=3D 1) /* DECCKM */
>  		    con.cursor_key_app_mode =3D (c =3D=3D 'h');
>  		  if (con.args[i] =3D=3D 9001) /* win32-input-mode (https://github.co=
m/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard=
%20handling%20in%20Conpty.md) */
> -		    {
> -		      set_disable_master_thread (c =3D=3D 'h', this);
> -		      if (con.curr_input_mode =3D=3D tty::cygwin)
> -			set_input_mode (tty::cygwin,
> -					&tc ()->ti, get_handle_set ());
> -		    }
> +		    con.need_win32_input_mode_fix =3D (c =3D=3D 'h');
>  		}
>  	      /* Call fix_tab_position() if screen has been alternated. */
>  	      if (need_fix_tab_position)
> @@ -3994,6 +4139,18 @@ fhandler_console::write (const void *vsrc, size_t=
 len)
> =20
>    push_process_state process_state (PID_TTYOU);
> =20
> +  ssize_t ret =3D raw_write (vsrc, len);
> +
> +  fix_input_mode_if_necessary (); /* for win32_input_mode */
> +
> +  syscall_printf ("%ld =3D fhandler_console::write(...)", len);
> +
> +  return ret;
> +}
> +
> +ssize_t
> +fhandler_console::raw_write (const void *vsrc, size_t len)
> +{
>    acquire_output_mutex (mutex_timeout);
> =20
>    /* Run and check for ansi sequences */
> @@ -4327,18 +4484,13 @@ fhandler_console::write (const void *vsrc, size_=
t len)
>      }
>    release_output_mutex ();
> =20
> -  syscall_printf ("%ld =3D fhandler_console::write(...)", len);
> -
>    return len;
>  }
> =20
>  void
>  fhandler_console::doecho (const void *str, DWORD len)
>  {
> -  int stopped =3D get_ttyp ()->output_stopped;
> -  get_ttyp ()->output_stopped =3D 0;
> -  write (str, len);
> -  get_ttyp ()->output_stopped =3D stopped;
> +  raw_write (str, len);
>  }
> =20
>  static const struct {
> @@ -4476,10 +4628,13 @@ fhandler_console::set_console_mode_to_native ()
>  	fhandler_console *cons =3D (fhandler_console *) (fhandler_base *) cfd;
>  	if (cons->get_device () =3D=3D cons->tc ()->getntty ())
>  	  {
> +	    const fhandler_console::handle_set_t *p =3D cons->get_handle_set (=
);
> +	    WaitForSingleObject (p->cons_mode_mutex, mutex_timeout);
>  	    set_disable_master_thread (true, cons);
>  	    termios *cons_ti =3D &cons->tc ()->ti;
> -	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
> -	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
> +	    set_input_mode (tty::native, cons_ti, p);
> +	    set_output_mode (tty::native, cons_ti, p);
> +	    ReleaseMutex (p->cons_mode_mutex);
>  	    break;
>  	  }
>        }
> @@ -4536,8 +4691,17 @@ ContinueDebugEvent_Hooked
>  static FARPROC
>  GetProcAddress_Hooked (HMODULE h, LPCSTR n)
>  {
> -  if (strcmp(n, "RequestTermConnector") =3D=3D 0)
> -    fhandler_console::set_disable_master_thread (true);
> +  if (cygheap->ctty && strcmp (n, "RequestTermConnector") =3D=3D 0)
> +    {
> +      char buf[MAX_PATH];
> +      const _minor_t unit =3D cygheap->ctty->get_minor ();
> +      shared_name (buf, "cygcons.cons_mode.mutex", unit);
> +      HANDLE cons_mode_mutex =3D CreateMutex (&sec_none, FALSE, buf);
> +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> +      fhandler_console::set_disable_master_thread (true);
> +      ReleaseMutex (cons_mode_mutex);
> +      CloseHandle (cons_mode_mutex);
> +    }
>    return GetProcAddress_Orig (h, n);
>  }
> =20
> @@ -4818,6 +4982,9 @@ fhandler_console::get_duplicated_handle_set (handl=
e_set_t *p)
>    DuplicateHandle (GetCurrentProcess (), output_mutex,
>  		   GetCurrentProcess (), &p->output_mutex,
>  		   0, FALSE, DUPLICATE_SAME_ACCESS);
> +  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
> +		   GetCurrentProcess (), &p->cons_mode_mutex,
> +		   0, FALSE, DUPLICATE_SAME_ACCESS);
>    p->unit =3D unit;
>  }
> =20
> @@ -4834,6 +5001,8 @@ fhandler_console::close_handle_set (handle_set_t *=
p)
>    p->input_mutex =3D NULL;
>    CloseHandle (p->output_mutex);
>    p->output_mutex =3D NULL;
> +  CloseHandle (p->cons_mode_mutex);
> +  p->cons_mode_mutex =3D NULL;
>  }
> =20
>  bool
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index ee576a0a8..0134ec8b8 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -830,20 +830,37 @@ void
>  fhandler_termios::spawn_worker::cleanup ()
>  {
>    if (ptys_need_cleanup)
> -    fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> -						    ptys_ttyp, stdin_is_ptys);
> +    {
> +      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> +						      ptys_ttyp, stdin_is_ptys);
> +      fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> +      ptys_need_cleanup =3D false;
> +    }
>    if (cons_need_cleanup)
> -    fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
> -  close_handle_set ();
> +    {
> +      fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
> +      fhandler_console::close_handle_set (&cons_handle_set);
> +      cons_need_cleanup =3D false;
> +    }
> +}
> +
> +bool
> +fhandler_termios::spawn_worker::is_attaching (DWORD pid)
> +{
> +  return !!fhandler_termios::get_console_process_id (pid, true);
>  }
> =20
>  void
> -fhandler_termios::spawn_worker::close_handle_set ()
> +fhandler_termios::spawn_worker::wait_for_resume_if_necessary
> +			      (path_conv &pc, PROCESS_INFORMATION &pi)
>  {
> -  if (ptys_need_cleanup)
> -    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> -  if (cons_need_cleanup)
> -    fhandler_console::close_handle_set (&cons_handle_set);
> +  if (is_attaching (myself->dwProcessId) && is_console_app (pc))
> +    {
> +      DWORD t0 =3D GetTickCount ();
> +      while (GetTickCount () - t0 < 40 && !is_attaching (pi.dwProcessId=
)
> +	     && WaitForSingleObject (pi.hProcess, 0) =3D=3D WAIT_TIMEOUT)
> +	Sleep (1);
> +    }
>  }
> =20
>  void
> @@ -916,7 +933,10 @@ fhandler_termios::get_console_process_id (DWORD pid=
, bool match,
>  	  }
>  	else
>  	  {
> -	    pinfo p (cygwin_pid (list[i]));
> +	    pid_t cygpid =3D cygwin_pid (list[i]);
> +	    if (cygpid =3D=3D 0)
> +	      continue;
> +	    pinfo p (cygpid);
>  	    if (nat && !!p && !ISSTATE(p, PID_NOTCYGWIN))
>  	      continue;
>  	    if (!!p && p->exec_dwProcessId)
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index d11b3ec4f..e00212f57 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2023,6 +2023,7 @@ class fhandler_termios: public fhandler_base
>      HANDLE output_handle;
>      HANDLE input_mutex;
>      HANDLE output_mutex;
> +    HANDLE cons_mode_mutex;
>      _minor_t unit;
>    };
>    class spawn_worker
> @@ -2042,7 +2043,8 @@ class fhandler_termios: public fhandler_base
>  		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
>      bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanu=
p; }
>      void cleanup ();
> -    void close_handle_set ();
> +    bool is_attaching (DWORD pid);
> +    void wait_for_resume_if_necessary (path_conv &, PROCESS_INFORMATION=
 &);
>    };
>  };
> =20
> @@ -2157,6 +2159,8 @@ class dev_console
>    volatile bool master_thread_suspended;
>    int num_processed; /* Number of input events in the current input buf=
fer
>  			already processed by cons_master_thread(). */
> +  bool need_win32_input_mode_fix;
> +  bool is_processed_input;
> =20
>    inline UINT get_console_cp ();
>    DWORD con_to_str (char *d, int dlen, WCHAR w);
> @@ -2199,6 +2203,7 @@ private:
>    static console_state *shared_console_info[MAX_CONS_DEV + 1];
>    static bool invisible_console;
>    HANDLE input_mutex, output_mutex;
> +  HANDLE cons_mode_mutex;
>    handle_set_t handle_set;
>    _minor_t unit;
>    size_t num_input_events_processed;
> @@ -2268,6 +2273,7 @@ private:
> =20
>    void read (void *ptr, size_t& len);
>    ssize_t write (const void *ptr, size_t len);
> +  ssize_t raw_write (const void *ptr, size_t len);
>    void doecho (const void *str, DWORD len);
>    int close (int flag =3D -1);
>    static bool exists ()
> @@ -2366,6 +2372,7 @@ private:
>    void wpbuf_send ();
>    int fstat (struct stat *buf);
>    void discard_key_events (size_t n);
> +  void fix_input_mode_if_necessary ();
> =20
>    class console_unit
>    {
> @@ -2379,6 +2386,7 @@ private:
>    void setup_pcon_hand_over ();
>    static void pcon_hand_over_proc ();
>    static tty::cons_mode cons_mode_on_close (handle_set_t *);
> +  static int active_non_cygwin_apps_exist (pid_t pgid);
> =20
>    friend tty_min * tty_list::get_cttyp ();
>  };
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index b72083447..37b28d5d1 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1154,34 +1154,36 @@ peek_console (select_record *me, bool)
>    HANDLE h;
>    set_handle_or_return_if_not_open (h, me);
> =20
> -  fh->acquire_input_mutex (mutex_timeout);
>    while (!fh->input_ready && !fh->get_cons_readahead_valid ())
>      {
>        if (fh->bg_check (SIGTTIN, true) <=3D bg_eof)
> -	{
> -	  fh->release_input_mutex ();
> -	  return me->read_ready =3D true;
> -	}
> +	return me->read_ready =3D true;
>        else
>  	{
> +	  fh->acquire_input_mutex (mutex_timeout);
>  	  acquire_attach_mutex (mutex_timeout);
>  	  DWORD resume_pid =3D fh->attach_console (fh->get_owner ());
>  	  BOOL r =3D PeekConsoleInputW (h, &irec, 1, &events_read);
>  	  fh->detach_console (resume_pid, fh->get_owner ());
>  	  release_attach_mutex ();
>  	  if (!r || !events_read)
> -	    break;
> +	    {
> +	      fh->release_input_mutex ();
> +	      break;
> +	    }
>  	}
> -      if (fhandler_console::input_winch =3D=3D fh->process_input_messag=
e (0)
> +      fhandler_console::input_states ret =3D fh->process_input_message =
(0);
> +      fh->release_input_mutex ();
> +      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> +
> +      if (ret =3D=3D fhandler_console::input_winch
>  	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
>  	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_DFL)
>  	{
>  	  set_sig_errno (EINTR);
> -	  fh->release_input_mutex ();
>  	  return -1;
>  	}
>      }
> -  fh->release_input_mutex ();
>    if (fh->input_ready || fh->get_cons_readahead_valid ())
>      return me->read_ready =3D true;
> =20
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 8f976b9a0..abaa34d32 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -559,6 +559,14 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>  			 PROCESS_QUERY_LIMITED_INFORMATION))
>  	sa =3D &sec_none_nih;
> =20
> +      if (!real_path.iscygexec () && mode =3D=3D _P_OVERLAY)
> +	{
> +	  LONG pidflags =3D PID_NOTCYGWIN;
> +	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
> +	    pidflags |=3D PID_NEW_PG;
> +	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
> +	}
> +
>        int fileno_stdin =3D in__stdin < 0 ? 0 : in__stdin;
>        int fileno_stdout =3D in__stdout < 0 ? 1 : in__stdout;
>        int fileno_stderr =3D 2;
> @@ -586,14 +594,6 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>  	 up on ruid. The new process will have ruid =3D=3D euid. */
>        ::cygheap->user.deimpersonate ();
> =20
> -      if (!real_path.iscygexec () && mode =3D=3D _P_OVERLAY)
> -	{
> -	  LONG pidflags =3D PID_NOTCYGWIN;
> -	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
> -	    pidflags |=3D PID_NEW_PG;
> -	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
> -	}
> -
>        cygpid =3D (mode !=3D _P_OVERLAY) ? create_cygwin_pid () : myself=
->pid;
> =20
>        cygheap->lock ();
> @@ -737,6 +737,18 @@ child_info_spawn::worker (const char *prog_arg, con=
st char *const *argv,
>        /* Name the handle similarly to proc_subproc. */
>        ProtectHandle1 (pi.hProcess, childhProc);
> =20
> +      /* Start the child running for non-cygwin process*/
> +      if (!iscygwin () && (c_flags & CREATE_SUSPENDED))
> +	{
> +	  /* Inject a non-inheritable wr_proc_pipe handle into child so that w=
e
> +	     can accurately track when the child exits without keeping this
> +	     process waiting around for it to exit.  */
> +	  DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess,
> +			   NULL, 0, false, DUPLICATE_SAME_ACCESS);
> +	  ResumeThread (pi.hThread);
> +	  term_spawn_worker.wait_for_resume_if_necessary (real_path, pi);
> +	}
> +
>        if (mode =3D=3D _P_OVERLAY)
>  	{
>  	  myself->dwProcessId =3D pi.dwProcessId;
> @@ -810,18 +822,11 @@ child_info_spawn::worker (const char *prog_arg, co=
nst char *const *argv,
>  	    }
>  	}
> =20
> -      /* Start the child running */
> -      if (c_flags & CREATE_SUSPENDED)
> +      /* Start the child running for cygwin process*/
> +      if (iscygwin () && (c_flags & CREATE_SUSPENDED))
>  	{
> -	  /* Inject a non-inheritable wr_proc_pipe handle into child so that w=
e
> -	     can accurately track when the child exits without keeping this
> -	     process waiting around for it to exit.  */
> -	  if (!iscygwin ())
> -	    DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess, =
NULL,
> -			     0, false, DUPLICATE_SAME_ACCESS);
>  	  ResumeThread (pi.hThread);
> -	  if (iscygwin ())
> -	    strace.write_childpid (pi.dwProcessId);
> +	  strace.write_childpid (pi.dwProcessId);
>  	}
>        ForceCloseHandle (pi.hThread);
> =20
> @@ -868,7 +873,6 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
>  		prev_sigExeced =3D
>  		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
>  	      term_spawn_worker.cleanup ();
> -	      term_spawn_worker.close_handle_set ();
>  	    }
>  	  /* Make sure that ctrl_c_handler() is not on going. Calling
>  	     init_console_handler(false) locks until returning from
> @@ -906,7 +910,7 @@ child_info_spawn::worker (const char *prog_arg, cons=
t char *const *argv,
>        res =3D -1;
>      }
>    __endtry
> -  term_spawn_worker.close_handle_set ();
> +  term_spawn_worker.cleanup ();
>    this->cleanup ();
>    if (envblock)
>      free (envblock);
> --=20
> 2.51.0
>=20
>=20
