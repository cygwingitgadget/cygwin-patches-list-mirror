Return-Path: <cygwin-patches-return-8999-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31847 invoked by alias); 17 Jan 2018 09:13:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31834 invoked by uid 89); 17 Jan 2018 09:13:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-110.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jan 2018 09:13:22 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 81B58721E282E	for <cygwin-patches@cygwin.com>; Wed, 17 Jan 2018 10:13:18 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 1B0FC5E0362	for <cygwin-patches@cygwin.com>; Wed, 17 Jan 2018 10:13:18 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0C100A8095C; Wed, 17 Jan 2018 10:13:18 +0100 (CET)
Date: Wed, 17 Jan 2018 09:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: add asm/bitsperlong.h, dummy asm/posix_types.h headers
Message-ID: <20180117091318.GC18814@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180117090521.11992-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20180117090521.11992-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00007.txt.bz2


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 688

On Jan 17 03:05, Yaakov Selkowitz wrote:
> These changes are necessary for cross-compiling the Linux kernel.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/asm/bitsperlong.h | 18 ++++++++++++++++++
>  winsup/cygwin/include/asm/posix_types.h | 14 ++++++++++++++
>  winsup/cygwin/include/asm/types.h       |  2 ++
>  3 files changed, 34 insertions(+)
>  create mode 100644 winsup/cygwin/include/asm/bitsperlong.h
>  create mode 100644 winsup/cygwin/include/asm/posix_types.h

ACK


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlpfE60ACgkQ9TYGna5E
T6B3IQ//dZd2sAe2zmj1BPqnMjEY2ugS65P2NK6AJijZn0aZH15/VvOlDOuf9NIM
2/UzuY4gzYdYwpNvrIj06u7fsFF1OPJPNa+4lXlOlqy0/UFvElWxnkTOigYTEm9Z
zHKjWnOPWfno+zEuWy0Ore1NH+X5MUbShRmmfm0msKHW06dQqSrCV2aRo/wwU5GY
35fLOmsIxq3hBNhpJN1zOOlUsgPPKPw6Jn4HuWAQhiLmWhrp9dOBDgNPSzJXRFsT
gTboYi9YrDrdz6vKuTaT9hwgeHb+mzH1n3ywKiQWW9Twq4b69zGgv0EC7flX2ndW
6PgB6itmCZaUhVGH9q+8Mhb4Whya4NHymzjEu58KX/VZvJKFp/1CDRFOewRQ+Ylf
ZGpTgXasDoJ7c/q+GbdS6ocQlUNGSuv/fO+ZIX2Vz7OhwMthF1KEO4FOyes593ZF
tSZ2bthOxN4nkoQQIzE7XNtschOJK9pJJNYeECWqwyYOrcRW5JXvlqYnKr8rj3+m
Lo7oOCilXYH6f5V3nPMGFFjDPallCr9/drLSjudx5umW0YtjC5U3NqvBrmaGVUaa
RglJW8ubQKFgAZiRvYikt7i4vx+g2EYpShHDUU2Y7mR73SyF4VeyGspOd2VL2BMp
mIDFiI11utVLyoUFdKK83izuz+UggjRuH8zFzN0884BL+Yz0reU=
=CBnQ
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
