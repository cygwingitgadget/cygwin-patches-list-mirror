Return-Path: <cygwin-patches-return-8691-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53877 invoked by alias); 6 Feb 2017 09:54:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53859 invoked by uid 89); 6 Feb 2017 09:54:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=anchors, ids, Turney, jon
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 Feb 2017 09:54:44 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 71D3D721E2830	for <cygwin-patches@cygwin.com>; Mon,  6 Feb 2017 10:54:41 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id C9F235E081E	for <cygwin-patches@cygwin.com>; Mon,  6 Feb 2017 10:54:40 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B54C1A8040B; Mon,  6 Feb 2017 10:54:40 +0100 (CET)
Date: Mon, 06 Feb 2017 09:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Make anchors stable in generated Cygwin HTML documentation
Message-ID: <20170206095440.GA15509@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170205134508.150092-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20170205134508.150092-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00032.txt.bz2


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 301

On Feb  5 13:45, Jon Turney wrote:
> Give more elements ids, so random ids aren't assigned to them, so anchors
> are stable between builds.

ACK,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYmEfgAAoJEPU2Bp2uRE+g5f0P/1hXpPLx/AMgIOKRpWaSfAvd
YSXu2WDzfsrnq2G1xHo6VEW54C08yu6dIJo7rW+y8aVT/XMWQFmzXY4Y9CYQoOWR
kCEjnvqDN+PvWjQdMgKNaMOpR2TSFfYMcnvAUOSPbnecewir3n+9bjIf6p8bbUvf
zL7g4R7aoWy7xYr46cjiIRv8xO3uvyPSivEMgBKWpa4eqH/5goRbUmcdsY3jywGi
w7O7WaCDkSHO1LwkkD5MJgn3RzxsbdWsja/eUYEVbEGK3Rz8WULiE7zQPi9oEEDD
JQ2DwhiBv7JIQs3+2+Q8KPOMbU7g7HD7JhqNdZMIRDweGCqe8e8wRwg+rWsbMnAb
mEFcbaM37pWwdl2k0SWHeTpt07bVHJBz88rIKJlqDKdon90rUdWoVGo3ZHuVl+21
FifwbTS6PVzuspblbSqpRM19gYapAZsIXzsEPdn9z9aN1n/pE7ctrx773d2P9f7e
KX8x80xI5jDyeGlZRGMSDP3ofHhZ52rG2rK6h/qtB69nhV9hDmhXReiO5pO9pVDH
fFrNdRKz8dG4SPyBtqqBXEXBo5U7w0rgWt4OJfGsIG7Pug3Y4d7WlOkKRM+Gil4c
UvKta6g4mmDg62z1C7i7qkcOcaUUiEMKOJfupIg35wyCwLRV5SKAsCFtIHdw9Ptx
yDXnwwNbjKg+MW/ilUnL
=whVj
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
