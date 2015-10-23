Return-Path: <cygwin-patches-return-8262-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96715 invoked by alias); 23 Oct 2015 09:41:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96160 invoked by uid 89); 23 Oct 2015 09:41:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 23 Oct 2015 09:41:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0671BA80443; Fri, 23 Oct 2015 11:41:41 +0200 (CEST)
Date: Fri, 23 Oct 2015 09:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow overriding the home directory via the HOME variable
Message-ID: <20151023094140.GA10312@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <20151021183209.GF17374@calimero.vinschen.de> <alpine.DEB.1.00.1510221731250.31610@s15462909.onlinehome-server.info> <20151023091018.GE5319@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20151023091018.GE5319@calimero.vinschen.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00015.txt.bz2


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1907

On Oct 23 11:10, Corinna Vinschen wrote:
> On Oct 22 17:38, Johannes Schindelin wrote:
> > Hi Corinna,
> >=20
> > On Wed, 21 Oct 2015, Corinna Vinschen wrote:
> >=20
> > > On Sep 16 15:06, Johannes Schindelin wrote:
> > > > 	* uinfo.cc (cygheap_pwdgrp::get_home): Offer an option in
> > > > 	nsswitch.conf that let's the environment variable HOME (or
> > > > 	HOMEDRIVE & HOMEPATH, or USERPROFILE) define the home
> > > > 	directory.
> > > >=20
> > > > 	* ntsec.xml: Document the `env` schema.
> > > >=20
> > > > Detailed comments:
> > > >=20
> > > > In the context of Git for Windows, it is a well-established techniq=
ue
> > > > to let the `$HOME` variable define where the current user's home
> > > > directory is, falling back to `$HOMEDRIVE$HOMEPATH` and `$USERPROFI=
LE`.
> > > >=20
> > > > The idea is that we want to share user-specific settings between
> > > > programs, whether they be Cygwin, MSys2 or not.  Unfortunately, we
> > > > cannot blindly activate the "db_home: windows" setting because in s=
ome
> > > > setups, the user's home directory is set to a hidden directory via =
an
> > > > UNC path (\\share\some\hidden\folder$) -- something many programs
> > > > cannot handle correctly.
> > >=20
> > > -v, please.  Which applications can't handle that?  Why do we have to
> > > care?
> >=20
> > Oh, the first one that comes to mind is `cmd.exe`. You cannot start
> > `cmd.exe` with a UNC working directory without getting complaints.
>=20
> Sure, but then again, why do we have to care?  Didn't you say GfW is
> using bash?

In particular, it affects all other native applications as well.  If that
home setting works for the user outside GfW/Cygwin, and given Cygwin apps
don't care, why should this suddenly be a problem for GfW?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWKgDUAAoJEPU2Bp2uRE+giKIQAJyH8+9QSamadB36NRC//JWg
kWZ1cLB+VemI/mKgc7bkyv6pIClWF+UAFtMMMc//2746qYkuTKlurd7PLGNpCl5m
Ft7kSO+4QnDKwg1dDnpOd/Z41E6n7LSrTchkaGVgT6sqk+0N5hxn3qgDGuAjMZQF
O/mlkwKAmTowze/kWk0MJ38CWzPhuBrlCTNpqEfrDDC1pXj/iv57Xfjka9upzTkJ
xtPlA4LoHNQB0nFW3PlIMyXf8H9pigdcfrPVOBv6XMsWIEczWeu+kqSoN3QRX8BG
+ZecFk9yCMJvvMKNBN8qA15LSldxTdgpoHCAXNyu+hRrAjHVHxyM9wB/b1DaMz/q
GXpL652YCi5FlLZ1mxze2+r0UDnyiLkuBBISqVq3aaiKRdU/TblOG4dx27m3q5C9
hyLGbesujHNaPN88LLxPWJOado46ydmP2qoT/ndW8d7UJLjpx8hr7D+gKg4LcK31
bcn7usqToT/tmY+XXkPBGx8ihxWG2+VTXhYIc55Q5B30sGkMuC8+TA1wLwwoghzq
B+ttdeKEgkwBAI4lm25pfWr92HNiJuXzSxfd28DdVO44M+MetDwAKPdSS88Fnz1K
79VGGbJZNGtsOngkCUdAaFpm60SRXYhnAWo2fPGVAurzllP1Ixgdi4RzR/UMcmg8
q1h33Ubfb6D8Juol3tAf
=cJAJ
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
