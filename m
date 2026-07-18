Return-Path: <SRS0=7Ga2=FM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 207E74BA2E0A
	for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 13:14:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 207E74BA2E0A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 207E74BA2E0A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784380493; cv=none;
	b=XPPKGnJmXwCjyG37ARDwoGPjOlNZ6vNbRFcJ476sjpWSLKwy1G5Tvr0RH3CLai44Bo+StQ70JA6cA3esFL2y2grnrHbcogjP2QDY797y2y26HeGU2+oH3RzKKOT9K/dV3iflmuaBSuomhXAPqKhxDw4olGUMrXYEY71Z67iZyF4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784380493; c=relaxed/simple;
	bh=0xzyi6uk68a5xJbVPh+JSOTbilxo+zPwQ2o5MIlO1CE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Ro8C3eeolftNFrOrxOJTLtPIOhYN+5H0L204oq+Hz93dWZI9VA1m8KVnogMuRE6yAEP/1Gj1Mh877hCKB9n8K8qk5H6Bbw/ZZTzcLG/Uv3nKJBVPbopy59LPonpfBJGHz/jVQfZtJneiyWCOhCmWcE/8Sh/9btVxv+szoOYF7Bg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZNO3Wwfn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 207E74BA2E0A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZNO3Wwfn
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260718131451375.DVYM.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 22:14:51 +0900
Date: Sat, 18 Jul 2026 22:14:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps
Message-Id: <20260718221449.d4c17e5d3c994088ff18c56c@nifty.ne.jp>
In-Reply-To: <43842666-74c7-623d-581c-3523f0283c01@gmx.de>
References: <20260716073629.6082-1-takashi.yano@nifty.ne.jp>
	<43842666-74c7-623d-581c-3523f0283c01@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784380491;
 bh=tjUggH2ht//1nuYb765judWkh7iCOELBpG9aoNiFdfI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ZNO3WwfnxeXXm/q/fm6W6bvTxCj+E1rHvWqx0AWB/wtIuOm54fkQxOX/8u/ghFBvOcaggSFG
 7uURRjV5mu3mwykb5B4FtOCxRy3CBOlJMN+w84mDsit9oAoLRpOi/fFZuCgQ+Tz11CEvXGKqIO
 cpvkSguBjxaJ6QTW8LC9nGH0RAIJUZjb+CG+PbuEV+80tn//lv3xauj5gLXP4WSTWa9Fhi+I4r
 6WR13irMWvVufPl3XWz6+tT2A2f7ZcsenZK2CAswXPuFvaNhihvmQQRgG3u3rlXc/OlkZHoQvI
 iHyRvRhIDDnBZDSXNd/fAuFS3YuW2muibQW4fZNvOzOu4nfA==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Fri, 17 Jul 2026 22:50:11 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 16 Jul 2026, Takashi Yano wrote:
> 
> > Previously, if two non-cygwin apps are started and one of them
> > exits first, the other one loosed appropriate console mode, since
> > the first one restored it to tty::cygwin. This patch counts the
> > active console process whose pgid is pgid of the tty and if the
> > result is zero (means the last non-cygwin foreground process),
> > restore console mode.
> 
> Thank you for v4 and for the follow-up correction. I verified that the
> published v4 applies cleanly to 0d516c2b1f4d and compiles and links a
> `new-cygwin1.dll`. I have not been able to establish the runtime behavior
> yet, so the following is from reading the code.
> 
> About the follow-up, to remove that `CloseHandle ()` call: agreed. That
> correction addresses the duplicate CloseHandle() only, though; the two
> blocking issues below are independent of it.
> 
> > To avoid race issue between apps modifying
> > console mode simultaneously, this patch also introduce a mutex
> > named `cons_mode_mutex`.
> 
> Here is the first blocking problem, and it is a direct consequence of
> "guard all mode changes". The new mutex is not acquired in a consistent
> order with respect to `output_mutex`.

Indeed. Thanks for finding this.

> > Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Stop counting up/down the counter by itself.
> >     Use num_active_non_cygwin_apps() instead.
> > v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
> > v4: Guard all mode changes in console by cons_mode_mutex.
> > 
> >  winsup/cygwin/fhandler/console.cc       | 87 ++++++++++++++++++++++++-
> >  winsup/cygwin/local_includes/fhandler.h |  2 +
> >  2 files changed, 86 insertions(+), 3 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index d4c87f29f..5b9a87ebd 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -977,15 +977,59 @@ fhandler_console::setup_for_non_cygwin_app ()
> >       console mode. */
> >    if (get_ttyp ()->getpgid () == myself->pgid)
> >      {
> > +      WaitForSingleObject (cons_mode_mutex, INFINITE);
> >        set_disable_master_thread (true, this);
> >        set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
> >        set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
> > +      ReleaseMutex (cons_mode_mutex);
> 
> In this path, `cons_mode_mutex` is taken first, and then
> `set_output_mode()` acquires `output_mutex` underneath it. The same
> nesting holds for `cleanup_for_non_cygwin_app()`, `bg_check()`, `open()`,
> `post_open_setup()`, `tcsetattr()`, and `set_console_mode_to_native()`:
> `cons_mode_mutex` first, `output_mutex` second.
> 
> >      }
> >  }
> >  
> > +static int
> > +num_active_non_cygwin_apps (pid_t pgid)
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
> > +	return 0;
> > +      buf_size1 = num;
> > +    }
> > +  if (num == 0)
> > +    return 0;
> > +
> > +  int cnt = 0;
> > +  for (DWORD i = 0; i < num; i++)
> > +    {
> > +      pinfo p (cygwin_pid (list[i]));
> > +      if (!!p && p->pgid == pgid && ISSTATE (p, PID_NOTCYGWIN))
> > +	cnt++;
> > +    }
> > +  return cnt;
> > +}
> > +
> >  void
> >  fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
> >  {
> > +  if (cygheap->ctty->tc()->pgid != myself->pgid)
> > +    return;
> > +
> > +  WaitForSingleObject (p->cons_mode_mutex, INFINITE);
> > +  if (num_active_non_cygwin_apps (cygheap->ctty->tc()->pgid))
> > +    {
> > +      ReleaseMutex (p->cons_mode_mutex);
> 
> The second blocking problem is a race window around process creation.
> `setup_for_non_cygwin_app()` runs before `CreateProcessW()` and releases
> `cons_mode_mutex` before the spawned process becomes visible: it is not
> yet in `GetConsoleProcessList()`, and there is no `pinfo` with
> `PID_NOTCYGWIN` and the matching `pgid` for it. During that interval a
> concurrent `cleanup_for_non_cygwin_app()` can count zero non-Cygwin apps
> and restore the Cygwin console mode, which is exactly the regression this
> patch sets out to fix. Keep in mind that the count is only reliable once
> the spawned process is both created and published. The pending native-mode
> state needs to remain represented across process creation and publication,
> with a rollback if `CreateProcessW()` fails.

I re-introduce a counter for this short period. This minimize the
risk that the stub process killed by taskkill, etc. while the
counter is active. However, as I mentioned in the previous mail,
we cannnot fully address this problem. What do you think?

> Two non-blocking points on this `num_active_non_cygwin_apps()` helper.
> 
> First, latency. On each call this normally does two
> `GetConsoleProcessList()` calls (more if the process count changes between
> them) plus O(N) `cygwin_pid()` and `pinfo` construction, all under
> `cons_mode_mutex`, and v4 broadens who has to wait for that mutex. I am
> not claiming an observed slowdown; I have not measured it. Did you? If
> not, a cheap fast path seems worthwhile: this loop counts every match but
> only the question "is there at least one?" matters, so returning on the
> first match, and skipping `pinfo` construction entirely when
> `cygwin_pid()` returns 0, would bound the common case.

Done. Thanks.

> Second, error semantics. This returns 0 for three distinct situations: a
> genuine "no matching process", an API failure (`num == 0`), and output
> exceeding `buf_size`. But 0 is precisely the value that authorizes the
> caller to restore the Cygwin mode. Conflating "there are no non-Cygwin
> apps" with "I could not find out" means an enumeration failure silently
> triggers a mode restore. Please give the helper a distinct
> "unavailable/error" result so the caller can decline to restore when the
> count is not trustworthy.

In the error case, v5 patch print error message by system_printf(), and
restore the console mode to tty::cygwin. (Because, in cygwin environment,
the emphasis is placed on ensuring that cygwin apps behave correctly,
rather than on non‑Cygwin apps.)

> > @@ -2135,11 +2191,13 @@ fhandler_console::close (int flag)
> >    if (shared_console_info[unit] && (dev_t) myself->ctty == get_device ()
> >        && cons_mode_on_close (&handle_set) == tty::restore)
> >      {
> > +      WaitForSingleObject (cons_mode_mutex, INFINITE);
> >        set_disable_master_thread (true, this);
> >        if (con.curr_output_mode != tty::restore)
> >  	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
> 
> But `close()` here, and `char_command()` below, are already holding
> `output_mutex` at the point they reach this code, and only then acquire
> `cons_mode_mutex`. That is the opposite order.

I moved acquire_output_mutex() in close() to the place after the console
mode change in v5 patch. As for char_command() case, if the cons_mode_mutex
cannot be acquired immediately, give up the setting console mode there.
Even if we manage to get the mutex acquisition order right, which can be
overwritten by concurrent process/thread. That's a matter of luck.

> >        if (con.curr_input_mode != tty::restore)
> >  	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
> > +      ReleaseMutex (cons_mode_mutex);
> >      }
> >  
> >    if (shared_console_info[unit] && con.owner == GetCurrentProcessId ())
> > @@ -2196,6 +2254,8 @@ fhandler_console::close (int flag)
> >    input_mutex = NULL;
> >    CloseHandle (output_mutex);
> >    output_mutex = NULL;
> > +  CloseHandle (cons_mode_mutex);
> > +  cons_mode_mutex = NULL;
> >  
> >    pcon_hand_over_proc ();
> >  
> > @@ -2369,10 +2429,12 @@ int
> >  fhandler_console::tcsetattr (int a, struct termios const *t)
> >  {
> >    get_ttyp ()->ti = *t;
> > +  WaitForSingleObject (cons_mode_mutex, INFINITE);
> >    if (con.curr_input_mode == tty::cygwin)
> >      set_input_mode (tty::cygwin, t, &handle_set);
> >    if (con.curr_output_mode == tty::cygwin)
> 
> Two processes can therefore wait on each other indefinitely: one holding
> `output_mutex` and waiting for `cons_mode_mutex`, the other holding
> `cons_mode_mutex` and waiting for `output_mutex`. We need one consistent
> lock order across all of these sites. I do not want to prescribe a
> specific redesign as unquestionably correct; whether that means taking
> `output_mutex` before `cons_mode_mutex` everywhere, or narrowing
> `cons_mode_mutex` so it never nests over `output_mutex`, is your call. But
> the current mixed order is a showstopper.

I think I have fixed the problem you pointed out. Could you please
review v5 patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
