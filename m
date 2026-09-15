Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w05.mail.nifty.com (mta-sp-w05.mail.nifty.com [IPv6:2001:268:fa30:84a:6a:99:e4:25])
	by sourceware.org (Postfix) with ESMTPS id 5C7D24BAE7E6
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 07:49:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5C7D24BAE7E6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5C7D24BAE7E6
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:84a:6a:99:e4:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789458568; cv=none;
	b=bGLh+LR6vrXUTiPxu/FbvbrtXM1zmNJPoNA8hGUooGhQV5b9nf4mQUtLPNknw/EOFW6Fn8SNUJT5DDfm+z12A23eRSHGMrLLgonjxDsQWr4h7+5VDWKjUIJ6rSo0A5CoKSCC4Eh6jxclImMhLwBtfHGbtqw5GnfdTV+h0v2Hbvo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789458568; c=relaxed/simple;
	bh=vc76Bkeomgi0uTg8nhxwj3hrSLW20KbAiA7RBAnXeyY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=CoczvTEFjSnWlkDnIeqVDbekZN/NJk9PTM1KQQlzow4UHT2l7XPF27/b8AGD8xZJJuCD6KQZTISXHGE+4iBrmdVxlILsrjjdyuuTyEBAr7gyC6JZpDx+FNMA+/dJzfmZ1i0z4F0rCvx6pgFeT6LDgplt4HXHZc8uBBja4Wy9yFI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GGl1O87j
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5C7D24BAE7E6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GGl1O87j
Received: from mta-snd-w05.mail.nifty.com by mta-sp-w05.mail.nifty.com
          with ESMTP
          id <20260915074916266.ZOVS.3803.mta-snd-w05.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 16:49:16 +0900
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260915074916091.SMCL.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 16:49:16 +0900
Date: Tue, 15 Sep 2026 16:49:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v15] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260915164916.f9f24e6926281e0ab3f1d737@nifty.ne.jp>
In-Reply-To: <115b3c1b-d5df-7274-ffea-3a12ac13a5ac@gmx.de>
References: <20260913060128.1453-1-takashi.yano@nifty.ne.jp>
	<115b3c1b-d5df-7274-ffea-3a12ac13a5ac@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789458556;
 bh=3v7oqlehz3ExFp3huhQ3apuU2ILxx8U9oTZ2Uth3TyY=;
 h=Date:From:To:Subject:In-Reply-To;
 b=GGl1O87j7bgUaESWqpU9N/K10b2XBwqSf+vVUbmrCmULn+YnQdb3s3mc2DgJ3L0Ewqc4yeDU
 Rzpk/htZfDFCK4wRce0s/P2ou4C/OBGz+yYU60n0yUYL15RzxgyryHdOHbuWV1bW57xM/U9rWM
 /lQCzuO3gIMOjuWjU1sOhO9Q4oKPxUoIHfzNtpovDTICN5zaD8zcOdiwfK8U/bM0UlwJvSE4OY
 7hF+KhYqarCcC1PUlUVOuGSSkw4ZEu2ib7NFXMep20kx9wJTgpYkMiQSACRj5fCXFBW32tgaTd
 pqzsfAPoodL4jqzQXpQmRFDlDJesbeg0kPpobzBLnJvFHiGQ==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

I think I've fixed the all points you mentioned.
Could you please check v16?

