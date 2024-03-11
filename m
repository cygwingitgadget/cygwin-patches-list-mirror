Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8D0773858D20; Mon, 11 Mar 2024 10:47:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D0773858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1710154054;
	bh=Q/kjo2TFBDavPjNPwmtT9nOBfJMuPucNr/uIsjtH7hc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=TN+wFfrJyFfuCHdy03mzeD5/AXIaQw0h//N2yzXsyoqdedJYFbqkyzeroBWcs8io0
	 h+l+fIbfnrO8atvvVIvgrJAgaeFIBtTKC1C6L+te7MGbKbn4cZxmq19soPbUJkttdi
	 /mxq2Z454c6hhhyTv8Hn0XWeiYkB8NoFPHa0C3iA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D6FEEA80B87; Mon, 11 Mar 2024 11:47:32 +0100 (CET)
Date: Mon, 11 Mar 2024 11:47:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore non-blocking mode which was reset
 for non-cygwin app.
Message-ID: <Ze7hRBVYCClZg-Kq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240310103202.3753-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240310103202.3753-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mar 10 19:31, Takashi Yano wrote:
> @@ -590,6 +591,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	      {
>  		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
>  		pipe->set_pipe_non_blocking (false);
> +		pipew_duped = (fhandler_pipe *)
> +			ccalloc (HEAP_FHANDLER, 1, sizeof (fhandler_pipe));
> +		pipew_duped = new (pipew_duped) fhandler_pipe;
> +		pipe->dup (pipew_duped, 0);
>  		if (pipe->request_close_query_hdl ())
>  		  need_send_sig = true;
>  	      }

The code setting up pipes and the dummy_tty is sufficiently complex,
so that I wonder if it shouldn't have

- its own methods and
- comments to describe why this stuff is necessary.

What about adding two methods, kind of like (the names are only
suggestion, albeit bad ones):

  child_info_spawn::noncygwin_child_pre_fork()

to keep the above stuff together (plus comments) and

  child_info_spawn::noncygwin_child_post_fork()

for the below code?

> @@ -597,6 +602,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	      {
>  		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
>  		pipe->set_pipe_non_blocking (false);
> +		piper_duped = (fhandler_pipe *)
> +			ccalloc (HEAP_FHANDLER, 1, sizeof (fhandler_pipe));
> +		piper_duped = new (piper_duped) fhandler_pipe;
> +		pipe->dup (piper_duped, 0);
>  	      }
>  
>  	  if (need_send_sig)
> @@ -905,6 +914,19 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	      term_spawn_worker.cleanup ();
>  	      term_spawn_worker.close_handle_set ();
>  	    }
> +	  if (pipew_duped)
> +	    {
> +	      bool is_nonblocking = pipew_duped->is_nonblocking ();
> +	      pipew_duped->set_pipe_non_blocking (is_nonblocking);

Is that really right?  You're asking pipew_duped for its
nonblocking flag and then set pipew_duped to the same value...?

> +	      pipew_duped->close ();
> +	      cfree (pipew_duped);
> +	    }


Thanks,
Corinna
