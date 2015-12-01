Return-Path: <cygwin-patches-return-8280-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5800 invoked by alias); 1 Dec 2015 14:27:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5788 invoked by uid 89); 1 Dec 2015 14:27:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 01 Dec 2015 14:27:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B9C69A805D4; Tue,  1 Dec 2015 15:27:25 +0100 (CET)
Date: Tue, 01 Dec 2015 14:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Introduce the 'usertemp' filesystem type
Message-ID: <20151201142725.GY2755@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0MIuft-1ZZdDB2IaP-002Y2r@mail.gmx.com> <3ddcb7adf1004c146964beda2f90521bb1c19d4a.1448978434.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2IUIi54rL+LZyXu+"
Content-Disposition: inline
In-Reply-To: <3ddcb7adf1004c146964beda2f90521bb1c19d4a.1448978434.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00033.txt.bz2


--2IUIi54rL+LZyXu+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 599

Hi Johannes,

On Dec  1 15:02, Johannes Schindelin wrote:
> 	* mount.cc (mount_info::from_fstab_line): support mounting the
> 	current user's temp folder as /tmp/. This is particularly
> 	useful a feature when Cygwin's own files are write-protected.
>=20
> 	* pathnames.xml: document the new usertemp file system type

patch looks good.  We just have to wait for the ok in terms of the
copyright assignment.  Might take a day or two.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--2IUIi54rL+LZyXu+
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWXa5NAAoJEPU2Bp2uRE+gla4QAIzGaWIgEAUzJvmuUvvY07kL
i7WwiVdPCTDJn715iDx4gTci9p/tRwUSO7rBqR6oTCSPnKyBb6lw84JFI8NdS8ia
S1oOrJNTXO0yHi1eusi7Gv/0HQglMLQGicpF3jcgIjbvE2ZRHRRypNkscomedyVl
PJnS0Vn41OdMbgoA31RLRQdyjwKKl2mEfiPx6Nrp2iVj3NHVm/i4PooINObreKuN
iLVlfec2PtcPejZkxkVybtkBVv+Lp8ApEyzwukPBI7uvhBmtLAl26xId2c9N+L3h
vga8Qke9E5NgJyF5IZ4/C7uizXik4xvW1jg51YbCOLvTEBL4JNWDbsVbUVzMa5yp
HvfFu1qPiAPyZTlCnjWex+mShTcfKV8ZpOgdts36RrYvaZe6uE1eynlP0v/QI2YP
dZrYklTfcjVzQZYzW5kccTg4N8yPBd4d0oleXBslJjNJb4xfQRQ/MjIIaHJ+DpVR
udMKhKr6PgxBBtoXJakB5fMDut3K9NLJc9YSu8HKQmSsHzBs9CE45k5d3SWJ9aCE
94K1bTc8YkWlVtcLVngqfB9Nyk0kFQUMo9/l7RrHAyLuPit/Aped+kvbAgWuLZzi
ilJoLD7An/w3gTKETdmcRbKNvBHkk5nG0uwdI/LOraT95jmxpylkmU5f7aUaJjmT
ls3YGpcPmJKE4XBynRG/
=C12w
-----END PGP SIGNATURE-----

--2IUIi54rL+LZyXu+--