On Sun, 13 Sep 2026 12:38:32 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> thank you for your tenacity! You are going well above and beyond what any
> open source maintainer could expect of any contributor, going to 15
> iterations of a patch.
> 
> So I feel quite embarrassed to point out a couple more things I would like
> to see changed... 😊 I hope you forgive me!
> 
> Also please note that I am still trying my best to understand the
> console/pty code with its implied contracts, and I feel comfortable in
> saying that I am still too uncomfortable to claim that I really understand
> it. _You_ are clearly the domain expert here, and I have to rely heavily
> on AI when performing these reviews, which means that I can easily miss
> crucial design decisions.
> 
> On Sun, 13 Sep 2026, Takashi Yano wrote:
> 
> > Previously, if two non-cygwin apps are started and one of them
> > exits first, the other one loosed appropriate console mode, since
> 
> Did you mean "the other application lost the console mode it needed" here?
> ("loosed" could be either "loosened", i.e. the opposite of tightened, or
> "lost", which I think you meant in this instance).
> 
> > the first one restored it to tty::cygwin. This patch counts the
> > active console process whose pgid is pgid of the tty and if the
> > result is zero (means the last non-cygwin foreground process),
> > restore console mode. To avoid race issue between apps modifying
> > console mode simultaneously, this patch also introduce a mutex
> > named `cons_mode_mutex`.
> 
> Well explained, thanks!
> 
> > 
> > Known limitation:
> > In the case of non-overlayed spawn, there still exists a small
> > window in which another non-cygwin process may restore tty::cygwin
> > mode even though new non-cygwin app is about to start.
> 
> Thank you for calling this out, and I also don't see any elegant way
> around this limitation. It *could* be done via some sort of "pending"
> state, but the difficult part is lifetime management: failed launches,
> cancellation, early child exit, parent death, and simultaneous starts must
> not leave stale pending state that would suppress cleanup forever.
> 
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
> > v13: Do not perform cleanup for non-cygwin apps on the error in
> >      active_non_cygwin_apps_exist().
> >      Handle WAIT_ABANDONED in CSI?9001h/l handling.
> >      Fix ABBA deadlock about echo code path.
> >      Set need_win32_input_mode_fix before set_disable_master_thread()
> >      in CSI?9001h/l handling.
> >      Setting and checking for need_win32_input_mode_fix inside the
> >      input_mutex.
> >      Fix the problem that the flag need_win32_input_mode_fix is set,
> >      but disable_master_thread does not set if another thread holds
> >      cons_mode_mutex.
> > v14: Re-design echo code path. (Introduce raw_write() for doecho())
> >      Re-design the handling of need_win32_input_mode_fix from scratch.
> > v15: Fix possible deadlock with input_mutex regarding doecho()
> > 
> >  winsup/cygwin/fhandler/console.cc       | 200 +++++++++++++++++++++---
> >  winsup/cygwin/fhandler/termios.cc       |  40 +++--
> >  winsup/cygwin/local_includes/fhandler.h |  10 +-
> >  winsup/cygwin/select.cc                 |  16 +-
> >  winsup/cygwin/spawn.cc                  |  44 +++---
> >  5 files changed, 250 insertions(+), 60 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index ba35ca44c..b036b7ac5 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -443,6 +443,11 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
> >  	  cygwait (40);
> >  	  continue;
> >  	}
> > +      if (con.need_win32_input_mode_fix)
> > +	{
> > +	  cygwait (40);
> > +	  continue;
> > +	}
> 
> `disable_master_thread` is the pause/resume request;
> `master_thread_suspended` is its acknowledgement. While
> `need_win32_input_mode_fix` remains true, v14's worker sleeps without
> clearing an old true acknowledgement. A non-owner Cygwin process can
> launch a native child, pause the worker, then request resume during
> cleanup and wait indefinitely while holding `cons_mode_mutex`. The
> worker's owner is alive, so the owner-exit patch cannot help. Suppressing
> input processing must not break the request/acknowledgement protocol.

