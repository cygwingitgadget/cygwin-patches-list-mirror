Return-Path: <cygwin-patches-return-8364-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21947 invoked by alias); 29 Feb 2016 12:58:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21934 invoked by uid 89); 29 Feb 2016 12:58:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=HX-Envelope-From:sk:corinna, turney, Jon, Turney
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Feb 2016 12:58:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BE581A8040B; Mon, 29 Feb 2016 13:58:13 +0100 (CET)
Date: Mon, 29 Feb 2016 12:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] ccwrap: fix build with non-english locale set
Message-ID: <20160229125813.GE3525@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56D3EF72.20504@patrick-bendorf.de> <20160229103339.GB3525@calimero.vinschen.de> <b818ad6d60ddfd3557c3d9e21efc6344@patrick-bendorf.de> <56D43D9B.5020602@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <56D43D9B.5020602@dronecode.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00070.txt.bz2


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 511

On Feb 29 12:46, Jon Turney wrote:
> On 29/02/2016 12:19, mail@patrick-bendorf.de wrote:
> >+if (`uname -o` =3D~ /cygwin/i) {
> >+    $ENV{'LANG'} =3D 'C.UTF-8';
> >+} else {
> >+    $ENV{'LANG'} =3D 'C';
>=20
> This can just say "$ENV{'LANG'} =3D 'C';" right? As that has to work
> everywhere?

Uh, I missed that.  Yes, of course that should work, too.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1EBhAAoJEPU2Bp2uRE+gWPIP/A4+5B7m8TuRikt/uD2+IHJ1
Pg+F1XgtcsTPxd7a78RwKE/2bhU1VyO4SaQ8hXllpQxuvq+4dM2LXSa5W1h89AKj
DMwV9NBVAC1QY+D7CZed2ee/JOqk048gcy58valrLIyrpthdxwSlBPOEvf0uA+fS
taygR7fb6R6VwFr+D39oqpF8RM1j3couYMNi8bglr7tkswVMITheiSNiG3aI/1hx
fZa6fzUnklC9/HKgo78ZCdyhWteRDHj8ZMI5jquGWZWLKN/YGCDO6UB9lewXObnQ
ZxIzWBMxz++wiOGlpNvlI+sUPYGUV6XYESFH0C/TjfHX5GjqKDizln4qfNzHQcfo
YCDmwgMyLiOhpvsl5ANUErIq4BhHJDrzVfjLz/vAjjkdXNJLiSxBiJWL5dbH4FGd
N2lPqD3k+aiQ0zVP193gEIzJ2YfRuGHLS84e2R1TZcZGIjNo/3Z35El1ts4iekn+
Xu2bIlcqhDHulHUTGyDR6A/4k039XAQU7UuITmX82CJxZNQl/3+zWPgniaFnCoUD
1yKgI+Rzlm/CltsYSLIdpClywkN+MQhDgrNVrIu5a2K7273Tv3HKkAY0svw4HcKR
ceMQ25fmsil4D6PhBLHFiTIlYyMqOq9hqTjMhwgYa9LCy3KAAbrTF1rnP0rsf+2j
KjN8K3KTYcQQWnnnc8g3
=TGvV
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
