Return-Path: <SRS0=APpz=6X=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id C76C74BA2E2D
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 15:50:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C76C74BA2E2D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C76C74BA2E2D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765986632; cv=none;
	b=A8cq8MMCVRXGowGfFiFrV4zpwgpPS3TvCoXecwmpxIJf84LlvgCJ/0iEXXGzPXFDu+J0Rma/+ZSXkgcqbWX+oKChwMoLJTdClueduzZicUwU+ckuR4kR+gqsWtqy9JeQLGnmiFuisDVYZD+eGpLhyTejTomKs9jC0femwRTmjcI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765986632; c=relaxed/simple;
	bh=LFDv5SFc08o2BBQsI6zoWfAeLr6eiTlXYjRluwg+718=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=wcmLYZzNSpcAVkT91FitmJqQx5x+pStYbBudJUXZGT5L+EuV6DaK23oT485cfTw5T7cNaLbvYsdbmingH2NibxQBdlCKdBkk8sqeYkWnKYQRH7OrhBUYoX3sm7VYA4ksk/9vyQKzEERUonEaLSA1OefQXCLw7EZjosQhQvkQdzY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C76C74BA2E2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=t4Xd29ML
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765986630; x=1766591430;
	i=johannes.schindelin@gmx.de;
	bh=YI+JIKlQlePRpPPNzvLisLX4PN0YSGq8JbJdlbgVtAw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t4Xd29MLW7Vv/C2a3yQjJSwzWbY24nuhdP4G76igbePJUy8spKd0Y0+at7LsGh6t
	 UUPWQyvjXhIShjdHrZxDA2tVBHe133qkhjKMnma6J7TGzLysOtOV/TLGEzmLD4QrV
	 fUYZbp70QwHahFwaFcgh1cMkAjtQEzLk10nMxErtXB045lEKyWVKPBxhA8b2h7nOd
	 7FgQCK1Poz2Fb/0wqriFLUcpy8e/RmtzUy1s+t2oBmqr1ReKIq3HiM6hx6QplJ6AV
	 c4xMX3fgBdo5tcG0/RHlcclHWt7FY6OWkjnTtm+7LB439lL6aQcl+FMIO6sjL+9qM
	 yo0eHI9w1gZKjrc2fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1vmhad294n-00BhLh; Wed, 17
 Dec 2025 16:50:30 +0100
Date: Wed, 17 Dec 2025 16:50:28 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
In-Reply-To: <20251217182931.c4dd8a2ea1569fc11b9a675e@nifty.ne.jp>
Message-ID: <7c03a948-c8fb-079c-a2e1-99e8626366a7@gmx.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com> <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com> <aUAoxVEKMpj6xNjM@calimero.vinschen.de> <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de> <aUAxwTZcfZ9qecW2@calimero.vinschen.de>
 <f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de> <20251216173957.fa9571466a8bced55924884f@nifty.ne.jp> <4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de> <20251217182931.c4dd8a2ea1569fc11b9a675e@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wlQtSGLZ6ePhNm1xV+kCqwgjnijBo9vqhe4fdYdNwzT4rIFOQjH
 SXLedKbPoXM6Sj1YAoSycWa+3zntpuHkRMZMvmvLNSu3kNx29SsEhcc2E/miaZUCRkGYBp+
 tadAxgdqamTIKRlLJbkjoEVEA2ivq48Qcn4urUVDOCG9+UTlsGPrEA57m+45sAZcS578NuS
 1pm5wiT+6yROv0ql+Ow7A==
UI-OutboundReport: notjunk:1;M01:P0:0D/qi7XzgIM=;oOAcJRmf8AjtRVii+pbrONjSY1X
 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
 bytSQ5lQ=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 17 Dec 2025, Takashi Yano wrote:

> On Tue, 16 Dec 2025 10:31:17 +0100 (CET)
> Johannes Schindelin wrote:
>=20
> > On Tue, 16 Dec 2025, Takashi Yano wrote:
> >=20
> > > On Mon, 15 Dec 2025 18:15:10 +0100 (CET)
> > > Johannes Schindelin wrote:
> > > >=20
> > > > On Mon, 15 Dec 2025, Corinna Vinschen wrote:
> > > >=20
> > > > > On Dec 15 16:40, Johannes Schindelin wrote:
> > > > >
> > > > > > Also, it looks as if that other proposed patch will always add
> > > > > > overhead, not only when the reparse point needs to be handled =
in a
> > > > > > special way. Given that this code path imposes already quite a=
 bit of
> > > > > > overhead, overhead that delays execution noticeably and makes
> > > > > > debugging less delightful than I'd like, I would much prefer t=
o do it
> > > > > > in the way that I proposed, where the extra time penalty is im=
posed
> > > > > > _only_ in case the special handling is actually needed.
> > > > >=20
> > > > > You may want to discuss this with Takashi.  Simplicity vs. Speed=
 ;)
> > > >=20
> > > > With that little rationale, the patch to always follow symlinks do=
es not
> > > > exactly look simple to me, but complex and requiring some
> > > > head-scratching...
> > >=20
> > > The overhead of path_conv with PC_SYM_FOLLOW is small, however,
> > > it may be a waste of process time to call it always indeed.
> >=20
> > When I debugged this problem, I introduced debug statements that show =
how
> > often that code path is hit. In a simple rebuild of the Cygwin runtime=
, it
> > is hit _very often_, and it is vexing how slow the rebuild is.
> >=20
> > I don't want to pile onto the damage by adding overhead that is totall=
y
> > unnecessary in the common case (most times processes are _not_ spawned=
 via
> > app execution aliases), even if it is small. If nothing else, it
> > encourages more of that undesirable code pattern to add more and more
> > stuff that is not even needed in the vast majority of calls.
>=20
> I believe path_conv::is_app_execution_alias() can minimize the overhead.

