Return-Path: <cygwin-patches-return-8664-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124012 invoked by alias); 9 Jan 2017 14:48:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102082 invoked by uid 89); 9 Jan 2017 14:48:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:2364, claims, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Jan 2017 14:48:04 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id C6A30721E280D	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2017 15:48:01 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 2802A5E0210	for <cygwin-patches@cygwin.com>; Mon,  9 Jan 2017 15:48:01 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 09A43A8041E; Mon,  9 Jan 2017 15:48:01 +0100 (CET)
Date: Mon, 09 Jan 2017 14:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Move the core environment parsing of environ_init into a new win32env_to_cygenv function.
Message-ID: <20170109144800.GB13527@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170105173929.65728-1-erik.m.bray@gmail.com> <20170105173929.65728-2-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20170105173929.65728-2-erik.m.bray@gmail.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00005.txt.bz2


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2672

On Jan  5 18:39, Erik M. Bray wrote:
> @@ -805,32 +796,8 @@ environ_init (char **envp, int envc)
>  	}
>        debug_printf ("GetEnvironmentStrings returned %p", rawenv);
>=20=20
> -      /* Current directory information is recorded as variables of the
> -	 form "=3DX:=3DX:\foo\bar; these must be changed into something legal
> -	 (we could just ignore them but maybe an application will
> -	 eventually want to use them).  */
> -      for (i =3D 0, w =3D rawenv; *w !=3D L'\0'; w =3D wcschr (w, L'\0')=
 + 1, i++)
> -	{
> -	  sys_wcstombs_alloc_no_path (&newp, HEAP_NOTHEAP, w);
> -	  if (i >=3D envc)
> -	    envp =3D (char **) realloc (envp, (4 + (envc +=3D 100)) * sizeof (c=
har *));
> -	  envp[i] =3D newp;
> -	  if (*newp =3D=3D '=3D')
> -	    *newp =3D '!';
> -	  char *eq =3D strchrnul (newp, '=3D');
> -	  ucenv (newp, eq);	/* uppercase env vars which need it */
> -	  if (*newp =3D=3D 'T' && strncmp (newp, "TERM=3D", 5) =3D=3D 0)
> -	    sawTERM =3D 1;
> -	  else if (*newp =3D=3D 'C' && strncmp (newp, "CYGWIN=3D", 7) =3D=3D 0)
> -	    parse_options (newp + 7);
> -	  if (*eq)
> -	    posify_maybe (envp + i, *++eq ? eq : --eq, tmpbuf);
> -	  debug_printf ("%p: %s", envp[i], envp[i]);
> -	}
> +	  lastenviron =3D envp =3D win32env_to_cygenv(rawenv, true);
                                                ^^^
                                                space missing

>=20=20
> -      if (!sawTERM)
> -	envp[i++] =3D strdup (cygterm);
> -      envp[i] =3D NULL;
>        FreeEnvironmentStringsW (rawenv);
>=20=20
>      out:
> @@ -852,6 +819,53 @@ environ_init (char **envp, int envc)
>    __endtry
>  }
>=20=20
> +
> +char **
      ^^^
      Header claims __stdcall, missing here.  But in fact it
      might be prudent to make this a __reg2 function instead.

> +win32env_to_cygenv(PWCHAR rawenv, bool posify)
                    ^^^
                    space missing

> +{

>  /* Function called by qsort to sort environment strings.  */
>  static int
>  env_sort (const void *a, const void *b)
> diff --git a/winsup/cygwin/environ.h b/winsup/cygwin/environ.h
> index 46beb2d..7bd87da 100644
> --- a/winsup/cygwin/environ.h
> +++ b/winsup/cygwin/environ.h
> @@ -45,4 +45,6 @@ extern "C" char __stdcall **cur_environ ();
>  char ** __reg3 build_env (const char * const *envp, PWCHAR &envblock,
>  			  int &envc, bool need_envblock, HANDLE new_token);
>=20=20
> +char __stdcall ** win32env_to_cygenv (PWCHAR rawenv, bool posify);
        ^^^^^      ^^^
        __reg2?    no space here


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

iQIcBAEBCAAGBQJYc6KgAAoJEPU2Bp2uRE+giqsP/3v0d5cSPNeTuJcXVZNORZn8
nxD/m1Qw+0aCyCbLOqjSuTspYQoS+VAb65brRxjg5ywI4VU4qpO0rA6xnFNp8hBn
LHBVgveJkjVK9jJPrtiRSIyc4iVbGvPmpAD2sOyxnCnApYrZQeHEbSPudwuuYkmf
AljRTWUms0vlcYabiiExjvtAAq+jo+9Ih7aX03vhusmqLZTFey8BtH0EHfL43C79
+zYm3M/sXUIJSMPiRlwrcc5PEI+AlDiOl99lBeEPmI/czS1p4uXNuMtTLrcAE4o6
/RAxnONgU3Wc93ZEneChZpwrPzzu3QlEsKCHdk2UdfCbdVn5vghuWRG8/rf5cWyc
l7gJQAYJLEd8kgviJS6Uq1PgM17SEe7A2qWZaR2O07js+ynARBqsDeW9Zuo9fTjW
CWQFYh+JNmr/SGVbKHOxSI7VxWRC+euRrru/nYlFTES8XegiJqAOP9GIwkYNvIyp
r8r+EGJIdZtxZTrM/IlwXasSmf6ybpMJjld5VkiMqY5tq9I1u055+jMcd5RclFce
zFLuZJMYIQbFzk2ozyOxTDcibUwfLDzEB2x8DDz6TTTMzpZpCQkUXZDcvtxCzOD9
i3XZewFCdJrPwGsmlkJcFrFzaLjv9UL0bwCG0+RvHC0YYCP7T+NGl0ewiuqcA/vU
G03RcULqzMB5HMOLr/VQ
=p3jO
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
