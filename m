Return-Path: <cygwin-patches-return-8831-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16991 invoked by alias); 19 Aug 2017 17:42:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16975 invoked by uid 89); 19 Aug 2017 17:42:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Feature, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 19 Aug 2017 17:42:45 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C96A771AF2A4D	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 19:42:42 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 0947C5E01BE	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2017 19:42:42 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E1504A806F8; Sat, 19 Aug 2017 19:42:41 +0200 (CEST)
Date: Wed, 23 Aug 2017 19:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: renameat2
Message-ID: <20170819174241.GB16422@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <992f81ea-736b-ebe3-2177-153b4d2e1852@cornell.edu> <20170818151525.GA6314@calimero.vinschen.de> <f7e3cc27-6989-54d8-8e3e-c11cdd5dfeca@cornell.edu> <20170819095707.GE6314@calimero.vinschen.de> <68b3c713-3261-e9d7-0865-384d18553744@cornell.edu> <20170819162828.GF6314@calimero.vinschen.de> <20170819163720.GA16422@calimero.vinschen.de> <0dd9fa10-9fb9-0848-72b5-920c7b6c20c3@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <0dd9fa10-9fb9-0848-72b5-920c7b6c20c3@cornell.edu>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00033.txt.bz2


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2231

On Aug 19 13:13, Ken Brown wrote:
> On 8/19/2017 12:37 PM, Corinna Vinschen wrote:
> > Oh, one more thing.  This is a question to Yaakov, too.
> >=20
> > diff --git a/newlib/libc/include/stdio.h b/newlib/libc/include/stdio.h
> > index 5d8cb1092..331a1cf07 100644
> > --- a/newlib/libc/include/stdio.h
> > +++ b/newlib/libc/include/stdio.h
> > @@ -384,6 +384,9 @@ int _EXFUN(vdprintf, (int, const char *__restrict, =
__VALIST)
> >   #endif
> >   #if __ATFILE_VISIBLE
> >   int    _EXFUN(renameat, (int, const char *, int, const char *));
> > +# ifdef __CYGWIN__
> > +int    _EXFUN(renameat2, (int, const char *, int, const char *, unsign=
ed int));
> > +# endif
> >   #endif
> >=20
> > Does it makes sense to guard the renameat2 prototype more extensively
> > to cater for standards junkies?  __MISC_VISIBLE, perhaps?
>=20
> I'll defer to Yaakov.  But here's a related question.  Is renameat
> currently guarded properly?  The Linux man page says:
>=20
> Feature Test Macro Requirements for glibc (see feature_test_macros(7)):
>=20
>        renameat():
>            Since glibc 2.10:
>                _POSIX_C_SOURCE >=3D 200809L
>            Before glibc 2.10:
>                _ATFILE_SOURCE
>=20
> This suggests that we should do something like the following:
>=20
> diff --git a/newlib/libc/include/stdio.h b/newlib/libc/include/stdio.h
> index 331a1cf07..9eb0964f2 100644
> --- a/newlib/libc/include/stdio.h
> +++ b/newlib/libc/include/stdio.h
> @@ -381,8 +381,6 @@ FILE *      _EXFUN(open_memstream, (char **, size_t *=
));
>  int    _EXFUN(vdprintf, (int, const char *__restrict, __VALIST)
>                 _ATTRIBUTE ((__format__ (__printf__, 2, 0))));
>  # endif
> -#endif
> -#if __ATFILE_VISIBLE
>  int    _EXFUN(renameat, (int, const char *, int, const char *));
>  # ifdef __CYGWIN__
>  int    _EXFUN(renameat2, (int, const char *, int, const char *, unsigned=
 int));

No, that's correct.  See sys/features.h:

 * __ATFILE_VISIBLE
 *      "at" functions; enabled by default, with _ATFILE_SOURCE,
 *      _POSIX_C_SOURCE >=3D 200809L, or _XOPEN_SOURCE >=3D 700.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZmHiRAAoJEPU2Bp2uRE+g5wAP/2HSa5ZwXGLn1r9NINrjxccG
zogUMyDKnVrX+zXMq1xlBMnDxu1VF2nV11vHsnegD51nJMauqXGQFklcypa7V4ld
flAXdpngThiIWwGSd/6W1webq3Is3Kp/ghREf9RwhXb8V6ypcJJ7l2c+86T2tsC0
+K2K/T+pMAItVJgZCPKpEIXsn2iT9Nkb9FqT9EVE45P2xTnpMGjxXV1Vl+GMLCm5
mhNvtluh6lKQJ2d1BCphU44uICIUSqcWuWKuPR/x80nvTksZrXV2xQBTEvRJ1C7H
zUVX0bNNb6KfVdPnn+qUK8PrwC1no9BVfSnYmaFQswtOpe5NEroMfvoutn3dsht5
i3q1KiJGpepEiTy9ukb2Je+VKEOm/WU95AvIdv92YE17YcE/9+Mq+6xGhctWjVnW
AkoULWg4LJKVGK8AqQ7QLfo/of+3g/NZ2GzwySDN5WE+OGUrNbd/eZA7mCb7U0+1
xFB4IT0ynbULUYhXhLlqQu43hN8cEB+pbwdyIvQMhCVhlKgrPfxItf6j0Viq3E6L
gfxpypEQeqCl+nYj1LtA2DhqrIOHWLC7vmZBwEGd0P7fuPzuVWL8Kux4UM7CDFOQ
k3Umx4mH9x/DPCwjB+c2JL0BzG5I/ORFDw/Q6ZJNvuLFtinyhglvorKR8gwOGMXX
MTHzTW5Tf59p8BP+QU/4
=255d
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
