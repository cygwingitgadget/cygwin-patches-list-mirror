Return-Path: <SRS0=gf06=ET=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 4462D4BA5439
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 07:31:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4462D4BA5439
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4462D4BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782199900; cv=none;
	b=RDCERNvqPealOgjDdj6D2KOLrWmnhQaUxdroj8IHPsOT1d81qZ5YOVT3dtaiMtJ46cLCKXLEHq7al78wRrTs8HEjFT7mn//UjE3VpPwq6H3tIkR3Cee9BRX1GFzFCIkAvt4LROTtwxP3LtuyGhnPA+XjcmhUjNxVDxj+m57Nd1w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782199900; c=relaxed/simple;
	bh=JwUnuzwmyHhXAMV4oBy54MaqRYhQuRFiZnJRNCLVoD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=hZVrtF/3VSOUEyiKScmkbSMaGFkoZeRAPWX1+wDzq42V44OsUelfSgPPADcNt9fO+N7Mu7znIhNYH66CqlaZIbSH82X3lH3eItXta3l6A+C7SHG1r5zjy9AKbr23UN3G8py0cSJZbqna6O88KAAiiYSy41zwI6x5CoNbEz/3eJ0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4462D4BA5439
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65N7kdH1016506
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 00:46:39 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdLdd5Bu; Tue Jun 23 00:46:33 2026
Message-ID: <9e5fa557-3ff1-41c2-8bb0-f09630eb1834@maxrnd.com>
Date: Tue, 23 Jun 2026 00:31:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Cygwin: pty: Fix race issue between starting and
 exiting non-cygwin apps
To: cygwin-patches@cygwin.com
References: <20260613140718.25268-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260613140718.25268-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/13/2026 7:07 AM, Takashi Yano wrote:
> Currently, when a non-cygwin program (A) is about to exit, and another
> non-cygwin program (B) is started, input transferring between cyg-pipe
> and nan-pipe may not work as expected. When the non-cygwin program (A)
       ^^^
> exits, input transferring from nat-pipe to cyg-pipe will be performed.
> However, the the non-cygwin program (B) will performs input transferring
> from cyg-pipe to nat-pipe at the same time.

I'm having some trouble understanding whether the above block all 
describes past (before patch) operation, or whether it shifts in the 
middle to discuss after patch operation.

Also, is there a simple example of this situation you could add?  Is the 
case of a (Cygwin) shell launching two foreground Windows programs one 
after the other a possible example?

>   1) The the non-cygwin program (A) checks current input pipe state,
>      then it is nat-pip since the this program is a non-cygwin program.
                   ^^^^^^^
>      The program (A) also checkes if any handover target exists, but
                             ^^^^^^^
>      it is not found since the probram (B) is not started yet. So,
                                  ^^^^^^^
>      the program (A) decided to transfer input form nat-pipe to cyg-
>      pipe.
>   2) Before the non-cygwin (A) program performs input transferring,
>      if the non-cygwin program (B) is started and checks the input
>      pipe state, it is nat-pipe state, so the non-cygwin program (B)
>      does not perform input transferring.
>   3) However, just after that, the non-cygwin program (A) performs
>      input transferring from nat-pipe to cyg-pipe, so typeahead input
>      will be stored in cyg-pipe.
>   4) The non-cygwin program (B) cannot read the typeahead input
>      because it is now in the cyg-pipe.

Maybe I do understand now.  The above is a sequence of steps to 
demonstrate the issue being fixed.  Am I correct?  And the below 
describes root cause and how it is fixed?

> Transferring input itself is guarded by input_mutex, but the pre-
> check is not. With this patch, the guard is enhanced so that the
> state check and tranferring input are done in atomic way.
                   ^^^^^^^^^^^
> 
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
                                             ^^^^^^^^^^ do not correct.. 
if same in original

> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
> v2: Guard term_has_pcon_cap() as well
> v3: Acquire pipe_sw_mutex first before acquiring input_mutex
> v4: Don't call to_be_read_from_nat_pipe() while holding input_mutex
>      (This simplifies the to_be_read_from_nat_pipe())
> v5: Don't wait pcon_handle_ready_event in req_xfer_input is set.
>      In pcon_start mode, send input data except for response to CSI6n
>      and CSI c to nat-pipe (to_slave_nat) rather than line_edit() if
>      pipe state is tty::to_nat (this happens when req_xfer_input mode).
> 
>   winsup/cygwin/fhandler/pty.cc | 110 ++++++++++++++++++----------------
>   1 file changed, 57 insertions(+), 53 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index e0fc67ae1..17bef7ea4 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -657,8 +657,7 @@ fhandler_pty_master::accept_input ()
>   
>     HANDLE write_to = get_output_handle ();
>     tmp_pathbuf tp;
> -  if (to_be_read_from_nat_pipe ()
> -      && get_ttyp ()->pty_input_state == tty::to_nat)
> +  if (get_ttyp ()->pty_input_state == tty::to_nat)
>       {
>         /* This code is reached if non-cygwin app is foreground and
>   	 pseudo console is not enabled. */
> @@ -1274,18 +1273,18 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
>   	  mutex_timeout = INFINITE;
>   	  if (isHybrid)
>   	    {
> +	      WaitForSingleObject (input_mutex, mutex_timeout);
>   	      if (get_ttyp ()->getpgid () == myself->pgid
>   		  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
>   		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
>   		{
> -		  WaitForSingleObject (input_mutex, mutex_timeout);
>   		  acquire_attach_mutex (mutex_timeout);
>   		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
>   				  input_available_event,
>   				  input_transferred_to_cyg);
>   		  release_attach_mutex ();
> -		  ReleaseMutex (input_mutex);
>   		}
> +	      ReleaseMutex (input_mutex);
>   	      if (get_ttyp ()->master_is_running_as_service
>   		  && get_ttyp ()->pcon_activated)
>   		/* If the master is running as service, re-attaching to
> @@ -1452,19 +1451,10 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
>   bool
>   fhandler_pty_common::to_be_read_from_nat_pipe (void)
>   {
> -  /* If the slave is in setup_pseudoconsole(), pipe_sw_mutex cannot
> -     be acquired because the slave has it. In this case pcon_start
> -     will be asserted. During pcon_start, other input than response
> -     to CSI6n should be go to cyg-pipe. So, wait for pcon_start and
> -     return false. */
> -  while (WaitForSingleObject (pipe_sw_mutex, 0) == WAIT_TIMEOUT)
> -    if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c
> -	|| get_ttyp ()->pcon_start_pid)
> -      return false;
> -    else
> -      yield ();
> -
>     bool ret = false;
> +
> +  WaitForSingleObject (pipe_sw_mutex, INFINITE);
> +

I am a little concerned if the replacement WFSO is equivalent to the 
looping WFSO being replaced.  I.e., it terminates for the same 
condition(s) with the pty being in correct state.  I can't point to 
something specific though.  Can you reassure me?  Or is this just 
re-establishing code to the way it was before?

>     if (!get_ttyp ()->switch_to_nat_pipe)
>       goto out;
>   
> @@ -2383,6 +2373,26 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   
>     int pcon_start_mode =
>       get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : 0);
> +
> +  /* This input transfer is needed when cygwin-app which is started from
> +     non-cygwin app is terminated if pseudo console is disabled. */
                                      ^^ maybe change "if" to "while" here

