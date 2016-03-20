Return-Path: <cygwin-patches-return-8431-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39366 invoked by alias); 20 Mar 2016 10:56:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39342 invoked by uid 89); 20 Mar 2016 10:56:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 10:56:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9F05BA805AC; Sun, 20 Mar 2016 11:56:39 +0100 (CET)
Date: Sun, 20 Mar 2016 10:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 03/11] Add necessary braces to if statements
Message-ID: <20160320105639.GD25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-3-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-3-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00137.txt.bz2


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 472

On Mar 19 13:45, Peter Foley wrote:
> The missing braces cause only the first expression to be guarded by the
> else clause.
>=20
> winsup/cygwin/ChangeLog
> * fhandler_disk_file.cc (facl): Add missing braces to if statement.
> * mount.cc (dos_drive_mappings): Add missing braces to if statement.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7oHnAAoJEPU2Bp2uRE+gz8cP/iUu95FQdPbsG+jR4tOGXld1
qBAH5nJvKbNPd66KAwGLNpCA5CDbCK2shBEZXM9DehGVU88mNDd7lVH2JcuRccGh
b8c9rrtq1/kOKj2X2lIlLTEwDgUdF45ez3rjmYjKum7UlmULlb9djHsRa/XVT8QC
nLOYmEt9ENhspnlMjNRuPFv2KTnp7QrZBF5FO+Ze8Mk/hLbCydpmAuReJlg2VIID
0KtWz4jm48smo50w+c1VmF+RrYHy2xCrm2kmCs20l4Fw4z5tBeWVMh5g+lEsvvcK
seBFMC39fe3xftJz+DHOv68Hu1Iu0w0LDDTnt2AL06knWKUCS/d1lrpRKjZooDs/
ywjX8bklTjz0m9rcwd9juZvJ1CubAtdbyak+nEcueiaNSIfDRNiPlRDPb+j7Flua
24BLWSp6Lfe+Rrh1+sVteqT6a053kLK/krrHr+l6Me2q61nlIxVKCTu7Dtvz5BQu
y0Z6YVW7pKVhPoHKQgiJ82ZOvtm0G+uM3hAkIWFKZ+/QjbT+Bmi6x18Iz62YzlPY
JwnodtEFI45/1GSZALRWoueHcRZ0o2ALw0B/jwQS/g4psw1NTZ5HPK+8PW3j+alw
9gJgDIhsh4+AZQAnxp1IdQEdlxBM5gjipU0CacbqooaglLL3rEeSkGdR2vg0heMI
8qKa5XP9fz5EQUen+X0+
=VyO6
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
