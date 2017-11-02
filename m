Return-Path: <cygwin-patches-return-8893-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 115150 invoked by alias); 2 Nov 2017 15:06:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115133 invoked by uid 89); 2 Nov 2017 15:06:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-102.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:266, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 15:06:27 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 4B517721E2830	for <cygwin-patches@cygwin.com>; Thu,  2 Nov 2017 16:06:25 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id B87315E038E	for <cygwin-patches@cygwin.com>; Thu,  2 Nov 2017 16:06:24 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B682CA80658; Thu,  2 Nov 2017 16:06:24 +0100 (CET)
Date: Thu, 02 Nov 2017 15:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] posix_fadvise() *returns* error codes but does not set errno
Message-ID: <20171102150624.GG8599@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171102132622.5756-1-erik.m.bray@gmail.com> <20171102145845.GE8599@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
In-Reply-To: <20171102145845.GE8599@calimero.vinschen.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00023.txt.bz2


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 230

On Nov  2 15:58, Corinna Vinschen wrote:
> Hi Eric,

s/Eric/Erik/


Sorry,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ+zRwAAoJEPU2Bp2uRE+gbc0P/AsK0UJsgNmijkFngBRAnzd9
8aYf8+pmhuYWO+TVZEHN8zfAK5esGkbja9z9Z7YKXHGYusvixBSVhgHj7itmoUJg
krY4pzbqLQRvSWyeQAEuVK5uViIyiz5NkrKtrxZJAZPlfR7w7+ZAS4HqVLURYTuF
n6iqe5xi6YvOLnvQUl3eLaeQFfFHyoOXFznMX6xgjPYhmrQ2QsKAe9AhfK6ncKZA
c/3zqvRX4BkrejLRO5HSm8/XEn0Cl97GykdGFgm8bCKYD/X/BN+TObBfVT2rC+kV
K7UTsMIpKcXntYiFXveUh754wS4V0fMSwcqP1oI/hvyLpy/daubcRS9/K73/of6h
oDzQtnF0mRDNTtzMNEpA3vpY2UfRqGJPjjGST8yVxC1FubH99Elu6a9zRI8vMdC+
F/4X1VYGDzUfQFIfGCa+AnVGvmQ9kY7ruDqhMtAWVmAztjKCjuApS5uY1YI7CBZx
CaywV8unRr0oovQ2R3WvVBrUCAyEYq9g/GMI36G8mBx9tSOn6kj4RZOcXcECaGzM
H/RF+QDSM+Ug4N2UpsV1KkWSuhGAw5e6FNqr93RmEnGn8z4ukO03m9GgOZiviD02
266pFPdsF/tD37pAZfRWR2SIaZCChJgNtwUcyggZbqiMMdne6SAblJ0HwWNOn6TN
FZ6Na3cbI554LR25o+lT
=i4Wb
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
