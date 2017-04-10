Return-Path: <cygwin-patches-return-8737-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10073 invoked by alias); 10 Apr 2017 08:16:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10039 invoked by uid 89); 10 Apr 2017 08:16:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Apr 2017 08:16:38 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 25779721E281A	for <cygwin-patches@cygwin.com>; Mon, 10 Apr 2017 10:16:37 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 8B91C5E03CB	for <cygwin-patches@cygwin.com>; Mon, 10 Apr 2017 10:16:36 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6F97DA805DB; Mon, 10 Apr 2017 10:16:36 +0200 (CEST)
Date: Mon, 10 Apr 2017 08:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Avoid decimal point localization in /proc/loadavg
Message-ID: <20170410081636.GB2848@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170408125537.15728-1-jon.turney@dronecode.org.uk> <8a034d22-0b06-c2e0-34ed-fa607ec90257@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <8a034d22-0b06-c2e0-34ed-fa607ec90257@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00008.txt.bz2


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 626

On Apr  8 12:18, cyg Simple wrote:
> On 4/8/2017 8:55 AM, Jon Turney wrote:
> > Explicitly format the contents of /proc/loadavg to avoid the decimal po=
int
> > getting localized according to LC_NUMERIC. Using anything other than '.'
> > breaks top.
> >=20
>=20
> Would it be more prudent to update top to be locale aware?

Not that it hurts to tweak top, but the linux kernel prints this with
decimal points independently of the locale of the current user, too.=20=20


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6z9kAAoJEPU2Bp2uRE+gNiEQAIVjSnFlci2JhBB1YaVjtYiX
kIRupaejR61MN3PG1zd7mO7bUlYgaTcSc7EHn8TjrfHHUMx/klZUE1gNkiIxzKne
9YLTe/fQ+TMxz9k/4d2Gz50Lsxf0Exek6frWtTiQGeXVK92qTwt2IeCPfhjsFymH
io5xf82xsCcYaOxNc60k9cwu4dvhUqhY3MxBXkvyLWaMv33GnT3CSHIgJo/PbLdA
tck+OgZr9LsYV/k0Ij2n/jlzfb1QzsuVtKozARquS2zpG5oYL0GtnEnKFPg8xRyM
sM76BA/iOuZi/86lhkYEjFmV6MuN3hkvdipjFLZMgd4jqOdq2DDxGq2cLKGzm2r6
NFntTqEFT9SB8PDpSAD5Sl2oZk1KjJh8iJwE3oSZM6nCEhtiMlv6IfI9EukIbrXr
NV82TBp4gNmS3jh3f5IYpUWL6fT2fWRxuKUT09dKjSfCdZgRCDUAvvHmECebH3O1
SxkhDf83B9/0WDRHl/kvmDXjX/ccXJQTrVdj4qvzz8RRhBGv2Z783Iohsnv8pEYx
Yz4qYsbQF7citw7Tyw5ljADZ6pmNGPfjVR0/98p0pCc3ePMYH1Pl0ZzlVLGPsaNj
PgtmUVw8aMsA6PQf9k9C0xFKeLwiEWuy7QvWeK4SlXWBxuc4cM+rbzmRIiNQgxkP
YiDwkeghaud9DNZ6Ea6e
=qe2A
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
