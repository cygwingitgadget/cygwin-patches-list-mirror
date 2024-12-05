Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 002FC3858D20
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 04:46:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 002FC3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 002FC3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733373997; cv=none;
	b=kOc9Uw/pgOSVGlBxSso5WofcaG/pFadh62DRvOE25V6Wrrno+yaVvh0hSJpFsiK2GTSMUlVh27Cn/R0kNHtCwE14i94tHgREI0V3R6Rd6dXFOfjYBiPiyjsquS1X+2c1C9aKWJjVVks48cbD8+yQDo4nQ3ZeqR294pdhgzYGpZc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733373997; c=relaxed/simple;
	bh=lZN1Maf5u99Wo/HnfDGNPMvk3fCHo0HgNL/fymXoGdY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Hbb6Y+tlzslwPx0Pzj3G2FijTN6MmlXWO62LsVbNhxWD0+YSSCd2TN//GH+M5FoxzLhlv+U9HeJJniWY0cDpPxBpxTLDDpTOISF3b/NyOIiPxxG5S1fN2siejOy4LaDmS9b+ROWembWezLMIiFV+x35EpSMQljj6pp0UCeleYps=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 002FC3858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pKM7MyeU
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20241205044634661.MWUA.13595.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 5 Dec 2024 13:46:34 +0900
Date: Thu, 5 Dec 2024 13:46:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Introduce a lock for the signal queue
Message-Id: <20241205134632.034ba5e5b68b78e2e2e50819@nifty.ne.jp>
In-Reply-To: <Z1BQuouCzDF9tSrK@calimero.vinschen.de>
References: <20241204114124.1246-1-takashi.yano@nifty.ne.jp>
	<Z1BQuouCzDF9tSrK@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733373994;
 bh=RrOfMivQs9LDD00325hek3sJdfHrpvUQ8nMWOUCVeok=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=pKM7MyeUq+fWTYy7xiGZPgCCmNIpiN/yGJjABPbb4XpbMc2SGa8tN6GjGX8QvMxTkxMBryGd
 VUIdu5HOuBPowl803BTGuT0goggQfkkUfUc6m9aKVzSLeTme8TY00F4B3EAiJUO1PrAFGEpG6n
 o/Irca9vvT53S0JOGdnM1K34WNPgXkUXS8LU5m1uO/1x0pOeVYoPupVjUIMUnBO4MJIWNqYc8N
 m8p1MeMAqboLmPV1VonVCna66H3gGzwWQZDWKiI/vK0FZS468xSFDrKksvBR2yJfS1o/s11RpB
 V39b/o6aQw8CWYLTOA8qzx5AksBChAjysvkpgp5MkkDercHw==
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 4 Dec 2024 13:53:14 +0100
Corinna Vinschen wrote:
> On Dec  4 20:41, Takashi Yano wrote:
> > Currently, the signal queue is touched by the thread sig as well as
> > other threads that call sigaction_worker(). This potentially has
> > a possibility to destroy the signal queue chain. A possible worst
> > result may be a self-loop chain which causes infinite loop. With
> > this patch, lock()/unlock() are introduce to avoid such a situation.
> 
> I was hoping for a lockfree solution, but never mind that for now.

I cannot imagine how the lockfree can be realized.
Consider the queue chain:
A->B->C->D
A<-B<-C<-D
where "->" shows next link and "<-" shows prev link.
Assume a thread tries to clear B, and another thread tries to clear C.
Two processes, i.e.
clear(B)
B->prev->next = B->next
B->next->prev = B->prev
and
clear(C)
C->prev->next = C->next
C->next->prev = C->prev
are running at the same time. Even if each line is executed atomically,
the next case is not avoidable.

clear(B)			clear(C)
B->prev->next = B->next						A->next = C
				C->prev->next = C->next		B->next = D
B->next->prev = B->prev						D->prev = A
				C->next->prev = C->prev		D->prev = B

Then, the result is broken as:
A->C->D
A<-B<-D
   B->D
   B<-C
while expected result is:
A->D
A<-D

Is there any way to execute atomically two lines:
B->prev->next = B->next
B->next->prev = B->prev
using Interlocked* functions?

> > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > index 7e02e61f7..cc3113b88 100644
> > --- a/winsup/cygwin/sigproc.cc
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -106,12 +106,27 @@ class pending_signals
> >  {
> >    sigpacket sigs[_NSIG + 1];
> >    sigpacket start;
> > +  volatile unsigned locked;
> >    bool retry;
> > +  void lock ()
> > +  {
> > +    while (InterlockedExchange (&locked, 1))
> > +      {
> > +#ifdef __x86_64__
> > +	__asm__ ("pause");
> > +#else
> > +#error unimplemented for this target
> > +#endif
> > +	yield ();
> > +      }
> > +    }
> > +  void unlock () { locked = 0; }
> >  
> >  public:
> > +  pending_signals (): locked(0) {}
> >    void add (sigpacket&);
> >    bool pending () {retry = !!start.next; return retry;}
> > -  void clear (int sig);
> > +  void clear (int sig, bool need_lock);
> >    void clear (_cygtls *tls);
> >    friend void sig_dispatch_pending (bool);
> >    friend void wait_sig (VOID *arg);
> 
> Given this is used in C-code only, what about just using SRWLocks
> in Exclusive-only mode, rather than a spinlock?

I submitted v2 patch. Please check.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
