Return-Path: <cygwin-patches-return-8694-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80134 invoked by alias); 12 Feb 2017 11:37:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80116 invoked by uid 89); 12 Feb 2017 11:37:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 12 Feb 2017 11:37:09 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 559CC721E281A	for <cygwin-patches@cygwin.com>; Sun, 12 Feb 2017 12:37:06 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id AF9E65E0210	for <cygwin-patches@cygwin.com>; Sun, 12 Feb 2017 12:37:05 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8D271A80CD3; Sun, 12 Feb 2017 12:37:05 +0100 (CET)
Date: Sun, 12 Feb 2017 11:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: (fixup) [PATCH] forkables: use dynloaded dll's IndexNumber as dirname
Message-ID: <20170212113705.GH11666@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9f8649cf-0293-cce7-f4a1-84433d62152d@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline
In-Reply-To: <9f8649cf-0293-cce7-f4a1-84433d62152d@ssi-schaefer.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00035.txt.bz2


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 834

On Feb 10 15:08, Michael Haubenwallner wrote:
> Hi Corinna,
>=20
> as realized during write of tl;dr draft for the topic/forkables branch,
> >=20
> > <damn-wrong reason=3D"original directory may not exist any more">
> >  * The temporary subdirectory name for a dynamically loaded dll is form=
ed
> >    using the original directory's NTFS-IndexNumber.
> > </damn-wrong>
> > https://cygwin.com/ml/cygwin-developers/2017-01/msg00000.html
>=20
> here's the patch, intended as fixup for
> >
> > [PATCH 3/6] forkables: Create forkable hardlinks, yet unused.
> > https://cygwin.com/ml/cygwin-developers/2016-12/msg00006.html

Applied to the (rebased) topic/forkables branch.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoEjhAAoJEPU2Bp2uRE+gecEP/2rSQnNrXTrsmELDrX2orZGY
qWpJLWKTR0pszfzvb8RT8OEYU/yetxIZbFNGzFhrhDQEepJPc0egkGe0zArgrQh9
zA5n0UTpfBJDDmM+gBYAQYYV8PgskffXkjB3MSCkI2/5JtOjBFSNjJMhJTLAMplk
B9ug0Hg0RYLF/e12NKT4ZDVBaehWa4SR41/mIUcJu+g+cxUBVu27MGr681WZO9V1
8vwQXl1NIpVegdXHsNGMeEi09PLLcc3ZrWwK74ScgnudLbKUUvK+SZgXN+8kp31s
9+nKEwW8TrOKOdGJJFr5/HmyBrcdgWDgqNTjc6YqCnioxJpQ231ODipef4dlqTlh
QW9szzm/2KeHzeK3SaB1K9x3ZJCHcUPojQa1Jxs/eg/n2jFv/9qpqBlIAf55CGd9
o3aD6VIYObImo9C4NNDQBtNuQpzDMl376uVRBUfRzh56rU3Mc43+DFkR1TMrVYxi
KtnzmJKG8S1iN5MxVCR6gictJxjQRA3yCvTsHhVL29AXXS9QB4lCS8mWgv+K76Jh
3+gb6bPBttiofSn2MEULmAcEvO7SH1gviL9Vl+t1nPKp8JPiag5wJhBKoGNMEpix
wd3nlOVkoev2HXWbxmk55tCn/nSqH3MO8MYDTzycLguaQbtz62DXV7ZC4upuXHuM
k2e9VRCTyyjTKTbj9+Yr
=9diX
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--
