Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 03ED03858D34
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 12:17:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 03ED03858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 03ED03858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733228270; cv=none;
	b=XRoj+XFXaWgY4p0/foCs6daZbmhxZZGv4TiS+rfQM8CVsgKRGZZCCTn8DVrGnXBME+kqz/kLscimFqeZytT43hiwiZTo7j15RkjiWUMKkb+znd0YQ977R7O21P7oOckOZx4gYbMqcpXi6sAcw6PaJV0EMw+HOvyBTIKA8gcQSJM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733228270; c=relaxed/simple;
	bh=eIAppiA37jBmak4bTUod9NB2phqXIhY03AuVwq6n98I=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vPTgCQTU+3LtlVB6NzxKTRNHwB9iPYCBvmEqfdc2/gTOVig9wlalj3q3qCGjYAQya+4sZc1AlG3HNFh7rCfA8VCgMsKN2qNSgOJ47LtjLni3LEPp4mnzmqaHSfk9rHH7OYD8UHA/vXVpTrenvfZgYvOcofPavcC8UFVit2DZcfM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 03ED03858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=n0SaX7Ll
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20241203121748051.NGDI.84910.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Dec 2024 21:17:48 +0900
Date: Tue, 3 Dec 2024 21:17:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the
 queue chain when cleared
Message-Id: <20241203211747.926c7428ffd35ac600dc4659@nifty.ne.jp>
In-Reply-To: <Z03O873ZPfo9akuc@calimero.vinschen.de>
References: <20241129114835.14497-1-takashi.yano@nifty.ne.jp>
	<Z03O873ZPfo9akuc@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733228268;
 bh=bgrnRwA9Uqe/PyNpbonfFQFWwkk78TQSKKotu+7bgUA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=n0SaX7LlUclz8dkhi0NsvrwBSiq4R9/NOkmq0jprfaHhGWewxOAWZJmjFKTQbuRaLOWGheet
 OihZYKjz8s+tl6MY8XUCEkooMHznV+1h5TObcDNcwWfBN0AEh9G5cpFRn2DRUlORsdry7z881C
 Z6t+kiTuqtMEf55I1+W33GJjKVi2+RFqy8fpW8dJZ+8W8Pa5aQef4rB7UOcIjgiN1/mM8AkBcv
 r21EBwg4NKxcCLOJlw2EuhZhTMZPtxqcWkSYJUeGAZ2ZySLd+AzZSRHCeCavQXF+YUcrSBcY+m
 K8swv3HAWmUxtKgCUQ+FDIuGe0QNy1VyAaAh5pWzAb35q3kw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Dec 2024 16:14:59 +0100
Corinna Vinschen wrote:
> On Nov 29 20:48, Takashi Yano wrote:
> > The queue is cleaned up by removing the entries having si_signo == 0
> > while processing the queued signals, however, sipacket::process() may
> > set si_signo in the queue to 0 of the entry already processed but not
> > succeed by calling sig_clear(). This patch ensures the sig_clear()
> > to remove the entry from the queue chain.
> 
> Thanks for this patch.  I just have two questions.
> 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/local_includes/sigproc.h |  3 +-
> >  winsup/cygwin/sigproc.cc               | 48 +++++++++++++++++---------
> >  2 files changed, 34 insertions(+), 17 deletions(-)
> > 
> > diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
> > index 46e26db19..8b7062aae 100644
> > --- a/winsup/cygwin/local_includes/sigproc.h
> > +++ b/winsup/cygwin/local_includes/sigproc.h
> > @@ -50,8 +50,9 @@ struct sigpacket
> >    {
> >      HANDLE wakeup;
> >      HANDLE thread_handle;
> > -    struct sigpacket *next;
> >    };
> > +  struct sigpacket *next;
> > +  struct sigpacket *prev;
> 
> The former method using q and qnext ptr didn't need prev.  The question
> is, why did you add prev?  If you think this has an advantage, even if
> just better readability, it would be nice to document this in the commit
> message.

Consider the queued signal chain is like:
A->B->C->D
Assume that now 'q' and 'qnext' ptr points to C and process() is
processing C. If B is cleared in process(), A->next should be set
to C. Then, if process() for C succeeds, C should be removed from
the queue, so A->next should be set to D. However, now we cannot
access to A because we do not have the pointer to A.

To resolve this problem, I introduced prev member.

v2 patch didn't need prev because it rescans again after all
process() finished.

> >    int process ();
> >    int setup_handler (void *, struct sigaction&, _cygtls *);
> >  };
> > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > index 4d50a5865..8ffb90a2c 100644
> > --- a/winsup/cygwin/sigproc.cc
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -111,7 +111,7 @@ class pending_signals
> >  public:
> >    void add (sigpacket&);
> >    bool pending () {retry = !!start.next; return retry;}
> > -  void clear (int sig) {sigs[sig].si.si_signo = 0;}
> > +  void clear (int sig);
> >    void clear (_cygtls *tls);
> >    friend void sig_dispatch_pending (bool);
> >    friend void wait_sig (VOID *arg);
> > @@ -432,21 +432,35 @@ sig_clear (int sig)
> >    sigq.clear (sig);
> >  }
> >  
> > +/* Clear pending signals of specific si_signo.
> > +   Called from sigpacket::process(). */
> > +void
> > +pending_signals::clear (int sig)
> > +{
> > +  sigpacket *q = sigs + sig;
> > +  if (!sig || !q->si.si_signo)
> > +    return;
> > +  q->si.si_signo = 0;
> > +  q->prev->next = q->next;
> > +  if (q->next)
> > +    q->next->prev = q->prev;
> > +}
> 
> This is called from sigpacket::process() as well as from wait_sig(),
> _cygtls::handle_SIGCONT() and sigaction_worker().
> 
> The below clear method is called from _cygtls::remove_pending_sigs().
> 
> The calls from sigpacket::process() and _cygtls::handle_SIGCONT() are
> under protection of the threadlist_t mutex (which actually isn't meant
> to protect the sig queue), but the calls from wait_sig() and
> sigaction_worker() are not.  wait_sig() also modifies the queue by itself.
> 
> Given that the signal queue is working on predefined memory, there's
> fortunately not much chance of memory corruption, but without locking
> or, better, lockfree add/clear using Interlocked functions, aren't
> we potentially losing signals?

Hmmm, maybe. Let me consider a bit.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
