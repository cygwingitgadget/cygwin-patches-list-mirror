Return-Path: <cygwin-patches-return-10033-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38641 invoked by alias); 29 Jan 2020 20:58:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38631 invoked by uid 89); 29 Jan 2020 20:58:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 20:58:33 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Ml6i2-1jQRnm2pzg-00lYWN for <cygwin-patches@cygwin.com>; Wed, 29 Jan 2020 21:58:30 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DFCFBA80BDF; Wed, 29 Jan 2020 21:58:29 +0100 (CET)
Date: Wed, 29 Jan 2020 20:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: AF_LOCAL: fix fcntl and dup if O_PATH is set
Message-ID: <20200129205829.GT3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200129172147.1566-1-kbrown@cornell.edu> <20200129172147.1566-5-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jcwRHPSxFqmwpRFb"
Content-Disposition: inline
In-Reply-To: <20200129172147.1566-5-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00139.txt


--jcwRHPSxFqmwpRFb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2353

On Jan 29 17:22, Ken Brown wrote:
> For fcntl this requires a new method, fhandler_socket_local::fcntl,
> which calls fhandler_base::fcntl if O_PATH is set and
> fhandler_socket_wsock::fcntl otherwise.

The patchset looks great.  Please apply with just a minor change:

Can you please add a hint why using fhandler_base::dup and
fhandler_base::fcntl is sufficient, despite fhandler_disk_file has its
own methods?  It's clear from looking at those functions, but a quick
description in the commit message and a one-line comment each in the
source might be helpful when debugging at one point.


Thanks,
Corinna


> ---
>  winsup/cygwin/fhandler.h               |  1 +
>  winsup/cygwin/fhandler_socket_local.cc | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index c54780ef6..1b477f633 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -836,6 +836,7 @@ class fhandler_socket_local: public fhandler_socket_w=
sock
>=20=20
>    int open (int flags, mode_t mode =3D 0);
>    int close ();
> +  int fcntl (int cmd, intptr_t);
>    int __reg2 fstat (struct stat *buf);
>    int __reg2 fstatvfs (struct statvfs *buf);
>    int __reg1 fchmod (mode_t newmode);
> diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhand=
ler_socket_local.cc
> index 76815a611..531f574b0 100644
> --- a/winsup/cygwin/fhandler_socket_local.cc
> +++ b/winsup/cygwin/fhandler_socket_local.cc
> @@ -628,6 +628,9 @@ fhandler_socket_local::af_local_set_secret (char *buf)
>  int
>  fhandler_socket_local::dup (fhandler_base *child, int flags)
>  {
> +  if (get_flags () & O_PATH)
> +    return fhandler_base::dup (child, flags);
> +
>    fhandler_socket_local *fhs =3D (fhandler_socket_local *) child;
>    fhs->set_sun_path (get_sun_path ());
>    fhs->set_peer_sun_path (get_peer_sun_path ());
> @@ -654,6 +657,15 @@ fhandler_socket_local::close ()
>      return fhandler_socket_wsock::close ();
>  }
>=20=20
> +int
> +fhandler_socket_local::fcntl (int cmd, intptr_t arg)
> +{
> +  if (get_flags () & O_PATH)
> +    return fhandler_base::fcntl (cmd, arg);
> +  else
> +    return fhandler_socket_wsock::fcntl (cmd, arg);
> +}
> +
>  int __reg2
>  fhandler_socket_local::fstat (struct stat *buf)
>  {
> --=20
> 2.21.0

--=20
Corinna Vinschen
Cygwin Maintainer

--jcwRHPSxFqmwpRFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4x8fUACgkQ9TYGna5E
T6B7qw//d2cOZjuhJLg2j4vufcRvJGIBa2RtKRgItkr2/b4L53DUaWuqulCP0h0Q
/jnBt/J8gHfn9EhXuNgwhRorBK8ZT+bTLvBFKo7OK3J4x/U5RXVtsRXN+bFl7sJP
0m8ETrP9qTBOGkMqWdOJ3id3pJeH8zIPMW+Tl25hDl2fWuS5NjCuGPQsLg6d1D/O
WrHDQuxAJvQ7LGv7NffVyEXZAUUuXH1LALsWD0V+LgAWnTBK90jFNORaiMEZ9LTO
4DkJFyc3TPpwuh1bFQjLysMUe/luIRqJM+mLTvr3OnRP+EqrVQJXQPvsptiaSO04
j17HNaFf2XU51GwrRn/5sM7PL9muSNxvkD7Wq5yxUX4Y5aBIbJxeolIIAMACC6X0
zPZ9Hz7MjbhZkGNld/922/vPbLYR7UHvEvTWzaGmnjNFRlEmAfitbDh1oUUviUR8
+QN93rMkWtavkkVE9qR3IuPlp+OVw/L/BVkL3DAE6P1X3Wmr0l+fcpDj/rwbd2L9
/CnWoQGlCPFu7jZ/tBokZXpn69CK1CSGhdzEAK91Ncuuijf6hNp8Ug/WDg4yEtHF
98XaWKEVw9Z0c1oxChnD/44HdD57KcO42ijGYGU7awfRuVIVUjgrn2E2TWpuOGiz
AH2sGZkzZpD/31jKJy8O7GYw1dyuWlbFo56/T2SV9YOgQpsr07w=
=Naer
-----END PGP SIGNATURE-----

--jcwRHPSxFqmwpRFb--
