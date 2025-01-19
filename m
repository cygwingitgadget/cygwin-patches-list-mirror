Return-Path: <SRS0=Rx1S=UL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id A66213858D21
	for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 08:41:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A66213858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A66213858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737276092; cv=none;
	b=Q0MRvyNSbBTXQuosR70weswMAGHNM4JcCtYoyI8NJIs9jen1dVPxxbSRGz7FXG0cnqiuKYk4Q7JVhRxytKQQi3O/zmESr53aO5KOMWtgzxv1TTKeu376SNawG+gQmNKY7YYAU4yshUMHCK+6151q+ZXNMUNseRrY0vbBkcpyR1w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737276092; c=relaxed/simple;
	bh=jfiYdlcBNPfSu6pxKxcChEhzndGQnZ/Dh44qY49bm9U=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=dLALAMY+fcrZOnzonn4ddaDXj9ZcRu8AprqLXJVlVHHVUbWGGv0uLF/+B2dMvLv6HTnFtikMyJKmByEb+V82MEEhV3mIwYXc8cdmU5BV9aNBKHotDaGznPYj3QShM+a9td74WDRAEomM6un2ArvpxHXuPQ6yc/Jdzv5vr0yzgyI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A66213858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=O/Y1CR7B
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20250119084127947.TKIG.61254.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 17:41:27 +0900
Date: Sun, 19 Jan 2025 17:41:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250119174127.562dc06aaac5fdf3d8a9d38e@nifty.ne.jp>
In-Reply-To: <1dc76092-3328-a611-81f2-6d4138e320b0@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
	<8bdee3d3-1200-b70d-5829-d0a081323562@jdrake.com>
	<20250119114958.82129e29fae9093f38dac53c@nifty.ne.jp>
	<1dc76092-3328-a611-81f2-6d4138e320b0@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737276088;
 bh=oRo8fCD/UJBfRAvhuHREJb9qtO+WW3oPxa9oZqK4N7A=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=O/Y1CR7Bd8akNN5i+z+GEWJY1rMLOBl6o+Lt4VdKVXCkjDE3LcBns3hUqpKJft6rcBKg3g6N
 b7yAMFrxrignZj9m1jopqrFVivA8lw2+ybCXe+2R3unbK8VjQS7tLbEdmGnS4Ji5gZXtgIMng9
 mPzcxAcsqFD4X6Rs9s2N4Xvpac2gZHtA+nca75L4RtaFMNwbNykYrwfE7qhkc8mBrcZAsswCIG
 +UkTScen0Is1/hXS7C9gXLndWIzpQCaaTyFHAFUvz6vH/m128qaJQYqcLtMRkxofXeFI3sN19l
 MyWBpIlSfliCiDlsfqnJB+cDu+zzrE1xbldf1SuJsKHcIthA==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 18 Jan 2025 19:24:51 -0800 (PST)
Jeremy Drake <cygwin@jdrake.com> wrote:

> On Sun, 19 Jan 2025, Takashi Yano wrote:
> 
> > Thanks for pointing out this. You are right if othre threads may
> > set current_sig to non-zero value. Current cygwin sets current_sig
> > to non-zero only in
> > _cygtls::interrupt_setup()
> > and
> > _cygtls::handle_SIGCONT()
> > both are called from sigpacket::process() as follows.
> >
> > wait_sig()->
> >  sigpacket::process() +-> sigpacket::setup_handler() -> _cygtls::interrupt_setup()
> >                       \-> _cygtls::handle_SIGCONT()
> >
> > wait_sig() is a thread which handle received signals, so other
> > threads than wait_sig() thread do not set the current_sig to non-zero.
> > That is, other threads set current_sig only to zero. Therefore,
> > I think we don't have to guard checking current_sig value by lock.
> > The only thing we shoud guard is the following case.
> >
> > [wait_sig()]               [another thread]
> > current_sig = SIGCONT;
> >                            current_sig = 0;
> > set_signal_arrived();
> >
> > So, we should place current_sig = SIGCONT and set_signal_arrived()
> > inside the lock.
> >
> 
> OK, that makes sense.
> 
> > As for volatile, personally, I have never had any problems by
> > not marking variables that are accessed by multiple threads as
> > volatile. Do you have any example that causes problem due to
> > lack of volatile other than, say, hardware registers?
> 
> After I sent that, I realized that it should be fine - yield calls Sleep
> which is an external function, and I think the compiler cannot know that
> it doesn't modify the variable.
> 
> The thing I think volatile protects against is if you didn't do
> something that could "clobber memory" in __asm__ speak:
> 
> while (sig == SIGCONT)
>   __asm__ ("pause":::);
> 
> then the compiler could load the value into a register and just check the
> register rather than re-loading from memory each time through the loop.
> And at that point, just optimize it into an infinite loop.  Either calling
> an external function or making sig volatile would fix that.  I was playing
> with https://gcc.godbolt.org/z/f49vsecYe you can see the effects of making
> mem volatile are the same as having Sleep be a function the compiler
> cannot inline.

Ah, I was wrong. Following code needs volatile for "int a" as you pointed out.

#include <pthread.h>
int a = 0;
void *func(void *arg)
{
	a = 1;
	return NULL;
}

int main()
{
	pthread_t th;
	pthread_create(&th, NULL, func, NULL);
	while (a == 0) ;
	pthread_join(th, NULL);
	return 0;
}


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
