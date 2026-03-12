Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EBB854BBC090; Thu, 12 Mar 2026 08:44:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EBB854BBC090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773305054;
	bh=Hg2Hb1RoBpDqQJRgYbgh56l9SOzdnrVgO32GZ+zgIgM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=qW4VMTtEpuv7CQY1x9ESBrQC6xlw2o0AyM+uFmkBkaTMjEv25/LA0irBDSom7BT89
	 EF+vJ9SmhbXKuchDr/QvZuDaewcf5erZ6kL21MgEeROa2wJ3E5p5PAEWxcmIVs4c/D
	 fdLBQKJ85SE9TfbHxTNRGYYXg66kd4buOcJ24k+I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 178FAA80859; Thu, 12 Mar 2026 09:44:13 +0100 (CET)
Date: Thu, 12 Mar 2026 09:44:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: signal: Wait for `sendsig` for a sufficient
 amount of time
Message-ID: <abJ83b5wNdizvvS_@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
 <20260310085041.102-2-takashi.yano@nifty.ne.jp>
 <abGGDAppzfO334u8@calimero.vinschen.de>
 <20260312165558.4325e8a14551a2b13bdeb1b9@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312165558.4325e8a14551a2b13bdeb1b9@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 12 16:55, Takashi Yano wrote:
> Hi Corinna,
> 
> On Wed, 11 Mar 2026 16:11:08 +0100
> Corinna Vinschen wrote:
> > On Mar 10 17:50, Takashi Yano wrote:
> > > The current code waits for `sendsig` by `for` loop in sigproc.cc,
> > > however, the wait time might be insufficient for recent CPU.
> > > The current code is as follows.
> > > 
> > >    for (int i = 0; !p->sendsig && i < 10000; i++)
> > >      yield ();
> > > 
> > > Due to this problem, in tcsh, the following command occasionally
> > > cannot be terminated by Ctrl-C. This is because, SIGCONT does not
> > > wake-up `sleep` process correctly.
> > > 
> > >   $ cat | sleep 100 &
> > >   $ fg
> > >   $ (type Ctrl-C)
> > > 
> > > With this patch, the wait time for `sendsig` is guaranteed to be
> > > up to 100ms instead of looping for 10000 times.
> > > 
> > > Fixes: d584454c8231 ("* sigproc.cc (sig_send): Wait for dwProcessId to be non-zero as well as sendsig.")
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Reviewed-by:
> > > ---
> > >  winsup/cygwin/sigproc.cc | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > > index 30779cf8e..0fd7ed3ba 100644
> > > --- a/winsup/cygwin/sigproc.cc
> > > +++ b/winsup/cygwin/sigproc.cc
> > > @@ -646,7 +646,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
> > >      {
> > >        HANDLE dupsig;
> > >        DWORD dwProcessId;
> > > -      for (int i = 0; !p->sendsig && i < 10000; i++)
> > > +      DWORD t0 = GetTickCount ();
> > 
> > Again a case where GetTickCount is sufficient?  I'd suggest
> > to use GetTickCount64 instead.
> > 
> > Other than that, LGTM.
> 
> Thanks for reviewing.
> 
> The usage of GetTickCount() like this is safe, because
> DWORD (unsigned integer) wraps on overflow. For example:
> 
> If the first call of GetTickCount() returns 0xFFFFFFF0,
> and the second one returns 0x00000010, the result of
> subtranction is:
> 
> 0x00000010 - 0xFFFFFFF0 = 0x00000020
> 
> Therefore, if yield() returns within 49 days, the result
> will be as expected.
> 
> Am I overlooking something?

No, it's fine as is.

It's a personal thing.  I'm always cringing a bit when I see
GetTickCount().  IMHO using GetTickCount64() is "the right thing to do"
because the counter is 64 bit anyway and 64 bit int arithmetic isn't
slower than 32 bit int arithmetic on 64 bit machines.  Or, is it?


Corinna
