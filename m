Return-Path: <SRS0=26d4=UM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 391C63858C5F
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 14:24:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 391C63858C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 391C63858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737383060; cv=none;
	b=Hk8h6d8s88ozLDFceLVTn8mltIqr2wiw/XAAxhYcScf7I+qwXyzHHydo97rW0iuFM1tvnxYp++FqAw8dbqjZJMhbSl9QKmLzPVexdT04R98cKyDXxSaxJJjpsVN5DY2Z5MD5K1LOtSw8qwplqn0YOlaRbZrpXgOKoYMZKvy8dxk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737383060; c=relaxed/simple;
	bh=hQEiaYW5eglGdRKQzj+CmHAs/KTuPU9KkY6Ntdkugv0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=g+2Kyl4Gu4X9zk4pwdrkOX8xPKVpG0rWGHuQs9bo1fg132ODcxoti2hd83ZRH/py7zFMuQTkget8a9M99mPiX0dXC6vMdziv0xK18rvaV3i/PaY280XTar853oiLTuHkKFYzcbuxOzotgOUzS3mhqeb6/l4qiq69Lsjs08yI+7c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 391C63858C5F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=o+mOam2q
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20250120142418609.MXON.102422.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 23:24:18 +0900
Date: Mon, 20 Jan 2025 23:24:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250120232417.cb86d7bcc439c9d5820e1548@nifty.ne.jp>
In-Reply-To: <Z442y6VhRE7IHVXo@calimero.vinschen.de>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
	<8bdee3d3-1200-b70d-5829-d0a081323562@jdrake.com>
	<20250119114958.82129e29fae9093f38dac53c@nifty.ne.jp>
	<20250119194206.862aecab375cb03c7143c22e@nifty.ne.jp>
	<Z442y6VhRE7IHVXo@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737383058;
 bh=51wyigLSiiiKjjr5cPCKTM8BVl92Bw92QugQ4mUkS3k=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=o+mOam2qb1m+xUi9ZT75EBc4lAknVH1HgMw9x8p6bd5YbEJloiyU2NEz2vGqLfRWWqO8d9wZ
 00JpnnWAASM0mLxQiVXrWJwOqxLuUuY/q4e9sZVLytu8bNC3gjOReB3mim4BLgWzu7hGmkoB3l
 ablnespe4IRjAzkJUrdBYayWocotoaguoiNFnQ7/P+OsciVBsZlzRw/BKBWvZNYpXCT2+HOvNf
 mEaJfaxDmdfp3sg9DddEMudypH3J+i7b0DC/naiy1xTBJvveXDIsot9qbALFEskKRc9k6a3wj0
 xGu6z/IzCM7GP14H9QY0EKjCyw4lY/m/oBs6QXHVjaZ+8uIg==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 20 Jan 2025 12:43:07 +0100
Corinna Vinschen wrote:
> On Jan 19 19:42, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Sun, 19 Jan 2025 11:49:58 +0900
> > Takashi Yano wrote:
> > > On Sat, 18 Jan 2025 17:06:50 -0800 (PST)
> > > Jeremy Drake wrote:
> > > > On Sat, 18 Jan 2025, Takashi Yano wrote:
> > > > 
> > > > > While debugging this problem, I encountered another hang issue,
> > > > > which is fixed by:
> > > > > 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> > > > 
> > > > I'm concerned about this patch.  There's a window where current_sig could
> > > > be changed after exiting the while, before the lock is acquired by
> > > > cygheap->find_tls (_main_tls);  Should current_sig be rechecked after the
> > > > lock is acquired to make sure that hasn't happened?  Also, does
> > > > current_sig need to be volatile, or is yield a sufficient fence for the
> > > > compiler to know other threads may have changed the value?
> > > 
> > > Thanks for pointing out this. You are right if othre threads may
> > > set current_sig to non-zero value. Current cygwin sets current_sig
> > > to non-zero only in 
> > > _cygtls::interrupt_setup()
> > > and
> > > _cygtls::handle_SIGCONT()
> > > both are called from sigpacket::process() as follows.
> > > 
> > > wait_sig()->
> > >  sigpacket::process() +-> sigpacket::setup_handler() -> _cygtls::interrupt_setup()
> > >                       \-> _cygtls::handle_SIGCONT()
> > > 
> > > wait_sig() is a thread which handle received signals, so other
> > > threads than wait_sig() thread do not set the current_sig to non-zero.
> > > That is, other threads set current_sig only to zero. Therefore,
> > > I think we don't have to guard checking current_sig value by lock.
> > > The only thing we shoud guard is the following case.
> > > 
> > > [wait_sig()]               [another thread]
> > > current_sig = SIGCONT;
> > >                            current_sig = 0;
> > > set_signal_arrived();
> > > 
> > > So, we should place current_sig = SIGCONT and set_signal_arrived()
> > > inside the lock.
> > 
> > I think the lock necessary here is _cygtls::lock(), isn't it?
> > Because the _cygtls::call_signal_handler() uses _cygtls::locl().
> > I'm asking you because you introduced the find_tls() lock first
> > in the commit:
> 
> Yeah, _cygtls::lock() of the target thread should be right.
> The mutex in find_tls was for guarding threadlist_t, not the
> thread's _cygtls.

Thanks! I'll submit a v2 patch. Please review.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
