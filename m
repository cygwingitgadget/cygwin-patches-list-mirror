Return-Path: <SRS0=jFRs=S5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 273423858D20
	for <cygwin-patches@cygwin.com>; Wed,  4 Dec 2024 11:40:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 273423858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 273423858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733312449; cv=none;
	b=Vj59p4A6igVNQXeInuc8a8DYwWuHOy1fVrisJIJ1dfVHu2djVjF+kOzEErmokFBwE8rrDfy2S+RkXE+IjrIoGWtgES/HuMpjk9sQ21LT/aWXS1vYr0RjB0aDf1KTs/1Vx7uj56Uz0WNl+diCVp0mXdaqqseDJB4LGOBxCNMSFPY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733312449; c=relaxed/simple;
	bh=iXtT869PPzL4YdK5OFsIlzc2kLwiulZag7262/XKzTU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=KNLlopHgu4mvxkliWaIlLo67OcjZ7fAhmOAhi4PtBxujp/Aary+zLNOZg5ojWKu87/jHYxOaZ6VArOwY5xCiKKVnltOeWK8MniErCo8KNf+WVFrUh9/2oIs+dVU6LBCScrY1X6czCGGWwCnb2WNXb3adqN/M238fnVUSwsjrulQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 273423858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QE5/p59U
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20241204114045912.KZYG.61254.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 4 Dec 2024 20:40:45 +0900
Date: Wed, 4 Dec 2024 20:40:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the
 queue chain when cleared
Message-Id: <20241204204045.cdafd77f53ac2993365a0771@nifty.ne.jp>
In-Reply-To: <20241203211747.926c7428ffd35ac600dc4659@nifty.ne.jp>
References: <20241129114835.14497-1-takashi.yano@nifty.ne.jp>
	<Z03O873ZPfo9akuc@calimero.vinschen.de>
	<20241203211747.926c7428ffd35ac600dc4659@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733312446;
 bh=JVLmhtuN1opdmE6d15RofMOXr6WzD1595cj6c85CpnA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=QE5/p59UYAN0Oxlr1YRi+Vo3cB09cscz0Ek0VQwo4ngQoBzFzZO//5fo9TyNtBwktqZR2D/v
 NDUC7BVwl2CefPgaYFvLkNzj321N2QwJk2eSNz1yob9oeNkiED7/oBT0fT2gj/5sv/O9hN21zk
 29vzs+byG71xQB/ksve503qpldQHIY+aeZVmMGaS6XDOKrdwfqmpxBZlyb53gnaA1sQ6M0oFFH
 BftS1L+KFBs9SYv7wtj1KdartO2AOZuHUkW1UoluQJV15AzJt1dK5ONimLaoy/cetaez+PftRq
 kKQev3km/9PfsOpca6RjJMljNhgPKHr2ULwgOy5e1ugLtQdw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 3 Dec 2024 21:17:47 +0900
Takashi Yano wrote:
> On Mon, 2 Dec 2024 16:14:59 +0100
> Corinna Vinschen wrote:
> > On Nov 29 20:48, Takashi Yano wrote:
> > > The queue is cleaned up by removing the entries having si_signo == 0
> > > while processing the queued signals, however, sipacket::process() may
> > > set si_signo in the queue to 0 of the entry already processed but not
> > > succeed by calling sig_clear(). This patch ensures the sig_clear()
> > > to remove the entry from the queue chain.
> > 
> > Thanks for this patch.  I just have two questions.
> > 
> > > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > > Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
> > > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/local_includes/sigproc.h |  3 +-
> > >  winsup/cygwin/sigproc.cc               | 48 +++++++++++++++++---------
> > >  2 files changed, 34 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
> > > index 46e26db19..8b7062aae 100644
> > > --- a/winsup/cygwin/local_includes/sigproc.h
> > > +++ b/winsup/cygwin/local_includes/sigproc.h
> > > @@ -50,8 +50,9 @@ struct sigpacket
> > >    {
> > >      HANDLE wakeup;
> > >      HANDLE thread_handle;
> > > -    struct sigpacket *next;
> > >    };
> > > +  struct sigpacket *next;
> > > +  struct sigpacket *prev;
> > 
> > The former method using q and qnext ptr didn't need prev.  The question
> > is, why did you add prev?  If you think this has an advantage, even if
> > just better readability, it would be nice to document this in the commit
> > message.
> 
> Consider the queued signal chain is like:
> A->B->C->D
> Assume that now 'q' and 'qnext' ptr points to C and process() is
> processing C. If B is cleared in process(), A->next should be set
> to C. Then, if process() for C succeeds, C should be removed from
> the queue, so A->next should be set to D. However, now we cannot
> access to A because we do not have the pointer to A.
> 
> To resolve this problem, I introduced prev member.
> 
> v2 patch didn't need prev because it rescans again after all
> process() finished.
> 
> > >    int process ();
> > >    int setup_handler (void *, struct sigaction&, _cygtls *);
> > >  };
> > > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > > index 4d50a5865..8ffb90a2c 100644
> > > --- a/winsup/cygwin/sigproc.cc
> > > +++ b/winsup/cygwin/sigproc.cc
> > > @@ -111,7 +111,7 @@ class pending_signals
> > >  public:
> > >    void add (sigpacket&);
> > >    bool pending () {retry = !!start.next; return retry;}
> > > -  void clear (int sig) {sigs[sig].si.si_signo = 0;}
> > > +  void clear (int sig);
> > >    void clear (_cygtls *tls);
> > >    friend void sig_dispatch_pending (bool);
> > >    friend void wait_sig (VOID *arg);
> > > @@ -432,21 +432,35 @@ sig_clear (int sig)
> > >    sigq.clear (sig);
> > >  }
> > >  
> > > +/* Clear pending signals of specific si_signo.
> > > +   Called from sigpacket::process(). */
> > > +void
> > > +pending_signals::clear (int sig)
> > > +{
> > > +  sigpacket *q = sigs + sig;
> > > +  if (!sig || !q->si.si_signo)
> > > +    return;
> > > +  q->si.si_signo = 0;
> > > +  q->prev->next = q->next;
> > > +  if (q->next)
> > > +    q->next->prev = q->prev;
> > > +}
> > 
> > This is called from sigpacket::process() as well as from wait_sig(),
> > _cygtls::handle_SIGCONT() and sigaction_worker().
> > 
> > The below clear method is called from _cygtls::remove_pending_sigs().
> > 
> > The calls from sigpacket::process() and _cygtls::handle_SIGCONT() are
> > under protection of the threadlist_t mutex (which actually isn't meant
> > to protect the sig queue), but the calls from wait_sig() and
> > sigaction_worker() are not.  wait_sig() also modifies the queue by itself.
> > 
> > Given that the signal queue is working on predefined memory, there's
> > fortunately not much chance of memory corruption, but without locking
> > or, better, lockfree add/clear using Interlocked functions, aren't
> > we potentially losing signals?
> 
> Hmmm, maybe. Let me consider a bit.

I agree we need lock for signal queue handling. Hoever, IIUC,
threadlist_t mutex lock woks for only the target thread. So,
it cannot be used as a lock for the signal queue that has
entries for different threads.

So, I introduced a lock for this purpose. Could you please
have a look?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
