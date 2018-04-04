Return-Path: <cygwin-patches-return-9045-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64127 invoked by alias); 4 Apr 2018 08:52:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64110 invoked by uid 89); 4 Apr 2018 08:52:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-123.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Apr 2018 08:52:11 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id 0Lc8iD-1ecKGz3THh-00jXn3 for <cygwin-patches@cygwin.com>; Wed, 04 Apr 2018 10:52:08 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C2F96A818CB; Wed,  4 Apr 2018 10:52:07 +0200 (CEST)
Date: Wed, 04 Apr 2018 08:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Posix asynchronous I/O support, part 2
Message-ID: <20180404085207.GK2833@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180329053153.6620-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <20180329053153.6620-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:W/i64sKjxwA=:lv4MjFq33eoF8bHqB9uqdT 6X1I339dejFk56CQY1yrUoECczdBqKpv9wXJZ84jT3mUtXAH7zcj3d/BppEPaWhAnHR1Bomrs rPmVVrY3TJFN2DbeaVjH6sEoUHoABWGVanYX97vnj/vM2NDpC/zQbEbmueFlZATr80ptLAd9L hZOLgZeQ9qiA01HXTIw6KC4tX8/9K5phpPsOQ8PkHLWd8Mzh68/xABilk90OAZ3wN0mbkbInq x1XOleh4aQi4Z7oe6bnTAW4WoXqY/wkDo2P41InCPfk786IQrG1JNGKzGc6c382FvaCBC8B4A DGmZaB7XeqXsVE2J+YWJwe7vhlFe9ydV0rsYgBkl/rdhfod9Ww2FPSI1GlKlWDB2HdIQZaVO9 4oubDosiKQwAr4BhQ0wgI0XEzABsKA9TZO2UO4mZmoZexgcfcaz9nymVGuqD9O0nSCd1jdZea aDWIAlCVYHK7mj+BADBtMPOAFl3RkVdxVU/t7mlSl42owX0fXjQATJPy9/r5ZCYBtA6q505cD 3km318Ea6wjRTYMab95liFjMOKET1pn3ZGgNQJrTbReUQ7D59mDGPzUFZzM66Bv9x2YMpZXWt cHIUjUy/Lkzp45XqVf8kyPHbB1NNMz7KE5jlpRA4KC9IT14NzAOz5lyAA0Aa9c+GnE7F6on5X apjcJwBIPU6bs+rgxedk2uI5UIHcHEGQdx5yZebviP+oVN0iZP/s0Yp5ongoni9VDPODp1TTb C7RYTLKu/+U1oGeacTogBiqrYc7+4M9SApmmDQ==
X-SW-Source: 2018-q2/txt/msg00002.txt.bz2


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 996

On Mar 28 22:31, Mark Geisert wrote:
> ---
>  winsup/cygwin/include/aio.h | 78 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 winsup/cygwin/include/aio.h

Ah, not quite ok, I have a nit here:

> diff --git a/winsup/cygwin/include/aio.h b/winsup/cygwin/include/aio.h
> new file mode 100644
> index 000000000..d6ca56517
> --- /dev/null
> +++ b/winsup/cygwin/include/aio.h
> +#ifdef __cplusplus
> +#define restrict /* meaningless in C++ */
> [...]
> +int     lio_listio  (int, struct aiocb *restrict const [restrict], int,
> +                        struct sigevent *restrict);
> +
> +#ifdef __cplusplus
> +}
> +#undef restrict
> +#endif

Don't do that.  Use __restrict instead.  Your header might have to
include sys/cdefs.h, but I guess the other includes already do that
for you.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlrEkjcACgkQ9TYGna5E
T6C8aBAAlyhooAMosNga7ORuNIunqrXs/XruTz7sAm8lvItTGWZGLZQlXljelPBf
u9aBFdtVx2TCLrJ/JM0lo8oZesEhCfRRk3081+KYEnd4LKwAJVSQnQ23CVk0OTIj
fnBuwpcy00NIuFlVxx5bSv1YuPcrkYEhXeb19ca5WQXa68EO+0XD0qvY9jtDHPxV
egGRRJMO4685nfrkPdW5IqaHX7mqZrd4Qykd/MUUW+w0PVjK0WENc+nt6m0KO+Yh
osjV2MgoBumAiGqHszF35nRB3pRFjnj45RksrergqUxerBO7f3J2PYVUNbSXGy6I
IUtAU/aGjG68hopDPZaxH4t/ucrknVj3cKa4PNvA/ramyAcHm6mRRIn0zso+wz+v
fPVD9hM13BVUhVgRFi3eYUUZ1YxZUeHhAXnrCw71vmTt778QnpmcH4D1y02bOIaP
Hk9kn0IVn8zw1mL+eyin1OPXJD0cihzARzxpuF93fShAHGUdYkpOIgcLkiJ5bUGa
mFj/+S4/y8/sTNyoM6JxTK97nSEFLmWkPaW9B67ABA265iakzJw9tsQmi2fAeEDt
IOErzSqba9lykxDfGDajaGlGxwChvI/ATZNpDTPZuofifjUeSy0pQo6Oft1elf7n
Uxq5BuPG5BkkHWMYm/HMcG1bUXYP7QtZIEs27s1thbNQTe/r2HM=
=Kpvw
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
