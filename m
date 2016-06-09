Return-Path: <cygwin-patches-return-8572-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 57251 invoked by alias); 9 Jun 2016 09:00:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57002 invoked by uid 89); 9 Jun 2016 09:00:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:2359, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 09 Jun 2016 09:00:06 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 46018A80929; Thu,  9 Jun 2016 11:00:04 +0200 (CEST)
Date: Thu, 09 Jun 2016 09:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Declaration of crypt
Message-ID: <20160609090004.GK30368@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <b1986513-81eb-39a0-959f-ba9f98521e03@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <b1986513-81eb-39a0-959f-ba9f98521e03@cornell.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00047.txt.bz2


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2467

Hi Ken,

On Jun  8 17:18, Ken Brown wrote:
> According to Posix, including <unistd.h> should bring in the declaration =
of
> crypt.  The glibc and FreeBSD headers are consistent with this, but Cygwi=
n's
> aren't.
>=20
> $ cat test.c
> #include <unistd.h>
>=20
> int
> main (void)
> {
>   const char *key =3D NULL;
>   const char *salt =3D NULL;
>   crypt (key, salt);
> }
>=20
> $ gcc -c test.c
> test.c: In function =E2=80=98main=E2=80=99:
> test.c:8:3: warning: implicit declaration of function =E2=80=98crypt=E2=
=80=99
> [-Wimplicit-function-declaration]
>    crypt (key, salt);
>    ^
>=20
> The attached patch is one way to fix this.  It means that cygwin-devel wo=
uld
> have to require libcrypt-devel.
>=20
> I'm not sure if I used the right feature-test macro in the patch.  It's
> marked XSI by Posix, but using __XSI_VISIBLE didn't work.

What do you mean by "didn't work"?  __XSI_VISIBLE should be the right
thing to use.  Your application would have to define, e.g.,
_XOPEN_SOURCE before including the file.

Another point is the && defined(__CYGWIN__).  This should go away.
We're trying to make the headers more standards compatible without
going into too much detial what targat provides which function.

> P.S. Is cygwin-patches OK for this sort of thing, or should I have sent it
> to the newlib list?

Ideally to the newlib list, but no worries :)

> From 91ed7816e771a78170555db246e0e35dc6d2ca3e Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Wed, 8 Jun 2016 17:04:06 -0400
> Subject: [PATCH] Make <unistd.h> declare crypt
>=20
> This is mandated by Posix and is done by the glibc and FreeBSD headers.
> ---
>  newlib/libc/include/sys/unistd.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sys/u=
nistd.h
> index ef00575..ebae5d8 100644
> --- a/newlib/libc/include/sys/unistd.h
> +++ b/newlib/libc/include/sys/unistd.h
> @@ -31,6 +31,9 @@ int     _EXFUN(close, (int __fildes ));
>  #if __POSIX_VISIBLE >=3D 199209
>  size_t	_EXFUN(confstr, (int __name, char *__buf, size_t __len));
>  #endif
> +#if __BSD_VISIBLE && defined(__CYGWIN__)
> +#include <crypt.h>
> +#endif
>  #if __XSI_VISIBLE && __XSI_VISIBLE < 700
>  char *  _EXFUN(ctermid, (char *__s ));
>  #endif
> --=20
> 2.8.3
>=20

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXWTAUAAoJEPU2Bp2uRE+gg0YP/0H2/sN+7gkniSHeoCaPHYt4
GNadddRKBk5TSeQd8gdxQv1RgMLdkKUJka2Ny/lZAqxAi87Nj/r8tVx15jtwGvrR
7fS+D3rJi9/A1WGPyUD50mx3CTZQl7GlRPvPEpxxNMKowWFAfzJbJEpAos3lelps
rTMOc/tucdFl9FCrjkY69gVZhbEmw+2Ew5/dbOMhGqqjO6gzlev+vSBO7iMwJpj+
QVjSFPGPjf8Hi5hGaT5BNINWm8xxqCTNXegJfQ4+kmBMJcqdqwO5XYasIbZJ4wXL
xaPqEf2l7wI+yL980mROiL0kt96j1m2i+hhvCVLHPUGN3fMm4L/SxiCBiwPnhPdM
WKV6z3rm2hIercnjWtjMAm7C2vsuttGAW7cCdPv8YPe4kt7LygSZstsdQX417oSw
4ErHMikZGtD3tZMdyM4Tz3lJP+tSU252RLzP53pPigoP9oglFFM/g6LHlIayu3P3
+ilc+lL0A5UH9pQvncICoUoiOc0LKy4DsCB4ZJ4wk3FLg/2qR2GuexKph2CTZuK5
kWL403WxeJVP9kDIbHyWFunUdSuxKd8EItPoHoB25HrDS88EcuW2DAmcG32tKJHN
a82dLR3cl/2eaX/kQhEN95Av6x6ZfKr/xqGdgYKXO2MhlGjEyZw7XxJOvN2+Rcob
GKbPGZF+degRZg3BZvTc
=4e0u
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
