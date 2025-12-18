Return-Path: <SRS0=Z/EC=6Y=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id D59594BA2E1D
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 08:08:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D59594BA2E1D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D59594BA2E1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766045313; cv=none;
	b=M2ZB1bKrH9l5REdxMST8638gt5XudRlaW2MfFSxaRQKNQjv7Xr+FpBy2DHeNvnPId94ptZp0gbpLhu1bDKbwea93RLk5sc2H8YHjKMkaY2fziPnASWM64HVliv4eUEldWgZoCqFWOoSLfiBygkvjm2kTONqd0Cw4GAdERx0fL6M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766045313; c=relaxed/simple;
	bh=fPphNeyXsqRDAoUteTnw7Wx4Cz0EkFhbEglGUhD5Xz4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lUDHHLqcjmMjFIzD4OzVPTQJNLH+/2N5hjVM+PHBfT6BqM3QUeK0jQLuhgtL+vAXhrTecqXgjnZT3tTHWmKpYEzSgIxSaeSFdDw/dBvg+V5YgMW2VaAKN1Italaei1Ilb6r/6af9qrlh3yrHyO9R66U936B9iXXAfTbjbDch5Gg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D59594BA2E1D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Fq5RsQBU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766045306; x=1766650106;
	i=johannes.schindelin@gmx.de;
	bh=9Uc6mtYuUMat55ZE0RbQuj18uW781om5utRpc+9/8ig=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fq5RsQBUXXhLDisMH/MjvKNqdaTLa/1Z+sEpnlfSNNi/St9DnI3EtWMLahz7uI4o
	 08RKDS1LQCBhNwsWHaTOVhHpCeSJZFCfxE4sSA5j/wgMb3cYY9tOHEn1banSz/UxI
	 QKiD6KBBAjp27WWt6I+EHOTaALWj4paOgE04pva/86U3b3k5QQ4fqRVubQQQM3Uf/
	 CE0XcKNjSsG/lgxzOw4/756l1UuJxQ8CGnjLG+ogOm5Dpz/WbcBltgaxyMHK2nSKk
	 L44T5aCVhpBmQKosE1Qg/WcKtc6yK4qYXWBnbildSn+xe1OnDKXmIXJgk2ZMhN1hy
	 8YTLH/SlHj9GCCCyJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1w8lKL2Qsd-00hOiX; Thu, 18
 Dec 2025 09:08:26 +0100
Date: Thu, 18 Dec 2025 09:08:24 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: termios: Handle app execution alias in
 is_console_app()
In-Reply-To: <20251218020426.2d726257fd3cce4d2405d67e@nifty.ne.jp>
Message-ID: <adf3c29b-5c94-9612-5de7-2f19141b723d@gmx.de>
References: <20251217093003.375-1-takashi.yano@nifty.ne.jp> <20251217093003.375-3-takashi.yano@nifty.ne.jp> <a4777af3-0f55-1b29-9fa7-cc38c47a3291@gmx.de> <20251218020426.2d726257fd3cce4d2405d67e@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TssyeelvI9MuQXYz1ACjEUiMgaZt65nHWxZmw1ipCEsCyS5vTgr
 PpVv8Acr3xQzT8x0QwZw50d0Ro4EezPqy9vaPauM0NQb2A8HedqbhMCkA3bMu1UYqwXD+xf
 33TtCaKFSQSW7e++cXcyYwCs+0cCYNjy1L36AFyUARgDC5JWt0Hgmsqgn/lcMeBtwx8Zven
 Jifs1gsV267sJQJWMJ1uw==
UI-OutboundReport: notjunk:1;M01:P0:Qv0+SaC/DBo=;+bxXQoPClisNcQL8in9h8hMr/NV
 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
 nPRXLDGE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,LIKELY_SPAM_BODY,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 18 Dec 2025, Takashi Yano wrote:

