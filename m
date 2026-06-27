Return-Path: <SRS0=+gxg=EX=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 1C36B4BA2E2D
	for <cygwin-patches@cygwin.com>; Sat, 27 Jun 2026 08:38:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1C36B4BA2E2D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1C36B4BA2E2D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782549539; cv=none;
	b=JSOyISTGBSbyy9Tf1cUCyB6XhicJ3iDlLYEeMFgbjg0xqgw0gKBfNj93b7C4mfjYIj7bqu5VnrfJKKQ3OUhtI+TEOPU1fOhFXZv89bOb0G758evIzmm81c0nTKMXG4FoFbq9udvHvqAo21hQ3l918YrF36VNNAtmnOYp/4QP8a0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782549539; c=relaxed/simple;
	bh=r6pJSPFrvrupB9DCwb0rfyZ31NrStXLW90oAlg13YcM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=dK/+JdBc6Wu29WdPMhi0oxmtBmDZflQ1zos80ytMoJr6e/JDB7TAOvyQMU+1/3ECZ98ZdzcyaCAcJNrMMZE/r7MU2Px5gYVX6dRKnDCt5nn3BxoKhaeMNviGvUA4qEyOkS/GH4njCQcys4S+D9EKg/eG9gHMr0irk6UhV2PA78I=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=nP+DAA0u
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1C36B4BA2E2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=nP+DAA0u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1782549531; x=1783154331;
	i=johannes.schindelin@gmx.de;
	bh=r2BsDxQwqXGWO6bLFOyRvfyl4bBTqP1d8dNylQPPwBY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nP+DAA0uCGtHPPZGmmyUid6oWifc1b+ToV8WmFcn7GSZsFwusFbmgAMwG6VosXSz
	 6WnLzuogiawD7K3ZeXJi2W1LBOk78NtXw8pCLtxpJITGbcsP1vRb+59t8NVs1UxUH
	 Ym+h6hzoFZfDwiFmJj+28HhtuTgEJ797HY1F5cAzkd4hf2gUCnNYwYeQzD4m2PgBP
	 URDGOD3w++Gy0hRn1i2Zg/AYvyqTKxLkus/IK+EMTvHoJ8KfW5DbBTxjYgM0CcfZN
	 wK0cTnKjgNzzPLgJ13UtQ4e9DXU8HBD2XpliFaZiW6BD7bi74JwtpnYdcqjGP86pi
	 9SFv1/h5yz3eAkMMqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1xElfO41Ci-00wWV2; Sat, 27
 Jun 2026 10:38:51 +0200
Date: Sat, 27 Jun 2026 10:38:50 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned
 children
In-Reply-To: <20260529115620.1ae78cd8926d65720e97d850@nifty.ne.jp>
Message-ID: <ecb00d76-6ac5-afd5-dea2-43b08c35818c@gmx.de>
References: <pull.7.cygwin.1777561444611.gitgitgadget@gmail.com> <20260505212503.fdf6b912b76c5cae97a1372c@nifty.ne.jp> <b11ddb3b-52c1-984d-6879-5257a2952b02@gmx.de> <20260529115620.1ae78cd8926d65720e97d850@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:6N22qb0sIctRua0QzU/5FiqXuN3X32xaDrbibGjvryTmImpCPjo
 +ECJtQnW7wQcoVRrF50+XlPEqHrGbsc/sjeXe/q93K7ijqoUkBBkiXSNZ1NFIGzFwESt6Ua
 M+b0gBtkQsAYxZGD74V1J4nl/JyqZFrddmTFvvIlNbZMyw48STGAf6nBle6fYDUc4vVgj5x
 SR6yAscFZfZKylaxaD6Xw==
