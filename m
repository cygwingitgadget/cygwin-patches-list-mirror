Return-Path: <cygwin-patches-return-8943-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8107 invoked by alias); 29 Nov 2017 12:05:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8091 invoked by uid 89); 29 Nov 2017 12:05:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=American, american, worries, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 12:05:04 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 1253A721E281A	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 13:05:02 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 161ED5E0418	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 13:04:59 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8CDE8A81808; Wed, 29 Nov 2017 13:05:01 +0100 (CET)
Date: Wed, 29 Nov 2017 12:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
Message-ID: <20171129120501.GD547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <e7c6061c-be0e-5c36-b135-5796f9cd5da0@maxrnd.com> <Pine.BSF.4.63.1711290324100.77443@m0.truegem.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.63.1711290324100.77443@m0.truegem.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00073.txt.bz2


--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 644

On Nov 29 03:27, Mark Geisert wrote:
> On Wed, 29 Nov 2017, I wrote:
> > I added the printf()s and, what do you know, it shows all the NtWriteFi=
le()s
>                              ^^^^^^^^^^^^^^^^
> That's an American English idiom and is not meant to be taken literally.
> It's like "How about that?" or "Can you believe it?". Perhaps y'all know
> this idiom already but it was only while contemplating a cerveza that I
> realized it might have come across badly.

Nope, no worries.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHqJtAAoJEPU2Bp2uRE+g76IP/1TVk86fqSX9tXjCGfu6v0mS
LjaI0i2duK2Q3AvbJc5mPHis1EwBC5gOzvfnBj/QjHMJPea0iLiSZWydXb9vxG0s
vkobKCynjUOM6+/ZHYhUkeu8eNWEp2H1EMLHW1XM4+BSS3mXUYhiYZFABoKi2u0l
9kMuZZM+mMPBJHOGpezEFjkRl/9VucZMzOhlgIvnGNnneKfusJwsQALUdaTS+eER
HCq5bJ+ji3hD4ENAgZ7Y8HbmimKkq5WKPKxfkry8rOWreQWeUNSebrF6q9IUdCSa
PshhkNtClQ8u1TpeFCqAw1ekQohlq+EJrZUh2qeAQ4Xb4suLpAJrQpJheS/tnJsC
Jn5z4DB91SCdSqwo0RAssxeLmXTRCRGM5ofaVFKQQ5gpZw7vdFuPChRV3I7ZRi3a
8qJ+/OfFEEp1S1C10ZnqPorBQ4r3xh8OKgqgTHKNfErActKXJ4+/7SsYu8hdYCWm
FEr9g2y9oSg0NzgD3S5z3cSXuWGp9n66lDeg3E4KNw+uLLtj4WKvSbMUWv1/4H6m
71jY+/mo+tXIG47YvWRgFF+/eEJWdLoFWJmtMW5x9HeyfHgyQAOdbPBJYsmvHsGd
YXwMeDqGn4FNQQ5mMLVqnEmTFsEX7hhWxrkNZka+eKKhZCMSnen3r7uEX2X+/WZj
ywtHMN8DYwEyvYIijsBo
=e6kG
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--
