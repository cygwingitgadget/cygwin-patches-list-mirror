Return-Path: <SRS0=lOez=RU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.177])
	by sourceware.org (Postfix) with ESMTPS id 25FE23858D21
	for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 08:58:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 25FE23858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 25FE23858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.177
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729760332; cv=none;
	b=PZi/c2BbKpmCzmp9dOEA9qeDl5Ex5a2nyopjXcx16hY09mhMBA7cT5wW9uYJZJ888FtHyKoYetWpu7xl9PGhca5+beYTEqKmGnTfEfqlDIw1fatLYvifHPEuvZuTODpDXRrtuTJJzejaEoFGTLiRKFBMQJO3W5TS5YVpglnBKms=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729760332; c=relaxed/simple;
	bh=jETsOvS6GYVwXFufkyxyqPrDVGx3IPdiYnwwNqu6VxI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LjqYBVldKUGqqatZ1ZAD9De1oUwG2kvyqcnFvjxU2YF1FAiU0RDEBOYUmlntVrPXMfEIr5SgNaXm7yM5RRDoxawi4IJe533N+1ymVam52JasHiJFciGdGSADQPAeQrglofnqCErGJlmvGmDpT/lKjZr+Q4Q/QhmfBl9PNX2JUpQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20241024085847256.UEYV.87244.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 17:58:47 +0900
Date: Thu, 24 Oct 2024 17:58:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
In-Reply-To: <Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
	<Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1729760327;
 bh=vATgHDtBlOE8lQr5TiOi0KlK15kM+X1Q1InzUwXD6rk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=KbO8SsVhF8h8DgNgCKpgOkCd60YJpm0v4NQ1irTLybsXzEiGOtkciMmBd97gx+obdj9vE0Lk
 xDqyZYq32VCPPnPOMnDk+DR2L+aCG5NePGiOn5/KaNv4m5p6JBXqtCxYTrkRTlrYqZG4+uIobz
 wRbBgNU2rwtzPqD17Dzfm+YM6tlnZ6VPZPDhxeba+SwVy18lSD1ZR1VkZx9RsTmX0rvoD/GbKu
 mNYMSJrLqckCpaplGZyI0i4yV74OMspNRHojb+EHQhXrggk0xEUPiBH97kIQ+d9laU7Wzg8ShE
 MObVlERDY7Or6NtOhGmKWYplyP6dioNg3ze+mZD2HW2E+rhQ==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 23 Oct 2024 11:00:33 +0200
Corinna Vinschen wrote:
> first of all, this is quite a piece of work, thanks for pulling
> this through!

Thanks!

> Just a few points:
> 
> On Sep 22 06:15, Takashi Yano wrote:
> > @@ -370,35 +415,15 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
> >  	      break;
> >  	    case STATUS_PIPE_LISTENING:
> >  	    case STATUS_PIPE_EMPTY:
> > +	      /* Only for real_non_blocking_mode */
> > +	      if (!is_nonblocking ())
> > +		/* Should not reach here */
> > +		continue;
> 
> Can you explain why this is necessary at all?

Just in case. We do not need this. I will remove.

> > @@ -439,24 +452,100 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >    if (!len)
> >      return 0;
> 
> This new implementation of raw_write() skips the mechanism added in
> commit 170e6badb621 ("Cygwin: pipe: improve writing when pipe buffer is
> almost full") for non-blocking pipes, if the pipe has less space than
> is requested by user-space.
> 
> Rather than trying to write multiple of 4K chunks or smaller multiple of
> 2 chunks if < 4K, it just writes as much as possible in one go, i.e.
> 
> Before:
> 
>   $ ./x 40000
>   pipe capacity: 65536
>   write: writable 1, 40000 25536
>   write: writable 1, 24576 960
>   write: writable 0, 512 448
>   write: writable 0, 256 192
>   write: writable 0, 128 64
>   write: writable 0, 64 0
>   write: writable 0, -1 / Resource temporarily unavailable
> 
> After:
> 
>   $ ./x 40000
>   pipe capacity: 65536
>   write: writable 1, 40000 25536
>   write: writable 1, 25536 0
>   write: writable 0, -1 / Resource temporarily unavailable
> 
> This way, we get into the EAGAIN case much faster again, which was
> one reason for 170e6badb621.
> 
> Does this make more sense, and if so, why?  If this is really the
> way to go, the comment starting at line 634 (after applying your patch)
> will have to be changed as well.

Perhaps, I did not understand intent of 170e6badb621. Could you please
provide the test program (./x)? I will check my code.

> 
> > +               /* Pipe should be empty because reader is waiting the data. */
>                                                                     ^^^
>                                                                     for

Fixed.

> > @@ -925,7 +952,7 @@ fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode)
> >    HANDLE r, w;
> >    SECURITY_ATTRIBUTES *sa = sec_none_cloexec (mode);
> >    int res = -1;
> > -  int64_t unique_id;
> > +  int64_t unique_id = 0;
> 
> unique_id will be set by the following nt_create() anyway.
> Is there a case where it's not set?  I don't see this.

Without initialization, compiler complains... due to false positive?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
