Return-Path: <cygwin-patches-return-10110-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9961 invoked by alias); 24 Feb 2020 18:33:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9952 invoked by uid 89); 24 Feb 2020 18:33:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 24 Feb 2020 18:33:21 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MuDPf-1jPTz12r4H-00uYVB for <cygwin-patches@cygwin.com>; Mon, 24 Feb 2020 19:33:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0C244A82770; Mon, 24 Feb 2020 19:33:18 +0100 (CET)
Date: Mon, 24 Feb 2020 18:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-ID: <20200224183318.GH4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp> <20200221194333.GZ4092@calimero.vinschen.de> <20200222170123.23099cf86117791daa1722c5@nifty.ne.jp> <20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp> <20200224100835.GD4045@calimero.vinschen.de> <20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00216.txt


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1647

On Feb 25 01:10, Takashi Yano wrote:
> On Mon, 24 Feb 2020 11:08:35 +0100
> Corinna Vinschen wrote:
> [...]
> > Btw., are you testing the console with black background?  I'm asking
> > because I'm using the console with grey background and black characters,
> > and I'm always seeing artifacts when using vim in xterm mode.
> >=20
> > E.g., open vim on the fork-setsid.c source in the console in xterm
> > mode.  Move the cursor to the beginning of the word `setsid'.  Now
> > press the three chars
> >=20
> >   c h <CR>
> >=20
> > this moves the setsid call to the next line.  But it also adds
> > black background after `setsid();'.  Simiar further actions always
> > create black background artifacts.
> >=20
> > Is there anything we can do against that?
>=20
> This seems to be a bug of windows console. It also occurs in wsl.
> /bin/echo -e '\033[H\033[5L'
> causes the similar result.

Oh well.

> The following code cause the problem as well.
>=20
> #include <windows.h>
> int main()
> {
>     CONSOLE_SCREEN_BUFFER_INFO sbi;
>     SMALL_RECT r;
>     COORD c =3D {0, 0};
>     CHAR_INFO f =3D {' ', 0};
>     HANDLE h =3D GetStdHandle(STD_OUTPUT_HANDLE);
>     DWORD n;
>     ReadConsoleOutputAttribute(h, &f.Attributes, 1, c, &n);
>     GetConsoleScreenBufferInfo(h, &sbi);
>     c.X =3D 0;
>     c.Y =3D sbi.srWindow.Top + 5;
>     ScrollConsoleScreenBuffer(h, &sbi.srWindow, NULL, c, &f);
>     return 0;
> }

Is there some kind of workaround for that problem?  Otherwise defaulting
to a (broken) xterm mode instead of a (working) cygwin mode is a bit
questionable, isn't it?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5UFu0ACgkQ9TYGna5E
T6BZ1hAAh5hqL6mK4xJ4algKGXNfypjT/vf0e76vr5JepVLks1e1CgFtShoj2IvU
K/3rodXl0FdkY+JyJQmBEMxss1jo4+YVI+5TBvednYlWh2iSNdi12Y5HVu3ONOWR
ehLIbGtGMxwRKaeQR4nv40ou7bZRJsDkNXfFE5MqoQiabMWuS8NWkqq3KrNRXK4w
f2aGl8xjQPJIRxRcMKsUOo6hKpLtje5t9WgOuJLOcLoXm4n7WVHrCVkmvzVdOQAF
/LPAVsdHQmxJJlBi/8rTU4UjUpunHNdW3FKfM2tbyBd3Fhj12t6TOw/sXdjTgi21
YQPtIgboa9N2dS3VKRndX3bPlrL6uSageNvFJ4mukbdScoHQ8LnzDskp7ZFz8uLj
o3PZeEDa3MWI+TS+gZSBFZKLIP2IDlWU3a9KpbOgcyJvRUKg5zg8vrfxmWgYNobo
dcn63Rdxi7Nyjq8tRn3FxqaMFRt9ctBrf1mZLumhRYiZa5VQjf7uWxCUrCBZmyVn
mxar/084Cvd4VwhiGTZu4VLUjw5LYdEZ2m7VjtGZ25Q+reEgI2mL/0NZm/R8Q1aB
OB17NdqPf4IHeeF9qjxEoFNiayfh07x2Lb6Bm7lh7KCyddViv/g0nqUTB6Guh+Qy
WArVoD1r51D0ubDVO70iAQ6bdZlJPr3jjCXPmEzp/pN7IBTn3VE=
=4XfW
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
