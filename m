Return-Path: <SRS0=nquO=HF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id DAFCD4BB590F
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 10:38:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DAFCD4BB590F
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DAFCD4BB590F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789295915; cv=none;
	b=cTWiRdt+4VUkec07rNWHR6L9SAHBeMddbUr8VV7//jclOXr1JMGaOGfv0i8Sqlxl5lau0hJrWCpKNJ6PoIy+onLu5u7V4iDWv/H4hxn9F8i5zHqYTJIe2ttzj5cbiBIwV6d4wYyMm4kv9jxy4kkpKMGLLeBYSd63o5M5AMQLS38=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789295915; c=relaxed/simple;
	bh=x4twLp0wBSh4bx1pckz7bN0n3ojwU6XTtck3+r8znEs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ArElxL67M5WXF3XUD9YhnZN88dJdfp1eB6jYRx4MDqVVBkkaGW6uErJuVl+s/HvXda5Tyk1PKjhJxksZjGPY6cyJjYWTwLHvF8Zyg1ysoJS2uZa0+kzT1wbtnFNosEpoYq5AknALCCwmAXkq8Owj1UWzh9i5NhTC0HfFh292M20=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=G33F+vjs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DAFCD4BB590F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=G33F+vjs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789295913; x=1789900713;
	i=johannes.schindelin@gmx.de;
	bh=j8IEYKSv4MMbSkF4Jkt6WUeDHoWva2uxyoS5hOHOukw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G33F+vjsECX9kpnaCUl7PvPca7hhycnmnafy1Cf7ewPVXS/Nu8zNY2tczPrgRXXd
	 bfDphIb+tml2vW1+KH8K7aOIc9T5s6/WiyaumbkedaRq5LPj5mXtStbmA+Okz+aWS
	 /S9VogLTr+H1hss4sHmeVTqiEP9v5NcR38Woae3b5vqnc8mDDCtzC4IDyoyK0q97G
	 HqTKeZrpOu/NoenNLpkBn8uiuzf8v6KveJIKDd5BYWvQNFmuQA1ZorbCpWt/i3uQ+
	 pYuHoYR2Jxwqgwda4XFQD6QheIf50qOYCtgRHVHteLuiyGP61mjwWLfHGE8Q3TXqI
	 ymxOS/0otwYDQdomBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1wi4NT1jYE-0181FL; Sun, 13
 Sep 2026 12:38:33 +0200
Date: Sun, 13 Sep 2026 12:38:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v15] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
In-Reply-To: <20260913060128.1453-1-takashi.yano@nifty.ne.jp>
Message-ID: <115b3c1b-d5df-7274-ffea-3a12ac13a5ac@gmx.de>
References: <20260913060128.1453-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=83233284192842031789295913524983
X-Provags-ID: V03:K1:yF39Rn5dqJ9/i1qmc2MFwBiA9OFSIxXZ5/6t9SlhQ6+ejFwB9SB
 CMYlMSn+he4qAKkISOU3MO9Jr+Fz0U2snzhx/Qv6Kq2G/hp7VNWWa4iiVDP8BnXqzZr76l6
 VHbfzrJqzSbYNrUD9nMWMElYCFVZpL8ihbQ7wpdhwrxpdwlfB3oYMLu39csbzh/AXfl9wVp
 euLsSutZ0BiaNGWZ6WPJg==
UI-OutboundReport: notjunk:1;M01:P0:XcaEWP9wMqA=;Tap3tWpOw6OXvIIN4kd6g28ZJ4P
 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
 BK8nuRHUwSpgOzcLQeo35/k4FK/3P4G7Hlz11A=
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--83233284192842031789295913524983
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

thank you for your tenacity! You are going well above and beyond what any
open source maintainer could expect of any contributor, going to 15
iterations of a patch.

So I feel quite embarrassed to point out a couple more things I would like
to see changed... =F0=9F=98=8A I hope you forgive me!

Also please note that I am still trying my best to understand the
console/pty code with its implied contracts, and I feel comfortable in
saying that I am still too uncomfortable to claim that I really understand
it. _You_ are clearly the domain expert here, and I have to rely heavily
on AI when performing these reviews, which means that I can easily miss
crucial design decisions.

On Sun, 13 Sep 2026, Takashi Yano wrote:

> Previously, if two non-cygwin apps are started and one of them
> exits first, the other one loosed appropriate console mode, since

