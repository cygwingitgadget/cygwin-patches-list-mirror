Return-Path: <cygwin-patches-return-8682-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38955 invoked by alias); 11 Jan 2017 16:03:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38943 invoked by uid 89); 11 Jan 2017 16:03:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 11 Jan 2017 16:03:08 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 90931721E281A	for <cygwin-patches@cygwin.com>; Wed, 11 Jan 2017 17:03:04 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 240D45E089D	for <cygwin-patches@cygwin.com>; Wed, 11 Jan 2017 17:03:03 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 111E5A80405; Wed, 11 Jan 2017 17:03:03 +0100 (CET)
Date: Wed, 11 Jan 2017 16:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] FAST_CWD: adjust the initial search scope
Message-ID: <20170111160303.GA23119@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5b4e3785c193feb56fa31eef637db2641e69eefd.1484140876.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <5b4e3785c193feb56fa31eef637db2641e69eefd.1484140876.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00023.txt.bz2


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 716

Hi Johannes,

On Jan 11 14:21, Johannes Schindelin wrote:
> A *very* recent Windows build adds more code to the preamble of
> RtlGetCurrentDirectory_U() so that the previous heuristic failed to find
> the call to the locking routine.
>=20
> This only affects the 64-bit version of ntdll, where the 0xe8 byte is
> now found at offset 40, not the 32-bit version. However, let's just
> double the area we search for said byte for good measure.

any chance to convince the powers that be to open up access to this
datastructures without such hacky means?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdlc2AAoJEPU2Bp2uRE+gNjsP/3xljO701Agyrij98m5LfgjN
JXjIumpB1blgS29Fj6G1siSC9uE7eih6hmfXZKcuEiXdgR41zPWxTUGs7aQ2zshQ
N/xutRcoc/6foIPjz+n3lOgBJjRkXgte8g4Bhj0JfHopiEYaoM6HD5lY45vFupbb
6KFqrOiIpx1ZgTb6Gau69g1jk8PLKowZ0CF6236VE+MTTzTW37w9svqJIabw0Ne+
zzVNNFamu0rx7XVPzl2T2CogQuz6nz5Lys+eo/yr+VIQRViH4tHp+2SE2NdexTnR
l/F5StFmc9tBx+ltImFRuqRspH1pp3E91us4DqHpbHZKMZWAuCJx408yMomOrhYY
OlMwL3ZVwW5AeI3y0k2C6jT6JAGMyqJoAP4ySwU10LnGWhRx1c8RiZUzlARrfkEc
wNei0GBObdrY+J83bP78M2KXqFsoKm17ysaW8PZ22VFO/JjuHsgfevapwf4M1tOb
GQhxLjz89JjxuYL6n9Auan8QpvC8FT9lszCdYkzn2jAxAL8uielCxV/C9XuHdeTP
ZSJPyUt+4i3qhw6ZkrWN5o4ss2Vl1vVI9mT1H/lMme0HZHoI1HTPHVrb1HrV6Ivu
qSEkhuwS62X/CAvWN4J6cfXuHbMEWR1OsZaWTR7ECJIZ0CxCLUlnafuaMILSUo4S
/3tNiGQ7ToFTkzqBUnzn
=sD+F
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
