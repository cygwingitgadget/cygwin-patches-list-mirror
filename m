Return-Path: <cygwin-patches-return-8233-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26163 invoked by alias); 5 Aug 2015 07:30:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26140 invoked by uid 89); 5 Aug 2015 07:30:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 05 Aug 2015 07:30:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 02D5BA80547; Wed,  5 Aug 2015 09:30:21 +0200 (CEST)
Date: Wed, 05 Aug 2015 07:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Improve FAQ answer on debugging Cygwin
Message-ID: <20150805073021.GO17917@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1438691794-7396-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
In-Reply-To: <1438691794-7396-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00015.txt.bz2


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 463

On Aug  4 13:36, Jon TURNEY wrote:
> Improve FAQ answer on debugging Cygwin to mention the cygwin-debuginfo pa=
ckage
> and the gdb command 'set cygwin-exceptions oon'.
>=20
> 2015-08-03  Jon Turney  <...>
>=20
> 	* faq-programming.xml: Improve debugging-cygwin answer.

Looks good.  Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVwbuNAAoJEPU2Bp2uRE+gSkMP/jBDZm/LuFBc+zeKExdO3Ej1
351k1OPfaN7e3OfcnilICzsPikFP6vS22ZcDFSLvIhYKsElt37glX8OxwVyeByH/
bfx7hiB/ysz/liPPDRxKdqnmWSM7dXE6NnZ8iUNwQvWLvwqpcWj5/DhbqkTLNj8j
EZilQQ2IrQVWtTAA8Ft60NZKGXiXxZg5IzQUPOhMc/dUXPL+YKMgDi9g6xv4ih1l
vl36KvJOXZefZuiRIwavBBjDyxgNGQb4BJ0xqUYModtMxtbnfGgKsVKwaakOLbF4
lnsVNSpyF8pblxo/dbNMJ76XfsfD0jTnyCNNv65H+8r9QJe+vfuJHdH0h3SuHhz8
3vZ0JeFZc0iX4/8CeWhSHAC/09TIlsMcy0ZAzLfrlPk+f8K3Iy819y7tx/O9v1CP
USDAprpR8K2VyPqKHb54dKrGiX6+PbgK1SDNTSlA4moJDog+Me8ODlDVo6PvaFtO
SFDS4WGWcc4EFKx9mhQmQLiqgoKQJM87tFkJUudqdkYTjt33X90ahPmILuU2A9Ka
nkTy9kEm02liyIE5tV3xEc3EcO2G9DVbHN82iTrvvTQ/nxtGuV4iTuxt6GJCvs+u
BVxWTgrN6MFOwdl74Vl+BkSG6iv53j1UQ0hL8wYeHn4fP3DZJRv0DAHs95FDS/al
gUpcpSroQG8B0R3R3hAt
=Qand
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
