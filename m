Return-Path: <cygwin-patches-return-8251-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77629 invoked by alias); 20 Oct 2015 19:26:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77616 invoked by uid 89); 20 Oct 2015 19:26:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 20 Oct 2015 19:26:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CB8DEA807C9; Tue, 20 Oct 2015 21:25:59 +0200 (CEST)
Date: Tue, 20 Oct 2015 19:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: New FAQ entry about permissions since Cygwin 1.7.34
Message-ID: <20151020192559.GC17374@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56143209.6060201@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <56143209.6060201@cornell.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00004.txt.bz2


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 673

Hi Ken,

On Oct  6 16:41, Ken Brown wrote:
> There have been several recent threads on the cygwin list stemming from t=
he
> permissions change in 1.7.34.  I've pointed people to the FAQ about ssh
> public key authentication, which is not the first place where someone with
> this problem is likely to look.  The following patch attempts to remedy
> this:

Unfortunately it doesn't apply cleanly.  There are weird differences in
whitespaces and a patch-breaking line wrap.  Can you check and resend,
please?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWJpVHAAoJEPU2Bp2uRE+gPvwQAI4qTUgNi+S0Qb8vSJDRMAvW
FA5zI5PQrzxOMMt2jrXhR8wINmcPBOZgW70Vnvpr6iEO+I7hYOh93WeK6KMTwNlV
mfdarrw7gLZ8n/C2pOnE+UdrK1cCKTngr4d9zVpbIVktdxNzySrjEFDkmkmc34Bk
4TEWyZqvgWlcyEEFVu091rbl6Eg1GfjxXthYvigbmq8Y8pBc49/6ZHR5PLKJM/i6
LxDrLkm2C+5Ujwh/ez5OjRy2Z1b6VijFxbkJkGq5b1kmOcDMnWrjQuWsXAdD7vqg
F4KLGzL+k7ArOXBDaLTEFixAe1XqJCNHW0NTsiFKzr9FW/hb127uX1ZCejFLAD4r
swqAoW04kbjZVktuSN5JEKn3q4ovjN8o1AtkEUkIXgjmbgzbgpVZh3yeq67VHXNx
wooqXC6l+tcwP9cH5oXoIq6XMYL4T6TX1Ts88mCbvNZ7zreGc4ObXsLKCZq9jYvq
tNOEengCPk5BUFm/l07akj2/dA03JsCNCOpicU4ewpkD/n9XQo55zMESEc4gTD72
l0vfJACWEWO3hVdAWm4zuWHQ2Q4YPqhaFNe/hBxO4Oypoj2Ihlmto765sfj6mUi7
WjzuAtABMCRYJ+TZkgZbCpPHWrvErCbwagV8kH/hqbw80o+clE74lAIK0HkaNFz9
uEJcvuaFB8QNwZu6M2pB
=l56N
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
