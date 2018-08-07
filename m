Return-Path: <cygwin-patches-return-9170-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47472 invoked by alias); 7 Aug 2018 07:49:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47456 invoked by uid 89); 7 Aug 2018 07:49:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=mails, Cygwin, Hx-languages-length:1439
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Aug 2018 07:49:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue006 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MK8g5-1fnlZ71sXt-001Q6J for <cygwin-patches@cygwin.com>; Tue, 07 Aug 2018 09:49:52 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 85123A81865; Tue,  7 Aug 2018 09:49:51 +0200 (CEST)
Date: Tue, 07 Aug 2018 07:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Fix return value on aio_read/write success
Message-ID: <20180807074951.GC4180@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180804202329.GA4180@calimero.vinschen.de> <20180807055406.4604-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20180807055406.4604-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00065.txt.bz2


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1534

On Aug  6 22:54, Mark Geisert wrote:
> Internally track resultant byte counts as ssize_t, but return 0 as int
> for success indication, per POSIX.
> ---
>  winsup/cygwin/aio.cc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
> index fe63dec04..7d5d98299 100644
> --- a/winsup/cygwin/aio.cc
> +++ b/winsup/cygwin/aio.cc
> @@ -265,7 +265,7 @@ aiowaiter (void *unused)
>      }
>  }
>=20=20
> -static int
> +static ssize_t
>  asyncread (struct aiocb *aio)
>  { /* Try to initiate an asynchronous read, either from app or worker thr=
ead */
>    ssize_t       res =3D 0;
> @@ -296,7 +296,7 @@ asyncread (struct aiocb *aio)
>    return res;
>  }
>=20=20
> -static int
> +static ssize_t
>  asyncwrite (struct aiocb *aio)
>  { /* Try to initiate an asynchronous write, either from app or worker th=
read */
>    ssize_t       res =3D 0;
> @@ -712,7 +712,7 @@ aio_read (struct aiocb *aio)
>        ; /* I think this is not possible */
>      }
>=20=20
> -  return res;
> +  return res < 0 ? (int) res : 0; /* return 0 on success */
>  }
>=20=20
>  ssize_t
> @@ -902,7 +902,7 @@ aio_write (struct aiocb *aio)
>        ; /* I think this is not possible */
>      }
>=20=20
> -  return res;
> +  return res < 0 ? (int) res : 0; /* return 0 on success */
>  }
>=20=20
>  int
> --=20
> 2.17.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltpTx8ACgkQ9TYGna5E
T6AVRxAAidlVzGoi9yli0X7X4JhxxbS3vkXJh2c6qnWVZQ+YjO1oq0nak2ud1b5y
Y4BPIyNeH5ojm/FPGeKsQ9rWoONjmTjrmL2bWez/ZGv+ce3ZHqRqAKI3pvgf8eEm
iE6FyfYokjIeS8WH8Tt6uBmIabBByLaV7IwVIG4QqIzLLelfpxQTb6lethCGi2VM
PaYMQFXSacDNl82ODcswCIzJppS7uyyDJbaj2oovb5kRWHEvSAvV9Un2NfgMoirU
aZGkYNwZmyadqGTBhequzOXwTbU0HKxGSzJA7oXCItwaFAS/G5Tm5CWmlS/1vpff
6tLv1YWqUOTcWA9/e3xdK8Ijh5YRnn/exhBgqstbI5W4Jr2S9npU4HCnDDJY8qYb
FyqqR+/AEBIQcSYekZplbjrnu8gW0h1oeONeDOtS7o93zvd9H+V4XAOH5/fdy0+n
zy1/jxsf5xVZEV+0LtgQu3yZ5V1YqDiOM88g2oDZzpTN1W4cAmY8wbrG8YwzjoTx
lsut3wyErK22jCZWlSW9PLYfh3uYv9awToeIBiTG9+ur36uuPX4guII9TjxGMTjX
hUB2YaQG6FQD30Tp1P29eY7bZC2Q0yO4XKiIn0Cb29c2j4ofF1l+eIJRlOjB/IlJ
ppnF94iMm7zKs/Aa9/RtTkDhNdZrwJKSBZI0w8GBrUXYsDRbMMk=
=YMn5
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
