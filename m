Return-Path: <SRS0=Uj6Q=6Z=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 7BBDD4BA2E04
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 08:15:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7BBDD4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7BBDD4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766132121; cv=none;
	b=qd+2BRsGkSDCiiVWWlueBsrDwwclxUVCoOQvkPZX8ZM5u928GIEcUTKT5eAXjiVM9jWgEXNaghj2O2HkyY/REVW2ecaw+JFbgjA0pRmZBTLxWXKmQ3a7x7JNqd9OITP9wSV+/s65qfMeZdK9KfMsrL52ONYAK97aEVqNKLxgrYE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766132121; c=relaxed/simple;
	bh=htc8cx29RfOZked3g/estYK/rfzUjYsA6qOdLg/AKUY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PoOncIqTUbyoYyUMEaIW+OHUAoXw0I351t5I8BpvhvGoK+mzLngd0qD3DsPjiSUURGu07rS4plKaiyMzsqoxPYlzd1vEsYTDvBx/ncGpBEm1DzqCiBmvZuAVHOzCOAtEaNpzM4PuFN9maXEgG+y1UGsY/zA3KRau1sx1udn75xY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7BBDD4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=d2vyG3cE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766132115; x=1766736915;
	i=johannes.schindelin@gmx.de;
	bh=RJHcKVRuCeW4OWXZJeeiJagG9Ba0lMMx9LpXzt7EBRg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d2vyG3cE+8FFyTJOnlacMeA17Emn/HNq278eZfQODaSFHh6NzmdfdyNl4UrzWLTv
	 pcaPqexUtFW8zQTUo/cFxYt0y7x+ZRyBWgKAEAi+rlyWHHRf1GMJWu/WWj8AsRvKo
	 qfYgD7vLGBo8ay6vnH/5mn61z+cK63XiyffAxv7jjF2YJiI6uRaPUFvS7YCvrBwyh
	 2ug+/DzpOZmLqYdQDfzl/7Po1mKVvWVJS1EZu9m1X7/p6mOqpVMVUefGVLb/DLILZ
	 ds2vHO96EYcTxe8oUySYjhqTKT/fZ3/mwy/grVVKxPVLz0QmGtz0qn5hUkapArDLV
	 IB4xd3ir02l9lqF0QA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1wI00t0oSa-00lguv; Fri, 19
 Dec 2025 09:15:15 +0100
Date: Fri, 19 Dec 2025 09:15:14 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 0/6] Fix stdio with app execution aliases (Microsoft
 Store applications)
In-Reply-To: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
Message-ID: <dc82f205-969a-708d-0efc-15f23ff93cb3@gmx.de>
References: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EI78um2epEufD5iNDdx2QeETZpGb3Y/Dhc7D2vI2gr74/zkvkVa
 jFDZeqFjyrargNS1AxUCKklQ5LDpiSulbYSmyaP2fdLD9/PQ77IGeKnS6Q86pkBdPc5PEOO
 oHOIGVgG19Uxb085Y/wTZJMxy5aMj98ovtVNLcN2HgUL3A/mW70wpFEAMvUC5jUDYQ9ZbwU
 0sWIVcgn1flgM1pT8dYTA==
UI-OutboundReport: notjunk:1;M01:P0:Bzqncv4jWas=;gNfOuiP2r5U4X73ybtLpC476pKx
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 19 Dec 2025, Takashi Yano wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> When I introduced support for executing Microsoft Store applications thr=
ough
> their "app execution aliases" (i.e. special reparse points installed int=
o
> %LOCALAPPDATA%\Microsoft\WindowsApps) in
> https://inbox.sourceware.org/cygwin-patches/cover.1616428114.git.johanne=
s.schindelin@gmx.de/,
> I had missed that it failed to spawn the process with the correct handle=
s to
> the terminal, breaking interactive usage of, say, the Python interpreter=
.
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
> Changes since v4:
>=20
>  * Split 5/5 patch into two patches: one is for changing argument type,
>    the other is for fixing a bug.
>  * Improve commit message of 5/5 patch.

Thank you so much for indulging me! Both changes look very good to me. I
verified that the cumulative diff is identical, and the commit messages
look good to me, too.

Here is the range-diff:

