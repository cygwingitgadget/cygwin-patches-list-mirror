Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9DA494BA2E3E; Tue, 16 Dec 2025 12:13:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9DA494BA2E3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765887216;
	bh=zqjEZ8nBSLdh2i9YadS0lGYrRNnHVDhGYTKyuV92i6k=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=YL2woiElivtNfeVmriJv/Zq/YLoCpFB6jWvTY3aEQkUkA717RTVvaRusiJi4j7POh
	 +WAiY8wz+UtjuSFhlUz1R6D9OYDxh4Jd3EliuKOPBeIm01A5alRtsp/JtSPuzurkcx
	 S66aVM/wktkvwCu2nNgurp6yu2z9/hWjyTvvaFY0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C4B2BA804CD; Tue, 16 Dec 2025 13:13:33 +0100 (CET)
Date: Tue, 16 Dec 2025 13:13:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: pty: Fix ESC sequence parsing in
 pty_master_fwd_thread
Message-ID: <aUFM7SdTYNVAAeN6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
 <20251210015233.1368-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251210015233.1368-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 10 10:52, Takashi Yano wrote:
> This patch fixes the bug in ESC sequence parser used when pseudo
> console is enabled in pty_master_fwd_thread(). Previously, if
> multiple ESC sequences exist in a fowarding chunk, the later one
> might not be processed appropriately. In addition, the termination
> ST was not supported, that is, only BEL was supported.

What's ST?  I only know STX, 0x02 in the C0 codeblock.  There's an ST in
the C1 codeblock, 0x9c, "String Terminator", but I don't see this in the
code, nor are the other C1 controls even recognized here.


Thanks,
Corinna


> Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pty.cc | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 679068ea2..3b0b4f073 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2680,7 +2680,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>  	  int state = 0;
>  	  int start_at = 0;
>  	  for (DWORD i=0; i<rlen; i++)
> -	    if (outbuf[i] == '\033')
> +	    if (state == 0 && outbuf[i] == '\033')
>  	      {
>  		start_at = i;
>  		state = 1;
> @@ -2688,12 +2688,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>  	      }
>  	    else if ((state == 1 && outbuf[i] == ']') ||
>  		     (state == 2 && outbuf[i] == '0') ||
> -		     (state == 3 && outbuf[i] == ';'))
> +		     (state == 3 && outbuf[i] == ';') ||
> +		     (state == 4 && outbuf[i] == '\033'))
>  	      {
>  		state ++;
>  		continue;
>  	      }
> -	    else if (state == 4 && outbuf[i] == '\a')
> +	    else if ((state == 4 && outbuf[i] == '\a')
> +		     || (state == 5 && outbuf[i] == '\\'))
>  	      {
>  		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
>  		if (memmem (&outbuf[start_at], i + 1 - start_at,
> @@ -2701,11 +2703,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>  		  {
>  		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
>  		    rlen = wlen = start_at + rlen - i - 1;
> +		    i = start_at - 1;
>  		  }
>  		state = 0;
>  		continue;
>  	      }
> -	    else if (outbuf[i] == '\a')
> +	    else if (state == 4)
> +	      continue;
> +	    else
>  	      {
>  		state = 0;
>  		continue;
> -- 
> 2.51.0
