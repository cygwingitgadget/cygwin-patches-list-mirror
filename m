Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3F67F3858C78; Wed, 21 Jun 2023 08:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3F67F3858C78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1687335772;
	bh=ggzcYRd2ioQnfO1CCD9JgZ0ulLusMZcgNf9Goiq6Lto=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JLqAnj9+zYWIGLAdt3OpuaeDp/meBP3PI+wLesfeOuPLB8Jqc0tnCzSMRJ8D094/a
	 0Hl9nL5ArUEH2Fv3hKDiz6ZhbZjfZYyAgt76kEFyomBUmCBWfFc1oVNM/U5B+ARNZC
	 CBOaAH4oanV2NWus7SN3KuR8sof5NfoMmrroqP1E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C26FEA80C4C; Wed, 21 Jun 2023 10:22:47 +0200 (CEST)
Date: Wed, 21 Jun 2023 10:22:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/3] use wincap in format_proc_cpuinfo for user_shstk
Message-ID: <ZJKzVwjLe7UeYHDI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
 <ZJFh2Cy9PnCqNoYU@calimero.vinschen.de>
 <6783769f-fb78-9ae7-bda9-ce64b79125d3@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6783769f-fb78-9ae7-bda9-ce64b79125d3@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jun 20 22:50, Brian Inglis wrote:
> On 2023-06-20 02:22, Corinna Vinschen wrote:
> > On Jun 19 12:15, Brian Inglis wrote:
> > > In test for for AMD/Intel Control flow Enforcement Technology user mode
> > > shadow stack support replace Windows version tests with test of wincap
> > > member addition has_user_shstk with Windows version dependent value
> > > 
> > > Fixes: 41fdb869f998 fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo
> > > Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
> > > 
> > > Brian Inglis (3):
> > >    wincap.h: add wincap member has_user_shstk
> > >    wincap.cc: set wincap member has_user_shstk true for 2004+
> > >    fhandler/proc.cc: use wincap.has_user_shstk
> > > 
> > >   winsup/cygwin/fhandler/proc.cc        |  8 ++++----
> > >   winsup/cygwin/local_includes/wincap.h |  2 ++
> > >   winsup/cygwin/wincap.cc               | 10 ++++++++++
> > >   3 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > Never mind, I fixed the remaining problems.  Thanks for the patch,
> > I pushed it with slight modifications to the commit messages.
> > 
> > I'm a bit puzzled if my original mail
> > https://cygwin.com/pipermail/cygwin-patches/2023q2/012280.html
> > was really that unclear.  Reiterating for the records:
> > 
> > - Commit messages should really try to explain why the patch is made and
> >    what it's good for. In case of fixing a bug, the bug should be explained
> >    and, ideally, explain why the patch is the better solution.
> > 
> > - If a patch fixes an older bug, it should say so and point out the
> >    commit which introduced the bug using the Fixes: tag.  The format
> >    is
> >      Fixes: <12-digit-SHA1> ("<commit headline>")
> > 
> >    The parens and quoting chars are part of the format.
> > 
> > - Every patch should contain a Signed-off-by: to indicate that
> >    you did the patch by yourself.  That's easily automated by
> >    using `git commit -s'.
> > 
> > - Other Tags like "Reported-by:" or "Tested-by:" are nice to have,
> >    but not essential.
> 
> > > - For obvious reasons, the message text in your cover message won't make
> > >   it into the git repo.  However, the commit messages in git should
> > >   reflect why the change was made, so a future interested reader has
> > >   a chance to understand why a change was made.
> 
> Not obvious to me unfortunately!

No worries, we're all learning while we're going along.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

This is pretty well written, and it very nicely explains how to write
commit messages and use tagging.

Writing useful commit messages helps other people a lot to understand
why a patch was made, especially in tricky error cases (locking issues
are hard to follow, a good explanation is key).

If you ask me, there's no such thing as a too long commit message.

We're a small group so we're not supposed to follow the above document
to the core.  However, things like "Fixes:" are really great, because
they connect a patch with a history of other patches and allow an aha
effect when checking on the referenced older patch.  I can honestely
tell you that it already helped me a lot when working on the Linux
kernel.  That's why I'd like to make this standard for our small project
here, too.

And one of the core expressions used in this doc is this:

  Don't get discouraged - or impatient


:)
Corinna
