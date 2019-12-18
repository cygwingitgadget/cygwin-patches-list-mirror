Return-Path: <cygwin-patches-return-9868-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88520 invoked by alias); 18 Dec 2019 19:25:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88509 invoked by uid 89); 18 Dec 2019 19:25:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Dec 2019 19:25:19 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M6DnM-1ib2AO2uHg-006fyE for <cygwin-patches@cygwin.com>; Wed, 18 Dec 2019 20:25:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2684CA806E3; Wed, 18 Dec 2019 20:25:16 +0100 (CET)
Date: Wed, 18 Dec 2019 19:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix a bug regarding ESC[?3h and ESC[?3l handling.
Message-ID: <20191218192516.GO10310@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191218160733.2084-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="lYjFa3qL1bvncypl"
Content-Disposition: inline
In-Reply-To: <20191218160733.2084-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2019-q4/txt/msg00139.txt.bz2


--lYjFa3qL1bvncypl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1469

On Dec 19 01:07, Takashi Yano wrote:
> - Midnight commander (mc) does not work after the commit
>   1626569222066ee601f6c41b29efcc95202674b7 as reported in
>   https://www.cygwin.com/ml/cygwin/2019-12/msg00173.html.
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 1d344c7fe..8c3a6e72e 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1262,16 +1262,19 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (co=
nst char *ptr, size_t len)
>    while ((p0 =3D (char *) memmem (p0, nlen - (p0 - buf), "\033[?", 3)))
>      {
>        p0 +=3D 3;
> -      while (p0 < buf + nlen && *p0 !=3D 'h' && *p0 !=3D 'l')
> +      bool exist_arg_3 =3D false;
> +      while (p0 < buf + nlen && !isalpha (*p0))
>  	{
>  	  int arg =3D 0;
>  	  while (p0 < buf + nlen && isdigit (*p0))
>  	    arg =3D arg * 10 + (*p0 ++) - '0';
>  	  if (arg =3D=3D 3)
> -	    get_ttyp ()->need_redraw_screen =3D true;
> +	    exist_arg_3 =3D true;
>  	  if (p0 < buf + nlen && *p0 =3D=3D ';')
>  	    p0 ++;
>  	}
> +      if (p0 < buf + nlen && exist_arg_3 && (*p0 =3D=3D 'h' || *p0 =3D=
=3D 'l'))
> +	get_ttyp ()->need_redraw_screen =3D true;
>        p0 ++;
>        if (p0 >=3D buf + nlen)
>  	break;
> --=20
> 2.21.0

Pushed, thanks.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--lYjFa3qL1bvncypl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl36fRsACgkQ9TYGna5E
T6AoKQ/+JTAm/hq1bcNoaR7VARRJxjJ0uZXGm19BRVbISk7PZv8D9ekd8Bs3dqPp
Zj//rp0PMwePF0iD/RE/pL8rgJS1zguiB4MvpHBoJLN3KkQsYmkLpPKMyZwiRBi7
RxzdSM4tmp7FyyDH9UKi7zEu1yNwM6B7sHiD/GSKPbDqJGHso6H1gAzcmJBcdCmO
blVXSuWtNRVhlnFSxuB2m1P8Sq2n/B+/QVJIECi2636RJ0WAbsFefmYaBaLE/Q2i
nxshRVRzs3oLCZh1+7r4vsYJwUoMln5VoNfNncon846LYS6G/gM2AejbOy0e/kw5
vWKr1XBC6nluT7tTH4K13J2MzudrZsdcRVlxxCgDBqs0HVpKDOVBw5IkVW11Qsvq
qh6/n8hVsrBMV6OykatkDb12E/aRJsDvK45SBbPiFbfqsgPb62BunTAOslpkmHtm
MvAnnq/ffd4ujQF6W5Py7KNZfPKoyMLaWB7JN8RsZBxeOImdzX/arHMxmxKceJcz
NlYJ+3hXdgfMmWgCSrcKsTftnpwk9BIZJrZsm9qetlufLOkO0Gf4n+dCqf/QexPE
/lG/Kckaej+frhjrKwEz5um8fc2kjcmwXqFtc/NxR4Pll7DeZN/XoWS1Riulx6kN
kPpazrQgSJz9WP8okixf0MlmDiUL/7CkkwhLVB99AQvyg1mshe8=
=lPnQ
-----END PGP SIGNATURE-----

--lYjFa3qL1bvncypl--