I see that you dislike the idea of working with me, and want to go with
your approach instead. I also see that you're not necessarily interested
in conversing with me, otherwise you would spend many more words on
talking to me rather than less so.

That's something I can accept, although I would have preferred it to be
spelled out clearly.

> > > However, IMHO, calling CreateFileW() twice is not what we want to do=
.
> > > I've just submitted v2 patch. In v2 patch, use extra path_conv only
> > > when the path is a symlink. Usually, simple symlink is already follo=
wed
> > > in spawn.cc:
> > > https://cygwin.com/git/?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dwinsup/cy=
gwin/spawn.cc;h=3D71add8755cabf4cc0113bf9f00924fddb8ddc5b7;hb=3DHEAD#l46
> >=20
> > Okay. However, then I don't understand how:
> >=20
> > 1. The patch in question is even necessary, as it would appear that it
> >    introduces a _second time_ where the symlink is followed?
>=20
> App execution alias can be executed by CreateProcess() while it cannot
> be opened by CreateFile(). However, other windows reparse points can be
> opened by CreateFile(). So, as your patch title saids, extra path_conv
> is necessary only for app execution aliases.
>=20
> Therefore, I proposed path_conv::is_app_execution_alias() in v3 patch.

So let me translate that into a form that would have actually not required
several minutes of looking through code paths to reconstruct the thinking:

While the "symlink" target of app execution aliases _was_ resolved when
2533912fc76c (Allow executing Windows Store's "app execution aliases",
2021-03-12) started allowing Microsoft Store apps to be executed, as of
f74dc93c63 (fix native symlink spawn passing wrong arg0, 2025-03-10) they
were _no longer_ resolved. Hence they are now only resolved _once_, namely
in `is_console_app()`.

> > 2. What purpose is the name `perhaps_suffix()` possibly trying to conv=
ey?
> >    I know naming is hard, but... `perhaps_suffix()`? Really?
> >=20
> > > The code is simpler than your patch 3/3 and my previous patch
> > > and intent of the code is clearer.
> >=20
> > The intent of that previous patch is a far cry from clear without a
> > much-improved commit message, I'd think. It talks about symlinks in
> > general, but then uses the app execution alias `debian.exe` as example
> > (when a simple test shows that regular symlinks do not need that fix a=
t
> > all), and the patch treats it as an "all symlinks" problem, too. Hones=
tly,
> > I am quite surprised to read this claim.
>=20
> Thanks.
> Please recheck the commit message in v3 patch.

I did. It still leaves a lot to be desired from my side:

- It does not start with a clear statement of what is broken.

- It leaves a huge gap between mentioning the added `PC_SYM_NOFOLLOW_REP`
  flag and the `is_console_app()` function, leaving it as a lengthy
  homework assignment to each and every reader to figure out what possible
  connection there is between those two: At first sight they seem rather
  unrelated.

- Saying "This patch fixes the issue by converting the path again" cannot
  do anything but cause utter confusion because the path "conversion"
  happens at a totally different place than it used to happen before, and
  there is not the slightest assistance in that commit message to help
  anybody understand

    - how the code path is getting from that `perhaps_suffix()` function
      (which is not even mentioned _once_ in that commit message), where
      the `PC_SYM_NOFOLLOW_REP` flag is newly set, to the
      `is_console_app()` function, which is in a totally different file.

    - what guarantee this patch makes that the touched code doesn't miss
      anything else that was broken by the "fix native symlink spawn"
      commit (or for that matter, whether there even has been given _any_
      thought to unintended side effects or unwanted gaps in the fix).

- The commit message freely admits that the `is_console_app()` code
  blatantly ignores errors  when calling `CreateFileW()`, and leaves
  things at that. The missing error checks (also for `ReadFile()`) are
  still as missing as before.

- The commit message says that the fix is to use `PC_SYM_FOLLOW` again,
  instead of `PC_SYM_NOFOLLOW_REP`. But the diff mentions neither of those
  constants. I don't know which reader would find this helpful, as I
  don't.

- One particularly irritating gap is the question why app execution
  aliases aren't simply special-cased such that their `argv[0]` is set to
  the symlink _target_, as it used to be when app execution alias support
  was introduced to `spawn()`. That would be quite an interesting
  discussion, in particular when the somewhat surprising fact is conveyed
  that app execution aliases are tied to a package identity, and executing
  them instead of the reparse point target path quite potentially equips
  the spawned process with permissions it would not otherwise have.

This is not the first time I have pointed out this class of problem in
commit messages. When a bug fix is quite involved, it pays a disservice to
any reader when the commit message just rushes through the words without
even trying to do a good job of explaining the problem, the context, the
approach taken to address the problem, and considerations what
(potantially unintended) consequences the patch might lead to.

I don't actually know how I can impress on you how crucial the skill of
commit message writing is, how essential it is to practice it well until
you do a better job. I have tried several times, and I am approaching my
wits' end.

If the author of a commit message would have trouble, after reading it as
little as half a year in the future, to understand the reasoning behind
their own patch (and there is not the slightest doubt in my mind that v3's
commit message would fall into that exact category), then that commit
message is in need of some work.

Writing commit messages is a craft as much as writing code, and if you
love your craft, you devote passion to honing that craft. It shows in the
results whether you do that.

You have push permission, so you can just push it as-is, of course.
Obviously, I'd rather you improve the commit message (and the patch), but
there is nothing I could do to enforce that.

Ciao,
Johannes
