Return-Path: <cygwin-patches-return-8435-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66427 invoked by alias); 20 Mar 2016 11:17:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66407 invoked by uid 89); 20 Mar 2016 11:17:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 11:17:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DF510A805AC; Sun, 20 Mar 2016 12:17:28 +0100 (CET)
Date: Sun, 20 Mar 2016 11:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 07/11] The address of an class always evaluates to true
Message-ID: <20160320111728.GH25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-7-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-7-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00141.txt.bz2


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 443

On Mar 19 13:45, Peter Foley wrote:
> winsup/cygwin/pinfo.cc:465:14: error: the compiler can assume that the
> address of 'tc' will always evaluate to 'true' [-Werror=3Daddress]
>=20
> winsup/cygwin/ChangeLog
> * pinfo.cc (_pinfo::set_ctty): remove always true check.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7obIAAoJEPU2Bp2uRE+gad0P/RAv4NulvY3gKVOtd3Y8ZVkF
WlLnr/B+WeQ/ZT4ENUmNPDamPgz+26qAYofv6/rP4sMMMwep9xJfgzCHsTl4qtB8
JCFpFj1ibX8AJeq0y6aTETr9dBPvZsiqxdcBRV0fSH5Q9r2reQCqERr0i05KitnZ
Tq+KqBoMwCzvan6hfRoNIBo/lze2twVdOJcVp/Md6RqM8Ot8X+kbElJlWLicTfcF
jSe7nZejKPkFxwSX6GNWbz1n/gN+Kzm/eTysdvMHUq/XYc9U9dH/yQfMcmr3J+IR
vR0FHQfmCiDp3Z0ByKBWEYSXOk6JmI1u2yD+M1qYkk0MVRtnLSAruZiKhIsO7Ete
cfSiGPOI+bzuLlUbIloFVj++uwhzIR44MLs02d+YSxjYaXME4Tkzd9VfwIYR2BUQ
PAl5e/ASNF/2sQscilLG26kHmIhke5da0jWmsr1u9OqcPLtnI5BCd/3Rm9lBA1U7
1ENmvRRQZ2MWraJyn8CONsicuY9rjhYvor6TuG59GtCZ81CGqUcmhpPjhnbJL7zS
TXI5aO2Fk1b/sL52Owg+AfHEXC51HYZvum/Q3xPnEjHJLoT7AYTOE5Z6782Wv0qm
Lde5QxUdvbrGGjzY6Ib5WuoBwYJDlynhZ6JpYal4Oab/ylHggQwnvBJT6tl1Aqvk
hHrylnFj+c/8iaDzBSw6
=PX5H
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
