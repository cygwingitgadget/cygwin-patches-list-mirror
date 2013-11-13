Return-Path: <cygwin-patches-return-7910-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27568 invoked by alias); 13 Nov 2013 15:18:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27503 invoked by uid 89); 13 Nov 2013 15:18:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.2 required=5.0 tests=AWL,BAYES_50,RDNS_NONE autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from Unknown (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2013 15:18:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B25051A0BE3; Wed, 13 Nov 2013 16:18:17 +0100 (CET)
Date: Wed, 13 Nov 2013 15:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Prototype initstate() etc. if _XOPEN_SOURCE is defined appropriately
Message-ID: <20131113151817.GA5883@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52838E8C.5060708@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <52838E8C.5060708@dronecode.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q4/txt/msg00006.txt.bz2


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 612

On Nov 13 14:37, Jon TURNEY wrote:
>=20
> Not sure if this is wanted, but mesa likes to compile with '-std=3Dc99
> D_XOPEN_SOURCE=3D500', which leads to exciting crashes on x86_64 because
> initstate() is not prototyped.
>=20
> 2013-11-13  Jon TURNEY  <...>
>=20
> 	* include/cygwin/stdlib.h(initstate, random, setstate, srandom) :
> 	Prototype if not __STRICT_ANSI__ or _XOPEN_SOURCE is defined appropriate=
ly.

Looks good to me.  Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-length: 836

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSg5g5AAoJEPU2Bp2uRE+gE8UP/0euUzXWWj3Afo0N8Ng8sEdU
4vNGwR7nDy+ZAfYEJbIVWkfwHY8upS3NtuqklKqAyYEsAKuwvM8PXHyC8kUM++yQ
eCmKglg6IDdNRmyWdDH6YFKqlH8N3cXf5ISh7r+qb3kft/IE12xdtp71NrMXWxKW
5emGJ78JcudgkssYSN01OF3yT8+PfgkwsI08xAjHku66lKTOkqYVJc3/j/NwLNmK
Epbu00Y47FWFAh5nZSDd63rvVQ61EgpJasH6MLRNwAhry3vkDJtHKj7czmtuWZBG
OOrRqiFj9etAqoG6ijUHLm4/U3Nj4sy1ocnY6awufd/s/nLh1e+LRrABzggmyIW4
bxwrbvaBolll5MHggyGhXmm9aKBqggjYY5XuyXr0wHl4prZlyygFGP4pzRA/ev+1
AgBwhhyTPqqnfqj5yAtCygzl3Oy2SjXeZ8kVzxUHBQ+NWrzD+vd7v21AL2AoIDvc
2HUpj7G+/UQCmjsIxJYnZz4MzImIIze9pOztM9akl+QJn8C8qduBxATksKtamw4P
LtjS9411qo6t5UB1LLsM+1hl+fL44OX8yr5fvkb2FoyTX7rAxpDexo8MJhtVv+NW
F2UOgAj+8rJCM7sEGDlS5XGV7uNzz31j8Wdx0iMj+xzAvt33glkiXDQpDFNht9tE
XKSzXyQ4wzGtkGxEhEl2
=KiBX
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
