Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 447624BA2E14; Thu, 26 Mar 2026 09:21:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 447624BA2E14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774516889;
	bh=X3whvFBcDhfsrZJywEES1CETIuT7QA/HdAznLyyx5rA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Qbk2eW8ZHno0iUozer1bCd4vanKDBPlGZbzmUaWvosilldFaK8jQDXNNtM/3lq2Br
	 MuRRvhUm28gtFoWgktt67L/+zceCtpTmp+7yWJH2JzoIwm+dUO9DB0UB6RGoml7qTW
	 o+R3j5SKY8UDt2iVl0ekp8GUblIWF7aBg39MPurY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 19EFCA80872; Thu, 26 Mar 2026 10:21:27 +0100 (CET)
Date: Thu, 26 Mar 2026 10:21:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Release pipe_sw_mutex in
 pcon_hand_over_proc()
Message-ID: <acT6lwMeLiPIuxUD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260325130644.64948-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325130644.64948-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 25 22:06, Takashi Yano wrote:
> Currently, pipe_sw_mutex is held in the process which is running
> in console inherited from pseudo console until the process ends.
> Due to this behaviour, the process may cause deadlock when it
> attempts to acuqire input_mutex in set_input_mode() called via
              acquire

> close_ctty(). This deadlock occurs because the pty master
> acuires input_mutex first and acuire pipe_sw_mutex next while
  acquire                       acquire

> the process exiting acuire pipe_sw_mutex first.
                      acquire

> To avoid this deadlock, this patch releases pipe_sw_mutex in
> pcon_hand_over_proc(). In addition, pointless pipe_sw_mutex
> acquire/release is drppped in pcon_hand_over_proc().
> 
> Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from parent pty")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/console.cc | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 29cdba0d3..1dd5dfa1d 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1994,8 +1994,6 @@ fhandler_console::pcon_hand_over_proc (void)
>    char buf[MAX_PATH];
>    shared_name (buf, PIPE_SW_MUTEX, parent_pty);
>    HANDLE mtx = OpenMutex (MAXIMUM_ALLOWED, FALSE, buf);
> -  WaitForSingleObject (mtx, INFINITE);
> -  ReleaseMutex (mtx);
>    DWORD res = WaitForSingleObject (mtx, INFINITE);
>    if (res == WAIT_OBJECT_0 || res == WAIT_ABANDONED)
>      {
> @@ -2006,9 +2004,8 @@ fhandler_console::pcon_hand_over_proc (void)
>      }
>    else
>      system_printf("Acquiring pcon_ho_mutex failed.");
> +  ReleaseMutex (mtx);
>    CloseHandle (parent_pty_input_mutex);
> -  /* Do not release the mutex.
> -     Hold onto the mutex until this process completes. */
>  }
>  
>  bool
> -- 
> 2.51.0

Other than that, LGTM.


Thanks,
Corinna
