Return-Path: <SRS0=PzXf=NB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.227.115])
	by sourceware.org (Postfix) with ESMTPS id 82EBD3858C50
	for <cygwin-patches@cygwin.com>; Thu, 30 May 2024 11:50:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 82EBD3858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 82EBD3858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.115
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717069819; cv=none;
	b=PkODAOA5AczvyW7ju29n8eXtJ9GatNL9Y3b7rTtCBNlgue7xeXjEj5S/xqOW8ASiXlDmtP1yf2ltuyLAsH9eF1Gdmnh3INadhbf+TJ98+ssSe+WqlhBqwSGJNKGtFbSTg+eR8qoH2LXfkYiujYfRwz8pGxt+MrqrPopX6p9Kj5c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717069819; c=relaxed/simple;
	bh=V5yh47wF/e6+Sk2O+uoxYxxvRSWJRaIA6bQCOKPFOoE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=CGGgpJlgy0cjfINAIWyyBmCWKa6SB/BQrWvMs7CgTPYapCHTjWhycd+0e20pByII3BZDKUX8iOFNN5/zL5S4EYIQ8U9KLGSu5lij+3WMhKDJqfhv14Btx4sdF0nOQ71fjLQpRVWqNlUVBXWvuqLI5wnMGZWCWLWxBZT9vQpOASg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20240530115013259.IFNH.40277.HP-Z230@nifty.com>;
          Thu, 30 May 2024 20:50:13 +0900
Date: Thu, 30 May 2024 20:50:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Bruno Haible <bruno@clisp.org>
Subject: Re: [PATCH v2] Cygwin: pthread: Fix a race issue introduced by the
 commit 2c5433e5da82
Message-Id: <20240530205012.2aff4d507acac144e50df2a4@nifty.ne.jp>
In-Reply-To: <5613635.1WZ037k8cV@nimes>
References: <20240530050538.53724-1-takashi.yano@nifty.ne.jp>
	<5613635.1WZ037k8cV@nimes>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717069813;
 bh=SOiC9QKQwQRwKCuF7QYg/1yMZEhh57dUhJshUNGm8nw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Y/DRPAeW07rfvkmDtvRsZTQ4TsjaZVjROlLs1jcU64oxGDbKPWorxMNyIxW6ektvP7pMa0Od
 5LPChp9+70Xm2gCLKQ3nIbPUC9HKnJysQLNUw24MHRH85sYmzcaKNr75BbXN0ScWqQJPY4YLlp
 bFhWi1bc1gyWHkGdQmCJRgJ/4gJj6v3bpwasq95SGDtvYFN0vTvoxf0Dyk4CHvHMWpZ3Zc74pS
 qZLupkySMpUYlwJUvxQ1OdQdhbYOR0SvX4YmVgp0+Zp/5WTFw2+bJuZAjFl1Hr/EV0f8sc2YTI
 H+Fy44YnLRyXdLRZse9lPYlymy0ZvMq8c9CW6bqFCR+ElUTQ==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 30 May 2024 12:14:10 +0200
Bruno Haible wrote:
> Takashi Yano wrote in cygwin-patches:
> >  int
> >  pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
> >  {
> > -  // already done ?
> > -  if (once_control->state)
> > +  /* Sign bit of once_control->state is used as done flag */
> > +  if (once_control->state & INT_MIN)
> >      return 0;
> >  
> > +  /* The type of &once_control->state is int *, which is compatible with
> > +     LONG * (the type of the first argument of InterlockedIncrement()). */
> > +  InterlockedIncrement (&once_control->state);
> >    pthread_mutex_lock (&once_control->mutex);
> > -  /* Here we must set a cancellation handler to unlock the mutex if needed */
> > -  /* but a cancellation handler is not the right thing. We need this in the thread
> > -   *cleanup routine. Assumption: a thread can only be in one pthread_once routine
> > -   *at a time. Stote a mutex_t *in the pthread_structure. if that's non null unlock
> > -   *on pthread_exit ();
> > -   */
> 
> Sorry, in a unified diff form this is unreadable. One needs to look at the
> entire function. A context diff would have been better. So:
> 
> int
> pthread::once (pthread_once_t *once_control, void (*init_routine) (void))
> {
>   /* Sign bit of once_control->state is used as done flag */
>   if (once_control->state & INT_MIN)
>     return 0;
> 
>   /* The type of &once_control->state is int *, which is compatible with
>      LONG * (the type of the first argument of InterlockedIncrement()). */
>   InterlockedIncrement (&once_control->state);
>   pthread_mutex_lock (&once_control->mutex);
>   if (!(once_control->state & INT_MIN))
>     {
>       init_routine ();
>       once_control->state |= INT_MIN;
>     }
>   pthread_mutex_unlock (&once_control->mutex);
>   if (InterlockedDecrement (&once_control->state) == INT_MIN)
>     pthread_mutex_destroy (&once_control->mutex);
>   return 0;
> }
> 
> 1) The overall logic seems right (using bit 31 of the state word as a
> 'done' bit), and the last thread that used the mutex destroys it.
> 
> 2) However, the 'state' field is not volatile, and therefore the memory
> model does not guarantee that an assignment
> 
>      once_control->state |= INT_MIN;
> 
> done in one thread has an effect on the values seen by other threads
> that do
> 
>      if (once_control->state & INT_MIN)
> 
> As long as there is no synchronization between the two CPUs that execute
> the two threads, one CPU may indefinitely see the old value of
> once_control->state, while the other CPU's new value is not being
> "broadcasted" to all CPUs.

OK. I'll add volatile attribute to state in thread.h.

> 3) Also, as noted by Noel Grandin, there is a race: If one thread does
> 
>      once_control->state |= INT_MIN;
> 
> while another thread does
> 
>      InterlockedIncrement (&once_control->state);
> or
>      InterlockedDecrement (&once_control->state)
> 
> the result can be that the increment or decrement is nullified. If it's
> an increment that gets nullified, the pthread_mutex_destroy occurs too
> early, with fatal consequences. If it's a decrement that get nullified,
> the pthread_mutex_destroy never happens, and there is therefore a resource
> leak.

That's right. I'll use InterlockedOr(&onece_control->state, INT_MIN)
here instead.

> 4) Does the test program that I posted in
> <https://cygwin.com/pipermail/cygwin/2024-May/255987.html> now pass?
> Notes:
>   - You should set
>       #define ENABLE_DEBUGGING 0
>     because with the debugging output, it nearly always succeeds.
>   - You should run it 10 times in a row, not just once. It may well
>     succeed 9 out of 10 times and fail 1 out of 10 times.

I start to run a few hours ago:
while true; do ./a.exe; done
and it does not detect any errors so far.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