Did you mean "the other application lost the console mode it needed" here?
("loosed" could be either "loosened", i.e. the opposite of tightened, or
"lost", which I think you meant in this instance).

> the first one restored it to tty::cygwin. This patch counts the
> active console process whose pgid is pgid of the tty and if the
> result is zero (means the last non-cygwin foreground process),
> restore console mode. To avoid race issue between apps modifying
> console mode simultaneously, this patch also introduce a mutex
> named `cons_mode_mutex`.

Well explained, thanks!

>=20
> Known limitation:
> In the case of non-overlayed spawn, there still exists a small
> window in which another non-cygwin process may restore tty::cygwin
> mode even though new non-cygwin app is about to start.

Thank you for calling this out, and I also don't see any elegant way
around this limitation. It *could* be done via some sort of "pending"
state, but the difficult part is lifetime management: failed launches,
cancellation, early child exit, parent death, and simultaneous starts must
not leave stale pending state that would suppress cleanup forever.

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
>=20
>  winsup/cygwin/fhandler/console.cc       | 200 +++++++++++++++++++++---
>  winsup/cygwin/fhandler/termios.cc       |  40 +++--
>  winsup/cygwin/local_includes/fhandler.h |  10 +-
>  winsup/cygwin/select.cc                 |  16 +-
>  winsup/cygwin/spawn.cc                  |  44 +++---
>  5 files changed, 250 insertions(+), 60 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index ba35ca44c..b036b7ac5 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -443,6 +443,11 @@ fhandler_console::cons_master_thread (handle_set_t =
*p, tty *ttyp)
>  	  cygwait (40);
>  	  continue;
>  	}
> +      if (con.need_win32_input_mode_fix)
> +	{
> +	  cygwait (40);
> +	  continue;
> +	}

`disable_master_thread` is the pause/resume request;
`master_thread_suspended` is its acknowledgement. While
`need_win32_input_mode_fix` remains true, v14's worker sleeps without
clearing an old true acknowledgement. A non-owner Cygwin process can
launch a native child, pause the worker, then request resume during
cleanup and wait indefinitely while holding `cons_mode_mutex`. The
worker's owner is alive, so the owner-exit patch cannot help. Suppressing
input processing must not break the request/acknowledgement protocol.

> =20
>        acquire_attach_mutex (mutex_timeout);
>        GetNumberOfConsoleInputEvents (p->input_handle, &total_read);
> @@ -841,6 +846,8 @@ fhandler_console::setup ()
>        con.num_processed =3D 0;
>        con.curr_input_mode =3D tty::restore;
>        con.curr_output_mode =3D tty::restore;
> +      con.need_win32_input_mode_fix =3D false;
> +      con.is_processed_input =3D false;
>      }
>  }
> =20
> @@ -877,6 +884,39 @@ fhandler_console::rabuflen ()
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

This method also runs while `con.curr_input_mode` is native. Switching to
native mode leaves `is_processed_input` unchanged, so that cache can still
be false after the worker has been paused. If the native application
disables `ENABLE_PROCESSED_INPUT` to receive Ctrl+C as input, a Cygwin
sibling's write can enable it again simply because the worker is paused.
No Win32-input-mode request is needed. Reconciliation must respect native
settings, not treat worker suspension as permission to rewrite them.

> +
>  /* The function set_{in,out}put_mode() should be static so that they
>     can be called even after the fhandler_console instance is deleted. *=
/
>  void
> @@ -899,7 +939,10 @@ fhandler_console::set_input_mode (tty::cons_mode m,=
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
> @@ -977,16 +1020,92 @@ fhandler_console::setup_for_non_cygwin_app ()
>       console mode. */
>    if (get_ttyp ()->getpgid () =3D=3D myself->pgid)
>      {
> +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
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
> @@ -994,11 +1113,11 @@ fhandler_console::cleanup_for_non_cygwin_app (han=
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
> @@ -1055,6 +1174,10 @@ fhandler_console::setup_io_mutex (void)
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
> @@ -1182,13 +1305,13 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECOR=
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
> @@ -1196,6 +1319,7 @@ fhandler_console::bg_check (int sig, bool dontsign=
al)
>      }
>    if (sig =3D=3D SIGTTOU && con.curr_output_mode !=3D tty::cygwin)
>      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    return fhandler_termios::bg_check (sig, dontsignal);
>  }
> @@ -1314,6 +1438,8 @@ wait_retry:
> =20
>  #undef buf
> =20
> +  fix_input_mode_if_necessary (); /* for win32_input_mode */
> +

