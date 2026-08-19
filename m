Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id 38D2C4BA23F9
	for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 04:43:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 38D2C4BA23F9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 38D2C4BA23F9
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787114604; cv=none;
	b=ajnKVKpHMpPNJM5SBTha+jgUuRQ2OhX2z/2yfdUia8mSHaMTToQyBUign2dPqdYXlzKOYkCA47e0cdWIOl8MbW/JEvYOQ4HM+7MYagHW9hOVKhu/0dFtgMTtzUMOU4jW9i5vPAr3j6OXKYsDzpZqAzqBFIj6Jhc4JJ0HagI1giE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787114604; c=relaxed/simple;
	bh=n2q7FEnrGCC5F+FMYHcE8U25TalRxEcLywYOd0Wq6QE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=IllReGoPvvclTbnypMGH6c1+8PRc2WpyXrC7rVnKLCenCgas5CD8NPK7RNy2/P1l8xKZg7u/7wz2i4wWu+b+wUFnfHbdJBB+uT27yxn5nDDu7he9LTiEKnQSkTY3ZwJVIBPDdwbbLkDx9GgrUcXJf4b3QjSGxLPyAX2ghCgG4B8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GW4kokiM
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 38D2C4BA23F9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GW4kokiM
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260819044320381.LXCD.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 13:43:20 +0900
Date: Wed, 19 Aug 2026 13:43:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v12] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260819134318.33ed499c4c1008c39120b5b6@nifty.ne.jp>
In-Reply-To: <6232ca34-e83a-621e-cc14-738a423cbc6c@gmx.de>
References: <20260807121459.3116-1-takashi.yano@nifty.ne.jp>
	<6232ca34-e83a-621e-cc14-738a423cbc6c@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1787114600;
 bh=Lg0z45x8CbNp+MOCbT9ZvdUoqYFEA4D3St/PcuTHwAc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=GW4kokiM9lyGAEgKHy5P44hha8Fh/zcIbwcnNjBLpZSnI6+CE6UsYSSOSSY4PfmeFfD8/AN5
 iyefMO2+fRVjrC0MA/5iSW/VxJcG492MW+IlVFHilLQJm2o9j1hJhzM6r2czDAWNqY7UVnbtg5
 BnsO79Gyg8GrunUZxs2ARr0CTWHdk/vxPxtINct3h0Yh4ihi/tM1m9fp6acK9hrYtZdeaHSmpY
 0VFbJEgd0q2nsdFwFrVs2Q0pNvXJIIx09esjEflThwBLI+vZjNvF7JJiBqf6H7LtIbgD15NM08
 RF1xLYwr63An1rC3Qu5lREbDiji6vAxvT1ve6vnfKkd0tF5Q==
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

I'm very sorry for responding so late.

On Tue, 11 Aug 2026 11:37:49 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> I missed something critical in my review of v11, and that's on me. I
> checked the direct callers that take `cons_mode_mutex` and confirmed they
> respect the ordering, but I did not trace an indirect path through the
> echo code that inverts it and deadlocks. Two blockers, one requested
> change, and a few nits below.
> 
> On Fri, 7 Aug 2026, Takashi Yano wrote:
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
> > Known limitation:
> > In the case of non-overlayed spawn, there still exists a small
> > window in which another non-cygwin process may restore tty::cygwin
> > mode even though new non-cygwin app is about to start.
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
> > v12: Change handling of disabling master thread in the case of win32
> >      input mode.
> >      Wait for console attaching only when the spawned app is a console
> >      app. In addition, a timeout is introduced to this wait loop for
> >      safety.
> > 
> >  winsup/cygwin/fhandler/console.cc       | 153 ++++++++++++++++++++++--
> >  winsup/cygwin/fhandler/termios.cc       |  40 +++++--
> >  winsup/cygwin/local_includes/fhandler.h |   7 +-
> >  winsup/cygwin/select.cc                 |  14 +--
> >  winsup/cygwin/spawn.cc                  |  44 +++----
> >  5 files changed, 208 insertions(+), 50 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index d4c87f29f..cfef59c90 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -841,6 +841,7 @@ fhandler_console::setup ()
> >        con.num_processed = 0;
> >        con.curr_input_mode = tty::restore;
> >        con.curr_output_mode = tty::restore;
> > +      con.need_win32_input_mode_fix = false;
> >      }
> >  }
> >  
> > @@ -977,16 +978,89 @@ fhandler_console::setup_for_non_cygwin_app ()
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
> > +      /* In case of an error, perform the cleanup, since cygwin is
> > +	 primarily intended to provide a correct enviroment for cygwin
> > +	 apps rather than non-cygwin ones. */
> > +      fallthrough;
> 
> You anticipated this on v11 when you noted that "msys2 might have
> different concept", and this is the spot. The comment's reasoning holds
> for a stock Cygwin install, but the scenario here is two native apps
> sharing a pgid with one exiting, and for MSYS2 and Git for Windows native
> Windows programs are the primary workload. Restoring cygwin mode precisely
> when the process count is untrustworthy inverts the desired behavior for
> the users most likely to reach this code.
> 
> Declining to restore on `-1` also fails safe, independent of MSYS2. The
> Cygwin-app case self-heals: the next console `read()` or `write()` runs
> `bg_check`, which re-asserts cygwin mode. A surviving native app does not
> self-heal, because it sets its console mode once, at spawn. So keeping the
> native mode when the count is uncertain is the safer default upstream too,
> not only for us.

