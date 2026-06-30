Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 0350F4BA2E15
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 08:37:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0350F4BA2E15
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0350F4BA2E15
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782808623; cv=none;
	b=Xb30wJhWXTpSVuwZQOuEtciY7Pod9t54iZuDDFGieu2kE0YyaVGoxZUttIeW9ixuQ9VBQ+bGrJ4QMCL/yUSa3fro6VboVtk9VwSSeKcbge5trV4EcoVzNH715zaLhhP4SAS3K16ibh0dkzq41ABWjEPlPlIPzzCYHjcF6YYPDwE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782808623; c=relaxed/simple;
	bh=B8gSy6WkAv+hH4hoWHe6U/PRS8Un5trTiY1bvHp3v2A=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=SYY40ithI3fOVfMbuQs+NyUZM8nI7S5+2OCxydJm8vFYbu1gYOxMMWT9jJVuGLD8wbtQSpNO6BVyATPgk0ozmkBOpWREOk29A5wp79SKHEBwwIEY5BcH6v0d+zwHoCmcYfTDJe+QKaf3Z1mbo85gRskCenEWYWRpkuhQx9ym1/k=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DvCiKrZ6
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0350F4BA2E15
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DvCiKrZ6
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260630083701096.SUOV.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 17:37:01 +0900
Date: Tue, 30 Jun 2026 17:36:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app
 exits
Message-Id: <20260630173659.6fef765e6d60dd2c54e42796@nifty.ne.jp>
In-Reply-To: <b9c76c12-c300-69c1-b6e3-5b03396ed8e0@gmx.de>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
	<20260613140917.27155-4-takashi.yano@nifty.ne.jp>
	<b9c76c12-c300-69c1-b6e3-5b03396ed8e0@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782808621;
 bh=m3f1L7620U0kpDr78V+KSn6oZQUf69qryG36lTb9Fzw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=DvCiKrZ6G9KwuMd1R4nbmYVG2l0RyVH/zob/MsjlO6ni4L2VM2NNfDqDd5m7HfaBxuhhfbF8
 yNFCJUiaODAEC/rVefgT6+vQBIg7jEzHeTttCwlqA4yyJHshExfBeOHCYTD5XSBO/iNXvikGDM
 fgiN7gEDPcA5H6IfsphO5unCuzlDYUTwrFeZw8AD+6Ft4pdE0rqSogarTyi4HqNRoi4pGOVRsd
 C7ZtKEqPnnJmxvACE0x5drHWa5pJbGtGwMBbk9JIQVhsJ39ubb02ZzPbBIRhlPs2ZHYLAC4gjp
 g74/Jx8Syq11f9PWWGg2xa/J/MUBjmtoL6fYVb6HA66RYeig==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_LOTSOFHASH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

The second and the third patches of your three additional patches LGTM.
Pushed to master.
Thanks!

I'm reviewing the first one. Please wait.

