Return-Path: <cygwin-patches-return-8795-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29734 invoked by alias); 21 Jun 2017 20:47:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29640 invoked by uid 89); 21 Jun 2017 20:47:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=watching, H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Jun 2017 20:47:39 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 2BA0F721E282F	for <cygwin-patches@cygwin.com>; Wed, 21 Jun 2017 22:47:36 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 59E355E0419	for <cygwin-patches@cygwin.com>; Wed, 21 Jun 2017 22:47:35 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3AA82A8064A; Wed, 21 Jun 2017 22:47:35 +0200 (CEST)
Date: Wed, 21 Jun 2017 20:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compatibility improvement to reparse point handling, v3
Message-ID: <20170621204735.GB1595@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <594199C4.9080804@pismotec.com> <20170619114532.GC26654@calimero.vinschen.de> <59481C4D.5030206@pismotec.com> <20170620081728.GB8342@calimero.vinschen.de> <594AB2BB.3060307@pismotec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <594AB2BB.3060307@pismotec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00066.txt.bz2


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1050

On Jun 21 10:54, Joe Lowe wrote:
>=20
>=20
> On 2017-06-20 01:17, Corinna Vinschen wrote:
> > Actually, DT_UNKNOWN indicates nothing.  The sole purpose of this
> > value is to tell the application that the information is not readily
> > available without having to perform costly operations, which often
>=20
> OK.
>=20
> > I pushed your patch, plus a follow-up patch to handle remote reparse
> > points correctly, as outlined in my previous reply.
>=20
> Thanks, and for catching the isremote() fix.
>=20
> I adhoc tested against a variety of symlink and mountpoint reparse
> points. I dont see any issues, and changes are working as expected.
> I will keep watching the dev and patch mail lists for a while, but if
> some issues pop-up then feel free to contact me directly.

Sure enough, thanks.  In turn, feel free to send patches when you see
some problem or room for extensions.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSttnAAoJEPU2Bp2uRE+gWRIQAKbfNUJPBffO8xOCfLCvJmyp
q8OKbbObCnVcBKrQLHRVzJ8jD+yywZToHSf8L1E2YhPtUTAPhXkkD+wmdV7pJzFA
9FuyKXuqwInArWtXRAjGCQQmOpB5LZSrw3KRbsejxngGDio5kQfCrjPQGwj87iqw
SqNiFkItjQVzkERbb2PsGnD5G5nSdlzmhEo81Cdf6EMa3o54gSpZ+oySYTGNZRTH
qTZrkHEFpQVWWtApPywtRj9SbT+wVLyLNlgFqT3i9N6zZ5cas2ozjYRvTv26ofb6
wcxBWw+ZvfeVntroxyfcPuHVGgkxrC/8yPH90GNr4TMkvh9hYr2hXXae3/Lp+WLD
rO9bQbo84WgZq1Hq8lBfH34S4iQ+HTgSruPYxgRZr5DdvAnu2oY5HvE+Xvb9FFzc
lVxOgGdjHm8r6zAqKMo8d+WKXnMuf3MvmPea4q0l9rYHfiSLyk+CLyK0wqvU9lhI
Cbed4/2S48sln70Fy0rWj3mx/VywTIx0wX1RdR3d28u//WQnKx5gO9TvvkIVvouP
gwsKvv8/ytTldvg6Q3bt62eTNzipVvoWXlPcoJ17V4KVzyFyPymfqFvumKbbvcq6
CjiA932dKNJBPO1V737sl4SMy0/bxUl3fHBRrDuKGH3TOUSvTdu6QpfmDNn+TDq1
SgQ8JutRnmK3YdavEwDH
=P9B0
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
