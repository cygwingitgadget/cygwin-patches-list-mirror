Return-Path: <cygwin-patches-return-8162-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65986 invoked by alias); 15 Jun 2015 17:02:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65975 invoked by uid 89); 15 Jun 2015 17:02:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 17:02:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 59B54A807CE; Mon, 15 Jun 2015 19:02:02 +0200 (CEST)
Date: Mon, 15 Jun 2015 17:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/8] winsup/doc: Fix xidepend to handle relative pathnames
Message-ID: <20150615170202.GB26901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-3-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <1434371793-3980-3-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00063.txt.bz2


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1027

On Jun 15 13:36, Jon TURNEY wrote:
> It seems that xidepend doesn't work correctly if we are ./configure'd usi=
ng a
> relative pathname to the srcdir:
>=20
> $ make
> cd ../../../../src/winsup/doc && ./xidepend ../../../../src/winsup/doc/cy=
gwin-ug-net.xml ../../../../src/winsup/doc/cygwin-api.xml >"/wip/cygwin/bui=
ld/x86_64-unknown-cygwin/winsup/doc/Makefile.dep"
> grep: ../../../../src/winsup/doc/cygwin-ug-net.xml: No such file or direc=
tory
> grep: ../../../../src/winsup/doc/cygwin-api.xml: No such file or directory
>=20
> Although it might be better to fix this by making xidepend use pathnames,=
 rather
> than ignoring them and assuming everything is in the current directory...

Indeed.  The problem is the included loop iterating over the
dependencies.  A more foolproof solution would be helpful.

For the time being, please apply your patch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVfwUKAAoJEPU2Bp2uRE+gtWAP/jFbQylSZFSwRetIR7KcO0HO
4GW27X8bDIQ6+Bvad6ZlPXMWYPFu20hHJlRopv0yJTuNdbOK70ZcNCO/Vxj//eam
5jZUkbXt53Exi7JKRoZ9mLp4/7D3fha4Q2QHlZeFWMKQhgO7si8zmv1FwCKbDkiN
tAkOkskwYFKgxTcVRkOu3ujUpKeGdB519FkjwEC1QuGowXqBnM12s3Lj2MQ8fPrd
xSb0koYh7zwFlrqHz05EfQuXbsb4/rWA5Pkzzb8mUUWK9DJzJzyi0MDMFo3exUYv
AbHNM1Lkk00VyejyS28ztBJ4X3G+C3oKUt5oRKEeb3iP6g1GsjOaNR1rEuNeh11I
0o8OFzjYavt99SKS64NROFB4nl+YOQc/GJ06clmvBsqrOWMzLlPn9DZ+BIoUuvze
YZeRK/ToERhFgYSWipobaEgNLswCOWoyDFRKnQ9AUgwvCXNMCV5raj1hSpMRMrtG
NyRa6P8pRonwKZCt/YHTWm2in9FT1RN/T1QvegK7/WX1Gp9gaB43YlBYfkr3RezA
3Age1lnzuTAcOfGyDd9B7A/sN40V+RPvvZWOKx+9/CcOqwp9qx+mFwT6ZDO1HzQR
1Tlyuge0dPTY1Tsy/KXpUHZM57Bp83B1c2JuFTY824lzYzkPZbrH6DuPmBwVQX1x
4I3ritPiVCV1XbJHHDvg
=1NW5
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
