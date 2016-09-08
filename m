Return-Path: <cygwin-patches-return-8637-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91204 invoked by alias); 8 Sep 2016 11:59:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91178 invoked by uid 89); 8 Sep 2016 11:59:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1261, DOT, H*F:U*corinna-cygwin, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 08 Sep 2016 11:59:01 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C25F6721E280C	for <cygwin-patches@cygwin.com>; Thu,  8 Sep 2016 13:58:57 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 219425E01C2	for <cygwin-patches@cygwin.com>; Thu,  8 Sep 2016 13:58:57 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 18EE2A80308; Thu,  8 Sep 2016 13:58:57 +0200 (CEST)
Date: Thu, 08 Sep 2016 11:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/4] dlopen: switch to new pathfinder class
Message-ID: <20160908115857.GA8359@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-2-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160831191231.GA649@calimero.vinschen.de> <09d08bc9-d430-f6e8-8076-e9f9ad992fd9@ssi-schaefer.com> <20160901140327.GD1128@calimero.vinschen.de> <3cd7bff6-2e56-addd-d9ca-88e203dfb337@ssi-schaefer.com> <20160902085213.GA7709@calimero.vinschen.de> <bd3e33f0-de36-a65c-2e28-ff8bfdbf2d22@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <bd3e33f0-de36-a65c-2e28-ff8bfdbf2d22@ssi-schaefer.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
X-SW-Source: 2016-q3/txt/msg00045.txt.bz2


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1262

On Sep  2 13:36, Michael Haubenwallner wrote:
> On 09/02/2016 10:52 AM, Corinna Vinschen wrote:
> > On Sep  2 10:05, Michael Haubenwallner wrote:
> >> Moving the allocator into pathfinder would work then, but still the
> >> tmp_pathbuf instance to use has to be provided as reference.
> >=20
> > Hmm, considering that a function calling your pathfinder *might*
> > need a tmp_pathbuf for its own dubious purposes, this makes sense.
> > That could be easily handled via the constructor I think:
> >=20
> >   tmp_pathbuf tp;
> >   pathfinder finder (tp);
> >=20
> > Still, since I said I'm willing to take this code as is, do you want me
> > to apply it this way for now or do you want to come up with the proposed
> > changes first?
>=20
> As I do prefer both pathfinder and vstrlist to not know about tmp_pathbuf
> in particular but a generic memory provider only: Yes, please apply as is.

Done, minus patch 4.  I still think that there should be only a single
pathfinder object and the rest encapsulated within and called via some
pathfinder member function.  I'll look into it later this year.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX0VKAAAoJEPU2Bp2uRE+gojUP/226mWTQowpjETO4W+D0qrZ9
InZ0Xn1ERIxujWFSYZ7UwDTxWtGHWTQQQl43OceL0Kf2Pwagq5h31hzk7Tdpcva7
JGFE3j5b6m2DDPF4rKNBLT4Y6lp6UhYIiQqyWbRo6RZ3nceCXPKiKCe76BTtxbTX
hen3D6fgZ0bBXFweHH0IP4K/OFgHJu+RaeVdHuzQ4V/jA6TjzwsdaPwfaBJDq9Ge
/o8gqQQIZVlkNbxubARn0GQoqgLl8vh8NYtq1w2CfFPdEIDhPGyU2R544rd6IxOD
a5KCoOkVIZT5WZfnuosDUCPbeRX+UrXYtJdDlwvrapNDzDnac0WnmIyvw22r6pLE
YkEcVOo7vLWUAyGMp063lxHEAPYKMX3W53dmkjiEzYk4xZg0kRFjjOEePMpkm2mY
evIjEcdccOQ/T4rt0qVt+mtksnOKPsEK20Yu/fYuKOaXKvR/8MhEmY6c1FR2amp7
bXJNG5RgUukQQTwn3s/sgU7i4eJm8tjT6/ihzAN9dcXr3hADzkVhmRN7EbjEV4ig
8T/9Fi5uY5aHZXVpOtSoXBImol5HbXWpsufzNnqtkTqwU7nI6SVZw5YdvOe2hDE6
FMgJY4NdcDw0TXfq6PYaGHdta+myk5tG7iemgUjb2necd6Azoq5ir+RBImm/IAvq
Jd39Vk9DkkS71lP/JW24
=hH9o
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
