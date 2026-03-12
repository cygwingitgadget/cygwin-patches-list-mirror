Return-Path: <SRS0=ji6e=BM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id D8A764B920E2
	for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2026 11:19:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D8A764B920E2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D8A764B920E2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773314358; cv=none;
	b=iqn6JhGioMRy8ni7j0mYwESrzRYIPaTFUeQuo5vCPjhStOsOEIq2Ltv1g7m6VQsLqFrEDj6jQt+i2uIFeI5+UiVuH+5MP7JqK65tEmWOkIp4sS4Q+MrIfRlGxxCWANW1FZkvzis6UeS8ObxEEwD9+P10JXMX+sGVsCHZj8I6buc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773314358; c=relaxed/simple;
	bh=AG5Ohci+igeEgkIEqg1b88SN9sONs2eHNpBOmi/hQz4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Qs4/v6n4G1Qgh1KSR5ePdvQKq3lRm6UK9xt9LwFiIN3Eq/yyaHpmpfaW/zA7l54lf4jOVfKMg0YtrmzWJmnD7zkzggWlMXjI4hGu3jcs5v+j47+VWxEjnbATBJp9BG1QvfcHBN4zle0f4fOHvMS++IBC63xGu0oiAH6GZEgf6TQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D8A764B920E2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=py2Vcujh
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260312111915962.VKCU.58584.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2026 20:19:15 +0900
Date: Thu, 12 Mar 2026 20:19:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: signal: Wait for `sendsig` for a sufficient
 amount of time
Message-Id: <20260312201913.85523929e2cd48a7559505b0@nifty.ne.jp>
In-Reply-To: <abJ83b5wNdizvvS_@calimero.vinschen.de>
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
	<20260310085041.102-2-takashi.yano@nifty.ne.jp>
	<abGGDAppzfO334u8@calimero.vinschen.de>
	<20260312165558.4325e8a14551a2b13bdeb1b9@nifty.ne.jp>
	<abJ83b5wNdizvvS_@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773314356;
 bh=bPjWLWhGCdfAZdGUcWM9ENmnXbP/sz6ZEF6yAdmwNsk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=py2Vcujhhm7FGf2htcp/2qwHPyFMTJypH04FouSGg1mD6h5wA0UOKe0Pj6fRxHtqtdmlXkcM
 /qWdw17TZMjsI/m44CKZnA/hcdB7FCKJA5tL5Y+jtbeJLqTeUBxFPQE57Q8sUH5DkzY8g7ai35
 Q/LDp4Gj/WYOt/YVdlHmJX8ZcJiL8X66rrA0ND08+9We15aqy72rYReJ0QEKPtZCT9CJCJHcGn
 gJPCLGjIX/KNkvd0Mkrjpg1qVpUaizXwNwhOLAZgGelp6J4ZKO87RMB/EAe4XyhSd8Sey3DAVd
 18AyRlWHDBRPcfybLUmeYnKEfkOnt4vNAfQFa9gTPBat99Uw==
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 12 Mar 2026 09:44:13 +0100
Corinna Vinschen wrote:
> On Mar 12 16:55, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Wed, 11 Mar 2026 16:11:08 +0100
> > Corinna Vinschen wrote:
> > > On Mar 10 17:50, Takashi Yano wrote:
> > > > The current code waits for `sendsig` by `for` loop in sigproc.cc,
> > > > however, the wait time might be insufficient for recent CPU.
> > > > The current code is as follows.
> > > > 
> > > >    for (int i = 0; !p->sendsig && i < 10000; i++)
> > > >      yield ();
> > > > 
> > > > Due to this problem, in tcsh, the following command occasionally
> > > > cannot be terminated by Ctrl-C. This is because, SIGCONT does not
> > > > wake-up `sleep` process correctly.
> > > > 
> > > >   $ cat | sleep 100 &
> > > >   $ fg
> > > >   $ (type Ctrl-C)
> > > > 
> > > > With this patch, the wait time for `sendsig` is guaranteed to be
> > > > up to 100ms instead of looping for 10000 times.
> > > > 
> > > > Fixes: d584454c8231 ("* sigproc.cc (sig_send): Wait for dwProcessId to be non-zero as well as sendsig.")
> > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > Reviewed-by:
> > > > ---
> > > >  winsup/cygwin/sigproc.cc | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > > > index 30779cf8e..0fd7ed3ba 100644
> > > > --- a/winsup/cygwin/sigproc.cc
> > > > +++ b/winsup/cygwin/sigproc.cc
> > > > @@ -646,7 +646,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
> > > >      {
> > > >        HANDLE dupsig;
> > > >        DWORD dwProcessId;
> > > > -      for (int i = 0; !p->sendsig && i < 10000; i++)
> > > > +      DWORD t0 = GetTickCount ();
> > > 
> > > Again a case where GetTickCount is sufficient?  I'd suggest
> > > to use GetTickCount64 instead.
> > > 
> > > Other than that, LGTM.
> > 
> > Thanks for reviewing.
> > 
> > The usage of GetTickCount() like this is safe, because
> > DWORD (unsigned integer) wraps on overflow. For example:
> > 
> > If the first call of GetTickCount() returns 0xFFFFFFF0,
> > and the second one returns 0x00000010, the result of
> > subtranction is:
> > 
> > 0x00000010 - 0xFFFFFFF0 = 0x00000020
> > 
> > Therefore, if yield() returns within 49 days, the result
> > will be as expected.
> > 
> > Am I overlooking something?
> 
> No, it's fine as is.
> 
> It's a personal thing.  I'm always cringing a bit when I see
> GetTickCount().  IMHO using GetTickCount64() is "the right thing to do"
> because the counter is 64 bit anyway and 64 bit int arithmetic isn't
> slower than 32 bit int arithmetic on 64 bit machines.  Or, is it?

No. I have compared GetTickCount() and GetTickCount64(). The result is
that they are almost the same performance as you expected.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
