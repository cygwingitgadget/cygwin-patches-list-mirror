Return-Path: <cygwin-patches-return-8935-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72648 invoked by alias); 28 Nov 2017 09:33:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72420 invoked by uid 89); 28 Nov 2017 09:33:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Nov 2017 09:33:37 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id D8328721E2823	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 10:33:34 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A8AC65E0418	for <cygwin-patches@cygwin.com>; Tue, 28 Nov 2017 10:33:31 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2B04FA8072C; Tue, 28 Nov 2017 10:33:34 +0100 (CET)
Date: Tue, 28 Nov 2017 09:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Feature test macros overhaul: Cygwin limits.h, part 2
Message-ID: <20171128093334.GP547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <13d8d4b7-8d73-44f7-5768-a26da81f966f@redhat.com> <20171128041053.3888-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <20171128041053.3888-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00065.txt.bz2


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 419

On Nov 27 22:10, Yaakov Selkowitz wrote:
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/limits.h.html
> https://sourceware.org/ml/newlib/2017/msg01133.html
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---

ACK, please push.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaHS1tAAoJEPU2Bp2uRE+gNdUP/2knP1xwmGWa8XuXpy4aTnxb
BhRVu7bRIMjrLKJB8suvcCSjN7QoUfGcR5izedWZTSKywhdS6z0qPPoFM/OZf3+k
+vwifG3d6ehZMrI/jL2Cv8NRXit2KcaDAIc45lyIfqtkgXHiaGLDvIJtatYDA4zR
FrNHGXzTXcJrs3esAoWUv3OlQC7oz37BO/YulJSdcbntMuCbJ/BLX/dq3xl4NcvP
Y5yR+BV8RkT32EE9xg4gFW+371dNqhxX0F6TAlwNDBOq9ynJfIC4UPHe8Srgb+ET
548Lza+fGFB2Q0rkIXdb5G8NyW8BMHl6Sq5AdlhSvSnnswiJEb8UrbjfiVtB8hCv
qU9Jwk/ARUVwQNjssXO5dAnkWeZbB1zUfcwZytW/OCMS9rQMGsFR1krnsC4KXz4z
Z5csFXA7a6sOWzDIEuY/Ce9OHSoepo0FNall6ukQAUiMEuiQZxruVvf+2hNc8TR/
g6VxYB1mdtJnLpfpR6d5BWQwS19wZHuFAiCJNcK+kw+3zP0JUH1AHeSLmVEtZ2UJ
8IpChb1hH81Yg4UxwWjmiS6OKCaMMtrvtJvONzDWlLkc5BxtZfY+Qgco28N6WDyQ
XZVhSGpbLzsIPW74hpIFWtDhYhtY/fJPfngvOo8ye8WSesPULSY45Cvk5aC2b+DS
FBlBeV+je9pVWM54tpkS
=PW96
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
