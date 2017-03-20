Return-Path: <cygwin-patches-return-8719-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37726 invoked by alias); 20 Mar 2017 14:08:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37656 invoked by uid 89); 20 Mar 2017 14:08:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Mar 2017 14:08:43 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id AE3B2721E280C	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 15:08:41 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 006B35E04B7	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 15:08:41 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DC362A80CD7; Mon, 20 Mar 2017 15:08:40 +0100 (CET)
Date: Mon, 20 Mar 2017 14:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement getloadavg()
Message-ID: <20170320140840.GJ16777@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk> <20170320103715.GH16777@calimero.vinschen.de> <19337cb5-19f3-5ebc-db08-2aecc1a01924@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <19337cb5-19f3-5ebc-db08-2aecc1a01924@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q1/txt/msg00060.txt.bz2


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 481

On Mar 20 13:05, JonY wrote:
> On 03/20/2017 10:37 AM, Corinna Vinschen wrote:
> >=20
> > JonY, any chance for a quick update of w32api-headers to include the
> > patch from https://sourceforge.net/p/mingw-w64/mailman/message/35727667=
/?
> >=20
>=20
> Sure, I'll try to churn out 5.0.2 with this fix by next week.

Thanks!


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz+JoAAoJEPU2Bp2uRE+g/+oP/j0xgEJGRmJEk28LxloetBSa
rXbZCLVZF7X63yXpRb4BkYn/n45xI8lFafKPcnV3uooIGWZI0I/WLtReuPkvrsZc
isk4jxp/xEf2xQZtD3D6+LHdKufx6GZOGWcFJiBYzsCDwtGud8kl4DUheD1WS/De
f3fodlv5Jd0gMyNsipSg+XK6S2VLXZRhG97Bx7olU7swtQA9ZUKW13NNowP0DnW8
Wb4DGVOyKgciVcWP0qnwGvfF/wky01M7dqpLS0YCpsv60iGh2ehXD3mOyAguSX5v
QMK5i8JB/A+wH2SouI61CK/nGa+0RhsuTc+gZV9lc6mBLfLP4na/xG1Pk00UKdj1
RcdcFT2xI0Yy3WGeqyfpLX1b5e48R2VEsD7br7kg7Nz+dFcoIaGWkgr+Dvg/oPsQ
odGllDMvW10ieVDRFaJSg/s1+sVp8PnBemH6XiftQJ3XgL3t+Ma5DPACbUjy9Kuw
EqJP/t+ZGcm6eJ8dw2t6uVezxyGbcV2dNc/TuCsXen26WRi3/0uXevL3Yo7bPkL2
TDfdyr52jeSnJMke5NpBnLf4xyN/5rQgetTKU8Bqzlgu6ANlSieBJIVeu3MVF265
Qsn+ufVO5Fm/w3qLdn2+PpLEA2+fQ8GB9e+v5fkyxg+ussM0XOZNF+6vEGsejIyE
UKWX3zw2IHj4Mj4QJQg9
=As+D
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