> On Wed, 17 Dec 2025 15:55:58 +0100 (CET)
> Johannes Schindelin wrote:
>=20
> > On Wed, 17 Dec 2025, Takashi Yano wrote:
> >=20
> > > Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
> > > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/fhandler/termios.cc       | 21 ++++++++++++++++-----
> > >  winsup/cygwin/local_includes/fhandler.h |  2 +-
> > >  winsup/cygwin/spawn.cc                  |  2 +-
> > >  3 files changed, 18 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhand=
ler/termios.cc
> > > index 19d6220bc..7fdbf6a97 100644
> > > --- a/winsup/cygwin/fhandler/termios.cc
> > > +++ b/winsup/cygwin/fhandler/termios.cc
> > > @@ -702,10 +702,21 @@ fhandler_termios::fstat (struct stat *buf)
> > >  }
> > > =20
> > >  static bool
> > > -is_console_app (const WCHAR *filename)
> > > +is_console_app (path_conv &pc)
> >=20
> > I see you insist of mixing the refactor where `path_conv &` is passed
> > instead of `WCHAR *` with the actual fix.
> >=20
> > Not a fan. I regularly hit your commits when bisecting Cygwin runtime
> > regressions, and I have not yet learned to be okay with finding patche=
s
> > that do too many things at the same time.
>=20
> Do you mean there should be a separate patch which just change
> the argument WCHAR * to path_conv & before the acutual fix?
> Doesn't that make the intent of the first commit unclear?

The first commit just needs a clear commit message that conveys the
intention. Then everything becomes a lot better. For example, `git bisect`
would become more efficient because it wouldn't find a commit that does
several things at the same time (refactoring and working around an API
limitation), but would instead find a commit that does one thing. I have
spent enough time bisecting Cygwin breakages to know how much of a time
saver that is, let alone a morale booster.

> > I'm weven less a fan of the non-descriptive variable name `pc` which
> > unnecessarily increases cognitive load.
> >=20
> > But hey, rather than shouting my objections to the form in the void, I=
'll
> > just accept that my recommendations are not welcome,
>=20
> ??? I don't understand why you think so. Which recommendations you mean?

I regularly suggest to you to spend more love on the commit messages so
that they become more useful than they are now.

Don't get me wrong, I have nothing against being concise. I have something
against being incomplete. The commit message that is proposed here only
makes sense to somebody who just investigated the bug, in depth. Anybody
who hasn't poured over the code for a substantial amount of time will be
confounded by the provided explanation. I have been in this situation with
your commit messages on more occasions than I care to remember, and I am
not exactly what one would call a novice software engineer. Granted, your
commit messages are way, way better than, say, commit messages like this:
https://github.com/evcc-io/evcc/commit/258bd9e1f550. But I seriously long
for the commit message to provide the four pillars of a good message (see
https://github.blog/developer-skills/github/write-better-commits-build-bet=
ter-projects/):
Intent, Context, Implementation and Justification. I want to understand
what is going on after reading the commit message, not be sent on a crazy
goose chase.

Maybe I should find an analogy to illustrate the problem. Have a look at
https://www.youtube.com/watch?v=3DlDSbg-1y5UY. It is an exquisitely funny
and concise summary of the movie "Frozen". But if you don't know the movie
before watching Olaf recount the story, you understand precisely nothing.
It's not "concise", it's "too incomplete".

Commit messages are not a diary. They are messages you send to software
engineers who need to work with your changes. Sometimes, they are even
messages to your future self.

This is particularly important in the context of bug fixing. As I have
debugged Cygwin bugs quite often in the past, I can tell you that it is
quite frustrating to end up finding commits that leave everything unclear,
whose diffs are too large to find any obvious bugs. There are no obvious
bugs. There are only the non-obvious, hard to track down ones. This is the
kind of frustration I aim to avoid by telling you how I want you to
improve the commits. This is my attempt to turn that frustration into an
outcome worth having.

Ciao,
Johannes

>=20
> > and this is the shape
> > of the patch that you want to have. It does fix the bug, so that's goo=
d.
>=20
> --=20
> Takashi Yano <takashi.yano@nifty.ne.jp>
>=20
