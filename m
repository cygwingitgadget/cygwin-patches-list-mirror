Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 2543D4BA2E29
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 17:58:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2543D4BA2E29
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2543D4BA2E29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765994296; cv=none;
	b=IpQ72m0l9H+6UT13PLm4f2sZwNcn6IGWeYen1DJb/7zSPeDbUjQ8DsswtBG/4tPV/q7TslIa/ieSZNn/jg8mEsydQxjbm4Xea53ccWjVp7QOuWEBTHow1mjPszwcuEn/Z/JDal2xlRGFi4d7vE1ROHdxIQOmrIPWstALBOn8qRU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765994296; c=relaxed/simple;
	bh=4g/YAgL2vZ6JlnkhB/RkPaWgirYk/AIFvS0MFNnqeYo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=RzCVvNEGXNWtALen1CoxOw1A2nYb+yPw208SeMnMNUqo79LVGHouLkteqC123iarO5RdclpuLjHn0KGxOxukcUpQ7t1rJ4PzxpU6FPbveH2hOVo4WABypPDV870VAGWWrRVkwNiYVLuf0/m7z/KfSA6znmSZIm4fjgOlZnarDso=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2543D4BA2E29
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HTIdUYV4
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251217175814014.RGCY.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 02:58:14 +0900
Date: Thu, 18 Dec 2025 02:58:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
Message-Id: <20251218025813.897e2af7ff1024302b6ddb10@nifty.ne.jp>
In-Reply-To: <7c03a948-c8fb-079c-a2e1-99e8626366a7@gmx.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
	<aUAoxVEKMpj6xNjM@calimero.vinschen.de>
	<18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
	<aUAxwTZcfZ9qecW2@calimero.vinschen.de>
	<f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de>
	<20251216173957.fa9571466a8bced55924884f@nifty.ne.jp>
	<4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de>
	<20251217182931.c4dd8a2ea1569fc11b9a675e@nifty.ne.jp>
	<7c03a948-c8fb-079c-a2e1-99e8626366a7@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765994294;
 bh=Qla3ypiIuCcdxFkSpgwyTQ4jV8U592rTAjAGVfE5ucU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=HTIdUYV42k5pqfnglLHn4Y1/430OjqXKt0x8FCZW088HKCsvsUxP2pM0AlatvGVXwrjN+yiM
 AtVQgHc/BfBDqHe5JlD1Y+M3hNmB+8jJOo3+4bwZ0iBF3fMRQU6jrm32H2uMW86KSQaXgcB60N
 DOUjwjGIfU+hP3iqAZBzXAcLqu8v3n1Je+USlAzDin93N6DXDj+5FgbyM6k5CjVPxxGFpZNrpR
 lOccY4zQ28y1VBE39ZB377Pwg6SqSrJmALjHzHlmtjKvDmximQhCjh8R6JQknMKGo9oehGxzwE
 VtN1Os4uFWKVd+b3rGnbg1IIhF1p4EOSPmwvBMMTMNkj2l0w==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 17 Dec 2025 16:50:28 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 17 Dec 2025, Takashi Yano wrote:
