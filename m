Return-Path: <cygwin-patches-return-10036-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100809 invoked by alias); 31 Jan 2020 11:49:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100725 invoked by uid 89); 31 Jan 2020 11:49:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=thereby, winsup, Brown, H*Ad:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 31 Jan 2020 11:49:02 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mk178-1jQH5g0lOS-00kO7P for <cygwin-patches@cygwin.com>; Fri, 31 Jan 2020 12:49:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A9988A807C3; Fri, 31 Jan 2020 12:48:59 +0100 (CET)
Date: Fri, 31 Jan 2020 11:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fstat_helper: always use handle in call to get_file_attribute
Message-ID: <20200131114859.GW3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200130170124.30431-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DvifzEOEABd5jzbd"
Content-Disposition: inline
In-Reply-To: <20200130170124.30431-1-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00142.txt


--DvifzEOEABd5jzbd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1393

On Jan 30 12:01, Ken Brown wrote:
> When fhandler_base::fstat_helper is called, the handle h returned by
> get_stat_handle() should be pc.handle() and should be safe to use for
> getting the file information.  Previously, the call to
> get_file_attribute() for FIFOs set the first argument to NULL instead
> of h, thereby forcing the file to be opened for fetching the security
> descriptor in get_file_sd().
> ---
>  winsup/cygwin/fhandler_disk_file.cc | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler=
_disk_file.cc
> index f362e31e3..ad63af824 100644
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -394,13 +394,14 @@ fhandler_base::fstat_fs (struct stat *buf)
>    return res;
>  }
>=20=20
> +/* Called by fstat_by_handle and fstat_by_name. */
>  int __reg2
>  fhandler_base::fstat_helper (struct stat *buf)
>  {
>    IO_STATUS_BLOCK st;
>    FILE_COMPRESSION_INFORMATION fci;
> -  HANDLE h =3D get_stat_handle ();
> -  PFILE_ALL_INFORMATION pfai =3D pc.fai ();
> +  HANDLE h =3D get_stat_handle ();      /* Should always be pc.handle().=
 */
> +  pfile_all_information pfai =3D pc.fai ();

This lower-casing PFILE_ALL_INFORMATION looks like a typo.  Other than
that the patch looks ok.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--DvifzEOEABd5jzbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl40FCsACgkQ9TYGna5E
T6AhAQ/+O+eiBj3TC+IBQZ+WAoJtmhuQFqGAwPQfP14wlDziN35oOsu0ZS5tavTx
2yfUP9vg+dlNt3pQUzY38XCJ6C1abbLkw0tiWoWuFw87/9TIZEBeRLwQHqzklYGy
MF8YIiL//rshTxmsWP9rsWmbdu5Xji9PSXKK/9EPtSEtW8EC8yJWzt1qZAs4xduC
6z1OdU1hg1eZY1Sh+6Q9vyKqaFIGsjnrooKDgi/OFmXxE8RBJnI0d4x8Wr5rp4N+
0X5G0af0jdM4fohRXtdJ5Kp9IZQgEj31sRbuPN+jebsfAWD4RQnCr17g2wuiRKg7
UmlUCEaBa7nkluqva8jYInzeRFF/n1ER6I+eJ7m1zPCgQKh7Q2pWS2d145+tmxDQ
WDeo5zwSYSQ384AUUxSlfH/T0XO6shyuzO3mctPTz1yAHNQFSx49yNHC59PQ8dNe
ueYjKHkHfQpFEIXj15weSShB2QFXSr10Ft52PpNpETD0eSHuUT0D9MkwVBmSkE4d
ZayXOBLwknTiAlTf6rlQQziTVBMbyimlXOgVAXZMl9q92N2VqBqLF/+bKMlOTxYi
pmBuv2Unbjk4+9Rj6/b6FpOSNSNmH54ozSJFQePr1iTN1mThbnBOlLNBaZ31WPyT
Eghr23Pk7xdgCWSzuPgidkd89G0VXkwehLGq//3XL4yi6KA3Vd0=
=5fms
-----END PGP SIGNATURE-----

--DvifzEOEABd5jzbd--
