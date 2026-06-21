Return-Path: <SRS0=iHxA=ER=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id E94044BA2E13
	for <cygwin-patches@cygwin.com>; Sun, 21 Jun 2026 07:16:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E94044BA2E13
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E94044BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782026180; cv=none;
	b=GRAc3EV0KagUzZ7Bu4tPg1x5lprrcvvTZQtWmiGduvnUv8MqISl9EqvzTdCYSpNxAKDtvw889IkcdyGoHcxqBxtzcR0rt++xEo8iTdVUghD9N5l32XtEttXLyvWE5q5w8uFYBJnXesuPOJEJEBSTGseviqSGHsipGTftE01/wFc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782026180; c=relaxed/simple;
	bh=Ei88srN//MlMI7gFRNDbW71/QuHT+xg+quoHpnG8e6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=qMZWu22XVqeWUeVdCI89M0qDKdxVbfm95zyx9CqnMzr6Bafx4CnQTnJlBDZihpSrYdttplfD/NB59Ur7G9fBiJVFBMuNKsh/2/lPOoBvOYecaYbPPVHkznNi2/zSPW+68ELpNxaGp5lecjXURPxaU+cQru+FYHVZDkXiBexqBz0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E94044BA2E13
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65L7VNVw059169;
	Sun, 21 Jun 2026 00:31:23 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdvsukWq; Sun Jun 21 00:31:17 2026
Message-ID: <f77eadf7-b41c-4229-b120-014dd3ca3db3@maxrnd.com>
Date: Sun, 21 Jun 2026 00:16:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Cygwin: pty: Introduce a helper function
 get_handle_from_process()
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
References: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
 <20260613140630.24451-2-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260613140630.24451-2-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/13/2026 7:06 AM, Takashi Yano wrote:
> The current pty code performs the sequence:
>    OpenProcess() -> DuplicateHandle()
> in various places. This helper function encapsulates that sequence
> to improve readability and maintainability.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/pty.cc | 66 +++++++++++++++++------------------
>   1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 2558fa799..e60e30230 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2213,6 +2213,23 @@ fhandler_pty_common::close (int flag)
>     return 0;
>   }
>   
> +static inline HANDLE
> +get_handle_from_process (DWORD pid, HANDLE h, bool inh = false)
> +{
> +  HANDLE ret = NULL;
> +  HANDLE owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, pid);
> +  if (owner)
> +    {
> +      if (!DuplicateHandle (owner, h, GetCurrentProcess (), &ret, 0, inh,
> +			    DUPLICATE_SAME_ACCESS))
> +	termios_printf ("DuplicateHandle() %p from process %d (%E)", h, pid);
> +      CloseHandle (owner);
> +    }
> +  else
> +    termios_printf ("OpenProcess (%d) failed (%E).", pid);
> +  return ret;
> +}
> +
>   void
>   fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
>   {
> @@ -2220,15 +2237,14 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
>     size.X = ws->ws_col;
>     size.Y = ws->ws_row;
>     HPCON_INTERNAL hpcon_local;
> -  HANDLE pcon_owner =
> -    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->nat_pipe_owner_pid);
> -  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_write_pipe,
> -		   GetCurrentProcess (), &hpcon_local.hWritePipe,
> -		   0, FALSE, DUPLICATE_SAME_ACCESS);
> +  hpcon_local.hWritePipe =
> +    get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> +			     get_ttyp ()->h_pcon_write_pipe);
> +  if (hpcon_local.hWritePipe == NULL)
> +    return;
>     acquire_attach_mutex (mutex_timeout);
>     ResizePseudoConsole ((HPCON) &hpcon_local, size);
>     release_attach_mutex ();
> -  CloseHandle (pcon_owner);
>     CloseHandle (hpcon_local.hWritePipe);
>   }
>   
> @@ -2490,18 +2506,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>   	    {
>   	      if (h_pcon_in_dupped)
>   		ForceCloseHandle (h_pcon_in_dupped);
> -	      h_pcon_in_dupped = NULL;
> -	      nat_pipe_owner_pid_dupped = 0;
> -	      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> -					       get_ttyp ()->nat_pipe_owner_pid);
> -	      if (pcon_owner)
> -		{
> -		  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> -				   GetCurrentProcess (), &h_pcon_in_dupped,
> -				   0, FALSE, DUPLICATE_SAME_ACCESS);
> -		  nat_pipe_owner_pid_dupped = get_ttyp ()->nat_pipe_owner_pid;
> -		  CloseHandle (pcon_owner);
> -		}
> +	      h_pcon_in_dupped =
> +		get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> +					 get_ttyp ()->h_pcon_in);
> +	      if (h_pcon_in_dupped)
> +		nat_pipe_owner_pid_dupped = get_ttyp ()->nat_pipe_owner_pid;
> +	      else
> +		nat_pipe_owner_pid_dupped = 0;
>   	    }
>   	  else
>   	    {
> @@ -4265,16 +4276,9 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
>       to = ttyp->to_slave ();
>   
>     pinfo p (ttyp->master_pid);
> -  HANDLE pty_owner = NULL;
>     if (p)
> -    pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
> -  if (pty_owner)
> -    {
> -      DuplicateHandle (pty_owner, to, GetCurrentProcess (), &to,
> -		       0, TRUE, DUPLICATE_SAME_ACCESS);
> -      CloseHandle (pty_owner);
> -    }
> -  else
> +    to = get_handle_from_process (p->dwProcessId, to, true);
> +  if (to == NULL)
>       {
>         char pipe[MAX_PATH];
>         __small_sprintf (pipe,
> @@ -4571,12 +4575,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
>         if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
>   	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
>   	{
> -	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
> -					   get_ttyp ()->nat_pipe_owner_pid);
> -	  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
> -			   GetCurrentProcess (), &from,
> -			   0, TRUE, DUPLICATE_SAME_ACCESS);
> -	  CloseHandle (pcon_owner);
> +	  from = get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
> +					  get_ttyp ()->h_pcon_in, true);
>   	  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
>   	  resume_pid = attach_console_temporarily (target_pid);
>   	  attach_restore = true;

LGTM.  OK to push.

..mark
