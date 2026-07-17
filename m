Return-Path: <SRS0=sMld=FL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 559A14BA5435
	for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2026 11:18:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 559A14BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 559A14BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784287097; cv=none;
	b=V8qZV4EvNOwwVnFXevW22LsSb0zg0U+HwgrtSKXvMf1A218EE+GdI/ubu+UxOopuXmXY73WABtc0pB74NjG4DECdb8vEtxJjBkgwm29EwWHI5QZZikTm6wiRuIbbUyHPLmCJmn0tumJeGJjzJDPKahtCfDCg92RiUtUo8RTSQ7o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784287097; c=relaxed/simple;
	bh=R4VJ/hjEVgK5jLZJhMb2aGtNKqZ9prqTaTk/ycxX/iU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YgLVloUezbPZQjcwAlXIsZxA88fhLrU06Dj7YNj5y/45ewOJ1OFitzR6Zshnj1h8kxr3KFxrjc+Uu5nz46Qgfk0XvqBBW/0b/2ghly7NLAdCor2ovOV7Td/yyGU1mDRTjg5MFOVF1yWzt8t0exOQKC9ZHGlmfThDVjhPflABX+4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lVm+uKmW
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 559A14BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lVm+uKmW
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260717111813704.WHVO.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2026 20:18:13 +0900
Date: Fri, 17 Jul 2026 20:18:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
Message-Id: <20260717201812.5d42df17e6c8e5d846ec0574@nifty.ne.jp>
In-Reply-To: <Pine.BSF.4.63.2607162324080.95488@m0.truegem.net>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
	<Pine.BSF.4.63.2607162324080.95488@m0.truegem.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784287093;
 bh=85QPtwi4rVSR32g6OjX1qB/uWN46alx4jrM0I5jwsRs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=lVm+uKmWv9KRUG56K4QUaKqcHl9+B8Cix1QMnlJVLs14Y9aU3OkDvkP2rIdGZChaD1RZoke7
 Eu9iOXGm+pqDRvvC71dXgtDHv5dTh5GbzP0PDZKXw6MYmHtShM8GsXrt9221xdTa6qZIrnMaQ6
 Zk67qMPgC7f5Z4OnT6s3aI6kAwpGioouD0yoxs6wtoz1Tei6RxGB7xNyV15YE0ISawG4V3IAM8
 TaGtrAc2LBB1AFT3ybRz/cThT2obhrxO8CLR87bbf6jRaEpy3QhfhuQXLGhdxlFRkybLupTbzj
 aEP3VySY8Urymy5B2GRJEvE7A2p62XGFgvl5REtTzuAZtmWA==
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Thu, 16 Jul 2026 23:36:02 -0700 (PDT)
Mark Geisert wrote:
> Hi Takashi,
> I'm offline for a while due to a system boot malfunction and subsequent 
> rebuilding from backups so I cannot test patches as I normally would do. 
> I do have some comments below...
> 
> On Fri, 17 Jul 2026, Takashi Yano wrote:
> > Since the commit 31bf91f867c5, opening fifo causes a deadlock. This
> > is because, open_with_arch() for fifo can be blocked until the other
> > side of the fifo is opened. The commit 31bf91f867c5 moves the creating
> > cygheap_fdnew before open_with_arch() to address the issue:
> > https://cygwin.com/pipermail/cygwin/2026-May/259664.html
> > However, cygheap_fdnew locks fdtab, so open() for the other side of
> > fifo cannot create cygheap_fdnew until fdtab is unlocked. This is
> > the cause of the deadlock.
> 
> Thank you for diagnosing the problem and coming up with a fix!
> 
> > With this patch, fdtab is unlocked before open_with_arch(), but marked
> > as used using tentative fhandler. The summary of open() is as follows.
> > 1) Lock fdtab.
> > 2) Create new fd.
> > 3) Mark fd as used using tentative fhandler.
> > 4) Unlock fdtab.
> > 5) Call open_with_arch().
> > 6) Set final fhandler to fd.
> >
> > The important point is that create fd before open_with_arch() to
> > address https://cygwin.com/pipermail/cygwin/2026-May/259664.html,
> > but unlock fdtab before open_with_arch() to address
> > https://cygwin.com/pipermail/cygwin/2026-July/259884.html.
> >
> > Fixes: 31bf91f867c5 ("Cygwin: Ensure unused fd available for open()")
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259884.html
> > Reported-by: kikairoya <kikairoya@gmail.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> > v2: Add lock/unlock when modifying the fdtab, just to be safe.
> >
> > winsup/cygwin/syscalls.cc | 20 +++++++++++++++++---
> > 1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> > index 2bea79768..e3ba8c65c 100644
> > --- a/winsup/cygwin/syscalls.cc
> > +++ b/winsup/cygwin/syscalls.cc
> > @@ -1451,6 +1451,7 @@ extern "C" int
> > open (const char *unix_path, int flags, ...)
> > {
> >   int res = -1;
> > +  int fd = -1;
> >   va_list ap;
> >   mode_t mode = 0;
> >   fhandler_base *fh = NULL;
> > @@ -1550,9 +1551,12 @@ open (const char *unix_path, int flags, ...)
> >       /* Reserve an fdtable entry here, before calling open_with_arch() below.
> >          Otherwise there's a tiny chance of hitting OPEN_MAX further on which
> >          could create a new file without any way for Cygwin to refer to it. */
> > -      cygheap_fdnew fd;
> > +      cygheap->fdtab.lock();
> > +      fd = cygheap->fdtab.find_unused_handle ();
> >       if (fd < 0)
> > -        __leave;		/* errno already set */
> > +	__leave;		/* errno already set */
> 
> Not sure about the above two lines.. did one of us use TABs and the other 
> did not?  A minor thing.

Yes, your previous patch uses 8 spaces at begining of the line.
It was replaced with one tab, when I use auto-indent.
> > +      cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
> 
> When I was looking into this area of code I couldn't determine if 'fh' was 
> non-null in every code path.  That's why I had proposed a distinctive 
> value to use (-1 IIRC).  Would be great if you know for sure it's safe.

syscalls.cc:
1485       /* If we're opening a FIFO, we will call device_access_denied
1486          below.  This leads to a call to fstat, which can use the
1487          path_conv handle. */
1488       opt |= PC_KEEP_HANDLE;
1489       if (!(fh = build_fh_name (unix_path, opt, stat_suffixes)))
1490         __leave;                /* errno already set */

fh is initialized here, or __leave.

> > +      cygheap->fdtab.unlock();
> >
> >       if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())

