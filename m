Return-Path: <SRS0=Uj6Q=6Z=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id EC9F94BA2E07
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 08:10:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC9F94BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EC9F94BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766131802; cv=none;
	b=qQp7jIjfWbUv5jYmfrHF4qA/NRZNITOsYrzjGcs84rbrFN1LdMHlyvtgPVoeNgpr8/g/3QkgQMs5+uhx6zc6WwnGPuSp2TiklXT7ByoKvgkVTtG0WNJbWs6At2YtFmAkOwzEJExABVcUyF/ggJUWURrOswdMfAhmKNi4c3SQK6U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766131802; c=relaxed/simple;
	bh=BwG3pGPG2AfedAR5l1DWwRIHING8aM25Gz+WEP82pMg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=sLfkm2skN/CZK5srxqH7y5DfCnLgkFcoSViNmiCllHBqsPoskny9vsPLAl2Ntwy9vYeRtvsoLmjB94EGQobXFkhw9X1r0aabVN9obvQzL1CwLNHDRXe8E9MbeXzlfbjRSll2DuO7cAp2GXybbdJEBGM1owtg4P33pTbrQ32yyI8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EC9F94BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Y2Pz8zZM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766131800; x=1766736600;
	i=johannes.schindelin@gmx.de;
	bh=Foj5UzVQcwYsCKpsEdsd0GbWMUtAlBr+KAUKLHVSX5M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y2Pz8zZMoUPZbj1dONIpLLsB4UobwchpHX/aeeFJ/2ZGumRvYISMk4mbABL0Blc6
	 8Oq3JJDGJA5OguynUQUnRAvly+oTkcscWeqbrF688XVvDYuoS5ZHdbi5oSlxmCZvP
	 fd8PoSWHFyruXtG7MG+fRDZRJ335JCsb6UUPCvs0cQNPJBNiieDdGy6DX78WqZuvS
	 6LZbhSsa4JEzqQzrPeSMt7YxfvXq1FqFGYL73HJxn9kQfcXM+/Ppsw7+fGUPIITAX
	 QF++08mofYq/9svqn9IcveZFhAx0kqMlG2mdd8t27GOfwoCO56iAjP/31Hnfdl0E8
	 0QAwd946BoxSsukxEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1vmwaD2HIr-00yWpb; Fri, 19
 Dec 2025 09:10:00 +0100
Date: Fri, 19 Dec 2025 09:09:59 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Refactor workaround code for pseudo console
 output
In-Reply-To: <20251219074831.953-1-takashi.yano@nifty.ne.jp>
Message-ID: <754f35dc-43d2-d7ef-22b3-e677a22814a8@gmx.de>
References: <20251219074831.953-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ph7cQXmKe1DWytoXRZ4PKhZ8g3Tu+UkQtcNkvCrsHWY/ZByxwj3
 l/LE+eZ6CHNpXXjxvQ9U75WhrBor4UjATsw+w2CuyoePZS+Yy2MWMkc2G+u/54mP0W2DpcX
 flrEkes6YHwA9qCWxTErB456x6C6beB2reUOoZf1QQvxEEM3hvYuR6cGEFTO9lkMV5aBVyH
 L21jihOn6Kl31WTigIKVw==
UI-OutboundReport: notjunk:1;M01:P0:a6yOb3BFXJs=;RsO0SCFUpI7qqES962ksO6MRpJy
 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
 iYb0e/XI=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 19 Dec 2025, Takashi Yano wrote:

> Currently, there are four separate workarounds for pseudo console
> output in pty_master_fwd_thread. Each workaround has its own 'for'
> loop that iterates over the entire output buffer, which is not
> efficient. This patch consolidates these loops and introduces a
> single state machine to handle all worarounds at once. In addition,
> the workarouds are moved into a dedicated function,
> 'workarounds_for_pseudo_console_output()' to improve readability.

Thank you for spending the time and effort to write this commit message. I
find it quite clear.

And of course: Thank you for implementing this!

> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pty.cc | 283 ++++++++++++++++------------------
>  1 file changed, 129 insertions(+), 154 deletions(-)

Very nice.

> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 32e50540e..7fa747e0a 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2642,6 +2642,134 @@ pty_master_thread (VOID *arg)
>    return fhandler_pty_master::pty_master_thread (&p);
>  }
> =20
> +static DWORD
> +workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
> +{
> +  int state =3D 0;
> +  int start_at =3D 0;
> +  bool is_csi =3D false;
> +  bool is_osc =3D false;
> +  int arg =3D 0;
> +  bool saw_greater_than_sign =3D false;

I had something slightly different in mind, and it might very well be
over-engineered and/or less readable:

- Instead of is_csi/is_osc/saw_greater_than_sign, I thought about fanning
  out state, so that state =3D 2 means we just saw CSI, state =3D 3 means =
we
  saw OSC, state =3D 4 means we saw a number after CSI, etc.

- Since those numbers would now be quite magic, I thought about using an
  `enum` to clarify their purposes.

Having written all that, I have to admit that your variant of the patch is
eminently easier to review.

> +  for (DWORD i=3D0; i<rlen; i++)
> +    if (state =3D=3D 0 && outbuf[i] =3D=3D '\033')
> +      {
> +	start_at =3D i;
> +	state =3D 1;
> +	is_csi =3D false;
> +	is_osc =3D false;
> +	arg =3D 0;
> +	continue;
> +      }
> +    else if (state =3D=3D 1)
> +      {
> +	switch (outbuf[i])
> +	  {
> +	  case '[':
> +	    is_csi =3D true;
> +	    state =3D 2;
> +	    break;
> +	  case ']':
> +	    is_osc =3D true;
> +	    state =3D 2;
> +	    break;
> +	  case '\033':
> +	    start_at =3D i;
> +	    state =3D 1;
> +	    break;
> +	  default:
> +	    state =3D 0;
> +	  }
> +	continue;
> +      }
> +    else if (is_csi)
> +      {
> +	if (state =3D=3D 2 && outbuf[i] =3D=3D '>')
> +	  saw_greater_than_sign =3D true;
> +	else if (state =3D=3D 2 && (isdigit (outbuf[i]) || outbuf[i] =3D=3D ';=
'))
> +	  continue;
> +	else if (state =3D=3D 2)
> +	  {

The two previous `if`/`else if` both have the same `state =3D=3D 2` condit=
ion
and could be folded into this here conditional block. I am not quite sure,
though, that that would be desirable: Treating `>` and digits and `;`
visually separately from the logic that looks at the end of the ANSI
sequences reduces the cognitive load, I find.

All this is to say: I reviewed this patch the best way I can, and I like
it!

Thank you,
Johannes

> +	    if (saw_greater_than_sign && outbuf[i] =3D=3D 'm')
> +	      {
> +		/* Remove CSI > Pm m */
> +		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> +		rlen =3D start_at + rlen - i - 1;
> +		i =3D start_at - 1;
> +		state =3D 0;
> +	      }
> +	    else if (wincap.has_pcon_omit_nl_before_cursor_move ()
> +		     && !saw_greater_than_sign && outbuf[i] =3D=3D 'H')
> +	      /* Workaround for rlwrap in Win11. rlwrap treats text between
> +		 NLs as a line, however, pseudo console in Win11 somtimes
> +		 omits NL before "CSIm;nH". This does not happen in Win10. */
> +	      {
> +		/* Add omitted CR NL before "CSIm;nH". However, when the
> +		   cusor is on the bottom-most line, adding NL might cause
> +		   unexpected scrolling. To avoid this, add "CSI H" before
> +		   CR NL. */
> +		const char *ins =3D "\033[H\r\n";
> +		const int ins_len =3D strlen (ins);
> +		if (rlen + ins_len <=3D NT_MAX_PATH)
> +		  {
> +		    memmove (&outbuf[start_at + ins_len], &outbuf[start_at],
> +			     rlen - start_at);
> +		    memcpy (&outbuf[start_at], ins, ins_len);
> +		    rlen +=3D ins_len;
> +		    i +=3D ins_len;
> +		  }
> +	      }
> +	    state =3D 0;
> +	  }
> +	else if (outbuf[i] =3D=3D '\033')
> +	  {
> +	    start_at =3D i;
> +	    is_csi =3D false;
> +	    state =3D 1;
> +	  }
> +	else
> +	  state =3D 0;
> +      }
> +    else if (is_osc)
> +      {
> +	if (state =3D=3D 2 && isdigit (outbuf[i]))
> +	  arg =3D arg * 10 + (outbuf[i] - '0');
> +	else if (state =3D=3D 2 && outbuf[i] =3D=3D ';')
> +	  state =3D 3;
> +	else if (state =3D=3D 3 && outbuf[i] =3D=3D '\033')
> +	  state =3D 4;
> +	else if ((state =3D=3D 3 && outbuf[i] =3D=3D '\a')
> +		 || (state =3D=3D 4 && outbuf[i] =3D=3D '\\'))
> +	  {
> +	    const char *helper_str =3D "\\bin\\cygwin-console-helper.exe";
> +	    if (outbuf[start_at + 4] =3D=3D '?' /* OSC Ps; ? BEL/ST */
> +		/* Stray set title at the start up of pcon */
> +		|| (arg =3D=3D 0 && memmem (&outbuf[start_at], i + 1 - start_at,
> +					helper_str, strlen (helper_str))))
> +	      {
> +		/* Remove this ESC sequence */
> +		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> +		rlen =3D start_at + rlen - i - 1;
> +		i =3D start_at - 1;
> +	      }
> +	    state =3D 0;
> +	  }
> +	else if (state =3D=3D 3)
> +	  continue;
> +	else if (outbuf[i] =3D=3D '\033')
> +	  {
> +	    start_at =3D i;
> +	    is_osc =3D false;
> +	    state =3D 1;
> +	  }
> +	else
> +	  state =3D 0;
> +      }
> +    else
> +      state =3D 0; /* Do not reach */
> +  return rlen;
> +}
> +
>  /* The function pty_master_fwd_thread() should be static because the
>     instance is deleted if the master is dup()'ed and the original is
>     closed. In this case, dup()'ed instance still exists, therefore,
> @@ -2676,160 +2804,7 @@ fhandler_pty_master::pty_master_fwd_thread (cons=
t master_fwd_thread_param_t *p)
>        char *ptr =3D outbuf;
>        if (p->ttyp->pcon_activated)
>  	{
> -	  /* Avoid setting window title to "cygwin-console-helper.exe" */
> -	  int state =3D 0;
> -	  int start_at =3D 0;
> -	  for (DWORD i=3D0; i<rlen; i++)
> -	    if (state =3D=3D 0 && outbuf[i] =3D=3D '\033')
> -	      {
> -		start_at =3D i;
> -		state =3D 1;
> -		continue;
> -	      }
> -	    else if ((state =3D=3D 1 && outbuf[i] =3D=3D ']') ||
> -		     (state =3D=3D 2 && outbuf[i] =3D=3D '0') ||
> -		     (state =3D=3D 3 && outbuf[i] =3D=3D ';') ||
> -		     (state =3D=3D 4 && outbuf[i] =3D=3D '\033'))
> -	      {
> -		state ++;
> -		continue;
> -	      }
> -	    else if ((state =3D=3D 4 && outbuf[i] =3D=3D '\a')
> -		     || (state =3D=3D 5 && outbuf[i] =3D=3D '\\'))
> -	      {
> -		const char *helper_str =3D "\\bin\\cygwin-console-helper.exe";
> -		if (memmem (&outbuf[start_at], i + 1 - start_at,
> -			    helper_str, strlen (helper_str)))
> -		  {
> -		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> -		    rlen =3D wlen =3D start_at + rlen - i - 1;
> -		    i =3D start_at - 1;
> -		  }
> -		state =3D 0;
> -		continue;
> -	      }
> -	    else if (state =3D=3D 4)
> -	      continue;
> -	    else if (outbuf[i] =3D=3D '\033')
> -	      {
> -		start_at =3D i;
> -		state =3D 1;
> -		continue;
> -	      }
> -	    else
> -	      {
> -		state =3D 0;
> -		continue;
> -	      }
> -
> -	  /* Remove CSI > Pm m */
> -	  state =3D 0;
> -	  for (DWORD i =3D 0; i < rlen; i++)
> -	    if (outbuf[i] =3D=3D '\033')
> -	      {
> -		start_at =3D i;
> -		state =3D 1;
> -		continue;
> -	      }
> -	    else if ((state =3D=3D 1 && outbuf[i] =3D=3D '[')
> -		     || (state =3D=3D 2 && outbuf[i] =3D=3D '>'))
> -	      {
> -		state ++;
> -		continue;
> -	      }
> -	    else if (state =3D=3D 3 && (isdigit (outbuf[i]) || outbuf[i] =3D=
=3D ';'))
> -	      continue;
> -	    else if (state =3D=3D 3 && outbuf[i] =3D=3D 'm')
> -	      {
> -		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> -		rlen =3D wlen =3D start_at + rlen - i - 1;
> -		state =3D 0;
> -		i =3D start_at - 1;
> -		continue;
> -	      }
> -	    else
> -	      state =3D 0;
> -
> -	  /* Remove OSC Ps ; ? BEL/ST */
> -	  state =3D 0;
> -	  for (DWORD i =3D 0; i < rlen; i++)
> -	    if (state =3D=3D 0 && outbuf[i] =3D=3D '\033')
> -	      {
> -		start_at =3D i;
> -		state =3D 1;
> -		continue;
> -	      }
> -	    else if ((state =3D=3D 1 && outbuf[i] =3D=3D ']')
> -		     || (state =3D=3D 2 && outbuf[i] =3D=3D ';')
> -		     || (state =3D=3D 3 && outbuf[i] =3D=3D '?')
> -		     || (state =3D=3D 4 && outbuf[i] =3D=3D '\033'))
> -	      {
> -		state ++;
> -		continue;
> -	      }
> -	    else if (state =3D=3D 2 && isdigit (outbuf[i]))
> -	      continue;
> -	    else if ((state =3D=3D 4 && outbuf[i] =3D=3D '\a')
> -		     || (state =3D=3D 5 && outbuf[i] =3D=3D '\\'))
> -	      {
> -		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> -		rlen =3D wlen =3D start_at + rlen - i - 1;
> -		state =3D 0;
> -		i =3D start_at - 1;
> -		continue;
> -	      }
> -	    else if (outbuf[i] =3D=3D '\033')
> -	      {
> -		start_at =3D i;
> -		state =3D 1;
> -		continue;
> -	      }
> -	    else
> -	      state =3D 0;
> -
> -	  /* Workaround for rlwrap in Win11. rlwrap treats text between
> -	     NLs as a line, however, pseudo console in Win11 somtimes
> -	     omits NL before "CSIm;nH". This does not happen in Win10. */
> -	  if (wincap.has_pcon_omit_nl_before_cursor_move ())
> -	    {
> -	      state =3D 0;
> -	      for (DWORD i =3D 0; i < rlen; i++)
> -		if (state =3D=3D 0 && outbuf[i] =3D=3D '\033')
> -		  {
> -		    start_at =3D i;
> -		    state++;
> -		    continue;
> -		  }
> -		else if (state =3D=3D 1 && outbuf[i] =3D=3D '[')
> -		  {
> -		    state++;
> -		    continue;
> -		  }
> -		else if (state =3D=3D 2
> -			 && (isdigit (outbuf[i]) || outbuf[i] =3D=3D ';'))
> -		  continue;
> -		else if (state =3D=3D 2 && outbuf[i] =3D=3D 'H')
> -		  {
> -		    /* Add omitted CR NL before "CSIm;nH". However, when the
> -		       cusor is on the bottom-most line, adding NL might cause
> -		       unexpected scrolling. To avoid this, add "CSI H" before
> -		       CR NL. */
> -		    const char *ins =3D "\033[H\r\n";
> -		    const int ins_len =3D strlen (ins);
> -		    if (rlen + ins_len <=3D NT_MAX_PATH)
> -		      {
> -			memmove (&outbuf[start_at + ins_len],
> -				 &outbuf[start_at], rlen - start_at);
> -			memcpy (&outbuf[start_at], ins, ins_len);
> -			rlen +=3D ins_len;
> -			i +=3D ins_len;
> -		      }
> -		    state =3D 0;
> -		    continue;
> -		  }
> -		else
> -		  state =3D 0;
> -	    }
> +	  wlen =3D rlen =3D workarounds_for_pseudo_console_output (outbuf, rle=
n);
> =20
>  	  if (p->ttyp->term_code_page !=3D CP_UTF8)
>  	    {
> --=20
> 2.51.0
>=20
>=20
