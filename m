Return-Path: <cygwin-patches-return-8781-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63763 invoked by alias); 14 Jun 2017 08:51:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63748 invoked by uid 89); 14 Jun 2017 08:51:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 14 Jun 2017 08:51:10 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 952D1721E281A	for <cygwin-patches@cygwin.com>; Wed, 14 Jun 2017 10:51:10 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id C78895E0359	for <cygwin-patches@cygwin.com>; Wed, 14 Jun 2017 10:51:09 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AB2B1A80706; Wed, 14 Jun 2017 10:51:09 +0200 (CEST)
Date: Wed, 14 Jun 2017 08:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Feature test macros overhaul: Cygwin signal.h
Message-ID: <20170614085109.GA14171@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170613200108.10620-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20170613200108.10620-1-yselkowi@redhat.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00052.txt.bz2


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 447

On Jun 13 15:01, Yaakov Selkowitz wrote:
> This should match newlib's <sys/signal.h>.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/cygwin/signal.h | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

ACK


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQPj9AAoJEPU2Bp2uRE+g43oP/3ysmjnqQQUJG+Lj2itUpM1w
jogVQBf43N4XLHlKSASj3IFYQ1CAXzydOMn4c4jvfmRbmS/bwA465+He/ScNxXpO
wVMXvqURl8E2kLLgeWOZdTbbMLOpzSpamskNYG+Me4xPezQKjSIM1hzu+7W6dqQf
AEtRnffCcz+6CascoHIf//f3ZiqU7oLo4ZW6tjIuf961rgpS1cfKhYbm2JGNfOBb
WVnyoiiFTyY7JRYmDEZKBuMDHAtTtLmEU6mIJz63+N+HsXtokx43snwgA70lrl5F
MLxI20QYmjy91aiTAQQ303GSoRCldKwfCd1pw3qV2hPhV8+H1S42AdIbtYmcKFJY
3gmBDCLflOp6gOKNq5de1W/XcrC++gXWUDIq4Tfav1IHuXVj56Vqrpa1KkEbFCLA
CNmCfKtJkEw2oDt9UvKY/6TVo5C8730o5yxSPIdOJ9rH5HHupW3ubUEFIbznSSsd
GiQ213h4NBy9yfWpUIvdXTGfYy52pbYf92vLavXiTPtNNVk+Mx0od2hUVzzv+Bun
L4bDtnwxbNqiXZsmkGUZoRlO0khpdGj5jMEgk8Ihq4ZV0iYeF0YsWzCoJd5hP08C
VlRDLSFhD/+eTqN9oOpEWjzFeFsfgznsJfTRvfiEwbFpFksJ5r4/f8Z9Fn0DojOn
73H9Z+3poF51LMi7CpYX
=tFIT
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