> +  if (!get_ttyp ()->pcon_activated && !pcon_start_mode
> +      && to_be_read_from_nat_pipe ())
> +    {
> +      WaitForSingleObject (input_mutex, mutex_timeout);
> +      if (get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
> +	  && get_ttyp ()->pty_input_state == tty::to_cyg)
> +	{
> +	  acquire_attach_mutex (mutex_timeout);
> +	  fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> +					      get_ttyp (),
> +					      input_available_event,
> +					      input_transferred_to_cyg);
> +	  release_attach_mutex ();
> +	}
> +      ReleaseMutex (input_mutex);
> +    }
> +
>     if (pcon_start_mode)
>       { /* Reaches here when pseudo console initialization is on going. */
>         /* Pseudo condole support uses "CSI6n" to get cursor position.
> @@ -2404,7 +2414,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   	  if (p[i] == '\033')
>   	    {
>   	      if (ixput)
> -		line_edit (wpbuf, ixput, ti, &ret);
> +		{
> +		  if (get_ttyp ()->req_xfer_input
> +		      && get_ttyp ()->pty_input_state_eq (tty::to_nat))
> +		    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> +		  else
> +		    line_edit (wpbuf, ixput, ti, &ret);
> +		}
>   	      ixput = 0;
>   	      state = 1;
>   	      wp_tid = _my_tls.thread_id;
> @@ -2422,7 +2438,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   		}
>   	    }
>   	  else
> -	    line_edit (p + i, 1, ti, &ret);
> +	    {
> +	      if (get_ttyp ()->req_xfer_input
> +		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
> +		WriteFile (to_slave_nat, p + i, 1, &n, NULL);
> +	      else
> +		line_edit (p + i, 1, ti, &ret);
> +	    }

It is unfortunate we have the two line_edit() calls above now being 
wrapped in almost identical fashion in two different locations.  I can't 
think of a way to pretty this, other than adding a couple of parameters 
to line_edit() and changing all the other calling sites to pass zeroes.
Maybe you have another idea?  But no need to spend much time on it.

>   	  len = orig_len - i - 1;
>   	  ptr = p + i + 1;
>   	  if (state == 1 && wp_tid == _my_tls.thread_id && p[i] == 'R')
> @@ -2454,6 +2476,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>         if (pcon_start_mode
>   	  && !get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
>   	{ /* Pseudo console initialization has been done in above code. */
> +	  WaitForSingleObject (input_mutex, mutex_timeout);
>   	  pinfo pp (get_ttyp ()->pcon_start_pid);
>   	  if (get_ttyp ()->switch_to_nat_pipe
>   	      && pp && pp->pgid == get_ttyp ()->getpgid ()
> @@ -2463,8 +2486,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   		{
>   		  HANDLE pcon_handle_ready_event =
>   		    get_ttyp ()->pcon_handle_ready_event;
> -		  get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> -					   pcon_handle_ready_event);
> +		  pcon_handle_ready_event =
> +		    get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> +					     pcon_handle_ready_event);
>   		  if (pcon_handle_ready_event)
>   		    {
>   		      cygwait (pcon_handle_ready_event, INFINITE);
> @@ -2475,7 +2499,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   
>   	      /* This accept_input() call is needed in order to transfer input
>   		 which is not accepted yet to non-cygwin pipe. */
> -	      WaitForSingleObject (input_mutex, mutex_timeout);
>   	      if (get_readahead_valid ())
>   		accept_input ();
>   	      acquire_attach_mutex (mutex_timeout);
> @@ -2484,9 +2507,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   						  input_available_event,
>   						  input_transferred_to_cyg);
>   	      release_attach_mutex ();
> -	      ReleaseMutex (input_mutex);
>   	    }
>   	  get_ttyp ()->req_xfer_input = false;
> +	  ReleaseMutex (input_mutex);
>   	  get_ttyp ()->pcon_start_pid = 0;
>   	}
>         if (len == 0)
> @@ -2496,7 +2519,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>     /* Write terminal input to to_slave_nat pipe instead of output_handle
>        if current application is native console application. */
>     WaitForSingleObject (input_mutex, mutex_timeout);
> -  if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
> +  if (get_ttyp ()->pcon_activated
>         && get_ttyp ()->pty_input_state == tty::to_nat)
>       { /* Reaches here when non-cygwin app is foreground and pseudo console
>   	 is activated. */
> @@ -2580,20 +2603,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>     /* The code path reaches here when pseudo console is not activated
>        or cygwin process is foreground even though pseudo console is
>        activated. */
> -
> -  /* This input transfer is needed when cygwin-app which is started from
> -     non-cygwin app is terminated if pseudo console is disabled. */
> -  if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
> -      && get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
> -      && get_ttyp ()->pty_input_state == tty::to_cyg)
> -    {
> -      acquire_attach_mutex (mutex_timeout);
> -      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> -					  get_ttyp (), input_available_event,
> -					  input_transferred_to_cyg);
> -      release_attach_mutex ();
> -    }
> -
>     line_edit_status status = line_edit (p, len, ti, &ret);
>     ReleaseMutex (input_mutex);
>   
> @@ -4537,9 +4546,9 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
>   					      const WCHAR *envblock,
>   					      bool stdin_is_ptys)
>   {
> +  WaitForSingleObject (pipe_sw_mutex, INFINITE);
>     if (disable_pcon || !term_has_pcon_cap (envblock))
>       nopcon = true;
> -  WaitForSingleObject (pipe_sw_mutex, INFINITE);
>     /* Setting switch_to_nat_pipe is necessary even if pseudo console
>        will not be activated. */
>     fhandler_base *fh = ::cygheap->fdtab[0];
> @@ -4555,16 +4564,16 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
>       pcon_enabled = setup_pseudoconsole ();
>     ReleaseMutex (pipe_sw_mutex);
>     /* For pcon enabled case, transfer_input() is called in master::write() */
> +  WaitForSingleObject (input_mutex, mutex_timeout);
>     if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
>         && stdin_is_ptys && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
>       {
> -      WaitForSingleObject (input_mutex, mutex_timeout);
>         acquire_attach_mutex (mutex_timeout);
>         transfer_input (tty::to_nat, get_handle (), get_ttyp (),
>   		      input_available_event, input_transferred_to_cyg);
>         release_attach_mutex ();
> -      ReleaseMutex (input_mutex);
>       }
> +  ReleaseMutex (input_mutex);
>   }
>   
>   void
> @@ -4573,22 +4582,22 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
>   						DWORD force_switch_to)
>   {
>     ttyp->wait_fwd ();
> +  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
> +  WaitForSingleObject (p->input_mutex, mutex_timeout);
>     if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
>       {
>         DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
>         if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
>   	  && ttyp->pty_input_state_eq (tty::to_nat))
>   	{
> -	  WaitForSingleObject (p->input_mutex, mutex_timeout);
>   	  acquire_attach_mutex (mutex_timeout);
>   	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
>   			  p->input_available_event,
>   			  p->input_transferred_to_cyg);
>   	  release_attach_mutex ();
> -	  ReleaseMutex (p->input_mutex);
>   	}
>       }
> -  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
> +  ReleaseMutex (p->input_mutex);
>     if (ttyp->pcon_activated)
>       close_pseudoconsole (ttyp, force_switch_to);
>     else
> @@ -4602,27 +4611,23 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
>     reset_switch_to_nat_pipe ();
>   
>     WaitForSingleObject (pipe_sw_mutex, INFINITE);
> +  WaitForSingleObject (input_mutex, mutex_timeout);
>     bool was_nat_fg = get_ttyp ()->nat_fg (tc ()->pgid);
>     bool nat_fg = get_ttyp ()->nat_fg (pid);
>     if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
>         && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
>       {
> -      ReleaseMutex (pipe_sw_mutex);
> -      WaitForSingleObject (input_mutex, mutex_timeout);
>         acquire_attach_mutex (mutex_timeout);
>         transfer_input (tty::to_nat, get_handle (), get_ttyp (),
>   		      input_available_event, input_transferred_to_cyg);
>         release_attach_mutex ();
> -      ReleaseMutex (input_mutex);
>       }
>     else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
>   	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
>       {
> -      ReleaseMutex (pipe_sw_mutex);
>         bool attach_restore = false;
>         HANDLE from = get_handle_nat ();
>         DWORD resume_pid = 0;
> -      WaitForSingleObject (input_mutex, mutex_timeout);
>         if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
>   	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
>   	{
> @@ -4640,10 +4645,9 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
>   	resume_from_temporarily_attach (resume_pid);
>         else
>   	release_attach_mutex ();
> -      ReleaseMutex (input_mutex);
>       }
> -  else
> -    ReleaseMutex (pipe_sw_mutex);
> +  ReleaseMutex (input_mutex);
> +  ReleaseMutex (pipe_sw_mutex);
>   }
>   
>   bool
> @@ -4653,8 +4657,8 @@ fhandler_pty_master::need_send_ctrl_c_event ()
>        apps will be done in pseudo console, therefore, sending it in
>        fhandler_pty_master::write() duplicates that event for non-cygwin
>        apps. So return false if pseudo console is activated. */
> -  return !(to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
> -    && get_ttyp ()->pty_input_state == tty::to_nat);
> +  return !(get_ttyp ()->pcon_activated
> +	   && get_ttyp ()->pty_input_state == tty::to_nat);
>   }
>   
>   void

The rest LGTM.  Let me know what you think about my comments.

..mark

