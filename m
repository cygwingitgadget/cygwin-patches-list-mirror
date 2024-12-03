Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DE7E63858D33; Tue,  3 Dec 2024 13:17:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DE7E63858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733231877;
	bh=K2uCbHZaEjxQEgEGmey1QcKJJTg6XmxGCQxhxXlJ+Sw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Vr8FPlcv6muE0RsVvuujVLxTPVAxJekwXINnleNmMJEwGMJmsHAfC/47DNIPaBNR7
	 WvVsmZpsDkKS/L00YgQwxDOQGLtpjCKz7zx1BMUUSfzsq4sUEHRD+RfsdxfjZNq6Ye
	 7t+wZTtDecM01Co/IbENkWSJ5VQ3c3qS4/oj04GM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DA9AFA80B66; Tue,  3 Dec 2024 14:17:55 +0100 (CET)
Date: Tue, 3 Dec 2024 14:17:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/7] Cygwin: signal: Optimize the priority of the sig
 thread
Message-ID: <Z08FAyn1qYNFbA-7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
 <20241126085521.49604-5-takashi.yano@nifty.ne.jp>
 <Z0dOoZwvFlgsCJNd@calimero.vinschen.de>
 <20241129205816.38feaf80bfef27cc563dd5ad@nifty.ne.jp>
 <Z03Dco0-3zegUX7w@calimero.vinschen.de>
 <20241203213625.70aadacf345dd79a9c7053e8@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203213625.70aadacf345dd79a9c7053e8@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  3 21:36, Takashi Yano wrote:
> On Mon, 2 Dec 2024 15:25:54 +0100
> Corinna Vinschen wrote:
> > On Nov 29 20:58, Takashi Yano wrote:
> > > On Wed, 27 Nov 2024 17:53:53 +0100
> > > Corinna Vinschen wrote:
> > > Hmmm, just setting THREAD_PRIORITY_NORMAL might be appropriate.
> > > See v3 patch.
> > > 
> > > > The culprit of the behaviour you're seeing is the fact that *all*
> > > > cygthread's are running with THREAD_PRIORITY_HIGHEST prio.
> > > > 
> > > > Maybe it's time to rethink this.  Most (none?) of the cygthreads really
> > > > need highest priority.  This *may* have been useful when we only had a
> > > > single CPU core, but these times have gone by, and cygthreads serve
> > > > quite a few tasks which don't need THREAD_PRIORITY_HIGHEST.
> > > > 
> > > > We could try to start all threads with normal priority, and
> > > > only threads suffering from priority problems could be moved to
> > > > another prio.
> > > 
> > > Enough testing will be necessary for that, I think.
> > 
> > I see what you mean, so yeah, let's try it your way and cherry-pick
> > into 3.5.
> 
> You mean applying the 4th patch to master branch, then apply another
> patch which drops setting THREAD_PRIORITY_HIGHEST. Right?

Yes, that's what I meant.  Sorry if that wasn't quite clear.

> > For the main branch, we should really try to drop setting all
> > cygthreads to THREAD_PRIORITY_HIGHEST and leave it as the discretion
> > of the thread itself to manage its priority.
> > 
> > Also, even if a higher prio is required for one thread or another,
> > THREAD_PRIORITY_ABOVE_NORMAL might be sufficient in most cases.
> 
> Just in my short trial, there is no problem even without HIGHEST
> proiority. I'd test that more.

Great, thanks!


Corinna
