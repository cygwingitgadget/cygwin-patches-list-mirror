Return-Path: <SRS0=WQBm=V5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 082433858D1E
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 03:58:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 082433858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 082433858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741579096; cv=none;
	b=pftsCl5Xo83XF+2436tyh50BVH8xbCjXEv3pnwMDgk78+9/KdTYfICV2XYJlFG5MXv3+TwMUp5Um3GrXQXKi3ZGXEIQbmTYwzQ+2vq+IVr8dONCMAlFz36RPkSyPIaPkOXzcvQF5vsGpZfoAncruk+hCDjAa2tTg0XEyVNulGs8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741579096; c=relaxed/simple;
	bh=sjrxFJxF7mpZIN56d7LUX7sWKkEF4/egMxnG/mpIiQg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=mbbbX3t6jRPiUzPmKBDDIxgOd7wJwTaHMTJxkdEHbqotC2KVel2ptcjyN43mzoEf1whsjzAOkgJ0fffjAE2+UY7kMLC9Z+bJth5bmIzgWd+7YhWclbUh4huZKYF1X6WiHA3PTGgp73AMyXiLA1TRDp+NMTRgRQgMDOb0QozZJqo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 082433858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TG4VB9xT
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20250310035811881.GMIT.4197.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 12:58:11 +0900
Date: Mon, 10 Mar 2025 12:58:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signa: Redesign signal queue handling
Message-Id: <20250310125812.f68fa6acc1d3c54672dbb6d4@nifty.ne.jp>
In-Reply-To: <21db86b5-d9db-734b-7fea-922b18dab292@t-online.de>
References: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
	<21db86b5-d9db-734b-7fea-922b18dab292@t-online.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741579091;
 bh=xLgJUU1ow6XekwWLU1H4CztE1jNKWcIy+axneMze9FQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=TG4VB9xTAlFaJZWxPjkZD4cRD2gNVh5P9x/k/KnG0gvX41+1qFo0FBAHAO06czUrAoFFYetq
 RNDXFd0hwNUAWU3Lpw38ZTC/C+HXcz6tFUBOhzwzPJkQj09KgYtGC3QOGhlIJf0/FmpQBc5Zvq
 8rUSqPGu8jSxPy00g9t5eLsXBag+/isMBZADqHxkaKrCAvY4WSJzjwSMxioVWUmPjByFFu+eVg
 fyy7rXauCpJXCIylK54TsPMOpv4HexBly68nVCYFI6oroo3cq7SAXK7ZTI/YR+g4Yru3nq6ZyU
 vs5OH/iLUw5ynOFtso6s6wIxz3zSam3cB04akXpM8kYi2epA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 9 Mar 2025 13:28:26 +0100
Christian Franke wrote:
> Takashi Yano wrote:
> > ...
> > With this patch prevents all signals from that issues by redesigning
> > the signal queue, Only the exception is the case that the process is
> > in the PID_STOPPED state. In this case, SIGCONT/SIGKILL should be
> > processed prior to the other signals in the queue.
> >
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
> > Fixes: 7ac6173643b1 ("(pending_signals): New class.")
> > Reported by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ...
> >   void
> >   pending_signals::add (sigpacket& pack)
> >   {
> > ...
> > +  if (q->si.si_signo == pack.si.si_signo)
> > +    q->usecount++;
> > ...
> >
> 
> This should possibly also compare the si.si_sigval fields. Otherwise 
> values would be lost if the same real-time signal is issued multiple 
> times with different value parameters.
> 
> The queuing might also be incorrect for real-time signals. Linux 
> signal(7) says:
> "If different real-time signals are sent to a process, they are 
> delivered starting with the lowest-numbered signal."

Thanks for the advice. I'll submit v2 patch in a several hours.
Please check.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
