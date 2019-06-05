Return-Path: <cygwin-patches-return-9435-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88362 invoked by alias); 5 Jun 2019 11:57:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88291 invoked by uid 89); 5 Jun 2019 11:57:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-102.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:400, H*F:D*cygwin.com, website
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 05 Jun 2019 11:57:38 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MZCSt-1h3TIl3Y8H-00V6ms; Wed, 05 Jun 2019 13:56:54 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6BA12A80667; Wed,  5 Jun 2019 13:56:53 +0200 (CEST)
Date: Wed, 05 Jun 2019 11:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ben <cygwin@wijen.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkdir: always check-for-existence
Message-ID: <20190605115653.GV3437@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ben <cygwin@wijen.net>, cygwin-patches@cygwin.com
References: <60c1e83d-59f1-6b7a-80e8-05bf41cc6947@wijen.net> <20190603193414.GO3437@calimero.vinschen.de> <dff7bebf-9fee-462e-0b77-fced83963d29@wijen.net> <20190604074136.GQ3437@calimero.vinschen.de> <82a42b1d-2ce5-c9bd-8d9e-9a02d62ce31d@wijen.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="VZEZlOQeSr/zV9d3"
Content-Disposition: inline
In-Reply-To: <82a42b1d-2ce5-c9bd-8d9e-9a02d62ce31d@wijen.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00142.txt.bz2


--VZEZlOQeSr/zV9d3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 366

On Jun  4 19:44, Ben wrote:
> Hi Corinna,
>=20
> Please see the attachment for my patch.
> My MUA indeed replaced the tabs with spaces.
>=20
> I did notice that the indentation was mixed tabs and spaces,
> but as stated on the website I have kept the surrounding indentation.


This applies fine.  Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--VZEZlOQeSr/zV9d3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlz3rgUACgkQ9TYGna5E
T6CfyhAAkmcO10sWkx50P8SIPjwO8HnPqoPl8Ey8Q1+ayAhmE1pxZB1vDgN23MP9
MRs88Bym8k3fgQHkhhznvXT+kccW8V4ge4wz+NnlppX+uZ88al9Iq8DhRdHf9hiK
DjKyntNIM18nlHFTJ15g1cwFow+3pg69IP7AiBfNwqVxgBplLbUkZIdRjOiZraF2
SeO+6S4NUZFWWynGB6hSLdO2yEYy/kb6vhIAIO/ucXVepG5fBLUkg7FOWjqpmMEt
xWwdl7HXHS527tTafvYNN/39r2mo7oK3p0UqGGisyVMcFZfwAUyjwTLK/7gs/VE9
CLd0Ppenr0CKw8xgAgpMe3QCueqndE2bS0Sd62tInY8m/jnqd33AXgZ1XjVkfH9S
I1AaHFDCPixzFlsAlWziRt5MWIUeJjIrgPc1ilZ4xvKdUOHg0YMxTYPAmFID9lrL
IpCu0+Qa2Ll2CeyBcKp7ASC2HYaMnGyfyRXk9blHxOeQtAHi3ya7pL21857/PXE0
NCTRLc/w8ebioo4vvCpHsJwIEyRiPlLj4RmErwh1EVqW2IWwIniJzrcYedfgc9/3
17r5eFaOBjeCLYbZ19FsEoIeKOHJjj5qISskEIBXEOfZcfbCg6MM9RGtXQ+5YpMC
9bZbroKG14cNJl2Iy8h3X2wAEF/FoutExkPaN0+OK+O9wNKsQn4=
=LSa/
-----END PGP SIGNATURE-----

--VZEZlOQeSr/zV9d3--
