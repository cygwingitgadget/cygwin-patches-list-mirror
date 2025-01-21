Return-Path: <SRS0=jwxA=UN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e01.mail.nifty.com (mta-sp-e01.mail.nifty.com [106.153.228.1])
	by sourceware.org (Postfix) with ESMTPS id 2DD633857727
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 14:25:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2DD633857727
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2DD633857727
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.1
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737469558; cv=none;
	b=S8bYitt1WQUUdP4urCu2XvQuYLezZfnweBuRZmNLmkeii6dBZQvT6kPxleShs+UwYM0YiOx7qv6/1ns+1IIJiaS5r6wdlepXtNsz8DzcV1uTY7VCA+LHTCEhor7a7hTgNgGqgC8KFYSah6P3yvWeBE5y97fSmpxASQs3IFOloyE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737469558; c=relaxed/simple;
	bh=1ll8wagVhR3bTxiOq4V6l88nEren65mhVSTcD+OtSPg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=eESBr6s52SxawNgkmNEOzluxW0KrlhGX9D/5Es9pSbkM/5ZGIFHOpuBQUm4drnQyWWPd/IMW5KzxuJlc0GO9GE7avxVMJGJhPSbq1F8+Uc3i4W3dhZVrZO0JKoaFUkKhgqRTZloX9YOsRT9ffWGtzyqroHHGJFZsOk/6h8x1iaQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2DD633857727
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kL4RKdC2
Received: from mta-snd-e01.mail.nifty.com by mta-sp-e01.mail.nifty.com
          with ESMTP
          id <20250121142555477.EWCH.6592.mta-snd-e01.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 23:25:55 +0900
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20250121142554624.MFKL.9629.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 23:25:54 +0900
Date: Tue, 21 Jan 2025 23:25:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/3] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250121232553.4e28ee07909111736d088731@nifty.ne.jp>
In-Reply-To: <Z4-k5oypdJ2gDavi@calimero.vinschen.de>
References: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
	<20250121031544.1716992-4-takashi.yano@nifty.ne.jp>
	<Z4-k5oypdJ2gDavi@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737469554;
 bh=75bDBcHefn5QBpC+kddoP9aevizFtqQmq4+RZqPqkNo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=kL4RKdC24Q3gON6i0fXqtV34dJwmliOsXiCIzc1fn4GrVop8jDcn2Auc9rTlRDsIffA/AZ7f
 njSSM1zc7tePWz2njTLjg7KjNPTcRN8ilN9/c19polaVmGhYwIdE3dXRv4dZMcRW8hvDi92YF/
 z2aa1F2NzlDnAggcNaUOWhD6OpW/oYcvj2wAbD97Zq4NKOPR1oYfNO4giztppwUU9qffaa9Oc+
 Lch6q9mOqGQKVROB3qnOw1R7X3PFKTcIlwZzXZDcLW+KT1Xj52HgTpwD7n+Puh9DJjFr+veC9h
 zUXq8AAJ6GXjy5OsKm7IcI0za0jKGGEIQ6tFp16hzJ6IDPbw==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 21 Jan 2025 14:45:10 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> There's a minor style thingy and one question...
> 
> On Jan 21 12:15, Takashi Yano wrote:
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -742,6 +742,12 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
> >        memcpy (p, si._si_commune._si_str, n); p += n;
> >      }
> >  
> > +  unsigned cw_mask;
> > +  if (pack.si.si_signo == __SIGFLUSHFAST)
> > +    cw_mask = 0;
> > +  else
> > +    cw_mask = cw_sig_restart;
> > +
> 
> This could be a one-liner, unsigned cw_mask = ... ? ... : ...;
> 
> >    DWORD nb;
> >    BOOL res;
> >    /* Try multiple times to send if packsize != nb since that probably
> > @@ -751,8 +757,7 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
> >        res = WriteFile (sendsig, leader, packsize, &nb, NULL);
> >        if (!res || packsize == nb)
> >  	break;
> > -      if (cygwait (NULL, 10, cw_sig_eintr) == WAIT_SIGNALED)
> > -	_my_tls.call_signal_handler ();
> > +      cygwait (NULL, 10, cw_mask);
> 
> This bugs me a bit.  While your solution nicely wraps the entire
> timer problem into cygwait(), the downside is that each invocation
> of cygwait() creates its own timer. Theoretically, given this is in a
> loop with up to 100 iterations, you have up to 100 additional timer
> create/destroy sequences.
> 
> So the question is, do you think this matters at all in this scenario,
> given we're in a 10 ms wait state anyway?
> 
> If you think that's not an issue, feel free to apply the patch with
> just the one-liner above.

Thansk for reviewing.
cygwait (NULL, 10, cw_mask) is just waiting for resolving pipe full.
Therefore, I think the overhead of creating and destroying a timer
every 10 msec in the wait loop is small enough to be negligible.
That is, the CPU load will be almost the same if we avoid it.

BTW, I'm happy if you could review also:
[PATCH v2] Cygwin: signal: Avoid frequent TLS lock/unlock for SIGCONT processing

Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
