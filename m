Return-Path: <cygwin-patches-return-8221-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100161 invoked by alias); 1 Jul 2015 12:27:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100127 invoked by uid 89); 1 Jul 2015 12:27:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Jul 2015 12:27:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AB6D7A80922; Wed,  1 Jul 2015 14:27:17 +0200 (CEST)
Date: Wed, 01 Jul 2015 12:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jeffrey Walton <noloader@gmail.com>
Subject: Re: Using g++ and -m32 option on x86_64 broken
Message-ID: <20150701122717.GK2918@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Jeffrey Walton <noloader@gmail.com>
References: <CAH8yC8mUrhuR2vPhqSSLKmrA82nW3JhvcRnFVO1nFccy337y_g@mail.gmail.com> <20150701082901.GA7902@calimero.vinschen.de> <CAH8yC8mAb_zt9GdyJz=F2wK4fcUsY38Gj4wExxDO2h28TuP5dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
Content-Disposition: inline
In-Reply-To: <CAH8yC8mAb_zt9GdyJz=F2wK4fcUsY38Gj4wExxDO2h28TuP5dg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00003.txt.bz2


--GvznHscUikHnwW2p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2753

On Jul  1 06:59, Jeffrey Walton wrote:
> On Wed, Jul 1, 2015 at 4:29 AM, Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Hi Jeffrey,
> >
> > On Jun 30 21:38, Jeffrey Walton wrote:
> >> Cygwin's GCC responds to the -m32 option, but it causes a compile erro=
r:
> >>
> >>    expected unqualified-id before =E2=80=98__int128=E2=80=99
> >>        inline __int128
> >>
> >> If the project does not support the -m32 option, then it should be
> >> removes so that using it causes a compile error.
> >>
> >> Below is the changed needed to get through the compile with -m32:
> >>
> >> $ diff /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwi=
n/bits/c++config.h
> >> /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin/bits/=
c++config.h.bu
> >> 1306,1308c1306
> >> < #ifndef __CYGWIN32__      /* -m32 used on x86_64 */
> >> < # define _GLIBCXX_USE_INT128 1
> >> < #endif
> >> ---
> >> > #define _GLIBCXX_USE_INT128 1
> >>
> >> ************
> >
> > Wrong mailing list.  cygwin-patches is for patches to the Cygwin
> > sources, not patches to arbitrary packages in the Cygwin distro.
> > See https://cygwin.com/lists.html
>=20
> Yes, you got a patch.

Again, cygwin-patches is for patches to the cygwin DLL, not for GCC
patches.  I'm politely telling you that you're sending your report to
the wrong address so please send you request where it belongs.

> > If you want to reach out to Cygwin package maintainers [GCC maintainer
> > BCCed], use the cygwin AT cygwin DOT com mailing list.  If you want to
> > report the bug to the GCC folks, see https://gcc.gnu.org/bugs/
>=20
> No, I used Cygwin's package, and that makes it Cygwin's problem.

Even then, this doesnt make it an issue for the cygwin-patches ML.

> >> And this project really needs a bug tracker...
> >
> > As for -m32, it's not supported for a reason.
>=20
> No, GCC responds to it. If you don't support it, then take it out and
> produce a compile error.

You seem to misunderstand how this works.  The package maintainers of
the various Cygwin packages are not subscribed to cygwin-patches.  This
mailing list servers only the purpose to send patches for the Cygwin DLL
and accompanying tools, as outlined on https://cygwin.com/lists.html.
So, if you want to reach out to the Cygwin GCC maintainer, please send
your request to the cygwin AT cygwin DOT com mailing list, as outlined
on https://cygwin.com/lists.html.  Insisting on using the wrong mailing
list will not really help to move your complaint forward in the long
run.

So, please don't follow up on cygwin-patches, it's the wrong addressee.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--GvznHscUikHnwW2p
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVk9ylAAoJEPU2Bp2uRE+gLcMP/ixt/dBzWkWamAxZf2xKSoth
DHdOop9KiHA77YmeN0NzOOJ75gvISPQLfptKyoxADjFzlXjDQ0R01aQYCPdMZeIu
TI2QPypKue4ZbhBsdfu4IkVRaGykiPh1uHgkF6cBoH4GMHHzYpa+uN9gzFsoAgrE
szvA1u1YVh1wfSsWL/TLPp/g0JycZxI9/wlpHdG5BdzxcDg3OY0+1exuc1hk/KjJ
eY8RJmU+mM3V9UcoieK+OdUBBOeQto/MwFf3IQ8dQpASjH4gQFGHyJmCNxvjfOMm
uVR0R8CvCCqA4ursjnofbWCQPu7VNGvp2Xx2EvBQ+X01IuPTzxVCBxJYsZ4MpLum
H5wQ0qUmKMb0PZXlRUodGHnsH3yH06thkVKqNvd8QomTPB6cv5sDgskPVqNiPBrl
dZozxntCUL5Iq7X+JdL0tz+kDOgu1lfHNiKfXY0gWWTxfqIt+GMjb/72LkSyut8N
h79Lyyif/JlZdkcbiisZCtrxZ1SsQerr56czaoi4o/64/ec8KAQCb1CPh8ILvGHl
JYMuCG/4wyU+JPN0Aj3v0wkbdOfcE/dA9zfDLhRQE0wagQiaugt6HPhAYG99kUgR
eYm6QFtKCkOMeFy7bL321Ue0AaugDDqo5l3ORBDP/2d71u2HsKP9vzAlYZxvBR/m
FoIg0rFxM7N7gqf18udL
=rEwM
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--
