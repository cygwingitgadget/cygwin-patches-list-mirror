Return-Path: <cygwin-patches-return-9317-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74537 invoked by alias); 10 Apr 2019 09:02:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71417 invoked by uid 89); 10 Apr 2019 09:02:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-126.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Envelope-From:sk:corinna, H*r:500, H*R:U*cygwin-patches, H*F:U*corinna-cygwin
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Apr 2019 09:02:41 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MxUfn-1gyOWt1L2H-00xvyx for <cygwin-patches@cygwin.com>; Wed, 10 Apr 2019 11:02:38 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 983D2A806B0; Wed, 10 Apr 2019 11:02:37 +0200 (CEST)
Date: Wed, 10 Apr 2019 09:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [rebase PATCH] Introduce --with-posix-shell configure flag.
Message-ID: <20190410090237.GF4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <65e46d68-33be-bfea-dfd2-756812ac3472@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <65e46d68-33be-bfea-dfd2-756812ac3472@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00024.txt.bz2


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3201

On Apr  9 11:23, Michael Haubenwallner wrote:
> Some distros prefer a POSIX shell other than /bin/ash and /bin/dash.

I think this is pretty old stuff nobody really looked at for a while.
ash and dash are the same binary anyway, both are dash.

I'd prefer to drop the distinction between ash and dash, so dash
is default and --with-dash becomes a no-op.

Also, why not just SHELL?


Thanks,
Corinna


> ---
>  Makefile.in   |  4 ++--
>  configure.ac  | 22 +++++++++++++++++-----
>  peflagsall.in |  2 +-
>  rebaseall.in  |  2 +-
>  4 files changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/Makefile.in b/Makefile.in
> index e984070..34c4684 100644
> --- a/Makefile.in
> +++ b/Makefile.in
> @@ -53,7 +53,7 @@ LN_S =3D @LN_S@
>  SED =3D @SED@
>  EGREP =3D @EGREP@
>  FGREP =3D @FGREP@
> -ASH =3D @ASH@
> +POSIXSHELL =3D @POSIXSHELL@
>=20=20
>  DEFAULT_INCLUDES =3D -I. -I$(srcdir) -I$(srcdir)/imagehelper
>  DEFS =3D @DEFS@ -DVERSION=3D'"$(PACKAGE_VERSION)"' -DLIB_VERSION=3D'"$(L=
IB_VERSION)"' -DSYSCONFDIR=3D'"$(sysconfdir)"'
> @@ -128,7 +128,7 @@ edit =3D sed \
>  	-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
>  	-e 's|@prefix[@]|$(prefix)|g' \
>  	-e 's|@exec_prefix[@]|$(exec_prefix)|g' \
> -	-e 's|@ASH[@]|$(ASH)|g' \
> +	-e 's|@POSIXSHELL[@]|$(POSIXSHELL)|g' \
>  	-e 's|@DEFAULT_OFFSET_VALUE[@]|$(DEFAULT_OFFSET_VALUE)|g'
>=20=20
>  rebaseall peflagsall: Makefile
> diff --git a/configure.ac b/configure.ac
> index 1dc9bf4..2b42e47 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -8,11 +8,23 @@ AC_CONFIG_SRCDIR([peflags.c])
>  AC_PREFIX_DEFAULT([/usr])
>  AC_CANONICAL_HOST
>=20=20
> -AC_ARG_WITH([dash], AS_HELP_STRING([use dash instead of ash]),
> -            [], [with_dash=3Dno])
> -ASH=3Dash
> -AS_IF([test "x$with_dash" !=3D xno], [ASH=3Ddash])
> -AC_SUBST([ASH])
> +AC_MSG_CHECKING([for POSIX shell to use in scripts])
> +AC_ARG_WITH([dash],
> +			AS_HELP_STRING([--with-dash],
> +						   [use /bin/dash instead of /bin/ash (deprecated in favor of --wi=
th-posix-shell=3D/bin/dash)]),
> +            [with_posix_shell=3D/bin/dash])
> +AC_ARG_WITH([posix-shell],
> +			AS_HELP_STRING([--with-posix-shell=3D/bin/dash],
> +						   [POSIX shell to use for scripts, default=3D/bin/ash]),
> +			[AS_CASE([$with_posix_shell],
> +					 [yes|no|''],
> +					 [AC_MSG_ERROR([Need shell path for --with-posix-shell, got '$with_=
posix_shell'.])],
> +					 [/*],
> +					 [POSIXSHELL=3D$with_posix_shell],
> +					 [AC_MSG_ERROR([Need absolute path for --with-posix-shell, got '$wi=
th_posix_shell'.])])],
> +			[POSIXSHELL=3D/bin/ash])
> +AC_SUBST([POSIXSHELL])
> +AC_MSG_RESULT([$POSIXSHELL])
>=20=20
>  AC_PROG_INSTALL
>  AC_PROG_MKDIR_P
> diff --git a/peflagsall.in b/peflagsall.in
> index d838201..6839db4 100644
> --- a/peflagsall.in
> +++ b/peflagsall.in
> @@ -1,4 +1,4 @@
> -#!/bin/@ASH@
> +#!@POSIXSHELL@
>=20=20
>  #
>  # Copyright (c) 2009,2011 Charles Wilson
> diff --git a/rebaseall.in b/rebaseall.in
> index 076cc32..af4fe3f 100644
> --- a/rebaseall.in
> +++ b/rebaseall.in
> @@ -1,4 +1,4 @@
> -#!/bin/@ASH@
> +#!@POSIXSHELL@
>=20=20
>  #
>  # Copyright (c) 2003, 2005, 2006, 2008, 2011, 2012 Jason Tishler
> --=20
> 2.19.2

--=20
Corinna Vinschen
Cygwin Maintainer

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlytsS0ACgkQ9TYGna5E
T6BKvg//TjDcqSCfeEm/ko6cdchocQAhFErVlgluasYo4S4TLmSH2R2sytiJ5gRA
TGeUlxTj/QiHGLMGiJOJlTP4xzqicB3tXvcIvLoHvZS6c9He82EPd+0xS0Cd3gCh
biCwC21/2JILz6m4nTEKZDeQ5V7/Nwup1XbajjT6PaUixQs8nalKNR8kAkordBU0
EQ673RNBSlWXOKiTdqa0bb1S1o+9YviS6gHOJgdtYcSGYoqyZKid9pYj9onnc397
ZZ/NRMGx8+YLFrsG3FirA/c2PptJSyxN4HzM15FvKQggzg9bylPPBuej4T45XXtI
RNMVwSgoW+/MHuS5XUDDcRkDef+nyCZLdgLJd1/iqEuE9QmZFsScySIkQtgDUh0N
54fIQf1xiOaykflJZKz9q6AXhbomU7RFJ1XZv13bmrbinYr4i9HI72ZAE/CfVT87
Q0RaPaaPK5ItwEtJ+yK19+wKYYxh//J7eopOwXwMpzOXOKmr11U22zeAASrXScIl
g2cWf9G3WGkveKwAFZ1iJrJVWl+0xnA5LPgcnv+N8h0pMe+pqVpztY+uUHOJqcsP
lQDONmXDvCO/LLSdXQvEEGOBCcBFTykG4zWdW6R4pX2LIAZZ9oSUzJiPQ4/TCBzS
6GuCW6rSkc22LppPGncrJVdiHeZ8hKOkXjC/HmYabS26yKSJClo=
=/5bE
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
