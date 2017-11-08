Return-Path: <cygwin-patches-return-8912-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86232 invoked by alias); 8 Nov 2017 12:41:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86219 invoked by uid 89); 8 Nov 2017 12:41:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-125.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1472, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Nov 2017 12:41:17 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C680072106C23	for <cygwin-patches@cygwin.com>; Wed,  8 Nov 2017 13:41:13 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 36CCB5E01BE	for <cygwin-patches@cygwin.com>; Wed,  8 Nov 2017 13:41:13 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 26444A8057D; Wed,  8 Nov 2017 13:41:13 +0100 (CET)
Date: Wed, 08 Nov 2017 12:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pread() returns non-zero if read beyond EOF, because NtReadFile returns  EOF status but doesn't set information to 0. Need reset io status block  before NtReadFile is called, so that pread() will return 0 if read beyond EOF.
Message-ID: <20171108124113.GA14994@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1958376489.4046072.1510075992854.ref@mail.yahoo.com> <1958376489.4046072.1510075992854@mail.yahoo.com> <20171108123458.GM18070@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20171108123458.GM18070@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00042.txt.bz2


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1457

On Nov  8 13:34, Corinna Vinschen wrote:
> On Nov  7 17:33, Xiaofeng Liu via cygwin-patches wrote:
> > ---=C2=A0winsup/cygwin/fhandler_disk_file.cc |=C2=A0 =C2=A0 1 +=C2=A01 =
files changed, 1 insertions(+), 0 deletions(-)
> > diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandl=
er_disk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandler_di=
sk_file.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @@ fh=
andler_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGE=
R off =3D { QuadPart:offset };=C2=A0+=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, si=
zeof(io));=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!prw_handle && prw_open (false))=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto non_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0stat=
us =3D NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,--=C2=A01.=
7.1
>=20
> This is still completely broken, unfortunately.  I took a look, though,
> and fixed this problem slightly differently.  Please have a look at
> https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D4670=
2f92ea49
> I retained your authorship, of course.

Obvious followup patch:

https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D181fe5=
d2ed


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAvtoAAoJEPU2Bp2uRE+gu3MP/2fpT9JZE4lv74pNkPxXlgIe
TZR2BZcDtqGoxxlfb0SLSF4ID7ypFghwdvO9k1Vfw0n+3snHcYzHkhPxt+lZmHjA
RqwdHfkc9JGEi//uTZkuzDUmybQygSrW2UA5fRioN55Cpl4SrKhKiBC+poodPDLC
wSXzoG24bxw4wJSYA6hsHumlCKl4s1kXFYkZuOxrAmW3ytNkMqeaLIVO/iwqJzhf
gOAxJjLi6G+0G45ODmsdS+bFZFK8GePsrFpRca5VeboBLWxYrPGKQI4U/ul/V9uW
uKABVcwLVYD4nGBvPD5z+6A5ZMUExoe3ZXWq18AoNy/GuU2NuylksQFpU/39RltD
K1XFoVJeXLplPFw1elWmHJb3eXRD6pRQIs/wdnxzOwyHnyRI9qvU68dvogUB2etg
RU6e9uXWExL66KPv1BLKIUMqK/srNVl+IoUwNLDpWD0uBjadC6dEKzTme/REhaEy
ZshSGbEw8b8RoF31gFFJDx+SvkMpGSIKHAQLc6juWCSgC0BbL1X1IBh6IY2IM45t
j6vAXczrLM+ioZlk5EchIrH1GTudSChok3/SbIRUwIcTifIA3P0kVeB0lUckUi91
sG95RhWSFEtRtLXE1DTaeKG5cGBLYOB1fg8IIEnZy382gmGHPM9PR0zPv07WnfZc
zv7CXr00o8fKFRIPcoWj
=uzI6
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
