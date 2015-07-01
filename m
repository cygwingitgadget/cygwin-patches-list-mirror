Return-Path: <cygwin-patches-return-8219-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4791 invoked by alias); 1 Jul 2015 08:29:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4780 invoked by uid 89); 1 Jul 2015 08:29:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 01 Jul 2015 08:29:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CA58FA8091C; Wed,  1 Jul 2015 10:29:01 +0200 (CEST)
Date: Wed, 01 Jul 2015 08:29:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jeffrey Walton <noloader@gmail.com>
Subject: Re: Using g++ and -m32 option on x86_64 broken
Message-ID: <20150701082901.GA7902@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Jeffrey Walton <noloader@gmail.com>
References: <CAH8yC8mUrhuR2vPhqSSLKmrA82nW3JhvcRnFVO1nFccy337y_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <CAH8yC8mUrhuR2vPhqSSLKmrA82nW3JhvcRnFVO1nFccy337y_g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00001.txt.bz2


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2595

Hi Jeffrey,

On Jun 30 21:38, Jeffrey Walton wrote:
> Cygwin's GCC responds to the -m32 option, but it causes a compile error:
>=20
>    expected unqualified-id before =E2=80=98__int128=E2=80=99
>        inline __int128
>=20
> If the project does not support the -m32 option, then it should be
> removes so that using it causes a compile error.
>=20
> Below is the changed needed to get through the compile with -m32:
>=20
> $ diff /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin/b=
its/c++config.h
> /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin/bits/c++=
config.h.bu
> 1306,1308c1306
> < #ifndef __CYGWIN32__      /* -m32 used on x86_64 */
> < # define _GLIBCXX_USE_INT128 1
> < #endif
> ---
> > #define _GLIBCXX_USE_INT128 1
>=20
> ************

Wrong mailing list.  cygwin-patches is for patches to the Cygwin
sources, not patches to arbitrary packages in the Cygwin distro.
See https://cygwin.com/lists.html

If you want to reach out to Cygwin package maintainers [GCC maintainer
BCCed], use the cygwin AT cygwin DOT com mailing list.  If you want to
report the bug to the GCC folks, see https://gcc.gnu.org/bugs/

> And this project really needs a bug tracker...

Since this is a GCC problem, it has:

  https://gcc.gnu.org/bugzilla/

As for -m32, it's not supported for a reason.  The link stage requires
to provide the 32 bit libs as part of a 64 bit install.  This is done on
Linux where the 32 bit stuff is in /usr/lib and the 64 bit stuff in
/usr/lib64, but we don't do that.  Both installations, 32 and 64 bit,
use /usr/lib.

What we do have is support for cross-compiling using a cross compiler
like i686-pc-cygwin-gcc on 64 bit Cygwin and x86_64-pc-cygwin on 32 bit
Cygwin.

See the cross build packages who's names start with "cygwin32-" on 64
bit, "cygwin64-" on 32 bit.
This supported is limited though, because it only provides a limited set
of cross libs to link against.  It was mainly an effort to support
our package maintainers when we introduced 64 bit Cygwin.

If you need access to all 32 bit libs, build on 32 bit Cygwin.  If
you need access to all 64 bit libs, build on 64 bit Cygwin.

Alternatively we wouldn't be unhappy for a volunteer (especially given
how few volunteers we are) to provide more cross build packages to
support easy cross compiling on both platforms.  Having a working -m32
utilizing the cross build package path would be the icing on the cake.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVk6TNAAoJEPU2Bp2uRE+gxQUP/1pbKFlNMU+5zpJPUEPgUyIW
+b6EOlvU9MTDjBYieqzY407NMv7IImeo9QpPAiItkwgtcbt/eWz3lthV+TdnLxqG
NRadDtgERf1imT+e/YKE7U4yZnEHA3/dZNug6dPkDVrvmFu/J126kD84HsKBWk1J
o7DsKOwG+MZqTWUOy9C+CA+/PTr6BX1xu8uSxaq3p7uFN8cygemWwe1Wq3axWrzf
JwYLJY28w6OgizxJ2T8FjAnx0LILhVnAwGpksu/9OgWA2N329lsPVqwCklGW6n/+
wGHVkHDqvjVWynQU1dy7FOfKzt1BF+8NOFiuNdM+hEYxaPutv93t5JfZNtXWo3IP
C/NbstIeJ9iXeBdp3CmTjBLz/HRK174vBI3KLZPdOkcJYbl2mfCtO19v71BJ6IJ1
d1cjJKRflgtHZITgXuPGE+cwZh2o8m6KG1ouKoR/KGxzMSWwY72j2tGof/iX9DyV
JTNoAbQNqheLjLXYDEOSqvKi+dvnECWmzhPNZU43GhaSePYc1kLGmmQc5XTqg/HG
1+mQR9aLc0sDwZHbC7YOoUIIbUPZQnPaYCdhpMJXzJZLHYwmuyGn5f0VPW3TFza5
yLW/E6FvXjy48Rs67JpIUO06eeWueg9G5sfrT5VnqFjry2bEPFPiQoKRcCvUNdd/
6LZxc/21iSNZR3mGndxV
=n/pS
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
