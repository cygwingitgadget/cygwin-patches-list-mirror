Return-Path: <SRS0=g3Q1=WL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id B20483858D1E
	for <cygwin-patches@cygwin.com>; Mon, 24 Mar 2025 13:05:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B20483858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B20483858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742821525; cv=none;
	b=WanSij9T3wUcRT7Dp99pHcF9GD+bVVlcfdm3D2bFYaas7n9kkYHwQ0ZLbhEMpjO1EDb09T0gkaPckHRbPJPSOBXcUVkDztFIMYiK7ZEfGdVOkiELPXYTayy36lZScnopOVtyIkI8WLrB8msqk1dTpiPZ/0stOpeMfClmbxM3vc4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742821525; c=relaxed/simple;
	bh=hC5AfOma6ml0ZSeOdCDNk4AqGqvNVRhPdiHeM/Ay2KA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=orsKT9fkqJVF1Ad6ISbLHbpAS666rtIqXYEqcGXpOsrzLfQxZVApL6zEnG8rK3pcODVHlOq6fJLAYOfh3dbR/EYylavH/KDjYRj5xbdx06/OejrfjxVb5ZSo07576YYTpcSNVF8Wr1ocHClSYVeyb09hyK6FjAJUYi+xRNyCk3o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B20483858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ocWNC+Pt
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20250324130522770.FNVR.88147.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 24 Mar 2025 22:05:22 +0900
Date: Mon, 24 Mar 2025 22:05:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired
 multiple times.
Message-Id: <20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
In-Reply-To: <Z-E6groYVnQAh-kj@calimero.vinschen.de>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
	<Z-E6groYVnQAh-kj@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742821522;
 bh=IXw4344TzfX+rmDJlznKK40U7oYkrcfwjiYCzkfkRyE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ocWNC+PtAfVkLSVS22M9a0YrtCMPgusLJE/exj5cAAMpV+Im3W4GnKTLAWWbbaJiRnOrYDu/
 d0chKZ3hx2soxl7GWeQ/TbT1rXmsliJdPF99AkzcRG5OfU/cFR7BfZ4rMCMQnQObsgv1BpIv5d
 YAnSU4M/z0cbCxQLCch5KLvZ2ELvol3qRNxYrc+YnWGz+CBHS9225hV9RalB+8k3PTbAxcUAjc
 TPLQHFGcSuFOME3fXfLlEZIP6vy/TsLPUIjiw1nL2Uam8/dP08XRWMgaF7oX79pE1Xxe9DRd1l
 Wab5IWcUuX1mh6klKhkR0y+xpcNHyQm+F8EGsuPFv6UgP0gw==
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 24 Mar 2025 11:57:06 +0100
Corinna Vinschen wrote:
> On Mar 24 14:53, Takashi Yano wrote:
> > Previously, the fast_mutex defined in thread.h could not be aquired
> > multiple times, i.e., the thread causes deadlock if it attempted to
> > acquire a lock already acquired by the thread. For example, a deadlock
> > occurs if another pthread_key_create() is called in the destructor
> > specified in the previous pthread_key_create(). This is because the
> > run_all_destructors() calls the desructor via keys.for_each() where
> > both for_each() and pthread_key_create() (that calls List_insert())
> > attempt to acquire the lock. With this patch, the fast_mutex can be
> > acquired multiple times by the same thread similar to the behaviour
> > of a Windows mutex. In this implementation, the mutex is released
> > only when the number of unlock() calls matches the number of lock()
> > calls.
> 
> Doesn't that mean fast_mutex is now the same thing as muto?  The
> muto type was recursive from the beginning.  It's kind of weird
> to maintain two lock types which are equivalent.

I have just looked at muto implementation. Yeah, it looks very
similar to fast_mutex with this patch. However, the performance
is different. fast_mutex with this patch is two times faster
than muto when just repeatedly locking/unlocking. If two threads
compete for the same mutex, the performance is almost the same.

> I wonder if we shouldn't drop the keys list structure entirely, and
> convert "keys" to a simple sequence number + destructor array, as in
> GLibc.  This allows lockless key operations and drop the entire list and
> mutex overhead.  The code would become dirt-easy, see
> https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_create.c
> https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_delete.c
> 
> What do you think?

It looks very simple and reasonable to me.

> However, for 3.6.1, the below patch should be ok.

What about reimplementing pthread_key_create/pthread_key_delete
based on glibc for master branch, and appling this patch to
cygwin-3_6-branch?

Shall I try to reimplement them?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
