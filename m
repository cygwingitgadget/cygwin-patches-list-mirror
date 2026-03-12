Return-Path: <SRS0=ji6e=BM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 8A04D4BBC087
	for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2026 07:56:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8A04D4BBC087
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8A04D4BBC087
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773302165; cv=none;
	b=qzKLEkSzgzEFHVo6gaXXdj0YOqf+fV5k4MuglxWwQ5sg0AK8bkp+gR1S+ocAXFEWYNbhfBT9EMtppFqarhC+efsfVk8IBrYfnu0hDW6dDn5c5t11eh1rvjLZ60atxeqblBAYrWMw5SPpGjl/MZKhrLzv8a3DBOehj2t/P0ulKAE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773302165; c=relaxed/simple;
	bh=YC/QthjiLfSbVQaOYjKPjBKWdmN1c8NGhngZCjHgnXQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=doLrE+prUQeWgHtM5kW5AR1mSuqaqEqPdESX6V3jTbM0I7yeb58ONddM4qUjBqTw9Fi8s5E/2yXzKSWgowsIIkTCJnkxC1yVmM4PpOKaV1iwUoFlbZzlwMlXdjWNTqDmrTdflmBIDJ3Hz8xJCqPDhrWtSufRw/a8OQOD1s4uo98=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8A04D4BBC087
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EOIVeCpZ
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260312075600625.ZAIR.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2026 16:56:00 +0900
Date: Thu, 12 Mar 2026 16:55:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: signal: Wait for `sendsig` for a sufficient
 amount of time
Message-Id: <20260312165558.4325e8a14551a2b13bdeb1b9@nifty.ne.jp>
In-Reply-To: <abGGDAppzfO334u8@calimero.vinschen.de>
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
	<20260310085041.102-2-takashi.yano@nifty.ne.jp>
	<abGGDAppzfO334u8@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773302160;
 bh=k03r+SxiFUfbEe1Lg3vUyKegHt3lbVdnitPAtmh7mJU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=EOIVeCpZUXqefRHLdk6ym7+PfhHU6Q/P6wV/Zfwn5X8PfEzexlFl0/ERnUSWXqn/DyH2SwKH
 0otKocAJSfTSFaNElYRIcNcz4m1VwTUrkPWeQa2jsn7Dv/3VJ0Y2ZfFOXxtHyOtIQ3FN5Nfc0t
 xR/+L7TTNtex1NR1SfGet0mKGPfEzn5JE2NOJCZ6fbl/tA+t6PWuCd/7TTADa7zYCfNb9ojkzW
 dgvzuUC9UQwuvGx1y0KzDKMjObzcUjzXdUZkgfunAzoFapI/pWhIXlVF17jK/4fScxG3yP+i8B
 yObu12AgvXmrB9VH3376TO7n5qBfLKEQgSVvzqRzpg4GMeUQ==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Wed, 11 Mar 2026 16:11:08 +0100
Corinna Vinschen wrote:
> On Mar 10 17:50, Takashi Yano wrote:
> > The current code waits for `sendsig` by `for` loop in sigproc.cc,
> > however, the wait time might be insufficient for recent CPU.
> > The current code is as follows.
> > 
> >    for (int i = 0; !p->sendsig && i < 10000; i++)
> >      yield ();
> > 
> > Due to this problem, in tcsh, the following command occasionally
> > cannot be terminated by Ctrl-C. This is because, SIGCONT does not
> > wake-up `sleep` process correctly.
> > 
> >   $ cat | sleep 100 &
> >   $ fg
> >   $ (type Ctrl-C)
> > 
> > With this patch, the wait time for `sendsig` is guaranteed to be
> > up to 100ms instead of looping for 10000 times.
> > 
> > Fixes: d584454c8231 ("* sigproc.cc (sig_send): Wait for dwProcessId to be non-zero as well as sendsig.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/sigproc.cc | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > index 30779cf8e..0fd7ed3ba 100644
> > --- a/winsup/cygwin/sigproc.cc
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -646,7 +646,8 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
> >      {
> >        HANDLE dupsig;
> >        DWORD dwProcessId;
> > -      for (int i = 0; !p->sendsig && i < 10000; i++)
> > +      DWORD t0 = GetTickCount ();
> 
> Again a case where GetTickCount is sufficient?  I'd suggest
> to use GetTickCount64 instead.
> 
> Other than that, LGTM.

Thanks for reviewing.

The usage of GetTickCount() like this is safe, because
DWORD (unsigned integer) wraps on overflow. For example:

If the first call of GetTickCount() returns 0xFFFFFFF0,
and the second one returns 0x00000010, the result of
subtranction is:

0x00000010 - 0xFFFFFFF0 = 0x00000020

Therefore, if yield() returns within 49 days, the result
will be as expected.

Am I overlooking something?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
