Return-Path: <cygwin-patches-return-9080-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77067 invoked by alias); 5 Jun 2018 09:59:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76995 invoked by uid 89); 5 Jun 2018 09:59:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jun 2018 09:59:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LjJmB-1g0Hii3RXz-00dXwt for <cygwin-patches@cygwin.com>; Tue, 05 Jun 2018 11:59:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4DAA2A8195B; Tue,  5 Jun 2018 11:59:51 +0200 (CEST)
Date: Tue, 05 Jun 2018 09:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Cygwin: Document clearenv
Message-ID: <20180605095951.GE17401@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180604193607.17088-1-kbrown@cornell.edu> <20180604193607.17088-6-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <20180604193607.17088-6-kbrown@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q2/txt/msg00037.txt.bz2


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1652

On Jun  4 15:36, Ken Brown wrote:
> ---
>  winsup/cygwin/include/cygwin/version.h | 3 ++-
>  winsup/cygwin/release/2.10.1           | 1 +
>  winsup/doc/posix.xml                   | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/inclu=
de/cygwin/version.h
> index f08707eea..2991ab858 100644
> --- a/winsup/cygwin/include/cygwin/version.h
> +++ b/winsup/cygwin/include/cygwin/version.h
> @@ -494,12 +494,13 @@ details. */
>    323: scanf %l[ conversion.
>    324: Export sigtimedwait.
>    325: Export catclose, catgets, catopen.
> +  326: Export clearenv

While you're at it, please bump the Cygwin version to 2.11.  I intended
to do that for every version adding such changes (but screwed up once or
twice already).

>    Note that we forgot to bump the api for ualarm, strtoll, strtoull,
>    sigaltstack, sethostname. */
>=20=20
>  #define CYGWIN_VERSION_API_MAJOR 0
> -#define CYGWIN_VERSION_API_MINOR 325
> +#define CYGWIN_VERSION_API_MINOR 326
>=20=20
>  /* There is also a compatibity version number associated with the shared=
 memory
>     regions.  It is incremented when incompatible changes are made to the=
 shared
> diff --git a/winsup/cygwin/release/2.10.1 b/winsup/cygwin/release/2.10.1
> index 42d9d1110..ef7d08256 100644
> --- a/winsup/cygwin/release/2.10.1
> +++ b/winsup/cygwin/release/2.10.1

git mv 2.10.1 2.11

And a matching entry in winsup/doc/new-features.xml would be nice :}


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsWXxcACgkQ9TYGna5E
T6AcKhAAmZhh4dLBZnSeHGMd1v/quMaXlL9Io19TCKcmZH+TQ0k2CQX0Y4G+Oj75
NyvLvUIdc4fOOEtxmLNN2TKv2c/1o4mF5M7fePQOwiJNTZyZwwDmE1sHzTdnVG+G
/gPXKLQ0AdYOVuHvri6HkFCg4S4UyNDOqcGLsnYMfEe1uti2jvOp6p95zgvwvYwO
Qq/SySA3k4yp+F7ioqYyh6Wp84XHyhQcq7F0E8cDio8d3RJeoEz58jnJDenfPYRU
az8QUxh6orDdM6YPexJDQA0xYagIL+/cYPzmS74nnPNW2jdOIs6HnfwmSBMsiXH8
zjZ32w5Nj39ygbFPK1lBevZrFuJhfXp3oYmpMBR4thSnXCqL1U3z2tVKVDVBifLL
U0+Uh8RC9xPJDv3EK2MBs2YGgPCZLe1fA369MXyKvDzRip99Ga74cEfGKntcakRz
iF74WrthcDgePr06N/RZU4cddtVQ74+uQkaZYomhgIr1BCP96HTaqKQnlhIcF+fY
qZPXIi8h7Im2bwJhAc6G/vJRul0kVdzEbKaE1uGYdIyAP6+SMqa+sGHGajhbLMnT
6ENNPfV/mViyA/RGXE3RHmOud+kkyy7z3DDmeqo0jaNLZpe+/yXZf2oIHOewmaIk
pIwgMVG73g+8UyKskf5Ikh5HaA8UpBxY9lCV9Myv4bzqA3irbcw=
=YiGi
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