=2D- snip --
1:  58110721b7 ! 1:  23748c821a Cygwin: termios: Make is_console_app() ret=
urn true for unknown
    @@ Commit message
         GUI apps is poinless indeed, but not unsafe.
    =20
         Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console s=
upport.")
    -    Reviewed-by:
    +    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    =20
2:  554422de5f =3D 2:  dd892f002a Cygwin: is_console_app(): do handle erro=
rs
3:  1f87881d8d ! 3:  697457a34b Cygwin: is_console_app(): deal with the `.=
bat`/`.cmd` file extensions first
    @@ Commit message
         early returns first.
    =20
         Fixes: bb4285206207 (Cygwin: pty: Implement new pseudo console su=
ppot., 2020-08-19)
    +    Reviewed-by: Takashi Yano <takashi.yano@nifty.ne.jp>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    =20
      ## winsup/cygwin/fhandler/termios.cc ##
4:  284feb0e78 ! 4:  835bcd9d01 Cygwin: path: Implement path_conv::is_app_=
execution_alias()
    @@ Commit message
         This patch adds new api path_conv::is_app_execution_alias() for
         that purpose.
    =20
    -    Reviewed-by:
    +    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    =20
5:  cf0d96afcd ! 5:  a18fe29ee4 Cygwin: termios: Handle app execution alia=
s in is_console_app()
    @@ Metadata
     Author: Takashi Yano <takashi.yano@nifty.ne.jp>
    =20
      ## Commit message ##
    -    Cygwin: termios: Handle app execution alias in is_console_app()
    +    Cygwin: termios: Change argument of fhandler_termios::spawn_worke=
r()
    =20
    -    After the commit f74dc93c6359, WSL cannot start by distribution n=
ame
    -    such as debian.exe, which has '.exe' extention but actually is an=
 app
    -    execution alias. This is because the commit f74dc93c6359 disabled=
 to
    -    follow windows reparse point by adding PC_SYM_NOFOLLOW_REP flag i=
n
    -    spawn.cc, that path is used for sapwning a process. As a result, =
the
    -    path, that is_console_app () received, had been the reparse point=
 of
    -    app execution alias, then it returned false for the the path due =
to
    -    open-failure because CreateFileW() cannot open an app execution a=
lias,
    -    while it can open normal reparse point.  If is_console_app() retu=
rns
    -    false, standard handles for console app (such as WSL) would not b=
e
    -    setup. This causes that the console input cannot be transfered to=
 the
    -    non-cygwin app.
    +    This patch changes the argument for passsing a path to an app
    +    to fhandler_termios::spawn_worker() from const WCHAR *runpath
    +    to path_conv &pc. The purpose of this patch is to prepare for
    +    a subsequent patch, that is intended to fix a bug in executing
    +    Microsoft Store apps.
    =20
    -    This patch fixes the issue by locally converting the path, which =
is
    -    a path to the app execution alias, once again using PC_SYM_FOLLOW
    -    (without PC_SYM_NOFOLLOW_REP) option path_conv for using inside o=
f
    -    is_console_app() to resolve the reparse point here, if the path i=
s
    -    an app execution alias.
    -
    -    Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0=
")
         Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    @@ winsup/cygwin/fhandler/termios.cc: fhandler_termios::fstat (struct =
stat *buf)
     +  wchar_t *e =3D wcsrchr (native_path, L'.');
        if (e && (wcscasecmp (e, L".bat") =3D=3D 0 || wcscasecmp (e, L".cm=
d") =3D=3D 0))
          return true;
    -+
    -+  if (pc.is_app_execution_alias ())
    -+    {
    -+      UNICODE_STRING upath;
    -+      RtlInitUnicodeString (&upath, native_path);
    -+      path_conv target (&upath, PC_SYM_FOLLOW);
    -+      target.get_wide_win32_path (native_path);
    -+    }
    -+
        HANDLE h;
     -  h =3D CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
     +  h =3D CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
-:  ---------- > 6:  f27c915a94 Cygwin: termios: Handle app execution alia=
s in is_console_app()
=2D- snap --

Again: Thank you very much!
Johannes

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
> Takashi Yano (4):
>   Cygwin: termios: Make is_console_app() return true for unknown
>   Cygwin: path: Implement path_conv::is_app_execution_alias()
>   Cygwin: termios: Change argument of fhandler_termios::spawn_worker()
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
