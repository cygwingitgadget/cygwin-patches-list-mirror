Return-Path: <SRS0=Wi/b=GE=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 6FB744BA79AF
	for <cygwin-patches@cygwin.com>; Tue, 11 Aug 2026 09:37:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6FB744BA79AF
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6FB744BA79AF
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786441073; cv=none;
	b=iei+gEwFxBNXYX2UTXUPv6Ag8hsfjYiqbOGp/d19QMiHvcN5x6MJ6at0ZDEzS5ZlQm8glfef+dLZffJiBQmH8JsktvtgWuNgV5sv/hefJ6TMN+3NnceiuiyHAmRkQXrXwZN0tCoGHoEAufSQ/euNirdtk5pMJMH4yorMuaoPSi4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786441073; c=relaxed/simple;
	bh=OklID0gxz4qpsGIBRTTAkZVsPfDbf8LN+UjzxZKQWO8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=m+K0lXpSf6OZvv+VAAr+Yj3+9tIYKLdLiJRE1oAYCixhokMchV94fpTLfDDLjZD2NgPokFMn00wb9SPxtzUTYMvui6jecSrYRjmAqhb7Z+YmNj5nAnvuBnhq7dkuwTB1LcnY5zBfsKSo1HnLIJ2uo0Hh21/8TIna1UnrVevCbmg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UkKAfcye
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6FB744BA79AF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UkKAfcye
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786441072; x=1787045872;
	i=johannes.schindelin@gmx.de;
	bh=x+JsAEEpohA6joEp1mfiJlIu9M1ZY0xvaxYN749Isxo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UkKAfcyeITgy2X9+hm3OTbT2oFZC0FE7f+yIp8C9gbNXL+4k2KwpMs0Ya//YW7Rt
	 d0fqbcz/7ery3bdktCgJEiV5m5m7TDe1Br+yyuutdc2vkQ/Isg5rLwld2PhZfoDYy
	 I5JlfjSi17qny2Qeljk/WSmWxPqVDo+zMNVN4F3TVgGGoTEEccthwtTad2mYDDCPc
	 9B9y1VuT8SVdPWqQ/pkAwhW+9mMnERcHY/dqfblQ6EBwkrRsqgkg+RRY4IikwZ3GZ
	 KigwlsnVRanAcy3sDQ9Hg+6QtfKq8DnlJ9tg7F6dzxhgEbAUcgoPcJrewqjKJjeNi
	 mw1DEBUp2yuJS3cNng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1wyioi46nX-0136bL; Tue, 11
 Aug 2026 11:37:52 +0200
Date: Tue, 11 Aug 2026 11:37:49 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v12] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
In-Reply-To: <20260807121459.3116-1-takashi.yano@nifty.ne.jp>
Message-ID: <6232ca34-e83a-621e-cc14-738a423cbc6c@gmx.de>
References: <20260807121459.3116-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:pIoDp1G+ene9A+A2gNNfLNc9MWmtEyYDFPrvtuxiGtPjHXpdeCb
 UGeV802fLtCt/Swst0wGPIOk6JvVLJ5XaIlkNl+wAC0AzV4kkTGgLw2JAfST5Ju4dZaPfKG
 LGEU85ZebemRX4ydYpGQAWSygV9K1lrZ5WiA1LnvlIc8DfhnJxdKjrCGessDifFOnpHZofX
 Zzd+hCb42S7xIAJ5rA6Ew==
UI-OutboundReport: notjunk:1;M01:P0:4YAMD2VTQcQ=;IGxc8NcPb9n2SjTTm+OXqezLG3Q
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

I missed something critical in my review of v11, and that's on me. I
checked the direct callers that take `cons_mode_mutex` and confirmed they
respect the ordering, but I did not trace an indirect path through the
echo code that inverts it and deadlocks. Two blockers, one requested
change, and a few nits below.

On Fri, 7 Aug 2026, Takashi Yano wrote:

> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one loosed appropriate console mode, since
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
> Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
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
>=20
>  winsup/cygwin/fhandler/console.cc       | 153 ++++++++++++++++++++++--
>  winsup/cygwin/fhandler/termios.cc       |  40 +++++--
>  winsup/cygwin/local_includes/fhandler.h |   7 +-
>  winsup/cygwin/select.cc                 |  14 +--
>  winsup/cygwin/spawn.cc                  |  44 +++----
>  5 files changed, 208 insertions(+), 50 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index d4c87f29f..cfef59c90 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -841,6 +841,7 @@ fhandler_console::setup ()
>        con.num_processed =3D 0;
>        con.curr_input_mode =3D tty::restore;
>        con.curr_output_mode =3D tty::restore;
> +      con.need_win32_input_mode_fix =3D false;
>      }
>  }
> =20
> @@ -977,16 +978,89 @@ fhandler_console::setup_for_non_cygwin_app ()
>       console mode. */
>    if (get_ttyp ()->getpgid () =3D=3D myself->pgid)
>      {
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
>        set_disable_master_thread (true, this);
>        set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
>        set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
> +      ReleaseMutex (cons_mode_mutex);
>      }
>  }
> =20
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
> +    }
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
> +}
> +
>  void
>  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
>  {
>    const _minor_t unit =3D p->unit;
> +  pid_t pgid =3D shared_console_info[unit] ?
> +    shared_console_info[unit]->tty_min_state.getpgid () : 0;
> +
> +  WaitForSingleObject (p->cons_mode_mutex, INFINITE);
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
> +    case 1: /* Exist */
> +      ReleaseMutex (p->cons_mode_mutex);
> +      return;
> +    case 0: /* Not exist */
> +      break;
> +    case -1: /* Error */
> +      /* In case of an error, perform the cleanup, since cygwin is
> +	 primarily intended to provide a correct enviroment for cygwin
> +	 apps rather than non-cygwin ones. */
> +      fallthrough;

You anticipated this on v11 when you noted that "msys2 might have
different concept", and this is the spot. The comment's reasoning holds
for a stock Cygwin install, but the scenario here is two native apps
sharing a pgid with one exiting, and for MSYS2 and Git for Windows native
Windows programs are the primary workload. Restoring cygwin mode precisely
when the process count is untrustworthy inverts the desired behavior for
the users most likely to reach this code.

Declining to restore on `-1` also fails safe, independent of MSYS2. The
Cygwin-app case self-heals: the next console `read()` or `write()` runs
`bg_check`, which re-asserts cygwin mode. A surviving native app does not
self-heal, because it sets its console mode once, at spawn. So keeping the
native mode when the count is uncertain is the safer default upstream too,
not only for us.

Could you make `case -1` release `cons_mode_mutex` and return, leaving the
native mode in place, while still logging the error via `system_printf`?

On the positive side, `wait_for_resume_if_necessary()` resolves v11's
unbounded busy-wait: it is bounded to 40 ms, it sleeps rather than spins,
and it is gated by `is_attaching()` and `is_console_app()`, whose
PE-subsystem check correctly excludes GUI applications. Documenting the
remaining non-overlay window as a known limitation is fine by me.

One note, though: that 40 ms wait runs inside `cygheap->lock()`, so a slow
console attach can stall other cygheap users for up to 40 ms. Worth
considering whether the wait needs to hold that lock.

That leaves a few smaller things. The `?9001` try-lock treats only
`WAIT_OBJECT_0` as success. `WAIT_ABANDONED` also grants ownership (a
previous owner died while holding the mutex), but the handler then skips
the body and never releases, leaking `cons_mode_mutex`. Please handle
`WAIT_ABANDONED` as well.

And a handful of typos:

	s/correnct/correct/

	s/requesting fo fixup/requesting a fixup/

	s/enviroment/environment/

	s/on going/ongoing/

The commit message word "loosed" also reads like a typo, though I am
not sure what it should be; can you clarify what you meant?

> +    default:
> +      system_printf("Checking for existence of non-cygwin app failed.")=
;
> +      break;
> +    }
> +
>    termios dummy =3D {0, };
>    termios *ti =3D shared_console_info[unit] ?
>      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
> @@ -994,11 +1068,11 @@ fhandler_console::cleanup_for_non_cygwin_app (han=
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
> @@ -1055,6 +1129,10 @@ fhandler_console::setup_io_mutex (void)
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
> @@ -1189,6 +1267,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>    /* Setting-up console mode for cygwin app. This is necessary if the
>       cygwin app and other non-cygwin apps are started simultaneously
>       in the same process group. */
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);