On Sat, 27 Jun 2026 09:18:41 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi, Mark,
> 
> I had started working on those patches, been pulled away, and meant coming
> back to them but failed. The work was tracked in
> https://github.com/git-for-windows/msys2-runtime/pull/131, but I
> admittedly did not find the time to complete the work earlier.
> 
> There are fixes in that PR (in addition to UI tests based on AutoHotKey
> that helped me catch a couple of bugs) for the following three issues:
> 
> 
> On Sat, 13 Jun 2026, Takashi Yano wrote:
> 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index b3a8d57cc..f4473bb69 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -388,6 +388,52 @@ atexit_func (void)
> >      }
> >  }
> >  
> > +void
> > +fhandler_pty_slave::req_fixup_pcon_state (void)
> > +{
> > +  while (true)
> > +    {
> > +      WaitForSingleObject (input_mutex, mutex_timeout);
> > +      if (!get_ttyp ()->pcon_start_pid)
> > +	break;
> > +      /* Another request is on going. */
> > +      ReleaseMutex (input_mutex);
> > +      yield ();
> > +    }
> > +
> > +  DWORD n;
> > +  /* indicates that this "ESC[6n" is just for fixing-up corsor position */
> > +  get_ttyp ()->req_fixup_pcon_cur_pos = true;
> > +  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
> > +					 is just for transfer input */
> > +  get_ttyp ()->pcon_start = true;
> > +  get_ttyp ()->pcon_start_pid = myself->pid;
> > +  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
> > +  ReleaseMutex (input_mutex);
> > +  while (get_ttyp ()->pcon_start_pid)
> > +    /* wait for completion of fixing-up in master::write(). */
> > +    yield ();
> 
> Both of these loops are unbounded, and both depend on somebody else
> clearing `pcon_start_pid`. If the master never replies (terminal closing,
> broken pipe, or the previous requester died mid-handshake), the exiting
> process spins forever in the second loop, and a stale slot wedges the next
> exiting process in the first one. This commit also drops the
> `pcon_start_pid = 0` reset that `close_pseudoconsole()` used to do, so the
> stale-slot case is no longer self-healing across pcon teardown either.
> 
> Bounding both waits with a 3-second `GetTickCount64()` deadline, clearing
> our own `pcon_start_pid` on timeout only if it is still ours, and
> restoring the `close_pseudoconsole()` reset as a backstop makes the
> pathological case degrade to a slightly stale cursor rather than a hung
> exit.
> 
> The fix I would propose is in
> https://github.com/git-for-windows/msys2-runtime/pull/131/changes/c366a1c02e66a242a3437f6b9335c2319c095c92:
> 
> -- snip --
> From c366a1c02e66a242a3437f6b9335c2319c095c92 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 25 Jun 2026 13:41:42 +0200
> Subject: [PATCH] Cygwin: pty: bound the cursor-sync round-trip so an exiting
>  process cannot hang
> 
> The cursor-position fixup added in "Cygwin: pty: Fixup pty state after
> a cygwin app exits" runs from cleanup() on every foreground Cygwin-app
> exit while a pseudo console is active, and it waits on two unbounded
> loops for the master to answer the "ESC[6n" it just sent: one that
> spins until the pcon_start_pid slot is free, and one that spins until
> the master clears the slot again. pcon_start_pid is only ever cleared
> once master::write() parses the terminal's reply, so if that reply
> never comes, because the terminal is going away, the forwarding pipe
> is broken, or a previous requester died mid-handshake, the exiting
> process spins on yield() forever and never exits.
> 
> Bound both waits with a three second deadline using GetTickCount64(),
> and on timeout clear our own pcon_start_pid slot, but only if it is
> still ours, so a give-up does not stomp a later requester. Also restore
> the pcon_start and pcon_start_pid reset that the same commit removed
> from close_pseudoconsole(); it is the backstop that keeps a requester
> which died without clearing its slot from wedging the next one. The
> worst case is now a slightly stale cursor after a timeout rather than a
> process that refuses to exit.
> 
> Fixes: b34394d456b6 ("Cygwin: pty: Fixup pty state after a cygwin app exits")
> Assisted-by: Opus 4.8
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index c79fd1f975..669e18238b 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -226,6 +226,7 @@ atexit_func (void)
>  void
>  fhandler_pty_slave::req_fixup_pcon_state (void)
>  {
> +  ULONGLONG deadline = GetTickCount64 () + 3000;
>    while (true)
>      {
>        WaitForSingleObject (input_mutex, mutex_timeout);
> @@ -233,6 +234,10 @@ fhandler_pty_slave::req_fixup_pcon_state (void)
>  	break;
>        /* Another request is on going. */
>        ReleaseMutex (input_mutex);
> +      if (GetTickCount64 () > deadline)
> +	/* A previous requester is stuck; give up this sync rather than
> +	   spin forever. */
> +	return;
>        yield ();
>      }
>  
> @@ -245,9 +250,25 @@ fhandler_pty_slave::req_fixup_pcon_state (void)
>    get_ttyp ()->pcon_start_pid = myself->pid;
>    WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
>    ReleaseMutex (input_mutex);
> -  while (get_ttyp ()->pcon_start_pid)
> +  deadline = GetTickCount64 () + 3000;
> +  while (get_ttyp ()->pcon_start_pid && GetTickCount64 () <= deadline)
>      /* wait for completion of fixing-up in master::write(). */
>      yield ();
> +  /* If the master never answered (e.g. the terminal is going away),
> +     clear our own request so a stale pcon_start_pid cannot wedge the
> +     next requester. */
> +  if (get_ttyp ()->pcon_start_pid == (pid_t) myself->pid)
> +    {
> +      WaitForSingleObject (input_mutex, mutex_timeout);
> +      if (get_ttyp ()->pcon_start_pid == (pid_t) myself->pid)
> +	{
> +	  get_ttyp ()->req_fixup_pcon_cur_pos = false;
> +	  get_ttyp ()->req_xfer_input = false;
> +	  get_ttyp ()->pcon_start = false;
> +	  get_ttyp ()->pcon_start_pid = 0;
> +	}
> +      ReleaseMutex (input_mutex);
> +    }
>  }
>  
>  void
> @@ -4007,6 +4028,10 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
>  	  ttyp->pcon_activated = false;
>  	  ttyp->switch_to_nat_pipe = false;
>  	  ttyp->nat_pipe_owner_pid = 0;
> +	  /* Safety net: if a req_fixup_pcon_state() requester died without
> +	     clearing its slot, do not leave pcon_start_pid set forever. */
> +	  ttyp->pcon_start = false;
> +	  ttyp->pcon_start_pid = 0;
>  	}
>        if (ttyp->pcon_handle_ready_event)
>  	{
> --  snap --
> 
> > +}
> > +
> > +void
> > +fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
> > +{
> > +  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > +				   get_ttyp ()->nat_pipe_owner_pid);
> > +  HANDLE h_pcon_out = NULL;
> > +  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> > +		   GetCurrentProcess (), &h_pcon_out,
> > +		   0, TRUE, DUPLICATE_SAME_ACCESS);
> > +  CloseHandle (pcon_owner);
> > +  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
> > +  DWORD resume_pid =
> > +    fhandler_pty_common::attach_console_temporarily (target_pid);
> > +  COORD cur_pos = {(SHORT) (x - 1), (SHORT) (y - 1)};
> > +  SetConsoleCursorPosition (h_pcon_out, cur_pos);
> > +  fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
> > +  CloseHandle (h_pcon_out);
> > +}
> > +
> >  #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
> >  /* CreateProcess() is hooked for GDB etc. */
> >  DEF_HOOK (CreateProcessA);
> > @@ -1162,6 +1208,19 @@ err_no_msg:
> >  bool
> >  fhandler_pty_slave::open_setup (int flags)
> >  {
> > +  if (get_ttyp ()->pcon_activated)
> > +    {
> > +      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > +				       get_ttyp ()->nat_pipe_owner_pid);
> > +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> > +		       GetCurrentProcess (), &get_handle_nat (),
> > +		       0, TRUE, DUPLICATE_SAME_ACCESS);
> > +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> > +		       GetCurrentProcess (), &get_output_handle_nat (),
> > +		       0, TRUE, DUPLICATE_SAME_ACCESS);
> > +      CloseHandle (pcon_owner);
> 
> By the time we get here, `open()` has already installed real duplicates of
> the cyg master-side pipe ends into `io_handle_nat` and
> `output_handle_nat`. Overwriting them through `&get_handle_nat()` /
> `&get_output_handle_nat()` without closing the previous values first leaks
> two handles on every pcon-backed grandchild open. The `OpenProcess()`
> return is also not NULL-checked: when the nat-pipe owner has already
> exited, both `DuplicateHandle()` calls fail silently and leave the nat
> slots NULL, which then breaks the slave's input routing in ways that are
> hard to reason about after the fact.
> 
> The fix is to close the existing handles first, skip the replacement when
> `OpenProcess()` returns NULL, and treat the two duplications as one
> transaction so a partial failure does not leave the slave in a
> half-installed state. I implemented that in
> https://github.com/git-for-windows/msys2-runtime/pull/131/changes/6238d106537d6e130efe9084353850349e9c593d:
> 
> -- snip --
> From 6238d106537d6e130efe9084353850349e9c593d Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 25 Jun 2026 13:41:43 +0200
> Subject: [PATCH] Cygwin: pty: do not leak nat handles when adopting the pcon's
>  in open_setup()
> 
> When a Cygwin process opens a pty slave whose pseudo console is already
> active, open() has just installed duplicates of the cyg master-side
> pipe ends into io_handle_nat and output_handle_nat. The pcon adoption
> added in "Cygwin: pty: Fixup pty state after a cygwin app exits"
> overwrites those two slots via &get_handle_nat() / &get_output_handle_nat()
> without closing them first, so two handles leak on every pcon-backed
> grandchild open. It also hands the result of OpenProcess() straight to
> DuplicateHandle() without a NULL check, so if the nat-pipe owner has
> already exited both duplications fail and leave the nat slots NULL,
> which then breaks the slave's input routing.
> 
> Close the old slots before replacing them, skip the replacement
> entirely when OpenProcess() returns NULL so we degrade to the handles
> open() installed, and make the pair transactional so a partial success
> cannot leave one original slot and one pcon slot.
> 
> Fixes: b34394d456b6 ("Cygwin: pty: Fixup pty state after a cygwin app exits")
> Assisted-by: Opus 4.8
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 669e18238b..acf7da9319 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1072,13 +1072,33 @@ fhandler_pty_slave::open_setup (int flags)
>      {
>        HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
>  				       get_ttyp ()->nat_pipe_owner_pid);
> -      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> -		       GetCurrentProcess (), &get_handle_nat (),
> -		       0, TRUE, DUPLICATE_SAME_ACCESS);
> -      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> -		       GetCurrentProcess (), &get_output_handle_nat (),
> -		       0, TRUE, DUPLICATE_SAME_ACCESS);
> -      CloseHandle (pcon_owner);
> +      if (pcon_owner)
> +	{
> +	  HANDLE new_in = NULL, new_out = NULL;
> +	  bool ok_in = DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> +				       GetCurrentProcess (), &new_in,
> +				       0, TRUE, DUPLICATE_SAME_ACCESS);
> +	  bool ok_out = DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> +				        GetCurrentProcess (), &new_out,
> +				        0, TRUE, DUPLICATE_SAME_ACCESS);
> +	  if (ok_in && ok_out)
> +	    {
> +	      /* Close the cyg master-side handles open() installed before
> +		 replacing them, so they do not leak. */
> +	      CloseHandle (get_handle_nat ());
> +	      CloseHandle (get_output_handle_nat ());
> +	      set_handle_nat (new_in);
> +	      set_output_handle_nat (new_out);
> +	    }
> +	  else
> +	    {
> +	      if (new_in)
> +		CloseHandle (new_in);
> +	      if (new_out)
> +		CloseHandle (new_out);
> +	    }
> +	  CloseHandle (pcon_owner);
> +	}
>      }
>  
>    set_flags ((flags & ~O_TEXT) | O_BINARY);
> -- snap --
> 
> > +    }
> > +
> >    set_flags ((flags & ~O_TEXT) | O_BINARY);
> >    myself->set_ctty (this, flags);
> >    report_tty_counts (this, "opened", "");
> > @@ -1171,6 +1230,9 @@ fhandler_pty_slave::open_setup (int flags)
> >  void
> >  fhandler_pty_slave::cleanup ()
> >  {
> > +  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
> > +    req_fixup_pcon_state ();
> > +
> >    /* This used to always call fhandler_pty_common::close when we were execing
> >       but that caused multiple closes of the handles associated with this pty.
> >       Since close_all_files is not called until after the cygwin process has
> > @@ -2478,7 +2540,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  	      /* req_xfer_input is true if "ESC[6n" was sent just for
> >  		 triggering transfer_input() in master. In this case,
> >  		 the response sequence should not be written. */
> > -	      if (!get_ttyp ()->req_xfer_input)
> > +	      if (get_ttyp ()->req_fixup_pcon_cur_pos)
> > +		{
> > +		  int x, y;
> > +		  sscanf (wpbuf, "\033[%d;%dR", &y, &x);
> > +		  fixup_pcon_cursor_position (x, y);
> 
> The `sscanf()` return is dropped, so a malformed or truncated
> cursor-position reply hands uninitialised `x` and `y` straight into
> `SetConsoleCursorPosition()` via the COORD cast.
> `fixup_pcon_cursor_position()` itself has the same `OpenProcess()` NULL
> hazard as above, plus an unchecked `DuplicateHandle()` whose `h_pcon_out`
> is then used unconditionally.
> 
> Gating the call on `sscanf (...) == 2`, clamping the coordinates into the
> valid SHORT range before the COORD cast, and adding the missing NULL
> checks in the helper closes all three holes:
> https://github.com/git-for-windows/msys2-runtime/pull/131/changes/5de332d1b7c289ff9f3b02f2dedc9e9842fbbf04
> 
> -- snip --
> From 5de332d1b7c289ff9f3b02f2dedc9e9842fbbf04 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 25 Jun 2026 13:41:44 +0200
> Subject: [PATCH] Cygwin: pty: validate the cursor-position reply before moving
>  the pcon cursor
> 
> The CSI6n reply handler added in "Cygwin: pty: Fixup pty state after a
> cygwin app exits" runs sscanf() on the terminal's response but ignores
> its return value, so a malformed or partial reply leaves the x and y
> locals uninitialised and hands them to SetConsoleCursorPosition(),
> which is exactly the cursor corruption the commit set out to prevent.
> 
> Only call the fixup when sscanf() reports both coordinates parsed, and
> in fixup_pcon_cursor_position() clamp the coordinates into the valid
> SHORT range before the COORD cast so a stray reply cannot wrap into a
> negative position. While there, check OpenProcess() for NULL (the
> nat-pipe owner may have exited) and check the DuplicateHandle() result
> instead of using a possibly-NULL screen-buffer handle.
> 
> Fixes: b34394d456b6 ("Cygwin: pty: Fixup pty state after a cygwin app exits")
> Assisted-by: Opus 4.8
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index acf7da9319..522f46e0f2 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -274,12 +274,23 @@ fhandler_pty_slave::req_fixup_pcon_state (void)
>  void
>  fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
>  {
> +  /* A malformed or out-of-range reply must not be turned into a wrapped
> +     negative COORD. */
> +  if (x < 1 || y < 1 || x > 0x7fff || y > 0x7fff)
> +    return;
>    HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
>  				   get_ttyp ()->nat_pipe_owner_pid);
> +  if (!pcon_owner)
> +    /* The nat-pipe owner is gone; nothing to sync to. */
> +    return;
>    HANDLE h_pcon_out = NULL;
> -  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> -		   GetCurrentProcess (), &h_pcon_out,
> -		   0, TRUE, DUPLICATE_SAME_ACCESS);
> +  if (!DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
> +			GetCurrentProcess (), &h_pcon_out,
> +			0, TRUE, DUPLICATE_SAME_ACCESS))
> +    {
> +      CloseHandle (pcon_owner);
> +      return;
> +    }
>    CloseHandle (pcon_owner);
>    DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
>    DWORD resume_pid =
> @@ -2424,8 +2435,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>  	      if (get_ttyp ()->req_fixup_pcon_cur_pos)
>  		{
>  		  int x, y;
> -		  sscanf (wpbuf, "\033[%d;%dR", &y, &x);
> -		  fixup_pcon_cursor_position (x, y);
> +		  if (sscanf (wpbuf, "\033[%d;%dR", &y, &x) == 2)
> +		    fixup_pcon_cursor_position (x, y);
>  		  get_ttyp ()->req_fixup_pcon_cur_pos = false;
>  		}
>  	      else if (!get_ttyp ()->req_xfer_input)
> -- snap --
> 
> Again, I am sorry for the lack of my presence in this thread!
> 
> Ciao,
> Johannes
> 
> > +		  get_ttyp ()->req_fixup_pcon_cur_pos = false;
> > +		}
> > +	      else if (!get_ttyp ()->req_xfer_input)
> >  		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> >  	      ixput = 0;
> >  	      state = 0;
> > @@ -4100,8 +4169,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
> >  	  ttyp->pcon_activated = false;
> >  	  ttyp->switch_to_nat_pipe = false;
> >  	  ttyp->nat_pipe_owner_pid = 0;
> > -	  ttyp->pcon_start = false;
> > -	  ttyp->pcon_start_pid = 0;
> >  	}
> >        if (ttyp->pcon_handle_ready_event)
> >  	{
> > diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> > index 322592bf1..2fa30cbce 100644
> > --- a/winsup/cygwin/local_includes/fhandler.h
> > +++ b/winsup/cygwin/local_includes/fhandler.h
> > @@ -2533,6 +2533,7 @@ class fhandler_pty_slave: public fhandler_pty_common
> >    void setpgid_aux (pid_t pid);
> >    static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termios *fh);
> >    void replace_nat_handles (HANDLE new_input, HANDLE new_output);
> > +  void req_fixup_pcon_state (void);
> >  };
> >  
> >  #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
> > @@ -2639,6 +2640,7 @@ public:
> >    void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
> >    bool need_send_ctrl_c_event ();
> >    void apply_line_edit_to_transferred_input ();
> > +  void fixup_pcon_cursor_position (int x, int y);
> >  };
> >  
> >  class fhandler_dev_null: public fhandler_base
> > diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
> > index 507f7772e..c5102eb81 100644
> > --- a/winsup/cygwin/local_includes/tty.h
> > +++ b/winsup/cygwin/local_includes/tty.h
> > @@ -145,6 +145,7 @@ private:
> >    xfer_dir pty_input_state;
> >    bool discard_input;
> >    bool stop_fwd_thread;
> > +  bool req_fixup_pcon_cur_pos;
> >  
> >  public:
> >    HANDLE from_master_nat () const { return _from_master_nat; }
> > -- 
> > 2.51.0
> > 
> > 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
