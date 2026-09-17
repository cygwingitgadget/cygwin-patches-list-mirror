Return-Path: <SRS0=k2H2=HJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id EDDD24BA23C0
	for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 05:28:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDDD24BA23C0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EDDD24BA23C0
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789622920; cv=none;
	b=iLZjdS41rC3ETBzmT4sfCrnExssUQHay2nViETHWkvcU4J79OOXYrYgb/r3Vh8TOCZ9T/a/HQMWjb3vXiVYqTQfXQzK5IHn7XtsvQ7CqlLLd27RpOMuTG61Nax/jOCFUJ940XOIi9SAuiT/8x8LghyYpTM2GilUx7kUtITFmAk4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789622920; c=relaxed/simple;
	bh=ZWu19iFq5p98ot2mIj5BEnfbIuFvuT7APW3ZJRrzt2I=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=E3FAjL7XdJniJkjS9sJwyusVF3otDfrfT+uKtganvC3XkpKdTW+ypm3724s/bgrj9b3nSp5JKPoMTe4iZkbICD5Y1GgWwq90O+UA50PIQuVqCCfJJD/V6byoDkPPirYZYh6NnA/MDSXuHjrFBy+WbvZn2T2pnEy0c9dKssNZ2aU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S9KQfe9A
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EDDD24BA23C0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S9KQfe9A
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260917052836135.TVRV.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2026 14:28:36 +0900
Date: Thu, 17 Sep 2026 14:28:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v16] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260917142834.122418c7121e4d13ea4c5719@nifty.ne.jp>
In-Reply-To: <b5cc7615-8db1-6f65-cd2b-88095d491667@gmx.de>
References: <20260915075713.726-1-takashi.yano@nifty.ne.jp>
	<b5cc7615-8db1-6f65-cd2b-88095d491667@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789622916;
 bh=Bp99FuSkV19BNyRMD0hgDFiMFEm39nmyj7mEhkt45Q8=;
 h=Date:From:To:Subject:In-Reply-To;
 b=S9KQfe9AGcjRvTYrOWGqJU0ygPdnKFLm4wWttE8WtVpltI4y9Fy+j2adRcjoXOuSaWLGO/Ba
 WRFvlqxWUgjDcGLK1KkhsanmxF46uHRXL4EABMJHYWr3dQjb2/D3x0Y786xnBBWGJEm+iQQ6Pe
 sTSxreHHNjm/AIZbVh9mx1Au6nP6KyonifIOI/m4qRt6e8dhm03FF0KcJnGr+gm9km5lzKAxGU
 nqT9BccIaBQyWKhfIpdZiLFLNhS6U+NWwDJKFyvEemXhYaaZaGxkDfsynTGpf1LtEV+1cI1hcN
 rEdyEdqUMIVmtAZIj6AKAy//ceFmaYkqoUqGGqEL7DeFRhVQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Sorry that I haven’t been able to come up with a fully satisfactory
patch.

