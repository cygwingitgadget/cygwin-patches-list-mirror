Return-Path: <SRS0=81Ig=VW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id B6BBC3858D3C
	for <cygwin-patches@cygwin.com>; Mon,  3 Mar 2025 14:39:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B6BBC3858D3C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B6BBC3858D3C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741012768; cv=none;
	b=jGNSGIpERclm2+qBDS1I3Ei20O2XnAfDFsthgXKcQy0MQlxkyGiaSKlq+Dc+yDRwnGR2Q4yFJbZb4t0T1wRfONBPbd2U06l6alzETNI4rkV0anWrPJqmS8t34GHrwz3/NBhzgcG8U6sGS37EICLIhXxH6pIIxDym7YmWUnYEyxY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741012768; c=relaxed/simple;
	bh=FXNvTj3M2duOD5mI6oU4PEPVcCcJNRY+I/J2GKSAXec=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=tUPpp0QzBFhVKxdvJZ5XIyMJ1b7Zj5taZ8KIE8BXp1tU9kWD8q4yZB8YGYufkoMB/JyKQflV7CxSkVbjLykJsiCHRmx3Y0dV6Ov5F5s0IRp2p+gdTTq3VGrzgAnjior+1vzxn/AZ9CHEsKWEkGilHTVW5CWkWN18Wu3GzqZXLMU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B6BBC3858D3C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tUoWn9m2
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250303143920599.BRVT.50988.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 3 Mar 2025 23:39:20 +0900
Date: Mon, 3 Mar 2025 23:39:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/3] Cygwin: signal: Fix a race issue on modifying
 _pinfo::process_state
Message-Id: <20250303233919.4f463d642c88623f9c520f74@nifty.ne.jp>
In-Reply-To: <Z8WoFOXWxwC8AJNx@calimero.vinschen.de>
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
	<20250228233406.950-3-takashi.yano@nifty.ne.jp>
	<Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
	<20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
	<Z8WoFOXWxwC8AJNx@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741012760;
 bh=+iWTP2eZs+SAY5S335p5FmTTzY8LZUvvqnAm186PuYk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tUoWn9m2xa+27e7nsV/VjJJTC6mnNsWD4bVHN33jiefnQWZEmaUniaDd9rBY9enI5wzXnwrm
 f0UlVbqdsGno29zMHQrY4HqxmqneATCMMEV02hhltgsOAhNrNIOGTrcOSW3xFmuuNJtOvRfvm+
 5cB2nzooEC2+Hh/w8OGar3oS/OAaH+ucW8Vx9wW1G01QBvFi+tF8ejvvUT9q0XTAkrUxcPc+Ol
 YVqpfn6wYjxngiTlvI8f0aYlaZng8NCO8nXTYbcm4enan5aIOwkYVO2asqdIGckkJYGrv9ExmA
 K+tpOdDayuiDtuLlY809nym6UxTTd7cEPsVzxqJf4nzwEslw==
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 3 Mar 2025 14:01:08 +0100
Corinna Vinschen wrote:
> On Mar  3 21:24, Takashi Yano wrote:
> > On Mon, 3 Mar 2025 10:51:30 +0100
> > Corinna Vinschen wrote:
> > > On Mar  1 08:33, Takashi Yano wrote:
> > > > The PID_STOPPED flag in _ponfo::process_state is sometimes accidentally
> > > > cleared due to a race condition when modifying it with the "|=" or "&="
> > > > operators. This patch uses InterlockedOr/And() instead to avoid the
> > > > race condition.
> > > 
> > > Is this really sufficent?  I'm asking because of...
> > > 
> > > > @@ -678,8 +678,9 @@ dofork (void **proc, bool *with_forkables)
> > > >  
> > > >    if (ischild)
> > > >      {
> > > > -      myself->process_state |= PID_ACTIVE;
> > > > -      myself->process_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
> > > > +      InterlockedOr ((LONG *) &myself->process_state, PID_ACTIVE);
> > > > +      InterlockedAnd ((LONG *) &myself->process_state,
> > > > +		      ~(PID_INITIALIZING | PID_EXITED | PID_REAPED));
> > > >      }
> > > >    else if (res < 0)
> > > >      {
> > > 
> > > ...places like these.  Every single Interlocked call is safe in itself,
> > > but what if somebody else changes something between the two interlocked
> > > calls?  Maybe this should be done with InterlockedCompareExchange.
> > 
> > Thanks for reviewing.
> > 
> > How can we guard that situation by using InterlockedCompareExchange()?
> > Could you please give me some more instruction?
> 
> The InterlockedCompareExchange can be used to check for a parallel
> change, kind of like this:
> 
>   DWORD old_state, new_state;
>   do
>     {
>       old_state = myself->process_state;
>       new_state = old_state | PID_ACTIVE;
>       new_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
>     }
>   while (InterlockedCompareExchange (&myself->process_state,
>                                      new_state,
>                                      old_state) != old_state);

Thanks!

> but now that I'm writing it I'm even more unsure this is necessary.
> The only two places doing an And and an Or are doing it with the
> exact same flags.  And the combination of PID_ACTIVE and the other
> three flags is never tested together.
> 
> What do you think?

No other code touches these flags except for:

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 1ffe00a94..8739f18f5 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -252,7 +252,7 @@ proc_subproc (DWORD what, uintptr_t val)
 	  vchild->sid = myself->sid;
 	  vchild->ctty = myself->ctty;
 	  vchild->cygstarted = true;
-	  vchild->process_state |= PID_INITIALIZING;
+	  InterlockedOr ((LONG *)&vchild->process_state, PID_INITIALIZING);
 	  vchild->ppid = myself->pid;	/* always set last */
 	}
       break;

Moreover, using InterlockedOr()/InterlockedAnd() can ensure that
the other flags than the current code is modifying will be kept
during modification. So using InterlockedCompareExchange() might
be over the top.

> Either way, I would add a volatile to _pinfo::process_state.

Thanks. I will.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
