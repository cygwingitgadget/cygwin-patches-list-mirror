Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 169063858D33
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 15:03:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 169063858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 169063858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733238213; cv=none;
	b=cQg5uqEmU9wkyWbGHp10d/5ksjawdxOYmF3X41xr5dnXs2JssL/DCzGZk1D3kbca4DXIFa7FzwJ8ndNtD6uiNPKlWOcgNRsoqGjvrrHIFDmxOd0fq95+4r991FROFVeq5mIOW19ul4WtFzYcMKXI7qhe9vYCc5t5J0wTodH7Wvs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733238213; c=relaxed/simple;
	bh=V8+ysC5IKB0EIES1HQPo7q+qX0dVeros7qxPpohzJIs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qJ5zmcHD1TdOIOl1iQpuuyNGcPS1knmfq6mbwv9Z7p7er+mqfRN6d8oh2qjR6Ln0tHq/obe3OUR2XCozy051vE34UW9f5GDzmZICNrqbEAgUZSwTDq9id0A0mpI3w6qVNXX+F6fRGxIO/1pYerKZyuxmAE9XJ3DCuDYuycROfiw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 169063858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=baXy3ijl
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20241203150327904.JAUX.116458.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 4 Dec 2024 00:03:27 +0900
Date: Wed, 4 Dec 2024 00:03:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: signal: Optimize the priority of the sig
 thread
Message-Id: <20241204000327.ed60cd7b8425880ca63be68a@nifty.ne.jp>
In-Reply-To: <Z08WJazDsg535Bew@calimero.vinschen.de>
References: <20241203140203.8351-1-takashi.yano@nifty.ne.jp>
	<Z08WJazDsg535Bew@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733238207;
 bh=jwuwP2e0xMI835qA/6K8Nl2n5lMsSwEgAO/EYm+UVbU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=baXy3ijlH7z/wP9Vnh+j9E3s3AEtrUne/H+/KJ5a89dclY7YphqxoLPLL4JCrXopKt6XJs34
 44YwAVpvIwxl52BVMx2kyZW9ulGmzpN9UQHRNX9LkhEPIsdeT5ZMkNJAGeMKQjBaBSGoCSWOjC
 k8hcCb9oRnDpHwnBkTHkXLuICq1j73VrxzGx9ilaR5dr0iluPphxMCp17FhoU3hx8KQjJr6r1L
 KmqX2WWEkgOxWVFuB/3u7SK1RF0glCkvyLcbagjFQRxrLxKvCmtzQp4F06DPqlVAVxkqgbZgxA
 ZI/p5KM01IKk+NGBsTTDxTSQgsnNsqQkAL3ABHPHy/KGZbqw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 3 Dec 2024 15:31:01 +0100
Corinna Vinschen wrote:
> On Dec  3 23:01, Takashi Yano wrote:
> > Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
> > This causes a critical delay in the signal handling in the main
> > thread if too many signals are received rapidly and the CPU is very
> > busy. In this case, most of the CPU time is allocated to the sig
> > thread, so the main thread cannot have a chance of handling signals.
> > With this patch, to avoid such a situation, the priority of the sig
> > thread is set to THREAD_PRIORITY_NORMAL priority.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/sigproc.cc | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > index 730259484..4c557f048 100644
> > --- a/winsup/cygwin/sigproc.cc
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -1333,6 +1333,7 @@ wait_sig (VOID *)
> >  
> >    hntdll = GetModuleHandle ("ntdll.dll");
> >  
> > +  SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_NORMAL);
> >    for (;;)
> >      {
> >        DWORD nb;
> > -- 
> > 2.45.1
> 
> Yep, please push.  This is the one you can eventually push to
> the 3.5 branch.
> 
> For 3.6 I suggest that you or I'll submit a patch removing this line
> again, in favor of dropping the line in cygthread::async_create
> setting the prio to HIGHEST.  But only after the threasd series is
> complete, ok?

I see.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
