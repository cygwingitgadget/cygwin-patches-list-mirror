Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A641B4BA2E05; Fri, 19 Dec 2025 09:42:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A641B4BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766137367;
	bh=9mrNvr8zsJLWrudIWVO6RDJ10eV57fKCewy8slVBnes=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=MDRyVzD6P2ht20MDrFhrzVisjPY3XjfucyloylhxYolGmNhK9zdmLr9Y2RB0ghBs4
	 OS3vw0aV79+wKD4BosAz0yRyp9iUvZ64hOu/JVVRyhXH1E1Cx3wGQnC1J+FD12cxIQ
	 an4JfjnWeA9tbEXed2Pu3GrUfxB+c8gA5jd2V8ME=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A660EA80797; Fri, 19 Dec 2025 10:42:45 +0100 (CET)
Date: Fri, 19 Dec 2025 10:42:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Refactor workaround code for pseudo console
 output
Message-ID: <aUUeFSTkhMvPAM6Z@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251219074831.953-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219074831.953-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

A few typos and the strlen bugs me...

On Dec 19 16:48, Takashi Yano wrote:
> Currently, there are four separate workarounds for pseudo console
> output in pty_master_fwd_thread. Each workaround has its own 'for'
> loop that iterates over the entire output buffer, which is not
> efficient. This patch consolidates these loops and introduces a
> single state machine to handle all worarounds at once. In addition,
                                     workarounds

> the workarouds are moved into a dedicated function,
      workarounds

