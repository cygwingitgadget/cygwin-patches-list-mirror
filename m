Return-Path: <SRS0=iHxA=ER=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 06EE34BA2E0E
	for <cygwin-patches@cygwin.com>; Sun, 21 Jun 2026 07:17:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06EE34BA2E0E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06EE34BA2E0E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782026230; cv=none;
	b=v09qCV9n47IEPR1317Q1Vj+lSI4qGei/jVV2rU4072AUWVazZdQfJXd4WlL6bcZ5Ok9oK8qkvPBErq9uxwZIBJNOUO7n6jh9uTV/PAFN/tgdle5/oH1cq3fq4LXFztZ+TpBNbbiO4rFIgyFcjj8mnuUzlkV9sAh2xezjL2lbbTs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782026230; c=relaxed/simple;
	bh=LV6QjI9cv/4KVDq+CqouZEBAumas+nuxdGXyUq97V78=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Tv0zhviORNWYtp9uz+U7+S38VIQ+P4Q0BBMqPzHMJz62Mmu7tdw7sb8uzCXONU8tud5TYF3s0ZXeNPa0sfqeSHxfwYZ6f3dPEd4ZphQinwBfKSTqq83hpGfXcCLlA9xHf0GWx76kPn2Fp+fQcwW7ZqJaWM+y9U+HJaNsyAJhxG0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06EE34BA2E0E
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65L7WD2R059180;
	Sun, 21 Jun 2026 00:32:13 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdpB3AWP; Sun Jun 21 00:32:03 2026
Message-ID: <ec212c2b-d706-4002-be1e-d3ceecba4895@maxrnd.com>
Date: Sun, 21 Jun 2026 00:17:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for
 cursor position report
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Cc: Koichi Murase <myoga.murase@gmail.com>
References: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
 <20260613140630.24451-3-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260613140630.24451-3-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/13/2026 7:06 AM, Takashi Yano wrote:
> When the cursor position report ("CSI m;n R") is transferred from
> cyg-pipe to nat-pipe, it is undesirably converted into Fn3 key by
> pseudo console. This patch adds a workaround to prevent this
> unintended conversion for cursor position report by enabling
> ENABLE_VIRTUAL_TERMINAL_INPUT flag temporarily.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2026-June/259776.html
> Reported-by: Koichi Murase <myoga.murase@gmail.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/pty.cc      | 53 +++++++++++++++++++++++++++++-
>   winsup/cygwin/local_includes/tty.h |  1 +
>   2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index e60e30230..e0fc67ae1 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2445,7 +2445,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   	      ixput = 0;
>   	      state = 0;
>   	      wp_tid = 0;
> -	      get_ttyp ()->req_xfer_input = false;
>   	      if (!get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
>   		break;
>   	    }
> @@ -2460,6 +2459,20 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   	      && pp && pp->pgid == get_ttyp ()->getpgid ()
>   	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
>   	    {
> +	      if (!get_ttyp ()->req_xfer_input)
> +		{
> +		  HANDLE pcon_handle_ready_event =
> +		    get_ttyp ()->pcon_handle_ready_event;
> +		  get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> +					   pcon_handle_ready_event);
> +		  if (pcon_handle_ready_event)
> +		    {
> +		      cygwait (pcon_handle_ready_event, INFINITE);
> +		      ResetEvent (pcon_handle_ready_event);
> +		      CloseHandle (pcon_handle_ready_event);
> +		    }
> +		}
> +
>   	      /* This accept_input() call is needed in order to transfer input
>   		 which is not accepted yet to non-cygwin pipe. */
>   	      WaitForSingleObject (input_mutex, mutex_timeout);
> @@ -2473,6 +2486,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   	      release_attach_mutex ();
>   	      ReleaseMutex (input_mutex);
>   	    }
> +	  get_ttyp ()->req_xfer_input = false;
>   	  get_ttyp ()->pcon_start_pid = 0;
>   	}
>         if (len == 0)
> @@ -3767,6 +3781,8 @@ fhandler_pty_slave::setup_pseudoconsole ()
>         si.StartupInfo.hStdOutput = NULL;
>         si.StartupInfo.hStdError = NULL;
>   
> +      get_ttyp ()->pcon_handle_ready_event =
> +	CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
>         get_ttyp ()->pcon_activated = true;
>         get_ttyp ()->pcon_start = true;
>         get_ttyp ()->pcon_start_pid = myself->pid;
> @@ -3853,6 +3869,7 @@ skip_create:
>         /* Discard the pseudo console handler container here.
>   	 Reconstruct it temporary when it is needed. */
>         HeapFree (GetProcessHeap (), 0, hp);
> +      SetEvent (get_ttyp ()->pcon_handle_ready_event);
>       }
>   
>     acquire_attach_mutex (mutex_timeout);
> @@ -4060,6 +4077,11 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
>   	  ttyp->pcon_start = false;
>   	  ttyp->pcon_start_pid = 0;
>   	}
> +      if (ttyp->pcon_handle_ready_event)
> +	{
> +	  CloseHandle (ttyp->pcon_handle_ready_event);
> +	  ttyp->pcon_handle_ready_event = NULL;
> +	}
>       }
>     else
>       { /* Just detach from the pseudo console if I am not owner. */
> @@ -4308,6 +4330,26 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
>   
>     UINT cp_from = 0, cp_to = 0;
>   
> +  HANDLE h_pcon_in = NULL;
> +  DWORD con_mode = 0;
> +  if (ttyp->pcon_activated && dir == tty::to_nat)
> +    {
> +      /* Escape sequences such as the cursor position report ("CSI m;n R")
> +	 are undesirably converted into an Fn3 key by pseudo console.
> +	 To privent this unintended conversion, temporarily enable
> +	 ENABLE_VIRTUAL_TERMINAL_INPUT flag. */
> +      h_pcon_in =
> +	get_handle_from_process (ttyp->nat_pipe_owner_pid, ttyp->h_pcon_in);
> +      if (h_pcon_in)
> +	{
> +	  DWORD target_pid = ttyp->nat_pipe_owner_pid;
> +	  DWORD resume_pid = attach_console_temporarily (target_pid);
> +	  GetConsoleMode (h_pcon_in, &con_mode);
> +	  SetConsoleMode (h_pcon_in, con_mode | ENABLE_VIRTUAL_TERMINAL_INPUT);
> +	  resume_from_temporarily_attach (resume_pid);
> +	}
> +    }
> +
>     if (dir == tty::to_nat)
>       {
>         cp_from = ttyp->term_code_page;
> @@ -4422,6 +4464,15 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
>       }
>     CloseHandle (to);
>   
> +  if (h_pcon_in)
> +    {
> +      DWORD target_pid = ttyp->nat_pipe_owner_pid;
> +      DWORD resume_pid = attach_console_temporarily (target_pid);
> +      SetConsoleMode (h_pcon_in, con_mode);
> +      resume_from_temporarily_attach (resume_pid);
> +      CloseHandle (h_pcon_in);
> +    }
> +
>     ttyp->pty_input_state = dir;
>     /* Fix input_available_event which indicates availability in cyg pipe. */
>     if (dir == tty::to_nat) /* all data is transfered to nat pipe,
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
> index 4fbebd820..0adad03e6 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -125,6 +125,7 @@ private:
>     bool pcon_start_csi_c;
>     bool switch_to_nat_pipe;
>     DWORD nat_pipe_owner_pid;
> +  HANDLE pcon_handle_ready_event;
>     UINT term_code_page;
>     ULONGLONG fwd_last_time;
>     bool fwd_not_empty;

LGTM.  OK to push.

..mark