On Wed, 16 Sep 2026 15:41:10 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 15 Sep 2026, Takashi Yano wrote:
> 
> > Previously, if two non-cygwin apps are started and one of them
> > exits first, the other one lost appropriate console mode, since
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
> > v16: Avoid to overwrite ENABLE_PROCESS_INPUT in tty::native mode.
> >      Call fix_input_mode_if_necessary in TIMEOUT case as well.
> 
> Unfortunately, v16 still does not quite address the hangs. See for example
> https://github.com/msys2/msys2-runtime/issues/351, with whose reproducer
> at https://github.com/mrev11/msys2-bugreport (which still hangs with a
> backported v16) I was able to come up with a fixup for the backported v15,
> https://github.com/msys2/msys2-runtime/pull/364/commits/dbc070a9d472021d0aecf771ea1d5280a6a48031:
> 
> -- snip --
> Avoid the cleanup/startup deadlock: cleanup can hold `cons_mode_mutex`
> while waiting for a console master that a new owner cannot start until
> acquiring that mutex. Startup must precede the mode-mutex wait without
> changing the handshake or mode serialization.
> 
> Also avoid waiting forever for an owner that exited without clearing
> ownership. A confirmed exit permits ending the wait only while the
> captured owner is still recorded, excluding the -1 normal-retirement
> sentinel. Preserve the published request for a replacement worker;
> a missing worker is not an acknowledgement.
> 
> Assisted-by: GPT-6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/console.cc | 47 +++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 1c30d5f981..c499ae491f 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -2086,6 +2086,26 @@ fhandler_console::open (int flags, mode_t)
>    if (in_is_console)
>      CloseHandle (h_in);
>  
> +  /* Another process may hold cons_mode_mutex while waiting for the
> +     master thread to acknowledge a state change. */
> +  if (GetCurrentProcessId () == con.owner)
> +    {
> +      if (GetModuleHandle ("ConEmuHk64.dll"))
> +	hook_conemu_cygwin_connector ();
> +      char name[MAX_PATH];
> +      shared_name (name, CONS_THREAD_SYNC, get_minor ());
> +      thread_sync_event = CreateEvent(NULL, FALSE, FALSE, name);
> +      if (thread_sync_event)
> +	{
> +	  new cygthread (::cons_master_thread, this, "consm");
> +	  WaitForSingleObject (thread_sync_event, INFINITE);
> +	  CloseHandle (thread_sync_event);
> +	}
> +      else
> +	debug_printf ("Failed to create thread_sync_event %08x",
> +		      GetLastError ());
> +    }
> +
>    WaitForSingleObject (cons_mode_mutex, mutex_timeout);
>    if (in_is_console && con.curr_input_mode != tty::cygwin)
>      {
> @@ -2104,23 +2124,6 @@ fhandler_console::open (int flags, mode_t)
>    debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
>  		get_output_handle ());
>  
> -  if (GetCurrentProcessId () == con.owner)
> -    {
> -      if (GetModuleHandle ("ConEmuHk64.dll"))
> -	hook_conemu_cygwin_connector ();
> -      char name[MAX_PATH];
> -      shared_name (name, CONS_THREAD_SYNC, get_minor ());
> -      thread_sync_event = CreateEvent(NULL, FALSE, FALSE, name);
> -      if (thread_sync_event)
> -	{
> -	  new cygthread (::cons_master_thread, this, "consm");
> -	  WaitForSingleObject (thread_sync_event, INFINITE);
> -	  CloseHandle (thread_sync_event);
> -	}
> -      else
> -	debug_printf ("Failed to create thread_sync_event %08x",
> -		      GetLastError ());
> -    }
>    return 1;
>  }

Thanks for the advice!
I'd like to include this change to v17 patch with Co-authored-by: tag.

> @@ -4938,7 +4941,15 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
>    con.disable_master_thread = x;
>    cons->release_input_mutex ();
>    while (con.master_thread_suspended != x)
> -    Sleep (1);
> +    {
> +      DWORD owner = con.owner;
> +      /* Keep the request for a replacement worker, but do not wait for a
> +	 dead owner.  -1 denotes an owner completing normal retirement. */
> +      if (owner != (DWORD) -1 && !process_alive (owner)
> +	  && con.owner == owner)
> +	break;
> +      Sleep (1);
> +    }
>  }
>  
>  int

I also would like to include this part into NOT this patch, but into:
[PATCH v2] Cygwin: console: Abort setting disable_master_thread when no con.owner
bacause the patch above attempt to fix the closely related problem.

