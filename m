Return-Path: <SRS0=q3sT=CF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 1BE314BA23F1
	for <cygwin-patches@cygwin.com>; Mon,  6 Apr 2026 12:19:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1BE314BA23F1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1BE314BA23F1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775477973; cv=none;
	b=KlvTKon/SrRYoP+0+xzl8ecIPOVwy5pVNqlaTk+vHhPdnsHfkDQsXXfO8c5nQu2UMrcpSMZ0ZbTIajPEhPGgyPHhjP8lteCR0qH0b5hNMG5sL2SLFrzqU3GyRjbGQXQ1EpEBTq/XW1FpXZOkIXrKORdlh5iHtJGjI3jbgYhYvEY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775477973; c=relaxed/simple;
	bh=bCwb7IEWlXyF0ffe9SMbuDwsAd2P6dtB7I18tvXXQyY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=I4Gj0uvYLG5DkfNX6/nAA1n85rPYTHhDwLBg0rP3IJH2h5Lmqd/FGx0//cTmKb0gRjLnL9p9HgP8BOMOUGfY/1d5WQcpZZvtBOZ9spuTYgkFPFv02JZHq0Vrt8FTVl9qm1jl1BUCYPGV5e4q7XUqRxwH8OKcYW3PA2atEfohmiM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1BE314BA23F1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UCy3hwXQ
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260406121931395.LPXY.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 6 Apr 2026 21:19:31 +0900
Date: Mon, 6 Apr 2026 21:19:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make pcon_start handling more multi thread
 durable
Message-Id: <20260406211929.e50e6dcc20b63c404ad6d648@nifty.ne.jp>
In-Reply-To: <22c40c24-dcb1-7386-629b-adc41e3c91e2@gmx.de>
References: <20260325130917.68025-1-takashi.yano@nifty.ne.jp>
	<22c40c24-dcb1-7386-629b-adc41e3c91e2@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1775477971;
 bh=fAjHcT/BJCsCVARXl32Y+nxoqvNQC3P98DluxAtOO5s=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=UCy3hwXQjsXJA+LNbrxGiu0FOwaJpuR/+lNuiCq0nhqOlmLqdP98k0bmZrL+ERV4OS1JDLi8
 Q13NAtL6p6tizmKSGfTngwoyjHLLAYhfZsR63PEaI08Kh8Oe64uNB0qsh+sXA8XLUeKCUDAirh
 PhNnWP4vOn4rVj22v5RiUGPd55joPUB4sPNqfJ2Z/u9BMq40lSKSKcrUMIVnTetBecdYNP6Pmu
 T/S9+hwv+YCi3nJj8buB4u7Ie7+emJYJdFh6SFRLepzVCy4AtB3j07DOr3wiZL0aTPErgRRcgx
 ziu6htPqS7o0G+AnyzIELpjEw5PiIBqvIpHYWmAJE5Xl47iA==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing.

On Mon, 6 Apr 2026 10:14:22 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Mon, 6 Apr 2026, Takashi Yano wrote:
> 
> > Currently, if the CSI6n response is devided into "CSI10;2" and "R",
> > and another thread call master write() with "c", the data written to
> > nat pipe will be interleaved like "CSI10;2cR". The first "CSI10;2"
> > make the 'state' 1, and in state == 1, all the data written goes
> > to 'wpbuf[]'. This may break statup of pseudo console.
> > 
> > With this patch, the thread ID of the thread that write the first ESC
> > char to 'wpbuf[]' is stored in 'wp_tid', and only if the thread ID
> > matches 'wp_tid' will be written to 'wpbuf[]'.
> 
> This looks correct and well-targeted. The interleaving scenario you
> describe is a real problem, and keying on the thread ID is a clean way to
> ensure that only the thread which initiated the escape sequence gets to
> append to wpbuf[].
> 
> Two small typos in the commit message that are worth fixing before you push
> (to make Corinna happy :-) ):
> 
> 	s/devided/divided/
> 
> 	s/statup/startup/

Fixed.

> > Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 8e6fb9c23..dda892269 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2230,6 +2230,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >        static char wpbuf[wpbuf_len];
> >        static int ixput = 0;
> >        static int state = 0;
> > +      static DWORD wp_tid = 0;
> >  
> >        DWORD n;
> >        WaitForSingleObject (input_mutex, mutex_timeout);
> > @@ -2242,8 +2243,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  		line_edit (wpbuf, ixput, ti, &ret);
> >  	      ixput = 0;
> >  	      state = 1;
> > +	      wp_tid = _my_tls.thread_id;
> >  	    }
> > -	  if (state == 1)
> > +	  if (state == 1 && wp_tid == _my_tls.thread_id)
> >  	    {
> >  	      if (ixput < wpbuf_len)
> >  		wpbuf[ixput++] = p[i];
> > @@ -2259,7 +2261,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  	    line_edit (p + i, 1, ti, &ret);
> >  	  len = orig_len - i - 1;
> >  	  ptr = p + i + 1;
> > -	  if (state == 1 && p[i] == 'R')
> > +	  if (state == 1 && wp_tid == _my_tls.thread_id && p[i] == 'R')
> >  	    state = 2;
> >  	  if (state == 2)
> >  	    {
> 
> One very minor nitpick. The code continues like this:
> 
> 	  if (state == 1 && wp_tid == _my_tls.thread_id && p[i] == 'R')
>  	    state = 2;
>  	  if (state == 2)
>  	    {
> 	  [...]
>  	  ixput = 0;
>  	  state = 0;
> 
> In this state==2 cleanup block, `state` and `ixput` are reset to 0 but
> `wp_tid` is not. It is harmless since the next pcon_start will overwrite it
> when state transitions to 1, but resetting `wp_tid = 0` here alongside the
> other variables would be slightly cleaner for readability. Up to you.

Added and pushed. Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