Indeed. I'm convinced.

> Could you make `case -1` release `cons_mode_mutex` and return, leaving the
> native mode in place, while still logging the error via `system_printf`?
> 
> On the positive side, `wait_for_resume_if_necessary()` resolves v11's
> unbounded busy-wait: it is bounded to 40 ms, it sleeps rather than spins,
> and it is gated by `is_attaching()` and `is_console_app()`, whose
> PE-subsystem check correctly excludes GUI applications. Documenting the
> remaining non-overlay window as a known limitation is fine by me.
> 
> One note, though: that 40 ms wait runs inside `cygheap->lock()`, so a slow
> console attach can stall other cygheap users for up to 40 ms. Worth
> considering whether the wait needs to hold that lock.

The wait loop does not need to run inside the cygheap lock. However,
the code between 
  term_spawn_worker.wait_for_resume_if_necessary (real_path, pi);
and
  cygheap->unlock ();
needs cygheap lock I guess. So we cannot release the lock before the
wait loop. If you have another perspective, please let me know. 

> That leaves a few smaller things. The `?9001` try-lock treats only
> `WAIT_OBJECT_0` as success. `WAIT_ABANDONED` also grants ownership (a
> previous owner died while holding the mutex), but the handler then skips
> the body and never releases, leaking `cons_mode_mutex`. Please handle
> `WAIT_ABANDONED` as well.

Thanks. Done.

> And a handful of typos:
> 
> 	s/correnct/correct/
> 
> 	s/requesting fo fixup/requesting a fixup/
> 
> 	s/enviroment/environment/
> 
> 	s/on going/ongoing/
> 
> The commit message word "loosed" also reads like a typo, though I am
> not sure what it should be; can you clarify what you meant?

Fixed.