This introduces an ABBA deadlock (for interested readers:
https://www.oreilly.com/library/view/hands-on-system-programming/978178899=
8475/edf57b67-a572-4202-8e56-18c85c2141e4.xhtml).
With this line, `bg_check()` acquires `cons_mode_mutex` unconditionally as
its first action, before the foreground short-circuit, which lives later
in `fhandler_termios::bg_check`, after the release. Every echoed byte now
takes `cons_mode_mutex`.

But the echo path reaches `bg_check` with `input_mutex` already held:
`read()` holds `input_mutex` directly across `process_input_message()`,
and `select()` does the same via `peek_console()` -> `line_edit()` ->
`doecho()` -> `fhandler_console::write()`, whose first statement is
`bg_check` for `SIGTTOU`. So on this path the order is `input_mutex`, then
`cons_mode_mutex`.

Any concurrent mode change takes the reverse order: `open`, `tcsetattr`,
`setup_for_non_cygwin_app`/`cleanup_for_non_cygwin_app`, `close`, and a
background reader's `bg_check` for `SIGTTIN` all hold `cons_mode_mutex`
first and then block on `input_mutex` inside
`set_input_mode()`/`set_disable_master_thread()`.

Both are cross-process named mutexes, and `mutex_timeout` is `INFINITE`
outside GDB, so the moment an echo overlaps a mode change the two sides
wait on each other forever, whether across threads or across processes.
This is not pathological input; it fires on ordinary keystroke echo.

It also breaks the patch's own invariant that `cons_mode_mutex` is taken
before the input and output mutexes everywhere: the direct sites honor it,
but `bg_check` on the echo path inverts it. That indirect path is the one
I failed to trace for v11; the deadlock was already present there. The fix
has to keep `bg_check` from acquiring `cons_mode_mutex` while
`input_mutex` may be held: skip or telescope the `bg_check` on the echo
path, or take `cons_mode_mutex` outside the `input_mutex` region.

