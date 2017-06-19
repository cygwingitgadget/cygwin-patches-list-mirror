Return-Path: <cygwin-patches-return-8788-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2075 invoked by alias); 19 Jun 2017 10:55:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130764 invoked by uid 89); 19 Jun 2017 10:55:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=erik, H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 19 Jun 2017 10:55:48 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D3600721E281A	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2017 12:55:48 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 001935E01FB	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2017 12:55:47 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D8011A80648; Mon, 19 Jun 2017 12:55:47 +0200 (CEST)
Date: Mon, 19 Jun 2017 10:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure that send() interrupted by a signal returns sucessfully
Message-ID: <20170619105547.GB26654@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170615133008.19708-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20170615133008.19708-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00059.txt.bz2


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 674

On Jun 15 15:30, Erik M. Bray wrote:
> When SA_RESTART is not set on a socket, a blocking send() that is
> interrupted mid-transition by a signal should return success (and
> report just how many bytes were actually transmitted).
>=20
> The err variable used here was not always guaranteed to be set
> correctly in the loop, so better to just remove it and call
> WSAGetLastError() explicitly.
> ---
>  winsup/cygwin/fhandler_socket.cc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZR62zAAoJEPU2Bp2uRE+g7QUP/35NEXBq7V3IIEZUQsVOTxwf
C5juM0NbalgCHpfNOW5Z7RmaXcCeqQyUCKgLG7EUKIu9CRPmJPfP4x2H8Y5l5n0r
kADdKbZuf76CFYWHEReFRA77Xx+gxkEqLCpB/736RzZxiNMbT4nKQIhRF0PyLpiC
jXTTIuARdDZKbQlwZxvyOAByUJWgIZ8Fx8IQCM5TKUNsZfojuSX9QhmLsKLZQax8
W/8XWWGUareJF+FWDUhVWXxuMIu0b66kltg+Mh+RghQiJq4uYFeFJa3th7t9eFAl
t7hjsFrHw87Ny83qMx10ddBG+mhSXtObn3OixR1LWMtv+PtYtga6gBs2sqgD1uLI
LK4KPdG22VuKLSKlQ8kyUwRt3rQnu9QMX9MjplxvDHYD+LZ8R4q1Ig63VDsrDOMQ
VvXkDy9IoNoXNIV4cBauJ39sK8HIpEBtglijm9Gzh1OlOaGC3Gp4Pi40QKDrzfE+
6iuwMfRQk0R//8E5xytDgYEuX408zOOcsz9AEYF8Uf3+/O8gojBlvImr+f0VrFCz
ucTn3tSJkDdn1i44Vlf42+k5TInJtHPfuY5pOI7Nodizv+cOFuUC+zSnXh6dq7xu
No0/C0J1R6p+iuCVmThahgaspj7mC/tV3ZO64vo/fFvXjW1wFMsNm1oV1GY/oXuy
km4Lgo71Nq0ckIV4MuHs
=2ZAf
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
