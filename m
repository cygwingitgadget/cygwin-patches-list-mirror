Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 775784BA2E07
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 13:09:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 775784BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 775784BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782824992; cv=none;
	b=YRz8NsLTGz93dVYhbwlzxBEovG5Kg/80liT+jpjGX1Hp2TcFw9wz0/9Nwt0sTT/DL4ERPRWb5QzL1NsZqUiuUIiHJ6tMWNWKrBQf0epA1koTbXVnhrYJr+GXbOcciL1mfB3TKeC1RbfLh1jAWhKjrq01RzOCKGtnO95EfMjiSXk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782824992; c=relaxed/simple;
	bh=6mY7SFGWOqALY/JnKsetuJ8T6tAQzSy22vCGkqKlqZM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=rL60Vq/KDd4iob/tuhlRMJF8jwT+c5XXf5X2zjaI571f/A4YkVD1ueFiI1G0HyIewHZmG2xGiplWMls1H9u6eimPEDWbkWXaX+NqO3VndmU9HBM8h6Ln7ZElCFRJwzxiJ7GuDi8B7ZjfyrewOuU/O245VXv2bSouB1yNxvRr+JQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NhVVwmlo
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 775784BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NhVVwmlo
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260630130948006.WHJX.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 22:09:48 +0900
Date: Tue, 30 Jun 2026 22:09:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app
 exits
Message-Id: <20260630220946.0a48b86844d9a450059f706c@nifty.ne.jp>
In-Reply-To: <20260630173659.6fef765e6d60dd2c54e42796@nifty.ne.jp>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
	<20260613140917.27155-4-takashi.yano@nifty.ne.jp>
	<b9c76c12-c300-69c1-b6e3-5b03396ed8e0@gmx.de>
	<20260630173659.6fef765e6d60dd2c54e42796@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782824988;
 bh=Snu7J68cLQTldqAJWDz1SlpS6U1kao5S25NRTuvchIE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=NhVVwmlo1ncG6eF/In0dCZeF/7jTYr9N7vP23gYk2ui2mx4+9Yy7QwM+Qfp2N4B3f861Lf5b
 04W4lhRrdSgf+euaCO3Rd7gP7LGWi9WrhB0UZhWudeQZHW1vtr6lK5SRaXntZzCIjH4IDmsK3m
 M2MB/VjppbXsqSJjPCAONoMMCllX3kWkLxLm605SgV/hFEE4fO7HRvJxlofopep3LvDkZ/32xY
 4RyzeXVZ+/jhIj/eo3OB5hRFFSaGyRLO0UvAvpQssPPu/0FJjCExiiv1qsHsZhj0dFrv8GMhvL
 HHK8G+9Rx/N7n+438ciclQxLRg0Mctto6wFlDVYHXCkLfVrA==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

As for the first patch, a small fix is necessary as below.
With the fix, the patch LGTM. Pushed to master.

Thanks!

