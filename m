Return-Path: <SRS0=zjkU=SY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 5125C3858D26
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 11:58:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5125C3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5125C3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732881499; cv=none;
	b=qTaqJ2fNcPnuFEVhmJESP3R9ywrq506Rt3FTzOFQ1bcTOLRgzXcNoaxzJMclR2U3MJx8S0rzXqUfA8SaRWlj93uH4tpfak/NlYsOE6xYV5a8PTgXK2OOrAZUMnv0s3+T7TkvxwoXZYuFPFlctIbV3FQLzHMMpoK/9+da1FId4b4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732881499; c=relaxed/simple;
	bh=IVbqFPNbss+AojSHfoEywISPxAVYHcsw5KviWp3TSdI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=RJSIuf8DsIPGVNFH4CmVWzVtcn5xFodoPQ/FKK07uw/ThyV2oSrCoeVV4CryDHRE1O3cg13UKQAYDPB4SCXwXhAXryDaJYVuq6spdPjYgk1kXFGZYr1WlSccvIvC6bE8OyRPklOVPG2vMswgN8Ikr9QFfjrDRcwiZvnxZkU8BTo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5125C3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ADfjA4Ak
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20241129115817575.ULOJ.107569.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 20:58:17 +0900
Date: Fri, 29 Nov 2024 20:58:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/7] Cygwin: signal: Optimize the priority of the sig
 thread
Message-Id: <20241129205816.38feaf80bfef27cc563dd5ad@nifty.ne.jp>
In-Reply-To: <Z0dOoZwvFlgsCJNd@calimero.vinschen.de>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
	<20241126085521.49604-5-takashi.yano@nifty.ne.jp>
	<Z0dOoZwvFlgsCJNd@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732881497;
 bh=mNavYA3LUSyh74v/3St8lmoy/TERNaULYjK6AQ4ECBs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ADfjA4Ak+KWwolH41RzKoBT0+JL809ce/BnFYlKDsh1ZnFRhLNmMXq4vaW3IHvajEOmcOh5C
 8sYPrGMoJfzbPSts7zQO4UXtpUiuLKKOVA8I6HBl+xB4Fre1Cw/vkv+iAdE8Zxw/CTMseCACpN
 bR7FHk4ivbaX4euN8d8VRQNHnRt46S/XplBwfGbNe7vy3sIJmLrHkA1ebH6573Qz57XQWJEWx4
 cKHLutzJ76XDO99J9ZXUENXBI0K4IsZmH/dWBYNTi6CbZzemKh31Rs+ngwPqVCxX/yQtUIr+/K
 nE6tjrvUt4+6HPk2yqiD/soVP4ytc/5+k8Ix25YZPXkmaPDg==
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 27 Nov 2024 17:53:53 +0100
Corinna Vinschen wrote:
> On Nov 26 17:55, Takashi Yano wrote:
> > Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
> > This causes a critical delay in the signal handling in the main thread
> > if too many signals are received rapidly and the CPU is very busy.
> > In this case, most of the CPU time is allocated to the sig thread, so
> > the main thread cannot have a chance to handle signals. With this patch,
> > the sig thread priority is set to the same priority as the main thread
> > to avoid such a situation. Furthermore, if the signal is alerted to
> > the main thread, but the main thread does not handle it yet, in order
> > to increase the chance of handling it in the main thread, reduce the
> > sig thread priority to THREAD_PRIORITY_LOWEST temporarily.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/sigproc.cc | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > index b8d961a07..fc4360951 100644
> > --- a/winsup/cygwin/sigproc.cc
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -1319,6 +1319,23 @@ wait_sig (VOID *)
> >      {
> >        DWORD nb;
> >        sigpacket pack = {};
> > +      /* Follow to the main thread priority */
>                    
> Just "Follow the ..."
> 
> > +      int prio = THREAD_PRIORITY_NORMAL;
> > +      if (cygwin_finished_initializing)
> > +	{
> > +	  HANDLE h_main_thread = NULL;
> > +	  threadlist_t *tl_entry = cygheap->find_tls (_main_tls);
> > +	  if (_main_tls->thread_id)
> > +	    h_main_thread = OpenThread (THREAD_QUERY_INFORMATION,
> > +					FALSE, _main_tls->thread_id);
> 
> We already have the main thread handle globally available in hMainThread.
> 
> But there's something I don't understand here: You don't know if the
> main thread is actually the thread handling the signal.  So why should
> the priority of the main thread be the role model?

Hmmm, just setting THREAD_PRIORITY_NORMAL might be appropriate.
See v3 patch.

> The culprit of the behaviour you're seeing is the fact that *all*
> cygthread's are running with THREAD_PRIORITY_HIGHEST prio.
> 
> Maybe it's time to rethink this.  Most (none?) of the cygthreads really
> need highest priority.  This *may* have been useful when we only had a
> single CPU core, but these times have gone by, and cygthreads serve
> quite a few tasks which don't need THREAD_PRIORITY_HIGHEST.
> 
> We could try to start all threads with normal priority, and
> only threads suffering from priority problems could be moved to
> another prio.

Enough testing will be necessary for that, I think. As for this patch,
we should use just
SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_NORMAL)
at the begining of the thread function.

> > +      if (cygwin_finished_initializing)
> > +	{
> > +	  threadlist_t *tl_entry = cygheap->find_tls (_main_tls);
> > +	  if (_main_tls->current_sig)
> > +	    /* Decrease the priority in order to make main thread process
> > +	       this signal. */
> > +	    SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_LOWEST);
> > +	  cygheap->unlock_tls (tl_entry);
> > +	}
> 
> Along these lines, I really wonder if this is required.  What if
> we just stick to THREAD_PRIORITY_NORMAL here?

I also think so first, however, without this, the Christian's
test case stops in a short time as if it's stuck. Doing this
here might not be sutable.

Please see v3 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
