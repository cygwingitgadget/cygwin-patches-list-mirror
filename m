Return-Path: <cygwin-patches-return-8598-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78525 invoked by alias); 14 Jul 2016 15:09:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78504 invoked by uid 89); 14 Jul 2016 15:09:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, our
X-HELO: calimero.vinschen.de
Received: from ipbcc0190b.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.25.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Jul 2016 15:09:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 14A94A80461; Thu, 14 Jul 2016 17:09:44 +0200 (CEST)
Date: Thu, 14 Jul 2016 15:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix 32-bit SSIZE_MAX
Message-ID: <20160714150944.GB21341@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1468443748-25335-1-git-send-email-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <1468443748-25335-1-git-send-email-eblake@redhat.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q3/txt/msg00006.txt.bz2


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2082

On Jul 13 15:02, Eric Blake wrote:
> POSIX requires that SSIZE_MAX have the same type as ssize_t, but
> on 32-bit, we were defining it as a long even though ssize_t
> resolves to an int.  It also requires that SSIZE_MAX be usable
> via preprocessor #if, so we can't cheat and use a cast.
>=20
> If this were newlib, I'd have had to hack _intsup.h to probe the
> qualities of size_t (via gcc's __SIZE_TYPE__), similar to how we
> already probe the qualities of int8_t and friends, then cross our
> fingers that ssize_t happens to have the same rank (most systems
> do, but POSIX permits a system where they differ such as size_t
> being long while ssize_t is int).  Unfortunately gcc gives us
> neither __SSIZE_TYPE__ nor __SSIZE_MAX__.  On the other hand, our
> limits.h is specific to cygwin, we can just shortcut to the
> correct results rather than being generic to all possible ABI.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  winsup/cygwin/include/limits.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/include/limits.h b/winsup/cygwin/include/limit=
s.h
> index 2083e3e..cf3c8d0 100644
> --- a/winsup/cygwin/include/limits.h
> +++ b/winsup/cygwin/include/limits.h
> @@ -128,9 +128,17 @@ details. */
>  #undef ULLONG_MAX
>  #define ULLONG_MAX (LLONG_MAX * 2ULL + 1)
>=20
> -/* Maximum size of ssize_t */
> +/* Maximum size of ssize_t. Sadly, gcc doesn't give us __SSIZE_MAX__
> +   the way it does for __SIZE_MAX__.  On the other hand, we happen to
> +   know that for Cygwin, ssize_t is 'int' on 32-bit and 'long' on
> +   64-bit, and this particular header is specific to Cygwin, so we
> +   don't have to jump through hoops. */
>  #undef SSIZE_MAX
> +#if __WORDSIZE =3D=3D 64
>  #define SSIZE_MAX (__LONG_MAX__)
> +#else
> +#define SSIZE_MAX (__INT_MAX__)
> +#endif
>=20
>=20
>  /* Runtime Invariant Values */

Looks good, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXh6s3AAoJEPU2Bp2uRE+gMdwP/2rgm4sEIfxOp0MqjIQDLRxF
E2phjLOKjmu37jQiSw7V4LWPpLYbSOFV0w1CjS9PgywMNDjl/4fs2Co6rMXbpMEL
ZQ37zrl/KuXJQZeQ+5l82jPCjP/eaugkfgHTxZ1EWDZ5qEaA3SjSIdB8RyVSEykg
OgzZclndpZQAep4E4BcnsN3MbDXJDq866uCeKeprORc0Q6hwp2QRozg8Ldwv3NEX
ibNHkKwDXuqV92nbG5wIuUb3vUGbpl0a+gSiNBXS5ca9Pkdj6pDragmo3RzvfiVI
e2/AKEx76sWv2umOT4zbCNSUXtBHJ/vbLWhw3RHz9lkGxT802uQq25it14zNvHzV
g+GEPeg7OU1BLXGQ9C5DiDmnlLmQl42XbsAXCDqg7EggysV9cqnumCxGX5LgcebK
EEm9QmFzBYvUxImV+wUSnuz35sbqXke04INZMK4EesJZjf+81r3NYpNUCall3pAs
akW/0fofZdQgqOCV3sBy/+iox94fyx/mn+ffyh/H8Qzmh/FH9p/4bi837GIKO2VF
q7SPuju6zkdXKYkb7sg0QTKSN54Y8MsO0h+13ZQjsl460+jY9R/7z6gI1gZ8V0i+
6vKSnySro74o6dqFi2W6ss9Q35MuabQQinUJ5eBs5HNdWLgyjSRC1X4sv3j7YahK
pD9zbTu1PK1sDLdXsvlt
=TneN
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
