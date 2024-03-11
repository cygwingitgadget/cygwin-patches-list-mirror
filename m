Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CF10438582A2; Mon, 11 Mar 2024 20:33:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CF10438582A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1710189186;
	bh=OYJYKoi/8vtiQzSEzXdVgFRBAnLcesDYLQqK0Der5CI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JiGSvDVTJcrn2hxOOuuavuj/Ql6fygDS7hoGGpMbB2Er28PxUDw2u+bhtiDI8KRLQ
	 wFdAtwSi+BZ8Y4vuOozwGRkYIBgQumeCSwgPAIWF01RU0HNFqh9VJpm7iB5da09dAh
	 NDgPmiQlXlxNeSq2UIAtAulu4Q/65hGIwMt+IqIA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C73A9A80B87; Mon, 11 Mar 2024 21:33:04 +0100 (CET)
Date: Mon, 11 Mar 2024 21:33:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore non-blocking mode which was reset
 for non-cygwin app.
Message-ID: <Ze9qgPIptT3EasMm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,
	cygwin-patches@cygwin.com
References: <20240310103202.3753-1-takashi.yano@nifty.ne.jp>
 <Ze7hRBVYCClZg-Kq@calimero.vinschen.de>
 <20240311204237.bb2ffef477328542a63b148d@nifty.ne.jp>
 <20240311221857.7b5175cc76b5c4be7d81896b@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311221857.7b5175cc76b5c4be7d81896b@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,


this looks much better.  Just one question and a few comment
changes...

On Mar 11 22:18, Takashi Yano wrote:
> Subject: [PATCH v2] Cygwin: pipe: Make sure to set read pipe non-blocking for
>  cygwin apps.
> 
> If pipe reader is a non-cygwin app first, and cygwin process reads
> the same pipe after that, the pipe has been set to bclocking mode
> for the cygwin app. However, the commit 9e4d308cd592 assumes the
> pipe for cygwin process always is non-blocking mode. With this patch,
> the pipe mode is reset to non-blocking when cygwin app is started.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-March/255644.html
> Fixes: 9e4d308cd592 ("Cygwin: pipe: Adopt FILE_SYNCHRONOUS_IO_NONALERT flag for read pipe.")
> Reported-by: wh <wh9692@protonmail.com>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc          | 54 +++++++++++++++++++++++++
>  winsup/cygwin/local_includes/fhandler.h |  2 +
>  winsup/cygwin/spawn.cc                  | 35 +---------------
>  3 files changed, 58 insertions(+), 33 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> index 29d3b41d9..b29726dcb 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -18,6 +18,7 @@ details. */
>  #include "pinfo.h"
>  #include "shared_info.h"
>  #include "tls_pbuf.h"
> +#include "sigproc.h"
>  #include <assert.h>
>  
>  /* This is only to be used for writing.  When reading,
> @@ -1288,3 +1289,56 @@ close_proc:
>      }
>    return NULL;
>  }
> +
> +void
> +fhandler_pipe::spawn_worker (bool iscygwin, int fileno_stdin,
> +			     int fileno_stdout, int fileno_stderr)
> +{
> +  bool need_send_noncygchld_sig = false;
> +
> +  /* Set read pipe itself always non-blocking for cygwin process. blocking/
> +     non-blocking is simulated in the raw_read(). As for write pipe, follow
> +     the is_nonblocking(). */

You can drop the articles here, i.e.

        ...non-blocking is simulated in raw_read().  For write pipe follow
	is_nonblocking().

> +  int fd;
> +  cygheap_fdenum cfd (false);
> +  while ((fd = cfd.next ()) >= 0)
> +    if (cfd->get_dev () == FH_PIPEW
> +	&& (fd == fileno_stdout || fd == fileno_stderr))
> +      {
> +	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> +	bool mode = iscygwin ? pipe->is_nonblocking () : false;
> +	pipe->set_pipe_non_blocking (mode);

What bugs me here is that we now run the loop for cygwin children
as well.  The old code only did that for non-cygwin children.
This looks like quite a performance hit, potentially. Especially
if the process has many open descriptors.  Let's say, a recursive
make or so.  Did you find this is necessary?  No way to avoid that?

> +
> +	/* Setup for query_ndl stuff. Read the comment below. */
> +	if (!iscygwin && pipe->request_close_query_hdl ())
> +	  need_send_noncygchld_sig = true;
> +      }
> +    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
> +      {
> +	fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> +	pipe->set_pipe_non_blocking (iscygwin);
> +      }
> +
> +  /* If multiple writers including non-cygwin app exist, the non-cygwin
> +     app cannot detect pipe closure on the read side when the pipe is
> +     created by system account or the the pipe creator is running as
                                     ^^^^^^^


Thanks,
Corinna
