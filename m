Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E9F663858D29; Mon, 24 Mar 2025 15:35:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E9F663858D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742830510;
	bh=Xb0dugDd866V35qHaBpRKZStwAui77Kur5wjdA1W50w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=IrFaGUfmFgKKsE2CgMFPdU9+mq6uPV2HNYOXr5ivMbqhVvJvHMRUsL3SbVIi6MsJg
	 1MdF62JuSdKNInsvLwB0UhjIM1eTNkydl9+U/OvVkT/HrDX1a4I6BkAA5+vf/6ejM5
	 K3qKwX6yKLRHfuY1HmXzs2JQFWxHoq70kj4g/dms=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 59353A80B7A; Mon, 24 Mar 2025 16:35:08 +0100 (CET)
Date: Mon, 24 Mar 2025 16:35:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired multiple
 times.
Message-ID: <Z-F7rKIQfY2aYHSD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp>
 <Z-E6groYVnQAh-kj@calimero.vinschen.de>
 <20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 24 22:05, Takashi Yano wrote:
> Hi Corinna,
> 
> On Mon, 24 Mar 2025 11:57:06 +0100
> Corinna Vinschen wrote:
> > On Mar 24 14:53, Takashi Yano wrote:
> > > Previously, the fast_mutex defined in thread.h could not be aquired
> > > multiple times, i.e., the thread causes deadlock if it attempted to
> > > acquire a lock already acquired by the thread. For example, a deadlock
> > > occurs if another pthread_key_create() is called in the destructor
> > > specified in the previous pthread_key_create(). This is because the
> > > run_all_destructors() calls the desructor via keys.for_each() where
> > > both for_each() and pthread_key_create() (that calls List_insert())
> > > attempt to acquire the lock. With this patch, the fast_mutex can be
> > > acquired multiple times by the same thread similar to the behaviour
> > > of a Windows mutex. In this implementation, the mutex is released
> > > only when the number of unlock() calls matches the number of lock()
> > > calls.
> > 
> > Doesn't that mean fast_mutex is now the same thing as muto?  The
> > muto type was recursive from the beginning.  It's kind of weird
> > to maintain two lock types which are equivalent.
> 
> I have just looked at muto implementation. Yeah, it looks very
> similar to fast_mutex with this patch. However, the performance
> is different. fast_mutex with this patch is two times faster
> than muto when just repeatedly locking/unlocking. If two threads
> compete for the same mutex, the performance is almost the same.

Ok, nice to know.  With fast_mutex being mostly faster and being
recursive with your patch, maybe we could replace all mutos with
this fast_mutex?

> > I wonder if we shouldn't drop the keys list structure entirely, and
> > convert "keys" to a simple sequence number + destructor array, as in
> > GLibc.  This allows lockless key operations and drop the entire list and
> > mutex overhead.  The code would become dirt-easy, see
> > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_create.c
> > https://sourceware.org/cgit/glibc/tree/nptl/pthread_key_delete.c
> > 
> > What do you think?
> 
> It looks very simple and reasonable to me.
> 
> > However, for 3.6.1, the below patch should be ok.
> 
> What about reimplementing pthread_key_create/pthread_key_delete
> based on glibc for master branch, and appling this patch to
> cygwin-3_6-branch?
> 
> Shall I try to reimplement them?

That would be great!


Thanks,
Corinna
