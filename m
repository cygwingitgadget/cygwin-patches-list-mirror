Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id E07B94BA2E07
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 10:32:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E07B94BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E07B94BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765967524; cv=none;
	b=URWhg+Ypv671Pr2hs+jUfFACYx/TT0Dn0YJhPMYn+GiwSw2AduZjkk/ZpDf0nbfTGWH9cPzvHrS93DvXz590M+mh/nwa6QorQGEacZJFlRk31VHnsYYGMaO7GJTHo54EdY5DJc0sn82P/dMh3cp8zMi5HJzpuMk7SVV8E3YoPcE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765967524; c=relaxed/simple;
	bh=dxad7wWzOyGKik//I5Cf6LFWWYpgHBu28+qctTuS/U4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=dNswldIViDDJiwgQbA8U0sPt0zCkinJBgcxmRJB2oeSg1mKJFn7xApE5juxun4Rn6R0G05CzFGskvn+OLeus7ZY2W3KSHYttCoxN8We/p8RyQZjaYX9hKpGPNV9zgf2kQZCZZVQ4SWu5klf/S4tr73Ki4bJMOCmfITxLm8a6mMA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E07B94BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=q2/UEASc
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20251217103202049.NMOB.120311.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 19:32:02 +0900
Date: Wed, 17 Dec 2025 19:32:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Add new workaround for rlwrap in pcon
 enabled mode
Message-Id: <20251217193200.6da09bfe1992af3ddb66140e@nifty.ne.jp>
In-Reply-To: <aUFQhE-Ts6fLvz-I@calimero.vinschen.de>
References: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
	<20251210015233.1368-3-takashi.yano@nifty.ne.jp>
	<aUFQhE-Ts6fLvz-I@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765967522;
 bh=TiHJx8KEU+NW2zZMBS+CCF6FgrJJxLhfi2s4bTihQKE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=q2/UEAScX0tJwPgzhzye8XzsVbntf+2RjrOyyXA1ZHT64gllQHhsq7BJOJCHdZm9rKAAEnyx
 NnjhkrXDQ7CY9go4hUcezsJpIs0UzHBqd2NRsIJJI3aP3yJX1pkXauTN4cowTdSn0T+/FKjhW2
 s5l1EPSk8ziUJvaiCOj2PNxsmYkXV78OZx14ptvKAreRxgRtY9cqcJKJN1YY0hvReil6AUjUsr
 BuiD52hMUaUu/KkWG759kWzJ+AllcHlcFzXgj721+VF28r+PX0nOf6a/46UlWbLxJMIRKgn/xJ
 3nsGN2VQdA/qHun7imsv8ciDILCxRJkzqBwZ3qfGIt1BYa5A==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 16 Dec 2025 13:28:52 +0100
Corinna Vinschen wrote:

> On Dec 10 10:52, Takashi Yano wrote:
> > In Windows 11, the command "rlwrap cmd" outputs garbaged screen.
> > This is because rlwrap treats text between NLs as a line, while
> > pseudo console sometimes ommits NL before "CISm;nH". This issue
> 
>                                              CSI
> 
> > does not happen in Windows 10. This patch fixes the issue.
> > 
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 3b0b4f073..5c02a4111 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2775,6 +2775,40 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
> >  	    else
> >  	      state = 0;
> >  
> > +	  /* Workaround for rlwrap */
> 
> I think the comment should mention that this is necessary since W11
> only.  And maybe the code should only run on systems needing it?

Yes.

> Is that a problem in W11 conhost which has been fixed in OpenConsole
> already, by any chance?  
Yes.

> If so, that would be a good indicator for
> always including a self-built OpenConsole package into our distro...

Maybe. I don't try to build OpenConsole in cygwin environment yet...

> > +	  /* rlwarp treats text between NLs as a line, however,
> 
>              rlwrap
> 
> > +	     pseudo console somtimes ommits NL before "CSIm;nH". */
> > +	  state = 0;
> > +	  for (DWORD i = 0; i < rlen; i++)
> > +	    if (state == 0 && outbuf[i] == '\033')
> > +	      {
> > +		start_at = i;
> > +		state++;
> > +		continue;
> > +	      }
> > +	    else if (state == 1 && outbuf[i] == '[')
> > +	      {
> > +		state++;
> > +		continue;
> > +	      }
> > +	    else if (state == 2 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
> > +	      continue;
> > +	    else if (state == 2 && outbuf[i] == 'H')
> > +	      {
> > +		/* Add "CSI H" before CR NL to avoid unexpected scroll */
> > +		const char *ins = "\033[H\r\n";
> > +		const int ins_len = strlen (ins);
> > +		memmove (&outbuf[start_at + ins_len], &outbuf[start_at],
> > +			 rlen - start_at);
> > +		memcpy (&outbuf[start_at], ins, ins_len);
> > +		rlen += ins_len;
> > +		i += ins_len;
> > +		state = 0;
> > +		continue;
> 
> I don't understand this code.  The commit message says, the pseudo
> console omits NL before CSI H, so I would expect this code to add a
> missing NL.  But instead it adds a CSI H?  What am I missing?

'\r\n' is added. CSI H is added in order to avoid extra scrolling when
the cursor is on bottom-most line.

After "CSI H \r\n", CSI m;nH will come, so CSI H does not change the
screen.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
