Return-Path: <cygwin-patches-return-9172-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3119 invoked by alias); 15 Aug 2018 11:52:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3108 invoked by uid 89); 15 Aug 2018 11:52:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, jh, van, Water
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Aug 2018 11:52:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MgwGe-1fTxbt2ji4-00M3r6 for <cygwin-patches@cygwin.com>; Wed, 15 Aug 2018 13:52:17 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B6177A80586; Wed, 15 Aug 2018 13:52:16 +0200 (CEST)
Date: Wed, 15 Aug 2018 11:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Keep the denormal-operand exception masked; modify FE_ALL_EXCEPT accordingly.
Message-ID: <20180815115216.GG3747@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1534330763-2755-1-git-send-email-houder@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3rx43rDlPB5nB2+S"
Content-Disposition: inline
In-Reply-To: <1534330763-2755-1-git-send-email-houder@xs4all.nl>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00067.txt.bz2


--3rx43rDlPB5nB2+S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 4650

Hi J.H.,

thanks for the patch.  Only problem, this patch is non-trivial
enough to require the BSD waiver per https://cygwin.com/contrib.html,
see the "Before you get started" section.  I add you to the
winsup/CONTRIBUTORS file then.  That ok with you?


Thanks,
Corinna


On Aug 15 12:59, J.H. van de Water wrote:
> By excluding the denormal-operand exception from FE_ALL_EXCEPT, it will n=
ot
> be possible anymore to UNmask this exception by means of the API defined =
by
> /usr/include/fenv.h
>=20
> Note: terminology has changed since IEEE Std 854-1987; denormalized numbe=
rs
> are called subnormal numbers nowadays.
>=20
> This modification has basically been motivated by the fact that it is also
> not possible on Linux to manipulate the denormal-operand exception by mea=
ns
> of the interface as defined by /usr/include/fenv.h. This has been the sta=
te
> of affairs on Linux since 2001 (Andreas Jaeger).
>=20
> The exceptions required by the standard (IEEE Std 754), in case they can =
be
> supported by the implementation, are:
> FE_INEXACT, FE_UNDERFLOW, FE_OVERFLOW, FE_DIVBYZERO and FE_INVALID.
>=20
> Although it is allowed to define additional exceptions, there is no reason
> to support the "denormal-operand exception" in this case (fenv.h), because
> the subnormal numbers can be handled almost as fast the normalized numbers
> by the hardware of the x86/x86_64 architecture. Said differently, a reason
> to trap on the input of subnormal numbers does not exist. At least that is
> what William Kahan and others at Intel asserted around 2000.
> (that is William Kahan of the K-C-S draft, the precursor to the standard)
>=20
> This commit modifies winsup/cygwin/include/fenv.h as follows:
>  - redefines FE_ALL_EXCEPT from 0x3f to 0x3d
>  - removes the definition for FE_DENORMAL
>  - introduces __FE_DENORM (0x2) (enum in Linux also uses __FE_DENORM)
>  - introduces FE_ALL_EXCEPT_X86 (0x3f), i.e. ALL x86/x86_64 FP exceptions
> ---
>  winsup/cygwin/fenv.cc        |  8 +++++---
>  winsup/cygwin/include/fenv.h | 14 ++++++++------
>  2 files changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/winsup/cygwin/fenv.cc b/winsup/cygwin/fenv.cc
> index 066704b..0067da0 100644
> --- a/winsup/cygwin/fenv.cc
> +++ b/winsup/cygwin/fenv.cc
> @@ -417,7 +417,7 @@ fesetprec (int prec)
>  void
>  _feinitialise (void)
>  {
> -  unsigned int edx, eax, mxcsr;
> +  unsigned int edx, eax;
>=20=20
>    /* Check for presence of SSE: invoke CPUID #1, check EDX bit 25.  */
>    eax =3D 1;
> @@ -431,11 +431,13 @@ _feinitialise (void)
>    /* The default cw value, 0x37f, is rounding mode zero.  The MXCSR has
>       no precision control, so the only thing to do is set the exception
>       mask bits.  */
> -  mxcsr =3D FE_ALL_EXCEPT << FE_SSE_EXCEPT_MASK_SHIFT;
> +
> +  /* initialize the MXCSR register: mask all exceptions */
> +  unsigned int mxcsr =3D __FE_ALL_EXCEPT_X86 << FE_SSE_EXCEPT_MASK_SHIFT;
>    if (use_sse)
>      __asm__ volatile ("ldmxcsr %0" :: "m" (mxcsr));
>=20=20
> -  /* Setup unmasked environment.  */
> +  /* Setup unmasked environment, but leave __FE_DENORM masked.  */
>    feenableexcept (FE_ALL_EXCEPT);
>    fegetenv (&fe_nomask_env);
>=20=20
> diff --git a/winsup/cygwin/include/fenv.h b/winsup/cygwin/include/fenv.h
> index 7ec5d4d..5fdbe5a 100644
> --- a/winsup/cygwin/include/fenv.h
> +++ b/winsup/cygwin/include/fenv.h
> @@ -87,16 +87,18 @@ typedef __uint32_t fexcept_t;
>  #define FE_OVERFLOW	(1 << 3)
>  #define FE_UNDERFLOW	(1 << 4)
>=20=20
> -/*  This is not defined by Posix, but since x87 supports it we provide
> -   a definition according to the same naming scheme used above.  */
> -#define FE_DENORMAL	(1 << 1)
> -
>  /*  The <fenv.h> header shall define the following constant, which is
>     simply the bitwise-inclusive OR of all floating-point exception
>     constants defined above:  */
>=20=20
> -#define FE_ALL_EXCEPT (FE_DIVBYZERO | FE_INEXACT | FE_INVALID \
> -			| FE_OVERFLOW | FE_UNDERFLOW | FE_DENORMAL)
> +/* in agreement w/ Linux the subnormal exception will always be masked */
> +#define FE_ALL_EXCEPT \
> +  (FE_INEXACT | FE_UNDERFLOW | FE_OVERFLOW | FE_DIVBYZERO | FE_INVALID)
> +
> +#define __FE_DENORM	(1 << 1)
> +
> +/* mask (=3D 0x3f) to disable all exceptions at initialization */
> +#define __FE_ALL_EXCEPT_X86 (FE_ALL_EXCEPT | __FE_DENORM)
>=20=20
>  /*  The <fenv.h> header shall define the following constants if and only
>     if the implementation supports getting and setting the represented
> --=20
> 2.7.5

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--3rx43rDlPB5nB2+S
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlt0E/AACgkQ9TYGna5E
T6A22g//SHX1/2vEzhB/LVXT3vZ7SNhIjvUF42oEOuVZqtrw4bValrF2ZHOMG1BK
h+wOpBmA3H4jZngC/O6o9gIjBJT1SREP+UTtjdf9KevbbGi8jlXdxLrKyxrdX9ps
3cIeQzXfeoc6Ludup9ndD1Hr/6A3Wmbq01k19c/RS2qsIdC7o7JN7zrvUNwLh4eT
WnHVkylQ4hs8EbvrPl304PTHhTR//BkSnPhSsrTKql3hPYVwmIhKCR1kBSa/MX+g
OgOXorLOHHL5F12D7Ptiy+xjqwF4NK80Vzz4NpSm5HGgeQ2b4erER/YMhz0Yp7SB
zym/3SCapREdWg1L/RvIIGgX1wchKEmzIkvdWIbYhbkcHA4P9CK2yze2ZsKYxAvh
uSVpt3LCkhRQDd973Cpz8i5GbqVg1LBF3MUPH6YiJtEFEtNZscbYyrFhu4pZZsYs
L754DI53cDt9sk/wtMGUBiVXkzl62e8gmrR/HPQ2Q40jMLuwvQYo96L5nZ31Luan
YaUVuKTgoOfEFGz7sdI5wjbos5ExCmu5xmkNk+GmzU+aJbwRperT4MAJqED/TFCw
ORoO3pxUdPRQXtRtZaqH8wljwXY9rlq8xG9amNod+4Cbqv0qgVqiXbGDKmXTtm/1
/s4aebJ27GPwsz/xUCzRR66jBRZMOrsWuwqiE4noeRVziqAcCd0=
=NlNI
-----END PGP SIGNATURE-----

--3rx43rDlPB5nB2+S--
