Return-Path: <cygwin-patches-return-8914-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21376 invoked by alias); 8 Nov 2017 18:07:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21361 invoked by uid 89); 8 Nov 2017 18:07:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-125.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Nov 2017 18:07:50 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 7FA9F721BBD31	for <cygwin-patches@cygwin.com>; Wed,  8 Nov 2017 19:07:46 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id B3AE05E040E	for <cygwin-patches@cygwin.com>; Wed,  8 Nov 2017 19:07:45 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9EFEBA8057D; Wed,  8 Nov 2017 19:07:45 +0100 (CET)
Date: Wed, 08 Nov 2017 18:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pread() returns non-zero if read beyond EOF, because NtReadFile returns  EOF status but doesn't set information to 0. Need reset io status block  before NtReadFile is called, so that pread() will return 0 if read beyond EOF.
Message-ID: <20171108180745.GB20845@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1958376489.4046072.1510075992854.ref@mail.yahoo.com> <1958376489.4046072.1510075992854@mail.yahoo.com> <20171108123458.GM18070@calimero.vinschen.de> <20171108124113.GA14994@calimero.vinschen.de> <1399268204.4792627.1510160512818@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1399268204.4792627.1510160512818@mail.yahoo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00044.txt.bz2


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2373

On Nov  8 17:01, Xiaofeng Liu via cygwin-patches wrote:
>  Hi Corinna,The followup patch is different from=C2=A0=C2=A0https://sourc=
eware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D46702f92ea49Maybe I=
 missed the submit protocol?ThanksXiaofeng

You should *really* fix your MUA.  I don't know what you're using there
but your mails are next to unreadable, missing line breaks, missing
spaces.  Check the archives to see what I mean:
https://cygwin.com/ml/cygwin-patches/2017-q4/

Also, please don't top-post.

>     On Wednesday, November 8, 2017, 4:41:22 AM PST, Corinna Vinschen <cor=
inna-cygwin@cygwin.com> wrote:=20=20
>=20=20
>  On Nov=C2=A0 8 13:34, Corinna Vinschen wrote:
> > On Nov=C2=A0 7 17:33, Xiaofeng Liu via cygwin-patches wrote:
> > > ---=C2=A0winsup/cygwin/fhandler_disk_file.cc |=C2=A0 =C2=A0 1 +=C2=A0=
1 files changed, 1 insertions(+), 0 deletions(-)
> > > diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhan=
dler_disk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandler_=
disk_file.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @@ =
fhandler_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGE=
R off =3D { QuadPart:offset };=C2=A0+=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, si=
zeof(io));=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!prw_handle && prw_open (false))=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto non_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0stat=
us =3D NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,--=C2=A01.=
7.1
> >=20
> > This is still completely broken, unfortunately.=C2=A0 I took a look, th=
ough,
> > and fixed this problem slightly differently.=C2=A0 Please have a look at
> > https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D46=
702f92ea49
> > I retained your authorship, of course.
>=20
> Obvious followup patch:
>=20
> https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D181f=
e5d2ed

As for the obvious followup patch, it only fixes the wrong comment I
added years ago.  Check what I pushed to fix the problem following the
other URL in my above mail, or just git pull and have a look in your
local repo.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaA0fxAAoJEPU2Bp2uRE+gV14P/2yAe+Y070EBl54Ho8DxDJBA
Uu3eGHgva169sVhmTG+uAO7WAUonx/1ZfuE4nNvLF3gwMNqljih7rsAKamMvGSOi
D4LcoB8FDoWiePN3/3uEuiGsmPa0FdBZ82oL0AazijQV7behzBxKds8JXFyaK81e
K76stNkzjmKeJTK2BnnDqFTjbx31mStSjAFA63BPCI956zyPRuJuyL1TKnhZgm1s
5h1auwI6ABExEFuLwCjVVsHo3oSUYIdXbCoEx183QBNM4XnBVo5SfszTnxOouAUf
wk3Y8NGBSiSqmPeUTqAk6tbojsbaujQxbuPjVvwRgk5MCLRvUImgj3wsQhTsYJ4V
gXddXrtorQec/EoNVVucHXkIJR6AufLDc84m+RU4j8Puc3eh1z9/S9Tt4y6oxw0p
2iCCEb3oH8hGwK+Keo7jjJHY6iFIIXembm0Ao5MbQkq72A4IspAhWLo0PtN4EvcY
z1CEco2X7jO+zxwqb80JKRK57uz1Tfu4B8c51uxjIdlbVuRirtny1V+NiCC1MJUX
jnC+FHsE8aDTX0+TyBD7afAEx19jtx+N5bmPN7J5kCgV4hlscMch34J2GmS1qrA+
nnMqA5nZAarmWui8FwI7JQyR/uBZWEqQX6MbEGnab6xb0NVtDquddyfqWP9t2VFj
guXiosSxOcKVlowUMPOK
=ifje
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
