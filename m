Return-Path: <cygwin-patches-return-8812-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111723 invoked by alias); 2 Aug 2017 08:09:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111701 invoked by uid 89); 2 Aug 2017 08:09:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=para, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 02 Aug 2017 08:09:23 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 355D671E3F90A	for <cygwin-patches@cygwin.com>; Wed,  2 Aug 2017 10:09:19 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 2FF275E01D9	for <cygwin-patches@cygwin.com>; Wed,  2 Aug 2017 10:09:18 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 131CEA8079A; Wed,  2 Aug 2017 10:09:18 +0200 (CEST)
Date: Sun, 06 Aug 2017 21:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: Export explicit_bzero
Message-ID: <20170802080918.GF25551@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170802061128.5208-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20170802061128.5208-1-yselkowi@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00014.txt.bz2


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2129

On Aug  2 01:11, Yaakov Selkowitz wrote:
> This was added to newlib together with timingsafe_*cmp but never exported.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/common.din               | 1 +
>  winsup/cygwin/include/cygwin/version.h | 3 ++-
>  winsup/doc/posix.xml                   | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
> index 08baa9e07..73e676841 100644
> --- a/winsup/cygwin/common.din
> +++ b/winsup/cygwin/common.din
> @@ -433,6 +433,7 @@ exp2f NOSIGFE
>  exp2l NOSIGFE
>  expf NOSIGFE
>  expl NOSIGFE
> +explicit_bzero NOSIGFE
>  expm1 NOSIGFE
>  expm1f NOSIGFE
>  expm1l NOSIGFE
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/inclu=
de/cygwin/version.h
> index bbb632626..ce548b13a 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -478,12 +478,13 @@ details. */
>    311: Export __xpg_sigpause.
>    312: Export strverscmp, versionsort.
>    313: Export fls, flsl, flsll.
> +  314: Export explicit_bzero.
>=20=20
>    Note that we forgot to bump the api for ualarm, strtoll, strtoull,
>    sigaltstack, sethostname. */
>=20=20
>  #define CYGWIN_VERSION_API_MAJOR 0
> -#define CYGWIN_VERSION_API_MINOR 313
> +#define CYGWIN_VERSION_API_MINOR 314
>=20=20
>  /* There is also a compatibity version number associated with the shared=
 memory
>     regions.  It is incremented when incompatible changes are made to the=
 shared
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index bc506434f..5ce5988bc 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -1139,6 +1139,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
>      endusershell
>      err
>      errx
> +    explicit_bzero
>      feof_unlocked
>      ferror_unlocked
>      fflush_unlocked
> --=20
> 2.13.2

Yep, please push (and update release info).


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZgYitAAoJEPU2Bp2uRE+gZNEP/2r5SjkvtX5Ov2dEFUkyEjtu
mR1LLdKRwjfLXmSiXjEi0GRXJQ22An2KxOpjpQ6vD5KUpOFfRUAPLeeqt6j3ADBm
H44WfjvE9F1xEHkRossDlNwan6YXv+DFFXt5Tf0S9kO7i7oQGvq4lKjIX9gkOkHS
gNqOpftSqjvMlWV1L8Titlg0ZcpohBugrQxmPetz5oTohAcnQqhbHr57nDhrAYrk
zbCsYkIBD7YatjUGLP3/2Ts44kMqXH4g1b7vMS70hIeijkUkc7+lgxVd7+o9dPV4
29ZamJ+s8xvjtL7BAcsZ8h3Ev+WbzgVJmTD3XTg3TvV/2m2UpafPTm5OiaBeynAH
3Co26zmkiLfpRaHzRHLAEs2nQWjW/eqImUz05I+hJBNASEoK9wso5Uzcg26ZMkR4
UVz6BBK9oBnk0dNNQqgp+h8mSNtySFRPNZxzstkv/pkoV9bWNt3kZDMbpQDvMa+m
OIKKlQVt/F2ut97WsMylov/aebmkPhhSD7XqeeE6U2Df7il8xoe1gaE6KPifH3Qn
6ABmW43AOZfyuxYswBjgLJ/+zgu7F1KZBSf5VRC7c3qjigqGNclg/Tp88AdCfD6F
ZsDy64KEAAZSYskpemnU+oYpskJIDIShdt/3grfLtLvSVbLz9UJlYEgVL6cIG/v3
5Mie1yEFiGVI9fS6KEu5
=S5yQ
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
