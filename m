Return-Path: <cygwin-patches-return-8950-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63624 invoked by alias); 30 Nov 2017 09:27:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63614 invoked by uid 89); 30 Nov 2017 09:27:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=para
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 30 Nov 2017 09:27:27 +0000
Received: from aqua.hirmke.de (business-24-134-7-25.pool2.vodafone-ip.de [24.134.7.25])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 6217171A3A991	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 10:27:24 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 1908D5E03CA	for <cygwin-patches@cygwin.com>; Thu, 30 Nov 2017 10:27:21 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7C7E7A8074C; Thu, 30 Nov 2017 10:27:23 +0100 (CET)
Date: Thu, 30 Nov 2017 09:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: export wmempcpy
Message-ID: <20171130092723.GI547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171130014829.19408-1-yselkowi@redhat.com> <20171130014857.4668-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="i/CQJCAqWP/GQJtX"
Content-Disposition: inline
In-Reply-To: <20171130014857.4668-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00080.txt.bz2


--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2248

On Nov 29 19:48, Yaakov Selkowitz wrote:
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
> Obviously this depends on the newlib implementation patch.
>=20
>  winsup/cygwin/common.din               | 1 +
>  winsup/cygwin/include/cygwin/version.h | 3 ++-
>  winsup/doc/posix.xml                   | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
> index a482cf2b7..14b9c2c18 100644
> --- a/winsup/cygwin/common.din
> +++ b/winsup/cygwin/common.din
> @@ -1609,6 +1609,7 @@ wmemchr NOSIGFE
>  wmemcmp NOSIGFE
>  wmemcpy NOSIGFE
>  wmemmove NOSIGFE
> +wmempcpy NOSIGFE
>  wmemset NOSIGFE
>  wordexp NOSIGFE
>  wordfree NOSIGFE
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/inclu=
de/cygwin/version.h
> index d8bb3ee44..7510f42b0 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -489,12 +489,13 @@ details. */
>         __stack_chk_fail, __stack_chk_guard, __stpcpy_chk, __stpncpy_chk,
>         __strcat_chk, __strcpy_chk, __strncat_chk, __strncpy_chk,
>         __vsnprintf_chk, __vsprintf_chk.
> +  321: Export wmempcpy.
>=20=20
>    Note that we forgot to bump the api for ualarm, strtoll, strtoull,
>    sigaltstack, sethostname. */
>=20=20
>  #define CYGWIN_VERSION_API_MAJOR 0
> -#define CYGWIN_VERSION_API_MINOR 320
> +#define CYGWIN_VERSION_API_MINOR 321
>=20=20
>  /* There is also a compatibity version number associated with the shared=
 memory
>     regions.  It is incremented when incompatible changes are made to the=
 shared
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index c99e003ba..ab574300f 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -1396,6 +1396,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
>      wcstoll_l
>      wcstoul_l
>      wcstoull_l
> +    wmempcpy
>  </screen>
>=20=20
>  </sect1>
> --=20
> 2.15.0

Basically ok, but shouldn't we use the assembler implementation of
memcpy/wmemcpy in miscfuncs.cc for x86_64 mempcpy/wmempcpy as well?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--i/CQJCAqWP/GQJtX
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaH877AAoJEPU2Bp2uRE+gIV8P/Rx1kf4OVTEngtehQ3iWE1M+
jhUui6UiCMGq0sKAEGW1KmRjzEjC+3g15aCVn377QPwtoERHP2es2miu2ZmDhmuC
TayrU6jeGaMgzosyscLvT4xMDg5HmdE5HlJdUfpb6ilwxTIRbDyBilMQkYQUBPeG
SMdeb18h5EYSax0eSF26DiTi+NeiAOOnq5aO5DiqkwZBDU4ZXvu1BYh8hDdcZhun
zotlnpxP0d1F18zW806DhVo/cJ2madMuq+cWP6XoXckltblp/8rJsAjeQQc+OQSS
6q0IBEWc0MIBkjINRqhxwIdCEy2hPy+kt9Wh7tGdfyqxtPt6lUo3gBwtnZyD3Org
1zYs1InefGFkWzquc6KzK8ocmRrdDH2JEx5fUugg4ru8o1wz8lemnZg50W+Ow9lw
GnF234OKJXefztM5bjaNOx25QxZ1f14RAD028Nt/tXWQKqblHLwQo0zZRO3XqWRx
tpNCcFEsLXQBqXugA/dAaz9M6p9pUkkd/bT/IeUyn5iAQFJlvM9vHrQsjm4mqOy1
HafCEEdx33MxHJ9g3t/bXuB9863aPdvS4jzahGtrNeTQc4jay7QgZ8Uk8danBlwU
/6edM98hPg3jME0w07e1MDsxB0X8qjENyhfEaPrU9Z8MOdMfiqCAYncRCfHlka8B
Aax9/rE6VzzsKLEiW1io
=uOrJ
-----END PGP SIGNATURE-----

--i/CQJCAqWP/GQJtX--
