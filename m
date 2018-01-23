Return-Path: <cygwin-patches-return-9019-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12568 invoked by alias); 23 Jan 2018 10:56:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12555 invoked by uid 89); 23 Jan 2018 10:56:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jan 2018 10:56:20 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 90CA4721E280C	for <cygwin-patches@cygwin.com>; Tue, 23 Jan 2018 11:56:16 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id E422D5E0091	for <cygwin-patches@cygwin.com>; Tue, 23 Jan 2018 11:56:15 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D274CA81843; Tue, 23 Jan 2018 11:56:15 +0100 (CET)
Date: Tue, 23 Jan 2018 10:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Define internal function mythreadname()
Message-ID: <20180123105615.GX18814@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180123052112.6568-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6o78gXsyQHm68LY/"
Content-Disposition: inline
In-Reply-To: <20180123052112.6568-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00027.txt.bz2


--6o78gXsyQHm68LY/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1986

Hi Mark,

On Jan 22 21:21, Mark Geisert wrote:
>  This new function returns the name of the calling thread; works for both
>  cygthreads and pthreads. All calls to cygthread::name(/*void*/) replaced=
 by
>  calls to mythreadname(/*void*/).
> [...]
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index f3c709a15..71e17a77f 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -2682,6 +2682,23 @@ pthread_setname_np (pthread_t thread, const char *=
name)
>    return 0;
>  }
>=20=20
> +/* Returns running thread's name; works for both cygthreads and pthreads=
 */
> +extern "C" const char *

You can drop the extern "C", the function is used in C++ context only
anyway.

> +mythreadname (void)
> +{
> +  const char *result =3D cygthread::name ();
> +
> +  if (strstr (result, "unknown "))

This test is a bit wasteful.  What about checking result =3D=3D
_my_tls.locals.unknown_thread_name instead?

> +    {
> +      static char tname[THRNAMELEN];

Ouch.  This isn't thread safe.  Why don't you just use
_my_tls.locals.unknown_thread_name, just like cygthread::name()?

> +
> +      tname[0] =3D '\0';
> +      if (0 =3D=3D pthread_getname_np (pthread_self (), tname, sizeof (t=
name)))
> +        result =3D tname;
> +    }
> +
> +  return result;
> +}
>  #undef THRNAMELEN
>=20=20
>  /* provided for source level compatability.
> diff --git a/winsup/cygwin/thread.h b/winsup/cygwin/thread.h
> index 12a9ef26d..60277c601 100644
> --- a/winsup/cygwin/thread.h
> +++ b/winsup/cygwin/thread.h
> @@ -17,6 +17,9 @@ details. */
>  /* resource.cc */
>  extern size_t get_rlimit_stack (void);
>=20=20
> +/* thread.cc */
> +extern "C" const char *mythreadname (void);
   ^^^^^^^^^^
   as above.

> +
>  #include <pthread.h>
>  #include <limits.h>
>  #include "security.h"
> --=20
> 2.15.1

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--6o78gXsyQHm68LY/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlpnFM8ACgkQ9TYGna5E
T6DzlxAAnv+6aM38zoWlAL00RMyVBTybEo6pEJjgpW6ezuMceixEjNnpTEwh2LIj
zKWWf2rVpOGKD5rrxTl1+VsbL2Z52cweaZH/njP2jM6LpdF0h5nrgBAlrLyu3/RR
EXwyQD4Zdi1C2jUy6wc5Uq70mNVmmJ9nxVjmKnXRlMtUWND0euljKbfrZnd0499T
AYx+1l9GCP8XNKC9tNTr4xn3/sON/aqQ6TS99KiJsTSvhG35hubX/1XGes1tg/qC
m7Fe7ItkRBQFhXi+UmnozOFXesjKWlijIkVMoMnj0FWdVdzbTV/IH6hFDfoEZptQ
omnqZGDMP2MowPp926F5j5BtESRdpynGyYq/VxiLWtCewnao6QOowyzCFM7l2c+x
bBwz1vLrjccQJaobM8rhi1pkZPoSNamzb8b3HcWQr0N5l8uBL08p+8l3qu6IyhMU
rkwUYvEzY6/+FqStpiZ0rjm4rbqX+ep24FSQCAEUUUCO2TxjdqLxjo3rwlIq+0Qh
rrLZtqSdmzAYick3wSmKuCaCJmKV3f7sV/+8P7AgsoA8zQpgkovAvV1aeFyckWWd
IsEOI0+06iOQlo6P8Gzsu4whyUdzg8mGdREfyPceLDDZeLTn2ukFiPJ30qRwzF6P
NDXrmQu6T9Mb1oVE3ZriAzADtjPVJkelmbEGXgJFzQ1w0SwejJ4=
=N4uP
-----END PGP SIGNATURE-----

--6o78gXsyQHm68LY/--
