Return-Path: <SRS0=Uj6Q=6Z=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 390104BA2E04
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 01:50:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 390104BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 390104BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766109011; cv=none;
	b=L5pjEUE90+hm6s7TnB4ZEOMHvYKD3MdCH9zEitX+vo3uM3Mxj1zN0DDH81Hz/ZhtoKogymNj1iA3s6M/+dONvT2hedmdOto3dAbPtds9ZvzlNZPGB7vuKFUJq84Atsu6x2Le3Ew6b25+Ztc0ltOnXzmRl0rL4vri54IHVUhOoiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766109011; c=relaxed/simple;
	bh=idDAiOns0h6XorUu3DW2EybulnGt0Vy0e8/Nq4EQwUA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=fnUeIiW8bCF5VZKKByniLqyOFEJwJxzHW2ulYhJDDHsd4AGuNyBx5lB/NuNDtTeOXfFu5n6mAuuhLhQQAqCNFf8Z+Sa4Rh49U8jWX4rfWzr2zueUEU0/wqCGlyKBHgMZrvv2PCBkNMVi19IVn0qbl1McFGiaZu5DuNr+AjUtdeQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 390104BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cO83VXhw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766109005; x=1766713805;
	i=johannes.schindelin@gmx.de;
	bh=mNJLimXtRfrpF/uNeT2aC37PQjkCjQzXU/xRoeKoXlc=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cO83VXhwxrw9uu0xCFXvcDE1v3fO8vf41e0x5nQ7iJXNZnYzym5oZgMD+ltfwwJx
	 ezR9WxBmnmdUQ8mLSCRdcZnznTgSgbJtHfamRCE1/Wni6IO/rbyC3DY819y5rBrNh
	 cpYQIirBiN+k5oVhqCb1dyO7vayuL9+k/LDRy23Wi1mUSGwwWPAASS43+5FG6cpFj
	 earWmc3yxoLPcvGfDRAntWLcwUxhGQDSqn7W2li+nMOO7QVNRRsNVAkVj4zHFXYEG
	 fVbyIlBonuvw25203dd8Wl15A9rxLWoPpYGCmKMljEPjxm25weCYLc0fAMdlf4AKz
	 S3uB7knAAAdbtGT6yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([89.1.212.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1vj2QU3Q7q-009Bal; Fri, 19
 Dec 2025 02:50:04 +0100
Date: Fri, 19 Dec 2025 02:50:02 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com, Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_5/5=5D_Cygwin=3A_termios=3A_Handl?=
 =?US-ASCII?Q?e_app_execution_alias_in_is=5Fconsole=5Fapp=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251219104512.0cba081c030bed339738f7fb@nifty.ne.jp>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp> <20251218072813.1644-6-takashi.yano@nifty.ne.jp> <3f93cf29-ce67-b8f4-fb5a-c4f6bce50e4d@gmx.de> <20251219104512.0cba081c030bed339738f7fb@nifty.ne.jp>
Message-ID: <8928B19D-7415-4357-8B66-9B88E972EBD0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CHqCg60V07Ig3g1x7Fq60gL/56+G3ivRbfXXa8GYgy40ErPZgzj
 0w2NRgTOFt44bsBg9N1UIPdg4ficHdijiMY3IL+ykNAmyzj/Z67TYEJygkcxgkWpHiLfzZL
 7rl2nSKnp1F8h2afIcbWC3tIZGuT8vxrrC7fdOjFS3TpVgOF5Feb3FbU+EXGxwyco78oFCO
 wrS63fBcRbGc8t9wzK/0Q==
UI-OutboundReport: notjunk:1;M01:P0:p7ygdabq9y4=;c2BbtlJ4iJJKlIfVyrlbPpgLQsZ
 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
 sDFLMLIfLCyd01tBZRww
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

that commit message sounds very good to me, thank you for that!

And I think you're right about app execution aliases only allowing `=2Eexe=
`=2E At least in practice that'll be the case=2E

Thank you,
Johannes




-------- Original Message --------
From: Takashi Yano <takashi=2Eyano@nifty=2Ene=2Ejp>
Sent: December 19, 2025 2:45:12 AM GMT+01:00
To: cygwin-patches@cygwin=2Ecom
Subject: Re: [PATCH v4 5/5] Cygwin: termios: Handle app execution alias in=
 is_console_app()

On Thu, 18 Dec 2025 09:22:52 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
>=20
> On Thu, 18 Dec 2025, Takashi Yano wrote:
>=20
> > After the commit f74dc93c6359, WSL cannot start by distribution name
> > such as debian=2Eexe, which has '=2Eexe' extention but actually is an =
app
> > execution alias=2E This is because the commit f74dc93c6359 disabled to
> > follow windows reparse point by adding PC_SYM_NOFOLLOW_REP flag in
> > spawn=2Ecc, that path is used for sapwning a process=2E As a result, t=
he
> > path, that is_console_app () received, had been the reparse point of
> > app execution alias, then it returned false for the the path due to
> > open-failure because CreateFileW() cannot open an app execution alias,
> > while it can open normal reparse point=2E  If is_console_app() returns
> > false, standard handles for console app (such as WSL) would not be
> > setup=2E This causes that the console input cannot be transfered to th=
e
> > non-cygwin app=2E
>=20
> Just a suggestion: Start by describing the bug instead of leading with t=
he
> commit that caused the bug=2E Something along the lines "Microsoft Store
> apps are run via 'app execution aliases', i=2Ee=2E special reparse point=
s=2E
> Cygwin usually treats those like symbolic links=2E However, unlike prope=
r
> symbolic links, app execution aliases are not resolved when trying to re=
ad
> the file contents via `CreateFile()`/`ReadFile()` [=2E=2E=2E]"=2E

Thanks for the advice=2E How about:

    Microsoft Store apps are run via app execution aliases, i=2Ee=2E speci=
al
    reparse points=2E Currently, spawn=2Ecc does not resolve a reparse poi=
nt
    when retrieving the path of app after the commit f74dc93c6359, that
    disabled to follow windows reparse point by adding PC_SYM_NOFOLLOW_REP
    flag=2E

    However, unlike proper reparse point, app execution aliases are not
    resolved when trying to open the file via CreateFile()=2E As a result,
    if the path, that is_console_app() received, is the reparse point
    for an app execution alias, the func retuned false due to open-failure
    because CreateFile() cannot open an app execution alias, while it can
    open normal reparse point=2E If is_console_app() returns false, standa=
rd
    handles for console app (such as WSL) would not be setup=2E This cause=
s
    that the console input cannot be transfered to the non-cygwin app=2E

    This patch fixes the issue by locally converting the path once again
    using option PC_SYM_FOLLOW (without PC_SYM_NOFOLLOW_REP), which is
    used inside is_console_app() to resolve the reparse point, if the path
    is an app execution alias=2E

> > This patch fixes the issue by locally converting the path, which is
> > a path to the app execution alias, once again using PC_SYM_FOLLOW
> > (without PC_SYM_NOFOLLOW_REP) option path_conv for using inside of
> > is_console_app() to resolve the reparse point here, if the path is
> > an app execution alias=2E
> >=20
> > Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
> > Reviewed-by: Johannes Schindelin <Johannes=2ESchindelin@gmx=2Ede>
> > Signed-off-by: Takashi Yano <takashi=2Eyano@nifty=2Ene=2Ejp>
> > ---
> >  winsup/cygwin/fhandler/termios=2Ecc       | 23 ++++++++++++++++++----=
-
> >  winsup/cygwin/local_includes/fhandler=2Eh |  2 +-
> >  winsup/cygwin/spawn=2Ecc                  |  2 +-
> >  3 files changed, 20 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/winsup/cygwin/fhandler/termios=2Ecc b/winsup/cygwin/fhand=
ler/termios=2Ecc
> > index f99ae6c80=2E=2E694a5c20f 100644
> > --- a/winsup/cygwin/fhandler/termios=2Ecc
> > +++ b/winsup/cygwin/fhandler/termios=2Ecc
> > @@ -702,13 +702,26 @@ fhandler_termios::fstat (struct stat *buf)
> >  }
> > =20
> >  static bool
> > -is_console_app (const WCHAR *filename)
> > +is_console_app (path_conv &pc)
> >  {
> > -  wchar_t *e =3D wcsrchr (filename, L'=2E');
> > +  tmp_pathbuf tp;
> > +  WCHAR *native_path =3D tp=2Ew_get ();
> > +  pc=2Eget_wide_win32_path (native_path);
> > +
> > +  wchar_t *e =3D wcsrchr (native_path, L'=2E');
> >    if (e && (wcscasecmp (e, L"=2Ebat") =3D=3D 0 || wcscasecmp (e, L"=
=2Ecmd") =3D=3D 0))
> >      return true;
> > +
> > +  if (pc=2Eis_app_execution_alias ())
> > +    {
> > +      UNICODE_STRING upath;
> > +      RtlInitUnicodeString (&upath, native_path);
> > +      path_conv target (&upath, PC_SYM_FOLLOW);
> > +      target=2Eget_wide_win32_path (native_path);
> > +    }
> > +
>=20
> It might make sense to move this `is_app_execution_alias()` block before
> looking at the file extension, not that it will matter a lot in pratices
> because as far as I understand, app execution aliases are only ever
> created for `=2Eexe` files, with the same base name as the target (or at
> least with the same file extension)=2E

Both is OK, I think=2E

AFAIK, app execution alias never has extension: "=2Ebat" or "=2Ecmd" so, t=
he
both 'if' blocks are exclusive=2E

So, only the question is: which is more natural for readers=2E

