Return-Path: <cygwin-patches-return-9908-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52364 invoked by alias); 13 Jan 2020 15:31:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52355 invoked by uid 89); 13 Jan 2020 15:31:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=2698, sk:fhandle, HX-Languages-Length:1322, edition
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 15:31:55 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MQuwR-1j426p2C0t-00Nxku for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 16:31:52 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 38D44A806B2; Mon, 13 Jan 2020 16:31:52 +0100 (CET)
Date: Mon, 13 Jan 2020 15:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_socket::open: support the O_PATH flag
Message-ID: <20200113153152.GF5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191226152524.10816-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20191226152524.10816-1-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00014.txt


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1309

Hi Ken,

On Dec 26 15:25, Ken Brown wrote:
> If that flag is not set, fail with EOPNOTSUPP instead of ENXIO.  This
> is consistent with POSIX, starting with the 2016 edition.  Earlier
> editions were silent on this issue.
> ---
>  winsup/cygwin/fhandler_socket.cc | 13 +++++++++++--
>  winsup/cygwin/release/3.1.3      |  5 +++++
>  winsup/doc/new-features.xml      |  5 +++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
>  create mode 100644 winsup/cygwin/release/3.1.3
>=20
> diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_so=
cket.cc
> index 9f33d8087..4a46d5a64 100644
> --- a/winsup/cygwin/fhandler_socket.cc
> +++ b/winsup/cygwin/fhandler_socket.cc
> @@ -269,8 +269,17 @@ fhandler_socket::fcntl (int cmd, intptr_t arg)
>  int
>  fhandler_socket::open (int flags, mode_t mode)
>  {
> -  set_errno (ENXIO);
> -  return 0;
> +  /* We don't support opening sockets unless O_PATH is specified. */
> +  if (!(flags & O_PATH))
> +    {
> +      set_errno (EOPNOTSUPP);
> +      return 0;
> +    }
> +
> +  query_open (query_read_attributes);
> +  nohandle (true);
> +  set_flags (flags);

Shouldn't that only work with AF_LOCAL/AF_UNIX sockets?  This looks
like it will return a valid descriptor even for IP sockets.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cjWgACgkQ9TYGna5E
T6A84BAAgF/cscKG4nT+IVDSZoUUJi49MIR5R/yKDEXd8eQSKp5Ljonp5wNmYDhl
vVY3VNr+YzJEz9PL7/9spBvscClTCewy/T6g866WRGB48z8aaDwZd+FWC21kLUyP
Kh9qmo8ss7ivuASfQ3k0wn1dr8rtEXjaDUB451pXe6u09wHwVUoM+cyGdIs+EBH8
AIgGJEZHAsU+ldsv8SQbwmXkCwP71HQ5ruNLa/6v5SOanZo7HldK2g4S4Xel6vNR
K3BPMHTMze4NaotkE+Y/kn791kcx3m2vVWd/f9mAqUYAY2e5+xxDJUdFMi6nlXox
b9r96BJxCdhEg9jF+zINUw8Rz/3M+daVdQ5Q2elv8PukuA8MaQSNSGLOcl5eVaOm
HDD/79QJVb2QpMgJVRQaS16HS2ONIK+11r8MGJZAJpe0QN2RfNRSyMPJAHwJmZyS
DLh2MndVCuytxCk9aGl8/a1GW2NzlJdub3fk2vfwP8gZRXcNPmGDfL6nHtY9byPH
GyMG7KLazBO6J9/lDcXNjgBnAeZznu4NRLoSUvIt8GIYdO9uOdvG8ERnkv5mCjL3
OBuPWxjlKUumIGpbC9ejxN5l8ECtPgLrcEqeUCUjMsAu3k1vt3M+RY0KCwyiasvs
uC8SkqoH+le2chKQVDAqYKaomYG3dD2CZhKh7Sq8EGCm+si+VoI=
=JM5Z
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
