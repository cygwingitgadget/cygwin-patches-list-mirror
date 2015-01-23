Return-Path: <cygwin-patches-return-8052-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23472 invoked by alias); 23 Jan 2015 10:48:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23428 invoked by uid 89); 23 Jan 2015 10:48:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 23 Jan 2015 10:48:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D244C8E15A8; Fri, 23 Jan 2015 11:47:58 +0100 (CET)
Date: Fri, 23 Jan 2015 10:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add-on to gethostbyname2
Message-ID: <20150123104758.GB5612@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0NIL00E86XTQH2L1@vms173013.mailsrvcs.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <0NIL00E86XTQH2L1@vms173013.mailsrvcs.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q1/txt/msg00007.txt.bz2


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 781

On Jan 22 21:05, Pierre A. Humblet wrote:
> Add-on to gethostbyname2, as discussed previously on main list.
> The diff is also attached.
>=20
>=20
> Pierre
>=20
> 2015-01-22  Pierre A. Humblet <...>
>=20
>         * net.cc (cygwin_inet_pton): Declare.
>         (gethostby_specials): New function.
>         (gethostby_helper): Change returned addrtype in 4-to-6 case.
>         (gethostbyname2): Call gethostby_specials.

Patch applied with just fixing the coding style a bit:

  if () {
    [...]
  }

  =3D=3D>

  if ()
    {
      [...]
    }

Do you have some wording for the release info in the docs, please?


Thanks,
Corinna


--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUwibeAAoJEPU2Bp2uRE+g0/4P+wWwrwNp2DkXO+qZlDk6CSBk
gyeU5996P0rspBzAYjhLvVCPZixMVV2KSigQcyx/4fIsIYW903k/e+Fah1cLNe5S
UUt/pW/IN9g7b3VzNS2+sGWX6uJctOidtfb5Dff0G6awdBUD8uwIT0yOrokpacjY
SIzRg4MtDgrmpOdURKKOAy/6zPYOa6EKMKFBfEtVfGx+V2nM0pS7D3/svcE1G6RZ
Th4KUL+NDyNum+D0jIvrZ3pNxRsrLO4aw39R25Yc54EHsYDH3l807aYhhSmCnUgj
Rl51zpncGa9IksPyCjMNulSitVl3DlQBoO60DDFYE/dDfUPdFjYRqkL0Qkk/gsZ2
16TPzOTO9XlW5wtSGhR5r4kwvekwsxv4e9KxIYAFEcycXxYZQy03WuL2rmiK3j4l
rKlKyIrbQCYBB73e0Kc8tf0divr1aTm6gRswcLZ7HP/GXLcyGZMNYPQQmvu3yC/0
kdhLtHFyzGLyYf0kpgCDM2kabZ9CtIDMZMSDaSq47J43FB7MAgjFy7M7BZzq5qZm
ePrUOwpF4+A9ABywQ7c8LDWzd0aJM9mNj+EWOPFWl+KcCfAqVZO4NAu4NvR7qM/T
huP1DnXYxvA9v4ThUoRxXjYE2EgcAvDhsOnHAD60K/tjTDcgfboCjbqbJj0wqXmp
v5e3iEErSBHh6CBkadkP
=KEiG
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
