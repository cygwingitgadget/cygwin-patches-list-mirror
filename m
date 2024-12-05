Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8D81D3858CDB; Thu,  5 Dec 2024 10:29:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D81D3858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733394549;
	bh=qBJcvmWYiSSt+qJe9AKtUWr3kHszWfMQTbP2oihfQW8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=DLUY9XvliyrmTfn1dlmdblCBAj1yJyv7dB1I5P2p57/sOH1BIBol2WOjxKQ44b/jb
	 nESBFF6ssjI8Y+bZb47OyJ8aFFs1lZuaSVfSsBJeaLsKW+d+izqkYwM6h7vdWsSNLV
	 mMpZ44RG+WHV6Bhtoykg2c/0tbDu/SlHkt7J36xI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 66A9EA805FC; Thu,  5 Dec 2024 11:29:07 +0100 (CET)
Date: Thu, 5 Dec 2024 11:29:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Introduce a lock for the signal queue
Message-ID: <Z1GAc9kBcwRQ5_wM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241204114124.1246-1-takashi.yano@nifty.ne.jp>
 <Z1BQuouCzDF9tSrK@calimero.vinschen.de>
 <20241205134632.034ba5e5b68b78e2e2e50819@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205134632.034ba5e5b68b78e2e2e50819@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  5 13:46, Takashi Yano wrote:
> On Wed, 4 Dec 2024 13:53:14 +0100
> Corinna Vinschen wrote:
> > On Dec  4 20:41, Takashi Yano wrote:
> > > Currently, the signal queue is touched by the thread sig as well as
> > > other threads that call sigaction_worker(). This potentially has
> > > a possibility to destroy the signal queue chain. A possible worst
> > > result may be a self-loop chain which causes infinite loop. With
> > > this patch, lock()/unlock() are introduce to avoid such a situation.
> > 
> > I was hoping for a lockfree solution, but never mind that for now.
> 
> I cannot imagine how the lockfree can be realized.
> Consider the queue chain:
> A->B->C->D
> A<-B<-C<-D
> where "->" shows next link and "<-" shows prev link.
> Assume a thread tries to clear B, and another thread tries to clear C.
> Two processes, i.e.
> clear(B)
> B->prev->next = B->next
> B->next->prev = B->prev
> and
> clear(C)
> C->prev->next = C->next
> C->next->prev = C->prev
> are running at the same time. Even if each line is executed atomically,
> the next case is not avoidable.
> 
> clear(B)			clear(C)
> B->prev->next = B->next						A->next = C
> 				C->prev->next = C->next		B->next = D
> B->next->prev = B->prev						D->prev = A
> 				C->next->prev = C->prev		D->prev = B
> 
> Then, the result is broken as:
> A->C->D
> A<-B<-D
>    B->D
>    B<-C
> while expected result is:
> A->D
> A<-D
> 
> Is there any way to execute atomically two lines:
> B->prev->next = B->next
> B->next->prev = B->prev
> using Interlocked* functions?

It is possible, apparently.  There's a university presentation with a
nice overview how to do this with a CAS primitive (e. g.
InterlockedCompareExchange):

https://www.cse.chalmers.se/~tsigas/papers/SLIDES/Lock-Free%20Doubly%20Linked%20Lists%20and%20Deques.pdf

Admittedly, I never tried it myself.  So, never mind that for now.
It might be a fun side-project, though.


Corinna