The code here with the patch is:
  while (con.owner == GetCurrentProcessId ())
    {
      DWORD total_read, n, i;
      DWORD mode;
      bool need_strip = false;

      if (con.disable_master_thread)
        {
          con.master_thread_suspended = true;
          cygwait (40);
          continue;
        }
      if (con.need_win32_input_mode_fix)
        {
          cygwait (40);
          continue;
        }

Even if need_win32_input_mode_fix is true, disable_master_thread
-> master_thread_suspended works within 40msec.

> >  
> >        acquire_attach_mutex (mutex_timeout);
> >        GetNumberOfConsoleInputEvents (p->input_handle, &total_read);
> > @@ -841,6 +846,8 @@ fhandler_console::setup ()
> >        con.num_processed = 0;
> >        con.curr_input_mode = tty::restore;
> >        con.curr_output_mode = tty::restore;
> > +      con.need_win32_input_mode_fix = false;
> > +      con.is_processed_input = false;
> >      }
> >  }
> >  
> > @@ -877,6 +884,39 @@ fhandler_console::rabuflen ()
> >  static DWORD prev_input_mode_backup;
> >  static DWORD prev_output_mode_backup;
> >  
> > +/* Even under cons_mode_mutex, only need_win32_input_mode_fix can be
> > +   modified by another thread. This function sets or clears the
> > +   ENABLE_PROCESSED_INPUT flag to reflect the current value of
> > +   need_win32_input_mode_fix. */
> > +void
> > +fhandler_console::fix_input_mode_if_necessary ()
> > +{
> > +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> > +  bool need_processed_input =
> > +    con.master_thread_suspended || con.disable_master_thread
> > +    || con.need_win32_input_mode_fix;
> > +  if (need_processed_input == con.is_processed_input)
> > +    {
> > +      ReleaseMutex (cons_mode_mutex);
> > +      return;
> > +    }
> > +  WaitForSingleObject (input_mutex, mutex_timeout);
> > +  acquire_attach_mutex (mutex_timeout);
> > +  DWORD resume_pid = attach_console (con.owner);
> > +  DWORD flags;
> > +  GetConsoleMode (get_handle (), &flags);
> > +  if (need_processed_input)
> > +    flags |= ENABLE_PROCESSED_INPUT;
> > +  else
> > +    flags &= ~ENABLE_PROCESSED_INPUT;
> > +  con.is_processed_input = need_processed_input;
> > +  SetConsoleMode (get_handle (), flags);
> > +  detach_console (resume_pid, con.owner);
> > +  release_attach_mutex ();
> > +  ReleaseMutex (input_mutex);
> > +  ReleaseMutex (cons_mode_mutex);
> > +}
> 
> This method also runs while `con.curr_input_mode` is native. Switching to
> native mode leaves `is_processed_input` unchanged, so that cache can still
> be false after the worker has been paused. If the native application
> disables `ENABLE_PROCESSED_INPUT` to receive Ctrl+C as input, a Cygwin
> sibling's write can enable it again simply because the worker is paused.
> No Win32-input-mode request is needed. Reconciliation must respect native
> settings, not treat worker suspension as permission to rewrite them.

Fixed. Thanks!

> 
> > +
> >  /* The function set_{in,out}put_mode() should be static so that they
> >     can be called even after the fhandler_console instance is deleted. */
> >  void
> > @@ -899,7 +939,10 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
> >        break;
> >      case tty::cygwin:
> >        flags |= ENABLE_WINDOW_INPUT;
> > -      if (con.master_thread_suspended || con.disable_master_thread)
> > +      con.is_processed_input =
> > +	con.master_thread_suspended || con.disable_master_thread
> > +	|| con.need_win32_input_mode_fix;
> > +      if (con.is_processed_input)
> >  	flags |= ENABLE_PROCESSED_INPUT;
> >        if (wincap.has_con_24bit_colors () && !con_is_legacy)
> >  	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
> > @@ -977,16 +1020,92 @@ fhandler_console::setup_for_non_cygwin_app ()
> >       console mode. */
> >    if (get_ttyp ()->getpgid () == myself->pgid)
> >      {
> > +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
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
> > +  WaitForSingleObject (p->cons_mode_mutex, mutex_timeout);
> > +  tty::cons_mode conmode = cons_mode_on_close (p);
> > +  if (con.curr_input_mode == conmode && con.curr_output_mode == conmode
> > +      && con.disable_master_thread == (con.owner == GetCurrentProcessId ()))
> > +    {
> > +      ReleaseMutex (p->cons_mode_mutex);
> > +      return;
> > +    }
> > +  switch (active_non_cygwin_apps_exist (pgid))
> > +    {
> > +    case -1: /* Error */
> > +      /* In case of an error, do not perform the cleanup, since the
> > +	 cygwin app has a chnce to restore console mode in bg_check()
> > +	 called from read()/write(). So give a priority to non-cygwin
> > +	 apps here that may exist. */
> > +      system_printf ("Checking for existence of non-cygwin app failed.");
> > +      if (con.owner == GetCurrentProcessId ())
> > +	/* This process is supposed to be the last non-cygwin process */
> > +	break;
> > +      fallthrough;
> > +    case 1: /* Exist */
> > +      ReleaseMutex (p->cons_mode_mutex);
> > +      return;
> > +    case 0: /* Not exist */
> > +    default:
> > +      break;
> > +    }
> > +
> >    termios dummy = {0, };
> >    termios *ti = shared_console_info[unit] ?
> >      &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
> > @@ -994,11 +1113,11 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
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
> > @@ -1055,6 +1174,10 @@ fhandler_console::setup_io_mutex (void)
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
> > @@ -1182,13 +1305,13 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECORD& mouse_event)
> >  		 || con.use_mouse >= 3));
> >  }
> >  
> > -
> >  bg_check_types
> >  fhandler_console::bg_check (int sig, bool dontsignal)
> >  {
> >    /* Setting-up console mode for cygwin app. This is necessary if the
> >       cygwin app and other non-cygwin apps are started simultaneously
> >       in the same process group. */
> > +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> >    if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
> >      {
> >        set_disable_master_thread (false, this);
> > @@ -1196,6 +1319,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
> >      }
> >    if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
> >      set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    return fhandler_termios::bg_check (sig, dontsignal);
> >  }
> > @@ -1314,6 +1438,8 @@ wait_retry:
> >  
> >  #undef buf
> >  
> > +  fix_input_mode_if_necessary (); /* for win32_input_mode */
> > +
> 
> This new call in `read()` is only on its normal finishing path. For
> example, consider a noncanonical 16-byte read with echo enabled,
> `VMIN=16`, and `VTIME=1`. If only the eight bytes `ESC[?9001h` arrive,
> echo changes `need_win32_input_mode_fix`; the read copies those bytes,
> retries, then returns eight from the partial-timeout branch. Please note
> that in this instance, it does *not* reach the new fix-up call. Another
> console operation may subsequently mask the missing update.

