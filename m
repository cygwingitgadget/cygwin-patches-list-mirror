Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D4CC4385702B; Mon, 31 Mar 2025 14:30:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D4CC4385702B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743431436;
	bh=NSxhhzO6/ej8e0bIszrN+v2i35Is0xaqabNpQFQS6pc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Si42iVtU0KGmcfQpAJvBSwi7f+RjNYCthBAdbuoW/dzvx4eZrhqQF0SJxzJPR1OWG
	 raRABB8VLBpam6hKvwbeEr5LMvvtPII8AQcMi3PT1OJqQdgPO+bTXcQlwzUmebDYw4
	 aIenDVD4V+EhaW3DcmmafVEwZ9zo9VzU9u+GBKn0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A16A3A80C9C; Mon, 31 Mar 2025 16:25:09 +0200 (CEST)
Date: Mon, 31 Mar 2025 16:25:09 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Add workaround for native ninja
Message-ID: <Z-qlxQF0C6NMeLyQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250331132719.278-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331132719.278-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mar 31 22:27, Takashi Yano wrote:
> Native (non-cygwin) ninja creates pipe with size == 0, and starts
> cygwin process with that pipe. This causes infinite loop in the
> fhandler_fifo_pipe::raw_write(). Ideally, the pipe implementation
> in cygwin could work even with pipe size == 0, however, it seems
> impossible due to:
> 
> (1) select() does not work for that pipe because PeekNamedPipe()
>     always returns 0. Read side is ready to read only when the
>     write side is about to write, but there is no way to know that.
> (2) The cause of the problem:
>     https://cygwin.com/pipermail/cygwin/2025-January/257143.html
>     cannot be avoidable. To avoid CancelIo() problem, the patch
>     https://cygwin.com/pipermail/cygwin-patches/2025q1/013451.html
>     restricts the data size less than the current pipe space.
>     However, if pipe size is zero this is impossible.
> 
> This patch adds just a workaround for native ninja that avoid
> infinite loop in raw_write().
> [...]
> @@ -670,7 +670,9 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
>  			   fpli.WriteQuotaAvailable);
>  	  return fpli.WriteQuotaAvailable;
>  	}
> -      /* TODO: Buffer really full or non-Cygwin reader? */
> +      return PIPE_BUF; /* Workaround for native ninja. Native ninja creates
> +			  pipe with size == 0, and starts cygwin process
> +			  with that pipe. */

Funny that this problem cleared up this TODO entry :)))

Please push.


Thanks,
Corinna
