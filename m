Return-Path: <cygwin-patches-return-9574-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81179 invoked by alias); 15 Aug 2019 08:09:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81169 invoked by uid 89); 15 Aug 2019 08:09:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HTo:U*mark, H*c:HHH
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 15 Aug 2019 08:09:36 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MjSDU-1ij6Du1fnm-00kv2S; Thu, 15 Aug 2019 10:08:36 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 06E0DA807B3; Thu, 15 Aug 2019 10:08:33 +0200 (CEST)
Date: Thu, 15 Aug 2019 08:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: ldd: Try harder to get dll names
Message-ID: <20190815080832.GJ11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20190815055943.31661-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DrGmS0+Jkf65/BeF"
Content-Disposition: inline
In-Reply-To: <20190815055943.31661-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00094.txt.bz2


--DrGmS0+Jkf65/BeF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 515

On Aug 14 22:59, Mark Geisert wrote:
> Borrow a trick from strace to lessen occurrences of "??? =3D> ???" in ldd
> output.  Specifically, if the module name isn't found in the usual place
> in the mapped image, use the file handle we have to look up the name.
>=20
> ---
>  winsup/utils/Makefile.in |  2 +-
>  winsup/utils/ldd.cc      | 44 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 2 deletions(-)

Great idea, pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--DrGmS0+Jkf65/BeF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1VEwAACgkQ9TYGna5E
T6BR/g/8CpXR/KTwIHytZUH/qWK4Fugs+tDUkUZGzgS4TY2H4jMQV87YK3WD+oiV
y0Quin8w5RQHSlUSKtvipONIoxgmFCYXQOPbh5u5GAkDq/T5cQn0Mi5hAnugtjsm
vOW5RkuSgkRdukMyw6vkcVZsRsM9Yy7HQ3Zm/H56uXlhq6r8BgfR77jpL4VerDv4
/JdV68hPinp73XPG9wLGiK5vFINmV5BRG4BIB8Zt5jQJ7/vexunWxRjP66w3q9Wc
9f2uPtf8/qhtulm8xh1L+mFTM+YYOtxvbVZflfDAvZUG9Q9F7WhDepC6i38qKvu4
USEE1RkLG9cAVzEHU8e0YXMf07sw1ng8eplzfnFnlx2rLFv6AALwC+aAcrE+g84b
BfvwFfChSp28LpWZ50MvgevlBliuC44Dc/5MLfgOqYDWo1AcubNVOljhLgK2St5T
7PFCzCOyoWB3blZvPMI5zvvZ6vt6RSz84Ck79aMtEu1vHa14WKe/myZ5GFs6NKbA
hAhj16waxAE1PviFRdBUsV3Usow8GNePJoMjo814JsF7StxlP3dX9szXdoouocKb
QLhlbzSdrexPENYtLt9QCvYyQCC4FKIN3FETTinCR8tbFu4MsoKbM3F+L1RPimpJ
R8dp5J6HgAaKO8f0vwlVXV8+NP2wW3JnQ3Uu+dt93nMO8hCy0rg=
=squJ
-----END PGP SIGNATURE-----

--DrGmS0+Jkf65/BeF--
