Return-Path: <cygwin-patches-return-8465-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50264 invoked by alias); 21 Mar 2016 19:49:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50254 invoked by uid 89); 21 Mar 2016 19:49:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Rosin, rosin, peters, Hx-languages-length:1022
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:49:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C0B10A803F7; Mon, 21 Mar 2016 20:49:44 +0100 (CET)
Date: Mon, 21 Mar 2016 19:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 05/11] A pointer to a pointer is nonnull.
Message-ID: <20160321194944.GI14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de> <56F02361.50905@lysator.liu.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="aFi3jz1oiPowsTUB"
Content-Disposition: inline
In-Reply-To: <56F02361.50905@lysator.liu.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00171.txt.bz2


--aFi3jz1oiPowsTUB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1019

On Mar 21 17:37, Peter Rosin wrote:
> On 2016-03-20 12:15, Corinna Vinschen wrote:
> > On Mar 19 13:45, Peter Foley wrote:
> >> GCC 6.0+ can assert that this argument is nonnull.
> >> Remove the unnecessary check to fix a warning.
> >>
> >> winsup/cygwin/ChangeLog
> >> malloc_wrapper.cc (posix_memalign): Remove always true nonnull check.
> >=20
> > Eh, what?!?  How on earth can gcc assert memptr is always non-NULL?
> > An application can call posix_memalign(NULL, 4096, 4096) just fine,
> > can't it?  If so, *memptr =3D res crashes.
>=20
> I think that passing NULL qualifies as undefined, in which case the
> crash is ok, no?
>=20
> I'm sure it will misbehave if you pass (void **)1 too. So, some might
> argue that the business of special-casing NULL here is questionable.

You have a point there.  I applied v2 of Peter's patch so that
should be ok now.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--aFi3jz1oiPowsTUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8FBYAAoJEPU2Bp2uRE+guWAP/iQcQMRjM2IoXuJQ+EhLiy7d
WND1gYcSVulZA8e1xU163+EEvSgTY7fgGpSiwo50oz8K6mx2hjhNy0IKYyKFizOa
YiGhbzyQqZ47atSRVPbuDCOMIGms8K6Xrt2C3Tg+yyuCDzh5OUPsjmNIXCiHPYeQ
vDi13/cv5Po23xV5bS5J1GShONqAzd59AqS4BpC2PXtAuLxdypE6u+R1JF/A2g4o
0WVEk+HciuYEmx+Qfndi0mKHIFUJ9lDIz30QY3+ButkOHTov9Pwv66c2DcwI876n
L1DxBNWkNKP78sZZRe/opakjI36PCg8pv3/x7nLnydx05wMBuKcIfEZZbMhm9zDc
6OqxgPSKu/gJXadsHGQHjWetFGzd8/aT69tSaiWqfXpggNRPaOtRHrd21tcHJMCM
pSMnYldejUe2GQhsIc/O6DcdPQoTymL8bdpqzLEHO5iNdk4+1YgiFHn1qQEraEz1
1gtx7NUx4NqfEL63oeBv2sOAwldnetj88UPSp9uEhPKYrQeGWtXA1QjZN4QTU/7N
D2p+0gLS3Rx7fDZaLiHlfkODsJRgaC4U1ULjm5NEXeneORTUUq/XGUaWxuBEegYo
4kbCp8TW4LlPLgtMm3M5k6SK7m1BWOkD0xXuCjn5GCYxP9dPkxWAO2FdBqX+DO98
SywIXfl5ygLFvWiDhkpa
=YWGO
-----END PGP SIGNATURE-----

--aFi3jz1oiPowsTUB--
