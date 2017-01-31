Return-Path: <cygwin-patches-return-8689-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107540 invoked by alias); 31 Jan 2017 08:48:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107522 invoked by uid 89); 31 Jan 2017 08:48:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-99.7 required=5.0 tests=BAYES_20,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=D*dronecode.org.uk, U*jon.turney, jonturneydronecodeorguk, jon.turney@dronecode.org.uk
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Jan 2017 08:48:42 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 02262721E281E	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2017 09:48:39 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id BD6DF5E0478	for <cygwin-patches@cygwin.com>; Tue, 31 Jan 2017 09:48:35 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A0B42A8040C; Tue, 31 Jan 2017 09:48:35 +0100 (CET)
Date: Tue, 31 Jan 2017 08:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygcheck -p's handling of '+'
Message-ID: <20170131084835.GA14713@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170130153720.209696-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20170130153720.209696-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00030.txt.bz2


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1205

On Jan 30 15:37, Jon Turney wrote:
> The form data sent to the server should be application/x-www-form-urlenco=
ded
>=20
> This replaces spaces with '+' before being RFC 11738 encoded, so a literal
> '+' must be %-encoded also.
>=20
> See https://cygwin.com/ml/cygwin/2014-01/msg00287.html et seq.
>=20
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>  winsup/utils/cygcheck.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/utils/cygcheck.cc b/winsup/utils/cygcheck.cc
> index d1e27b7..e745b20 100644
> --- a/winsup/utils/cygcheck.cc
> +++ b/winsup/utils/cygcheck.cc
> @@ -2009,8 +2009,8 @@ check_keys ()
>    return 0;
>  }
>=20=20
> -/* RFC1738 says that these do not need to be escaped.  */
> -static const char safe_chars[] =3D "$-_.+!*'(),";
> +/* These do not need to be escaped in application/x-www-form-urlencoded =
*/
> +static const char safe_chars[] =3D "$-_.!*'(),";
>=20=20
>  /* the URL to query.  */
>  static const char base_url[] =3D
> --=20
> 2.8.3

Thanks, please apply.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkE9jAAoJEPU2Bp2uRE+g4MsP/11qIKwQNIdg8RrDwReijAVM
mbFZUBQcnmoUhiQC8mZ0tGaE+UyXskecf/JC5A5X1WocyekD1DPrH+BzsQuQ8baB
bVZLbvuw9p4DMzZpmASe4jQsUU+i8dK6je9SkofQtOq8LtWqvuPw8jdo4BG76dKm
CTUFMDGB+BFaH9cvAyAPLT4PgZGQrjAIcIZSb1CG3rUjGInSbYwvhgywKc37ilXI
+UL0UnJ2T6mSCq3YmkSZLiYNMqraFVMWh5dJMYkb7Nteiegzo6BC/+TleEq73OOh
qhkq0Nr2Xhc++1Nv+J8KmOh2QlvXgeYtaDymC+9UHD0NcY6O6HkGjWc1a7Fv1pQO
w67GBR8DfBwnq0PDDLB6clhTSdiuMTnMTsW4oGMFiLgTE8aOW3EsUPZGuc4Ig2R0
YBgjhSP8t/+9grPO60A9syPLLDhtsbXCBpfFWnN1EXvFxwq9oOVNxMejp9DKXtbs
wrBxCrJCza5cXnwEdcM3s6UUjPbnTVgZCg8Cio686PWVCzYFo0K8+VVyEFqNJPH6
HV0/qW3WoEBfl8DnBWHlwthfSl+nkp2PTzz49C4peEhDkCEkkaAQTFEvPMBAs+jT
E4LpeBkvZSdJc+ozLDYqJzwmuNeRxrx8HWdz9hy8GYHZrzHAH9SUa+Qvg8ltRQl3
lYNgHTDFKVobdqGbf4yN
=kYag
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
