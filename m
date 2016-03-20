Return-Path: <cygwin-patches-return-8434-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64711 invoked by alias); 20 Mar 2016 11:16:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64697 invoked by uid 89); 20 Mar 2016 11:16:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=earth, Hx-languages-length:588, H*R:D*cygwin.com, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 11:16:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D555EA805AC; Sun, 20 Mar 2016 12:15:58 +0100 (CET)
Date: Sun, 20 Mar 2016 11:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 05/11] A pointer to a pointer is nonnull.
Message-ID: <20160320111558.GG25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-5-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00140.txt.bz2


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 578

On Mar 19 13:45, Peter Foley wrote:
> GCC 6.0+ can assert that this argument is nonnull.
> Remove the unnecessary check to fix a warning.
>=20
> winsup/cygwin/ChangeLog
> malloc_wrapper.cc (posix_memalign): Remove always true nonnull check.

Eh, what?!?  How on earth can gcc assert memptr is always non-NULL?
An application can call posix_memalign(NULL, 4096, 4096) just fine,
can't it?  If so, *memptr =3D res crashes.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7oZuAAoJEPU2Bp2uRE+gIxsQAJNJtqq36bDZWMRJ/zFHtwM3
sdr2aAXPTiEDr+qeOWOJS+4oixK2ef488ikxU5hl0QCt+tIBrsgcbStYV6Kl3EfI
Cp/LZA3D/A6m9A6/Aw8jnJjzxhpDrwJpnVh+ZDZhH5XgwnWy0Rrp81oHjMhbRl2/
RyQ1Jz7dIwWQoPT6vebQt14d8r5j4E9K4SkA/t8WNWlB6eDdo9TctagUpfjN3jBx
/gdA4dTgmJ6sF2xke4IyjhFVXMfPptLfWQIGH56ddNlgAIJ3wH6QITjH670ncjG9
+4yrR0p/GJtRuzUMK8/R2IXP/RYyF5IrjveyEeJWxmYjByKZdcnrLhI1H6QzTzD0
uAxX+uuf5sRhzVDWsPulhWx3GugU2P8CavahTJKGcX/rpgrGLRYZJMATiluLEsvi
YVqwryPZmD20b3DMBoQaRAI3P1H5R+edOeU0r5gc3Nr80fbkTj0yw+CEYmS0bdby
yEGrZee+aMtfyAv504uBBz0DeYkePKI56BMqiclWY43GQc5f/DbrAZcHIicAVMTh
g4LlCOWoPIxdE23szmkXhlraeB24ahVjT8XBpaV5v33tNB7y1WYHsUyUHVEd9mrM
Ppo7kxBvFqak8JC/1n6k2Dg6+Eex+xsXvo40dn6qPT5vN8ReN06PT0uzAcF385P0
tgwMSA94DgxbbxU2e0zX
=XALd
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
