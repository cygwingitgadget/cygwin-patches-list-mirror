Return-Path: <SRS0=4N44=6B=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id C6B38385843B
	for <cygwin-patches@cygwin.com>; Tue, 25 Nov 2025 02:29:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C6B38385843B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C6B38385843B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1764037794; cv=none;
	b=AIf5RRe+t7mtJqMcL9+/zDX1eYXaJBUD0slI1ksFNhMiKmJq/hP4/++9l0HdOkZHwrowqe0hhEMAkM+NlszDhLmcJI1Z/m8JFR39EkNdL4fuBeHCEmBlRNNcCE59rGiIrZ/ySLT24XUpAIlS1HcpYqY+2s57kwT+2YCl+s1weK0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1764037794; c=relaxed/simple;
	bh=YA7ihOpK3OvKnXu5CFzpkmNiML14lLvO6x+/aR+Q8iM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=SojFOGX4Wv6KliElkJo75DG7ADexZXvnlIekCR1Nqh2nVNwDt7tMdBFFs1dWA6N/iA3L1QuACP7F25iNdmes+Lwo/1UIE9XmJz7vpx8Vt/FKV6AZoyIdx0kwNNHUWMjPA3/EdTabkdBP3DLzWMGOVWHAS+XSLxg8PqeZBFh7l9M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C6B38385843B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gnWPflna
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20251125022949754.HGOW.15876.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 25 Nov 2025 11:29:49 +0900
Date: Tue, 25 Nov 2025 11:29:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already
 released
Message-Id: <20251125112948.0136d0bdd77aca512f9977d0@nifty.ne.jp>
In-Reply-To: <aSSBUMJ8l3dYWR4T@calimero.vinschen.de>
References: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
	<aSRKB6KpYHIViSD_@calimero.vinschen.de>
	<aSRY7wyUJFby7XHZ@calimero.vinschen.de>
	<20251124223546.9d3e2b5085fb2d71dca3479f@nifty.ne.jp>
	<20251124225933.b32dd342d5d0795dee496e8d@nifty.ne.jp>
	<20251124233114.0e3e1f3328ea3cbda7cf81d0@nifty.ne.jp>
	<aSSBUMJ8l3dYWR4T@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1764037789;
 bh=XDuLqOK0gNO3tl9f/AnRq/YuMkdkf4d6VA55SeK7ntw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=gnWPflnaOa14pbmld6EZDY/+KwCqlRRg4Vosa1m3apmq7rxdsDuBDGMRx5roKHsbyMjhpWri
 R8XgM3oyXfx+QPogIF/AUCBMsVsJ5elFfpuLuovWsWQtV4S0UMaZhjkS8jt8+5xvNxuWy37Nqn
 VsN/tqjrWK/eaPN48SMv0ED2m29l2uWkU09en5J6V5aXJt7+1XzOhfsuaZOgjxudMN8wOwJxMW
 Ku99Hxrg4MafLayL0/auW0Mi/gTlZIZ2NDNrq31bgJadAbDkBasVeK72+T9DQVS2yAshEjZeo7
 S3UrjsAcnp2hp4diMlLOC/RQmeXIGmhIZXbO/JY876yIIksw==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 24 Nov 2025 17:01:20 +0100
Corinna Vinschen wrote:
> On Nov 24 23:31, Takashi Yano wrote:
> > On Mon, 24 Nov 2025 22:59:33 +0900
> > Takashi Yano wrote:
> > > On Mon, 24 Nov 2025 22:35:46 +0900
> > > Takashi Yano wrote:
> > > > On Mon, 24 Nov 2025 14:09:03 +0100
> > > > Corinna Vinschen wrote:
> > > > > Version 2 of the patch.  Rather than calling get_all_locks_list()
> > > > > from lf_setlock() *and* lf_clearlock(), call it right from
> > > > > fhandler_base::lock() to avoid calling the function twice.
> > > > > Also, move comment.
> > > > > [...]
> > > > Thanks. Your patch looks better than mine, however, this
> > > > does not fix the second error in the report; i.e.,
> > > > 
> > > > tmp_dir: /tmp/flockRsYGNU
> > > > done[7]
> > > > done[3]
> > > > lock error: 14 - Bad address: 3
> > > > assertion "lock_res == 0" failed: file "main.c", line 40, function: thread_func
> > > >                                                                                Aborted
> > > > 
> > > > while mine does. I'm not sure why...
> > > 
> > > fhandler_base::lock() seems necessary to be reentrant for the original
> > > test case, because, your v2 patch + making i_all_lf local variable
> > > solves the issue. Please see my v2 patch.
> > > 
> > > What do you think?
> > 
> > I think I understand now.
> > 
> > The object of inode_t * is inside cygheap, and it is not thread-local.
> > So if i_all_lf in inode_t * is changed by another thread, the pointer
> > i_all_lf is destroied.
> 
> Ooooh, ok.  I was already puzzeling about the potential situation where
> fhandler_base::lock() should be reentrant.
> 
> I think I get it now.  While the node is in use, it's supposed to be
> LOCK()ed.  But if we're waiting for a blocking POSIX lock, the node
> gets temporarily UNLOCK()ed.  So we have a valid w_get() in i_all_lf
> potentially overwritten by another w_get() which gets released and
> potentially reused in a different context, while i_all_lf still holds
> the pointer.
> 
> Your usage of a local variable is perfectly fine, considering the above.
> 
> However, I wonder if we don't have a general thinko here, in that we're
> using a TLS buffer or a temporary buffer at all?  Thinking it through...
> 
> [Careful, idle musing ahead...]
> 
> I_all_lf is a member of inode_t because the data stored therein is not
> thread local, but node local.  It's content doesn't depend on the thread
> it's used in, just on the state the file locks are in.
> 
> The content of i_all_lf is refreshed evey time the lock list is
> required, and it's always refreshed under node LOCK() conditions.
> 
> A pointer to a member of the lock list in i_all_lf is only generated and
> returned to the caller by getblock().  getblock() is used under node
> LOCK() conditions.
> 
> But, this pointer is used once during node UNLOCK(): in the lf_setlock()
> loop scanning for blocking locks, when we find a lock that blocks us.
> Line 1301 in origin/main:
> 
>     proc = OpenProcess (SYNCHRONIZE, FALSE, block->lf_wid);
>                                             ^^^^^^^^^^^^^
> 
> This can be avoided easily by introducing a local variable getting the
> windows id before calling node->UNLOCK().
> 
> So we could avoid using w_get() in every call to fcntl/flock/lockf if we
> always create the inode_t with an allocated i_all_lf which never gets
> changed or deallocated.  But that also requires to re-malloc() i_all_lf
> after execve().

Good point. I was wondering why i_all_lf need to be temporary. However,
I'm not sure why re-allocation is necessary for execve() case?

cygheap is initialized to initial state after execve(), isn't it?

> Alternatively we convert i_all_lf to an array member, so it's allocated
> on the cygheap automatically. But then every node takes almost 100K on
> the cygheap rather than just 64 bytes.  No, scratch that, that sounds bad.
> 
> Or we just stick to your V2 patch using local TLS buffers, given the
> temporary nature of the data.
> 
> What do you think is the better approach here, single malloc per node or
> TLS per invocation?

I prefer single malloc(), if the cost of malloc() is not much larger than
tmp_pathbuf::w_get().

I have created v3 patch based on your idea. Please have a look.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
