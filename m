Return-Path: <SRS0=PzXf=NB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id A7F0E385840F
	for <cygwin-patches@cygwin.com>; Thu, 30 May 2024 11:59:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A7F0E385840F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A7F0E385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717070363; cv=none;
	b=xfHmJzUzrVZoQN/AdmvMOgJnbvaVUZubPshc3o8bhUDiPAQzWVVQz3OaSx/+lVofditsKasEoAarbcwT+Q3oQHjJM5Kj3geXu9Q1Shpq0W/wt3LfGIorlVyZUQy9OWmXcSECP780tPyyaoSYMQFLYNu/KFo3Wrqzc6ZP47i7YUM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717070363; c=relaxed/simple;
	bh=EoNiMqhkgSPcumihifwT2uCcwQRDNKtFbqJDd7hUwMg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=HrwugVwLOPYSSOw3ELF/lLgQCjmVEi2URMTZN/ciln3vLfJRxBeY2+xSljby/1DzsRInZXK0IVVm+aACZHqcxvLbVLhjWSvhuRbvS2Je0k2r6xAfGJgTrI6btYb5jwPFs4FVDmE/NizDsHOAnuXKoPSzEclxszXRisRHj7tv0aE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20240530115919828.SQBC.6907.HP-Z230@nifty.com>;
          Thu, 30 May 2024 20:59:19 +0900
Date: Thu, 30 May 2024 20:59:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Bruno Haible <bruno@clisp.org>
Subject: Re: [PATCH v2] Cygwin: pthread: Fix a race issue introduced by the
 commit 2c5433e5da82
Message-Id: <20240530205918.7c730117b567bb3bec3a0c3f@nifty.ne.jp>
In-Reply-To: <20240530205012.2aff4d507acac144e50df2a4@nifty.ne.jp>
References: <20240530050538.53724-1-takashi.yano@nifty.ne.jp>
	<5613635.1WZ037k8cV@nimes>
	<20240530205012.2aff4d507acac144e50df2a4@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717070359;
 bh=3GlUPjdQjBg4582UDPTbnfkhvIZxbvCJRODk7hoSk4I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XWfUrtaHVvK4pr6CeZ1SGxLJUxJtHFwZuXwiWSZr08P+5G448RQjpQ1SEgjQHIpjxIZCJWvx
 om4yj/znUG7JnWzjj6484dNPjbbOScFcpxd47kCA/549Su1JPyV+VDfIj2yymUwv2CrR28iAf1
 LBbw0JdyJmIDXEqmTrqbcgiHjdqz/X2BNXk/Vi1kqVnfDaA5Gc/RXr84IdXbTV+/LgRFGn5Qka
 4sxG2rT25BxTcnP2F+vJkFW3ibq2Q960Z0hW9kAF9ZfNTVegAeiseb7qw1Hk8XmbwdN7eX+P84
 nw5bKahtg62BFXm3WFjSTsMcBRWM4ul6JlFXhm1Xc9nbYQzA==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 30 May 2024 20:50:12 +0900
Takashi Yano <takashi.yano@nifty.ne.jp> wrote:
> On Thu, 30 May 2024 12:14:10 +0200
> Bruno Haible wrote:
> > Takashi Yano wrote in cygwin-patches:
> > >  int
> > >  pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
> > >  {
> > > -  // already done ?
> > > -  if (once_control->state)
> > > +  /* Sign bit of once_control->state is used as done flag */
> > > +  if (once_control->state & INT_MIN)
> > >      return 0;
> > >  
> > > +  /* The type of &once_control->state is int *, which is compatible with
> > > +     LONG * (the type of the first argument of InterlockedIncrement()). */
> > > +  InterlockedIncrement (&once_control->state);
> > >    pthread_mutex_lock (&once_control->mutex);
> > > -  /* Here we must set a cancellation handler to unlock the mutex if needed */
> > > -  /* but a cancellation handler is not the right thing. We need this in the thread
> > > -   *cleanup routine. Assumption: a thread can only be in one pthread_once routine
> > > -   *at a time. Stote a mutex_t *in the pthread_structure. if that's non null unlock
> > > -   *on pthread_exit ();
> > > -   */
> > 
> > Sorry, in a unified diff form this is unreadable. One needs to look at the
> > entire function. A context diff would have been better. So:
> > 
> > int
> > pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
> > {
> >   /* Sign bit of once_control->state is used as done flag */
> >   if (once_control->state & INT_MIN)
> >     return 0;
> > 
> >   /* The type of &once_control->state is int *, which is compatible with
> >      LONG * (the type of the first argument of InterlockedIncrement()). */
> >   InterlockedIncrement (&once_control->state);
> >   pthread_mutex_lock (&once_control->mutex);
> >   if (!(once_control->state & INT_MIN))
> >     {
> >       init_routine ();
> >       once_control->state |= INT_MIN;
> >     }
> >   pthread_mutex_unlock (&once_control->mutex);
> >   if (InterlockedDecrement (&once_control->state) == INT_MIN)
> >     pthread_mutex_destroy (&once_control->mutex);
> >   return 0;
> > }

With v3 patch:
int
pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
{
  /* Sign bit of once_control->state is used as done flag */
  if (once_control->state & INT_MIN)
    return 0;

  /* The type of &once_control->state is int *, which is compatible with
     LONG * (the type of the first argument of InterlockedIncrement()). */
  InterlockedIncrement (&once_control->state);
  pthread_mutex_lock (&once_control->mutex);
  if (!(once_control->state & INT_MIN))
    {
      init_routine ();
      InterlockedOr (&once_control->state, INT_MIN);
    }
  pthread_mutex_unlock (&once_control->mutex);
  if (InterlockedDecrement (&once_control->state) == INT_MIN)
    pthread_mutex_destroy (&once_control->mutex);
  return 0;
}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
