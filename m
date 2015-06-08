Return-Path: <cygwin-patches-return-8144-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126178 invoked by alias); 8 Jun 2015 11:30:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126161 invoked by uid 89); 8 Jun 2015 11:30:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 08 Jun 2015 11:30:42 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 820F0A807C8; Mon,  8 Jun 2015 13:30:39 +0200 (CEST)
Date: Mon, 08 Jun 2015 11:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc: Remove ancient unused Makefile rules to make documentation tarball
Message-ID: <20150608113039.GA3396@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1433447744-17688-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1433447744-17688-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00045.txt.bz2


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 465

On Jun  4 20:55, Jon TURNEY wrote:
> This used to be used by cygwin-doc to make a tarball which would be used =
with a
> ssh script to run docbook tools on a linux host since they weren't availa=
ble on
> Cygwin or something crazy like that...
>=20
> 2015-06-04  Jon Turney  <...>

Ok, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVdXzfAAoJEPU2Bp2uRE+gdesP/ji3M9+2qxM4VqOiqB2zz5gZ
BwsKH+UL1wenTKQRDw0lmbXQ7d0jzkLGU0Y95tCTl+xO98Km1yx5VgFrb4prXZiF
1BuVIdIdjyZ9NQQPuM4QO+S5UvAe4qli7+rD8DJFYNIeFBM/A3xOLkOEjgxB9XlW
feSfvj7fmB5qVp5ElfqelKLeF0BMMv1eHeP/+ULrOFWWn1QFdty2B9qoUG2NbtyR
nTF7/xomzU64h0BrexUsqWjV46n1NHXYBBBr85akguaGQi/RPV+LJfbgdrfFrCEV
eS5ypYJp1KxU1skmt7kyA+5T6yAA3bn8yoUTjlMGaNAXa9QJJfBKs/GhcrlQX2Iw
kBRobjlDstKvbDQusP8Rvr7iekgrpYXl9Uj1K4AAXlPInSvUqNvh3pOJanm1qzx7
par3eGNxzd4D6tJIzuamWTc+g4YtNEu9H/CyYNI6dArF+egJ+0PZjQ6WSufv+LOz
dr+PazEt+Ah0DSA9BcLhKJadOwc4kA1IjcqgYVHrSLfFygDW1cs7KiMZNW9V6pNY
HghRE3sz+zG4uC2EQ/QCru24ZsQQbgV//UxQ4a08PI53AFaQ4sak12ug8HjCuZ2c
4S1NdX74oYovPcxdMZj+krdWKHncmb6tG0j4MiAZt2Grf403kYeAOANC+BjSDzep
IdL0cZCNnSVqBGo4kkQh
=pPve
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
