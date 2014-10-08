Return-Path: <cygwin-patches-return-8021-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22305 invoked by alias); 8 Oct 2014 16:35:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22288 invoked by uid 89); 8 Oct 2014 16:35:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Oct 2014 16:35:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6E2198E0A26; Wed,  8 Oct 2014 18:34:58 +0200 (CEST)
Date: Wed, 08 Oct 2014 16:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix crash of ffs (0x80000000) on 64 bit
Message-ID: <20141008163458.GE2681@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5421994E.5020808@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <5421994E.5020808@t-online.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00000.txt.bz2


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 535

On Sep 23 18:01, Christian Franke wrote:
> This fixes the issue reported here:
> https://cygwin.com/ml/cygwin/2014-09/msg00341.html
>=20
> On 64 bit, i =3D 0x80000000 results in x =3D 0xffffffff80000000 due to si=
gn
> extension.
>=20
> Christian
>=20

> 2014-09-23  Christian Franke  <...>
>=20
> 	* syscall.cc (ffs): Fix crash of ffs (0x80000000) on 64 bit.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNWeyAAoJEPU2Bp2uRE+gYyAP/1Z41ft9DciBZwDdnm9vcW6y
bh3kLC4rkulwbNKqmc8SwAfWXFuNz5zafIUhVpSz4VvRaohUs5XSTI/CtWm6kv9c
YZK8mjMew112wM2qeteYIsvBZ6UJ09mrDlYagdbgd3DrqAHkqG1tjAGVNHaH0doJ
fGzTjo2Qoe1nMBzgdqjWgdRpuWXOzMJgaf7G+os1LpGPjl3D46NSy8cnBbiW+E8h
at8VLsBb4fptsEmhbVZRyy8UxbzwbLT3CbmOiMQOxEwHIc8pt7Bp/Ii1TTxO+/PC
D//1jYt4PM4gXrRcDO6QLrvW8sbHaeMHoaRHUUUs81a7bwEGwvBrxGy5tfU0YKRP
lmXwC2qqxnt/Q7mMBuHCXKbVG1sVFoseSdoCQ9P2yP+J6rwNj4KSuYduY48UIO5b
mZNXIeJVZ6Y73Ai1Y1y6ZjqJntLVM7eb17tuJp/0dIIkbs3gxf2MrbxdNTtjUvtA
OjJ8VdamC4eX+Yuy6xk84Y7SJbJ46hB3PeK7oKJGAgVLebc6JmaK+ZjW+vezYCey
Mv/nq5tfwcEaTDxwMZo1liivpJoXuWn0Mt90+m43+SklSmtivYtOVZm68nMzXRx5
JYm3wgJioIKDp5TIJQteDo4c0Q1D2OWqCyZuG/QeYvbC6n1l2pssFyAsiQhHKo4h
rvec33bsSktswoXlP+dr
=T7Rc
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
