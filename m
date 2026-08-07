Return-Path: <SRS0=Gg12=GA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e05.mail.nifty.com (mta-sp-e05.mail.nifty.com [106.153.228.5])
	by sourceware.org (Postfix) with ESMTPS id 955414BA5435
	for <cygwin-patches@cygwin.com>; Fri,  7 Aug 2026 12:16:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 955414BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 955414BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.228.5
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786104975; cv=none;
	b=W45kxmJJ5lWNGeMsr1mPOmQrneyovTeK5gI01jrbdn6vZvAjZy5FQLjfDhwOdTezGBYU33EeRsO8dzuAfOHUpGVcdxYbhNfuE8VIT5/LzROMjh6E40vvnLukRCuxTNwqhWgVl+HYEVNPUs5ZGj0hMDOdJ9atQnlQZJHFKyVtogI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786104975; c=relaxed/simple;
	bh=cyEzTnzHqOJiGCdiAal1XHo1bJ3dvarrjZ4ioH5pfYs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=aFmtp1KcF3h+7bAmTuu5zS9OsLARnTRNVnCfkijlmCY2MH8AeERpp2YYzPSBlThzhiJKsU8NbU1maS9XRl7porsVBDtuRmBQGEX15zlwDFVpTo9k7AL0dJAebcbtPb7qwCuBV4+du62SZ37JgK6ZLjS6g+fRVEc9KjnK8iWw2IU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iCbF0NPR
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 955414BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=iCbF0NPR
Received: from mta-snd-e05.mail.nifty.com by mta-sp-e05.mail.nifty.com
          with ESMTP
          id <20260807121612268.HRHT.45160.mta-snd-e05.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 7 Aug 2026 21:16:12 +0900
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260807121612123.SMQZ.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 7 Aug 2026 21:16:12 +0900
Date: Fri, 7 Aug 2026 21:16:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v11] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260807211610.e5f51c8e8e22531215be555b@nifty.ne.jp>
In-Reply-To: <68ad32a2-a464-115e-fd4a-e3eda91c5403@gmx.de>
References: <20260720195832.400-1-takashi.yano@nifty.ne.jp>
	<68ad32a2-a464-115e-fd4a-e3eda91c5403@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1786104972;
 bh=jlR/B1vesvJsVLumS/L9bgxWvOjMr1LdT52lRkJtL+o=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=iCbF0NPRzZxFONrmAWOwHvpC73PBeoXqGbkFe8er/R+7H0AhiPJudPPcbUx2XllwTYeXk5Qz
 fKlQa9xW5EQ/8nMAhH3n7VSLJhjsiZ2yIbbGwdaLiirjpJkSUO2J2V/0wh0vTE88FmRbh7X97w
 +G0imP3o4BjKlQkTreWbE97k6zo36C1kkKBoD5on1PzyeotD5xs0GXRnQl96HjD+kh9dwVNjFk
 NTWX7WRTWYnmEyosSh8XskNqiHtgqE3VbQ+sayjlq8JXE7YFYCjgTh/CEe6QfqoYjIdTm5skzc
 V3T0DUgkp/Stto64s+c1ZuFoLe+nuNRnlvXKLvzom55w69yg==
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 22 Jul 2026 22:44:36 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for v11. The v4 lock-ordering deadlocks are resolved: every
> mode-changing site now takes `cons_mode_mutex` before the input/output
> mutex, and the v10 `TIOCSWINSZ` path releases `output_mutex` before
> calling `bg_check()`. Verified both.
> 
> On Tue, 21 Jul 2026, Takashi Yano wrote:
> 
> > Previously, if two non-cygwin apps are started and one of them
> > exits first, the other one loosed appropriate console mode, since
> > the first one restored it to tty::cygwin. This patch counts the
> > active console process whose pgid is pgid of the tty and if the
> > result is zero (means the last non-cygwin foreground process),
> > restore console mode. To avoid race issue between apps modifying
> > console mode simultaneously, this patch also introduce a mutex
> > named `cons_mode_mutex`.
> > 
> > Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Stop counting up/down the counter by itself.
> >     Use num_active_non_cygwin_apps() instead.
> > v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> > v4: Guard all mode changes in console by cons_mode_mutex.
> > v5: Fix the issue of mutex acquisition order.
> >     Fix the race window around the process creation.
> >     Improve latency of checking existence of non-cygwin apps.
> >     Handle errors in checking existence of non-cygwin apps.
> > v6: Match the conditions for incrementing and decrementing the counter.
> > v7: Decrement the counter only if it was incremented by myself.
> > v8: Symlify the conditions for incrementing and decrementing the counter
> >     a bit.
> > v9: Minimize the argument of set_non_cygwin_app_setup_ongoing().
> > v10: Set process_state before calling spawn_worker::setup() rather than
> >      using the counter. In addition, resume non-cygwin app before
> > 	 modifying process table. These make things much simpler.
> >      Narrowing the period of acquiring input_mutex in peek_console()
> >      in select.cc.
> > v11: Release output_mutex before calling bg_check() in ioctl().
> >      Suppress unecessary console-mode change attempts.
> > 
> >  winsup/cygwin/fhandler/console.cc       | 141 ++++++++++++++++++++++--
> >  winsup/cygwin/fhandler/termios.cc       |  29 +++--
> >  winsup/cygwin/local_includes/fhandler.h |   5 +-
> >  winsup/cygwin/select.cc                 |  14 +--
> >  winsup/cygwin/spawn.cc                  |  46 ++++----
> >  5 files changed, 184 insertions(+), 51 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index d4c87f29f..0219a37ef 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -977,16 +977,85 @@ fhandler_console::setup_for_non_cygwin_app ()
> >       console mode. */
> >    if (get_ttyp ()->getpgid () == myself->pgid)
> >      {
> > +      WaitForSingleObject (cons_mode_mutex, INFINITE);
> >        set_disable_master_thread (true, this);
> >        set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
> >        set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
> > +      ReleaseMutex (cons_mode_mutex);
> >      }
> >  }
> >  
> > +/* Return values
> > +   0: not exist
> > +   1: exist
> > +  -1: error */
> > +int
> > +fhandler_console::active_non_cygwin_apps_exist (pid_t pgid)
> > +{
> > +  tmp_pathbuf tp;
> > +  DWORD *list = (DWORD *) tp.c_get ();
> > +  const DWORD buf_size = NT_MAX_PATH / sizeof (DWORD);
> > +
> > +  DWORD buf_size1 = 1;
> > +  DWORD num;
> > +  /* The buffer of too large size does not seem to be expected by new condrv.
> > +     https://github.com/microsoft/terminal/issues/18264#issuecomment-2515448548
> > +     Use the minimum buffer size in the loop. */
> > +  while ((num = GetConsoleProcessList (list, buf_size1)) > buf_size1)
> > +    {
> > +      if (num > buf_size)
> > +	return -1;
> > +      buf_size1 = num;
> > +    }
> > +  if (num == 0)
> > +    return -1;
> > +
> > +  /* Last one is the oldest. */
> > +  /* https://github.com/microsoft/terminal/issues/95 */
> > +  /* Assuming that newer processes are more likely to be non-cygwin. */
> > +  for (DWORD i = 0; i < num; i++)
> > +    {
> > +      DWORD my_pid = myself->exec_dwProcessId ? : myself->dwProcessId;
> > +      if (list[i] == my_pid)
> > +	continue;
> > +      pid_t pid = cygwin_pid (list[i]);
> > +      if (pid == 0)
> > +	continue;
> > +      pinfo p (pid);
> > +      if (!!p && p->pgid == pgid && ISSTATE (p, PID_NOTCYGWIN))
> > +	return 1;
> > +    }
> > +  return 0;
> > +}
> > +
> >  void
> >  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
> >  {
> >    const _minor_t unit = p->unit;
> > +  pid_t pgid = shared_console_info[unit] ?
> > +    shared_console_info[unit]->tty_min_state.getpgid () : 0;
> > +
> > +  WaitForSingleObject (p->cons_mode_mutex, INFINITE);
> > +  tty::cons_mode conmode = cons_mode_on_close (p);
> > +  if (con.curr_input_mode == conmode && con.curr_output_mode == conmode
> > +      && con.disable_master_thread == (con.owner == GetCurrentProcessId ()))
> > +    {
> > +      ReleaseMutex (p->cons_mode_mutex);
> > +      return;
> > +    }
> > +  switch (active_non_cygwin_apps_exist (pgid))
> > +    {
> > +    case 1: /* Exist */
> > +      ReleaseMutex (p->cons_mode_mutex);
> > +      return;
> > +    case 0: /* Not exist */
> > +      break;
> > +    case -1: /* Error */
> > +    default:
> > +      system_printf("Checking for existence of non-cygwin app failed.");
> > +      break;
> > +    }
> 
> `active_non_cygwin_apps_exist()` returns -1 when `GetConsoleProcessList()`
> fails, including the zero-count and buffer-overflow cases the helper
> guards against (condrv buffer-size flakiness). But `case -1` prints and
> falls through to the restore below, restoring `tty::cygwin` anyway, the
> opposite of the v4 request for a distinct unavailable/error result so the
> caller could decline to restore when the count is untrustworthy.
> Concretely: two native processes share the console (same pgid, native
> mode), one exits and runs cleanup just as `GetConsoleProcessList()`
> transiently fails, and the survivor loses native mode, the exact
> regression this patch targets. If restoring on failure is deliberate
> (prioritising Cygwin apps), fine, but it contradicts the v4 request and
> should be stated, not buried in a fall-through.

It's intentional. I think cygwin is primarily intended to provide
a correct environment for cygwin-apps rather than non-cygwin app,
although msys2 might have different concept.

> The fix moves the non-Cygwin resume ahead of the process-table update, and
> for the `exec`/`_P_OVERLAY` path marks the spawning process non-Cygwin
> early (`InterlockedOr` of `PID_NOTCYGWIN | PID_NEW_PG` onto
> `myself->process_state`, guarded by `mode == _P_OVERLAY`), covering that
> path against the restore race. But for non-overlay spawns the spawned
> process's pinfo carrying `PID_NOTCYGWIN` is published only after the
> busy-wait, while native console mode was set before `CreateProcessW()`. In
> that window a concurrent `cleanup_for_non_cygwin_app()` for another
> exiting native process in the same pgid can count zero and restore Cygwin
> mode, the same window you acknowledged in v4 (`we cannot fully address
> this problem`). Either represent the pending native-mode acquisition
> across both creation and publication, or document it as a known limitation
> in the commit message.

Hmm, for now, I've added a note about that limitation in the commit message.

> Honestly, I'm not quite sure how to proceed from here. This is all super
> complicated to me.
> 
> Ciao,
> Johannes
> 
> > +
> >    termios dummy = {0, };
> >    termios *ti = shared_console_info[unit] ?
> >      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
> > @@ -994,11 +1063,11 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
> >    set_disable_master_thread (con.owner == GetCurrentProcessId ());
> >    /* conmode can be tty::restore when non-cygwin app is
> >       exec'ed from login shell. */
> > -  tty::cons_mode conmode = cons_mode_on_close (p);
> >    if (con.curr_output_mode != conmode)
> >      set_output_mode (conmode, ti, p);
> >    if (con.curr_input_mode != conmode)
> >      set_input_mode (conmode, ti, p);
> > +  ReleaseMutex (p->cons_mode_mutex);
> >  }
> >  
> >  /* Return the tty structure associated with a given tty number.  If the
> > @@ -1055,6 +1124,10 @@ fhandler_console::setup_io_mutex (void)
> >    if (res == WAIT_OBJECT_0)
> >      release_output_mutex ();
> >  
> > +  shared_name (buf, "cygcons.cons_mode.mutex", get_minor ());
> > +  if (!cons_mode_mutex)
> > +    cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
> > +
> >    extern HANDLE attach_mutex;
> >    if (!attach_mutex)
> >      attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
> > @@ -1189,6 +1262,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
> >    /* Setting-up console mode for cygwin app. This is necessary if the
> >       cygwin app and other non-cygwin apps are started simultaneously
> >       in the same process group. */
> > +  WaitForSingleObject (cons_mode_mutex, INFINITE);
> >    if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
> >      {
> >        set_disable_master_thread (false, this);
> > @@ -1196,6 +1270,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
> >      }
> >    if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
> >      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    return fhandler_termios::bg_check (sig, dontsignal);
> >  }
> > @@ -2010,6 +2085,7 @@ fhandler_console::open (int flags, mode_t)
> >    if (in_is_console)
> >      CloseHandle (h_in);
> >  
> > +  WaitForSingleObject (cons_mode_mutex, INFINITE);
> >    if (in_is_console && con.curr_input_mode != tty::cygwin)
> >      {
> >        prev_input_mode_backup = con.prev_input_mode;
> > @@ -2022,6 +2098,7 @@ fhandler_console::open (int flags, mode_t)
> >        GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> >        set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> >      }
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
> >  		get_output_handle ());
> > @@ -2105,6 +2182,7 @@ fhandler_console::open_setup (int flags)
> >        handle_set.output_handle = get_output_handle ();
> >        handle_set.input_mutex = input_mutex;
> >        handle_set.output_mutex = output_mutex;
> > +      handle_set.cons_mode_mutex = cons_mode_mutex;
> >        handle_set.unit = unit;
> >      }
> >    return fhandler_base::open_setup (flags);
> > @@ -2114,6 +2192,7 @@ void
> >  fhandler_console::post_open_setup (int fd)
> >  {
> >    /* Setting-up console mode for cygwin app started from non-cygwin app. */
> > +  WaitForSingleObject (cons_mode_mutex, INFINITE);
> >    if (fd == 0)
> >      {
> >        set_disable_master_thread (false, this);
> > @@ -2121,6 +2200,7 @@ fhandler_console::post_open_setup (int fd)
> >      }
> >    else if (fd == 1 || fd == 2)
> >      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    fhandler_base::post_open_setup (fd);
> >  }
> > @@ -2130,18 +2210,20 @@ fhandler_console::close (int flag)
> >  {
> >    debug_printf ("closing: %p, %p", get_handle (), get_output_handle ());
> >  
> > -  acquire_output_mutex (mutex_timeout);
> > -
> >    if (shared_console_info[unit] && (dev_t) myself->ctty == get_device ()
> >        && cons_mode_on_close (&handle_set) == tty::restore)
> >      {
> > +      WaitForSingleObject (cons_mode_mutex, INFINITE);
> >        set_disable_master_thread (true, this);
> >        if (con.curr_output_mode != tty::restore)
> >  	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
> >        if (con.curr_input_mode != tty::restore)
> >  	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
> > +      ReleaseMutex (cons_mode_mutex);
> >      }
> >  
> > +  acquire_output_mutex (mutex_timeout);
> > +
> >    if (shared_console_info[unit] && con.owner == GetCurrentProcessId ())
> >      {
> >        if (master_thread_started)
> > @@ -2196,6 +2278,8 @@ fhandler_console::close (int flag)
> >    input_mutex = NULL;
> >    CloseHandle (output_mutex);
> >    output_mutex = NULL;
> > +  CloseHandle (cons_mode_mutex);
> > +  cons_mode_mutex = NULL;
> >  
> >    pcon_hand_over_proc ();
> >  
> > @@ -2245,8 +2329,8 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >  	release_output_mutex ();
> >  	return 0;
> >        case TIOCSWINSZ:
> > -	bg_check (SIGTTOU);
> >  	release_output_mutex ();
> > +	bg_check (SIGTTOU);
> >  	return 0;
> >        case KDGKBMETA:
> >  	*(int *) arg = (con.metabit) ? K_METABIT : K_ESCPREFIX;
> > @@ -2369,10 +2453,12 @@ int
> >  fhandler_console::tcsetattr (int a, struct termios const *t)
> >  {
> >    get_ttyp ()->ti = *t;
> > +  WaitForSingleObject (cons_mode_mutex, INFINITE);
> >    if (con.curr_input_mode == tty::cygwin)
> >      set_input_mode (tty::cygwin, t, &handle_set);
> >    if (con.curr_output_mode == tty::cygwin)
> >      set_output_mode (tty::cygwin, t, &handle_set);
> > +  ReleaseMutex (cons_mode_mutex);
> >    return 0;
> >  }
> >  
> > @@ -3140,10 +3226,24 @@ fhandler_console::char_command (char c)
> >  		    con.cursor_key_app_mode = (c == 'h');
> >  		  if (con.args[i] == 9001) /* win32-input-mode (https://github.com/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard%20handling%20in%20Conpty.md) */
> >  		    {
> > -		      set_disable_master_thread (c == 'h', this);
> > -		      if (con.curr_input_mode == tty::cygwin)
> > -			set_input_mode (tty::cygwin,
> > -					&tc ()->ti, get_handle_set ());
> > +		      /* The correnct order of acquiring mutex should be
> > +			 cons_mode_mutex first, then output_mutex.
> > +			 However, here, output_mutex is already acquired.
> > +			 So, to avoid deadlock, if another mode change is
> > +			 on going concurrently, that one takes precedence,
> > +			 and do not change the mode here. Even if we manage
> > +			 to get the mutex acquisition order right, which
> > +			 one ends up taking precedence is still a matter
> > +			 of luck. The later one overwrites the earlier one. */
> > +		      DWORD wret = WaitForSingleObject (cons_mode_mutex, 0);
> > +		      if (wret == WAIT_OBJECT_0)
> > +			{
> > +			  set_disable_master_thread (c == 'h', this);
> > +			  if (con.curr_input_mode == tty::cygwin)
> > +			    set_input_mode (tty::cygwin,
> > +					    &tc ()->ti, get_handle_set ());
> > +			  ReleaseMutex (cons_mode_mutex);
> > +			}
> 
> This is the win32-input-mode (`?9001`) handler, reached from
> `fhandler_console::write()`, which already holds `output_mutex` before
> calling `char_command()`. Since `cons_mode_mutex` must precede
> `output_mutex`, it can only try-lock with timeout 0, and on `WAIT_TIMEOUT`
> skips both `set_disable_master_thread()` and `set_input_mode()`. The base
> applied both unconditionally, so under contention v11 drops the requested
> win32-input-mode transition: `con.disable_master_thread` and the console
> input mode are left not reflecting the request. This is the
> master-thread/input-mode area that has produced keyboard regressions
> before. The comment concedes `which one ends up taking precedence is still
> a matter of luck`, but this is not benign last-writer-wins: the update is
> lost outright, not overwritten.

After reconsideration, I’ve come to the conclusion that, in the first place,
the win32 input‑mode settings should take precedence over the normal cygwin
app settings. Because the win32 input mode is automatically re-enabled after
non-cygwin app ends. So, I've added a flag that suppresses enabling cons_
master_thread in set_disable_master_thread().

> >  		    }
> >  		}
> >  	      /* Call fix_tab_position() if screen has been alternated. */
> > @@ -4475,10 +4575,13 @@ fhandler_console::set_console_mode_to_native ()
> >  	fhandler_console *cons = (fhandler_console *) (fhandler_base *) cfd;
> >  	if (cons->get_device () == cons->tc ()->getntty ())
> >  	  {
> > +	    const fhandler_console::handle_set_t *p = cons->get_handle_set ();
> > +	    WaitForSingleObject (p->cons_mode_mutex, INFINITE);
> >  	    set_disable_master_thread (true, cons);
> >  	    termios *cons_ti = &cons->tc ()->ti;
> > -	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
> > -	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
> > +	    set_input_mode (tty::native, cons_ti, p);
> > +	    set_output_mode (tty::native, cons_ti, p);
> > +	    ReleaseMutex (p->cons_mode_mutex);
> >  	    break;
> >  	  }
> >        }
> > @@ -4535,8 +4638,17 @@ ContinueDebugEvent_Hooked
> >  static FARPROC
> >  GetProcAddress_Hooked (HMODULE h, LPCSTR n)
> >  {
> > -  if (strcmp(n, "RequestTermConnector") == 0)
> > -    fhandler_console::set_disable_master_thread (true);
> > +  if (cygheap->ctty && strcmp(n, "RequestTermConnector") == 0)
> > +    {
> > +      char buf[MAX_PATH];
> > +      const _minor_t unit = cygheap->ctty->get_minor ();
> > +      shared_name (buf, "cygcons.cons_mode.mutex", unit);
> > +      HANDLE cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
> > +      WaitForSingleObject (cons_mode_mutex, INFINITE);
> > +      fhandler_console::set_disable_master_thread (true);
> > +      ReleaseMutex (cons_mode_mutex);
> > +      CloseHandle (cons_mode_mutex);
> > +    }
> >    return GetProcAddress_Orig (h, n);
> >  }
> >  
> > @@ -4817,6 +4929,9 @@ fhandler_console::get_duplicated_handle_set (handle_set_t *p)
> >    DuplicateHandle (GetCurrentProcess (), output_mutex,
> >  		   GetCurrentProcess (), &p->output_mutex,
> >  		   0, FALSE, DUPLICATE_SAME_ACCESS);
> > +  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
> > +		   GetCurrentProcess (), &p->cons_mode_mutex,
> > +		   0, FALSE, DUPLICATE_SAME_ACCESS);
> >    p->unit = unit;
> >  }
> >  
> > @@ -4833,6 +4948,8 @@ fhandler_console::close_handle_set (handle_set_t *p)
> >    p->input_mutex = NULL;
> >    CloseHandle (p->output_mutex);
> >    p->output_mutex = NULL;
> > +  CloseHandle (p->cons_mode_mutex);
> > +  p->cons_mode_mutex = NULL;
> >  }
> >  
> >  bool
> > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> > index ee576a0a8..dcd5472cc 100644
> > --- a/winsup/cygwin/fhandler/termios.cc
> > +++ b/winsup/cygwin/fhandler/termios.cc
> > @@ -830,20 +830,24 @@ void
> >  fhandler_termios::spawn_worker::cleanup ()
> >  {
> >    if (ptys_need_cleanup)
> > -    fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> > -						    ptys_ttyp, stdin_is_ptys);
> > +    {
> > +      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
> > +						      ptys_ttyp, stdin_is_ptys);
> > +      fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> > +      ptys_need_cleanup = false;
> > +    }
> >    if (cons_need_cleanup)
> > -    fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
> > -  close_handle_set ();
> > +    {
> > +      fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
> > +      fhandler_console::close_handle_set (&cons_handle_set);
> > +      cons_need_cleanup = false;
> > +    }
> >  }
> >  
> > -void
> > -fhandler_termios::spawn_worker::close_handle_set ()
> > +bool
> > +fhandler_termios::spawn_worker::is_attaching (DWORD pid)
> >  {
> > -  if (ptys_need_cleanup)
> > -    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> > -  if (cons_need_cleanup)
> > -    fhandler_console::close_handle_set (&cons_handle_set);
> > +  return !!fhandler_termios::get_console_process_id (pid, true);
> >  }
> >  
> >  void
> > @@ -916,7 +920,10 @@ fhandler_termios::get_console_process_id (DWORD pid, bool match,
> >  	  }
> >  	else
> >  	  {
> > -	    pinfo p (cygwin_pid (list[i]));
> > +	    pid_t cygpid = cygwin_pid (list[i]);
> > +	    if (cygpid == 0)
> > +	      continue;
> > +	    pinfo p (cygpid);
> >  	    if (nat && !!p && !ISSTATE(p, PID_NOTCYGWIN))
> >  	      continue;
> >  	    if (!!p && p->exec_dwProcessId)
> > diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> > index d11b3ec4f..eb96435bd 100644
> > --- a/winsup/cygwin/local_includes/fhandler.h
> > +++ b/winsup/cygwin/local_includes/fhandler.h
> > @@ -2023,6 +2023,7 @@ class fhandler_termios: public fhandler_base
> >      HANDLE output_handle;
> >      HANDLE input_mutex;
> >      HANDLE output_mutex;
> > +    HANDLE cons_mode_mutex;
> >      _minor_t unit;
> >    };
> >    class spawn_worker
> > @@ -2042,7 +2043,7 @@ class fhandler_termios: public fhandler_base
> >  		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
> >      bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
> >      void cleanup ();
> > -    void close_handle_set ();
> > +    bool is_attaching (DWORD pid);
> >    };
> >  };
> >  
> > @@ -2199,6 +2200,7 @@ private:
> >    static console_state *shared_console_info[MAX_CONS_DEV + 1];
> >    static bool invisible_console;
> >    HANDLE input_mutex, output_mutex;
> > +  HANDLE cons_mode_mutex;
> >    handle_set_t handle_set;
> >    _minor_t unit;
> >    size_t num_input_events_processed;
> > @@ -2379,6 +2381,7 @@ private:
> >    void setup_pcon_hand_over ();
> >    static void pcon_hand_over_proc ();
> >    static tty::cons_mode cons_mode_on_close (handle_set_t *);
> > +  static int active_non_cygwin_apps_exist (pid_t pgid);
> >  
> >    friend tty_min * tty_list::get_cttyp ();
> >  };
> > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > index b72083447..592f6d14d 100644
> > --- a/winsup/cygwin/select.cc
> > +++ b/winsup/cygwin/select.cc
> > @@ -1154,23 +1154,23 @@ peek_console (select_record *me, bool)
> >    HANDLE h;
> >    set_handle_or_return_if_not_open (h, me);
> >  
> > -  fh->acquire_input_mutex (mutex_timeout);
> >    while (!fh->input_ready && !fh->get_cons_readahead_valid ())
> >      {
> >        if (fh->bg_check (SIGTTIN, true) <= bg_eof)
> > -	{
> > -	  fh->release_input_mutex ();
> > -	  return me->read_ready = true;
> > -	}
> > +	return me->read_ready = true;
> >        else
> >  	{
> > +	  fh->acquire_input_mutex (mutex_timeout);
> >  	  acquire_attach_mutex (mutex_timeout);
> >  	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
> >  	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
> >  	  fh->detach_console (resume_pid, fh->get_owner ());
> >  	  release_attach_mutex ();
> >  	  if (!r || !events_read)
> > -	    break;
> > +	    {
> > +	      fh->release_input_mutex ();
> > +	      break;
> > +	    }
> >  	}
> >        if (fhandler_console::input_winch == fh->process_input_message (0)
> >  	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > @@ -1180,8 +1180,8 @@ peek_console (select_record *me, bool)
> >  	  fh->release_input_mutex ();
> >  	  return -1;
> >  	}
> > +      fh->release_input_mutex ();
> >      }
> > -  fh->release_input_mutex ();
> >    if (fh->input_ready || fh->get_cons_readahead_valid ())
> >      return me->read_ready = true;
> >  
> > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > index 8f976b9a0..8fcd89735 100644
> > --- a/winsup/cygwin/spawn.cc
> > +++ b/winsup/cygwin/spawn.cc
> > @@ -559,6 +559,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  			 PROCESS_QUERY_LIMITED_INFORMATION))
> >  	sa = &sec_none_nih;
> >  
> > +      if (!real_path.iscygexec () && mode == _P_OVERLAY)
> > +	{
> > +	  LONG pidflags = PID_NOTCYGWIN;
> > +	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
> > +	    pidflags |= PID_NEW_PG;
> > +	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
> > +	}
> > +
> >        int fileno_stdin = in__stdin < 0 ? 0 : in__stdin;
> >        int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
> >        int fileno_stderr = 2;
> > @@ -586,14 +594,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  	 up on ruid. The new process will have ruid == euid. */
> >        ::cygheap->user.deimpersonate ();
> >  
> > -      if (!real_path.iscygexec () && mode == _P_OVERLAY)
> > -	{
> > -	  LONG pidflags = PID_NOTCYGWIN;
> > -	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
> > -	    pidflags |= PID_NEW_PG;
> > -	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
> > -	}
> > -
> >        cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
> >  
> >        cygheap->lock ();
> > @@ -737,6 +737,20 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >        /* Name the handle similarly to proc_subproc. */
> >        ProtectHandle1 (pi.hProcess, childhProc);
> >  
> > +      /* Start the child running for non-cygwin process*/
> > +      if (!iscygwin () && (c_flags & CREATE_SUSPENDED))
> > +	{
> > +	  /* Inject a non-inheritable wr_proc_pipe handle into child so that we
> > +	     can accurately track when the child exits without keeping this
> > +	     process waiting around for it to exit.  */
> > +	  DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess,
> > +			   NULL, 0, false, DUPLICATE_SAME_ACCESS);
> > +	  ResumeThread (pi.hThread);
> > +	  if (term_spawn_worker.is_attaching (myself->dwProcessId))
> > +	    while (!term_spawn_worker.is_attaching (pi.dwProcessId)
> > +		   && WaitForSingleObject (pi.hProcess, 0) == WAIT_TIMEOUT);
> > +	}
> 
> This is an unbounded busy-wait, empty body, no yield. `is_attaching(pid)`
> holds exactly while `pid` is in `GetConsoleProcessList()` and alive, so
> the loop exits only when the child attaches or dies. A native process that
> never attaches (GUI-subsystem, `FreeConsole()` at start-up, or started
> `DETACHED`) spins for its entire lifetime, and the loop runs on every
> non-Cygwin spawn from a console where the spawner is itself attached, so
> launching a GUI program from a console shell hits it for that program's
> whole run.
> 
> Reproducer (`spin.c`):
> 
> #include <windows.h>
> #include <stdio.h>
> 
> static int attaching (DWORD p) {
>   DWORD l[4096], n = GetConsoleProcessList (l, 4096);
>   for (DWORD i = 0; i < n; i++) if (l[i] == p) return 1;
>   return 0;
> }
> 
> int main (int argc, char **argv) {
>   STARTUPINFOA si = { sizeof si };
>   PROCESS_INFORMATION pi;
>   CreateProcessA (argv[1], 0, 0, 0, TRUE, CREATE_SUSPENDED, 0, 0, &si, &pi);
>   ResumeThread (pi.hThread);
>   unsigned long long it = 0; DWORD t = GetTickCount ();
>   if (attaching (GetCurrentProcessId ()))
>     while (!attaching (pi.dwProcessId)
>            && WaitForSingleObject (pi.hProcess, 0) == WAIT_TIMEOUT) it++;
>   printf ("spun %llu times in %lu ms\n", it, GetTickCount () - t);
>   return 0;
> }
> 
> Point it at any GUI program (`notepad.exe` spins until you close it); a
> console child returns at once. A console `Sleep(3000)` child prints `spun
> 109 times in 16 ms` (it attaches immediately); a GUI child prints `spun
> 86543 times in 3000 ms`, spinning for the child's full lifetime.
> Instrumented, the no-yield loop burns roughly a third of a CPU core (about
> 1.1 s of CPU time for a 3 s child) and issues tens of thousands of
> `GetConsoleProcessList()`/`OpenProcess()` calls, achieving nothing since
> the child never attaches; corroborate the CPU figure with
> `GetProcessTimes()` or Task Manager.
> 
> Second cost, same hunk: the loop sits inside the cygheap allocator lock.
> `cygheap->lock()`/`unlock()` is a single critical section spanning most of
> `child_info_spawn::worker()` (the process-local `cygheap_protect` SRWLOCK
> guarding `_cmalloc`/`_cfree`/`_crealloc`), and the busy-wait runs within
> it, stalling unrelated cygheap allocations on other threads for the
> child's whole lifetime on top of the core burn. Directions: yield in the
> loop (`cygwait()`/`Sleep()`), or wait on an event with a bounded timeout
> instead of polling, and reconsider whether the wait needs
> `cygheap->lock()` at all.

I had forgotten about GUI apps. v12 patch waits for attaching to the console
only when the app is a console app. Also, introduced timeout.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
