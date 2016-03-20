Return-Path: <cygwin-patches-return-8439-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8818 invoked by alias); 20 Mar 2016 11:49:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8797 invoked by uid 89); 20 Mar 2016 11:49:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Recent, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 11:49:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ACE86A805AC; Sun, 20 Mar 2016 12:49:46 +0100 (CET)
Date: Sun, 20 Mar 2016 11:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 11/11] respect datarootdir
Message-ID: <20160320114946.GU25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-11-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ai3I8gwHc37+ASRI"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-11-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00145.txt.bz2


--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 359

On Mar 19 13:45, Peter Foley wrote:
> Recent versions of autoconf define datadir/infodir in terms of
> datarootdir. Add it.
>=20
> winsup/ChangeLog
> * Makefile.in: define datarootdir

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ai3I8gwHc37+ASRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7o5aAAoJEPU2Bp2uRE+gYSoP/iyhY3YbjHSDPnzj5o04zTRd
LHGvOhLmSUvdxkizEfCs+0d15De+gOaVshRl1H7Kn0MwLjVZyiWg5QZGWHMk1hIi
OywJc5jLIt2aKsMY7VAXGNRtKxoPFGTfhfhFwgHAaAsxY81oJi4euUZjfkGYk1Gy
IyyW7XsD39ZC+nLVs90nl4MmgDeoBHVaObMNGIhDvvyHD9+x0bLCWjbZHI6AEZ/u
jdB4wuszKZx/l7GJ+0Gik25ErHWonJuGQUNAIC78j5iroFBimRlvdaWqHflXrWTg
w6Xd2VFVrnWAiGW5SNc7qrhh399npT07hWuM9faN/mUSQQM7fFlWFxG9yLDNx0JD
+A2PqA5pH+dPx85XWjSEeBSQ5LC51aKVvosN6mjL24f+f1vleXxRgAtQpYDAxMC9
K0NVD//oBkyqxCspqH7k4jBw49JnceADRm1v5DRgiTo+CUdSTIE9NXFrYLpmkQQC
oUiH6zZkXrTIgD9nt2N9+bgyhzR6qdKwAU+53VORR1ThVcMzl9Aw7vp9LsivkT2F
Z34b7TyXxAGLo+yudyoILCwpyTbXz4Y3rJBpZSvC/P7aZFhiDy2DDZDSAWCb8ca2
lWNnou/+j+FBYAcjP0Avo8vdWPFkGLzWJUxWhswUpF6mtD9fgBsBDCnRw9IwOtUk
MJwW0CrGM/R/ig4L3n2e
=NhOr
-----END PGP SIGNATURE-----

--ai3I8gwHc37+ASRI--
