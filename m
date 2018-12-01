Return-Path: <cygwin-patches-return-9188-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63286 invoked by alias); 1 Dec 2018 14:16:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63244 invoked by uid 89); 1 Dec 2018 14:16:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-125.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*MI:sk:2018120, H*i:sk:2018120, H*Ad:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 01 Dec 2018 14:16:16 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N1fzM-1hUrmo0KEq-0120yC for <cygwin-patches@cygwin.com>; Sat, 01 Dec 2018 15:16:14 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 63104A803A9; Sat,  1 Dec 2018 15:16:13 +0100 (CET)
Date: Sat, 01 Dec 2018 14:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix version typo
Message-ID: <20181201141613.GQ30649@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20181201061400.4244-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Ix2jQZQ3wXOip0b1"
Content-Disposition: inline
In-Reply-To: <20181201061400.4244-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q4/txt/msg00004.txt.bz2


--Ix2jQZQ3wXOip0b1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 725

On Nov 30 22:14, Mark Geisert wrote:
> ---
>  winsup/doc/new-features.xml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
> index e3786e545..7cc449764 100644
> --- a/winsup/doc/new-features.xml
> +++ b/winsup/doc/new-features.xml
> @@ -4,7 +4,7 @@
>=20=20
>  <sect1 id=3D"ov-new"><title>What's new and what changed in Cygwin</title>
>=20=20
> -<sect2 id=3D"ov-new2.11"><title>What's new and what changed in 2.12</tit=
le>
> +<sect2 id=3D"ov-new2.12"><title>What's new and what changed in 2.12</tit=
le>
>=20=20
>  <itemizedlist mark=3D"bullet">
>=20=20
> --=20
> 2.17.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Ix2jQZQ3wXOip0b1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlwCl60ACgkQ9TYGna5E
T6B8VQ//Z2MdM6HK78U9spREij5HGSRPvrg0Crbe9alLhkl5AQa0p0cXQNa8oqwv
T+w/DgoP3yPCp00UVmems6Kscz6y8PYEz6BPYVqrlrVt0uLmFWlO/Due5GzYkmQB
jzVOmVWNafqiz2O3tu+bbjXZDZnCoTYPZNIhAbS/Y1myQKWISGIEdcJrzgj2tBK9
VmlSDJox71HyqYX7IvyUv4pVfioAcdDZLZlGe6zaB0awEPoTMAT30lNEauGwIo1k
9r/GYzJJXEaaE9iMTUaXDIbCtmDNize8jTOMhXHGzL+dk7IVrOWcyY7as5CirYNj
cI2VGE6QF1u9XWk4gNjKcCBCX+kYJ+sMo04qjrKmOYS5NRYI5DP4pa/0JL9y/1wO
WqYGBbM/PmnzIXKQHdvwQgUGhWZ3eKk+p8wq1N8pVPckNr9M/8iaKKrOC4KAsbRX
4CIQLRwYIyQKhYZzi6bNrU5n+z+8wSb5g83oCOLDHM6v954o5M+pGNOzgQdoAlA2
v0dNQ4RRXUBXo/58ovX+hFIOaR9gKVtOkY6ZEPlLQTTkB5mDqUQFLtewbNEJgCJ2
knb9keelMjMgT67KI8zjKb56unYsVptqPIasWwNJS7TXxv9u5W3588BhnhGIrbAY
Ut2tuBfvjI2ki+pgHcdi49I4+zyeNLdrSf1vq5ZH5yF1m3aMboY=
=hmig
-----END PGP SIGNATURE-----

--Ix2jQZQ3wXOip0b1--