>    if (sig =3D=3D SIGTTIN && con.curr_input_mode !=3D tty::cygwin)
>      {
>        set_disable_master_thread (false, this);
> @@ -1196,6 +1275,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>      }
>    if (sig =3D=3D SIGTTOU && con.curr_output_mode !=3D tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    return fhandler_termios::bg_check (sig, dontsignal);
>  }
> @@ -2010,6 +2090,7 @@ fhandler_console::open (int flags, mode_t)
>    if (in_is_console)
>      CloseHandle (h_in);
> =20
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
>      {
>        prev_input_mode_backup =3D con.prev_input_mode;
> @@ -2022,6 +2103,7 @@ fhandler_console::open (int flags, mode_t)
>        GetConsoleMode (get_output_handle (), &con.prev_output_mode);
>        set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
>      }
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
>  		get_output_handle ());
> @@ -2105,6 +2187,7 @@ fhandler_console::open_setup (int flags)
>        handle_set.output_handle =3D get_output_handle ();
>        handle_set.input_mutex =3D input_mutex;
>        handle_set.output_mutex =3D output_mutex;
> +      handle_set.cons_mode_mutex =3D cons_mode_mutex;
>        handle_set.unit =3D unit;
>      }
>    return fhandler_base::open_setup (flags);
> @@ -2114,6 +2197,7 @@ void
>  fhandler_console::post_open_setup (int fd)
>  {
>    /* Setting-up console mode for cygwin app started from non-cygwin app=
. */
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (fd =3D=3D 0)
>      {
>        set_disable_master_thread (false, this);
> @@ -2121,6 +2205,7 @@ fhandler_console::post_open_setup (int fd)
>      }
>    else if (fd =3D=3D 1 || fd =3D=3D 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    fhandler_base::post_open_setup (fd);
>  }
> @@ -2130,18 +2215,20 @@ fhandler_console::close (int flag)
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
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
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
> @@ -2196,6 +2283,8 @@ fhandler_console::close (int flag)
>    input_mutex =3D NULL;
>    CloseHandle (output_mutex);
>    output_mutex =3D NULL;
> +  CloseHandle (cons_mode_mutex);
> +  cons_mode_mutex =3D NULL;
> =20
>    pcon_hand_over_proc ();
> =20
> @@ -2245,8 +2334,8 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
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
> @@ -2369,10 +2458,12 @@ int
>  fhandler_console::tcsetattr (int a, struct termios const *t)
>  {
>    get_ttyp ()->ti =3D *t;
> +  WaitForSingleObject (cons_mode_mutex, INFINITE);
>    if (con.curr_input_mode =3D=3D tty::cygwin)
>      set_input_mode (tty::cygwin, t, &handle_set);
>    if (con.curr_output_mode =3D=3D tty::cygwin)
>      set_output_mode (tty::cygwin, t, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
>    return 0;
>  }
> =20
> @@ -3140,10 +3231,22 @@ fhandler_console::char_command (char c)
>  		    con.cursor_key_app_mode =3D (c =3D=3D 'h');
>  		  if (con.args[i] =3D=3D 9001) /* win32-input-mode (https://github.co=
m/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard=
%20handling%20in%20Conpty.md) */
>  		    {
> -		      set_disable_master_thread (c =3D=3D 'h', this);
> -		      if (con.curr_input_mode =3D=3D tty::cygwin)
> -			set_input_mode (tty::cygwin,
> -					&tc ()->ti, get_handle_set ());
> +		      /* The correnct order of acquiring mutex should be
> +			 cons_mode_mutex first, then output_mutex.
> +			 However, here, output_mutex is already acquired.
> +			 So, to avoid deadlock, if another mode change is
> +			 on going concurrently, set the flag requesting
> +			 fo fixup for win32-input-mode. */
> +		      DWORD wret =3D WaitForSingleObject (cons_mode_mutex, 0);
> +		      if (wret =3D=3D WAIT_OBJECT_0)
> +			{
> +			  set_disable_master_thread (c =3D=3D 'h', this);
> +			  if (con.curr_input_mode =3D=3D tty::cygwin)
> +			    set_input_mode (tty::cygwin,
> +					    &tc ()->ti, get_handle_set ());
> +			  ReleaseMutex (cons_mode_mutex);
> +			}
> +		      con.need_win32_input_mode_fix =3D (c =3D=3D 'h');
>  		    }
>  		}
>  	      /* Call fix_tab_position() if screen has been alternated. */
> @@ -4475,10 +4578,13 @@ fhandler_console::set_console_mode_to_native ()
>  	fhandler_console *cons =3D (fhandler_console *) (fhandler_base *) cfd;
>  	if (cons->get_device () =3D=3D cons->tc ()->getntty ())
>  	  {
> +	    const fhandler_console::handle_set_t *p =3D cons->get_handle_set (=
);
> +	    WaitForSingleObject (p->cons_mode_mutex, INFINITE);
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
> @@ -4535,8 +4641,17 @@ ContinueDebugEvent_Hooked
>  static FARPROC
>  GetProcAddress_Hooked (HMODULE h, LPCSTR n)
>  {
> -  if (strcmp(n, "RequestTermConnector") =3D=3D 0)
> -    fhandler_console::set_disable_master_thread (true);
> +  if (cygheap->ctty && strcmp(n, "RequestTermConnector") =3D=3D 0)
> +    {
> +      char buf[MAX_PATH];
> +      const _minor_t unit =3D cygheap->ctty->get_minor ();
> +      shared_name (buf, "cygcons.cons_mode.mutex", unit);
> +      HANDLE cons_mode_mutex =3D CreateMutex (&sec_none, FALSE, buf);
> +      WaitForSingleObject (cons_mode_mutex, INFINITE);
> +      fhandler_console::set_disable_master_thread (true);
> +      ReleaseMutex (cons_mode_mutex);
> +      CloseHandle (cons_mode_mutex);
> +    }
>    return GetProcAddress_Orig (h, n);
>  }
> =20
> @@ -4817,6 +4932,9 @@ fhandler_console::get_duplicated_handle_set (handl=
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
> @@ -4833,6 +4951,8 @@ fhandler_console::close_handle_set (handle_set_t *=
p)
>    p->input_mutex =3D NULL;
>    CloseHandle (p->output_mutex);
>    p->output_mutex =3D NULL;
> +  CloseHandle (p->cons_mode_mutex);
> +  p->cons_mode_mutex =3D NULL;
>  }
> =20
>  bool
> @@ -4852,6 +4972,15 @@ fhandler_console::set_disable_master_thread (bool=
 x, fhandler_console *cons)
>  	return;
>      }
>    const _minor_t unit =3D cons->get_minor ();
> +  if (con.need_win32_input_mode_fix)
> +    /* Even when enabling cons_master_thread is requested, the master
> +       thread should not be enabled if win32_input_mode is set. */
> +    {
> +      if (con.disable_master_thread)
> +	return;
> +      else
> +	x =3D true;
> +    }

The second blocker: this guard is evaluated one assignment too early. In
`char_command()`, the `?9001` handler sets `need_win32_input_mode_fix` --
true for `?9001h`, false for `?9001l` -- only after it has already called
`set_disable_master_thread` with that same value.

So take `?9001l` arriving while a `?9001h` session is active, that is, the
flag is still true and `disable_master_thread` is true.
`set_disable_master_thread` is called with `false`, but because the flag
is still set it enters this new branch, sees `disable_master_thread`
already true, and returns early without clearing it. The flag is cleared
only afterward, so the master thread is left disabled for good.

That is a keyboard and signal regression: after any win32-input-mode
session, a busy foreground Cygwin process no longer gets Ctrl-C or Ctrl-S
handled by the master thread until its next `read()`, and `bg_check` for
`SIGTTIN` cannot rescue it, since the mode is already `tty::cygwin`. The
pre-patch code always re-enabled the master thread on `?9001l`.

The one-line fix is to move the assignment to `need_win32_input_mode_fix`
ahead of the try-lock and `set_disable_master_thread` block, so the guard
reads the new value.

Two smaller points in the same area, less important than that fix: the
flag is written in `char_command` (on the try-lock-timeout path, without
`cons_mode_mutex` held) and read in `set_disable_master_thread` with no
lock in common, on a cross-process `dev_console` field, so it is a data
race. And on `WAIT_TIMEOUT` the code still skips the immediate switch to
`tty::cygwin` mode; the flag gates only the master thread, not the input
mode.

Given the two blockers, this needs another round, I think. I am happy to
work through the `bg_check`/`cons_mode_mutex` ordering with you if that
helps; it is genuinely hard to get right, and I share the responsibility
for missing it the first time.

Ciao,
Johannes

>    cons->acquire_input_mutex (mutex_timeout);
>    con.disable_master_thread =3D x;
>    cons->release_input_mutex ();
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
> index d11b3ec4f..966610f55 100644
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
> @@ -2157,6 +2159,7 @@ class dev_console
>    volatile bool master_thread_suspended;
>    int num_processed; /* Number of input events in the current input buf=
fer
>  			already processed by cons_master_thread(). */
> +  bool need_win32_input_mode_fix;
> =20
>    inline UINT get_console_cp ();
>    DWORD con_to_str (char *d, int dlen, WCHAR w);
> @@ -2199,6 +2202,7 @@ private:
>    static console_state *shared_console_info[MAX_CONS_DEV + 1];
>    static bool invisible_console;
>    HANDLE input_mutex, output_mutex;
> +  HANDLE cons_mode_mutex;
>    handle_set_t handle_set;
>    _minor_t unit;
>    size_t num_input_events_processed;
> @@ -2379,6 +2383,7 @@ private:
>    void setup_pcon_hand_over ();
>    static void pcon_hand_over_proc ();
>    static tty::cons_mode cons_mode_on_close (handle_set_t *);
> +  static int active_non_cygwin_apps_exist (pid_t pgid);
> =20
>    friend tty_min * tty_list::get_cttyp ();
>  };
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index b72083447..592f6d14d 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1154,23 +1154,23 @@ peek_console (select_record *me, bool)
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
>        if (fhandler_console::input_winch =3D=3D fh->process_input_messag=
e (0)
>  	  && global_sigs[SIGWINCH].sa_handler !=3D SIG_IGN
> @@ -1180,8 +1180,8 @@ peek_console (select_record *me, bool)
>  	  fh->release_input_mutex ();
>  	  return -1;
>  	}
> +      fh->release_input_mutex ();
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