> 
> > On Tue, 16 Dec 2025 10:31:17 +0100 (CET)
> > Johannes Schindelin wrote:
> > 
> > > On Tue, 16 Dec 2025, Takashi Yano wrote:
> > > 
> > > > On Mon, 15 Dec 2025 18:15:10 +0100 (CET)
> > > > Johannes Schindelin wrote:
> > > > > 
> > > > > On Mon, 15 Dec 2025, Corinna Vinschen wrote:
> > > > > 
> > > > > > On Dec 15 16:40, Johannes Schindelin wrote:
> > > > > >
> > > > > > > Also, it looks as if that other proposed patch will always add
> > > > > > > overhead, not only when the reparse point needs to be handled in a
> > > > > > > special way. Given that this code path imposes already quite a bit of
> > > > > > > overhead, overhead that delays execution noticeably and makes
> > > > > > > debugging less delightful than I'd like, I would much prefer to do it
> > > > > > > in the way that I proposed, where the extra time penalty is imposed
> > > > > > > _only_ in case the special handling is actually needed.
> > > > > > 
> > > > > > You may want to discuss this with Takashi.  Simplicity vs. Speed ;)
> > > > > 
> > > > > With that little rationale, the patch to always follow symlinks does not
> > > > > exactly look simple to me, but complex and requiring some
> > > > > head-scratching...
> > > > 
> > > > The overhead of path_conv with PC_SYM_FOLLOW is small, however,
> > > > it may be a waste of process time to call it always indeed.
> > > 
> > > When I debugged this problem, I introduced debug statements that show how
> > > often that code path is hit. In a simple rebuild of the Cygwin runtime, it
> > > is hit _very often_, and it is vexing how slow the rebuild is.
> > > 
> > > I don't want to pile onto the damage by adding overhead that is totally
> > > unnecessary in the common case (most times processes are _not_ spawned via
> > > app execution aliases), even if it is small. If nothing else, it
> > > encourages more of that undesirable code pattern to add more and more
> > > stuff that is not even needed in the vast majority of calls.
> > 
> > I believe path_conv::is_app_execution_alias() can minimize the overhead.
> 
> I see that you dislike the idea of working with me, and want to go with
> your approach instead. I also see that you're not necessarily interested
> in conversing with me, otherwise you would spend many more words on
> talking to me rather than less so.

??? Do you mean that the explanation below is not enough for you?

On the contrary, your message feels a bit wordy to me, and I find it
difficult to catch the main point...

> That's something I can accept, although I would have preferred it to be
> spelled out clearly.
> 
> > > > However, IMHO, calling CreateFileW() twice is not what we want to do.
> > > > I've just submitted v2 patch. In v2 patch, use extra path_conv only
> > > > when the path is a symlink. Usually, simple symlink is already followed
> > > > in spawn.cc:
> > > > https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/spawn.cc;h=71add8755cabf4cc0113bf9f00924fddb8ddc5b7;hb=HEAD#l46
> > > 
> > > Okay. However, then I don't understand how:
> > > 
> > > 1. The patch in question is even necessary, as it would appear that it
> > >    introduces a _second time_ where the symlink is followed?
> > 
> > App execution alias can be executed by CreateProcess() while it cannot
> > be opened by CreateFile(). However, other windows reparse points can be
> > opened by CreateFile(). So, as your patch title saids, extra path_conv
> > is necessary only for app execution aliases.
> > 
> > Therefore, I proposed path_conv::is_app_execution_alias() in v3 patch.
> 
> So let me translate that into a form that would have actually not required
> several minutes of looking through code paths to reconstruct the thinking:
> 
> While the "symlink" target of app execution aliases _was_ resolved when
> 2533912fc76c (Allow executing Windows Store's "app execution aliases",
> 2021-03-12) started allowing Microsoft Store apps to be executed, as of
> f74dc93c63 (fix native symlink spawn passing wrong arg0, 2025-03-10) they
> were _no longer_ resolved. Hence they are now only resolved _once_, namely
> in `is_console_app()`.

Right. Perhaps? But _once_ ?

