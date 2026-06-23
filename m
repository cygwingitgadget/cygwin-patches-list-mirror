Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id C746F4BA2E05
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 12:29:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C746F4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C746F4BA2E05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782217771; cv=none;
	b=HxCpt+q3RHUvXdG8KXXN1uMce+u6/7hSnwL9o1fTuPVh+aqMEUhxQlbQg5Smb2AOaJfXC90DCDrGngrKIOCJcj62rWmpeZPJ9OeCUuWpbsnVVzSRxVDvB6342lEa79ilRc3uly0zW2bGnmcpGcyozm9ycCTZTXTkCd4cJk6BnfQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782217771; c=relaxed/simple;
	bh=UwtMwY1c3JRsdB6+beGNYeLuWVjHxF4ckLw5LPABtiI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=rJ/vv5Nee3GH1uAfvXaCDZpJh+bAWYMgSsqY2ez7iDLWqacyer0dJdF5At00BJHe3iFijow7Wk0+MeKQvZm++ec0KPYCy7F7rU+oA9VVT9gaC6jOx1ToT+HQNoe7H1n0SDPVyCwwW8I/IYzqlmXeHaZD7dnUWjVtmZGRIxakQAs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NpQWCcSe
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C746F4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NpQWCcSe
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260623122926594.ODMX.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 21:29:26 +0900
Date: Tue, 23 Jun 2026 21:29:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: pty: Fix race issue between starting and
 exiting non-cygwin apps
Message-Id: <20260623212925.b12a2d4dc3c2c52926d44874@nifty.ne.jp>
In-Reply-To: <9e5fa557-3ff1-41c2-8bb0-f09630eb1834@maxrnd.com>
References: <20260613140718.25268-1-takashi.yano@nifty.ne.jp>
	<9e5fa557-3ff1-41c2-8bb0-f09630eb1834@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782217766;
 bh=/zd+itERl/VAiKylX3I1+jHDBuHCL/tpizGsRsX1Cks=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=NpQWCcSedXumndBpqGaV91kc6KKRaJvFYATGQtHPpkpSpt74WRgn6xDAkEhUDt4cd/VU6tQw
 T+D4QUUN+OTpAsiu1fm46WWhXua94QvzQR9NRsVI3beoHXXFZbdN7VdRqDpa4H4ZAIevZxr9Pa
 ArytAzPpXYQ2P8MlXhPI1Bc7jRzHOqdQNUzK++HDYR9kAE4IvJyPVYvYt8TTM06r8pTOsGN5xl
 mLWmq14JyxgOtqaHywvxpSRb5a74fpeAJbp+d3Xr2GSMDXAoViXEzhlPp8mxqAtE0cabjNFTho
 h0/BB5jw931nmxPCvs9wxpKx1TE9E1/JY/J6TPQS5PauYgjw==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for reviewing!

On Tue, 23 Jun 2026 00:31:39 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/13/2026 7:07 AM, Takashi Yano wrote:
> > Currently, when a non-cygwin program (A) is about to exit, and another
> > non-cygwin program (B) is started, input transferring between cyg-pipe
> > and nan-pipe may not work as expected. When the non-cygwin program (A)
>        ^^^
> > exits, input transferring from nat-pipe to cyg-pipe will be performed.
> > However, the the non-cygwin program (B) will performs input transferring
> > from cyg-pipe to nat-pipe at the same time.
> 
> I'm having some trouble understanding whether the above block all 
> describes past (before patch) operation, or whether it shifts in the 
> middle to discuss after patch operation.

This part describes the behavioour before this patch.

> Also, is there a simple example of this situation you could add?  Is the 
> case of a (Cygwin) shell launching two foreground Windows programs one 
> after the other a possible example?

The following code demonstrates the issue.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int n = 1;
	if (argc > 1)
		n = atoi(argv[1]);
	if (fork()) {
		execlp("cmd.exe", "cmd", NULL);
		perror("execlp(\"cmd\"): ");
	}
	for (int i=0; i<n; i++) {
		if (fork() == 0) {
			execlp("./non-cygwin-app.exe", "non-cygwin-app", "0", NULL);
			perror("execlp(\"non^cygwin-app\"): ");
		}
	}
	return 0;
}

