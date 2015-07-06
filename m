Return-Path: <cygwin-patches-return-8225-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21977 invoked by alias); 6 Jul 2015 20:02:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21966 invoked by uid 89); 6 Jul 2015 20:02:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 Jul 2015 20:02:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 530B2A80975; Mon,  6 Jul 2015 22:02:10 +0200 (CEST)
Date: Mon, 06 Jul 2015 20:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/cygwin: fix compile of path.cc after basename changes
Message-ID: <20150706200210.GX2918@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1436206232-9776-1-git-send-email-yselkowi@redhat.com> <1436211686-9256-1-git-send-email-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="QFO1zB2dwAkGraMW"
Content-Disposition: inline
In-Reply-To: <1436211686-9256-1-git-send-email-yselkowi@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00007.txt.bz2


--QFO1zB2dwAkGraMW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 836

On Jul  6 14:41, Yaakov Selkowitz wrote:
> ---
>  winsup/cygwin/path.cc | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 446d746..5eb076f 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -48,7 +48,7 @@
>       c: means c:\.
>    */
>=20=20
> -#define _BASENAME_DEFINED
> +#define basename basename

As part of the sources, this define needs an informative comment,
describing why it's necessary.  Ideally not in just three words
following on the same line but in full english preceeding the #define
line.  With such a comment and a ChangeLog entry, patch is ok.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--QFO1zB2dwAkGraMW
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVmt7CAAoJEPU2Bp2uRE+gGckQAI4JfW907UhfpgJkgVh4lYDN
GzDQ2pFoDtXXRwLJS5fKekjyfqAhmmxTokwA0oVEyVuR++mHpPb7EInYfk6H1LA5
SzjX25+114rWEEVWvGPgeiLRzvCYGunrc4Ura89Hcy5SbysDrbjTlB6SNvYqqMc/
UfRvn2EhjyvxF1cHiU9FON3OqxOxxz9nhMvRUD+mUmIhYP20WNDuy2nxrIdqPwbU
2YEBLUWQ93sUF8MWLOzeX6RoKYVIkxYbI+km4tIFFc+WCaZ4XuMaO+KZew3rk1Hd
h9X/Ca47ujRsy+De4EdcyY5cYE7lIPul7BtspRlJ2YosHrTNCY6PSK/gj3IOUYC4
ASJwMLoDMi+BgekAoW+Y3NrLcsuXF8TxTaFjY9Q4C6Qvm0fpQyehpGjeYJ/IhL5S
VNwXiDSPWHZHaGX8XmT22Fu+nn9D422svgn3jb2vXtOkTvVOX8tT2MldDc9q+jS5
JWXextyaMArW+jUOBB3mITqVHMwC77y8oVdHNCi8nAJjHlxt3b87xIXQWiZcyKI0
ZvE9oLOGXgtAirjAgDvArL8hWNrEeUoQTEY5xfdBZBuY1eDApr4IzhZFLNGafqqG
z+WXjobRGz8RsZvd4+fdV9KVpBT+4x99F1bTjtgyu54eStHBgyJ0NiYSqsVHkBz9
EjnbXw/nThKL3xopiVsG
=Em5f
-----END PGP SIGNATURE-----

--QFO1zB2dwAkGraMW--
