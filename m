Return-Path: <cygwin-patches-return-9844-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87188 invoked by alias); 13 Nov 2019 09:38:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87176 invoked by uid 89); 13 Nov 2019 09:38:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 09:38:04 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1McpS0-1huw361JHW-00ZtzX for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2019 10:38:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9A56AA809F3; Wed, 13 Nov 2019 10:38:01 +0100 (CET)
Date: Wed, 13 Nov 2019 09:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] regtool: allow /proc/registry{,32,64}/ registry path prefix
Message-ID: <20191113093801.GP3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca> <20191111172859.39062-1-Brian.Inglis@SystematicSW.ab.ca> <20191113084621.GK3372@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="La/RrqhzniGiVaa5"
Content-Disposition: inline
In-Reply-To: <20191113084621.GK3372@calimero.vinschen.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00115.txt.bz2


--La/RrqhzniGiVaa5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 588

On Nov 13 09:46, Corinna Vinschen wrote:
> Hi Brian,
>=20
> On Nov 11 10:29, Brian Inglis wrote:
> > The user can supply the registry path prefix /proc/registry{,32,64}/ to
> > use path completion.
>=20
> The git commit message does not outline why you're changing the example,
>=20
> Given that the example doesn't use /proc/registry anyway, what's the
> reasoning?  This should either be a patch on its own or at least this
> should be mentioned in the commit message.

Sigh, I accidentally pushed this patch as is.  Never mind then.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--La/RrqhzniGiVaa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3LzvkACgkQ9TYGna5E
T6CzyxAAjmcAptcCTN9K35t+2JNsPqp9N5X4GVJK/zXAhMqmuLHTb4Z5K5miFYnz
It10gH6/2KblQDlWSDOXtACNx80KHNsvh1suEQJlJlSIB2mVkbHGOJ/ssvOHyErD
1uuUmms6BNrb9PL/6ukXQAgftYjL91a+R449tqwJ6Ed7RSC4bRg0Ty6ocNdNF7J6
BM7Mer4dFcrbHNaUsKd1ZQqRYSMusX/4FLQ5UU8ZDbni4DuyZOY0xFSUzqU1O7P4
83AOtkLVZXl/yH7zv2foiJddfs6ZcbfqF+XWDiZa2xdxIOuVwoMx3nG7DeqLxpyg
+h+zfvli3nRkqfq5/FwTVGeQ/I6Sy+SCxwoROM+HP8bc6LCPckP/aAh0NHwLhWLV
h9VQCD+EGxVd2pStNxIHwLCcioHNzco6jZxYzTIPXyuA4c0g7G5My6Bh8jD968Kz
AoHkyufw9deOU1oA3o8fusw7tSC/KvQOBcJK8DsUM9GW1u3BHzP90Orj4TxmuGII
L0UJ155ihsiT03zXYOl3wSaSd7l/QvkPy+utRfSpQ/Y1zN2qHZZn2SmBy99mFn01
qLoCSH6Xb1Rx96gTIhuzUFUN9vN7uTwC6PIdyOfsSktht3apO3Tytalyd0LNQ1KF
oh6yQ3ZSjH7LymIkp+jEB8AjEdCF5MIlmH7aykiMfnyxHJaQDL8=
=bqlf
-----END PGP SIGNATURE-----

--La/RrqhzniGiVaa5--
