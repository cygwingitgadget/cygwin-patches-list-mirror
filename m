Return-Path: <cygwin-patches-return-8291-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26535 invoked by alias); 17 Dec 2015 20:20:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26469 invoked by uid 89); 17 Dec 2015 20:20:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-103.3 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=Win32, win32, HX-HELO:sk:calimer, H*r:188.192.47
X-HELO: calimero.vinschen.de
Received: from ipbcc02fe8.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.47.232) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Dec 2015 20:20:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D63ACA8062D; Thu, 17 Dec 2015 21:20:23 +0100 (CET)
Date: Thu, 17 Dec 2015 20:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory via the HOME variable
Message-ID: <20151217202023.GA3507@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de> <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="v+Mbu5iuT/5Blw/K"
Content-Disposition: inline
In-Reply-To: <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00044.txt.bz2


--v+Mbu5iuT/5Blw/K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3856

Hi Johannes,

a few comments...

On Dec 17 19:05, Johannes Schindelin wrote:
> [...]
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index c9b3e09..a5d6270 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> [...]
> +static size_t
> +fetch_env(LPCWSTR key, char *buf, size_t size)
           ^^^
           space

> +{
> +  WCHAR wbuf[32767];

Ok, there are a couple of problems here.  First, since this buffer
is a filename buffer, use NT_MAX_PATH from winsup.h as buffer size.

But then again, please avoid allocating 64K buffers on the stack.
That's what tmp_pathbuf:w_get () is for.

> +  DWORD max =3D sizeof wbuf / sizeof *wbuf;
> +  DWORD len =3D GetEnvironmentVariableW (key, wbuf, max);

This call to GetEnvironmentVariableW looks gratuitous to me.  Why don't
you simply call getenv?  It did the entire job already, it avoids the
requirement for a local buffer, and in case of $HOME it even did the
Win32->POSIX path conversion.  If there's a really good reason for using
GetEnvironmentVariableW it begs at least for a longish comment.

> +
> +  if (!len || len >=3D max)
> +    return 0;
> +
> +  len =3D sys_wcstombs (buf, size, wbuf, len);
> +  return len && len < size ? len : 0;
> +}
> +
> +static char *
> +fetch_home_env (void)
> +{
> +  char home[32767];
> +  size_t max =3D sizeof home / sizeof *home, len;
> +
> +  if (fetch_env (L"HOME", home, max)
> +      || ((len =3D fetch_env (L"HOMEDRIVE", home, max))
> +        && fetch_env (L"HOMEPATH", home + len, max - len))
> +      || fetch_env (L"USERPROFILE", home, max))
> +    {
> +      tmp_pathbuf tp;
> +      cygwin_conv_path (CCP_WIN_A_TO_POSIX | CCP_ABSOLUTE,
> +	  home, tp.c_get(), NT_MAX_PATH);
                       ^^^
                       space
> +      return strdup(tp.c_get());
                     ^^^      ^^^
                     space......s

Whoa, tp.c_get() twice to access the same space?  That's a dirty trick
which may puzzle later readers of the code and heavily depends on
knowing the internals of tmp_pathbuf.  Please use a variable and only
assign tp.c_get () once.

OTOH, the above's a case for a cygwin_create_path call, rather than
cygwin_conv_path+strdup.  Also, if there's *really* a good reason to use
GetEnvironmentVariableW, you should collapse sys_wcstombs+cygwin_conv_path+
strdup into a single cygwin_create_path (CCP_WIN_W_TO_POSIX, ...).

> [...]
> @@ -1079,6 +1123,7 @@ cygheap_pwdgrp::get_shell (cyg_ldap *pldap, cygpsid=
 &sid, PCWSTR dom,
>  	case NSS_SCHEME_FALLBACK:
>  	  return NULL;
>  	case NSS_SCHEME_WINDOWS:
> +	case NSS_SCHEME_ENV:
>  	  break;
>  	case NSS_SCHEME_CYGWIN:
>  	  if (pldap->fetch_ad_account (sid, false, dnsdomain))

You know that I don't exactly like the "env" idea, but if we implement
it anyway, wouldn't it make sense to add some kind of $SHELL handling as
well, for symmetry?

> [...]
> @@ -1487,6 +1497,16 @@ of each schema when used with <literal>db_home:</l=
iteral>
>  	      for a detailed description.</listitem>
>    </varlistentry>
>    <varlistentry>
> +    <term><literal>env</literal></term>
> +    <listitem>Derives the home directory of the current user from the
> +	      environment variable <literal>HOME</literal> (falling back to
> +	      <literal>HOMEDRIVE\HOMEPATH</literal> and
> +	      <literal>USERPROFILE</literal>, in that order).  This is faster
> +	      than the <term><literal>windows</literal></term> schema at the
> +	      expense of determining only the current user's home directory
> +	      correctly.</listitem>

In both case of the documentation it might make sense to add a few words
along the lines of "This schema is skipped for any other account",
wouldn't it?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--v+Mbu5iuT/5Blw/K
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcxkHAAoJEPU2Bp2uRE+gZaQP+gOC0OSaZw/nnSrXcToc5zB9
wLl/JOTmXCBgB8iLHLi37zHHf0vzDUUaWAy1A2jQbGf5/D9DMwaSMaUZ4f/hRPIW
Eh/sgxzixPhW0bxQ2UY01nToVMiVc1OY6SMHl8OIJBmYoJ2qOjRATF0LiO3xvaeK
5RskMgKQ+3fDwL1ojTBT/Rz9Lgu7kd1j5+eh+Pjv7UZQOY0a3FGPnLaHcYxrOAKw
1cdRQ5+9ys47+CimZBq4B1aqz7dUbUCmG/QOvfvSKNOffYd4dje+Qw5KuRuptjfh
6zPo8gyek3/I5aqS+9Bq74GNJJ2vMcr9xqFIP68psSMtQ7jGNRbwjXdHh5crb2yR
wRiv9nHI5Kdj35tv9XQUf3SKQFhBL7tGoize7qyR4b08CJhBDcXApWsZIjXz8bPt
1n8IQJTZppPN/O55rEYnKT+vQD6tJuxkn4mXY4sm/dg4zSBmLC8bQfB7a1Oc+6j9
prSnG37y4hjBwj462iusOQ3LgVnPKCqTSaPRX2FzMvTLCi3W5ztUs+9xyvJ3yiCv
E/5eQdgYY4t+rZ8uYXoRGiZbN4h5RuTtAFJdgunZ1PB2ddTb1HwKQVISuhn5R4QK
/I2l+GRa9t8GwyTs2adXC05jKVtWg3MTfCTp4RjIuEeYU8/0IZKggTNjHyYpamCq
38takwhuELXprZXdVLaI
=xqvJ
-----END PGP SIGNATURE-----

--v+Mbu5iuT/5Blw/K--