This new call in `read()` is only on its normal finishing path. For
example, consider a noncanonical 16-byte read with echo enabled,
`VMIN=3D16`, and `VTIME=3D1`. If only the eight bytes `ESC[?9001h` arrive,
echo changes `need_win32_input_mode_fix`; the read copies those bytes,
retries, then returns eight from the partial-timeout branch. Please note
that in this instance, it does *not* reach the new fix-up call. Another
console operation may subsequently mask the missing update.

Once again, please do double-check my claims. While I have a somewhat
rudimentary understanding of the architecture of the code (and now finally
even understand why that "master" thread exists, thanks to your patient
explanations), without any doubt there could be gaping holes in my
reasoning due to my lack of expertise in this area.

And before I forget, again: Thank you so much for working on this code. It
is tricky, it is finicky, and without your continued dedication there
would be no chance to ever resolve these bugs.

Ciao,
Johannes

>    buflen =3D copied_chars;
>    return;
> =20
> @@ -2011,6 +2137,7 @@ fhandler_console::open (int flags, mode_t)
>    if (in_is_console)
>      CloseHandle (h_in);
> =20
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (in_is_console && con.curr_input_mode !=3D tty::cygwin)
>      {
>        prev_input_mode_backup =3D con.prev_input_mode;
> @@ -2023,6 +2150,7 @@ fhandler_console::open (int flags, mode_t)
>        GetConsoleMode (get_output_handle (), &con.prev_output_mode);
>        set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
>      }
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
>  		get_output_handle ());
> @@ -2106,6 +2234,7 @@ fhandler_console::open_setup (int flags)
>        handle_set.output_handle =3D get_output_handle ();
>        handle_set.input_mutex =3D input_mutex;
>        handle_set.output_mutex =3D output_mutex;
> +      handle_set.cons_mode_mutex =3D cons_mode_mutex;
>        handle_set.unit =3D unit;
>      }
>    return fhandler_base::open_setup (flags);
> @@ -2115,6 +2244,7 @@ void
>  fhandler_console::post_open_setup (int fd)
>  {
>    /* Setting-up console mode for cygwin app started from non-cygwin app=
. */
> +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (fd =3D=3D 0)
>      {
>        set_disable_master_thread (false, this);
> @@ -2122,6 +2252,7 @@ fhandler_console::post_open_setup (int fd)
>      }
>    else if (fd =3D=3D 1 || fd =3D=3D 2)
>      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> +  ReleaseMutex (cons_mode_mutex);
> =20
>    fhandler_base::post_open_setup (fd);
>  }
> @@ -2131,18 +2262,20 @@ fhandler_console::close (int flag)
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
> @@ -2197,6 +2330,8 @@ fhandler_console::close (int flag)
>    input_mutex =3D NULL;
>    CloseHandle (output_mutex);
>    output_mutex =3D NULL;
> +  CloseHandle (cons_mode_mutex);
> +  cons_mode_mutex =3D NULL;
> =20
>    pcon_hand_over_proc ();
> =20
> @@ -2246,8 +2381,8 @@ fhandler_console::ioctl (unsigned int cmd, void *a=
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
> @@ -2370,10 +2505,12 @@ int
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
> @@ -3140,12 +3277,7 @@ fhandler_console::char_command (char c)
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
> @@ -3994,6 +4126,18 @@ fhandler_console::write (const void *vsrc, size_t=
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
> @@ -4327,18 +4471,13 @@ fhandler_console::write (const void *vsrc, size_=
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
> @@ -4476,10 +4615,13 @@ fhandler_console::set_console_mode_to_native ()
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
> @@ -4536,8 +4678,17 @@ ContinueDebugEvent_Hooked
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
> @@ -4818,6 +4969,9 @@ fhandler_console::get_duplicated_handle_set (handl=
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
> @@ -4834,6 +4988,8 @@ fhandler_console::close_handle_set (handle_set_t *=
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
> index b72083447..33417169b 100644
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
> @@ -1180,8 +1180,10 @@ peek_console (select_record *me, bool)
>  	  fh->release_input_mutex ();
>  	  return -1;
>  	}
> +      fh->release_input_mutex ();
> +
> +      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
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

--83233284192842031789295913524983--
