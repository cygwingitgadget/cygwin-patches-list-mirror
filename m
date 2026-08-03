Return-Path: <SRS0=LDpO=F4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 52E064BAE7F3
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 10:49:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 52E064BAE7F3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 52E064BAE7F3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785754191; cv=none;
	b=np4bCJlL2D9K6AlAD8JISKr8aECvrtgLX6jS/x8FtxdRQ4KUYBXVSCjU8SyJSOk6dtjCQuPUmUk3/VDIOutdjJsN15ARgYyXpsRcoIkmYIAL/iXeSZ9YANth7nPPrIdX7zBJs/Zlij51h30Lr7UiTckHvwkZVQcU3oO3MsiDshU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785754191; c=relaxed/simple;
	bh=RE6tH52/CWXiRzXwAB+Nm3AVc1/t5Qkt9dQH68dG6ro=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=r9kh41ogPAy7tNOvrE0VZ4jCcT6fJ4wbC8Shln/2d/kHnSjfkTE3aS7hhIeT+7R++pb+CzRKlat3P6NkMPp7DVgRWdu6zpL2m3eiiGrnYC96FoElMO/YCkGLOqk34m7+suCk3cp3128tb9WXxsSvA8XTSgRSCIgPtlVDWReQNuE=
ARC-Authentication-Results: i=1; sourceware.org
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260803104948456.ZSCO.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 3 Aug 2026 19:49:48 +0900
Date: Mon, 3 Aug 2026 19:49:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: open: Add missing unlock on error
Message-Id: <20260803194946.6036d562150d8a63f16cce2f@nifty.ne.jp>
In-Reply-To: <0f65a017-2590-4d55-a4bc-05730da1f521@maxrnd.com>
References: <20260803032303.5382-1-takashi.yano@nifty.ne.jp>
	<0f65a017-2590-4d55-a4bc-05730da1f521@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785754188;
 bh=XFfExY075wXKiKaXDgrbS1j0aYsiQeBKka1yq94eHeU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=EYcWivbKLIxJrnRUoJ8AttdOsxMd4ouqpsUyXIxPfLngYXnjJgEi6ME0SDFmHvV6YYHWld0v
 CWOUllsxoGNM5e6g15+91duca5lQFL9lTXL4dgeE8omOKNWe/BFzFA5pMWqolScE365WUV6I30
 6crkbQSAFg1ekDQmHYHSyEEOLlBD2yB4R35uSCGlLvxw3VcYk+XXtYFWfxhi/LH5etd3qdmiX4
 eEGR2OjmMGwp62Wzk5eUGCagn7PkRn+IEQHfE+OvAMJq04DVPh5k4xe68f+75B6CD1zD1s5sI6
 IMipu6u7fuMr0pmMqIvZ8sWv+rDDaTIj7QufLQkRJil4j07A==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for reviewing so quickly!

On Mon, 3 Aug 2026 01:52:29 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 8/2/2026 8:22 PM, Takashi Yano wrote:
> > the commit 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_
> > with_arch()") introduced a bug that fdtab lock was not unlocked
> > when new fd cannot be allocated due to an error.
> > 
> > This patch adds missing unlock for fdtab lock on error.
> > 
> > Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
> > Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/syscalls.cc | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> > index e3ba8c65c..8373482e9 100644
> > --- a/winsup/cygwin/syscalls.cc
> > +++ b/winsup/cygwin/syscalls.cc
> > @@ -1554,7 +1554,10 @@ open (const char *unix_path, int flags, ...)
> >         cygheap->fdtab.lock();
> >         fd = cygheap->fdtab.find_unused_handle ();
> >         if (fd < 0)
> > -	__leave;		/* errno already set */
> > +	{
> > +	  cygheap->fdtab.unlock();
> > +	  __leave;		/* errno already set */
> > +	}
> >         cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
> >         cygheap->fdtab.unlock();
> >   
> 
> This patch LGTM.  Apologies for not catching this in my review.
> Thanks & Regards,

Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
