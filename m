Return-Path: <SRS0=Z/EC=6Y=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 8E4C44BA2E23
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 08:28:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8E4C44BA2E23
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8E4C44BA2E23
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766046530; cv=none;
	b=gwXBYMIenc35tUJCZTsx2c8GL3fDzeRZnfZjFxnhJ3YTnr96csi2kLInyn7DxHFNIobuX1Gjfa6mN8yNUpZ34uKz+AttWQAJY6t2j2ysQibEmTkyvB0yXLxgiOwjLr+zS/HHHB3O2/kULE4jeq/fNlQ08rkUOojfhWlkGcEdTUM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766046530; c=relaxed/simple;
	bh=CrUU76zzOMCQv9DiO5PFYievQ+mmUVUgvpLS/Ny6x4Y=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=B8wjNjFIFUUZUMPBxMLAIssbFvTzLEh55AXgsExyACK+f8PloB+ObF/raySguQ94WWOpnNEQd9Uuy8Qk3bJqwnbdhDdmu+/4OJPmP4myGiJVt3U4VjPJhuNgj6lMD/cdB1QdfOz1EkxO0wquoRvYfYNh4XfqQzry4Mno9Vfzwvg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8E4C44BA2E23
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=igTvuRKT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766046524; x=1766651324;
	i=johannes.schindelin@gmx.de;
	bh=VFjDysbux5hDiqcmMwmRnWsxpB9VBh+V0qwWBE8P3xI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=igTvuRKTi/v5uc+yXvqloYzCVmpyMPVJ/eJMVB0YHNUNgR+LIsqGamPu3x9S6q3V
	 XWFkW2AQ5B4EW7xOKhwiqZ6bFvJiltHf0uE1r0w9Zc5BjrsPxR/JyMTUmelta5wEn
	 MnMfoZjVHzHzk8KfYxH4acazLvKUbswCxsDY1XrW2jvHjMEXzAjebwOcIOZv77Gdc
	 2XWefpymnh2kLzDIbSc7vllKT4ztax1B1TyZT0vpQgXuGfWmpVI3hbPpJK3DXBMad
	 WDBbMwNpQnIwiPzoSmdK+jwA3Zx/W/A8AfFOCliikZBvKvzNYOIfPjMyaJOUi4Y4n
	 6r+yuo5zLz0O3H0vYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1w2BwV0ctH-012xwI; Thu, 18
 Dec 2025 09:28:44 +0100
Date: Thu, 18 Dec 2025 09:28:42 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] Fix stdio with app execution aliases (Microsoft
 Store applications)
In-Reply-To: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
Message-ID: <ce71152f-04cd-a2c0-c819-699ff091ea3a@gmx.de>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wXEP0PCh7TIyTy8I1E21CmwBSdZsSDpHuc5UxXNEof8TH0fK4o9
 DgBj4BAO3ofd3wSuDixsfWHiKM4nJ8teON//o9nwNJcpc+G7PchR6OVWSkJubX0wVUgX18g
 /EaSof6vAQjB4NkOuq7d0FQ4hm8h0R2Mwp/QgCp98HjcfRqddhBojXDIeyJV09PnOm+71h2
 U2tPoKVNe/XP1Fi9HWeEg==
UI-OutboundReport: notjunk:1;M01:P0:s6qcMRbD1L0=;cAmADm9aqQLZKBRJVtKNk0Ytjqh
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 18 Dec 2025, Takashi Yano wrote:

> When I introduced support

Heh... That's what _I_ wrote ;-) All good, though, I appreciate your
effort to combine your and my patches.

> for executing Microsoft Store applications through their "app execution
> aliases" (i.e. special reparse points installed into
> %LOCALAPPDATA%\Microsoft\WindowsApps) in
> https://inbox.sourceware.org/cygwin-patches/cover.1616428114.git.johanne=
s.schindelin@gmx.de/,
> I had missed that it failed to spawn the process with the correct
> handles to the terminal, breaking interactive usage of, say, the Python
> interpreter.
>=20
> This was later reported in
> https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=3DjUHL=
_pShff+aRv9P1Eiug@mail.gmail.com/t/#u,
> and also in https://github.com/python/pymanager/issues/210 (which was th=
en
> re-reported in
> https://github.com/msys2/MSYS2-packages/issues/1943#issuecomment-3467583=
078).
>=20
> The root cause is that the is_console_app() function required quite a bi=
t of
> TLC, which this here patch series tries to provide.
>=20
> Changes since v2: (v3 skipped)
>=20
>  * Merge Takashi's v3 patch into Johaness's patch series.
>  * is_conslle_app() returns true when error happens.
>  * Implement new API path_conv::is_app_execution_alias().
>  * To determine if the path is an app execution alias in is_console_app(=
),
>    change argument of fhandler_termis::spawn_worker() and is_console_app=
()
>    from const WCHAR * to path_conv &, so that is_app_execution_alias()
>    can be called from is_console_app().
>  * Resolve reparse point when the path is an app execution alias.

I have reviewed these patches, and in particular love that you changed the
default return value of `is_console_app()` to true, in particular with the
added explanation in the commit message that it actually does not hurt GUI
apps much at all.

While I still think it would be better to split 5/5 into a patch that
changes the function signature of `is_console_app()` and then a patch that
adds special handling for app execution aliases, and while I still think
that the commit message could be improved, at this point I do not want to
force you to work on this even more than you already have, and therefore I
would be okay with this patch series to be integrated as-is.

I truly appreciate the effort you put into this.

Thank you,
Johannes

>=20
> Changes since v1:
>=20
>  * Amended the commit messages with "Fixes:" footers.
>  * Added a code comment to is_console_app() to clarify why a simple
>    CreateFile() is not enough in the case of app execution aliases.
>=20
> Johannes Schindelin (2):
>   Cygwin: is_console_app(): do handle errors
>   Cygwin: is_console_app(): deal with the `.bat`/`.cmd` file extensions
>     first
>=20
> Takashi Yano (3):
>   Cygwin: termios: Make is_console_app() return true for unknown
>   Cygwin: path: Implement path_conv::is_app_execution_alias()
>   Cygwin: termios: Handle app execution alias in is_console_app()
>=20
>  winsup/cygwin/fhandler/termios.cc       | 37 +++++++++++++++++++------
>  winsup/cygwin/local_includes/fhandler.h |  2 +-
>  winsup/cygwin/local_includes/path.h     |  5 ++++
>  winsup/cygwin/path.cc                   |  2 +-
>  winsup/cygwin/spawn.cc                  |  2 +-
>  5 files changed, 36 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.51.0
>=20
>=20
