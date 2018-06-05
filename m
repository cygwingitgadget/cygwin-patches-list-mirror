Return-Path: <cygwin-patches-return-9077-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123051 invoked by alias); 5 Jun 2018 09:53:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121691 invoked by uid 89); 5 Jun 2018 09:53:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=hood, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jun 2018 09:52:59 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id 0M3wRS-1gGSLq3eLa-00rZdw for <cygwin-patches@cygwin.com>; Tue, 05 Jun 2018 11:52:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0B406A8195B; Tue,  5 Jun 2018 11:52:56 +0200 (CEST)
Date: Tue, 05 Jun 2018 09:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Implement clearenv
Message-ID: <20180605095256.GB17401@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180604193607.17088-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20180604193607.17088-1-kbrown@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00034.txt.bz2


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1042

Hi Ken,

On Jun  4 15:36, Ken Brown wrote:
> This is a followup to https://cygwin.com/ml/cygwin/2018-05/msg00334.html.
>=20
> In this patch series I attempt to implement the glibc extension
> clearenv().  I also implement glibc's notion of environ=3D=3DNULL being
> shorthand for an empty environment.
>=20
> Two questions:
>=20
> 1. I haven't yet absorbed what SIGFE means.  I arbitrarily decorated
>    clearenv with SIGFE rather than NOSIGFE in common.din, but I don't
>    know if that's right.

In a sloppy nutshell, SIGFE is for all Cygwin function calls which may
call Windows functions under the hood.  Anything which may take time.
I.e., simple math functions or getpid(), basically immediately returning
to the caller are NOSIGFE, more complex functions are SIGFE.
SIGFE functions have a special function wrapper allowing to call
a signal handler after the function returns.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsWXXcACgkQ9TYGna5E
T6CM2w//Zxocw7DyiYef9EKQOCBgNb462IV8xXUqPTTbXoOjKz8XTbi3g5c3vH0I
FVTuEHoyBDpiVe/cu/s6FjFUvNDIen+ANrgGp9g4IgXvDiwf4eXQhM1BQLvUt5Ux
ELUs/l19a7W4Aii01BuO/EFaVhm9JOfbOQcgmRjsZIZADpJ9uHDKW6XrQFHApvx/
06hdB7vglLmM9lpDDKksLpeY9TR0a6JfVujsDClZg9x6AyM+iwAXIOw4V4Qgkk7i
HcpxH2EtKj2pAtAgRZKbXm3fEmmda0ENHc2YkWoVCpNHk0g3aw3tNMdR7ddK4o8m
I6X8IwkQmfzcUPgdiW5L7phhmF5Cfdsqt9uBEGQ+sCHw9cmJmfZkOg6oUUmLFLUQ
wZwlv83TXGfbN3hbBP5eGp6wkhc6Nqdu8jsNcyv/1u2+/0FInEZOto9CkBWqPMNq
VaA7nwl6QlSdi2eU13u36Awos+XL71d7QLdfeNnoU16wxyR9XglOVqWGY98MiXRw
CtxEVcZrOM+bpaDoJs9G4uG9J6tLR6cP8791/uyHUPs9vGHzZW4aXNGh4R0AbM30
f0Qc7Ssr9rJ2quwVEbbgc0I5v5uDsKK4eWQLJ+KUZ8Slh6i9Wi4zPVYBj3UwKPF9
cXVPwf6Cl4/vOnKdFeukEo/1pmWBJYuSGiD2xrfF+zpvSA2Ozmg=
=v7ow
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
