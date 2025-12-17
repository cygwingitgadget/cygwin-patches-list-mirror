Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 4A5184BA2E05
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 17:04:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A5184BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A5184BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765991070; cv=none;
	b=jnjmZbwCZCW8etKEkvZAIB1sgiMSB0jcUoMa7hBq6zPeBUQWtOngn5tvO8C4gCpyxguS+RwjEjsTL9W55YtS7CdM46lYeciGTdLK8at6IyGXtORaU8aIVY8sSFemRyR/k9SidxGHxebbCIzkecSR+EGTEmuV9974L9ZyakwQ7Sc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765991070; c=relaxed/simple;
	bh=7x7fdvZVa2SdKcN585TIUiC6RwcfcsqNRZdp3p6G4Qo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=i7lTKx8QqIQNilr2t3aW44UNBcWhXHXkqeZq0ltTNDYRo0sisJ8j+NHii/7CTb2EHS4oShhPHQ51TS4UNXaO0a6iAilUfGEKuq6x47MCNi9glD1Z9R0DK2prm9pG1pJLIoRkeFAWIN40Ko5mJqQsqi29jfeiEx1z+fM0WzL1Lmk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A5184BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TZSYZ+j+
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20251217170427395.QLWQ.37742.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 02:04:27 +0900
Date: Thu, 18 Dec 2025 02:04:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: termios: Handle app execution alias in
 is_console_app()
Message-Id: <20251218020426.2d726257fd3cce4d2405d67e@nifty.ne.jp>
In-Reply-To: <a4777af3-0f55-1b29-9fa7-cc38c47a3291@gmx.de>
References: <20251217093003.375-1-takashi.yano@nifty.ne.jp>
	<20251217093003.375-3-takashi.yano@nifty.ne.jp>
	<a4777af3-0f55-1b29-9fa7-cc38c47a3291@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765991067;
 bh=tA9kDr0p3fehLVwUZRlJmEpbcsaGoE1Oc5BI3QB2ddQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=TZSYZ+j+Bmxr3oto1Vj6LSV3VyNM8qapi45feTUyTihudWVbq1uDlfijVooAlq17c+oWUVbP
 Ha9NekObmQyty9QPb9ElYedNdGzmKpOcIFfrcCLFIMalPgj1qTSRmfwZUFK5LLA0444HrAabaF
 63EtvSaC8Oy8Vr/kO2Tq6ssAzP6OIKRXnnSLzbBZ2RqbxcJO64Gk2RYxddTcsvXleJqo1m5B9N
 EVDeaLUfW5m/fM1Gnh9xKFAY00W1YbHb8B3m8NHwZ6f2EBCcFTVfzEiM3EpxmUq0TtARZXSg7/
 HA6aQUohAcyBbLbMhuVQiabardCCca7lgwoWkso7SlxYpdeA==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 17 Dec 2025 15:55:58 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 17 Dec 2025, Takashi Yano wrote:
> 
> > After the commit f74dc93c6359, WSL cannot start by distribution name
> > such as debian.exe, which has '.exe' extention but actually is an app
> > execution alias. The commit f74dc93c6359 disables to follow windows
> > reparse point by adding PC_SYM_NOFOLLOW_REP flag in spawn.cc. As a
> > result, is_console_app () returns false for the app execution alias
> > due to open-failure because CreateFileW() cannot open an app execution
> > alias. This patch fixes the issue by converting the path again using
> > PC_SYM_FOLLOW (without PC_SYM_NOFOLLOW_REP) option in path_conv if
> > the path is an app execution alias.
> 
> Since you repeat this commit as the culprit, I guess that this is your way
> to explain to me that before this commit, the standard handles were
> correctly set even after 2533912fc76c (Allow executing Windows Store's
> "app execution aliases", 2021-03-12) allowed executing Microsoft Store
> Apps via their app execution aliases?

Yes. You can see that by just trying cygwin 3.5.7.

> > Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/termios.cc       | 21 ++++++++++++++++-----
> >  winsup/cygwin/local_includes/fhandler.h |  2 +-
> >  winsup/cygwin/spawn.cc                  |  2 +-
> >  3 files changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> > index 19d6220bc..7fdbf6a97 100644
> > --- a/winsup/cygwin/fhandler/termios.cc
> > +++ b/winsup/cygwin/fhandler/termios.cc
> > @@ -702,10 +702,21 @@ fhandler_termios::fstat (struct stat *buf)
> >  }
> >  
> >  static bool
> > -is_console_app (const WCHAR *filename)
> > +is_console_app (path_conv &pc)
> 
> I see you insist of mixing the refactor where `path_conv &` is passed
> instead of `WCHAR *` with the actual fix.
> 
> Not a fan. I regularly hit your commits when bisecting Cygwin runtime
> regressions, and I have not yet learned to be okay with finding patches
> that do too many things at the same time.

Do you mean there should be a separate patch which just change
the argument WCHAR * to path_conv & before the acutual fix?
Doesn't that make the intent of the first commit unclear?

> I'm weven less a fan of the non-descriptive variable name `pc` which
> unnecessarily increases cognitive load.
> 
> But hey, rather than shouting my objections to the form in the void, I'll
> just accept that my recommendations are not welcome,

??? I don't understand why you think so. Which recommendations you mean?

> and this is the shape
> of the patch that you want to have. It does fix the bug, so that's good.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
