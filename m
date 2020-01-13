Return-Path: <cygwin-patches-return-9915-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25048 invoked by alias); 13 Jan 2020 16:11:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25030 invoked by uid 89); 13 Jan 2020 16:11:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Special
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:11:22 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M42fG-1ir2JD2yH2-00069q for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:11:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F2F14A806B2; Mon, 13 Jan 2020 17:11:18 +0100 (CET)
Date: Mon, 13 Jan 2020 16:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Disable xterm mode for non cygwin process only.
Message-ID: <20200113161118.GM5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200101065128.8897-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Content-Disposition: inline
In-Reply-To: <20200101065128.8897-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00021.txt


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1062

Hi Takashi,

On Jan  1 15:51, Takashi Yano wrote:
> - Special function keys such as arrow keys or function keys do not
>   work in ConEmu with cygwin-connector after commit
>   6a06c6bc8f8492ea09aa3ae180fe94e4ac265611. This patch fixes the
>   issue.
> ---
> [...]
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index cea79e326..efd82c3c2 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -29,6 +29,14 @@ details. */
>  #include "winf.h"
>  #include "ntdll.h"
>=20=20
> +/* Not yet defined in Mingw-w64 */
> +#ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
> +#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
> +#endif /* ENABLE_VIRTUAL_TERMINAL_PROCESSING */
> +#ifndef ENABLE_VIRTUAL_TERMINAL_INPUT
> +#define ENABLE_VIRTUAL_TERMINAL_INPUT 0x0200
> +#endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */
> +

I think it's about time to move these definitions into a header, rather
than defining them in three different places.  winlean.h might be the
right place for them.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4clqYACgkQ9TYGna5E
T6Cr6Q/+IiB22s0i0uVebwSNxEcd9MVk5FCwGWFt2luSF2zF//8t5YPXozyrHiLN
IigjLwKsF50jvyjbUtZIiAeCshK7qVuH8R9kz+UXhBaBziq0ps7zlaW91MYbo5Xb
PdjPiMxHNlR+DWJZkXYGeK8kQQNUWcmrWafg8tOBDjhESkAfshOMkds9bnS7Hu4S
6EIn1YpmOJnxwS96EzecfzywuCraaEGTR4P/Lu1Ko3CHbA4uDHYNbc2tpMkTtD0q
u1THPr1VXNJrBk8iOiatsLT7mLpPw/oZYQ5bSlAlmSun1Gu8D/kL6iP6vuvKRhFU
I6q01rR9UILkj8HysK8scpHWS1I27/yO0NX1rqZPIpxmuplDgtjiCeQLmqnyTwgA
w2dsG40m2pLQ+V3+oydOF7QYVhNONJFJwpv/H2BNUbaRf96lhWDV5FLptq0SbMNU
lqx/z/f3j4mynYNMwx1BKuVicd2dxgC5aNaq3aeuh+ANOZd7mI0qHHrFpc9+Wq+n
RT8bYnhvBqvsezTWF60ZUCkf8ihNu8dEq+dio/QsETzsO5/JzhlRYnRLJLZQkP9X
K1gYTlCJc2zX0g8gNVXOivsLcLQmiA/DwYX1/D1YoMo25xyKMChB8OzjWqFVZHRY
wgscqePqc5397yVzaLve3US9VPseQjeoon+v667SzqeyclTYG4g=
=eWWd
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--