> > +    default:
> > +      system_printf("Checking for existence of non-cygwin app failed.");
> > +      break;
> > +    }
> > +
> >    termios dummy = {0, };
> >    termios *ti = shared_console_info[unit] ?
> >      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
> > @@ -994,11 +1068,11 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
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
> > @@ -1055,6 +1129,10 @@ fhandler_console::setup_io_mutex (void)
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
> > @@ -1189,6 +1267,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
> >    /* Setting-up console mode for cygwin app. This is necessary if the
> >       cygwin app and other non-cygwin apps are started simultaneously
> >       in the same process group. */
> > +  WaitForSingleObject (cons_mode_mutex, INFINITE);
> 
> This introduces an ABBA deadlock (for interested readers:
> https://www.oreilly.com/library/view/hands-on-system-programming/9781788998475/edf57b67-a572-4202-8e56-18c85c2141e4.xhtml).
> With this line, `bg_check()` acquires `cons_mode_mutex` unconditionally as
> its first action, before the foreground short-circuit, which lives later
> in `fhandler_termios::bg_check`, after the release. Every echoed byte now
> takes `cons_mode_mutex`.
> 
> But the echo path reaches `bg_check` with `input_mutex` already held:
> `read()` holds `input_mutex` directly across `process_input_message()`,
> and `select()` does the same via `peek_console()` -> `line_edit()` ->
> `doecho()` -> `fhandler_console::write()`, whose first statement is
> `bg_check` for `SIGTTOU`. So on this path the order is `input_mutex`, then
> `cons_mode_mutex`.
> 
> Any concurrent mode change takes the reverse order: `open`, `tcsetattr`,
> `setup_for_non_cygwin_app`/`cleanup_for_non_cygwin_app`, `close`, and a
> background reader's `bg_check` for `SIGTTIN` all hold `cons_mode_mutex`
> first and then block on `input_mutex` inside
> `set_input_mode()`/`set_disable_master_thread()`.
> 
> Both are cross-process named mutexes, and `mutex_timeout` is `INFINITE`
> outside GDB, so the moment an echo overlaps a mode change the two sides
> wait on each other forever, whether across threads or across processes.
> This is not pathological input; it fires on ordinary keystroke echo.
> 
> It also breaks the patch's own invariant that `cons_mode_mutex` is taken
> before the input and output mutexes everywhere: the direct sites honor it,
> but `bg_check` on the echo path inverts it. That indirect path is the one
> I failed to trace for v11; the deadlock was already present there. The fix
> has to keep `bg_check` from acquiring `cons_mode_mutex` while
> `input_mutex` may be held: skip or telescope the `bg_check` on the echo
> path, or take `cons_mode_mutex` outside the `input_mutex` region.

I revised the code as follows.

If ECHO flag is set, doecho() will be called in line_edit(). So,
the output mode is set when bg_check() is called from read() in
that case. And then, setting output mode in the bg_check() called
from write() is omited.

> >    if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
> >      {
> >        set_disable_master_thread (false, this);
> > @@ -1196,6 +1275,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
> >      }
> >    if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
> >      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    return fhandler_termios::bg_check (sig, dontsignal);
> >  }
> > @@ -2010,6 +2090,7 @@ fhandler_console::open (int flags, mode_t)
> >    if (in_is_console)
> >      CloseHandle (h_in);
> >  
> > +  WaitForSingleObject (cons_mode_mutex, INFINITE);
> >    if (in_is_console && con.curr_input_mode != tty::cygwin)
> >      {
> >        prev_input_mode_backup = con.prev_input_mode;
> > @@ -2022,6 +2103,7 @@ fhandler_console::open (int flags, mode_t)
> >        GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> >        set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> >      }
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
> >  		get_output_handle ());
> > @@ -2105,6 +2187,7 @@ fhandler_console::open_setup (int flags)
> >        handle_set.output_handle = get_output_handle ();
> >        handle_set.input_mutex = input_mutex;
> >        handle_set.output_mutex = output_mutex;
> > +      handle_set.cons_mode_mutex = cons_mode_mutex;
> >        handle_set.unit = unit;
> >      }
> >    return fhandler_base::open_setup (flags);
> > @@ -2114,6 +2197,7 @@ void
> >  fhandler_console::post_open_setup (int fd)
> >  {
> >    /* Setting-up console mode for cygwin app started from non-cygwin app. */
> > +  WaitForSingleObject (cons_mode_mutex, INFINITE);
> >    if (fd == 0)
> >      {
> >        set_disable_master_thread (false, this);
> > @@ -2121,6 +2205,7 @@ fhandler_console::post_open_setup (int fd)
> >      }
> >    else if (fd == 1 || fd == 2)
> >      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    fhandler_base::post_open_setup (fd);
> >  }
> > @@ -2130,18 +2215,20 @@ fhandler_console::close (int flag)
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
> > @@ -2196,6 +2283,8 @@ fhandler_console::close (int flag)
> >    input_mutex = NULL;
> >    CloseHandle (output_mutex);
> >    output_mutex = NULL;
> > +  CloseHandle (cons_mode_mutex);
> > +  cons_mode_mutex = NULL;
> >  
> >    pcon_hand_over_proc ();
> >  
> > @@ -2245,8 +2334,8 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >  	release_output_mutex ();
> >  	return 0;
> >        case TIOCSWINSZ:
> > -	bg_check (SIGTTOU);
> >  	release_output_mutex ();
> > +	bg_check (SIGTTOU);
> >  	return 0;
> >        case KDGKBMETA:
> >  	*(int *) arg = (con.metabit) ? K_METABIT : K_ESCPREFIX;
> > @@ -2369,10 +2458,12 @@ int
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
> > @@ -3140,10 +3231,22 @@ fhandler_console::char_command (char c)
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
> > +			 on going concurrently, set the flag requesting
> > +			 fo fixup for win32-input-mode. */
> > +		      DWORD wret = WaitForSingleObject (cons_mode_mutex, 0);
> > +		      if (wret == WAIT_OBJECT_0)
> > +			{
> > +			  set_disable_master_thread (c == 'h', this);
> > +			  if (con.curr_input_mode == tty::cygwin)
> > +			    set_input_mode (tty::cygwin,
> > +					    &tc ()->ti, get_handle_set ());
> > +			  ReleaseMutex (cons_mode_mutex);
> > +			}
> > +		      con.need_win32_input_mode_fix = (c == 'h');
> >  		    }
> >  		}
> >  	      /* Call fix_tab_position() if screen has been alternated. */
> > @@ -4475,10 +4578,13 @@ fhandler_console::set_console_mode_to_native ()
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
> > @@ -4535,8 +4641,17 @@ ContinueDebugEvent_Hooked
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
> > @@ -4817,6 +4932,9 @@ fhandler_console::get_duplicated_handle_set (handle_set_t *p)
> >    DuplicateHandle (GetCurrentProcess (), output_mutex,
> >  		   GetCurrentProcess (), &p->output_mutex,
> >  		   0, FALSE, DUPLICATE_SAME_ACCESS);
> > +  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
> > +		   GetCurrentProcess (), &p->cons_mode_mutex,
> > +		   0, FALSE, DUPLICATE_SAME_ACCESS);
> >    p->unit = unit;
> >  }
> >  
> > @@ -4833,6 +4951,8 @@ fhandler_console::close_handle_set (handle_set_t *p)
> >    p->input_mutex = NULL;
> >    CloseHandle (p->output_mutex);
> >    p->output_mutex = NULL;
> > +  CloseHandle (p->cons_mode_mutex);
> > +  p->cons_mode_mutex = NULL;
> >  }
> >  
> >  bool
> > @@ -4852,6 +4972,15 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
> >  	return;
> >      }
> >    const _minor_t unit = cons->get_minor ();
> > +  if (con.need_win32_input_mode_fix)
> > +    /* Even when enabling cons_master_thread is requested, the master
> > +       thread should not be enabled if win32_input_mode is set. */
> > +    {
> > +      if (con.disable_master_thread)
> > +	return;
> > +      else
> > +	x = true;
> > +    }
> 
> The second blocker: this guard is evaluated one assignment too early. In
> `char_command()`, the `?9001` handler sets `need_win32_input_mode_fix` --
> true for `?9001h`, false for `?9001l` -- only after it has already called
> `set_disable_master_thread` with that same value.
> 
> So take `?9001l` arriving while a `?9001h` session is active, that is, the
> flag is still true and `disable_master_thread` is true.
> `set_disable_master_thread` is called with `false`, but because the flag
> is still set it enters this new branch, sees `disable_master_thread`
> already true, and returns early without clearing it. The flag is cleared
> only afterward, so the master thread is left disabled for good.
> 
> That is a keyboard and signal regression: after any win32-input-mode
> session, a busy foreground Cygwin process no longer gets Ctrl-C or Ctrl-S
> handled by the master thread until its next `read()`, and `bg_check` for
> `SIGTTIN` cannot rescue it, since the mode is already `tty::cygwin`. The
> pre-patch code always re-enabled the master thread on `?9001l`.
> 
> The one-line fix is to move the assignment to `need_win32_input_mode_fix`
> ahead of the try-lock and `set_disable_master_thread` block, so the guard
> reads the new value.

Thanks! Done.

> Two smaller points in the same area, less important than that fix: the
> flag is written in `char_command` (on the try-lock-timeout path, without
> `cons_mode_mutex` held) and read in `set_disable_master_thread` with no
> lock in common, on a cross-process `dev_console` field, so it is a data
> race. And on `WAIT_TIMEOUT` the code still skips the immediate switch to
> `tty::cygwin` mode; the flag gates only the master thread, not the input
> mode.

input_mutex guard is enabled for checking the flag need_win32_input_mode_fix
in set_disable_master_thread().

> Given the two blockers, this needs another round, I think. I am happy to
> work through the `bg_check`/`cons_mode_mutex` ordering with you if that
> helps; it is genuinely hard to get right, and I share the responsibility
> for missing it the first time.

Thanks again. I think I’ve addressed all of the points you raised.
Could you please kindly review v13 patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
