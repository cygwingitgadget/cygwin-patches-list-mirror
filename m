Return-Path: <cygwin-patches-return-8438-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128493 invoked by alias); 20 Mar 2016 11:34:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128481 invoked by uid 89); 20 Mar 2016 11:34:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 11:34:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3C44EA805AC; Sun, 20 Mar 2016 12:34:37 +0100 (CET)
Date: Sun, 20 Mar 2016 11:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 10/11] Fix strict aliasing
Message-ID: <20160320113437.GR25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-10-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="tBhgiDt8dP1efIIJ"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-10-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00144.txt.bz2


--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 352

On Mar 19 13:45, Peter Foley wrote:
> Fix a strict aliasing error detected by gcc 6.0+
>=20
> winsup/cygwin/ChangeLog
> * pinfo.cc (winpids::enum_process): Fix strict aliasing.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--tBhgiDt8dP1efIIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7orNAAoJEPU2Bp2uRE+g6YEP/iWMKbe499saI3q/I4I52QjD
Hykw29tBvdQ1xuFdiwSti4scTo4RuvKNaFtCBFN+1OOJknk50n2+vPJiZPTh8w6/
2nLvhoBJLUBX90eEruBNQV9M9PAkEpF+0eDdqa6ILoCJyCdkIFGc/zDUPdOY+L+h
Vt7v9soe5uiNCwkN/rFm4Fb+98InE+ILpr2E8F7QcknbRhM2CH+IMvpPJZINtHNU
6q2hwOenvHh1I83RkGmkvXJAr2Ju6WstIQmUeme1TiejijgpRIIELJi88kG0YH73
VSwPp2elN1fElrTs7OpS+F5Dy68RSYq9lo53lRHyExcCqHIagenc7GlnOUDFsUDS
Ea76hbkvzoQs69n2tXsEOS6ZGwDKCSqjPJ56Bb7cIxMXDWkMkYRce3ZBjGHKe3N4
sLVSF2UJ13qY3T2jDQ67ifFMb7N3FREIt7C0tjpIWpIA8PXJOrEDygWHCeu63kb0
z87AXf9SNmLP2n0MPT09aSJ+11JBGL5v7SHz3SlF+ztS0hx97thpHRBSS8xOft+L
vtgehrPnVcMqXo2cIA6kRMl++AB+mpXQefFUlkq0v5UtTHxy/VFmhLurHjYcw2BH
iK+qzUWCH7N0IgaC48AmE3NCU+vH8/reHzMpqlyIifOzAvF5iYlJIBZjHxk+lCl+
HbcJAge6+N6vSnw6Qv8a
=ApuR
-----END PGP SIGNATURE-----

--tBhgiDt8dP1efIIJ--
