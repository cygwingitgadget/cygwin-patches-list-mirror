Return-Path: <cygwin-patches-return-9488-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22036 invoked by alias); 17 Jul 2019 13:50:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22025 invoked by uid 89); 17 Jul 2019 13:50:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*r:500, H*F:U*corinna-cygwin, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jul 2019 13:50:31 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MmkfQ-1iCagz2O9e-00jpkz; Wed, 17 Jul 2019 15:50:23 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 69C8BA80769; Wed, 17 Jul 2019 15:50:22 +0200 (CEST)
Date: Wed, 17 Jul 2019 13:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 4/5] Cygwin: fix GCC 8.3 'asm volatile' errors
Message-ID: <20190717135022.GM3772@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190716173407.17040-1-kbrown@cornell.edu> <20190716173407.17040-5-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
In-Reply-To: <20190716173407.17040-5-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00008.txt.bz2


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 264

Hi Ken,

On Jul 16 17:34, Ken Brown wrote:
> Remove 'volatile'.

What happened to asm volatile?   Can you add a short description (single
sentence) to the commit msg explaining why this is a problem now?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0vJ54ACgkQ9TYGna5E
T6CS4A//S0tAOuMPOK1UpBLEgL6bs0hXpz4ZlJWhfBHYAQGTLVRX5FL2HnQ2Um3t
PlkF8yALS/IfTWVxarHUUU+UjquuPz7mda24mXLDM/UA1Z2oBhN41KgzRdXjyXoo
yq2NZS/LXJyX4fncoXIj45nSn13QErhKb6pmiu/g/OlwmQpcGmQtmUIeMMBKECvD
zISEIwbGOdsabjdnYt0e0okjHqCyDh1L0dYCDlrEbKrFge1Ba8Fh0MqyEUCZlG6H
Zdp/xc73htCytiP+6MuepLVZJh2Cn0Le/X4u1FAVHLlMBLAW/aIasbicc2zdKiy+
gL7T0sIIRXIzO+wMzA+J/Q2oJvPwofqXeFwUFZyxF9qoH1BiyKoWKq2vBti8bptQ
EOIwFEcTRer5zR0bnzI+a6bT3XzV+v7hssB5MzRZvYKA7Oj4yfvkHF5p3nmLa3OY
Ff0uBP49qFdCZci0g4tUfXNeLdxASsajLhIFj1vWTQD6rMx5UbImArYU04EI1wbp
wCvM1Ly9HmD9OlmlabydbPj9hssRYwHwelT+7IMO86Eprl0W+pQuQI7wqaiZEoTr
kqX7BVifK88hufEFnYpMVRdzEi6JwCuNVvWMPsH7szZPDDBRaskPp7fcvfSyoXqI
LtfLtwydyis14J7CigGGN67HeU2BRezbTxEo9bVn96CQ0dNFTmg=
=2atr
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
