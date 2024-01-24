Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9ED9B3858410; Wed, 24 Jan 2024 14:40:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9ED9B3858410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1706107224;
	bh=vEAM5cMscpd9CMo1LoI8zSOblhQviB6V5TFUbH+/Cd8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=TW2xiEa0D+BEZMQ55Bmq+kmkz33wBApvo43y4gmelLkGB+T+caF2BtrthyphEsDWU
	 ocGbOrFdL77Smz6Q+xVLFwrGA2Jy1uBXJQvAHoX/C8xdnaXMwDX+FqR6RCBtZUrEyf
	 ScflaLlCjr1bji3e8VqWe4/aDugz6aixZssfP07Y=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F359EA80B93; Wed, 24 Jan 2024 15:40:22 +0100 (CET)
Date: Wed, 24 Jan 2024 15:40:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pthread: Fix handle leak in pthread_once.
Message-ID: <ZbEhVg3ApRhrWF1Z@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240124134448.39071-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124134448.39071-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jan 24 22:44, Takashi Yano wrote:
> If pthread_once() is called with pthread_once_t initialized using
> PTREAD_ONCE_INIT, pthread_once does not release pthread_mutex used
> internally. This patch fixes that by calling pthread_mutex_destroy()
> in the thread which has called init_routine.
> 
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/thread.cc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index 7bb4f9fc8..0f8327831 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -2060,6 +2060,9 @@ pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
>      {
>        init_routine ();
>        once_control->state = 1;
> +      pthread_mutex_unlock (&once_control->mutex);
> +      while (pthread_mutex_destroy (&once_control->mutex) == EBUSY);
> +      return 0;
>      }
>    /* Here we must remove our cancellation handler */
>    pthread_mutex_unlock (&once_control->mutex);
> -- 
> 2.43.0

Sure, please push.

(You don't have to CC me, btw., I only get the same mail twice then
and I look into this mailing list constantly anyway)


Thanks,
Corinna
