Return-Path: <cygwin-patches-return-8223-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21228 invoked by alias); 5 Jul 2015 20:06:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21217 invoked by uid 89); 5 Jul 2015 20:06:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 05 Jul 2015 20:06:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D5B1BA80923; Sun,  5 Jul 2015 22:06:32 +0200 (CEST)
Date: Sun, 05 Jul 2015 20:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc: Add a configure test to find docbook2xtexi
Message-ID: <20150705200632.GA8681@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1436119898-2752-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <1436119898-2752-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q3/txt/msg00005.txt.bz2


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 605

On Jul  5 19:11, Jon TURNEY wrote:
> Fedora installs docbook2texi under the name db2x_docbook2texi
> Other distros and Cygwin install docbook2texi under the name docbook2x-te=
xi
>=20
> Add a configure test to find either.
>=20
> 2015-07-05  Jon Turney  <jon.turney@dronecode.org.uk>
>=20
> 	* configure.ac: Add check for DOCBOOK2XTEXI
> 	* configure: Regenerate.
> 	* Makefile.in (DOCBOOK2XTEXI): Use.

Looks good on Fedora, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVmY5IAAoJEPU2Bp2uRE+gmqoP/1w6kWRxoJUvtcp0vZ24hl7+
UJnV/yNPM9uZWY557cswRj8llRWsQjtBYkBpS3TTQbTpWP0CKNiR/9jrM1H1Nw3w
3vSpxK5JlZp5g8HrYUAeiuWuWQZG/wzQGkDvBp+y10oY7OOj1+zEXvIQy60Q+15d
pny0Lil5D6ggY1xLryTzNkWxjGJRdVJzpw56yVWMzKxW+6WN49vo2/uC37xxEshx
hQgLS9eEtZjE/JfwXbAFqkLclbB/9Hxeu9WxDoHsol9blv9N587zRBWX1lSfmqPr
dOxdihYPoLL/akZUeT8sJR6wIE0JBw9n2Z2eiGneMKgDv3M3fyZn7oXlG+333SUH
ikDFVG3w2S3czl9LkBStOLR0m9CwE0ulzCY8QLd7BlpPAU2eN8SPdled1S6N3wXy
P5U81Vl2N7dfhnbYNeSdWEEXenXaeCOCq02EfuKz3/2LppkDRccF1fQQpQzKlwhS
a6JR44a8aN7uTQk9Elgle5G4Eji5J+NtteXDTPsbFkLtci9WxSu273krAKgF/UxC
XZ3uK+dS3G64rT6LSK9LInGgnVcJHG9sAzSID7v8ylqtXfBjtVxgRA5/ioTMgrX6
olcu+VKSVdBkMM1SzL2N9uoKR+TyKV/jclnzmYcMAfNheEXH1rFtQyW2++w7Ft2P
10mYMo91cuqLmaMA2HLV
=vvTT
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
