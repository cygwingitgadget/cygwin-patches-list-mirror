Return-Path: <cygwin-patches-return-9079-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54905 invoked by alias); 5 Jun 2018 09:55:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54886 invoked by uid 89); 5 Jun 2018 09:55:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jun 2018 09:55:49 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LyfeV-1gK2ey0GRj-0167X6 for <cygwin-patches@cygwin.com>; Tue, 05 Jun 2018 11:55:47 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9BD75A80648; Tue,  5 Jun 2018 11:55:46 +0200 (CEST)
Date: Tue, 05 Jun 2018 09:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: Remove workaround in environ.cc
Message-ID: <20180605095546.GD17401@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180604193607.17088-1-kbrown@cornell.edu> <20180604193607.17088-5-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <20180604193607.17088-5-kbrown@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00036.txt.bz2


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1594

On Jun  4 15:36, Ken Brown wrote:
> Commit ebd645e on 2001-10-03 made environ.cc:_addenv() add unneeded
> space at the end of the environment block to "work around problems
> with some buggy applications."  This clutters the code and is
> presumably no longer needed.
> ---
>  winsup/cygwin/environ.cc | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
> index 3676bd9ea..7cdeded08 100644
> --- a/winsup/cygwin/environ.cc
> +++ b/winsup/cygwin/environ.cc
> @@ -591,13 +591,11 @@ _addenv (const char *name, const char *value, int o=
verwrite)
>      {				/* Create new slot. */
>        int sz =3D envsize (cur_environ ());
>=20=20
> -      /* If sz =3D=3D 0, we need two new slots, one for the terminating =
NULL.
> -	 But we add two slots in all cases, as has been done since
> -	 2001-10-03 (commit ebd645e) to "work around problems with
> -	 some buggy applications." */
> -      int allocsz =3D (sz + 2) * sizeof (char *);
> +      /* If sz =3D=3D 0, we need two slots, one for the terminating NULL=
. */
> +      int newsz =3D sz =3D=3D 0 ? 2 : sz + 1;
> +      int allocsz =3D newsz * sizeof (char *);
>=20=20
> -      offset =3D sz =3D=3D 0 ? 0 : sz - 1;
> +      offset =3D newsz - 2;
>=20=20
>        /* Allocate space for additional element. */
>        if (cur_environ () =3D=3D lastenviron)
> --=20
> 2.17.0

Huh!  What I said.  Thanks!


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsWXiIACgkQ9TYGna5E
T6CunA/9HfJDs2Kzj2KgbDGbpi/S8KvRmDXnF7JYl9LlnGenO49G/IAHEZLbzP7c
g1g6tGB6Jt8kpn0hBV4tDzGD6VeKFjZCY1OKzyK0lhTtvmH3n6Q2qL1799iaPxDZ
pX089ygY6vIZ7699EfJIJ37RiwgzWMHSCWXXitXzJbjLhHHKJa6N1XrWrGN6xuPg
qdaJYVh1LjvGMr8ICpmaI9+NlPEwkBiYuC0iP/nvP7CMJ1AcedtrEQvluhB5R8ec
Tje8CknKc8KXOJftYUG6ERCg/yvZ7I1rIe8j8kFz/gLsg9Hv0O2MMpmQ6X+yq1xi
BBjaKxtrFKUJmrHZBjs7Pf4/qNN+FrHqTeYmQZHe1GavX8BrJXKcB4aPBTbn7WQW
txmGg38BXO4tcbo2reUNxbd5B5mAA77FQzkgastf1eUq95P2UbSIVpGtHxLDxPwJ
xlwqrkzXuNGGt54CqABs/SK2DvYIEEvk5ywLNx7Gs1p+wdFQliWpCminr8Ffg9Ez
vANuWyAQds7H6AYkb7CtmHG3YS4qpXh87U4j1XB4iC9HOQcUzOCEvGul/xxFTOjP
al3txl9n4X3BNbN+t/W1rCeQFkkFPe0oqpyOVXpzAIX++J9dDNcX6FApkpUrkD/M
xmqrLWnzfxKScWt4uKZR6R1I9e8veJA1aZPopyWwEKoJc1lYVe8=
=ByXR
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
