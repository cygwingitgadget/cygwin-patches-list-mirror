Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 362F44BA2E0F
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 01:16:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 362F44BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 362F44BA2E0F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782177411; cv=none;
	b=s7ZYzueQse8V0bw8XOUOBfRWpFNC/Wf4vTrgs/mjVmcEwfTIL+rTj/C7rd8k3gk7qB0RLfTK6Z6CQeuKyIPO3WiOWj1wc7mTOCdM0ZJVQJ2orb4M8lXRZF9JjE1nE/O0qf+t4ALgWI1yBCCopeOhuegJtK5JuBPg4wWKgkn/Qow=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782177411; c=relaxed/simple;
	bh=uxYAiphsUjcigei5fKM0QVkqE9hIUJbkH94gMLSfj/Q=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=BHaSIBIPr/SiADupvpJH9DhPBNrwcSZXDOIIBvNWWyU5cCSIfvPOo6lOuKF7gz9HZPXLKrVIrndIkLHcMsH0GOiO6gknpMypbgVnc7Zxs5e4YZYu/ack5hLWWUMNBUWH41MqJYZINalC2fs3MUy7tfmR7wWzV/rr/Y2hspi2/gI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=f14K6Xzs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 362F44BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=f14K6Xzs
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260623011648865.SLU.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 10:16:48 +0900
Date: Tue, 23 Jun 2026 10:16:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/2] Cygwin: pty: Introduce a helper function
 get_handle_from_process()
Message-Id: <20260623101648.f4a5b4731b05759b3f392add@nifty.ne.jp>
In-Reply-To: <f77eadf7-b41c-4229-b120-014dd3ca3db3@maxrnd.com>
References: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
	<20260613140630.24451-2-takashi.yano@nifty.ne.jp>
	<f77eadf7-b41c-4229-b120-014dd3ca3db3@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782177408;
 bh=qoByxMKu+Wf6ritm6HpJqp8TjF7Sf0KLmE7PGbXmNAQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=f14K6XzspW4LyTrwR+Swxo/uEdRZD+taEVuNg/Oqq3ZYeESCe9BhwHOmKk7nSgHZJlu73fAn
 WA4QbnRTlk6lN4RenglI8XoD9luidykyOQpRoKwihLzEbUDEI/8Cr3MtFhHHmyUj/ut8wMCfRf
 +dLr5NodAOTZ3fQeWe67XC0NC0vJdtF7RRKjQQfEJ6S2TBiQJhJY/hHdLcfQ9UP+ns32F4YVA7
 CITxG71h0AqK8lGY9bH8Kgc5InN5Lee933W3Oi6dcErTLs755sM7vNhQjdtAZ2k9uMJA7xdF5H
 /+3eAdSxFH+pP9ihk3Ao3Un4Fv7sEtRl4eyCVuHKcCorNz+Q==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 21 Jun 2026 00:16:21 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/13/2026 7:06 AM, Takashi Yano wrote:
> > The current pty code performs the sequence:
> >    OpenProcess() -> DuplicateHandle()
> > in various places. This helper function encapsulates that sequence
> > to improve readability and maintainability.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/pty.cc | 66 +++++++++++++++++------------------
> >   1 file changed, 33 insertions(+), 33 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 2558fa799..e60e30230 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2213,6 +2213,23 @@ fhandler_pty_common::close (int flag)
> >     return 0;
> >   }
> >   
> > +static inline HANDLE
> > +get_handle_from_process (DWORD pid, HANDLE h, bool inh = false)
> > +{
> > +  HANDLE ret = NULL;
> > +  HANDLE owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, pid);
> > +  if (owner)
> > +    {
> > +      if (!DuplicateHandle (owner, h, GetCurrentProcess (), &ret, 0, inh,
> > +			    DUPLICATE_SAME_ACCESS))
> > +	termios_printf ("DuplicateHandle() %p from process %d (%E)", h, pid);
> > +      CloseHandle (owner);
> > +    }
> > +  else
> > +    termios_printf ("OpenProcess (%d) failed (%E).", pid);
> > +  return ret;
> > +}
> > +
> >   void
> >   fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
> >   {
> > @@ -2220,15 +2237,14 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
> >     size.X = ws->ws_col;
> >     size.Y = ws->ws_row;
> >     HPCON_INTERNAL hpcon_local;
> > -  HANDLE pcon_owner =
> > -    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->nat_pipe_owner_pid);
> > -  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_write_pipe,
> > -		   GetCurrentProcess (), &hpcon_local.hWritePipe,
> > -		   0, FALSE, DUPLICATE_SAME_ACCESS);
> > +  hpcon_local.hWritePipe =
> > +    get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> > +			     get_ttyp ()->h_pcon_write_pipe);
> > +  if (hpcon_local.hWritePipe == NULL)
> > +    return;
> >     acquire_attach_mutex (mutex_timeout);
> >     ResizePseudoConsole ((HPCON) &hpcon_local, size);
> >     release_attach_mutex ();
> > -  CloseHandle (pcon_owner);
> >     CloseHandle (hpcon_local.hWritePipe);
> >   }
> >   
> > @@ -2490,18 +2506,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   	    {
> >   	      if (h_pcon_in_dupped)
> >   		ForceCloseHandle (h_pcon_in_dupped);
> > -	      h_pcon_in_dupped = NULL;
> > -	      nat_pipe_owner_pid_dupped = 0;
> > -	      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > -					       get_ttyp ()->nat_pipe_owner_pid);
> > -	      if (pcon_owner)
> > -		{
> > -		  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> > -				   GetCurrentProcess (), &h_pcon_in_dupped,
> > -				   0, FALSE, DUPLICATE_SAME_ACCESS);
> > -		  nat_pipe_owner_pid_dupped = get_ttyp ()->nat_pipe_owner_pid;
> > -		  CloseHandle (pcon_owner);
> > -		}
> > +	      h_pcon_in_dupped =
> > +		get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> > +					 get_ttyp ()->h_pcon_in);
> > +	      if (h_pcon_in_dupped)
> > +		nat_pipe_owner_pid_dupped = get_ttyp ()->nat_pipe_owner_pid;
> > +	      else
> > +		nat_pipe_owner_pid_dupped = 0;
> >   	    }
> >   	  else
> >   	    {
> > @@ -4265,16 +4276,9 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
> >       to = ttyp->to_slave ();
> >   
> >     pinfo p (ttyp->master_pid);
> > -  HANDLE pty_owner = NULL;
> >     if (p)
> > -    pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
> > -  if (pty_owner)
> > -    {
> > -      DuplicateHandle (pty_owner, to, GetCurrentProcess (), &to,
> > -		       0, TRUE, DUPLICATE_SAME_ACCESS);
> > -      CloseHandle (pty_owner);
> > -    }
> > -  else
> > +    to = get_handle_from_process (p->dwProcessId, to, true);
> > +  if (to == NULL)
> >       {
> >         char pipe[MAX_PATH];
> >         __small_sprintf (pipe,
> > @@ -4571,12 +4575,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
> >         if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
> >   	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
> >   	{
> > -	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> > -					   get_ttyp ()->nat_pipe_owner_pid);
> > -	  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> > -			   GetCurrentProcess (), &from,
> > -			   0, TRUE, DUPLICATE_SAME_ACCESS);
> > -	  CloseHandle (pcon_owner);
> > +	  from = get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> > +					  get_ttyp ()->h_pcon_in, true);
> >   	  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
> >   	  resume_pid = attach_console_temporarily (target_pid);
> >   	  attach_restore = true;
> 
> LGTM.  OK to push.

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
