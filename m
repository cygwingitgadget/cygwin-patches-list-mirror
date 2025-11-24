Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 188C63858D2A; Mon, 24 Nov 2025 16:01:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 188C63858D2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764000083;
	bh=KUJBvOnhTLtqpZQnLpC/P6CTl9C5UWRPNyFxcL2w8ok=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lFSpYKdRWbIo9JYR3XaA+Mk7CNQO2b7mOw66O6WMuC4kANbSwStmCjhMAwOl6XRHg
	 noA+5hRBM+5f5uBowKPdhOcHj2yTMKMnKrgXAauQBAR6KO1dIcOQ0q5vg4R7NrildX
	 la41FA1HLmv62PqIa9U1hGgD78uG5QM7/HpDGCmw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 09F82A80A5E; Mon, 24 Nov 2025 17:01:21 +0100 (CET)
Date: Mon, 24 Nov 2025 17:01:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already released
Message-ID: <aSSBUMJ8l3dYWR4T@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
 <aSRKB6KpYHIViSD_@calimero.vinschen.de>
 <aSRY7wyUJFby7XHZ@calimero.vinschen.de>
 <20251124223546.9d3e2b5085fb2d71dca3479f@nifty.ne.jp>
 <20251124225933.b32dd342d5d0795dee496e8d@nifty.ne.jp>
 <20251124233114.0e3e1f3328ea3cbda7cf81d0@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124233114.0e3e1f3328ea3cbda7cf81d0@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 24 23:31, Takashi Yano wrote:
> On Mon, 24 Nov 2025 22:59:33 +0900
> Takashi Yano wrote:
> > On Mon, 24 Nov 2025 22:35:46 +0900
> > Takashi Yano wrote:
> > > On Mon, 24 Nov 2025 14:09:03 +0100
> > > Corinna Vinschen wrote:
> > > > Version 2 of the patch.  Rather than calling get_all_locks_list()
> > > > from lf_setlock() *and* lf_clearlock(), call it right from
> > > > fhandler_base::lock() to avoid calling the function twice.
> > > > Also, move comment.
> > > > [...]
> > > Thanks. Your patch looks better than mine, however, this
> > > does not fix the second error in the report; i.e.,
> > > 
> > > tmp_dir: /tmp/flockRsYGNU
> > > done[7]
> > > done[3]
> > > lock error: 14 - Bad address: 3
> > > assertion "lock_res == 0" failed: file "main.c", line 40, function: thread_func
> > >                                                                                Aborted
> > > 
> > > while mine does. I'm not sure why...
> > 
> > fhandler_base::lock() seems necessary to be reentrant for the original
> > test case, because, your v2 patch + making i_all_lf local variable
> > solves the issue. Please see my v2 patch.
> > 
> > What do you think?
> 
> I think I understand now.
> 
> The object of inode_t * is inside cygheap, and it is not thread-local.
> So if i_all_lf in inode_t * is changed by another thread, the pointer
> i_all_lf is destroied.

Ooooh, ok.  I was already puzzeling about the potential situation where
fhandler_base::lock() should be reentrant.

I think I get it now.  While the node is in use, it's supposed to be
LOCK()ed.  But if we're waiting for a blocking POSIX lock, the node
gets temporarily UNLOCK()ed.  So we have a valid w_get() in i_all_lf
potentially overwritten by another w_get() which gets released and
potentially reused in a different context, while i_all_lf still holds
the pointer.

Your usage of a local variable is perfectly fine, considering the above.

However, I wonder if we don't have a general thinko here, in that we're
using a TLS buffer or a temporary buffer at all?  Thinking it through...

[Careful, idle musing ahead...]

I_all_lf is a member of inode_t because the data stored therein is not
thread local, but node local.  It's content doesn't depend on the thread
it's used in, just on the state the file locks are in.

The content of i_all_lf is refreshed evey time the lock list is
required, and it's always refreshed under node LOCK() conditions.

A pointer to a member of the lock list in i_all_lf is only generated and
returned to the caller by getblock().  getblock() is used under node
LOCK() conditions.

But, this pointer is used once during node UNLOCK(): in the lf_setlock()
loop scanning for blocking locks, when we find a lock that blocks us.
Line 1301 in origin/main:

    proc = OpenProcess (SYNCHRONIZE, FALSE, block->lf_wid);
                                            ^^^^^^^^^^^^^

This can be avoided easily by introducing a local variable getting the
windows id before calling node->UNLOCK().

So we could avoid using w_get() in every call to fcntl/flock/lockf if we
always create the inode_t with an allocated i_all_lf which never gets
changed or deallocated.  But that also requires to re-malloc() i_all_lf
after execve().

Alternatively we convert i_all_lf to an array member, so it's allocated
on the cygheap automatically. But then every node takes almost 100K on
the cygheap rather than just 64 bytes.  No, scratch that, that sounds bad.

Or we just stick to your V2 patch using local TLS buffers, given the
temporary nature of the data.

What do you think is the better approach here, single malloc per node or
TLS per invocation?


Corinna