UI-OutboundReport: notjunk:1;M01:P0:awT+YEjQqhY=;+q1DZx/vas5gF9n29zbI5FclLss
 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
 T0vnay3CuZrToE1630gRDa2DGlDP3AYbHq0LqPvfB0P+xdSFP/CoOoJ66Hg35z9QUl0d96UxX
 c3h5zRS+IxBRG8geEKk0M0g7rde6VkrSCZipKclIbnt/+Bo2GaKIXP9tT2iU3RH7aG+v/DzaT
 2fo/JYgPacgZD9MubbuCUTI0M6U0EisV+NV2u0NdejkjC0rnrDT2cyzQ5rtB244xpBO2g8yMh
 ZTMLpQmDMDDOEMxFAQYOOtOg19iv3rcGs7qa9AF8x6VJ/XyEPORl4Da6ZYYWaq7R+1X+el95T
 Jr+qb806t+t4UiqEOt75sbKhSrHDRvSs/5zXa5B+32R2Fk1YODxU3ALOV/j8hlVK660p1/FM/
 +QryCqT9LuN+1xB2f897CDrflbX6T1sO5ZxM0KsNIWva7chzcT773RXRzxm79zSvsNX6lG9LJ
 wZtnMKF84cZdZviOMhkN0v63BKC+fdXdKX87Kl31ToDHXboYeCjGjxd/5rkuoZl4UcXbsdI3P
 /Fj6cyWClYnD7lxvm1NrCxk7xlsMV8b6zux+Iq4+Vo2q9oGhFe0gB2ZUQNM4lt4wYD4LC7Oa1
 1rdofgOJUobufIyzpkODtgURVNJ7+igZU2YcOwj+Bn0zPF2UPxzxpsWT89C4iJu/siEsJZ4LC
 Sqvdnh11sVQBbP+v01RQeYoeqe46vZH1ojNqDzTKMUrJb1wiDL+eT1kiw68U+ZCg9YrTnBg3j
 TgXycmeNmi67/DYgr0=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 29 May 2026, Takashi Yano wrote:

> On Thu, 28 May 2026 15:48:24 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> >=20
> > On Tue, 5 May 2026, Takashi Yano wrote:
> >=20
> > > On Thu, 30 Apr 2026 15:04:04 +0000
> > > "Johannes Schindelin via GitGitGadget" wrote:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >=20
> > > > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > > > index 7303f7eac..ce29f4608 100644
> > > > --- a/winsup/cygwin/dtable.cc
> > > > +++ b/winsup/cygwin/dtable.cc
> > > > @@ -327,7 +327,17 @@ dtable::init_std_file_from_handle (int fd, HA=
NDLE handle)
> > > >  	dev.parse (myself->ctty);
> > > >        else
> > > >  	{
> > > > -	  dev.parse (FH_CONSOLE);
> > > > +	  /* Check whether the inherited console is actually a pseudo
> > > > +	     console bridging a pty.  This happens when our non-Cygwin
> > > > +	     parent was itself spawned by a Cygwin process from a pty
> > > > +	     (e.g. bash spawning git.exe which then spawns vim).  In
> > > > +	     that case, connect to the pty slave instead of treating
> > > > +	     the handle as a real console. */
> > > > +	  int pcon_minor =3D cygwin_shared->tty.find_pcon_pty ();
> > > > +	  if (pcon_minor >=3D 0)
> > > > +	    dev.parse (FHDEV (DEV_PTYS_MAJOR, pcon_minor));
> > > > +	  else
> > > > +	    dev.parse (FH_CONSOLE);
> > > >  	  CloseHandle (handle);
> > > >  	  handle =3D INVALID_HANDLE_VALUE;
> > >=20
> > > The lines:
> > > CloseHandle (handle);
> > > handle =3D INVALID_HANDLE_VALUE;
> > > are dropped in master branch. Do you think that these two lines
> > > are necessary for this patch when applying this patch to cygwin
> > > master branch?
> >=20
> > Those two lines are not necessary, all added code ignores the handle
> > entirely.
>=20
> OK. I think this patch is not a bug fix but a behavioral change,
> so it should go only to the master branch. What do you think?

Seeing as this fixes a regression in Git for Windows, where `git commit`'s
spawning a `vim` that will clear the screen after exiting instead of
restoring the previous non-alternate screen, I would characterize it as a
bug fix.

But I can make that bug fix downstream-only, in Git for Windows' fork of
the MSYS2 runtime, if you want to keep the commit in Cygwin's `master`
only and not backport it to `cygwin-3_6-branch`. Either solution is fine
for me.

> If so, the patch does not apply to master branch due to these
> two lines. Could you please update the patch for master branch?
>=20
> In addition, I would appreciate it if you could consider incorporating
> the two additional patches I posted earlier.

Sorry, I could not find the time to finish the analysis and validation via
those AutoHotKey-based tests earlier.

Ciao,
Johannes
