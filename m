Return-Path: <SRS0=PzXf=NB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id 0626B3858D20
	for <cygwin-patches@cygwin.com>; Thu, 30 May 2024 05:05:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0626B3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0626B3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717045506; cv=none;
	b=fDkB7nJtBtKc8T13AVilfMeQNy7BWMsFKWwthOG58mfR4R7tU0tKTnZdYGcs/eS8w/oN+AH6ThIhQWqMiypeENgPEmihYE/Z/coSd47S1DO/DN0cOmzASBE9wG0ibzc/oNxfo/x8vSMWydwZ+BdTJIcLSpNXQlh3TUH1AiVLg9c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717045506; c=relaxed/simple;
	bh=8SFp8q/Q9ormy/bLTe675gsK/63UKV3+QyznN/xBewA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=aRy6VmTS/gxjv1p3SxQGKIqbcHOdJ08G1bDSSoIbisu7e/mNreG3nVZttBiNww0gTKth3WczxrbKlF2ftJERAS5xpU/sMcGMsFlvBm+LYLP5oInWe2yHyhfqAoO7OYrs9jUNoMLOoRHJ/pRCxph/JMZ8Ah8iB+MaB5NKqgRMhOo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20240530050459708.HLSZ.9629.HP-Z230@nifty.com>;
          Thu, 30 May 2024 14:04:59 +0900
Date: Thu, 30 May 2024 14:04:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: Bruno Haible <bruno@clisp.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pthread: Fix a race issue introduced by the
 commit 2c5433e5da82
Message-Id: <20240530140458.2ba002c3dda20ad06b7ddad0@nifty.ne.jp>
In-Reply-To: <3767625.UuxTggG6dJ@nimes>
References: <20240529103020.53514-1-takashi.yano@nifty.ne.jp>
	<3767625.UuxTggG6dJ@nimes>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1717045499;
 bh=eBNDOqqoDbJhWDo3WtL3dUklZYw4BR3OFHI7tXI9loA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ngzpbzhBXHXTbSZymh7MlnQezlWXKDOwKJNY0xUUieNPBoijwPnDB0MRUD3zjQBCr3GDyt8q
 4mlf8/QcCGA+sae9lFXtMJmnoONwQune9x2mB7BokiYc7Lstub6/q5JJFsPGj5VcCzru3PEyv9
 xlHVNRgNHQdyR98PtKTebOpMp0ROXnFr1e4om0JtvhLm6x0y8Lk2nnTNR4n4GOKFOYgvo4mNJ3
 TL+oXVsZIcGoaHG/j+Cl2Tgr+tZKFe5r4ht7r+cXX87LxUV8EGKlzza4JVKHnWm5i4M8IuLaUf
 2rHgf7XgnYhCG38ttlWreXUEtTBsyuw9iggh+RKfXlazDOJA==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 29 May 2024 13:17:47 +0200
Bruno Haible wrote:
> Takashi Yano wrote:
> > To avoid race issues, pthread::once() uses pthread_mutex. This caused
> > the handle leak which was fixed by the commit 2c5433e5da82. However,
> > this fix introduced another race issue, i.e., the mutex may be used
> > after it is destroyed. With this patch, do not use pthread_mutex in
> > pthread::once() to avoid both issues. Instead, InterlockedExchage()
> > is used.
> 
> This patch is bogus as well, because it allows one thread to return
> from a pthread_once call while the other thread is currently
> executing the init_routine and not yet done with it.
> 
> > +  if (!InterlockedExchange (&once_control->state, 1))
> > +    init_routine ();
> >    return 0;
> >  }
> 
> There is no code after the init_routine () call here. This means
> that other threads are not notified when the init_routine () call
> is complete. Therefore this implementation *cannot* be correct.
> 
> See: Assume thread1 and thread2 call pthread_once on the same
> once_control.
> 
>             thread1                      thread2
>             -------                      -------
> 
>          enters pthread_once       enters pthread_once
> 
>          sets state to 1
> 
>                                    sees that state == 1
> 
>                                    returns from pthread_once
> 
>                                    executes code that assumes
>                                    init_routine has completed
> 
>          starts executing
>          init_routine
> 
>          finished executing
>          init_routine
> 
>          returns from pthread_once

Thanks for pointing out that.

I'll submit a v2 patch. Please have a look.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
