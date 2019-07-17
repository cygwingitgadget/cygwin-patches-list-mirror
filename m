Return-Path: <cygwin-patches-return-9489-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22691 invoked by alias); 17 Jul 2019 13:51:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22682 invoked by uid 89); 17 Jul 2019 13:51:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jul 2019 13:51:22 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MowbA-1iEoh41u7q-00qVik for <cygwin-patches@cygwin.com>; Wed, 17 Jul 2019 15:51:20 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EE783A806DE; Wed, 17 Jul 2019 15:51:19 +0200 (CEST)
Date: Wed, 17 Jul 2019 13:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Port to GCC 8.3
Message-ID: <20190717135119.GN3772@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190716173407.17040-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
In-Reply-To: <20190716173407.17040-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00009.txt.bz2


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1248

On Jul 16 17:34, Ken Brown wrote:
> This patch series tries to fix all the warnings (which are treated as
> errors) when building Cygwin with GCC 8.3.  I'm not confident that
> I've chosen the best way to fix each warning.  All I can say is that
> the build now succeeds.
>=20
> Ken Brown (5):
>   Cygwin: avoid GCC 8.3 errors with -Werror=3Dclass-memaccess
>   Cygwin: avoid GCC 8.3 errors with -Werror=3Dstringop-truncation
>   Cygwin: suppress GCC 8.3 errors with -Warray-bounds
>   Cygwin: fix GCC 8.3 'asm volatile' errors
>   Cygwin: fix GCC 8.3 'local external declaration errors'
>=20
>  winsup/cygserver/bsd_mutex.cc    | 5 ++---
>  winsup/cygwin/environ.cc         | 2 +-
>  winsup/cygwin/flock.cc           | 2 +-
>  winsup/cygwin/include/sys/utmp.h | 6 +++---
>  winsup/cygwin/miscfuncs.cc       | 4 ++--
>  winsup/cygwin/path.cc            | 4 ++--
>  winsup/cygwin/path.h             | 2 +-
>  winsup/cygwin/pinfo.cc           | 4 ++--
>  winsup/cygwin/uname.cc           | 2 +-
>  winsup/utils/dumper.cc           | 2 ++
>  10 files changed, 17 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.21.0

ACK to the series with just a short description in terms of asm volatile.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0vJ9cACgkQ9TYGna5E
T6DMQA/6A6H8BuMlacgp3qkbsufx59bIduJbipeZtd10F8yuS28wv5EwUpdM0UYN
RqhkCwOEN2RRrxCh5vemDvB3SGw2wD60IS1latRMVjkj6wrP8K3Jxj4Rbt2C3Fv0
7gP65OYeK5/hEQeH7K+rCCSbVv/TQqg2NW0+hVcetrpswcSR6P3Hq/3hh56TB1J2
9QwYW3GIwUKbOJheHhIGN2Z0TTbZMDyvQBg6KVCe1HIkyTP/ZaZ23ZPvRBTDc7JS
mZ0yvvcEBN5GmOvMl8WoNU7F/UOIjsqfen7VQb1rY3IZwrBYjfQ/qNg4k9Z9y4Pd
jPh4wzCLwBKn+pjBe4Sch5F9qLHRFlPzMWMZ7QHJcV83YsaJS8c4HGzIZAhFAOG2
y16S/iiM+A1NmVayqKPpZmWq1SbprAS/9TzQ/s0jZK7DmSe1seRnOCNFn6MYsyl3
Wk8tLXnVmg3y3BH4ahwoy1ve0UGkwaj0Ync2fw7IlwjOWFDjxIibr11dRGr9dQ31
0bOgEkpR/KaYSra3sxOj0G0cnswqfgV0iXUMRg7fZ3CIIWGpbNG/Gk7tT5eQ6ds6
3Nqhn2jG0p2LCdXCH2LwA90eqTx2/njvt9cFIeREDT54rNzSe3uKgA3MlC8M4mZK
7K5b3a23CkGIuquEghTA7zoqYY33bL6w5tXHeDHt8Z0kvvDfXIg=
=AfhE
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
