Return-Path: <cygwin-patches-return-8008-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19072 invoked by alias); 1 Aug 2014 09:56:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18972 invoked by uid 89); 1 Aug 2014 09:56:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Aug 2014 09:55:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 86E1B8E05FF; Fri,  1 Aug 2014 11:55:55 +0200 (CEST)
Date: Fri, 01 Aug 2014 09:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: namespace safety with attributes
Message-ID: <20140801095555.GA6417@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53DA69CF.3010201@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <53DA69CF.3010201@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q3/txt/msg00003.txt.bz2


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 937

On Jul 31 10:07, Eric Blake wrote:
> As pointed out here:
> https://cygwin.com/ml/cygwin/2014-07/msg00371.html
>=20
> any use of __attribute__ in a header that can be included by a user
> should be namespace-safe, by decorating the attribute arguments with __
> (while gcc does a lousy job at documenting it, ALL attributes have a __
> counterpart, precisely so that public headers can use attributes without
> risk of collision with macros belonging to user namespace).
>=20
> 2014-07-31  Eric Blake  <...>
>=20
> 	* include/pthread.h: Decorate attribute names with __, for
> 	namespace safety.
> 	* include/cygwin/core_dump.h: Likewise.
> 	* include/cygwin/cygwin_dll.h: Likewise.
> 	* include/sys/cygwin.h: Likewise.
> 	* include/sys/strace.h: Likewise.

Thanks, please apply.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT22QrAAoJEPU2Bp2uRE+gIOAP/3bIsaxkF7+xfEywK7yGa7YL
IO2BHyFJyvT5aliY6cPGlPBezzr7hwG6Ixy6+T6mABjEt4E2vOGyUyqWhwJLOM2d
mFLvjhKhGZwP3Ugaqu9IUpvbD0obTn4P2ADavwbDr/i2W4G0kWi3LfAtSB92rHeW
rUmzK6BPvb0W6grx57B9JbCiaWoc4sLGYRS4bLx4DnxdlzgbAE+keXTlXCnlS8Zk
BTZsrt8iX2yI9E4y45GEYM5bg+5gIeGStLWeP4SgXbeMs5SoE0U2MuJ3j53/FSOT
baZnUF/c9Guckwvx5sCB/NIX8FhBEpzwmHnDuifH/Y1UzOkwJyK4xPxlrabxnjri
ZuYrx3g5XgbUD3Rt/mkouXdQqIWMwK2LTmpKXXWRyS1xHPoPX+DcXVBqDjoh3EDm
119a3QfT+KvXDtVPKUPyfUhAGkIGczLN6G3RLPuDMSmhQgGXgdciDXp/dpb+Ebnv
MmxqdbIOuezV/gxz9k3O5wBILNIQO5RqUqnuDS4ndNAP8y2VCRXP4EO67+cR0ngK
FsbplQ0mCUHxr2D5ucKu36WDwNT4udT1n6QLhoZ0UXm1kaa9ggDRKGjvKa07O2ht
oAJRcIlEXw+UfKny5/AVXZ6uVD4g7Vc9cz7dBZRmoYRBPpSyDdFKNcJlNAnXV4UM
0SqfXbNKkTEi8LNGJnOA
=85Sf
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