> -- snap --
> 
> Note: I am _not_ claiming that this should be the final fix. I'm just
> observing that it addresses the reported hangs reliably.
> 
> The reason is a startup deadlock. The reproducer launches Bash and native
> children from concurrent native threads. In my tests, already its first of
> five passes hung: one started, zero completed. Cleanup process A holds
> `cons_mode_mutex` in `cleanup_for_non_cygwin_app()` and calls
> `set_disable_master_thread(false)`, waiting for resume acknowledgement.
> Live owner B waits in `open()` for the same mutex _before creating the
> worker_ that must acknowledge A. Process A cannot release the mutex until
> B's worker runs; B cannot start it until A releases the mutex. The
> captures show a `false` request, `true` acknowledgement, no started worker
> and `need_win32_input_mode_fix=false`: this failure does not involve
> Win32-input suppression.
> 
> The fixup I came up with moves worker startup before the mode-lock wait
> and adds an owner-liveness escape preserving the request. Startup
> reordering alone still hung on a dead, nonzero owner. The combined
> v15-backport fix completed five uninstrumented reproducer runs (495 jobs,
> no child-command failures); GitHub user `@lhmouse` reported in
> https://github.com/msys2/MSYS2-packages/pull/6445#issuecomment-5677483786
> that their own hang was _also_ resolved by this v15+fixup
> 
> > 
> >  winsup/cygwin/fhandler/console.cc       | 207 +++++++++++++++++++++---
> >  winsup/cygwin/fhandler/termios.cc       |  40 +++--
> >  winsup/cygwin/local_includes/fhandler.h |  10 +-
> >  winsup/cygwin/select.cc                 |  16 +-
> >  winsup/cygwin/spawn.cc                  |  44 ++---
> >  5 files changed, 257 insertions(+), 60 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index be41bf3a2..5de74a6a6 100644
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
> An already-started worker can still fail to acknowledge resume. The 40msec
> window covers setting acknowledgement `true` for pause. While
> `need_win32_input_mode_fix` remains `true`, the worker sleeps and
> continues before clearing that acknowledgement. A caller requesting
> `false` can therefore wait indefinitely despite periodic wakes. This
> unchanged source-level concern is distinct from the captured startup
> deadlock; the experimental startup/death safeguards do not fix it.

Ah, I got it. Thanks! I'll fix that in v17 patch.

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
> > [... snipping ...]
> > @@ -1248,6 +1378,7 @@ wait_retry:
> >  	case WAIT_TIMEOUT:
> >  	  if (copied_chars)
> >  	    {
> > +	      fix_input_mode_if_necessary (); /* for win32_input_mode */
> >  	      buflen = copied_chars;
> >  	      return;
> >  	    }
> 
> This timeout fix still misses canonical echo (a blocking canonical read
> uses `INFINITE`). If it echoes a mode-switch sequence without receiving a
> newline, input processing can return `input_processing`, release
> `input_mutex`, and loop back to waiting. It reaches neither this timeout
> branch nor the normal finishing fix-up. Thus this hunk addresses the
> specific partial-timeout example, but not that canonical-echo path.
> 
> I do like the native guard and timeout improvement, but also think that
> worker startup/retirement, `false` acknowledgement and deferred
> reconciliation before approval need addressing.
> 
> I.e. the code needs to finish processing the current input under
> `input_mutex`, release that lock, then apply any mode change recorded
> during echo, _before_ waiting for more input or returning to the
> application. The order should be something along the lines of:
> 
> 	case input_processing:
> 	  release_input_mutex ();
> 	  fix_input_mode_if_necessary ();
> 	  continue;
> 
> v16 currently goes straight from `release_input_mutex()` to `continue`,
> potentially waiting indefinitely for more input before applying the echoed
> mode change. Early returns after input processing need the same
> consideration.
> 
> So why release input first? The helper acquires `cons_mode_mutex` and
> then, when an update is needed, `input_mutex`. Calling it while the caller
> still holds `input_mutex` would introduce the reverse ordering:
> 
> 	echoing reader:		holds INPUT -> waits for MODE
> 	mode changer:		holds MODE -> waits for INPUT
> 
> That's the deadlock we need to remove.

Thanks for the advice. I'll add your proposal to v17.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