> 
> >   1) The the non-cygwin program (A) checks current input pipe state,
> >      then it is nat-pip since the this program is a non-cygwin program.
>                    ^^^^^^^
> >      The program (A) also checkes if any handover target exists, but
>                              ^^^^^^^
> >      it is not found since the probram (B) is not started yet. So,
>                                   ^^^^^^^
> >      the program (A) decided to transfer input form nat-pipe to cyg-
> >      pipe.
> >   2) Before the non-cygwin (A) program performs input transferring,
> >      if the non-cygwin program (B) is started and checks the input
> >      pipe state, it is nat-pipe state, so the non-cygwin program (B)
> >      does not perform input transferring.
> >   3) However, just after that, the non-cygwin program (A) performs
> >      input transferring from nat-pipe to cyg-pipe, so typeahead input
> >      will be stored in cyg-pipe.
> >   4) The non-cygwin program (B) cannot read the typeahead input
> >      because it is now in the cyg-pipe.
> 
> Maybe I do understand now.  The above is a sequence of steps to 
> demonstrate the issue being fixed.  Am I correct?  And the below 
> describes root cause and how it is fixed?

Right. I'll make the description clearer.

> > Transferring input itself is guarded by input_mutex, but the pre-
> > check is not. With this patch, the guard is enhanced so that the
> > state check and tranferring input are done in atomic way.
>                    ^^^^^^^^^^^
> > 
> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
>                                              ^^^^^^^^^^ do not correct.. 
> if same in original
> 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> > v2: Guard term_has_pcon_cap() as well
> > v3: Acquire pipe_sw_mutex first before acquiring input_mutex
> > v4: Don't call to_be_read_from_nat_pipe() while holding input_mutex
> >      (This simplifies the to_be_read_from_nat_pipe())
> > v5: Don't wait pcon_handle_ready_event in req_xfer_input is set.
> >      In pcon_start mode, send input data except for response to CSI6n
> >      and CSI c to nat-pipe (to_slave_nat) rather than line_edit() if
> >      pipe state is tty::to_nat (this happens when req_xfer_input mode).
> > 
> >   winsup/cygwin/fhandler/pty.cc | 110 ++++++++++++++++++----------------
> >   1 file changed, 57 insertions(+), 53 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index e0fc67ae1..17bef7ea4 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -657,8 +657,7 @@ fhandler_pty_master::accept_input ()
> >   
> >     HANDLE write_to = get_output_handle ();
> >     tmp_pathbuf tp;
> > -  if (to_be_read_from_nat_pipe ()
> > -      && get_ttyp ()->pty_input_state == tty::to_nat)
> > +  if (get_ttyp ()->pty_input_state == tty::to_nat)
> >       {
> >         /* This code is reached if non-cygwin app is foreground and
> >   	 pseudo console is not enabled. */
> > @@ -1274,18 +1273,18 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
> >   	  mutex_timeout = INFINITE;
> >   	  if (isHybrid)
> >   	    {
> > +	      WaitForSingleObject (input_mutex, mutex_timeout);
> >   	      if (get_ttyp ()->getpgid () == myself->pgid
> >   		  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
> >   		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
> >   		{
> > -		  WaitForSingleObject (input_mutex, mutex_timeout);
> >   		  acquire_attach_mutex (mutex_timeout);
> >   		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
> >   				  input_available_event,
> >   				  input_transferred_to_cyg);
> >   		  release_attach_mutex ();
> > -		  ReleaseMutex (input_mutex);
> >   		}
> > +	      ReleaseMutex (input_mutex);
> >   	      if (get_ttyp ()->master_is_running_as_service
> >   		  && get_ttyp ()->pcon_activated)
> >   		/* If the master is running as service, re-attaching to
> > @@ -1452,19 +1451,10 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
> >   bool
> >   fhandler_pty_common::to_be_read_from_nat_pipe (void)
> >   {
> > -  /* If the slave is in setup_pseudoconsole(), pipe_sw_mutex cannot
> > -     be acquired because the slave has it. In this case pcon_start
> > -     will be asserted. During pcon_start, other input than response
> > -     to CSI6n should be go to cyg-pipe. So, wait for pcon_start and
> > -     return false. */
> > -  while (WaitForSingleObject (pipe_sw_mutex, 0) == WAIT_TIMEOUT)
> > -    if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c
> > -	|| get_ttyp ()->pcon_start_pid)
> > -      return false;
> > -    else
> > -      yield ();
> > -
> >     bool ret = false;
> > +
> > +  WaitForSingleObject (pipe_sw_mutex, INFINITE);
> > +
> 
> I am a little concerned if the replacement WFSO is equivalent to the 
> looping WFSO being replaced.  I.e., it terminates for the same 
> condition(s) with the pty being in correct state.  I can't point to 
> something specific though.  Can you reassure me?  Or is this just 
> re-establishing code to the way it was before?

The code before the patch intended to leave wait-loop when pcon_start
mode is set even though the pipe_sw_mutex was not acquired. With this
patch, to_be_read_from_nat_pipe() is not called from master::write()
anymore, so the busy-loop is not necessary due to changes below.

@@ -2496,7 +2519,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
@@ -2580,20 +2603,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)