Fixed.

> Once again, please do double-check my claims. While I have a somewhat
> rudimentary understanding of the architecture of the code (and now finally
> even understand why that "master" thread exists, thanks to your patient
> explanations), without any doubt there could be gaping holes in my
> reasoning due to my lack of expertise in this area.
> 
> And before I forget, again: Thank you so much for working on this code. It
> is tricky, it is finicky, and without your continued dedication there
> would be no chance to ever resolve these bugs.
> 
> Ciao,
> Johannes
> 
> >    buflen = copied_chars;
> >    return;
> >  
> > @@ -2011,6 +2137,7 @@ fhandler_console::open (int flags, mode_t)
> >    if (in_is_console)
> >      CloseHandle (h_in);
> >  
> > +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> >    if (in_is_console && con.curr_input_mode != tty::cygwin)
> >      {
> >        prev_input_mode_backup = con.prev_input_mode;
> > @@ -2023,6 +2150,7 @@ fhandler_console::open (int flags, mode_t)
> >        GetConsoleMode (get_output_handle (), &con.prev_output_mode);
> >        set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> >      }
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
> >  		get_output_handle ());
> > @@ -2106,6 +2234,7 @@ fhandler_console::open_setup (int flags)
> >        handle_set.output_handle = get_output_handle ();
> >        handle_set.input_mutex = input_mutex;
> >        handle_set.output_mutex = output_mutex;
> > +      handle_set.cons_mode_mutex = cons_mode_mutex;
> >        handle_set.unit = unit;
> >      }
> >    return fhandler_base::open_setup (flags);
> > @@ -2115,6 +2244,7 @@ void
> >  fhandler_console::post_open_setup (int fd)
> >  {
> >    /* Setting-up console mode for cygwin app started from non-cygwin app. */
> > +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> >    if (fd == 0)
> >      {
> >        set_disable_master_thread (false, this);
> > @@ -2122,6 +2252,7 @@ fhandler_console::post_open_setup (int fd)
> >      }
> >    else if (fd == 1 || fd == 2)
> >      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
> > +  ReleaseMutex (cons_mode_mutex);
> >  
> >    fhandler_base::post_open_setup (fd);
> >  }
> > @@ -2131,18 +2262,20 @@ fhandler_console::close (int flag)
> >  {
> >    debug_printf ("closing: %p, %p", get_handle (), get_output_handle ());
> >  
> > -  acquire_output_mutex (mutex_timeout);
> > -
> >    if (shared_console_info[unit] && (dev_t) myself->ctty == get_device ()
> >        && cons_mode_on_close (&handle_set) == tty::restore)
> >      {
> > +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
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
> > @@ -2197,6 +2330,8 @@ fhandler_console::close (int flag)
> >    input_mutex = NULL;
> >    CloseHandle (output_mutex);
> >    output_mutex = NULL;
> > +  CloseHandle (cons_mode_mutex);
> > +  cons_mode_mutex = NULL;
> >  
> >    pcon_hand_over_proc ();
> >  
> > @@ -2246,8 +2381,8 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >  	release_output_mutex ();
> >  	return 0;
> >        case TIOCSWINSZ:
> > -	bg_check (SIGTTOU);
> >  	release_output_mutex ();
> > +	bg_check (SIGTTOU);
> >  	return 0;
> >        case KDGKBMETA:
> >  	*(int *) arg = (con.metabit) ? K_METABIT : K_ESCPREFIX;
> > @@ -2370,10 +2505,12 @@ int
> >  fhandler_console::tcsetattr (int a, struct termios const *t)
> >  {
> >    get_ttyp ()->ti = *t;
> > +  WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> >    if (con.curr_input_mode == tty::cygwin)
> >      set_input_mode (tty::cygwin, t, &handle_set);
> >    if (con.curr_output_mode == tty::cygwin)
> >      set_output_mode (tty::cygwin, t, &handle_set);
> > +  ReleaseMutex (cons_mode_mutex);
> >    return 0;
> >  }
> >  
> > @@ -3140,12 +3277,7 @@ fhandler_console::char_command (char c)
> >  		  if (con.args[i] == 1) /* DECCKM */
> >  		    con.cursor_key_app_mode = (c == 'h');
> >  		  if (con.args[i] == 9001) /* win32-input-mode (https://github.com/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard%20handling%20in%20Conpty.md) */
> > -		    {
> > -		      set_disable_master_thread (c == 'h', this);
> > -		      if (con.curr_input_mode == tty::cygwin)
> > -			set_input_mode (tty::cygwin,
> > -					&tc ()->ti, get_handle_set ());
> > -		    }
> > +		    con.need_win32_input_mode_fix = (c == 'h');
> >  		}
> >  	      /* Call fix_tab_position() if screen has been alternated. */
> >  	      if (need_fix_tab_position)
> > @@ -3994,6 +4126,18 @@ fhandler_console::write (const void *vsrc, size_t len)
> >  
> >    push_process_state process_state (PID_TTYOU);
> >  
> > +  ssize_t ret = raw_write (vsrc, len);
> > +
> > +  fix_input_mode_if_necessary (); /* for win32_input_mode */
> > +
> > +  syscall_printf ("%ld = fhandler_console::write(...)", len);
> > +
> > +  return ret;
> > +}
> > +
> > +ssize_t
> > +fhandler_console::raw_write (const void *vsrc, size_t len)
> > +{
> >    acquire_output_mutex (mutex_timeout);
> >  
> >    /* Run and check for ansi sequences */
> > @@ -4327,18 +4471,13 @@ fhandler_console::write (const void *vsrc, size_t len)
> >      }
> >    release_output_mutex ();
> >  
> > -  syscall_printf ("%ld = fhandler_console::write(...)", len);
> > -
> >    return len;
> >  }
> >  
> >  void
> >  fhandler_console::doecho (const void *str, DWORD len)
> >  {
> > -  int stopped = get_ttyp ()->output_stopped;
> > -  get_ttyp ()->output_stopped = 0;
> > -  write (str, len);
> > -  get_ttyp ()->output_stopped = stopped;
> > +  raw_write (str, len);
> >  }
> >  
> >  static const struct {
> > @@ -4476,10 +4615,13 @@ fhandler_console::set_console_mode_to_native ()
> >  	fhandler_console *cons = (fhandler_console *) (fhandler_base *) cfd;
> >  	if (cons->get_device () == cons->tc ()->getntty ())
> >  	  {
> > +	    const fhandler_console::handle_set_t *p = cons->get_handle_set ();
> > +	    WaitForSingleObject (p->cons_mode_mutex, mutex_timeout);
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
> > @@ -4536,8 +4678,17 @@ ContinueDebugEvent_Hooked
> >  static FARPROC
> >  GetProcAddress_Hooked (HMODULE h, LPCSTR n)
> >  {
> > -  if (strcmp(n, "RequestTermConnector") == 0)
> > -    fhandler_console::set_disable_master_thread (true);
> > +  if (cygheap->ctty && strcmp (n, "RequestTermConnector") == 0)
> > +    {
> > +      char buf[MAX_PATH];
> > +      const _minor_t unit = cygheap->ctty->get_minor ();
> > +      shared_name (buf, "cygcons.cons_mode.mutex", unit);
> > +      HANDLE cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
> > +      WaitForSingleObject (cons_mode_mutex, mutex_timeout);
> > +      fhandler_console::set_disable_master_thread (true);
> > +      ReleaseMutex (cons_mode_mutex);
> > +      CloseHandle (cons_mode_mutex);
> > +    }
> >    return GetProcAddress_Orig (h, n);
> >  }
> >  
> > @@ -4818,6 +4969,9 @@ fhandler_console::get_duplicated_handle_set (handle_set_t *p)
> >    DuplicateHandle (GetCurrentProcess (), output_mutex,
> >  		   GetCurrentProcess (), &p->output_mutex,
> >  		   0, FALSE, DUPLICATE_SAME_ACCESS);
> > +  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
> > +		   GetCurrentProcess (), &p->cons_mode_mutex,
> > +		   0, FALSE, DUPLICATE_SAME_ACCESS);
> >    p->unit = unit;
> >  }
> >  
> > @@ -4834,6 +4988,8 @@ fhandler_console::close_handle_set (handle_set_t *p)
> >    p->input_mutex = NULL;
> >    CloseHandle (p->output_mutex);
> >    p->output_mutex = NULL;
> > +  CloseHandle (p->cons_mode_mutex);
> > +  p->cons_mode_mutex = NULL;
> >  }
> >  
> >  bool
> > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> > index ee576a0a8..0134ec8b8 100644
> > --- a/winsup/cygwin/fhandler/termios.cc
> > +++ b/winsup/cygwin/fhandler/termios.cc
> > @@ -830,20 +830,37 @@ void
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
> > +}
> > +
> > +bool
> > +fhandler_termios::spawn_worker::is_attaching (DWORD pid)
> > +{
> > +  return !!fhandler_termios::get_console_process_id (pid, true);
> >  }
> >  
> >  void
> > -fhandler_termios::spawn_worker::close_handle_set ()
> > +fhandler_termios::spawn_worker::wait_for_resume_if_necessary
> > +			      (path_conv &pc, PROCESS_INFORMATION &pi)
> >  {
> > -  if (ptys_need_cleanup)
> > -    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
> > -  if (cons_need_cleanup)
> > -    fhandler_console::close_handle_set (&cons_handle_set);
> > +  if (is_attaching (myself->dwProcessId) && is_console_app (pc))
> > +    {
> > +      DWORD t0 = GetTickCount ();
> > +      while (GetTickCount () - t0 < 40 && !is_attaching (pi.dwProcessId)
> > +	     && WaitForSingleObject (pi.hProcess, 0) == WAIT_TIMEOUT)
> > +	Sleep (1);
> > +    }
> >  }
> >  
> >  void
> > @@ -916,7 +933,10 @@ fhandler_termios::get_console_process_id (DWORD pid, bool match,
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
> > index d11b3ec4f..e00212f57 100644
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
> > @@ -2042,7 +2043,8 @@ class fhandler_termios: public fhandler_base
> >  		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
> >      bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
> >      void cleanup ();
> > -    void close_handle_set ();
> > +    bool is_attaching (DWORD pid);
> > +    void wait_for_resume_if_necessary (path_conv &, PROCESS_INFORMATION &);
> >    };
> >  };
> >  
> > @@ -2157,6 +2159,8 @@ class dev_console
> >    volatile bool master_thread_suspended;
> >    int num_processed; /* Number of input events in the current input buffer
> >  			already processed by cons_master_thread(). */
> > +  bool need_win32_input_mode_fix;
> > +  bool is_processed_input;
> >  
> >    inline UINT get_console_cp ();
> >    DWORD con_to_str (char *d, int dlen, WCHAR w);
> > @@ -2199,6 +2203,7 @@ private:
> >    static console_state *shared_console_info[MAX_CONS_DEV + 1];
> >    static bool invisible_console;
> >    HANDLE input_mutex, output_mutex;
> > +  HANDLE cons_mode_mutex;
> >    handle_set_t handle_set;
> >    _minor_t unit;
> >    size_t num_input_events_processed;
> > @@ -2268,6 +2273,7 @@ private:
> >  
> >    void read (void *ptr, size_t& len);
> >    ssize_t write (const void *ptr, size_t len);
> > +  ssize_t raw_write (const void *ptr, size_t len);
> >    void doecho (const void *str, DWORD len);
> >    int close (int flag = -1);
> >    static bool exists ()
> > @@ -2366,6 +2372,7 @@ private:
> >    void wpbuf_send ();
> >    int fstat (struct stat *buf);
> >    void discard_key_events (size_t n);
> > +  void fix_input_mode_if_necessary ();
> >  
> >    class console_unit
> >    {
> > @@ -2379,6 +2386,7 @@ private:
> >    void setup_pcon_hand_over ();
> >    static void pcon_hand_over_proc ();
> >    static tty::cons_mode cons_mode_on_close (handle_set_t *);
> > +  static int active_non_cygwin_apps_exist (pid_t pgid);
> >  
> >    friend tty_min * tty_list::get_cttyp ();
> >  };
> > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > index b72083447..33417169b 100644
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
> > @@ -1180,8 +1180,10 @@ peek_console (select_record *me, bool)
> >  	  fh->release_input_mutex ();
> >  	  return -1;
> >  	}
> > +      fh->release_input_mutex ();
> > +
> > +      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> >      }
> > -  fh->release_input_mutex ();
> >    if (fh->input_ready || fh->get_cons_readahead_valid ())
> >      return me->read_ready = true;
> >  
> > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > index 8f976b9a0..abaa34d32 100644
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
> > @@ -737,6 +737,18 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
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
> > +	  term_spawn_worker.wait_for_resume_if_necessary (real_path, pi);
> > +	}
> > +
> >        if (mode == _P_OVERLAY)
> >  	{
> >  	  myself->dwProcessId = pi.dwProcessId;
> > @@ -810,18 +822,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  	    }
> >  	}
> >  
> > -      /* Start the child running */
> > -      if (c_flags & CREATE_SUSPENDED)
> > +      /* Start the child running for cygwin process*/
> > +      if (iscygwin () && (c_flags & CREATE_SUSPENDED))
> >  	{
> > -	  /* Inject a non-inheritable wr_proc_pipe handle into child so that we
> > -	     can accurately track when the child exits without keeping this
> > -	     process waiting around for it to exit.  */
> > -	  if (!iscygwin ())
> > -	    DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess, NULL,
> > -			     0, false, DUPLICATE_SAME_ACCESS);
> >  	  ResumeThread (pi.hThread);
> > -	  if (iscygwin ())
> > -	    strace.write_childpid (pi.dwProcessId);
> > +	  strace.write_childpid (pi.dwProcessId);
> >  	}
> >        ForceCloseHandle (pi.hThread);
> >  
> > @@ -868,7 +873,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  		prev_sigExeced =
> >  		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
> >  	      term_spawn_worker.cleanup ();
> > -	      term_spawn_worker.close_handle_set ();
> >  	    }
> >  	  /* Make sure that ctrl_c_handler() is not on going. Calling
> >  	     init_console_handler(false) locks until returning from
> > @@ -906,7 +910,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >        res = -1;
> >      }
> >    __endtry
> > -  term_spawn_worker.close_handle_set ();
> > +  term_spawn_worker.cleanup ();
> >    this->cleanup ();
> >    if (envblock)
> >      free (envblock);
> > -- 
> > 2.51.0
> > 
> > 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