Pointer fh is used just after the patch lines (above fh->dev()) without
check.

> > 	{
> > @@ -1580,13 +1584,23 @@ open (const char *unix_path, int flags, ...)
> > 	try_to_bin (fh->pc, fh->get_handle (), DELETE,
> > 		    FILE_OPEN_FOR_BACKUP_INTENT);
> >
> > -      fd = fh;
> > +      cygheap->fdtab.lock ();
> > +      cygheap->fdtab[fd] = fh;
> > +      fh->inc_refcnt ();
> > +      cygheap->fdtab.unlock ();
> > +
> >       if (fd <= 2)
> > 	set_std_handle (fd);
> >       res = fd;
> >     }
> >   __except (EFAULT) {}
> >   __endtry
> > +    if (res < 0 && fd >= 0)
> > +      {
> > +	cygheap->fdtab.lock ();
> > +	cygheap->fdtab[fd] = NULL; /* Mark as unused */
> > +	cygheap->fdtab.unlock ();
> 
> I had wondered about using InterlockedExchange() but your code is more 
> explicit, so I go with you on this.

I also consider using InterlockedExchangePointer(), or not
using a guard here because open() still not return this fd,
and no other thread using this fd because find_unused_handle ()
returned this fd as unused.
However, it is better to use fdtab.lock() as a precaution for
overlooking something.

> > +      }
> >   if (res < 0 && fh)
> >     delete fh;
> >   syscall_printf ("%R = open(%s, %y)", res, unix_path, flags);
> > -- 
> > 2.51.0
> >
> 
> Thanks again Takashi for diving in so quickly on this report.

Thanks for reviewing so quickly!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
