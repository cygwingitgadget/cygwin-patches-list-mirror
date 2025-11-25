Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1E4FC3858C51; Tue, 25 Nov 2025 10:38:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1E4FC3858C51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764067105;
	bh=U+uBgyspJsW4eYAXTocU8STcweIR1srPzxbNjg/rjP8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WoqImtm55PMGl1Z/oKSEytjomKhIbhYHoIeFzKDX4e34fEibJPAcr8uOIYcp8pggj
	 GMxZnaaPU8l9sPGVw0Gue61kqC85XAmRWPw3qUzBSRGLtwNSaK9U/9wxmdDamNj/c4
	 S8o9QwEP2UnMvdbUsxdgXfonu0fpXebx6/br/JtE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1FA9AA805BC; Tue, 25 Nov 2025 11:38:23 +0100 (CET)
Date: Tue, 25 Nov 2025 11:38:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already released
Message-ID: <aSWHH95BcSy6wHed@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
 <aSRKB6KpYHIViSD_@calimero.vinschen.de>
 <aSRY7wyUJFby7XHZ@calimero.vinschen.de>
 <20251124223546.9d3e2b5085fb2d71dca3479f@nifty.ne.jp>
 <20251124225933.b32dd342d5d0795dee496e8d@nifty.ne.jp>
 <20251124233114.0e3e1f3328ea3cbda7cf81d0@nifty.ne.jp>
 <aSSBUMJ8l3dYWR4T@calimero.vinschen.de>
 <20251125112948.0136d0bdd77aca512f9977d0@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125112948.0136d0bdd77aca512f9977d0@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 25 11:29, Takashi Yano wrote:
> On Mon, 24 Nov 2025 17:01:20 +0100
> Corinna Vinschen wrote:
> > I_all_lf is a member of inode_t because the data stored therein is not
> > thread local, but node local.  It's content doesn't depend on the thread
> > it's used in, just on the state the file locks are in.
> > 
> > The content of i_all_lf is refreshed evey time the lock list is
> > required, and it's always refreshed under node LOCK() conditions.
> > 
> > A pointer to a member of the lock list in i_all_lf is only generated and
> > returned to the caller by getblock().  getblock() is used under node
> > LOCK() conditions.
> > 
> > But, this pointer is used once during node UNLOCK(): in the lf_setlock()
> > loop scanning for blocking locks, when we find a lock that blocks us.
> > Line 1301 in origin/main:
> > 
> >     proc = OpenProcess (SYNCHRONIZE, FALSE, block->lf_wid);
> >                                             ^^^^^^^^^^^^^
> > 
> > This can be avoided easily by introducing a local variable getting the
> > windows id before calling node->UNLOCK().
> > 
> > So we could avoid using w_get() in every call to fcntl/flock/lockf if we
> > always create the inode_t with an allocated i_all_lf which never gets
> > changed or deallocated.  But that also requires to re-malloc() i_all_lf
> > after execve().
> 
> Good point. I was wondering why i_all_lf need to be temporary. However,
> I'm not sure why re-allocation is necessary for execve() case?
> 
> cygheap is initialized to initial state after execve(), isn't it?

Of course not.  Cygheap contains datastructures inherited by exec'ed
processes, one of the major reasons to keep the cygheap separate from
the user heap.  Think fhandlers representing descriptors.

Same goes for the lock nodes and the locks.  See fhandler_base::del_my_locks()
and fixup_lockf_after_exec():

- flock(2) locks are associated with a descriptor.  That means, flock(2)
  locks are duplicated by dup(2), fork(2), execve(2).  The nodes have to
  be preserved over fork(2) and execve(2) (unless CLOFORK/CLOEXEC).

- Traditional advisory POSIX locks are bound to the PID of a process.
  The node can be deleted in the child after fork(2) but has to be
  preserved after execve(2).

- OFD locks are like flock(2) locks associated with a descriptor.

So the i_all_lf member will be inherited by the execve'd process, but
the pointer is pointing into the user heap which does not
get inherited and has to be freshly allocated in the new process.

> > Alternatively we convert i_all_lf to an array member, so it's allocated
> > on the cygheap automatically. But then every node takes almost 100K on
> > the cygheap rather than just 64 bytes.  No, scratch that, that sounds bad.

While writing this down, I'm getting second, third, and forth thoughts.

How bad would it really be to keep i_all_lf on the cygheap as well, by
converting it to a statically sized array?

The somewhat inflexible allocation strategy of cygheap always allocates
in fixed chunk sizes.  inode_t is 72 bytes right now.  If we stick to
the definition of MAX_LOCKF_CNT, inode_t would have a size of 65584
bytes, which leads to a chunk size of 96K.  If we reduce MAX_LOCKF_CNT
by 1 (909 instead of 910), inode_t would fit into a 64K chunk.  The
cygheap has an initial size of 3 Megs and is only limited by the start
of the user heap, so it could potentially grow to 8 Gigs.

On the downside the cygheap gets slightly bigger for a process using
file locking and copying cygheap during fork/execve gets slightly
slower.

On the upside we don't have to care for additional space at all.  No
extra malloc during inode_t init or execve(2), no free in ~inode_t().

How many files are typically locked in parallel by a single process or
descriptor while the process forks/execs?

If this is a low number (<10?), then the space and copy overhead of
having a 64K node in cygheap should beat the malloc/free overhead of
the same number of nodes.

> I prefer single malloc(), if the cost of malloc() is not much larger than
> tmp_pathbuf::w_get().

w_get() is using malloc() under the hood, so it's basically the same in
terms of cost on first invocation.

The advantage of w_get() is in reusing already allocated areas, so
there's a considerable chance that w_get() just returns a pointer without
having to call malloc().  Assuming the same thread is running the locking
calls in a process and uses w_get() every time (as in your original or v2
patches), malloc() will be very likely called only once in this thread on
the first flock/fcntl call, and any subsequent flock/fcntl will reuse
this buffer.

That means:

- i_all_lf as array incures extra cost only at fork/execve time by
  having to copy additional 64K over to the child process.

- i_all_lf as malloced pointer in inode_t incures extra cost once
  per created inode (malloc), once per execve (malloc), once per
  deleted inode (free).

- i_all_lf as local variable incures extra cost once per thread
  (malloc), per process, under ideal conditions. 


Corinna
