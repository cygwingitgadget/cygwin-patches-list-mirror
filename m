Return-Path: <cygwin-patches-return-8392-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120618 invoked by alias); 11 Mar 2016 13:04:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119568 invoked by uid 89); 11 Mar 2016 13:04:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-95.2 required=5.0 tests=BAYES_05,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, HX-Envelope-From:sk:corinna, H*R:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 11 Mar 2016 13:04:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AF1A6A805E5; Fri, 11 Mar 2016 14:04:29 +0100 (CET)
Date: Fri, 11 Mar 2016 13:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] spinlock spin with pause instruction
Message-ID: <20160311130429.GA30865@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAKw7uVgrjqZVznRMoCbsjyz4YXast5YtAAmpWQorOw7YXqbOhw@mail.gmail.com> <CAKw7uVg78t2V8KKLYfPyhb97XjU+aUb4KV-poz7i_wwDeJ6b=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <CAKw7uVg78t2V8KKLYfPyhb97XjU+aUb4KV-poz7i_wwDeJ6b=g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00098.txt.bz2


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 508

On Mar 11 11:28, V=C3=A1clav Haisman wrote:
> Hi.
>=20
> I have noticed that Cygwin's spinlock goes into heavy sleeping code
> for each spin. It seems it would be a good idea to actually try to
> spin a bit first. There is this 'pause' instruction which let's the
> CPU make such busy loops be less busy. Here is a patch to do this.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4sJdAAoJEPU2Bp2uRE+gGJ8QAJe519DVgV5n3tXzGRKd+35I
f+NRW468sfjQXAczxXrKh/aTuA/ZA7+RAI8aJMYyxthafe8CK6VTmatHO6xaydmw
f0XsDfJGhkrjxYGNJD1DWt3sEehWnDxeYnw66AfojeaEZ8O901QtYVvGUxqrqAAI
gaTT/K2BqMqhVhABiZkDe158cszZZOJFs2hiFguu28J8a7YA5HnI87MTBGFYMamg
8XhBKZVLe1AnKOtcED/rIWi5hzrIRGdnKQVDOAD5Rx8HWhbWxZC5UBCBr4C1Lq3i
VzOpOMGsL6QiJNm17HR5GnbMPhpgbhr4KCBZkKQgeBL1s8GLoWOnB2e4mdSf0LJK
rTHF4n1Jl8WP1CHw0RYmYyh/NTAml/yFIKX5axhC2EcM+POKnQF3PaxvgtrBBqd6
a9jBY/bnqp1flNcnc0cBW8gFsKYNALnx2bUCXI3f2pjRHXy0Bq2HEIt7iyuByzJW
oATnz+ppNbRiyVHO960aPKpBDb8gyyG+MLzreDZ1O206CPuwhxvwb4EmN+WNOFtV
ZG4a8P0DCNq5dNGVQGpn9y6HLmXuSTJNEbjsnvx/QUCt0ERwl8BrFgPfS9/SG1gg
jmcax7JWZsI8qFKhmpS9bwfe7hwcq8RlgFcHD36etPirXlxI79ba53KiuHMvwJor
CeaZ+eQwFAzprKaDb+9u
=8ufB
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
