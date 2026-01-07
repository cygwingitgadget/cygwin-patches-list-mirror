Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B77534BA23C7; Wed,  7 Jan 2026 10:52:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B77534BA23C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1767783143;
	bh=dbhoKPBwDBFyPeinl/8wdjWW+DDkbRHHRN7NPyGYzb8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=XXfaCa1CfinSGRrxJxuFQphmhRKINIeC8xnUNoxKbcB7C30uVYgBhHBylZrFzEaFB
	 fkcc7dQKTSwqdWR1+4aucVvFKFqviTxVAY4dEMggu7F+o/ubtM9kbWgt9xk62H04SL
	 RPZBdKy8jeCtd+9HC6gI6QAHoDoMkLf0wgqNmPqg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CCD42A80D4B; Wed, 07 Jan 2026 11:52:21 +0100 (CET)
Date: Wed, 7 Jan 2026 11:52:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: flock deadlock
Message-ID: <aV465e_t3Agp-uf0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CA+1R0Vg7b7YyvgDf1=or8oxskEX4BJwMJQxxTKYaUHWPQeD9iQ@mail.gmail.com>
 <CA+1R0Vju3VQYaz-s00vCroEV3pH7vBeUhoMGqtUxi0x5k56vpQ@mail.gmail.com>
 <20260103230511.24a6f772323927a141bf595f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260103230511.24a6f772323927a141bf595f@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Jan  3 23:05, Takashi Yano wrote:
> On Sun, 28 Dec 2025 11:52:36 -0800
> Nahor <nahor.j+cygwin@gmail.com> wrote:
> > Attached is a reproducible example.
> > The example just calls `fork()` then open/flock/close a directory and
> > repeats (fork/open/flock/close). The forks optionally sleep then
> > open/flock/close the same directory and exit.
> > 
> > There is no issue if either the parent or the children don't call `flock()`.
> > Without sleeping, the example deadlocks immediately on my system 100%
> > of the time. Killing the child allow the parent to proceed, fork the
> > next child, which triggers the next deadlock.
> > When sleeping, _sometimes_ one child will deadlock with the parent.
> > Killing that child allows the parent and remaining children to proceed
> > (and potentially trigger another deadlock). Killing the parent also
> > unblocks all the children.
> 
> Thanks for the report and the test case.
> I looked into the issue and found the cause. I also confirmed that
> the patch attached solves the issue.
> 
> Could anyone please review the patch?
> 
> -- 
> Takashi Yano <takashi.yano@nifty.ne.jp>

> From 5b0a3fac8c6f4f56626d108a2dfa9738f73ecf6b Mon Sep 17 00:00:00 2001
> From: Takashi Yano <takashi.yano@nifty.ne.jp>
> Date: Sat, 3 Jan 2026 21:53:36 +0900
> Subject: [PATCH] Cygwin: close: Do not lock fdtab
> 
> Otherwise, a deadlock can occur if the child process attempts to
> lock a file while the parent process is closing the same file, which
> is already locked. The deadlock mechanism is as follows.
> 
> When the child process attempts to lock a file, it notifies the parent
> process by calling CreateRemoteThread(), which creates a remote thread
> in the parent. That thread checks whether the file being locked is
> currently opened in the parent. During the operation, cygheap->fdtab
> is temporarily locked in order to enumerate the file descriptors.
> 
> However, if the parent process is closing the same file at that moment,
> it also locks fdtab via cygheap_fdget cfd(fd, true) in __close().
> If the parent acquires th fdtab lock first, it proceeds to call
> del_my_locks(), which attempts to lock the inode in inode_t:get().
> 
> At this point, the inode is already locked in the child,
> so the parent waits for the child to release the inode. Meanwhile,
> the child is waiting to acquire the fdtab lock, which is still held
> by the parent. As a result, the parent and child become deadlocked.
> 
> However, since close_all_files() and close_range() do not lock fdtab,

close_all_files() is called from _exit(), so there's no reason to lock
fdtab.  close_range() locks fdtab explicitly right after EINVAL
handling.

Since close() is a process manipulating the fdtab, I have a bad feeling
to perform the action unlocked.  Wouldn't it make more sense to
enumerate without locking in create_lock_in_parent()?


Thanks,
Corinna
