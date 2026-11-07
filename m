Return-Path: <SRS0=/zPv=I4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id 5B27D4BA2E0C
	for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2026 07:43:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B27D4BA2E0C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B27D4BA2E0C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794037420; cv=none;
	b=umMVKvdZSKUGLieDjEcxN6f8x5RX8JdzOCFJnQkqJtAvdoTBaalay1ULibB463FFZKDsT8fY+hI0LD+PnONIMDafhynyC0eR3cNvDTmP8lz+cpzj9MxcsjuKNKrx+obDBwJUcM06EiPCChTsiRXLBTaZhichICLusfiPfodigw0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794037420; c=relaxed/simple;
	bh=CVBkNvhHUMVsUHkS80VHYF6HrVsj8V7SDEAdRePnWKE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ss02BBib4FHKlE7DWBrBwP6CxryNd010umlsPjweBwJQBkhR23v6fL1guujnIwJoT1pk5kFu1Fr+QT1HuXRzrbdQ09MbqV6UZVggV0uuKTYDBEv31QRzdB9pP2nX5bxGTFTQH7dzvxtq2M2MJaLmJvH0ZofGcWm6CauPj4mvmG4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XWguEk3m
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B27D4BA2E0C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XWguEk3m
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20261107074336880.HXNJ.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 7 Nov 2026 16:43:36 +0900
Date: Sat, 7 Nov 2026 16:43:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: spawn: Create winpid symlink for spawned
 processes as well
Message-Id: <20261107164335.42acbe2a64f8590e55257cd4@nifty.ne.jp>
In-Reply-To: <02a8901e-648d-40c1-8f96-2e792336af5b@maxrnd.com>
References: <20261106113122.315-1-takashi.yano@nifty.ne.jp>
	<02a8901e-648d-40c1-8f96-2e792336af5b@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1794037416;
 bh=piTy89lOH0TyavZzgvqnaruhSm+qIhjeIX8qIdhry8g=;
 h=Date:From:To:Subject:In-Reply-To;
 b=XWguEk3mgBzpVuBMHSbF7s8cpHF255QELxh5rd+32WuipoWnQtTcCWyjunOZC2IUAnB2mksR
 FI2RMNr6FKJ6xWwhmIw3b4OG5BvkLaMghLy3ZP1BlAZDn2fC7rhtwNbZlAq/rXQBP5DKjcR8+j
 o1kkgaqih13NHRzshHaJ8QtiFF4Ra7+w8u6nfENg6o7wdy5OukBUkJPexqKrMt/pAu8fYnWJ/x
 4c1Kt1fzXxrikDfohMKvFouoq2hG0w4Ky+CEbvd3HBVPW9+AUd21zWs18svJ2XbGQA6yeilJ+U
 idQKNCSlRiH9Q5tPpT3oVyI7uL5X9IJHEADmotgkIe7+DMRg==
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Fri, 6 Nov 2026 21:20:11 -0800
Mark Geisert wrote:
> Hi Takashi,
> 
> On 11/6/2026 3:31 AM, Takashi Yano wrote:
> > Since commit 1b86dd7d8c19 ("Cygwin: make sure exec'ed process exists
> > early in process list"), spawned processes have been missing from the
> > process list (e.g. the output of `ps`). This is because that commit
> > should also have maintained the winpid symlink for spawned cygwin
> > processes, but did not.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-October/260185.html
> > Fixes: 1b86dd7d8c19 ("Cygwin: make sure exec'ed process exists early in process list")
> > Reported-by: Daniyar Oshakbayev <daniyar29@gmail.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/spawn.cc | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > index 6d736888a..87865ddf3 100644
> > --- a/winsup/cygwin/spawn.cc
> > +++ b/winsup/cygwin/spawn.cc
> > @@ -794,16 +794,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >   	     not available. */
> >   	  DuplicateHandle (GetCurrentProcess (), child.shared_handle (),
> >   			   pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
> > +	  /* We have to create a new winpid symlink on behalf of the child
> > +	     process. For Cygwin processes we also have to create a reference
> > +	     in the child. */
> > +	  child.create_winpid_symlink ();
> >   	  if (!real_path.iscygexec ())
> > -	    {
> > -	      /* If the child process is not a Cygwin process, we have to
> > -		 create a new winpid symlink and induce it into the child
> > -		 process as well to keep it over the lifetime of the child. */
> > -	      child.create_winpid_symlink ();
> > -	      DuplicateHandle (GetCurrentProcess (),
> > -			       child.shared_winpid_handle (),
> > -			       pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
> > -	    }
> > +	    DuplicateHandle (GetCurrentProcess (),
> > +			     child.shared_winpid_handle (),
> > +			     pi.hProcess, NULL, 0, 0, DUPLICATE_SAME_ACCESS);
> >   	  child->start_time = time (NULL); /* Register child's starting time. */
> >   	  child->nice = myself->nice;
> >   	  child->sched_policy = myself->sched_policy;
> 
> The patch LGTM.  Please apply at your convenience.

Thanks for reviewing! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