On Tue, 30 Jun 2026 17:36:59 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> The second and the third patches of your three additional patches LGTM.
> Pushed to master.
> Thanks!
> 
> I'm reviewing the first one. Please wait.
> 
> On Sat, 27 Jun 2026 09:18:41 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi, Mark,
> > 
> > I had started working on those patches, been pulled away, and meant coming
> > back to them but failed. The work was tracked in
> > https://github.com/git-for-windows/msys2-runtime/pull/131, but I
> > admittedly did not find the time to complete the work earlier.
> > 
> > There are fixes in that PR (in addition to UI tests based on AutoHotKey
> > that helped me catch a couple of bugs) for the following three issues:
> > 
> > 
> > On Sat, 13 Jun 2026, Takashi Yano wrote:
> > 
> > > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > > index b3a8d57cc..f4473bb69 100644
> > > --- a/winsup/cygwin/fhandler/pty.cc
> > > +++ b/winsup/cygwin/fhandler/pty.cc
> > > @@ -388,6 +388,52 @@ atexit_func (void)
> > >      }
> > >  }
> > >  
> > > +void
> > > +fhandler_pty_slave::req_fixup_pcon_state (void)
> > > +{
> > > +  while (true)
> > > +    {
> > > +      WaitForSingleObject (input_mutex, mutex_timeout);
> > > +      if (!get_ttyp ()->pcon_start_pid)
> > > +	break;
> > > +      /* Another request is on going. */
> > > +      ReleaseMutex (input_mutex);
> > > +      yield ();
> > > +    }
> > > +
> > > +  DWORD n;
> > > +  /* indicates that this "ESC[6n" is just for fixing-up corsor position */
> > > +  get_ttyp ()->req_fixup_pcon_cur_pos = true;
> > > +  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
> > > +					 is just for transfer input */
> > > +  get_ttyp ()->pcon_start = true;
> > > +  get_ttyp ()->pcon_start_pid = myself->pid;
> > > +  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
> > > +  ReleaseMutex (input_mutex);
> > > +  while (get_ttyp ()->pcon_start_pid)
> > > +    /* wait for completion of fixing-up in master::write(). */
> > > +    yield ();
> > 
> > Both of these loops are unbounded, and both depend on somebody else
> > clearing `pcon_start_pid`. If the master never replies (terminal closing,
> > broken pipe, or the previous requester died mid-handshake), the exiting
> > process spins forever in the second loop, and a stale slot wedges the next
> > exiting process in the first one. This commit also drops the
> > `pcon_start_pid = 0` reset that `close_pseudoconsole()` used to do, so the
> > stale-slot case is no longer self-healing across pcon teardown either.
> > 
> > Bounding both waits with a 3-second `GetTickCount64()` deadline, clearing
> > our own `pcon_start_pid` on timeout only if it is still ours, and
> > restoring the `close_pseudoconsole()` reset as a backstop makes the
> > pathological case degrade to a slightly stale cursor rather than a hung
> > exit.
> > 
> > The fix I would propose is in
> > https://github.com/git-for-windows/msys2-runtime/pull/131/changes/c366a1c02e66a242a3437f6b9335c2319c095c92:
> > 
> > -- snip --
> > From c366a1c02e66a242a3437f6b9335c2319c095c92 Mon Sep 17 00:00:00 2001
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Date: Thu, 25 Jun 2026 13:41:42 +0200
> > Subject: [PATCH] Cygwin: pty: bound the cursor-sync round-trip so an exiting
> >  process cannot hang
> > 
> > The cursor-position fixup added in "Cygwin: pty: Fixup pty state after
> > a cygwin app exits" runs from cleanup() on every foreground Cygwin-app
> > exit while a pseudo console is active, and it waits on two unbounded
> > loops for the master to answer the "ESC[6n" it just sent: one that
> > spins until the pcon_start_pid slot is free, and one that spins until
> > the master clears the slot again. pcon_start_pid is only ever cleared
> > once master::write() parses the terminal's reply, so if that reply
> > never comes, because the terminal is going away, the forwarding pipe
> > is broken, or a previous requester died mid-handshake, the exiting
> > process spins on yield() forever and never exits.
> > 
> > Bound both waits with a three second deadline using GetTickCount64(),
> > and on timeout clear our own pcon_start_pid slot, but only if it is
> > still ours, so a give-up does not stomp a later requester. Also restore
> > the pcon_start and pcon_start_pid reset that the same commit removed
> > from close_pseudoconsole(); it is the backstop that keeps a requester
> > which died without clearing its slot from wedging the next one. The
> > worst case is now a slightly stale cursor after a timeout rather than a
> > process that refuses to exit.
> > 
> > Fixes: b34394d456b6 ("Cygwin: pty: Fixup pty state after a cygwin app exits")
> > Assisted-by: Opus 4.8
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index c79fd1f975..669e18238b 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -226,6 +226,7 @@ atexit_func (void)
> >  void
> >  fhandler_pty_slave::req_fixup_pcon_state (void)
> >  {
> > +  ULONGLONG deadline = GetTickCount64 () + 3000;
> >    while (true)
> >      {
> >        WaitForSingleObject (input_mutex, mutex_timeout);
> > @@ -233,6 +234,10 @@ fhandler_pty_slave::req_fixup_pcon_state (void)
> >  	break;
> >        /* Another request is on going. */
> >        ReleaseMutex (input_mutex);
> > +      if (GetTickCount64 () > deadline)
> > +	/* A previous requester is stuck; give up this sync rather than
> > +	   spin forever. */
> > +	return;
> >        yield ();
> >      }
> >  
> > @@ -245,9 +250,25 @@ fhandler_pty_slave::req_fixup_pcon_state (void)
> >    get_ttyp ()->pcon_start_pid = myself->pid;
> >    WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
> >    ReleaseMutex (input_mutex);
> > -  while (get_ttyp ()->pcon_start_pid)
> > +  deadline = GetTickCount64 () + 3000;
> > +  while (get_ttyp ()->pcon_start_pid && GetTickCount64 () <= deadline)
> >      /* wait for completion of fixing-up in master::write(). */
> >      yield ();
> > +  /* If the master never answered (e.g. the terminal is going away),
> > +     clear our own request so a stale pcon_start_pid cannot wedge the
> > +     next requester. */
> > +  if (get_ttyp ()->pcon_start_pid == (pid_t) myself->pid)
> > +    {
> > +      WaitForSingleObject (input_mutex, mutex_timeout);
> > +      if (get_ttyp ()->pcon_start_pid == (pid_t) myself->pid)
> > +	{
> > +	  get_ttyp ()->req_fixup_pcon_cur_pos = false;
> > +	  get_ttyp ()->req_xfer_input = false;
> > +	  get_ttyp ()->pcon_start = false;
> > +	  get_ttyp ()->pcon_start_pid = 0;
> > +	}
> > +      ReleaseMutex (input_mutex);
> > +    }
> >  }
> >  
> >  void
> > @@ -4007,6 +4028,10 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
> >  	  ttyp->pcon_activated = false;
> >  	  ttyp->switch_to_nat_pipe = false;
> >  	  ttyp->nat_pipe_owner_pid = 0;
> > +	  /* Safety net: if a req_fixup_pcon_state() requester died without
> > +	     clearing its slot, do not leave pcon_start_pid set forever. */
> > +	  ttyp->pcon_start = false;
> > +	  ttyp->pcon_start_pid = 0;
> >  	}
> >        if (ttyp->pcon_handle_ready_event)
> >  	{

Clearing pcon_start and pcon_start_pid unconditionally here is
not correct. The request from the other process may be active.
Therefore, this should be:
@@ -4228,6 +4249,13 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
          ttyp->pcon_activated = false;
          ttyp->switch_to_nat_pipe = false;
          ttyp->nat_pipe_owner_pid = 0;
+         /* Safety net: if a req_fixup_pcon_state() requester died without
+            clearing its slot, do not leave pcon_start_pid set forever. */
+         if (ttyp->pcon_start_pid == myself->pid)
+           {
+             ttyp->pcon_start = false;
+             ttyp->pcon_start_pid = 0;
+           }
        }
       if (ttyp->pcon_handle_ready_event)
        {

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
