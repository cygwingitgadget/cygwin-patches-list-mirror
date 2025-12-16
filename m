Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8B0974BA2E04; Tue, 16 Dec 2025 12:28:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8B0974BA2E04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765888134;
	bh=CdULQ5rmXMtBkkGAeav0AUWjH7qpXpY0JEWthAk1phw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=o/6S4PWDZbd2J6i+rHD6fUNTLYkf1WuGXnUKG7Eotb7IR886Uo5efASvLXlnodMJc
	 NvHvQ4u9E9jFf1f2J9WdOr/VU8l/w6y+m/5XtQ8Z/YAqvtNP6621ne8uuwYkchCFGd
	 vGExfsZncLf1+/kB1zIKInlpQr6o4SoVjGDqN2fI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 93A14A804CD; Tue, 16 Dec 2025 13:28:52 +0100 (CET)
Date: Tue, 16 Dec 2025 13:28:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Add new workaround for rlwrap in pcon
 enabled mode
Message-ID: <aUFQhE-Ts6fLvz-I@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
 <20251210015233.1368-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251210015233.1368-3-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 10 10:52, Takashi Yano wrote:
> In Windows 11, the command "rlwrap cmd" outputs garbaged screen.
> This is because rlwrap treats text between NLs as a line, while
> pseudo console sometimes ommits NL before "CISm;nH". This issue

                                             CSI

> does not happen in Windows 10. This patch fixes the issue.
> 
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pty.cc | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 3b0b4f073..5c02a4111 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2775,6 +2775,40 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>  	    else
>  	      state = 0;
>  
> +	  /* Workaround for rlwrap */

I think the comment should mention that this is necessary since W11
only.  And maybe the code should only run on systems needing it?

Is that a problem in W11 conhost which has been fixed in OpenConsole
already, by any chance?  If so, that would be a good indicator for
always including a self-built OpenConsole package into our distro...

> +	  /* rlwarp treats text between NLs as a line, however,

             rlwrap

> +	     pseudo console somtimes ommits NL before "CSIm;nH". */
> +	  state = 0;
> +	  for (DWORD i = 0; i < rlen; i++)
> +	    if (state == 0 && outbuf[i] == '\033')
> +	      {
> +		start_at = i;
> +		state++;
> +		continue;
> +	      }
> +	    else if (state == 1 && outbuf[i] == '[')
> +	      {
> +		state++;
> +		continue;
> +	      }
> +	    else if (state == 2 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
> +	      continue;
> +	    else if (state == 2 && outbuf[i] == 'H')
> +	      {
> +		/* Add "CSI H" before CR NL to avoid unexpected scroll */
> +		const char *ins = "\033[H\r\n";
> +		const int ins_len = strlen (ins);
> +		memmove (&outbuf[start_at + ins_len], &outbuf[start_at],
> +			 rlen - start_at);
> +		memcpy (&outbuf[start_at], ins, ins_len);
> +		rlen += ins_len;
> +		i += ins_len;
> +		state = 0;
> +		continue;

I don't understand this code.  The commit message says, the pseudo
console omits NL before CSI H, so I would expect this code to add a
missing NL.  But instead it adds a CSI H?  What am I missing?


Thanks,
Corinna
