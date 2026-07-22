Return-Path: <SRS0=IG9T=FQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id D0C294BA5439
	for <cygwin-patches@cygwin.com>; Wed, 22 Jul 2026 11:10:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D0C294BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D0C294BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784718618; cv=none;
	b=GuQgG+zvlTgybkqeLyKhd8wRU7SeSLvt0CthOsIluEP5hquH1W53/RbSYNKQyzRWfJdd4gDmiNdDff5pmf9sxKTMUMkFneikS3thR5enBw6H8i8JhFHVtOKOtXfvr9LUaq8JlYn8QeKx0tTx8J2f47Lel5skCIk2k8bsppi/j8I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784718618; c=relaxed/simple;
	bh=iCtTSyZSOm2IXjaG/dfC82nNYnhrXCVpDGqHICmuEnc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=D+bYe+RLxok4IpPMlawONT7gBXw4eRVcHrKujNi6kWCocXI1IoB/14USHIxL3vvCTCS5UKgR1gVjHs1/Hc+Jh+CAC7wMbgALGpjhFJGnROD9wbEekXo58oE1NReiRKr6mdWfQAduWTIjkSNwKwf48bEuVpsUP0Mc7OGVr+mHQhE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Rf+6bp3i
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D0C294BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Rf+6bp3i
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260722111013777.PZXZ.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 22 Jul 2026 20:10:13 +0900
Date: Wed, 22 Jul 2026 20:10:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
Message-Id: <20260722201012.8403bbf6045b2fb041af985b@nifty.ne.jp>
In-Reply-To: <bccbac3b-78e9-67d3-2a92-30986f6ff9b6@gmx.de>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
	<bccbac3b-78e9-67d3-2a92-30986f6ff9b6@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784718613;
 bh=/y4AoA5vFg3Yk3Jh8sMpF88Mz7mMMQXODPlFDSaejJk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Rf+6bp3iN3ARv4bTnrAKo87UtcW+a+Js47JPA7rUi7VWV1/JXIKTcaxey+JKfQ37gKR/4qbQ
 ARKs7cMOPSAgT4LH+aedYqfJNVW/MCZQLzk5l3STTertatomAKKUpWfSHBJTCpCVD7RnfbJFZ3
 7+rA86QhHadU8K8IwonJPeayLIBCN7jWOtjltQ+8pSgm8qdU4gIzpI1KzZervBL71tvLpj4M0e
 iFdFNFbn1UmbdNvKg98ES8hqBe0l7dMCgbo7aX/LVOlHLmslP8u9Bupukb8O6GQoxFy6y5Mee8
 fESo0nqj1cFS4eTfdU4Np8xNvW2IV/nVkQ+zBhUMkOZDA69Q==
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing!

On Tue, 21 Jul 2026 19:16:11 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> sorry for getting to reply only after you pushed this to `master`. I
> wanted to take the time to double-check a couple of things, and other
> responsibilities got into the way.
> 
> On Fri, 17 Jul 2026, Takashi Yano wrote:
> 
> > [...]
> > diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> > index 2bea79768..e3ba8c65c 100644
> > --- a/winsup/cygwin/syscalls.cc
> > +++ b/winsup/cygwin/syscalls.cc
> > @@ -1451,6 +1451,7 @@ extern "C" int
> >  open (const char *unix_path, int flags, ...)
> >  {
> >    int res = -1;
> > +  int fd = -1;
> >    va_list ap;
> >    mode_t mode = 0;
> >    fhandler_base *fh = NULL;
> > @@ -1550,9 +1551,12 @@ open (const char *unix_path, int flags, ...)
> >        /* Reserve an fdtable entry here, before calling open_with_arch() below.
> >           Otherwise there's a tiny chance of hitting OPEN_MAX further on which
> >           could create a new file without any way for Cygwin to refer to it. */
> > -      cygheap_fdnew fd;
> > +      cygheap->fdtab.lock();
> > +      fd = cygheap->fdtab.find_unused_handle ();
> >        if (fd < 0)
> > -        __leave;		/* errno already set */
> > +	__leave;		/* errno already set */
> > +      cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
> > +      cygheap->fdtab.unlock();
> >  
> >        if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())
> >  	{
> 
> I see three problems here:
> 
> When `fd` is negative, the `unlock()` right below is skipped, and
> `__endtry` only unlocks for non-negative ones. So an `open()` that ran out
> of descriptors returns with the fdtab still locked, and the next fdtab
> operation on any other thread waits for good. `cygheap_fdnew` used to
> release the lock in that case; this one does not. I reproduced [*1*] it
> three times out of three on a local build. It stays invisible while
> single-threaded, because the muto is reentrant -- which is also why the
> OPEN_MAX test still passes.

Ugh, I messed up…

> The tentative assignment puts `fh` into the table with a zero reference
> count, then drops the lock across `open_with_arch()`, which for a FIFO
> waits for the other end. Any lookup in that window -- an `fcntl()`, a
> `close()`, a `close_range()` -- raises the count from zero to one and
> lowers it straight back, freeing `fh` while `open()` is still using it and
> leaving the slot pointing at nothing valid. I reproduced [*2*] it by
> querying the descriptor from a second thread while the open was waiting:
> the process ended with an access violation (status 0xC0000005), and the
> same run without the query was clean.

How do you know the descriptor which open() does not return it yet
in your reproducer?

> 
> The `FH_PROCESSFD` branch shows the same thing with no threads at all: it
> deletes `fh` and repoints the local variable at the reopened handler, but
> the table still refers to the deleted one until the re-assignment further
> down.

The same here. The fd is not returned by open() yet, so the program
cannot think the fd is the valid file descriptor, I think...

> > @@ -1580,13 +1584,23 @@ open (const char *unix_path, int flags, ...)
> >  	try_to_bin (fh->pc, fh->get_handle (), DELETE,
> >  		    FILE_OPEN_FOR_BACKUP_INTENT);
> >  
> > -      fd = fh;
> > +      cygheap->fdtab.lock ();
> > +      cygheap->fdtab[fd] = fh;
> > +      fh->inc_refcnt ();
> > +      cygheap->fdtab.unlock ();
> > +
> >        if (fd <= 2)
> >  	set_std_handle (fd);
> >        res = fd;
> >      }
> >    __except (EFAULT) {}
> >    __endtry
> > +    if (res < 0 && fd >= 0)
> > +      {
> > +	cygheap->fdtab.lock ();
> > +	cygheap->fdtab[fd] = NULL; /* Mark as unused */
> > +	cygheap->fdtab.unlock ();
> > +      }
> >    if (res < 0 && fh)
> >      delete fh;
> >    syscall_printf ("%R = open(%s, %y)", res, unix_path, flags);
> 
> This is the first point where the slot and its reference count agree
> again; Too late for anything that looked in between. And the cleanup only
> runs for non-negative descriptors, so it never covers the case above.
> 
> Since it is already in `master`, a follow-up patch probably makes most
> sense. Two things to fix: release the lock when no descriptor is
> available, and stop a reserved-but-not-yet-open descriptor from looking
> like a fully open one to the rest of the fdtable. Reviving the old integer
> marker would mean teaching every consumer of the table about it, so it is
> not a drop-in.

Ah, I got it. The user program cannot know that, but cygwin1.dll can
refere fdtab inside it. What about adding reserved flag to fdtab?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