> 'workarounds_for_pseudo_console_output()' to improve readability.
> 
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pty.cc | 283 ++++++++++++++++------------------
>  1 file changed, 129 insertions(+), 154 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 32e50540e..7fa747e0a 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2642,6 +2642,134 @@ pty_master_thread (VOID *arg)
>    return fhandler_pty_master::pty_master_thread (&p);
>  }
>  
> +static DWORD
> +workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
> +{
> +  int state = 0;
> +  int start_at = 0;
> +  bool is_csi = false;
> +  bool is_osc = false;
> +  int arg = 0;
> +  bool saw_greater_than_sign = false;
> +  for (DWORD i=0; i<rlen; i++)
> +    if (state == 0 && outbuf[i] == '\033')
> +      {
> +	start_at = i;
> +	state = 1;
> +	is_csi = false;
> +	is_osc = false;
> +	arg = 0;
> +	continue;
> +      }
> +    else if (state == 1)
> +      {
> +	switch (outbuf[i])
> +	  {
> +	  case '[':
> +	    is_csi = true;
> +	    state = 2;
> +	    break;
> +	  case ']':
> +	    is_osc = true;
> +	    state = 2;
> +	    break;
> +	  case '\033':
> +	    start_at = i;
> +	    state = 1;
> +	    break;
> +	  default:
> +	    state = 0;
> +	  }
> +	continue;
> +      }
> +    else if (is_csi)
> +      {
> +	if (state == 2 && outbuf[i] == '>')
> +	  saw_greater_than_sign = true;
> +	else if (state == 2 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
> +	  continue;
> +	else if (state == 2)
> +	  {
> +	    if (saw_greater_than_sign && outbuf[i] == 'm')
> +	      {
> +		/* Remove CSI > Pm m */
> +		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> +		rlen = start_at + rlen - i - 1;
> +		i = start_at - 1;
> +		state = 0;
> +	      }
> +	    else if (wincap.has_pcon_omit_nl_before_cursor_move ()
> +		     && !saw_greater_than_sign && outbuf[i] == 'H')
> +	      /* Workaround for rlwrap in Win11. rlwrap treats text between
> +		 NLs as a line, however, pseudo console in Win11 somtimes
                                                                 sometimes

> +		 omits NL before "CSIm;nH". This does not happen in Win10. */
> +	      {
> +		/* Add omitted CR NL before "CSIm;nH". However, when the
> +		   cusor is on the bottom-most line, adding NL might cause
                   cursor

> +		   unexpected scrolling. To avoid this, add "CSI H" before
> +		   CR NL. */

> +		const char *ins = "\033[H\r\n";
> +		const int ins_len = strlen (ins);

The strlen bugs me a bit.  The expression is static and the length is
static, maybe the entire thing should express it's static, kind of like
this?

                #define CSIH_INSERT "\033[H\r\n"
                #define CSIH_INSLEN (sizeof(CSIH_INSERT)-1)

> +		if (rlen + ins_len <= NT_MAX_PATH)
> +		  {
> +		    memmove (&outbuf[start_at + ins_len], &outbuf[start_at],
> +			     rlen - start_at);
> +		    memcpy (&outbuf[start_at], ins, ins_len);
> +		    rlen += ins_len;
> +		    i += ins_len;
> +		  }
> +	      }
> +	    state = 0;
> +	  }
> +	else if (outbuf[i] == '\033')
> +	  {
> +	    start_at = i;
> +	    is_csi = false;
> +	    state = 1;
> +	  }
> +	else
> +	  state = 0;
> +      }
> +    else if (is_osc)
> +      {
> +	if (state == 2 && isdigit (outbuf[i]))
> +	  arg = arg * 10 + (outbuf[i] - '0');
> +	else if (state == 2 && outbuf[i] == ';')
> +	  state = 3;
> +	else if (state == 3 && outbuf[i] == '\033')
> +	  state = 4;
> +	else if ((state == 3 && outbuf[i] == '\a')
> +		 || (state == 4 && outbuf[i] == '\\'))
> +	  {
> +	    const char *helper_str = "\\bin\\cygwin-console-helper.exe";

Same here...

    #define CONSOLE_HELPER ...
    #define CONSOLE_HELPER_LEN

?

> +	    if (outbuf[start_at + 4] == '?' /* OSC Ps; ? BEL/ST */
> +		/* Stray set title at the start up of pcon */
> +		|| (arg == 0 && memmem (&outbuf[start_at], i + 1 - start_at,
> +					helper_str, strlen (helper_str))))
> +	      {
> +		/* Remove this ESC sequence */
> +		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> +		rlen = start_at + rlen - i - 1;
> +		i = start_at - 1;
> +	      }
> +	    state = 0;
> +	  }
> +	else if (state == 3)
> +	  continue;
> +	else if (outbuf[i] == '\033')
> +	  {
> +	    start_at = i;
> +	    is_osc = false;
> +	    state = 1;
> +	  }
> +	else
> +	  state = 0;
> +      }
> +    else
> +      state = 0; /* Do not reach */
> +  return rlen;
> +}
> +
>  /* The function pty_master_fwd_thread() should be static because the
>     instance is deleted if the master is dup()'ed and the original is
>     closed. In this case, dup()'ed instance still exists, therefore,
> @@ -2676,160 +2804,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>        char *ptr = outbuf;
>        if (p->ttyp->pcon_activated)
>  	{
> -	  /* Avoid setting window title to "cygwin-console-helper.exe" */
> -	  int state = 0;
> -	  int start_at = 0;
> -	  for (DWORD i=0; i<rlen; i++)
> -	    if (state == 0 && outbuf[i] == '\033')
> -	      {
> -		start_at = i;
> -		state = 1;
> -		continue;
> -	      }
> -	    else if ((state == 1 && outbuf[i] == ']') ||
> -		     (state == 2 && outbuf[i] == '0') ||
> -		     (state == 3 && outbuf[i] == ';') ||
> -		     (state == 4 && outbuf[i] == '\033'))
> -	      {
> -		state ++;
> -		continue;
> -	      }
> -	    else if ((state == 4 && outbuf[i] == '\a')
> -		     || (state == 5 && outbuf[i] == '\\'))
> -	      {
> -		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
> -		if (memmem (&outbuf[start_at], i + 1 - start_at,
> -			    helper_str, strlen (helper_str)))
> -		  {
> -		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> -		    rlen = wlen = start_at + rlen - i - 1;
> -		    i = start_at - 1;
> -		  }
> -		state = 0;
> -		continue;
> -	      }
> -	    else if (state == 4)
> -	      continue;
> -	    else if (outbuf[i] == '\033')
> -	      {
> -		start_at = i;
> -		state = 1;
> -		continue;
> -	      }
> -	    else
> -	      {
> -		state = 0;
> -		continue;
> -	      }
> -
> -	  /* Remove CSI > Pm m */
> -	  state = 0;
> -	  for (DWORD i = 0; i < rlen; i++)
> -	    if (outbuf[i] == '\033')
> -	      {
> -		start_at = i;
> -		state = 1;
> -		continue;
> -	      }
> -	    else if ((state == 1 && outbuf[i] == '[')
> -		     || (state == 2 && outbuf[i] == '>'))
> -	      {
> -		state ++;
> -		continue;
> -	      }
> -	    else if (state == 3 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
> -	      continue;
> -	    else if (state == 3 && outbuf[i] == 'm')
> -	      {
> -		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> -		rlen = wlen = start_at + rlen - i - 1;
> -		state = 0;
> -		i = start_at - 1;
> -		continue;
> -	      }
> -	    else
> -	      state = 0;
> -
> -	  /* Remove OSC Ps ; ? BEL/ST */
> -	  state = 0;
> -	  for (DWORD i = 0; i < rlen; i++)
> -	    if (state == 0 && outbuf[i] == '\033')
> -	      {
> -		start_at = i;
> -		state = 1;
> -		continue;
> -	      }
> -	    else if ((state == 1 && outbuf[i] == ']')
> -		     || (state == 2 && outbuf[i] == ';')
> -		     || (state == 3 && outbuf[i] == '?')
> -		     || (state == 4 && outbuf[i] == '\033'))
> -	      {
> -		state ++;
> -		continue;
> -	      }
> -	    else if (state == 2 && isdigit (outbuf[i]))
> -	      continue;
> -	    else if ((state == 4 && outbuf[i] == '\a')
> -		     || (state == 5 && outbuf[i] == '\\'))
> -	      {
> -		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> -		rlen = wlen = start_at + rlen - i - 1;
> -		state = 0;
> -		i = start_at - 1;
> -		continue;
> -	      }
> -	    else if (outbuf[i] == '\033')
> -	      {
> -		start_at = i;
> -		state = 1;
> -		continue;
> -	      }
> -	    else
> -	      state = 0;
> -
> -	  /* Workaround for rlwrap in Win11. rlwrap treats text between
> -	     NLs as a line, however, pseudo console in Win11 somtimes
> -	     omits NL before "CSIm;nH". This does not happen in Win10. */
> -	  if (wincap.has_pcon_omit_nl_before_cursor_move ())
> -	    {
> -	      state = 0;
> -	      for (DWORD i = 0; i < rlen; i++)
> -		if (state == 0 && outbuf[i] == '\033')
> -		  {
> -		    start_at = i;
> -		    state++;
> -		    continue;
> -		  }
> -		else if (state == 1 && outbuf[i] == '[')
> -		  {
> -		    state++;
> -		    continue;
> -		  }
> -		else if (state == 2
> -			 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
> -		  continue;
> -		else if (state == 2 && outbuf[i] == 'H')
> -		  {
> -		    /* Add omitted CR NL before "CSIm;nH". However, when the
> -		       cusor is on the bottom-most line, adding NL might cause
> -		       unexpected scrolling. To avoid this, add "CSI H" before
> -		       CR NL. */
> -		    const char *ins = "\033[H\r\n";
> -		    const int ins_len = strlen (ins);
> -		    if (rlen + ins_len <= NT_MAX_PATH)
> -		      {
> -			memmove (&outbuf[start_at + ins_len],
> -				 &outbuf[start_at], rlen - start_at);
> -			memcpy (&outbuf[start_at], ins, ins_len);
> -			rlen += ins_len;
> -			i += ins_len;
> -		      }
> -		    state = 0;
> -		    continue;
> -		  }
> -		else
> -		  state = 0;
> -	    }
> +	  wlen = rlen = workarounds_for_pseudo_console_output (outbuf, rlen);
>  
>  	  if (p->ttyp->term_code_page != CP_UTF8)
>  	    {
> -- 
> 2.51.0
