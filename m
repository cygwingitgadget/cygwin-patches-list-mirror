Return-Path: <SRS0=N7Gl=WN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id 6B3AF385AC1B
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 09:24:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6B3AF385AC1B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6B3AF385AC1B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742981064; cv=none;
	b=KFfuCYnqZdVkXgREnthXdfDwintkf497B0aHT6QubDtHpNbK5r7RrQjGi633KaTCMxcZP7ZX7JAquRdlMWmsQfkXW7/TDnxGEsrlXB9VUxmuGkQ5U0zziCDwKFuKaM44pDKcrJK9N++DTnIVuviTCChWJ3qCeik16ZK89IHGRqM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742981064; c=relaxed/simple;
	bh=ir5lRFcaWgeGOLC9wg0+URLynyBmnfqE9uoyNPYPIyI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=MbLQ5Xg2rIMzkdZmwri92Z47Yxf9cYIy4i++y9WamMCiJT/vt80IR7DLm+HNEwQtlKAztYE57Eb4onDGir9GwvDXMXC6myIOINuC2ZlXT0GlYCLlWW+OazJN7pXKCjGzTj2dWML4ZonOna2O37yo4X4rQcVLGyEjMXMjigAO2FM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6B3AF385AC1B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=CTUO0AaY
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20250326092422645.GBVF.45927.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 18:24:22 +0900
Date: Wed, 26 Mar 2025 18:24:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired
 multiple times.
Message-Id: <20250326182422.8eade9b58ae30757e0f45a5a@nifty.ne.jp>
In-Reply-To: <20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
	<Z-E6groYVnQAh-kj@calimero.vinschen.de>
	<20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
	<Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
	<20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742981062;
 bh=QzP6e6Xz2caHm0tSFklEYxV5tSI/OghmuKqePkfBR7Y=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=CTUO0AaY6mSUEArUvfy51K+d3DBL7HNsZpGY7gsFHZGE+3FAWeL1xey3CglBHPMtgs04vgVz
 58fyMWlxjYqDZjD2UG4b6/uqzES5NzputY9CenCQQEJ26qeus6UBiE9Vtye5ao/vZfUALWkljv
 n+GsaYHycPAH156d2a1Y8GYksVG8Vn9GXn7GAuOhoMQhcUD84HVOZrJ3mVJjIhISwf2NeEF9fu
 iaSNHCaiJNRnYDjTUqw+ClWBkvrHAkSP8kD6UqwDGF8dlet17YAnQSJ0geYEdhhRnGhEuoouod
 OH+dGCAndlNWqcy5nRXJJmE7h6HEuFHjIhSZit715BgBKp6A==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 26 Mar 2025 18:14:04 +0900
Takashi Yanowrote:
> Hi Corinna,
> 
> On Mon, 24 Mar 2025 16:35:08 +0100
> Corinna Vinschen wrote:
> > On Mar 24 22:05, Takashi Yano wrote:
> > > Hi Corinna,
> > > 
> > > On Mon, 24 Mar 2025 11:57:06 +0100
> > > Corinna Vinschen wrote:
> > > > On Mar 24 14:53, Takashi Yano wrote:
> > > > > Previously, the fast_mutex defined in thread.h could not be aquired
> > > > > multiple times, i.e., the thread causes deadlock if it attempted to
> > > > > acquire a lock already acquired by the thread. For example, a deadlock
> > > > > occurs if another pthread_key_create() is called in the destructor
> > > > > specified in the previous pthread_key_create(). This is because the
> > > > > run_all_destructors() calls the desructor via keys.for_each() where
> > > > > both for_each() and pthread_key_create() (that calls List_insert())
> > > > > attempt to acquire the lock. With this patch, the fast_mutex can be
> > > > > acquired multiple times by the same thread similar to the behaviour
> > > > > of a Windows mutex. In this implementation, the mutex is released
> > > > > only when the number of unlock() calls matches the number of lock()
> > > > > calls.
> > > > 
> > > > Doesn't that mean fast_mutex is now the same thing as muto?  The
> > > > muto type was recursive from the beginning.  It's kind of weird
> > > > to maintain two lock types which are equivalent.
> > > 
> > > I have just looked at muto implementation. Yeah, it looks very
> > > similar to fast_mutex with this patch. However, the performance
> > > is different. fast_mutex with this patch is two times faster
> > > than muto when just repeatedly locking/unlocking. If two threads
> > > compete for the same mutex, the performance is almost the same.
> > 
> > Ok, nice to know.  With fast_mutex being mostly faster and being
> > recursive with your patch, maybe we could replace all mutos with
> > this fast_mutex?
> > 
> > > > I wonder if we shouldn't drop the keys list structure entirely, and
> > > > convert "keys" to a simple sequence number + destructor array, as in
> > > > GLibc.  This allows lockless key operations and drop the entire list and
> > > > mutex overhead.  The code would become dirt-easy, see
> > > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_create.c
> > > > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_delete.c
> > > > 
> > > > What do you think?
> > > 
> > > It looks very simple and reasonable to me.
> > > 
> > > > However, for 3.6.1, the below patch should be ok.
> > > 
> > > What about reimplementing pthread_key_create/pthread_key_delete
> > > based on glibc for master branch, and appling this patch to
> > > cygwin-3_6-branch?
> > > 
> > > Shall I try to reimplement them?
> > 
> > That would be great!
> 
> What about the patch attached?
> Is this as you intended?

Having a race issue between pthread_key_delete() and
_fixup_befor_fork()/_fixup_after_fork()/run_all_destructors().

Let me consider again.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
