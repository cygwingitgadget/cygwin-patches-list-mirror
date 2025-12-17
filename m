Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.227.115])
	by sourceware.org (Postfix) with ESMTPS id B1FCD4BA2E04
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 09:29:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B1FCD4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B1FCD4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.115
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765963775; cv=none;
	b=rSSZlzUNiVD+e06pHhn2Ho0P2asHQLlaL3RIq2kSArvqrtyevag2KPaee9sHM01TNjozs/q7TykRD9L34nOkr+HmAXETWIRvC+jhO+ByHjUudzHD9MzgcwAUxKiHhbg3NFtC3Ad4G6lh7FXPTQKxI/LW0jeMygktGHK6zP74Qrw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765963775; c=relaxed/simple;
	bh=ihoLCP97n33Rrj7dcs8rgEhpyVxP5QpmBhlQnyI+cnQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=N52T2W7s809ucPRTDwrwAuxNffZzwOBL2arOwc936gU1lCej+hE3tIgXz6jWCawyz576+Rbfyl7vFAAaJWNx4NMse79L2Xg4tNFYXMLnypCx3n7PTcN4dfVvS9jK6WC+E4EspwQns3fU15tUuFO4cOkIFX3z0kqOJij2eIZelF4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B1FCD4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PDeRllwo
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20251217092932972.FWOZ.47114.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 18:29:32 +0900
Date: Wed, 17 Dec 2025 18:29:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
Message-Id: <20251217182931.c4dd8a2ea1569fc11b9a675e@nifty.ne.jp>
In-Reply-To: <4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
	<aUAoxVEKMpj6xNjM@calimero.vinschen.de>
	<18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
	<aUAxwTZcfZ9qecW2@calimero.vinschen.de>
	<f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de>
	<20251216173957.fa9571466a8bced55924884f@nifty.ne.jp>
	<4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765963773;
 bh=XP4CJBK46lku2I6z+eNRwMZ/NYfJ8iiiNMmRk5T3EYY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=PDeRllwojtgx2qKaefZRMjbvlQ6Rnk/zvNhSctkFOSI2aqY/x30PXfPd3/EP9FI4d5aLtqNX
 n+LjiCST713Oh/Ys2cqB7eZgUiODh2ScbEqLsn1kM/xsZmCGIYv6lLLtPcwmeSE2XB0XgFWb/s
 fbHiYYB2fI/7FO7l54fc7gYtM53tdYfI5DPSIUN4hAOEEPTPfYASpx4Ru0NaBM5IIQaCGor2U5
 ZweYeYxJWJRJJaFUvZW8kJH0WV5Y/NhEaS85J/338MTIFeSUGvEyUiY16uwOlPpqp042xoDBtZ
 GMw+n1nOy7quajELvfGUMDtChfczAxtUaOGU38TxN6QFpJuA==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 16 Dec 2025 10:31:17 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 16 Dec 2025, Takashi Yano wrote:
> 
> > On Mon, 15 Dec 2025 18:15:10 +0100 (CET)
> > Johannes Schindelin wrote:
> > > 
> > > On Mon, 15 Dec 2025, Corinna Vinschen wrote:
> > > 
> > > > On Dec 15 16:40, Johannes Schindelin wrote:
> > > > > Hey Corinna,
> > > > > 
> > > > > [Sorry for top-posting]
> > > > 
> > > > /*rolling eyes*/
> > > 
> > > I wanted to reply quickly, which precluded me from using a mailer that
> > > allows inlined responses, sorry.
> > > 
> > > > > Also, it looks as if that other proposed patch will always add
> > > > > overhead, not only when the reparse point needs to be handled in a
> > > > > special way. Given that this code path imposes already quite a bit of
> > > > > overhead, overhead that delays execution noticeably and makes
> > > > > debugging less delightful than I'd like, I would much prefer to do it
> > > > > in the way that I proposed, where the extra time penalty is imposed
> > > > > _only_ in case the special handling is actually needed.
> > > > 
> > > > You may want to discuss this with Takashi.  Simplicity vs. Speed ;)
> > > 
> > > With that little rationale, the patch to always follow symlinks does not
> > > exactly look simple to me, but complex and requiring some
> > > head-scratching...
> > 
> > The overhead of path_conv with PC_SYM_FOLLOW is small, however,
> > it may be a waste of process time to call it always indeed.
> 
> When I debugged this problem, I introduced debug statements that show how
> often that code path is hit. In a simple rebuild of the Cygwin runtime, it
> is hit _very often_, and it is vexing how slow the rebuild is.
> 
> I don't want to pile onto the damage by adding overhead that is totally
> unnecessary in the common case (most times processes are _not_ spawned via
> app execution aliases), even if it is small. If nothing else, it
> encourages more of that undesirable code pattern to add more and more
> stuff that is not even needed in the vast majority of calls.

I believe path_conv::is_app_execution_alias() can minimize the overhead.

> > However, IMHO, calling CreateFileW() twice is not what we want to do.
> > I've just submitted v2 patch. In v2 patch, use extra path_conv only
> > when the path is a symlink. Usually, simple symlink is already followed
> > in spawn.cc:
> > https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/spawn.cc;h=71add8755cabf4cc0113bf9f00924fddb8ddc5b7;hb=HEAD#l46
> 
> Okay. However, then I don't understand how:
> 
> 1. The patch in question is even necessary, as it would appear that it
>    introduces a _second time_ where the symlink is followed?

App execution alias can be executed by CreateProcess() while it cannot
be opened by CreateFile(). However, other windows reparse points can be
opened by CreateFile(). So, as your patch title saids, extra path_conv
is necessary only for app execution aliases.

Therefore, I proposed path_conv::is_app_execution_alias() in v3 patch.

> 
> 2. What purpose is the name `perhaps_suffix()` possibly trying to convey?
>    I know naming is hard, but... `perhaps_suffix()`? Really?
> 
> > The code is simpler than your patch 3/3 and my previous patch
> > and intent of the code is clearer.
> 
> The intent of that previous patch is a far cry from clear without a
> much-improved commit message, I'd think. It talks about symlinks in
> general, but then uses the app execution alias `debian.exe` as example
> (when a simple test shows that regular symlinks do not need that fix at
> all), and the patch treats it as an "all symlinks" problem, too. Honestly,
> I am quite surprised to read this claim.

Thanks.
Please recheck the commit message in v3 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
