Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F37E34B9DB51; Wed, 25 Mar 2026 19:12:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F37E34B9DB51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774465970;
	bh=f8N5ikPB+Jnvm+gWBbmbJfR1EU0aRApXC4mVe01+Ibc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=UAaC95Tb4FYCvsl+kcss7libno/WuuJbUfqA7ac6ZcVEw3BckIPW88rtABB1CSk3t
	 sUtnCIitZyAkBKXx3RZ8Pzx3+BBADuQm/+GydhQuOkao13SP4ZvuAe6Qmp5sTpKzpb
	 xK6lMEO16eTZ/L5v98SNMgo/ykeqfJtqKtOLicSM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2F7DCA805DF; Wed, 25 Mar 2026 20:12:48 +0100 (CET)
Date: Wed, 25 Mar 2026 20:12:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Omit CSI?1004h/l from pseudo console output
Message-ID: <acQzsE9p03u7UJsZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260309092442.1502-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309092442.1502-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mar  9 18:24, Takashi Yano wrote:
> "CSI?1004h" is the sequence that enabes focus event report. This
                                   enables

> can be handle correctly by pseudo console, however, if the pty
> input is not connected to pseudo console, the focus event responces
                                                            responses

> such as "CSI I/O" are sent to the foreground process. Due to this,
> `cat` receives these responces unexpectedly in the command below.
                       responses
> 
> $ cmd &
> $ cat
> 
> This seems to happen after Windows 11.

Not sure what this means. What is after W11?  Do you mean it happens
since W11 already?


Thanks,
Corinna


> 
> To avoid this, this patch removes "CSI?1004h/l" from pseudo console
> output.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 0717c043b..65b10dd62 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2760,7 +2760,8 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
>  	      }
>  	    state = 0;
>  	  }
> -	else if (saw_question_mark && arg == 9001
> +	else if (saw_question_mark
> +		 && (arg == 9001 || arg == 1004)
>  		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
>  	  {
>  	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> -- 
> 2.51.0