> >     if (!get_ttyp ()->switch_to_nat_pipe)
> >       goto out;
> >   
> > @@ -2383,6 +2373,26 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   
> >     int pcon_start_mode =
> >       get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : 0);
> > +
> > +  /* This input transfer is needed when cygwin-app which is started from
> > +     non-cygwin app is terminated if pseudo console is disabled. */
>                                       ^^ maybe change "if" to "while" here
> 
> > +  if (!get_ttyp ()->pcon_activated && !pcon_start_mode
> > +      && to_be_read_from_nat_pipe ())
> > +    {
> > +      WaitForSingleObject (input_mutex, mutex_timeout);
> > +      if (get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
> > +	  && get_ttyp ()->pty_input_state == tty::to_cyg)
> > +	{
> > +	  acquire_attach_mutex (mutex_timeout);
> > +	  fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> > +					      get_ttyp (),
> > +					      input_available_event,
> > +					      input_transferred_to_cyg);
> > +	  release_attach_mutex ();
> > +	}
> > +      ReleaseMutex (input_mutex);
> > +    }
> > +
> >     if (pcon_start_mode)
> >       { /* Reaches here when pseudo console initialization is on going. */
> >         /* Pseudo condole support uses "CSI6n" to get cursor position.
> > @@ -2404,7 +2414,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   	  if (p[i] == '\033')
> >   	    {
> >   	      if (ixput)
> > -		line_edit (wpbuf, ixput, ti, &ret);
> > +		{
> > +		  if (get_ttyp ()->req_xfer_input
> > +		      && get_ttyp ()->pty_input_state_eq (tty::to_nat))
> > +		    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> > +		  else
> > +		    line_edit (wpbuf, ixput, ti, &ret);
> > +		}
> >   	      ixput = 0;
> >   	      state = 1;
> >   	      wp_tid = _my_tls.thread_id;
> > @@ -2422,7 +2438,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   		}
> >   	    }
> >   	  else
> > -	    line_edit (p + i, 1, ti, &ret);
> > +	    {
> > +	      if (get_ttyp ()->req_xfer_input
> > +		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
> > +		WriteFile (to_slave_nat, p + i, 1, &n, NULL);
> > +	      else
> > +		line_edit (p + i, 1, ti, &ret);
> > +	    }
> 
> It is unfortunate we have the two line_edit() calls above now being 
> wrapped in almost identical fashion in two different locations.  I can't 
> think of a way to pretty this, other than adding a couple of parameters 
> to line_edit() and changing all the other calling sites to pass zeroes.
> Maybe you have another idea?  But no need to spend much time on it.

I'll add a simple function line_edit_maybe() to fhandler_pty_master class
to avoid code duplication.

> >   	  len = orig_len - i - 1;
> >   	  ptr = p + i + 1;
> >   	  if (state == 1 && wp_tid == _my_tls.thread_id && p[i] == 'R')
> > @@ -2454,6 +2476,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >         if (pcon_start_mode
> >   	  && !get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
> >   	{ /* Pseudo console initialization has been done in above code. */
> > +	  WaitForSingleObject (input_mutex, mutex_timeout);
> >   	  pinfo pp (get_ttyp ()->pcon_start_pid);
> >   	  if (get_ttyp ()->switch_to_nat_pipe
> >   	      && pp && pp->pgid == get_ttyp ()->getpgid ()
> > @@ -2463,8 +2486,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   		{
> >   		  HANDLE pcon_handle_ready_event =
> >   		    get_ttyp ()->pcon_handle_ready_event;
> > -		  get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> > -					   pcon_handle_ready_event);
> > +		  pcon_handle_ready_event =
> > +		    get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> > +					     pcon_handle_ready_event);
> >   		  if (pcon_handle_ready_event)
> >   		    {
> >   		      cygwait (pcon_handle_ready_event, INFINITE);
> > @@ -2475,7 +2499,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   
> >   	      /* This accept_input() call is needed in order to transfer input
> >   		 which is not accepted yet to non-cygwin pipe. */
> > -	      WaitForSingleObject (input_mutex, mutex_timeout);
> >   	      if (get_readahead_valid ())
> >   		accept_input ();
> >   	      acquire_attach_mutex (mutex_timeout);
> > @@ -2484,9 +2507,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   						  input_available_event,
> >   						  input_transferred_to_cyg);
> >   	      release_attach_mutex ();
> > -	      ReleaseMutex (input_mutex);
> >   	    }
> >   	  get_ttyp ()->req_xfer_input = false;
> > +	  ReleaseMutex (input_mutex);
> >   	  get_ttyp ()->pcon_start_pid = 0;
> >   	}
> >         if (len == 0)
> > @@ -2496,7 +2519,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >     /* Write terminal input to to_slave_nat pipe instead of output_handle
> >        if current application is native console application. */
> >     WaitForSingleObject (input_mutex, mutex_timeout);
> > -  if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
> > +  if (get_ttyp ()->pcon_activated
> >         && get_ttyp ()->pty_input_state == tty::to_nat)
> >       { /* Reaches here when non-cygwin app is foreground and pseudo console
> >   	 is activated. */
> > @@ -2580,20 +2603,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >     /* The code path reaches here when pseudo console is not activated
> >        or cygwin process is foreground even though pseudo console is
> >        activated. */
> > -
> > -  /* This input transfer is needed when cygwin-app which is started from
> > -     non-cygwin app is terminated if pseudo console is disabled. */
> > -  if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
> > -      && get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
> > -      && get_ttyp ()->pty_input_state == tty::to_cyg)
> > -    {
> > -      acquire_attach_mutex (mutex_timeout);
> > -      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> > -					  get_ttyp (), input_available_event,
> > -					  input_transferred_to_cyg);
> > -      release_attach_mutex ();
> > -    }
> > -
> >     line_edit_status status = line_edit (p, len, ti, &ret);
> >     ReleaseMutex (input_mutex);
> >   
> > @@ -4537,9 +4546,9 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
> >   					      const WCHAR *envblock,
> >   					      bool stdin_is_ptys)
> >   {
> > +  WaitForSingleObject (pipe_sw_mutex, INFINITE);
> >     if (disable_pcon || !term_has_pcon_cap (envblock))
> >       nopcon = true;
> > -  WaitForSingleObject (pipe_sw_mutex, INFINITE);
> >     /* Setting switch_to_nat_pipe is necessary even if pseudo console
> >        will not be activated. */
> >     fhandler_base *fh = ::cygheap->fdtab[0];
> > @@ -4555,16 +4564,16 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
> >       pcon_enabled = setup_pseudoconsole ();
> >     ReleaseMutex (pipe_sw_mutex);
> >     /* For pcon enabled case, transfer_input() is called in master::write() */
> > +  WaitForSingleObject (input_mutex, mutex_timeout);
> >     if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
> >         && stdin_is_ptys && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
> >       {
> > -      WaitForSingleObject (input_mutex, mutex_timeout);
> >         acquire_attach_mutex (mutex_timeout);
> >         transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> >   		      input_available_event, input_transferred_to_cyg);
> >         release_attach_mutex ();
> > -      ReleaseMutex (input_mutex);
> >       }
> > +  ReleaseMutex (input_mutex);
> >   }
> >   
> >   void
> > @@ -4573,22 +4582,22 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
> >   						DWORD force_switch_to)
> >   {
> >     ttyp->wait_fwd ();
> > +  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
> > +  WaitForSingleObject (p->input_mutex, mutex_timeout);
> >     if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
> >       {
> >         DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
> >         if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
> >   	  && ttyp->pty_input_state_eq (tty::to_nat))
> >   	{
> > -	  WaitForSingleObject (p->input_mutex, mutex_timeout);
> >   	  acquire_attach_mutex (mutex_timeout);
> >   	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
> >   			  p->input_available_event,
> >   			  p->input_transferred_to_cyg);
> >   	  release_attach_mutex ();
> > -	  ReleaseMutex (p->input_mutex);
> >   	}
> >       }
> > -  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
> > +  ReleaseMutex (p->input_mutex);
> >     if (ttyp->pcon_activated)
> >       close_pseudoconsole (ttyp, force_switch_to);
> >     else
> > @@ -4602,27 +4611,23 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
> >     reset_switch_to_nat_pipe ();
> >   
> >     WaitForSingleObject (pipe_sw_mutex, INFINITE);
> > +  WaitForSingleObject (input_mutex, mutex_timeout);
> >     bool was_nat_fg = get_ttyp ()->nat_fg (tc ()->pgid);
> >     bool nat_fg = get_ttyp ()->nat_fg (pid);
> >     if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
> >         && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
> >       {
> > -      ReleaseMutex (pipe_sw_mutex);
> > -      WaitForSingleObject (input_mutex, mutex_timeout);
> >         acquire_attach_mutex (mutex_timeout);
> >         transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> >   		      input_available_event, input_transferred_to_cyg);
> >         release_attach_mutex ();
> > -      ReleaseMutex (input_mutex);
> >       }
> >     else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
> >   	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
> >       {
> > -      ReleaseMutex (pipe_sw_mutex);
> >         bool attach_restore = false;
> >         HANDLE from = get_handle_nat ();
> >         DWORD resume_pid = 0;
> > -      WaitForSingleObject (input_mutex, mutex_timeout);
> >         if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
> >   	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
> >   	{
> > @@ -4640,10 +4645,9 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
> >   	resume_from_temporarily_attach (resume_pid);
> >         else
> >   	release_attach_mutex ();
> > -      ReleaseMutex (input_mutex);
> >       }
> > -  else
> > -    ReleaseMutex (pipe_sw_mutex);
> > +  ReleaseMutex (input_mutex);
> > +  ReleaseMutex (pipe_sw_mutex);
> >   }
> >   
> >   bool
> > @@ -4653,8 +4657,8 @@ fhandler_pty_master::need_send_ctrl_c_event ()
> >        apps will be done in pseudo console, therefore, sending it in
> >        fhandler_pty_master::write() duplicates that event for non-cygwin
> >        apps. So return false if pseudo console is activated. */
> > -  return !(to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
> > -    && get_ttyp ()->pty_input_state == tty::to_nat);
> > +  return !(get_ttyp ()->pcon_activated
> > +	   && get_ttyp ()->pty_input_state == tty::to_nat);
> >   }
> >   
> >   void
> 
> The rest LGTM.  Let me know what you think about my comments.

I'll submit the v6 patch that incorporates your comments.
Could you please kindly check v6 patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
