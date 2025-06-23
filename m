Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0DAAE385020A; Mon, 23 Jun 2025 13:36:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0DAAE385020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750685768;
	bh=H6vP6cOZ+CjvLz+k4nZtnUxyrYt6PcyEV+fcK6EtOrU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=c/cYD9veuswiAFVJESUA/vSofEYlvisJlQdZuJKZK6GpK5d412Rg8QcYBS6WhR1Bz
	 JFbhXexHyTsv03Hm53CQNQNSzAR+M4/S7+Ss52Sz8SJQGo5HWah2I7nqlRHom09rPw
	 GtD+UmU4Yp96djCAAsV6KUYk785a0Png6OW/z1Sw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E29AFA80D72; Mon, 23 Jun 2025 15:36:05 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:36:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pipe: fix SSH hang (again)
Message-ID: <aFlYRfQ_VYtJv3PR@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johannes.schindelin@gmx.de>
 <20250623221908.eb98440b375387e3bc68f295@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623221908.eb98440b375387e3bc68f295@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jun 23 22:19, Takashi Yano wrote:
> On Mon, 23 Jun 2025 14:09:49 +0200 (CEST)
> Johannes Schindelin wrote:
> > The recent changes in Cygwin's pipe logic are a gift that keeps on
> > giving.
> > 
> > The recurring pattern is that bugs are fixed, but with many of these bug
> > fixes, new bugs are produced, and we are stuck in this seemingly endless
> > tunnel of fixing bugs caused by bug fixes.
> > 
> > In cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write(),
> > 2024-11-06), for example, a segmentation fault was fixed. Which is good!
> > However, a bug was introduced, where e.g. Git for Windows' `git clone`
> > via SSH frequently hangs indefinitely for large-ish repositories, see
> > https://github.com/git-for-windows/git/issues/5688.
> > 
> > That commit removed logic whereby in non-blocking mode, not only the
> > chunk size, but also the overall count of bytes to write (`len`) was
> > clamped to whatever is indicated as the `WriteQuotaAvailable`. Now only
> > `chunk` is clamped to that, but `len` is left at its original number.
> > However, the following `while` loop expects `len - chunk` (which is
> > assigned to `len1`) not to be positive in non-blocking mode.
> > 
> > Let's reinstate that clamping logic and implicitly fix this SSH hang.
> > 
> > Fixes: cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write(), 2024-11-06)
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-ssh-hangs-reloaded-v1
> > Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-ssh-hangs-reloaded-v1
> > 
> > 	This commit message will like any love you can give it. For
> > 	example, I do not _quite_ understand why the `while` loop skips
> > 	large chunks of code unless `len1 > 0`, and what the exact idea
> > 	was behind having that `while` loop even for non-blocking mode.
> > 	Could anyone help me understand that `raw_write()` method? Is
> > 	there any good reason why the non-blocking mode runs into a
> > 	`while` loop? Is it supposed to be run only once in non-blocking
> > 	mode, is _that_ the big secret that allows the code to be shared
> > 	between blocking and non-blocking mode? If so, wouldn't it be much
> > 	better to refactor out that logic and then have non-blocking mode
> > 	take a short-cut, for clarity's sake and peace of readers' mind?
> > 
> > 	What I am quite confident is that this works around the problems.
> > 
> > 	I would have put more work into the commit message, if it weren't
> > 	for two counter-acting points:
> > 
> > 	1. This seems to be a pretty bad regression by which many Git for
> > 	   Windows users are affected. So I do feel quite the pressure to
> > 	   get a fix out to those users.
> > 
> > 	2. Despite my pleas, the commit messages in the pipe-related
> > 	   changes keep having too many gaps, still leave way too much
> > 	   unclear for me to make any sense of them, and I have to admit
> > 	   that I do not want to be the only person in that space to put
> > 	   in a large effort to write stellar commit messages. Therefore I
> > 	   left this here commit message in a state I consider "good
> > 	   enough", even if I am more than willing to improve it should
> > 	   someone enlighten me as to the questions I raised above.
> > 
> >  winsup/cygwin/fhandler/pipe.cc | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> > index e35d523bbc..13af7f2ae1 100644
> > --- a/winsup/cygwin/fhandler/pipe.cc
> > +++ b/winsup/cygwin/fhandler/pipe.cc
> > @@ -542,6 +542,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >  
> >    if (len <= (size_t) avail)
> >      chunk = len;
> > +  else if (is_nonblocking ())
> > +    chunk = len = avail;
> >    else
> >      chunk = avail;
> >  
> > 
> > base-commit: 1186791e9f404644832023b8fa801227c2995ab7
> > -- 
> > 2.50.0.windows.1
> 
> Thanks for the patch.
> 
> This indeed fixes the issue. However, I have another idea to fix the issue.
> Please see:
> https://github.com/git-for-windows/git/issues/5682#issuecomment-2996285140

Whatever you two come up with as the final patch, given the current
complexity of the code it might really be helpful to factor out
nonblocking vs. blocking case and get two slightly less complex code
paths.  For example, every time I look into the code I'm puzzeling if
we really need len1.  I'm just not sure anymore the loop got a bit
out of hand and could be folded into a simpler loop.


Corinna