> > > 2. What purpose is the name `perhaps_suffix()` possibly trying to convey?
> > >    I know naming is hard, but... `perhaps_suffix()`? Really?
> > > 
> > > > The code is simpler than your patch 3/3 and my previous patch
> > > > and intent of the code is clearer.
> > > 
> > > The intent of that previous patch is a far cry from clear without a
> > > much-improved commit message, I'd think. It talks about symlinks in
> > > general, but then uses the app execution alias `debian.exe` as example
> > > (when a simple test shows that regular symlinks do not need that fix at
> > > all), and the patch treats it as an "all symlinks" problem, too. Honestly,
> > > I am quite surprised to read this claim.
> > 
> > Thanks.
> > Please recheck the commit message in v3 patch.
> 
> I did. It still leaves a lot to be desired from my side:
> 
> - It does not start with a clear statement of what is broken.
> 
> - It leaves a huge gap between mentioning the added `PC_SYM_NOFOLLOW_REP`
>   flag and the `is_console_app()` function, leaving it as a lengthy
>   homework assignment to each and every reader to figure out what possible
>   connection there is between those two: At first sight they seem rather
>   unrelated.
> 
> - Saying "This patch fixes the issue by converting the path again" cannot
>   do anything but cause utter confusion because the path "conversion"
>   happens at a totally different place than it used to happen before, and
>   there is not the slightest assistance in that commit message to help
>   anybody understand
> 
>     - how the code path is getting from that `perhaps_suffix()` function
>       (which is not even mentioned _once_ in that commit message), where
>       the `PC_SYM_NOFOLLOW_REP` flag is newly set, to the
>       `is_console_app()` function, which is in a totally different file.
> 
>     - what guarantee this patch makes that the touched code doesn't miss
>       anything else that was broken by the "fix native symlink spawn"
>       commit (or for that matter, whether there even has been given _any_
>       thought to unintended side effects or unwanted gaps in the fix).
> 
> - The commit message freely admits that the `is_console_app()` code
>   blatantly ignores errors  when calling `CreateFileW()`, and leaves
>   things at that. The missing error checks (also for `ReadFile()`) are
>   still as missing as before.
> 
> - The commit message says that the fix is to use `PC_SYM_FOLLOW` again,
>   instead of `PC_SYM_NOFOLLOW_REP`. But the diff mentions neither of those
>   constants. I don't know which reader would find this helpful, as I
>   don't.
> 
> - One particularly irritating gap is the question why app execution
>   aliases aren't simply special-cased such that their `argv[0]` is set to
>   the symlink _target_, as it used to be when app execution alias support
>   was introduced to `spawn()`. That would be quite an interesting
>   discussion, in particular when the somewhat surprising fact is conveyed
>   that app execution aliases are tied to a package identity, and executing
>   them instead of the reparse point target path quite potentially equips
>   the spawned process with permissions it would not otherwise have.
> 
> This is not the first time I have pointed out this class of problem in
> commit messages. When a bug fix is quite involved, it pays a disservice to
> any reader when the commit message just rushes through the words without
> even trying to do a good job of explaining the problem, the context, the
> approach taken to address the problem, and considerations what
> (potantially unintended) consequences the patch might lead to.
> 
> I don't actually know how I can impress on you how crucial the skill of
> commit message writing is, how essential it is to practice it well until
> you do a better job. I have tried several times, and I am approaching my
> wits' end.
> 
> If the author of a commit message would have trouble, after reading it as
> little as half a year in the future, to understand the reasoning behind
> their own patch (and there is not the slightest doubt in my mind that v3's
> commit message would fall into that exact category), then that commit
> message is in need of some work.
> 
> Writing commit messages is a craft as much as writing code, and if you
> love your craft, you devote passion to honing that craft. It shows in the
> results whether you do that.
> 
> You have push permission, so you can just push it as-is, of course.
> Obviously, I'd rather you improve the commit message (and the patch), but
> there is nothing I could do to enforce that.

Let me spend a bit more time to understand what is your point.

But perhaps I tend to prefer more concise commit messages than you do.

As for the commit f74dc93c6359, the reader can easily find where
PC_SYM_NOFOLLOW_REP was added by just running:
git diff f74dc93c6359^..f74dc93c6359
In addition, the reader can see what PC_SYM_NOFOLLOW_REP flag is by
grep -r PC_SYM_NOFOLLOW_REP winsup/cygwin

I think it would be clear what happened from commit f74dc93c6359
to a reader who knows what "reparse point" and "app execution alias"
are.

Anyway, after reading your message carefully, I'll reply again.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
