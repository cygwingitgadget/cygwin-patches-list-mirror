Return-Path: <cygwin-patches-return-8995-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39067 invoked by alias); 16 Jan 2018 09:32:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37935 invoked by uid 89); 16 Jan 2018 09:30:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jan 2018 09:30:12 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id CD8A272106C16	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 10:30:04 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 880145E00DF	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 10:30:04 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 72361A807E5; Tue, 16 Jan 2018 10:30:04 +0100 (CET)
Date: Tue, 16 Jan 2018 09:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: make sys/socket.h completely visible from netinet/in.h
Message-ID: <20180116093004.GC3009@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180116032447.14572-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
In-Reply-To: <20180116032447.14572-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00003.txt.bz2


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1545

On Jan 15 21:24, Yaakov Selkowitz wrote:
> While POSIX mandates that certain socket types shall be defined by the
> inclusing of <netinet/in.h>, it also says that this header may also make
> visible all <sys/socket.h> symbols.  Glibc does this, and without out it,
> some packages end up requiring an additional #include <sys/socket.h>.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/cygwin/in.h  | 2 +-
>  winsup/cygwin/include/sys/socket.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/include/cygwin/in.h b/winsup/cygwin/include/cy=
gwin/in.h
> index 9d7331d30..42b776653 100644
> --- a/winsup/cygwin/include/cygwin/in.h
> +++ b/winsup/cygwin/include/cygwin/in.h
> @@ -18,7 +18,7 @@
>  #ifndef _CYGWIN_IN_H
>  #define _CYGWIN_IN_H
>=20=20
> -#include <cygwin/socket.h>
> +#include <sys/socket.h>
>=20=20
>  #ifndef _IN_ADDR_T_DECLARED
>  typedef	__uint32_t	in_addr_t;
> diff --git a/winsup/cygwin/include/sys/socket.h b/winsup/cygwin/include/s=
ys/socket.h
> index 9e897a9ff..e6b92eef8 100644
> --- a/winsup/cygwin/include/sys/socket.h
> +++ b/winsup/cygwin/include/sys/socket.h
> @@ -11,7 +11,6 @@ details. */
>=20=20
>  #include <features.h>
>  #include <cygwin/socket.h>
> -#include <sys/time.h>

You don't explain the incentive behind removing sys/time.h.  Sure this
doesn't break anything?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlpdxhwACgkQ9TYGna5E
T6Bv7Q//SaWjhc162BH5oH0GlKY/uYTg0zYLBoVDvDLyvZ1rydcpu3QEfEYBaFm+
vDTdFjG25sYLA+P1zQPj1EvBulhbjrXQnaYr0R2+5QEaBLL1yZdw12bQYar1JTWW
SHyoKiZzEOL2BJHr1TbsL4XKw5WlGyGiGEEm3a4T1W6f3fOxeD5+CAqZbgx8BRBe
WBfd8ElExkqET89rV9GuI8czrVo4+FaCkpoq3/2Qit7pPqS34dHu8VxDSf/2FavW
1y3+uLPhFAwAGe30hHUy3loIZ+J2ZOtZgCoqRlJPrjrpj+7yjnzgLNi/X7ILFo2P
5dSC5D4ERvKhm7wvKhkvhnhuZ9nluEHzq9nbhUUhPfRk7sTqBHtGfXNX24X5Ed/u
8I2b+3+qL72cG35jtA0wugkbOA0n60aZvKbGSfSTZiHT39lFXAdimoI2sQomqfOz
r8rV5BkfIP7PQX9UexZuAfysSjeC+Kb3MCLFQeOVnZsACw0czJttWB6/PcXcRtV1
Lyr5yWvScMFwkCIcuyaaA8gwVnPsGHwjfM2cDz24Q+pw1l8XltEuMshzocVcQ56d
/g9auZdLiong7mx6irYHacSSg0iNM92u6lu0MTAZYO3KuMtFxzHQJyHuWpgHeZAo
J9tPvEW2mrtmBSvTfT8tzk9STiIhdjcj9Lgmj/nEAX/ZmUB8Mkc=
=tohj
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
