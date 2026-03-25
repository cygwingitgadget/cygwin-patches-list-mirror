Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 385244BA2E09; Wed, 25 Mar 2026 19:22:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 385244BA2E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774466537;
	bh=DMyAP2c14wcCzyub+H+Mzx1RWi+E+TaSVgkYTtK713I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VhqsTCghzHEBcsMyAJySTsEaGXfwMZriZzDSpY5kQr8NmxY2WWelmt5lNpxwSgrKu
	 Lr6FcXPW6+YGx1iTHMHytFNKlvSZm+qmYtGGbSom8wSaGg9zj+pm3W2eMKMVfBw74c
	 mnff4UtLM6Ld8b2ts3hYUXLB09mtkzDhB1XG5UZI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6D4C6A805DF; Wed, 25 Mar 2026 20:22:15 +0100 (CET)
Date: Wed, 25 Mar 2026 20:22:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Omit CSI?1004h/l from pseudo console output
Message-ID: <acQ155Qe0lamPNNA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260309092442.1502-1-takashi.yano@nifty.ne.jp>
 <acQzsE9p03u7UJsZ@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acQzsE9p03u7UJsZ@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Mar 25 20:12, Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Mar  9 18:24, Takashi Yano wrote:
> > "CSI?1004h" is the sequence that enabes focus event report. This
>                                    enables
> 
> > can be handle correctly by pseudo console, however, if the pty
> > input is not connected to pseudo console, the focus event responces
>                                                             responses
> 
> > such as "CSI I/O" are sent to the foreground process. Due to this,
> > `cat` receives these responces unexpectedly in the command below.
>                        responses
> > 
> > $ cmd &
> > $ cat
> > 
> > This seems to happen after Windows 11.
> 
> Not sure what this means. What is after W11?  Do you mean it happens
> since W11 already?
> 
> > 
> > To avoid this, this patch removes "CSI?1004h/l" from pseudo console
> > output.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 0717c043b..65b10dd62 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2760,7 +2760,8 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
> >  	      }
> >  	    state = 0;
> >  	  }
> > -	else if (saw_question_mark && arg == 9001
> > +	else if (saw_question_mark
> > +		 && (arg == 9001 || arg == 1004)
> >  		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
> >  	  {
> >  	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
> > -- 
> > 2.51.0

Other than the above commit message stuff, LGTM.

Corinna
