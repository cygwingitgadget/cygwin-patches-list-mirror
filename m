Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3274E3858D26; Tue, 25 Feb 2025 09:32:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3274E3858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1740475959;
	bh=m6j5/VxQWaSB7papJgezyn2q2R6KtUkzUfkJcu5lU0g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cc0oE5BY6gBiqYKzDnf4n5JtxMeDGl1bl7ivnFbFK0ZFCY0whlVxy0EDY933s2EgS
	 V70+8Oiou27sSK37Qxx6xx2lQXncvA2+q3gRs6UTbXX39NYu8xb7ejwwg3pHN90pV2
	 WPotp9tCZW3YjD3I52TpSFCUgTWyxUoAAX8Z/SeY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2C820A807B4; Tue, 25 Feb 2025 10:32:37 +0100 (CET)
Date: Tue, 25 Feb 2025 10:32:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: Re: Patch from git-for-windows for SSH hangs
Message-ID: <Z72ONcWLpoYLRlel@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeremy Drake <cygwin@jdrake.com>
References: <3604c9a5-c130-da33-076a-987b6cf3c7a7@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3604c9a5-c130-da33-076a-987b6cf3c7a7@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy, hi Johannes,



On Feb 24 13:22, Jeremy Drake via Cygwin-patches wrote:
> This patch exists in the git-for-windows fork of msys2-runtime (which is
> itself a fork of cygwin).  There have been complaints and requests to
> apply this patch to msys2-runtime (such as
> https://github.com/msys2/MSYS2-packages/issues/4962), but it makes more
> sense to me to try to figure this out upstream, so everyone can benefit.
> I did not write the patch, nor do I personally encounter the bug it is
> intended to fix, so I can't really advocate for its approach, but the
> commit message is pretty detailed as to the investigation that led to it.
> 
> This is the original patch from
> https://github.com/git-for-windows/msys2-runtime/pull/75, if necessary I
> can rebase it on cygwin's master branch, it does so cleanly (or you can
> try git am -3, that tends to work for me in cases where straight git am
> does not).

It applies cleanly.  I just wonder why Johannes hasn't sent this
already upstream, given the patch is from October.

*puzzled*

> >From cbe555e054cefeccd65250bb11dc56f82196301f Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 10 Oct 2024 19:52:47 +0200
> Subject: [PATCH] Fix SSH hangs
> 
> It was reported in https://github.com/git-for-windows/git/issues/5199
> that as of v3.5.4, cloning or fetching via SSH is hanging indefinitely.
> 
> Bisecting the problem points to 555afcb2f3 (Cygwin: select: set pipe
> writable only if PIPE_BUF bytes left, 2024-08-18). That commit's
> intention seems to look at the write buffer, and only report the pipe as
> writable if there are more than one page (4kB) available.
> 
> However, the number that is looked up is the number of bytes that are
> already in the buffer, ready to be read, and further analysis
> shows that in the scenario described in the report, the number of
> available bytes is substantially below `PIPE_BUF`, but as long as they
> are not handled, there is apparently a dead-lock.
> 
> Since the old logic worked, and the new logic causes a dead-lock, let's
> essentially revert 555afcb2f3 (Cygwin: select: set pipe writable only if
> PIPE_BUF bytes left, 2024-08-18).
> 
> Note: This is not a straight revert, as the code in question has been
> modified subsequently, and trying to revert the original commit would
> cause merge conflicts. Therefore, the diff looks very different from the
> reverse diff of the commit whose logic is reverted.

Ok, so the patch shows that reporting writable from select only
if PIPE_BUF bytes are free is not working as desired.  Too bad.

The patch is just kind of incomplete.  pipe_data_available() returns
PIPE_BUF in case the actual available bytes can't be evaluated.
However, it only does so if called from select(). If called from
elsewhere, it returns 1.

If select() now always returns writability if at least 1 byte is
available,  there's no reason left to special case being called
from select(), because it's now sufficient to return 1 to select()
as well.

I added a second patch on top to drop the PDA_SELECT handling
and pushed both.


Thanks,
Corinna
