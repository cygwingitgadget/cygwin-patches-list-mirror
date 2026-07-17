Return-Path: <SRS0=bPmJ=FL=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 6A6444BA23C3
	for <cygwin-patches@cygwin.com>; Fri, 17 Jul 2026 06:21:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6A6444BA23C3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6A6444BA23C3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784269281; cv=none;
	b=OPpmyGPCUCc9s0JUBDom8y8IzIz3c8pV5q7a4NkBiwJInOTaAN7Wb81yAvEGS+nNqv9TUuttRVQUD0nHVKA5LfW6fJbHXmvl8QYvQ1R2D3eirxNEjWjPPEJV+Q5mg91azFbpdrt5ADcZDGXkR/M7yysZUWi3MaYGk6qkVd0wO+s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784269281; c=relaxed/simple;
	bh=Bwc7a3wyFweT62EObM+5kE6jYgWpoNOkFLzwS0tuSR8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=EqTCFK3cErez08yFmUTZcEFsbhgzzXuVHrEIVIw6/g/IQV/RpEqebUlzcVDQg1g7/N18oF2gW8yi2bIVDIwiIiTYnOVOvvdZnw+MFeB7kZlm1AwrAjzLceiOHA5IdKjoBOHBl+ZpGWKMGAKCjOW8ISDM9wjyhSck19vnx2CgSN4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A6444BA23C3
Received: from localhost (mark@localhost)
	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 66H6a2KD097236
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 23:36:02 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Thu, 16 Jul 2026 23:36:02 -0700 (PDT)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
In-Reply-To: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
Message-ID: <Pine.BSF.4.63.2607162324080.95488@m0.truegem.net>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,
I'm offline for a while due to a system boot malfunction and subsequent 
rebuilding from backups so I cannot test patches as I normally would do. 
I do have some comments below...

On Fri, 17 Jul 2026, Takashi Yano wrote:
> Since the commit 31bf91f867c5, opening fifo causes a deadlock. This
> is because, open_with_arch() for fifo can be blocked until the other
> side of the fifo is opened. The commit 31bf91f867c5 moves the creating
> cygheap_fdnew before open_with_arch() to address the issue:
> https://cygwin.com/pipermail/cygwin/2026-May/259664.html
> However, cygheap_fdnew locks fdtab, so open() for the other side of
> fifo cannot create cygheap_fdnew until fdtab is unlocked. This is
> the cause of the deadlock.

Thank you for diagnosing the problem and coming up with a fix!

> With this patch, fdtab is unlocked before open_with_arch(), but marked
> as used using tentative fhandler. The summary of open() is as follows.
> 1) Lock fdtab.
> 2) Create new fd.
> 3) Mark fd as used using tentative fhandler.
> 4) Unlock fdtab.
> 5) Call open_with_arch().
> 6) Set final fhandler to fd.
>
> The important point is that create fd before open_with_arch() to
> address https://cygwin.com/pipermail/cygwin/2026-May/259664.html,
> but unlock fdtab before open_with_arch() to address
> https://cygwin.com/pipermail/cygwin/2026-July/259884.html.
>
> Fixes: 31bf91f867c5 ("Cygwin: Ensure unused fd available for open()")
> Addresses: https://cygwin.com/pipermail/cygwin/2026-July/259884.html
> Reported-by: kikairoya <kikairoya@gmail.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
> v2: Add lock/unlock when modifying the fdtab, just to be safe.
>
> winsup/cygwin/syscalls.cc | 20 +++++++++++++++++---
> 1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 2bea79768..e3ba8c65c 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1451,6 +1451,7 @@ extern "C" int
> open (const char *unix_path, int flags, ...)
> {
>   int res = -1;
> +  int fd = -1;
>   va_list ap;
>   mode_t mode = 0;
>   fhandler_base *fh = NULL;
> @@ -1550,9 +1551,12 @@ open (const char *unix_path, int flags, ...)
>       /* Reserve an fdtable entry here, before calling open_with_arch() below.
>          Otherwise there's a tiny chance of hitting OPEN_MAX further on which
>          could create a new file without any way for Cygwin to refer to it. */
> -      cygheap_fdnew fd;
> +      cygheap->fdtab.lock();
> +      fd = cygheap->fdtab.find_unused_handle ();
>       if (fd < 0)
> -        __leave;		/* errno already set */
> +	__leave;		/* errno already set */

Not sure about the above two lines.. did one of us use TABs and the other 
did not?  A minor thing.

> +      cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */

When I was looking into this area of code I couldn't determine if 'fh' was 
non-null in every code path.  That's why I had proposed a distinctive 
value to use (-1 IIRC).  Would be great if you know for sure it's safe.

> +      cygheap->fdtab.unlock();
>
>       if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())
> 	{
> @@ -1580,13 +1584,23 @@ open (const char *unix_path, int flags, ...)
> 	try_to_bin (fh->pc, fh->get_handle (), DELETE,
> 		    FILE_OPEN_FOR_BACKUP_INTENT);
>
> -      fd = fh;
> +      cygheap->fdtab.lock ();
> +      cygheap->fdtab[fd] = fh;
> +      fh->inc_refcnt ();
> +      cygheap->fdtab.unlock ();
> +
>       if (fd <= 2)
> 	set_std_handle (fd);
>       res = fd;
>     }
>   __except (EFAULT) {}
>   __endtry
> +    if (res < 0 && fd >= 0)
> +      {
> +	cygheap->fdtab.lock ();
> +	cygheap->fdtab[fd] = NULL; /* Mark as unused */
> +	cygheap->fdtab.unlock ();

I had wondered about using InterlockedExchange() but your code is more 
explicit, so I go with you on this.

> +      }
>   if (res < 0 && fh)
>     delete fh;
>   syscall_printf ("%R = open(%s, %y)", res, unix_path, flags);
> -- 
> 2.51.0
>

Thanks again Takashi for diving in so quickly on this report.
Regards,

..mark
