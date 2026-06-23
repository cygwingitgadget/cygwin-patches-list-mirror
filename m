Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 8EF444BA2E0F
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 01:17:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8EF444BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8EF444BA2E0F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782177455; cv=none;
	b=mCFFDxo97TXNE8lgg+X60eLVvMD8HZ2Ibgs0n3PUZSCXz2ZBWo2pC2Z28uA0UIta5i1w6UwvwXJC+ydpi6YO5ZsvdFC4SgKFuZAv4zxXtKJzCNNIGvNiaNv6ou8oYcfaeXWRQZW+mLvzNkyAsCoH2FXUUyLta2zteyAN+b9v5ms=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782177455; c=relaxed/simple;
	bh=7DpPxbwaVWHIitN3MhsVHzdcmYSTSqJE80GBnNwrbVI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EnEGwDOjpj694Q8bmqSZ/+hcUnrLnCsG1yfPsa6USne5H9Rn2KrzjqaPybQWbACaSrtW6luwFgBQ6aFm2Vz653ZjWK53WHHGMvJJ6mfmwESp4OuS6746D/Kz90v/ogv6in56PLoNP4oiKwPVa6ZWanBTKAAXOfOy8ywKZX5TYxU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Hd44qNVR
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8EF444BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Hd44qNVR
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260623011732656.BFBS.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 10:17:32 +0900
Date: Tue, 23 Jun 2026 10:17:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for
 cursor position report
Message-Id: <20260623101732.cb1ce302c679713eeef276dd@nifty.ne.jp>
In-Reply-To: <ec212c2b-d706-4002-be1e-d3ceecba4895@maxrnd.com>
References: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
	<20260613140630.24451-3-takashi.yano@nifty.ne.jp>
	<ec212c2b-d706-4002-be1e-d3ceecba4895@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782177452;
 bh=14fgfq/f7OL/cSxHvtS5gN/HfO0h+goi2FPbJ2bHC3c=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Hd44qNVRWXh1dco8sH++NKqVlesRRnbVeFK9HR8/kgmgHbRN0sprdO5gaI90hvvLLjX9Ms5n
 JEc6lDEFq5j9HjhPy39H5v1ZgaK1sg+byDjXZE1jDd14idvmngGu6SPUent1xrPFtY//1TRFR4
 lXnktVlmRN3fJQ6anpXV54/NflP48y6+hLwV2OlgSxz9yPxMZqEuIPVlGdTw8S566wZOqa8HNT
 2KUxIFB50EM5aPbbuQptO+naR8SEaR/7Hzcb00G8dhALxLCBzZIxvuEJmm30FENwwerjXOJqxJ
 PpS5r3KJbVemXr2E7MRefkq6M8csbh9dkI6Vvh+SFfNyJmpA==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 21 Jun 2026 00:17:08 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/13/2026 7:06 AM, Takashi Yano wrote:
> > When the cursor position report ("CSI m;n R") is transferred from
> > cyg-pipe to nat-pipe, it is undesirably converted into Fn3 key by
> > pseudo console. This patch adds a workaround to prevent this
> > unintended conversion for cursor position report by enabling
> > ENABLE_VIRTUAL_TERMINAL_INPUT flag temporarily.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-June/259776.html
> > Reported-by: Koichi Murase <myoga.murase@gmail.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/pty.cc      | 53 +++++++++++++++++++++++++++++-
> >   winsup/cygwin/local_includes/tty.h |  1 +
> >   2 files changed, 53 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index e60e30230..e0fc67ae1 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2445,7 +2445,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   	      ixput = 0;
> >   	      state = 0;
> >   	      wp_tid = 0;
> > -	      get_ttyp ()->req_xfer_input = false;
> >   	      if (!get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
> >   		break;
> >   	    }
> > @@ -2460,6 +2459,20 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   	      && pp && pp->pgid == get_ttyp ()->getpgid ()
> >   	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
> >   	    {
> > +	      if (!get_ttyp ()->req_xfer_input)
> > +		{
> > +		  HANDLE pcon_handle_ready_event =
> > +		    get_ttyp ()->pcon_handle_ready_event;
> > +		  get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> > +					   pcon_handle_ready_event);
> > +		  if (pcon_handle_ready_event)
> > +		    {
> > +		      cygwait (pcon_handle_ready_event, INFINITE);
> > +		      ResetEvent (pcon_handle_ready_event);
> > +		      CloseHandle (pcon_handle_ready_event);
> > +		    }
> > +		}
> > +
> >   	      /* This accept_input() call is needed in order to transfer input
> >   		 which is not accepted yet to non-cygwin pipe. */
> >   	      WaitForSingleObject (input_mutex, mutex_timeout);
> > @@ -2473,6 +2486,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   	      release_attach_mutex ();
> >   	      ReleaseMutex (input_mutex);
> >   	    }
> > +	  get_ttyp ()->req_xfer_input = false;
> >   	  get_ttyp ()->pcon_start_pid = 0;
> >   	}
> >         if (len == 0)
> > @@ -3767,6 +3781,8 @@ fhandler_pty_slave::setup_pseudoconsole ()
> >         si.StartupInfo.hStdOutput = NULL;
> >         si.StartupInfo.hStdError = NULL;
> >   
> > +      get_ttyp ()->pcon_handle_ready_event =
> > +	CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
> >         get_ttyp ()->pcon_activated = true;
> >         get_ttyp ()->pcon_start = true;
> >         get_ttyp ()->pcon_start_pid = myself->pid;
> > @@ -3853,6 +3869,7 @@ skip_create:
> >         /* Discard the pseudo console handler container here.
> >   	 Reconstruct it temporary when it is needed. */
> >         HeapFree (GetProcessHeap (), 0, hp);
> > +      SetEvent (get_ttyp ()->pcon_handle_ready_event);
> >       }
> >   
> >     acquire_attach_mutex (mutex_timeout);
> > @@ -4060,6 +4077,11 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
> >   	  ttyp->pcon_start = false;
> >   	  ttyp->pcon_start_pid = 0;
> >   	}
> > +      if (ttyp->pcon_handle_ready_event)
> > +	{
> > +	  CloseHandle (ttyp->pcon_handle_ready_event);
> > +	  ttyp->pcon_handle_ready_event = NULL;
> > +	}
> >       }
> >     else
> >       { /* Just detach from the pseudo console if I am not owner. */
> > @@ -4308,6 +4330,26 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
> >   
> >     UINT cp_from = 0, cp_to = 0;
> >   
> > +  HANDLE h_pcon_in = NULL;
> > +  DWORD con_mode = 0;
> > +  if (ttyp->pcon_activated && dir == tty::to_nat)
> > +    {
> > +      /* Escape sequences such as the cursor position report ("CSI m;n R")
> > +	 are undesirably converted into an Fn3 key by pseudo console.
> > +	 To privent this unintended conversion, temporarily enable
> > +	 ENABLE_VIRTUAL_TERMINAL_INPUT flag. */
> > +      h_pcon_in =
> > +	get_handle_from_process (ttyp->nat_pipe_owner_pid, ttyp->h_pcon_in);
> > +      if (h_pcon_in)
> > +	{
> > +	  DWORD target_pid = ttyp->nat_pipe_owner_pid;
> > +	  DWORD resume_pid = attach_console_temporarily (target_pid);
> > +	  GetConsoleMode (h_pcon_in, &con_mode);
> > +	  SetConsoleMode (h_pcon_in, con_mode | ENABLE_VIRTUAL_TERMINAL_INPUT);
> > +	  resume_from_temporarily_attach (resume_pid);
> > +	}
> > +    }
> > +
> >     if (dir == tty::to_nat)
> >       {
> >         cp_from = ttyp->term_code_page;
> > @@ -4422,6 +4464,15 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
> >       }
> >     CloseHandle (to);
> >   
> > +  if (h_pcon_in)
> > +    {
> > +      DWORD target_pid = ttyp->nat_pipe_owner_pid;
> > +      DWORD resume_pid = attach_console_temporarily (target_pid);
> > +      SetConsoleMode (h_pcon_in, con_mode);
> > +      resume_from_temporarily_attach (resume_pid);
> > +      CloseHandle (h_pcon_in);
> > +    }
> > +
> >     ttyp->pty_input_state = dir;
> >     /* Fix input_available_event which indicates availability in cyg pipe. */
> >     if (dir == tty::to_nat) /* all data is transfered to nat pipe,
> > diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
> > index 4fbebd820..0adad03e6 100644
> > --- a/winsup/cygwin/local_includes/tty.h
> > +++ b/winsup/cygwin/local_includes/tty.h
> > @@ -125,6 +125,7 @@ private:
> >     bool pcon_start_csi_c;
> >     bool switch_to_nat_pipe;
> >     DWORD nat_pipe_owner_pid;
> > +  HANDLE pcon_handle_ready_event;
> >     UINT term_code_page;
> >     ULONGLONG fwd_last_time;
> >     bool fwd_not_empty;
> 
> LGTM.  OK to push.

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
