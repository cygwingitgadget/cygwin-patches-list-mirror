Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id AF6CA4BA2E04
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 05:04:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AF6CA4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AF6CA4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766120687; cv=none;
	b=wykVhpYQbdPafQwiShonZ1g97M2fosTjBu1rPVF8SSUZwRGOleHmiSEeOxbDhRv2NHfk5GlnZAuXgdGh70+I8H/i5nYh+1oB7lw43WwWHIJOpJtxXlSJ/viR+SEdeccjZv1D6Xifmx6hXyBIdpDAzZrrlACumAVPpU575QZMnWw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766120687; c=relaxed/simple;
	bh=7E64zYUcZQTmXF5zWFoJE6i1nAIvOfOyFHcdGlES9ao=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=GnBikrCp3Az6IZvEI5gp7NS+4+m+KokPiu4GMltZh7KRFYwwJEm8ZW/r4tob9PaJNKNbwbz76ZdpLqxpsnzOVXf10oGHEdriQFvO8xZqwA/a6dqvlLO/NZ14p2vr7CVufkmaYflmK3qWeoZ8w6lutqzrH5MwE9CvGDO/cvMWA5U=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AF6CA4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=T/F/VFJ+
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20251219050444762.IUPJ.15876.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 14:04:44 +0900
Date: Fri, 19 Dec 2025 14:04:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: pty: Add new workaround for rlwrap in
 pcon enabled mode
Message-Id: <20251219140443.f1597c3b8981f31b61e64ca3@nifty.ne.jp>
In-Reply-To: <44b4f408-477d-f179-61ce-716c06e99495@gmx.de>
References: <20251218072722.1634-1-takashi.yano@nifty.ne.jp>
	<20251218072722.1634-3-takashi.yano@nifty.ne.jp>
	<44b4f408-477d-f179-61ce-716c06e99495@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766120684;
 bh=af8BUjsqNBw+Tr59LvtPvNzeY/2N5BCD7dLKrJH36eo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=T/F/VFJ+ILcWkTU6oc5DfDj3cdmLA5pgIgtVaFNYt/4GAAakgmrcqTVqup4iwsPB1ZZRm6kZ
 EAgUoCS826EhbyGOVqZWXrM4FkuDQaq6pPnZ4t2TFUWJHjXHeNTERl8YMFQhCKUKuqBvg6W8uu
 3lMGQMIYeaCzUm0+Km4n+S72HTen/M51oQrF6CmBlGj7xynzsDWFcNzVLQBDnoKid5zvkg7VpM
 hMLG6J5+dJpzKre3u3vvn83dTPvBt9qOU3gi3u+t1kF3JJ0WR/RKVsXPyxN8A+8cbL2EXlnSqr
 OSjwq4ijxpLq8gMxYesGtGQTOzt4amY2harvGXimDQ3579UA==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 18 Dec 2025 10:04:13 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 18 Dec 2025, Takashi Yano wrote:
> 
> > In Windows 11, the command "rlwrap cmd" outputs garbaged screen.
> > This is because rlwrap treats text between NLs as a line, while
> > pseudo console sometimes omits NL before "CSIm;nH". This issue
> > does not happen in Windows 10. This patch fixes the issue by
> > adding CR NL before "CSIm:nH" into the output from the pseudo
> > console if the OS is Windows 11.
> > 
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/pty.cc         | 44 +++++++++++++++++++++++++++
> >  winsup/cygwin/local_includes/wincap.h |  2 ++
> >  winsup/cygwin/wincap.cc               | 11 +++++++
> >  3 files changed, 57 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 3b0b4f073..7acedc165 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2775,6 +2775,50 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
> >  	    else
> >  	      state = 0;
> >  
> > +	  /* Workaround for rlwrap in Win11. rlwrap treats text between
> > +	     NLs as a line, however, pseudo console in Win11 somtimes
> > +	     omits NL before "CSIm;nH". This does not happen in Win10. */
> > +	  if (wincap.has_pcon_omit_nl_before_cursor_move ())
> > +	    {
> > +	      state = 0;
> 
> The pattern of the first two `for()` loops in this function is to reset
> both `state` and `start_at` (even if the `/* Remove OSC Ps ; ? BEL/ST */`
> loop seems not to reset either, which might be a bug). Should `start_at`
> be re-set to 0 here, too?

Hmm, state should be initialized for each parser. But, start_at
is set in state machine when state 0->1. So, not necessary to init.

> > +	      for (DWORD i = 0; i < rlen; i++)
> > +		if (state == 0 && outbuf[i] == '\033')
> > +		  {
> > +		    start_at = i;
> > +		    state++;
> > +		    continue;
> > +		  }
> > +		else if (state == 1 && outbuf[i] == '[')
> > +		  {
> > +		    state++;
> > +		    continue;
> > +		  }
> > +		else if (state == 2
> > +			 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
> > +		  continue;
> > +		else if (state == 2 && outbuf[i] == 'H')
> > +		  {
> > +		    /* Add omitted CR NL before "CSIm;nH". However, when the
> > +		       cusor is on the bottom-most line, adding NL might cause
> > +		       unexpected scrolling. To avoid this, add "CSI H" before
> > +		       CR NL. */
> > +		    const char *ins = "\033[H\r\n";
> > +		    const int ins_len = strlen (ins);
> > +		    if (rlen + ins_len <= NT_MAX_PATH)
> 
> How can we avoid this problem when running out of buffer space?

Cannot.

The worst case is:
"\033[H" => "\033[H\r\n\033[H"
3 byte => 5 byte

So, ristricting the size to read from pipe to NT_MAX_PATH * 5/3
can avoid this situation, but usually rlen is much smaller than
NT_MAX_PATH, where this does not happen, I think.

In the first place, if the buffer is filled up by ReadFFile() and
an ESC sequence is cut off in the middle, the current parser cannot
function correctly.

Do you think the fix for these cases is necessary?

BTW, the problem that you pointed out in IRC, i.e. each state machine
has own 'for' loop, which is not efficient, is more important to me.

I'll refactor this and submit as a non-bugfix patch.

Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
